PREFLAGS=-O3 -E -P -fopenmp
CLASS=A
INC=-I../Energymonitorlibrary/include/
HELPERS=c_randdp.c c_timers.c  c_print_results.c wtime.c
HELPOBJS=wtime.o c_timers.o c_print_results.o c_randdp.o
ISHELPERS=c_timers.c  c_print_results.c wtime.c
ISHELPOBJS=wtime.o c_timers.o c_print_results.o
LINK=-fopenmp -lm
EM=-lenergymodule
CFILES= *.c
CC=gcc
OBJFLAGS= -c -O3
frompreprocessed:  bt cg ep ft is lu mg sp dc

all: frombase

frombase: bt cg ep ft is lu mg sp

.PHONY  : clean clean_pre



bt_pre.o: bt_pre.c
	$(CC) $(OBJFLAGS) bt_pre.c $(LINK)

bt: bt_pre.o $(ISHELPOBJS)		
	$(CC)  -fopenmp -o bt bt_pre.o $(ISHELPOBJS) -lm $(EM) 	$(LINK)


dc_pre.o: dc_pre.c
	$(CC) $(OBJFLAGS) dc_pre.c $(LINK)

dc_pre_g.o: dc_pre.c
	$(CC) $(OBJFLAGS) dc_pre.c $(LINK) -g

dc_g: dc_pre_g.o $(ISHELPOBJS)		
	$(CC)  -fopenmp -o dc_g dc_pre.o $(ISHELPOBJS) -lm $(EM)	 $(LINK) -g



cg_pre.o: cg_pre.c
	$(CC) $(OBJFLAGS) cg_pre.c $(LINK)
cg      : cg_pre.o  $(HELPOBJS)
	$(CC)  -fopenmp -o cg cg_pre.o  $(HELPOBJS) -lm $(EM) $(LINK)

ep_pre.o: ep_pre.c
	 $(CC) $(OBJFLAGS) ep_pre.c $(LINK)
ep     : ep_pre.o  $(HELPOBJS)
	$(CC) -o $@ $@_pre.o $(HELPOBJS) $(EM) -lm $(LINK)

ft_pre.o : ft_pre.c
	$(CC) $(OBJFLAGS) $(LINK) $< 
ft: ft_pre.o $(HELPOBJS)
	$(CC) -o $@ $@_pre.o $(HELPOBJS) -lm -fopenmp $(EM) $(LINK)


is_pre.o: is_pre.c
	$(CC) $(OBJFLAGS) $(LINK) $<
is     : is_pre.o $(ISHELPOBJS)
	$(CC) -o $@ $@_pre.o $(ISHELPOBJS) -fopenmp $(EM) -lm $(LINK)

lu_pre.o: lu_pre.c
	$(CC) $(OBJFLAGS) $(LINK) $<
lu     : lu_pre.o $(ISHELPOBJS)
	$(CC) -o $@ $@_pre.o $(ISHELPOBJS) -lm -fopenmp $(EM) $(LINK)

mg_pre.o: mg_pre.c
	$(CC) $(OBJFLAGS) $(LINK) $<
mg     : mg_pre.o $(HELPOBJS)
	$(CC) -o $@ $@_pre.o $(HELPOBJS) -lm -fopenmp $(EM) $(LINK)

sp_pre.o: sp_pre.c
	$(CC) $(OBJFLAGS) $(LINK) $<
sp     : sp_pre.o $(ISHELPOBJS)
	$(CC) -o $@ $@_pre.o $(ISHELPOBJS) -lm -fopenmp $(EM) $(LINK)


clean_all: clean

clean:
	-rm bt cg ep ft is lu mg sp dc
clean_obj :
	-rm bt_pre.o cg_pre.o ep_pre.o ft_pre.o is_pre.o lu_pre.o mg_pre.o sp_pre.o dc_pre.o
