SUBDIRS := bootloader

all: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

.PHONY: all $(SUBDIRS) clean

clean:
	$(MAKE) -C $(SUBDIRS) clean
