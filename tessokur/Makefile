.PHONY: a41 a42 a43 a44 b41 b42 b43

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

a43: $(BIN_DIR)/a43
	cat data/a43.1 | $(BIN_DIR)/a43

a44: $(BIN_DIR)/a44
	cat data/a44.1 | $(BIN_DIR)/a44

b41: $(BIN_DIR)/b41
	cat data/b41.1 | $(BIN_DIR)/b41
	cat data/b41.2 | $(BIN_DIR)/b41

b42: $(BIN_DIR)/b42
	cat data/b42.1 | $(BIN_DIR)/b42

b43: $(BIN_DIR)/b43
	cat data/b43.1 | $(BIN_DIR)/b43
