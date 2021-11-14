TEMPLATE_DIR = template
CONTEST = set_contest_number

usage:
	@echo '`add CONTEST=xxx` to add the contest'

add:
	rsync -av --delete "${TEMPLATE_DIR}"/ "${CONTEST}"/
	echo "- [${CONTEST}](${CONTEST}/README.md)" >>README.md
