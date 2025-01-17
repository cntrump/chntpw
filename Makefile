#
# Makefile for the Offline NT Password Editor
#
#
# Change here to point to the needed OpenSSL libraries & .h files
# See INSTALL for more info.
#

PREFIX=/opt/local

#SSLPATH=/usr/local/ssl
OSSLPATH=/opt/local
OSSLINC=$(OSSLPATH)/include

# 64 bit if default for compiler setup
CFLAGS+= -DUSEOPENSSL -g -I. -I$(OSSLINC)
OSSLLIB=$(OSSLPATH)/lib

# This is to link with whatever we have, SSL crypto lib we put in static
#LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a
LIBS=-L$(OSSLLIB) $(OSSLLIB)/libcrypto.a -lz

chntpw: chntpw.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o chntpw chntpw.o ntreg.o edlib.o $(LIBS)

cpnt: cpnt.o
	$(CC) $(CFLAGS) -o cpnt cpnt.o $(LIBS)

reged: reged.o ntreg.o edlib.o
	$(CC) $(CFLAGS) -o reged reged.o ntreg.o edlib.o

#ts: ts.o ntreg.o
#	$(CC) $(CFLAGS) -nostdlib -o ts ts.o ntreg.o $(LIBS)

# -Wl,-t

.c.o:
	$(CC) -c $(CFLAGS) $<

.PHONY: all clean install

all: chntpw cpnt reged

clean:
	rm -f *.o chntpw chntpw.static cpnt reged reged.static *~

install: all
	install chntpw $(PREFIX)/bin/
	install cpnt $(PREFIX)/bin/
	install reged $(PREFIX)/bin/
