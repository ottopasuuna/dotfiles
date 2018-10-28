
.PHONY: link unlink

link:
	# ln -s $(PWD)/awesome $(HOME)/.config/awesome
	ln -s $(PWD)/ranger $(HOME)/.config/ranger
	ln -s $(PWD)/bin $(HOME)/bin

unlink:
	unlink $(HOME)/.config/ranger
	unlink $(HOME)/bin
