# See https://github.com/spook/sshping

.PHONY=default sshping man
CFLAGS=-I /opt/homebrew/include -I ext -L /opt/homebrew/lib -lssh

default: sshping

sshping: bin/sshping

bin/sshping: src/sshping.cxx
	g++ -Wall -o bin/sshping $(CFLAGS) src/sshping.cxx

man: doc/sshping.8.gz

doc/sshping.8.gz: doc/sshping.8
	gzip -9cn $< > $@

doc/sshping.8: doc/sshping.pod
	if command -v pod2man &> /dev/null; then \
	  pod2man --section=8 -c "ssh-based ping test utility" -d 2018-03-13 -r v0.1.4 doc/sshping.pod doc/sshping.8; \
	else \
	  echo '*** Please install pod2man so that we can create the man page'; \
	  exit 2; \
	fi
