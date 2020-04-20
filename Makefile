SHELL := bash

CFLAGS += -D_GNU_SOURCE
CFLAGS += -g


ifneq ($(shell pkg-config --exists --print-errors egl; echo $$?),0)
  $(error Missing Package: egl)
endif
egl_CFLAGS := $(shell pkg-config --cflags egl)
egl_LDLIBS := $(shell pkg-config --libs egl)

m_CFLAGS :=
m_LDLIBS := -lm

dl_CFLAGS :=
dl_LDLIBS := -ldl

.PHONY: all
all: build/render

.PHONY: clean
clean:

LDLIBS := $(egl_LDLIBS) $(dl_LDLIBS) $(m_LDLIBS)

build:
	mkdir -p build

build/%.o: src/%.c | build
	$(CC) $(CFLAGS) -c -o $@ $<

build/%: build/%.o | build
	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)


buid/render: render.c
	$(CC) $(CFLAGS) -o $@ $^ $(LDLIBS)
