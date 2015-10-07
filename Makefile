SUBDIRS = src examples #tests

all: $(SUBDIRS)

$(SUBDIRS):
	$(MAKE) -C $@

clean: $(SUBDIRS)
	rm -f *~
	for dir in $(SUBDIRS); do \
		$(MAKE) clean -C $$dir; \
	done

.PHONY: all clean $(SUBDIRS)
