build:
	spago build

clean:
	rm -rf output/

run:
	spago run -m Example.Console.Main -p "Example/Console/*.purs"

run_2:
	spago run -m Example.Console.Main2 -p "Example/Console/*.purs"
