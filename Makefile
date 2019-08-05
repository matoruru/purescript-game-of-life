build:
	spago build

clean:
	rm -rf output/

run:
	spago run -m Example.Console.Main -p Example/Console/*.purs
