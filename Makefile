all:
	mkdir -p build
	elm make src/Main.elm --output=build/main.js
	cp -f public/index.html .
	cp -f public/style.css build/style.css
	cp -f public/elm-canvas.js build/elm-canvas.js

format:
	elm-format src/ --yes
	python tools/formatdoc.py ./src

clean:
	rm -rf build/
