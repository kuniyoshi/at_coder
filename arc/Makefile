TEMPLATE_DIR = template
CONTEST =

usage:
	@echo '`add CONTEST=xxx` to add the contest'

add:
	@if [ -e "${CONTEST}" ]; then echo ${CONTEST} already exists; exit 1; fi
	rsync -av "${TEMPLATE_DIR}"/ "${CONTEST}"/
