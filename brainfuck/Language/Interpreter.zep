namespace Brainfuck\Language;

use Brainfuck\ProgramInterface;

class Interpreter
{
	private program;

	private script;

	private input;

	private output;

	private memory;

	private debug = false;

	private counter = 0;

	public function __construct(<ProgramInterface> program = null)
	{
		let this->script = new Script();
		let this->input = new Input();
		let this->output = new Output();
		let this->memory = new Memory();

		if typeof program != "null" {
			let this->program = program;

			let this->debug = this->program->getDebug();

			this->script->setSource(this->program->getScript());
			this->input->setInput(this->program->getInput());
		}
	}

	public function getProgram()
	{
		return this->program;
	}

	public function setProgram(<ProgramInterface> program)
	{
		let this->program = program;

		let this->debug = this->program->getDebug();

		this->script->setSource(this->program->getScript());
		this->input->setInput(this->program->getInput());

		return this;
	}

	public function getOutput()
	{
		return this->output->read();
	}

	public function run()
	{
		if !(this->program instanceof \Brainfuck\ProgramInterface) {
			throw new \Exception("The program is not setted.");
		}

		this->output->reset();

		this->memory->reset();

		this->script->sanitize();

		this->script->checkSyntax();

		// Todo: optimize

		this->script->insertInputInSequence(this->input);

		this->interpret(this->script);

		this->program->setOutput(this->output->read());

		return this->program;
	}

	private function interpret(<Script> script, boolean! repeat = false)
	{
		var equipoise = 0;

		var interpretSlice = "";

		var value;

		let this->counter += 1;

		for value in script->getSequence() {

			if value == "[" {
				let equipoise += 1;

				if equipoise > 1 {
					let interpretSlice = interpretSlice . value;
				}

				continue;
			}

			if value == "]" {
				let equipoise -= 1;

				if equipoise > 0 {
					let interpretSlice = interpretSlice . value;
				}

				if equipoise == 0 && strlen(interpretSlice) > 0 {
					this->interpret(new Script(interpretSlice), true);
					let interpretSlice = "";
				}

				continue;
			}

			if equipoise != 0 {
				if this->memory->read() > 0 {
					let interpretSlice = interpretSlice . value;
				}

				continue;
			}

			switch (value) {
				case "+":
					this->memory->inc();
					break;
				case "-":
					this->memory->dec();
					break;
				case "<":
					this->memory->left();
					break;
				case ">":
					this->memory->right();
					break;
				case ".":
					if this->debug {
						this->debug(repeat, script->getSource());
					}

					this->output->write(chr(this->memory->read()));
			}
		}

		if repeat && this->memory->read() != 0 {
			this->interpret(script, true);
		}
	}

	private function debug(boolean! repeat = false, string! source = "")
	{
		var output = "";

		let output = output . "\r\n";

		let output = output . "\r\nsource: " . source;
		let output = output . "\r\noutput: " . chr(this->memory->read());
		let output = output . "\r\nloop: " . (repeat ? "true" : "false");
		let output = output . "\r\niteration: " . this->counter;
		let output = output . "\r\ndump: " . this->memory->dump();

		let output = output . "\r\n";

		echo output;

		return this;
	}
}