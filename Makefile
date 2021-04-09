CC=gcc
BIN=./bin
CFLAGS=-Wall -Werror -g

PROGS=fork mfork exec sh

.PHONY: all
all: $(PROGS)

%: %.c
	$(CC) -o $@ $< $(CFLAGS)

test-exec: exec
	@./test-exec.sh

test-fork: fork
	@./test-fork.sh

test-mfork: mfork
	@./test-mfork.sh

test: test-exec test-fork test-mfork

.PHONY: clean
clean:
	rm -f $(PROGS)
