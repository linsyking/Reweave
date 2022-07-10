all:
	mkdir -p build
	elm make src/Main.elm --output=build/main.js
	cp -f public/index.html .

format:
	elm-format src/ --yes

clean:
	rm -rf build/