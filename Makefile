SUBDIRS = src test #examples tests

all: $(SUBDIRS)

$(SUBDIRS): src
	$(MAKE) -C $@

clean: $(SUBDIRS)
	rm -f *~
	for dir in $(SUBDIRS); do \
		$(MAKE) clean -C $$dir; \
	done

.PHONY: all clean $(SUBDIRS)
