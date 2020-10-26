# -*- coding: utf-8 -*-
import os 
import sys
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import matplotlib as mpl
import seaborn as sns
from sklearn.preprocessing import Normalizer
from sklearn.preprocessing import StandardScaler
from sklearn.preprocessing import MinMaxScaler
from sklearn.model_selection import LeaveOneOut
from sklearn.model_selection import KFold
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import cross_val_predict
from sklearn.model_selection import train_test_split

from sklearn import model_selection
from sklearn.linear_model import LinearRegression
from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor

from sklearn.metrics import r2_score
from sklearn.metrics import mean_squared_log_error
from sklearn.metrics import mean_absolute_error
from sklearn.metrics import mean_squared_error

from sklearn.tree import DecisionTreeRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.ensemble import GradientBoostingRegressor
from xgboost import XGBRegressor
from sklearn.neighbors import KNeighborsRegressor
from sklearn.model_selection import GridSearchCV
from sklearn.neural_network import MLPRegressor
import warnings; warnings.simplefilter('ignore')

import statsmodels.api as sm
import operator
import timeit
import joblib
import statistics
import random
import logging
from pickle import dump
from sys import maxsize

import scipy.cluster.hierarchy as shc
from enum import Enum
from scipy.spatial.distance import pdist
from collections import defaultdict


'''
sudo -H pip3 install --upgrade pip
pip3 install sklearn pandas xgboost statsmodels matplotlib seaborn


This code assume you have two kind of dataset:
       - Dataset with NO target (all profile)
            This dataset we use for calculate correlation between pmcs
            For this first dataset we called df_pmcs
       - Dataset with target (based on for example median or average of each pmcs)
            This dataset we use to calculate the importance of each pmcs
            For this dataset we called df_pmcs_avg

You have some options to run this code:
    Which kind of feature selection: Filter, Filter + HCA and Wrapper
    Tunning: yes or no ?
All theses options you should pass as parameter:
    sys.argv[1] dataset full
    sys.argv[2] dataset avg
    sys.argv[3] Filter or Wrapper
    sys.argv[4] seed
    sys.argv[5] file output

'''

logging.basicConfig(filename="output",format='%(message)s', filemode='w', level=logging.INFO)

'''
Theses variables is more specific for each dataset and each problem that you are trying to fix.
'''
NUMBER_MAX_ITER = 15  #how many times are necessary to try to get better accuracy
MINIMUM_ACCURACY=0.5  #this is the minimum accuracy to avoid continue try more iterations
K_FOLD_N_SPLITS = int(sys.argv[5])
MAX_PMCS_TO_SELECT = 6 #this is the limite of our architecture
random.seed(sys.argv[4]) #this is for reproduce the same values

class Common: 
    '''
    This function is responsible for several smalls functionality
    '''
    #Will remove lines if exist outliers
    @staticmethod
    def remove_outlier(df_in, col_name):
        q1 = df_in[col_name].quantile(0.25)
        q3 = df_in[col_name].quantile(0.75)
        iqr = q3-q1 #Interquartile range
        fence_low  = q1-1.5*iqr
        fence_high = q3+1.5*iqr
        df_out = df_in.loc[(df_in[col_name] > fence_low) & (df_in[col_name] < fence_high)]
        return df_out
    #Will remove columns if exist low std by column
    @staticmethod
    def remove_low_std(file_path,threshold):
        df = pd.read_csv(file_path)
        columns_to_drop = list(df.loc[:, df.std() < threshold].columns)
        print("Num columns to remove:",columns_to_drop)
        if columns_to_drop.count('speedup4l') > 0 or columns_to_drop.count('speedup4b') > 0 or columns_to_drop.count('speedup4b4l') > 0 :
          print("target column will be removed. !!!!")
        if columns_to_drop.count('power') > 0:
          print("target column will be removed. !!!!")
        df = df.drop(columns_to_drop, axis=1)
        return df

    @staticmethod
    def remove_lines_zero_values(file_path):
        maximum_zero_per_line=10
        df = pd.read_csv(file_path)
        new_df = df.drop(df[df.eq(0).sum(axis=1)>maximum_zero_per_line].index)
        return new_df

    @staticmethod
    def print_performance(list_scores,list_pmcs):
        print("")
        for i in range(len(list_pmcs)):
           my_list =  list_pmcs[i]
           my_formatted_list = [ '%02d' % elem for elem in my_list ]
           print("Mean Accuracy: {0:.2f} ".format(round(list_scores[i],2)),my_formatted_list)
        print("Final Mean : {0:.2f} ".format(round(sum(list_scores)/len(list_scores),2)))

    @staticmethod
    def print_selected_pmcs(my_dict, num_pmcs):
        dictionary = sorted(my_dict.items(), key=operator.itemgetter(1), reverse=True)
        for i in range(num_pmcs):
           string = "\'"+dictionary[i][0]+"\'"
           print(string, end =",")

    @staticmethod
    def rmsle_error(y_true, y_pred):
        assert len(y_true) == len(y_pred)
        return np.sqrt(np.mean((np.log1p(y_pred) - np.log1p(y_true))**2))

    @staticmethod
    def score_regression(y_true, y_pred, report=True):
        """
        Create regression score
        :param y:
        :param y_hat:
        :return:
        """
        r2 = r2_score(y_true, y_pred)
        rmse = np.sqrt(mean_squared_error(y_true, y_pred))
        mae = mean_absolute_error(y_true, y_pred)
        rmsle = Common.rmsle_error(y_true, y_pred)

        #report_string = "---Regression Score--- \n"
        #report_string += "R2 = " + str(r2) + "\n"
        #report_string += "RMSE = " + str(rmse) + "\n"
        #report_string += "RMSLE (kaggle) = " + str(rmsle) + "\n"
        #report_string += "MAE = " + str(mae) + "\n"

        #print("R2 = " + str(r2))
        return r2

        #print(report_string)
        #return mae, report_string

    @staticmethod
    def plot_predict_values(Y,predicted,name_of_file, title):
        mpl.rcParams['xtick.labelsize'] = 14
        mpl.rcParams['ytick.labelsize'] = 14
        fig, ax = plt.subplots()
        fig.suptitle(title)
        ax.grid(False)
        ax.scatter(Y, predicted)
        ax.plot([Y.min(), Y.max()], [Y.min(), Y.max()], 'k--', lw=4)
        ax.set_xlabel('Measured',fontsize=14)
        ax.set_ylabel('Predicted',fontsize=14)
        #plt.savefig(name_of_file, dpi=300, bbox_inches='tight', format='eps')
        plt.savefig(name_of_file, dpi=300, bbox_inches='tight', format='png')

        #df = pd.DataFrame()
        #df['MAPE'] = np.array((abs(Y[0] -  predicted)/abs(predicted))*100)
        #filename, file_extension = os.path.splitext(name_of_file)
        #filename = filename+".csv"
        #df['MAPE'].describe().to_csv(filename)
        #files.download(name_of_file)
        #plt.show()

    @staticmethod
    def plot_boxplot(model_name,scores_list,mean):
        mpl.rcParams['xtick.labelsize'] = 14
        mpl.rcParams['ytick.labelsize'] = 14
        fig, ax = plt.subplots()
        fig.suptitle(model_name)

        file_name=model_name+"_"+sys.argv[4]+"_"+"Kfold_"+str(K_FOLD_N_SPLITS)+"_Mean_"+str(mean)+"_FINAL"+".png"
        plt.boxplot(scores_list)
        plt.savefig(file_name)


    @staticmethod
    def plot_barplot(model_name,scores_list,mean,i):
        mpl.rcParams['xtick.labelsize'] = 14
        mpl.rcParams['ytick.labelsize'] = 14
        fig, ax = plt.subplots()
        fig.suptitle(model_name)

        labels =  np.arange(1,K_FOLD_N_SPLITS+1)

        file_name=model_name+"_"+sys.argv[4]+"_"+"Kfold_"+str(K_FOLD_N_SPLITS)+"_"+"Iteration_"+str(i)+"_Mean_"+str(mean)+".png"
        plt.bar(labels.tolist(),scores_list)
        plt.savefig(file_name)

    @staticmethod
    def drop_constant_column_v2(df):
        #drop_col = [e for e in df.columns if df[e].nunique() == 1]
        drop_col = [i for i in range(len(df.columns)) if df[df.keys()[i]].nunique() == 1]
        #print("Columns removed:",drop_col)
        df.drop(drop_col,axis=1,inplace=True)
        return drop_col

    @staticmethod
    def drop_constant_column(dataframe):
        """
        Drops constant value columns of pandas dataframe.
        """
        return dataframe.loc[:, (dataframe != dataframe.iloc[0]).any()]

    @staticmethod
    def plot_density_histogram(models,best_pmcs):
        df = ds.df_pmcs.copy()
        for i in range(len(models)):
            #sns.distplot(df[best_pmcs[j][2]], hist = True, kde = True,kde_kws = {'linewidth': 3}, hist_kws={'edgecolor':'black'},label = best_pmcs[j][0])
            #sns.distplot(df[best_pmcs[j][1]], hist = False, kde = True,kde_kws = {'linewidth': 3}, label = best_pmcs[j][1])
            for j in range(len(best_pmcs[i])):
                #sns.distplot(df[best_pmcs[i][j]], hist = True, kde = True,kde_kws = {'linewidth': 3}, hist_kws={'edgecolor':'black'},label = best_pmcs[i][j])
                sns.distplot(df[best_pmcs[i][j]])
                plt.legend(prop={'size': 12})
                plt.title('Density Plot for %s' % str(best_pmcs[i][j]))
                plt.xlabel('Values')
                plt.ylabel('Density')
                name_file="Density_histogram_"+models[i][0]+"_"+str(best_pmcs[i][j])+".png"
                plt.savefig(name_file,dpi=300, bbox_inches='tight', format='png')
                plt.clf()
    @staticmethod
    def plot_density_histogram_for_correlations(models,best_pmcs,correlation):
        df = ds.df_pmcs.copy()
        for i in range(len(models)):
            #sns.distplot(df[best_pmcs[j][2]], hist = True, kde = True,kde_kws = {'linewidth': 3}, hist_kws={'edgecolor':'black'},label = best_pmcs[j][0])
            #sns.distplot(df[best_pmcs[j][1]], hist = False, kde = True,kde_kws = {'linewidth': 3}, label = best_pmcs[j][1])
            for j in range(len(best_pmcs[i])):
                #sns.distplot(df[best_pmcs[i][j]], hist = True, kde = True,kde_kws = {'linewidth': 3}, hist_kws={'edgecolor':'black'},label = best_pmcs[i][j])
                sns.distplot(df[best_pmcs[i][j]])
                plt.legend(prop={'size': 12})
                plt.title('Density Plot for %s' % str(best_pmcs[i][j]))
                plt.xlabel('Values')
                plt.ylabel('Density')                
                name_file="Density_histogram_"+correlation+"_"+models[i][0]+"_"+str(best_pmcs[i][j])+".png"
                #plt.savefig(name_file,dpi=300, bbox_inches='tight', format='eps')
                plt.savefig(name_file,dpi=300, bbox_inches='tight', format='png')
                plt.clf()
    @staticmethod
    def export_tree(df,clf):
        #Export a decision tree in DOT format.
        #clf = model.fit(X,Y)
        #dot -Tps tree.dot -o outfile.ps
        from sklearn import tree
        last_column_name = list(df_pmcs_avg.columns.values)[-1]
        X = df_pmcs_avg.loc[:, df_pmcs_avg.columns != last_column_name]
        tree.export_graphviz(clf,out_file = "tree.dot", feature_names = X.columns)

    @staticmethod
    def get_subset_features_and_target(df, best_pmcs):        
        last_column_name = list(df.columns.values)[-1]
        X = df[best_pmcs].values
        Y = df[[last_column_name]].to_numpy()
        return X, Y

    @staticmethod
    def get_features_and_target(df):
        last_column_name = list(df.columns.values)[-1]
        X = df.loc[:, df.columns != last_column_name].values
        Y = df[[last_column_name]].to_numpy()
        return X, Y

    @staticmethod
    def convert_list_to_df_and_save(data, filename):
        df = pd.DataFrame(data)
        df.to_csv(filename,header=False)


#Class Variable
class Dataset:
    #df_pmcs = pd.read_csv(sys.argv[1])
    #df_pmcs_avg = pd.read_csv(sys.argv[2])

    #Whe should sure that both dataset has the same valid values (no zero) for each column
    #First we remove all the invalid column and remove the same column in the other
    #drop_col = Common.drop_constant_column_v2(df_pmcs_avg)
    #df_pmcs.drop(drop_col,axis=1,inplace=True)

    #Here we do the oposite
    #drop_col = Common.drop_constant_column_v2(df_pmcs)
    #df_pmcs_avg.drop(drop_col,axis=1,inplace=True)
    
    df_pmcs = pd.read_csv(sys.argv[1])
    df_pmcs_avg = pd.read_csv(sys.argv[2])
    
    #print(df_pmcs.columns)
    #first_row_full = {i:str(np.array(df_pmcs.columns)[int(i)]) for i in range(len(df_pmcs.columns))}
    #first_row_avg = df_pmcs_avg.columns
    
    ########Problem: This deletes first row#########
    df_pmcs_avg.columns = [str(i) for i in range(len(df_pmcs_avg.columns))]
    df_pmcs.columns = [str(i) for i in range(len(df_pmcs.columns))]
    ################################################
    
    #Whe should sure that both dataset has the same valid values (no zero) for each column
    #First we remove all the invalid column and remove the same column in the other
    drop_col = Common.drop_constant_column_v2(df_pmcs_avg)
    df_pmcs.drop(drop_col,axis=1,inplace=True)

    #Here we do the oposite
    drop_col = Common.drop_constant_column_v2(df_pmcs)
    df_pmcs_avg.drop(drop_col,axis=0,inplace=True)


class Models:
    '''
    This class basically return from your functions an list of models that we will work. RFR has taken a lot of time and for this reason i have commented
    '''
    @staticmethod
    def get_models_default_parameters():
        models =[("DTR",DecisionTreeRegressor(random_state=0)) ,
                 #("RFR",RandomForestRegressor(random_state=0,n_estimators=30,n_jobs=-1)), #, n_jobs=-1)),
                 ("GBR",GradientBoostingRegressor(random_state=0,n_estimators=30)),
                 ("XGBR",XGBRegressor(objective='reg:squarederror',colsample_bytree=0.9, max_depth=None,n_estimators=30,n_jobs=-1))] #,n_jobs=-1))] #,
                 #("MLP",MLPRegressor(max_iter=5000))]
        return models

    @staticmethod
    def get_models_initial_parameters():
        models = [("DTR",DecisionTreeRegressor(max_depth=30, max_features='auto')),
                  #("RFR",RandomForestRegressor(bootstrap='True', max_depth=None, max_features=None, n_estimators=10,n_jobs=-1)),
                  ("GBR",GradientBoostingRegressor(learning_rate=0.1, n_estimators=30)) ,
                  ("XGBR",XGBRegressor(objective='reg:squarederror',colsample_bytree=0.9, max_depth=None, n_estimators=30,n_jobs=-1))] #,
                  #("MLP",MLPRegressor(alpha= 0.0001, batch_size=8, hidden_layer_sizes=100, max_iter=5000, solver='adam'))]
        return models  

class HCA:
    '''
    This class has two functions responsible for calculate HCA(Hierarchical cluster analyses).
    One function plot hca and another return correlation of features per cluster.
    '''

    @staticmethod
    def create_hca():
        '''
        Here we use dataset with all trace
        '''
        plt.figure(figsize=(45, 25))
        #plt.axvline(x=0.86, color='black', linestyle='--')
        df_pmcs = ds.df_pmcs.copy()

        correlations=['pearson', 'spearman', 'kendall']
        for corr_method in correlations:
            corr = 1 - df_pmcs.corr(method = corr_method).abs()
            corr_condensed = shc.distance.squareform(corr) # convert to condensed
            z = shc.linkage(corr_condensed, method='average') #orientation="right"
            dendrogram = shc.dendrogram(z,labels=corr.columns,orientation="right",leaf_rotation=0,leaf_font_size=10) #if orientation right, change rotation to 0
            file_name=corr_method + ".png"
            plt.savefig(file_name, dpi=300, bbox_inches='tight')
            plt.clf()

    @staticmethod
    def get_features_per_cluster(number_of_clusters,corr_method):
        df_pmcs = ds.df_pmcs.copy()
        df_pmcs_avg = ds.df_pmcs_avg.copy()

        df_pmcs.drop(['0'],axis = 1,inplace=True)
        df_pmcs_avg.drop(['0'],axis = 1,inplace=True)

        #calculate correlation with all features each other
        corr = 1 - df_pmcs.corr(method=corr_method).abs()
        corr_condensed = shc.distance.squareform(corr) # convert to condensed
        z = shc.linkage(corr_condensed, method='average')
        #z = shc.linkage(corr_condensed, method='centroid')

        tree = shc.cut_tree(z, n_clusters = number_of_clusters)

        feat_per_cluster = [[] for i in range(0, number_of_clusters)]#create list of features for each cluster
        feat_correlation = [[] for i in range(0, number_of_clusters)]#create list of correlation values with target

        #Here we wave each features in your cluster, but we need to know wich inside of cluster has more correlation with target
        for i in range(len(df_pmcs.columns)):
            cluster_id = tree[i][0]   #get cluster identification
            feat_per_cluster[cluster_id].append(df_pmcs.columns[i])#add the name of this pmcs in this cluster

        #Now we need to get the correlation
        dictionary = Filter.get_features_correlated_with_target_sorted(ds.df_pmcs_avg.copy(),corr_method)

        for i in range(number_of_clusters):
          for j in range(len(feat_per_cluster[i])):
             feat_correlation[i].append(dictionary.get(feat_per_cluster[i][j]))

        #This part correct this problem: TypeError: '>' not supported between instances of 'float' and 'NoneType'
        for i in range(number_of_clusters):
           for j in range(len(feat_per_cluster[i])-1):
               if feat_correlation[i][j] == None:
                  feat_correlation[i].pop(j)
                  feat_per_cluster[i].pop(j)


        features_correlation_per_cluster = [[] for i in range(0, number_of_clusters)]
        for i in range(number_of_clusters):
          result = dict(zip(feat_per_cluster[i],feat_correlation[i]))
          #print(sorted(result.items(), key=operator.itemgetter(1),reverse=True))
          features_correlation_per_cluster[i].append(sorted(result.items(), key=operator.itemgetter(1),reverse=True))

        return features_correlation_per_cluster


class Wrapper:
    global K_FOLD_N_SPLITS

    def incremental_feature_select_using_correlation(subset_pmcs,model):
        index_pmcs_selected = []
        best_score = -maxsize
        best_index = -1

        df = ds.df_pmcs_avg[subset_pmcs].copy() #this dataframe will not have instrcutions and cycles        
        #df['avg_instructions'] = ds.df_pmcs_avg['avg_instructions']
        df['0'] = ds.df_pmcs_avg['0']

        X = df.values
        last_column_name = list(ds.df_pmcs_avg.columns.values)[-1]
        Y = ds.df_pmcs_avg[[last_column_name]].to_numpy()

        #scaler = Normalizer().fit(X)
        array = np.concatenate((X,Y),axis=1)

        #Force to show decimal format instead cientific
        #np.set_printoptions(suppress=True)
        #print(array)

        #pmcs_selected = df[['avg_instructions']].values
        #index_pmcs_selected.append(df.columns.get_loc("avg_instructions"))
        pmcs_selected = df[['0']].values
        index_pmcs_selected.append(df.columns.get_loc("0"))

        seed = random.randint(1, 1000)
        model = model
        model.set_params(random_state=seed) #REPRODUCIBLE since seed initial set

        for j in range(MAX_PMCS_TO_SELECT):
             #for i in range (0,len(df_pmcs_avg.columns)-num_target_columns):
             i=0
             while i< len(df.columns): #Poderia até colocar columns -2 já que as duas ultimas colunas já foram inseridas cycles/instructions
                #current_column_limit = (i+1)*NUM_PMCS_PER_TEST
                if i not in index_pmcs_selected:
                    column = array[:,[i]] #select subset to be test
                    X = np.concatenate((pmcs_selected, column), axis=1) #concate with the pmcs selected before
                    Y = array[:, [-1]]

                    #dataset performance is too small, so i need to use all datast
                    k_fold = KFold(n_splits=K_FOLD_N_SPLITS, shuffle=True, random_state=0)
                    predicted = cross_val_predict(model, X, Y.ravel(), cv = k_fold)
                    current_score = Common.score_regression(Y,predicted)
                    #scores = cross_val_score(model, X, Y.ravel(), cv = k_fold, scoring='r2',n_jobs=-1)
                    #current_score = scores.mean()

                    if current_score > best_score:
                        best_score = current_score
                        best_index = i
                i+=1
             if best_index not in index_pmcs_selected: #outside from while
                 index_pmcs_selected.append(best_index)
                 column = array[:,[best_index]]
                 pmcs_selected = np.concatenate((pmcs_selected, column), axis=1)


        string_pmcs_selected = []
        for s in range(len(index_pmcs_selected)):
            string_pmcs_selected.append(df.columns[index_pmcs_selected[s]])

        X = array[:,index_pmcs_selected]
        Y = array[:, [-1]]

        k_fold = KFold(n_splits=K_FOLD_N_SPLITS, shuffle=True, random_state=0)
        predicted = cross_val_predict(model, X, Y.ravel(), cv = k_fold)        
        score = Common.score_regression(Y,predicted)

        return score,string_pmcs_selected,seed

    def incremental_feature_select_using_importance(model):
        df = ds.df_pmcs_avg.copy()
        X, Y = Common.get_features_and_target(df)

        seed = random.randint(1, 1000)
        model = model
        model.set_params(random_state=seed) #REPRODUCIBLE since seed initial set
        model.fit(X, Y.ravel())

        last_column_name = list(df.columns.values)[-1]
        X = df.loc[:, df.columns != last_column_name]
        feature_importances = pd.DataFrame(model.feature_importances_,index = X.columns,columns=['importance']).sort_values('importance',ascending=False).head(3)
        subset_pmcs = feature_importances.index.tolist()

        if subset_pmcs.count("avg_instructions") == 1 or subset_pmcs.count("0") == 1:
            print("Another pmcs should be select because instructions and cycles are already select by default!")
        df = ds.df_pmcs_avg[subset_pmcs].copy() #this dataframe will not have instrcutions and cycles
        df['avg_instructions'] = ds.df_pmcs_avg['avg_instructions']
        df['0'] = ds.df_pmcs_avg['0']
        #print(df.shape)

        X = df.values
        last_column_name = list(ds.df_pmcs_avg.columns.values)[-1]
        Y = ds.df_pmcs_avg[[last_column_name]].to_numpy()

        k_fold = KFold(n_splits=K_FOLD_N_SPLITS, shuffle=True, random_state=0)
        predicted = cross_val_predict(model, X, Y.ravel(), cv = k_fold)
        score = Common.score_regression(Y,predicted)
        #print("Score:", score)

        subset_pmcs = ['0'] + subset_pmcs
        return score,subset_pmcs,seed


    '''
    This function call the last two other functions.
    '''
    @staticmethod
    def select_best_pmcs(models,subset_pmcs):
        list_scores_pmcs_selected = []
        list_index_pmcs_selected = []
        list_names_pmcs_selected = []
        list_seeds = []
        j = -1
        for model_name, model in models:
            #print(model_name)
            list_scores_pmcs_selected.append(-100)
            list_names_pmcs_selected.append(['null'])
            list_seeds.append(-1)
            current_score = -100
            old_score = -100
            current_iter=0
            j+=1

            '''
            If the accuracy achieves the minimum, after 20 iterations the loop break.
            But if not, they continue until or to get the better accuracy or to get 100 iterations
            '''
            while current_score< MINIMUM_ACCURACY or current_iter < 10:
                #print("Iter:",current_iter)
                start = timeit.default_timer()
                if sys.argv[3] == "FilterCorrelation" or sys.argv[3] == "HCA_FilterCorrelation":
                   score,string_pmcs_selected,seed  = Wrapper.incremental_feature_select_using_correlation(subset_pmcs, model)
                elif sys.argv[3] == "WrapperImportance":
                   score,string_pmcs_selected,seed = Wrapper.incremental_feature_select_using_importance(model)
                else:
                   print("Invalid parameter")
                current_score = score.mean()
                if current_score > old_score:
                    del list_scores_pmcs_selected[j]
                    del list_names_pmcs_selected[j]
                    del list_seeds[j]
                    list_scores_pmcs_selected.append(round(score,2))
                    list_names_pmcs_selected.append(string_pmcs_selected)
                    list_seeds.append(seed)
                    old_score = current_score

                current_iter+=1
                if current_iter > NUMBER_MAX_ITER:
                   print(model_name," exceeded max iterations !!!!")
                   break
                #print("Time(minutes) {0:.2f} \n".format(round((timeit.default_timer() - start))/60,2))

        return list_names_pmcs_selected,list_scores_pmcs_selected,list_seeds

class Filter:
    @staticmethod
    def get_features_correlated_with_target_sorted(df_pmcs_avg, method):
        '''
        We are assuming that target is the last column
        '''
        df = df_pmcs_avg.copy()
        df.drop(['0'],axis = 1,inplace=True)#As we will select them regardless, i removed
        last_column_name = list(df.columns.values)[-1]
        correlation_matriz = df.corr(method)
        dic_params = abs(correlation_matriz[last_column_name]).sort_values(ascending=False).to_dict()

        return dic_params

    def get_features_HCA(number_of_clusters):
        corr = 1 - ds.df_pmcs.corr().abs()
        corr_condensed = shc.distance.squareform(corr) # convert to condensed
        z = shc.linkage(corr_condensed, method='average')
        tree = shc.cut_tree(z, n_clusters = number_of_clusters)

        feat_per_cluster = [[] for i in range(0, number_of_clusters)]#create list of features for each cluster
        feat_correlation = [[] for i in range(0, number_of_clusters)]#create list of correlation values with target

        #Here we wave each features in your cluster, but we need to know wich inside of cluster has more correlation with target
        for i in range(len(ds.df_pmcs.columns)):
            cluster_id = tree[i][0]   #get cluster identification
            feat_per_cluster[cluster_id].append(ds.df_pmcs.columns[i])#add the name of this pmcs in this cluster

        #Now we need to get the correlation
        dictionary = Filter.get_features_correlated_with_target_sorted(ds.df_pmcs_avg,method)

        for i in range(number_of_clusters):
          for j in range(len(feat_per_cluster[i])):
             feat_correlation[i].append(dictionary.get(feat_per_cluster[i][j]))

        #This part correct this problem: TypeError: '>' not supported between instances of 'float' and 'NoneType'
        for i in range(number_of_clusters):
           for j in range(len(feat_per_cluster[i])-1):
               if feat_correlation[i][j] == None:
                  feat_correlation[i].pop(j)
                  feat_per_cluster[i].pop(j)


        #features_correlation_per_cluster = [[] for i in range(0, number_of_clusters)]
        selected_pmcs = []
        for i in range(number_of_clusters):
          result = dict(zip(feat_per_cluster[i],feat_correlation[i]))
          dic_params = sorted(result.items(), key=operator.itemgetter(1),reverse=True)
          selected_pmcs.append(dic_params[0][0])

          #features_correlation_per_cluster[i].append(sorted(result.items(), key=operator.itemgetter(1),reverse=True))
        return selected_pmcs

class Tunning:
    @staticmethod
    def tunning_model(models, list_best_pmcs):
        global K_FOLD_N_SPLITS
        seed = random.randint(1, 1000)
        acc_list = []
        acc_avg_list = []
        acc_std_list = []
        j=0

        tunned_models = []

        df = ds.df_pmcs_avg.copy()

        last_column_name = list(df.columns.values)[-1]
        for model_name, model in models:            

            X = df[list_best_pmcs[j]].values
            Y = df[[last_column_name]].to_numpy()

            scaler = Normalizer().fit(X)

            current_model = model
            #model.set_params(random_state=seed)

            if model_name == 'DTR':
                param_grid = {'max_depth': [2,8,20,50],'max_features': ["auto", "sqrt", "log2"]}

            elif model_name == 'RFR':
                param_grid = {'n_estimators': [10,30,50,80,100,120,150],'min_samples_split':[2,5,10,20],"bootstrap": [True, False]}

            elif model_name == 'GBR':
                param_grid = {'n_estimators': [30,50,80,100,150,180,200,400,600],'learning_rate': [0.1,0.3,0.5,0.75,0.9,0.95],  }

            elif model_name == 'XGBR':
                 param_grid = {'n_estimators': [30,50,80,100,120,150,200],'colsample_bytree': [0.3,0.5, 0.7, 0.9]}

            elif model_name == 'NN':
                param_grid = { 'batch_size': [8, 16, 32],'alpha': [0.0001, 0.001, 0.01, 0.08, 0.1, 0.15],'max_iter':[5000,7000],
                                                            'hidden_layer_sizes': [(50), (75),(100),(50,100), (100,100), (200,200),(200,300),(300,300), (400,400)],}
            else:
                print("Invalid model!!")


            k_fold = KFold(n_splits=K_FOLD_N_SPLITS, shuffle=True, random_state=0)
            grid_ret = GridSearchCV(estimator=current_model, param_grid=param_grid, cv=k_fold, scoring='r2', verbose=False,n_jobs=-1)
            #ret_gridsearch = grid_ret.fit(scaler.transform(X), Y.ravel())
            ret_gridsearch = grid_ret.fit(X, Y.ravel())
            current_model.set_params(**ret_gridsearch.best_params_)

            tunned_models.append(current_model)
            '''
            #After we discovery the best parameters, we calculate the accuracy using theses best parametrs
            acc, avg, std = Accuracy.calculate_accuracy(model_name,current_model,scaler.transform(X),Y.ravel())

            acc_list.append(acc)
            acc_avg_list.append(avg)
            acc_std_list.append(std)
            j+=1
            '''
            j+=1
            #print(model_name," ", ret_gridsearch.best_params_)

        #for acc, avg, std in zip(acc_list, acc_avg_list, acc_std_list):
        #     print("Acc:",acc," Mean:",avg," Std:", std)
        return tunned_models


class Accuracy:
    @staticmethod
    def calculate_accuracy(model_name,model, X, Y):
         r2_list = []
         current_r2 = 0
         num_iterations = 0

         scores_list = []
         mean_list = []

         while num_iterations < 10: #Before i just increased k when it get minimum accuracy, but i decided to remove
                seed = random.randint(1, 1000)
                model.set_params(random_state=seed)

                k_fold = KFold(n_splits=K_FOLD_N_SPLITS, shuffle=True, random_state=0)

                predicted = cross_val_predict(model, X, Y, cv = k_fold)
                current_r2 = Common.score_regression(Y,predicted)
                #file_name=model_name+"_"+str(num_iterations)+"_r2_"+str(round(current_r2,2))+".eps"
                file_name=model_name+"_"+str(num_iterations)+"_r2_"+str(round(current_r2,2))+".png"
                title = sys.argv[3]+ " " + model_name + "\n" + "R"+ str(chr(0x00B2)) +"=" + str(round(current_r2,2))
                Common.plot_predict_values(Y,predicted,file_name, title)                
                r2_list.append(round(current_r2,2))

                '''
                scores = cross_val_score(model,X, Y, cv = k_fold, scoring='r2',n_jobs=-1)
                file_name=model_name+"_"+str(num_iterations)+"_r2_"+str(round(scores.mean(),2))+".eps"
                title = sys.argv[3]+ " " + model_name + "\n" + "R"+ str(chr(0x00B2)) +"=" + str(round(scores.mean(),2))
                Common.plot_barplot(model_name,scores.tolist(),scores.mean(),num_iterations)
                r2_list.append(round(scores.mean(),2))
                scores_list.append(scores)
                mean_list.append(scores.mean())
                '''
                num_iterations+=1

         #Common.plot_boxplot(model_name,scores_list,sum(mean_list)/len(mean_list))

         return r2_list,round(statistics.mean(r2_list),2), round(statistics.stdev(r2_list),2)


        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
if __name__ == '__main__':
    
    ds = Dataset()
    #HCA.create_hca()
    
    if sys.argv[3] == "FilterCorrelation":
       logging.info("FilterCorrelation - Select Features")
       models = Models.get_models_initial_parameters()

       results = []
       corr_method=['pearson', 'spearman', 'kendall']
       for i in range(len(corr_method)):
           print("Using correlation method:", corr_method[i])
           logging.info("Correlation:%s",corr_method[i])

           last_column_name = list(ds.df_pmcs_avg.columns.values)[-1]
           dic_params = Filter.get_features_correlated_with_target_sorted(ds.df_pmcs_avg,corr_method[i])

           subset_pmcs = []
           max = 0
           for key,value in dic_params.items():
               if not key == last_column_name:
                   if max ==30: #get the best 30 features
                       break
                   subset_pmcs.append(key)
                   max+=1

           #subset_pmcs = ['avg_cycles','avg_instructions'] + subset_pmcs
           best_pmcs,score,seeds = Wrapper.select_best_pmcs(models,subset_pmcs) #Here we have n models and different pmcs selection for each model probably

           #Common.plot_density_histogram_for_correlations(models,best_pmcs,correlations[i])

           for j in range(len(models)):
               #print(models[j][0],pmcs_selected[j],"R2:",score[j]," Seed:",seeds[j])
               logging.info("Model:%s best_pmcs:%s r2:%s",models[j][0],best_pmcs[j],score[j])
               results.append(best_pmcs[j])

       Common.convert_list_to_df_and_save(results, "FilterCorrelation_Best_PMCs.csv")


       logging.info("\nFilterCorrelation - Validation")
       results = []
       for i in range(len(corr_method)):
           logging.info("\nCorrelation:%s",corr_method[i])

           for j in range(len(models)):
               row = []
               X, Y = Common.get_subset_features_and_target(ds.df_pmcs_avg.copy(), best_pmcs[j])
               r2_list,avg,std = Accuracy.calculate_accuracy(models[j][0],models[j][1],X,Y.ravel())
               logging.info("Model:%s r2:%s avg:%s std:%s",models[j][0],r2_list,avg,std)
               algorithm = "Filter_" + corr_method[i] + "_" + models[j][0]
               row.append(algorithm)
               row.append(avg)
               row.append(std)
               results.append(row)

       Common.convert_list_to_df_and_save(results, "FilterCorrelation_Accuracy.csv")


    elif sys.argv[3] == "HCA_FilterCorrelation":
       #HCA.create_hca()
       logging.info("HCA_FilterCorrelation")
       results = []
       corr_method=['pearson', 'spearman', 'kendall']
       for i in range(len(corr_method)):
           #print("Correlation:",corr_method[i])
           logging.info("Correlation:%s",corr_method[i])
           features_per_cluster_sorted = HCA.get_features_per_cluster(30,corr_method[i])
           subset_features = []
           for cluster in features_per_cluster_sorted:
               subset_features.append(cluster[0][0][0])
           models = Models.get_models_initial_parameters()
           best_pmcs,score,seeds = Wrapper.select_best_pmcs(models,subset_features)

           #Common.plot_density_histogram_for_correlations(models,best_pmcs,correlations[i])
           '''
           for j in range(len(models)):
               row = []
               #print(models[j][0],pmcs_selected[j],"R2:",score[j]," Seed:",seeds[j])
               logging.info("Model:%s best_pmcs:%s r2:%s",models[j][0],best_pmcs[j],score[j])
               X, Y = Common.get_subset_features_and_target(ds.df_pmcs_avg.copy(), best_pmcs[j])
               r2_list,avg,std = Accuracy.calculate_accuracy(models[j][0],models[j][1],X,Y.ravel())
               algorithm = "HCA_Filter_" + corr_method[i] + "_" + models[j][0]
               row.append(algorithm)
               row.append(avg)
               row.append(std)
               results.append(row)
           '''
       #Common.convert_list_to_df_and_save(results, "HCA_FilterCorrelation_Accuracy.csv")

    elif sys.argv[3] == "WrapperImportance":
       logging.info("WrapperImportance")
       models = Models.get_models_initial_parameters()
       subset_features = [[],[],[]]
       best_pmcs,score,seeds = Wrapper.select_best_pmcs(models,subset_features)

       #Common.plot_density_histogram(models,best_pmcs)

       results = []
       for j in range(len(models)):
           logging.info("Model:%s best_pmcs:%s r2:%s",models[j][0],best_pmcs[j],score[j])
           #print(models[j][0],pmcs_selected[j],"R2:",score[j]," Seed:",seeds[j])
           results.append(best_pmcs[j])
       Common.convert_list_to_df_and_save(results, "WrapperImportance_Best_PMCs.csv")


       logging.info("\nWrapperImportance - Validation")
       results = []
       for i in range(len(models)):
           row = []
           X, Y = Common.get_subset_features_and_target(ds.df_pmcs_avg.copy(), best_pmcs[j])
           r2_list,avg,std = Accuracy.calculate_accuracy(models[i][0],models[i][1],X,Y.ravel())
           logging.info("Model:%s r2:%s avg:%s std:%s",models[i][0],r2_list,avg,std)
           algorithm = "WrapperImportance_" + models[i][0]
           row.append(algorithm)
           row.append(avg)
           row.append(std)
           results.append(row)
       Common.convert_list_to_df_and_save(results, "WrapperImportance_Accuracy.csv")

       '''
       For using tunning, passing as parametrs and make some contition on code.
       For example, we can reuse models and best_pmcs from th begining and do this:

       models_tunned = Tunning.tunning_model(models,best_pmcs)
       for j in range(len(models)):
         X, Y = Common.get_subset_features_and_target(ds.df_pmcs_avg.copy(), best_pmcs)
         r2_list,avg,std = Accuracy.calculate_accuracy(models[j][0],models_tunned[j],scaler.transform(X),Y.ravel())
         print(r2_list,avg)
       '''


    else:
       print("\n Wrong parameter!! You should pass FilterCorrelation,HCA_FilterCorrelation or WrapperImportance. \n")



