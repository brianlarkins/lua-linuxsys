DESTDIR=
LUAVERS=5.4
#LUAVERS=5.3
LUALIB=/usr/lib/lua/$(LUAVERS)
LUAPKG=/usr/share/lua/$(LUAVERS)
DOC=/usr/share/doc/lua-linuxsys

NAME= linuxsys
CFLAGS= $(WARN) -O2 -fPIC -g
WARN= -ansi -pedantic -Wall

ifneq ($(LUAVERS), 5.4)
	LIB= $(NAME)_c
else 
	LIB= $(NAME)
endif

T= $(LIB).so
OBJS= $(LIB).o

all:	$T

o:	$(LIB).o

so:	$T

linuxsys.c: linuxsys_c.c
	@ln -s $< $@

$T:	$(OBJS)
	$(CC) -o $@ -shared $(OBJS)

clean:
	rm -f $(OBJS) $T core core.* a.out

install: all
	mkdir -p            $(DESTDIR)/$(LUALIB)
	install $T          $(DESTDIR)/$(LUALIB)
	if [ ${LUAVERS} != "5.4" ];then \
	  mkdir -p            $(DESTDIR)/$(LUAPKG);\
	  install $(NAME).lua $(DESTDIR)/$(LUAPKG);\
	fi
	mkdir -p            $(DESTDIR)/$(DOC)
	install README.md   $(DESTDIR)/$(DOC)
