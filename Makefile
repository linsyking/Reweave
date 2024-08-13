debug:
	mkdir -p build
	elm make src/Main.elm --output=build/main.js
	cp -f public/index.html .
	cp -f public/style.css build/style.css
	cp -f public/elm-canvas.js build/elm-canvas.js

release:
	mkdir -p build
	elm make src/Main.elm --output=build/main.js --optimize
	uglifyjs build/main.js -c -m --in-situ
	cp -f public/index.html .
	cp -f public/style.css build/style.css
	cp -f public/*.js build/

format:
	elm-format src/ --yes
	python tools/formatdoc.py ./src
	elm-format src/ --yes

clean:
	rm -rf build/

.PHONY: debug release format clean
