import os
import csv
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

destfile = open("data.csv", 'w')
writer = csv.DictWriter(destfile, fieldnames=['timestamp', 'name','value', 'energy', 'executiontime', 'config', 'benchmark_branch'])
writer.writeheader()
count = 0
data = list()
for x in os.listdir('pmcs'):
	if x.endswith('_pmcs'):#just in case there is any other folder needed to be added in the future
		config = x.split('_')[0]
		if config == '4l2b':
			config=config+'_'+x.split('_')[1]
			benchmark_branch = x.split('_')[3]
		else:
			benchmark_branch = x.split('_')[2]
		folder = os.path.join('pmcs', x)
		namefile = open(os.path.join(folder, 'pmcs_schedule.txt'), 'r')
		timefile = open(os.path.join(folder, 'ExecutionTimes.txt'), 'r')
		for n in range(int(namefile.readline())):
			filename = namefile.readline().split(' ')[1].replace(',', '_').replace('\n', '')
			if filename.split('_')[0]!='0x09' or filename.split('_')[0]!='0x10':
				energypath = os.path.join(folder, filename+'.energy')
				pmcpath = os.path.join(folder, filename + '.csv')
				
				pmcdata = np.genfromtxt(pmcpath, delimiter = ',', dtype = float)
				pmcdata = np.delete(pmcdata, 0, 0)#remove time stamp

				pmcfile = open(pmcpath, 'r')
				pmc_timestamp = pmcfile.read().split(',')[0]
				pmcfile.close()
				#reformat the energy file so it has same format as .csv files
				tempfile = open(energypath, 'r')
				tempdata = tempfile.read().replace(' ', ',')
				tempfile.close()
				tempfile = open(energypath, 'w')
				tempfile.write(tempdata)
				tempfile.close()

				energydata = np.genfromtxt(energypath, delimiter=',', dtype=float, skip_header=1, skip_footer = 1)
				energydata = np.delete(energydata, 0, 1)
				energydata = np.delete(energydata, 0, 1)

				energyfile = open(energypath, 'r')
				energyfile.readline()#skip the first line
				empty = True
				for row in range(np.shape(energydata)[0]):
					energy_timestamp = energyfile.readline().split('.')[0]+']'
					if energy_timestamp == pmc_timestamp:
						if empty:
							empty = False
							temp = energydata[row].reshape(1, 4)
						else:
							temp = np.append(temp, energydata[row].reshape(1,4), 0)
				energyfile.close()
				
				energydata = np.mean(temp, axis=0)
				executiontime = timefile.readline()

				sample = {'timestamp': pmc_timestamp, 'name': filename, 'value': pmcdata, 'energy': energydata, 'executiontime': executiontime, 'config':config, 'benchmark_branch': benchmark_branch}
				data.append(sample)
				writer.writerow(sample)
				count+=1
		namefile.close()
		timefile.close()
destfile.close()


#Now we have all samples in variable 'data'
destfile = open("results.csv", 'w')
writer = csv.DictWriter(destfile, fieldnames=['pmc', 'pearson','spearman', 'kendall', 'pmcs', 'core'])
writer.writeheader()

spresult = {'pearson': 0}
ssresult = {'spearman': 0}
skresult = {'kendall': 0}
bpresult = {'pearson': 0}
bsresult = {'spearman': 0}
bkresult = {'kendall': 0}

selectdata = {}
for sample in data:
	names = sample['name'].split('_')
	values = sample['value']
	energy = sample['energy'][2]
	for i in range(len(names)):
		name = names[i]
		value = values[i]

		if not selectdata.has_key(name):
			if sample['config']=='2b' or sample['config']=='4l2b_A72':
				config = 'Big'
			else:
				config = 'Small'
			selectdata[name] = {'pmcvalue': list(), 'energy': list(), 'pmcs': sample['name'], 'config': config }

		selectdata[name]['pmcvalue'].append(value)
		selectdata[name]['energy'].append(energy)

spmclist = list()
bpmclist = list()
plt.figure(figsize=(28,10))

for name, datadict in selectdata.items():
		pmcs = datadict.pop('pmcs')
		config = datadict.pop('config')
		sampledf = pd.DataFrame(datadict)
		pcorr = sampledf.corr(method = 'pearson')['pmcvalue']['energy']
		scorr = sampledf.corr(method = 'spearman')['pmcvalue']['energy']
		kcorr = sampledf.corr(method = 'kendall')['pmcvalue']['energy']
		result = {'pmc': name, 'pearson': pcorr,'spearman': scorr, 'kendall': kcorr, 'pmcs': pmcs, 'core': config}
		writer.writerow(result)
		if result['core'] == 'Small':
			if abs(result['pearson'])>abs(spresult['pearson']):
				spresult = result
			if abs(result['spearman'])>abs(ssresult['spearman']):
				ssresult = result
			if abs(result['kendall'])>abs(skresult['kendall']):
				skresult = result
		else:
			if abs(result['pearson'])>abs(bpresult['pearson']):
				bpresult = result
			if abs(result['spearman'])>abs(bsresult['spearman']):
				bsresult = result
			if abs(result['kendall'])>abs(bkresult['kendall']):
				bkresult = result
		if result['core'] == 'Big':
			plt.subplot(2,1,1)
			if bpmclist.count(result['pmc'])==0:
				bpmclist.append(result['pmc'])
			index = bpmclist.index(result['pmc'])
			p1, = plt.plot(index, result['pearson'],'ob')
			p2, = plt.plot(index, result['spearman'], '*b')
			p3, = plt.plot(index, result['kendall'], '^b')
		else:
			plt.subplot(2,1,2)
			if spmclist.count(result['pmc'])==0:
				spmclist.append(result['pmc'])
			index = spmclist.index(result['pmc'])
			plt.plot(index, result['pearson'], 'ob')
			plt.plot(index, result['spearman'], '*b')
			plt.plot(index, result['kendall'], '^b')

plt.subplot(2,1,1)
plt.xticks(range(len(bpmclist)), bpmclist)
plt.title('Energy-PMC Feature Selection Big Core')
#plt.xlabel('PMC')
plt.ylabel('Corrlation')
plt.xlim(-1, len(bpmclist)+1)
plt.ylim(-1, 1)
plt.legend((p1, p2, p3), ('Pearson', 'Spearman', 'Kendall'), fontsize=10)
plt.subplot(2,1,2)
plt.xticks(range(len(spmclist)), spmclist)
plt.title('Energy-PMC Feature Selection Small Core')
plt.xlabel('PMC')
plt.ylabel('Corrlation')
plt.xlim(-1, len(spmclist)+1)
plt.ylim(-1, 1)
plt.legend((p1, p2, p3), ('Pearson', 'Spearman', 'Kendall'), fontsize=10)
plt.savefig('result.png')



destfile.close()
print('Algorithm: Pearson')
print('	For small core: {}'.format(spresult['pmcs']))
print('		Correlation coefficient: {}'.format(spresult['pearson']))
print('	For big core: {}'.format(bpresult['pmcs']))
print('		Correlation coefficient: {}'.format(bpresult['pearson']))
print('\n')
print('Algorithm: Spearman')
print('	For small core: {}'.format(ssresult['pmcs']))
print('		Correlation coefficient: {}'.format(ssresult['spearman']))
print('	For big core: {}'.format(bsresult['pmcs']))
print('		Correlation coefficient: {}'.format(bsresult['spearman']))
print('\n')
print('Algorithm: Kendall')
print('	For small core: {}'.format(skresult['pmcs']))
print('		Correlation coefficient: {}'.format(skresult['kendall']))
print('	For big core: {}'.format(bkresult['pmcs']))
print('		Correlation coefficient: {}'.format(bkresult['kendall']))




		


