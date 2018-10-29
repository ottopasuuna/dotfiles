
.PHONY: link unlink

link:
	ln -s $(CURDIR)/ranger $(HOME)/.config/ranger
	ln -s $(CURDIR)/bin $(HOME)/bin
	$(MAKE) -C dot-zsh link
	$(MAKE) -C dot-vim link
	$(MAKE) -C dot-awesome link
	$(MAKE) -C dot-xorg link
	$(MAKE) -C dot-misc link

unlink:
	unlink $(HOME)/.config/ranger
	unlink $(HOME)/bin
	$(MAKE) -C dot-zsh unlink
	$(MAKE) -C dot-vim unlink
	$(MAKE) -C dot-awesome unlink
	$(MAKE) -C dot-xorg unlink
	$(MAKE) -C dot-misc unlink
