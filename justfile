# use nushell
self := justfile_directory()
set shell := ['nu', '-c']

# list recipes
[private]
default:
	@just --list

# generate example images
gen:
	typst compile \
		--root {{ self }} \
		examples/main.typ \
		examples/expample{n}.png

	ls examples/ \
		| where name =~ '^example\d.png$' \
		| get name \
		| each {|it| magick convert $it -crop 1191x200++0+0 $it}

# run a minimal test harness
test filter='':
	@{{ self }}/tests/run.nu '{{ filter }}'