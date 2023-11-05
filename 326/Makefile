.PHONY: a b c d e f ca cb cc cd ce cf

BIN_DIR = bin
OPT_LEVEL = 0

$(BIN_DIR)/%: %.rs
	rustc -C opt-level=$(OPT_LEVEL) --out-dir $(BIN_DIR) $<

p%:
	@pbcopy <$*.rs

a: $(BIN_DIR)/a
	cat data/a.1 | $(BIN_DIR)/a
	cat data/a.2 | $(BIN_DIR)/a
	cat data/a.3 | $(BIN_DIR)/a

b: $(BIN_DIR)/b
	cat data/b.1 | $(BIN_DIR)/b
	cat data/b.2 | $(BIN_DIR)/b
	cat data/b.3 | $(BIN_DIR)/b

c: $(BIN_DIR)/c3
	cat data/c.1 | $(BIN_DIR)/c3
	cat data/c.2 | $(BIN_DIR)/c3
	cat data/c.3 | $(BIN_DIR)/c3

d: $(BIN_DIR)/d2
	cat data/d.0 | time $(BIN_DIR)/d2
	cat data/d.1 | time $(BIN_DIR)/d2
	cat data/d.2 | time $(BIN_DIR)/d2

e: $(BIN_DIR)/e
	cat data/e.1 | $(BIN_DIR)/e
	cat data/e.2 | $(BIN_DIR)/e
	cat data/e.3 | $(BIN_DIR)/e

f: $(BIN_DIR)/f
	cat data/f.1 | $(BIN_DIR)/f
	cat data/f.2 | $(BIN_DIR)/f
	cat data/f.3 | $(BIN_DIR)/f
	cat data/f.4 | $(BIN_DIR)/f
