SUBCLEAN = $(addsuffix .clean,$(SUBDIRS))
SUBREALLYCLEAN = $(addsuffix .reallyclean,$(SUBDIRS))

all: $(SUBDIRS)

clean: $(SUBCLEAN)

reallyclean: $(SUBREALLYCLEAN)

$(SUBDIRS):
	$(MAKE) -C $@

$(SUBCLEAN): %.clean:
	$(MAKE) -C $* clean

$(SUBREALLYCLEAN): %.reallyclean:
	$(MAKE) -C $* reallyclean

.PHONY: all clean reallyclean $(SUBDIRS) $(SUBCLEAN) $(SUBREALLYCLEAN)
