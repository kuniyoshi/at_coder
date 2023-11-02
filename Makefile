TEMPLATE_DIR = rust_template
CONTEST = set_contest_number

usage:
	@echo '`add CONTEST=xxx` to add the contest'

add:
	@if [ -e "${CONTEST}" ]; then echo ${CONTEST} already exists; exit 1; fi
	rsync -av --delete "${TEMPLATE_DIR}"/ "${CONTEST}"/
	echo "- [${CONTEST}](${CONTEST}/README.md)" >>README.md
