.PHONY: a b c d e f

p%:
	@pbcopy <src/bin/$*.rs

RELEASE=

a:
	cat data/a.1 | cargo run $(RELEASE) --bin a
	cat data/a.2 | cargo run $(RELEASE) --bin a

b:
	cat data/b.1 | cargo run $(RELEASE) --bin b
	cat data/b.2 | cargo run $(RELEASE) --bin b

c:
	cat data/c.1 | cargo run $(RELEASE) --bin c
	cat data/c.2 | cargo run $(RELEASE) --bin c

d:
	cat data/d.1 | cargo run $(RELEASE) --bin d
	cat data/d.2 | cargo run $(RELEASE) --bin d
	cat data/d.3 | cargo run $(RELEASE) --bin d

e:
	cat data/e.1 | cargo run $(RELEASE) --bin e
	cat data/e.2 | cargo run $(RELEASE) --bin e

f:
	cat data/f.1 | cargo run $(RELEASE) --bin f
	cat data/f.2 | cargo run $(RELEASE) --bin f
