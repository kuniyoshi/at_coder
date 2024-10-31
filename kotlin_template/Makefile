.PHONY: a b c d e f

p%:
	@pbcopy <src/src/$*.kt

a:
	cat data/a.1 | java -jar $^
	cat data/a.2 | java -jar $^

b:
	cat data/b.1 | java -jar $^
	cat data/b.2 | java -jar $^

c:
	cat data/c.1 | java -jar $^
	cat data/c.2 | java -jar $^

d:
	cat data/d.1 | java -jar $^
	cat data/d.2 | java -jar $^

e:
	cat data/e.1 | java -jar $^
	cat data/e.2 | java -jar $^

f:
	cat data/f.1 | java -jar $^
	cat data/f.2 | java -jar $^

bin/a.jar: src/a.kt
	kotlinc $^ -include-runtime -d $@

bin/b.jar: src/b.kt
	kotlinc $^ -include-runtime -d $@

bin/c.jar: src/c.kt
	kotlinc $^ -include-runtime -d $@

bin/d.jar: src/d.kt
	kotlinc $^ -include-runtime -d $@

bin/e.jar: src/e.kt
	kotlinc $^ -include-runtime -d $@

