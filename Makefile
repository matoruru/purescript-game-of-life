build:
	spago build

clean:
	rm -rf output/

run:
	spago run -p Example/Console/Main.purs -m Example.Console.Main
