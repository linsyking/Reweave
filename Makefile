all:
	mkdir -p build
# elm make src/Demo.elm

format:
	elm-format src/ --yes

clean:
	rm -rf build/