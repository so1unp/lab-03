CC=gcc
BIN=./bin
CFLAGS=-Wall -Werror -g

PROGS=fork mfork exec sh

.PHONY: all
all: $(PROGS)

%: %.c
	$(CC) -o $@ $< $(CFLAGS)

docs:
	pandoc -o README.txt -f gfm README.md
	pandoc -o README.html -f gfm README.md

test-exec: exec
	@./test-exec.sh ||:

test-fork: fork
	@./test-fork.sh ||:

test-mfork: mfork
	@./test-mfork.sh ||:

test: test-exec test-fork test-mfork

.PHONY: clean
clean:
	rm -f $(PROGS)
