.PHONY: a41 a42 b41

BIN_DIR = bin

$(BIN_DIR)/%: %.rs
	rustc --out-dir $(BIN_DIR) $<

p%:
	@pbcopy <$*.rs

a41: $(BIN_DIR)/a41
	cat data/a41.1 | $(BIN_DIR)/a41
	cat data/a41.2 | $(BIN_DIR)/a41

a42: $(BIN_DIR)/a42
	cat data/a42.1 | $(BIN_DIR)/a42

b41: $(BIN_DIR)/b41
	cat data/b41.1 | $(BIN_DIR)/b41
	cat data/b41.2 | $(BIN_DIR)/b41
