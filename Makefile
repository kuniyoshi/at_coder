WORKING_DIR = current
TEMPLATE_DIR = template
CONTEST = set_contest_number

usage:
	@echo '`start` to start contest'
	@echo 'to end contest, type `end CONTEST=xxx`'

start:
	rsync -av --delete "${TEMPLATE_DIR}"/ "${WORKING_DIR}"/

end:
	mv "${WORKING_DIR}" "${CONTEST}"
