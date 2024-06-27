SRC := $(wildcard *.fnl)
OUT := $(patsubst %.fnl,%.lua,$(SRC))

build: $(OUT)

%.lua: %.fnl fennel
	./fennel --compile $< > $@
