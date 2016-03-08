# General Makefile which checks every every example by going into it's directory and building it
# recursively

# specify the make command
MAKE=/usr/bin/make

# all target should include every snippet which has to be build
all: interface-arbitaryDimensions


# list of all different snippets
.PHONY: interface-arbitaryDimensions
interface-arbitaryDimensions:
	$(MAKE) -C interface-arbitaryDimensions
