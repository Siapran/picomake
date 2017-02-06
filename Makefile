SOURCEDIR := src
SOURCES := $(shell find $(SOURCEDIR) -name '*.lua')
CART := $(shell find . -name '*.p8')

all: $(CART)

$(CART): code.lua
	p8tool build --lua code.lua $(CART)

code.lua: $(SOURCES)
	lua depend.lua

clean:
	rm code.lua