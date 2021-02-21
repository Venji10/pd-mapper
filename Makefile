PD_MAPPER := pd-mapper

CFLAGS := -Wall -g -O2
LDFLAGS := -lqrtr

prefix ?= /usr
bindir := $(prefix)/bin
servicedir := $(prefix)/lib/systemd/system

SRCS := pd-mapper.c \
        assoc.c \
        json.c \
	servreg_loc.c

OBJS := $(SRCS:.c=.o)

$(PD_MAPPER): $(OBJS)
	$(CC) -o $@ $^ $(LDFLAGS)

install: $(PD_MAPPER)
	@install -D -m 755 $(PD_MAPPER) $(DESTDIR)$(bindir)/$(PD_MAPPER)
	@install -D -m 755 pd-mapper.initd $(DESTDIR)etc/init.d/$(OUT)
	@install -D -m 644 LICENSE $(DESTDIR)usr/share/licenses/$(OUT)/COPYING

clean:
	rm -f $(PD_MAPPER) $(OBJS)
