WORKING_DIR = current
TEMPLATE_DIR = template
CONTEST = set_contest_number

start:
	rsync -av --delete "${TEMPLATE_DIR}" "${WORKING_DIR}"

end:
	mv "${WORKING_DIR}" "${CONTEST}"
