
.PHONY: link unlink

link:
	ln -s $(CURDIR)/ranger $(HOME)/.config/ranger
	ln -s $(CURDIR)/bin $(HOME)/bin
	$(MAKE) -C dot-zsh link

unlink:
	unlink $(HOME)/.config/ranger
	unlink $(HOME)/bin
	$(MAKE) -C dot-zsh unlink
