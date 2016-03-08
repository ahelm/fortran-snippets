# General Makefile which checks every every example by going into it's directory and building it
# recursively

# specify the make command
MAKE=/usr/bin/make
# general run command for each snippet
RUN=$(MAKE) -C $@ run

# SNIPPETS
SNIPPETS = interface-arbitaryDimensions

# all target should include every snippet which has to be build
all: $(SNIPPETS)

# list of all different snippets - each snippet should include 'make run'
.PHONY: $(SNIPPETS)
$(SNIPPETS):
	$(RUN)

clean:
	for dir in $(SNIPPETS); do \
		$(MAKE) -C $$dir clean; \
	done
