namespace Brainfuck;

use Brainfuck\Language\Interpreter;

class Program implements ProgramInterface
{
	private script = "";

	private input = [];

	private output = "";

	private debug = false;

	private interpreter;

	public function __construct(string! script = "", array! input = [])
	{
		let this->interpreter = new Interpreter();

		let this->script = script;
		let this->input = input;
	}

	public function getScript()
	{
		return this->script;
	}

	public function setScript(string! script)
	{
		let this->script = script;
		return this;
	}

	public function getInput()
	{
		return this->input;
	}

	public function setInput(array! input)
	{
		let this->input = input;
		return this;
	}

	public function getOutput()
	{
		return this->output;
	}

	public function setOutput(string! output)
	{
		let this->output = output;
		return this;
	}

	public function getDebug()
	{
		return this->debug;
	}

	public function setDebug(boolean! debug)
	{
		let this->debug = debug;
		return this;
	}

	public function execute()
	{
		if this->debug {
			echo "\r\n" . "Running: " . this->script . "\r\n";
			echo "\r\n" . "With input: " . json_encode(this->input) . "\r\n\r\n";
		}

		this->interpreter
			->setProgram(this)
			->run()
		;

		if this->debug {
			echo "\r\n" . "Output: " . this->output . "\r\n";
		}

		return this->getOutput();
	}
}