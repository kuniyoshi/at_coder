.PHONY: a41 a42 a43 a44 a45 a46 b41 b42 b43 b44 b45 b51

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

a45: $(BIN_DIR)/a45
	cat data/a45.1 | $(BIN_DIR)/a45

a46: $(BIN_DIR)/a46
	cat data/a46.1 | $(BIN_DIR)/a46

b41: $(BIN_DIR)/b41
	cat data/b41.1 | $(BIN_DIR)/b41
	cat data/b41.2 | $(BIN_DIR)/b41

b42: $(BIN_DIR)/b42
	cat data/b42.1 | $(BIN_DIR)/b42

b43: $(BIN_DIR)/b43
	cat data/b43.1 | $(BIN_DIR)/b43

b44: $(BIN_DIR)/b44
	cat data/b44.1 | $(BIN_DIR)/b44
	cat data/b44.2 | $(BIN_DIR)/b44

b45: $(BIN_DIR)/b45
	cat data/b45.1 | $(BIN_DIR)/b45

b51: $(BIN_DIR)/b51
	cat data/b51.1 | $(BIN_DIR)/b51
