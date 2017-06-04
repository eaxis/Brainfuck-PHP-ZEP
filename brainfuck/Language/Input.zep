namespace Brainfuck\Language;

class Input
{
	private input = [];

	private pointer = 0;

	public function __construct(array! input = [])
	{
		let this->input = input;
	}

	public function getInput()
	{
		return this->input;
	}

	public function setInput(array! input)
	{
		let this->input = input;
		let this->pointer = 0;
		return this;
	}

	public function read()
	{
		var value = null;

		if isset this->input[this->pointer] {
			let value = this->input[this->pointer];
			let this->pointer++;
		}

		return value;
	}
}