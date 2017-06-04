namespace Brainfuck\Language;

class Output
{
	private output = "";

	public function reset()
	{
		let this->output = "";

		return this;
	}

	public function read()
	{
		return this->output;
	}

	public function write(string! character)
	{
		let this->output = this->output . character;

		return this;
	}
}