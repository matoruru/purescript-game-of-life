build:
	spago build

clean:
	rm -rf output/

run_1:
	spago run -m Example.Console.Main1 -p "Example/Console/*.purs"

run_2:
	spago run -m Example.Console.Main2 -p "Example/Console/*.purs"

run_3:
	spago run -m Example.Console.Main3 -p "Example/Console/*.purs"
