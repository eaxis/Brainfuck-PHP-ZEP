namespace Brainfuck\Language;

class Script
{
	private source;

	private sequence;

	public function __construct(string! source = "")
	{
		this->setSource(source);

		let this->sequence = str_split(source);
	}

	public function getSource()
	{
		return this->source;
	}

	public function setSource(string! source)
	{
		let this->source = source;

		let this->sequence = str_split(source);

		return this;
	}

	public function getSequence()
	{
		return this->sequence;
	}

	public function setSequence(array! sequence)
	{
		let this->sequence = sequence;

		let this->script = implode("", sequence);

		return this;
	}

	public function sanitize()
	{
		this->setSource(preg_replace("/[^\[\]\-+<>,.]+/", "", this->source));

		return this;
	}

	public function checkSyntax()
	{
		var value;
		var opened = 0, closed = 0;

		for value in this->sequence {
			if value == "[" {
				let opened += 1;
			}

			if value == "]" {
				let closed += 1;
			}

			if closed > opened {
				throw new \Exception("The script contains unmatched brackets.");
			}
		}

		if closed != opened {
			throw new \Exception("The script contains unmatched brackets.");
		}

		return this;
	}

	public function insertInputInSequence(<Input> input)
	{
		var tempSequence = [];

		var key, value;

		for key, value in this->sequence {
			if value == "," {
				var character = input->read();

				if typeof character == "null" {
					throw new \Exception("The script requires for more inputs than was provided (@" . (key + 1) . ").");
				}

				var insertInSequence = str_split(this->getIncrementsByCharacter(character));

				let tempSequence = array_merge(tempSequence, insertInSequence);
			} else {
				let tempSequence[] = value;
			}
		}

		this->setSequence(tempSequence);

		return this;
	}

	private function getIncrementsByCharacter(string! character)
	{
		return str_repeat("+", ord(character));
	}
}