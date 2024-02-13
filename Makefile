TEMPLATE_DIR = rust_template
CONTEST = set_contest_number
PROBLEM = a

usage:
	@echo '`add CONTEST=xxx` to add the contest'

add:
	@if [ -e "${CONTEST}" ]; then echo ${CONTEST} already exists; exit 1; fi
	rsync -av --delete "${TEMPLATE_DIR}"/ "${CONTEST}"/
	echo "- [${CONTEST}](${CONTEST}/README.md)" >>README.md
	perl -i -lpe 's{abcXXX}{abc$(CONTEST)}' $(CONTEST)/Cargo.toml
	perl -i -lpe '$$. != 1 && s{\]}{    "$(CONTEST)",\n]}' Cargo.toml

sample:
	fish bin/get_sample_inputs.fish $(CONTEST) $(PROBLEM)
