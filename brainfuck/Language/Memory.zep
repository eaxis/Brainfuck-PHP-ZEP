namespace Brainfuck\Language;

class Memory
{
	private memory = [];

	private pointer = 0;

	public function reset()
	{
		let this->memory = ["0": 0];
		let this->pointer = 0;

		return this;
	}

	public function inc()
	{
		this->write(this->read() < 255 ? this->read() + 1: 0);

		return this;
	}

	public function dec()
	{
		this->write(this->read() > 0 ? this->read() - 1 : 255);

		return this;
	}

	public function left()
	{
		let this->pointer -= 1;

		return this; 
	}

	public function right()
	{
		let this->pointer += 1;

		return this; 
	}

	public function dump()
	{
		var memclone = this->memory; // prevent changing original memory

		ksort(memclone);

		return json_encode(["memory": memclone, "pointer": this->pointer]);
	}

	public function read()
	{
		if !isset(this->memory[(string) this->pointer]) {
			this->write(0);
		}

		return this->memory[(string) this->pointer];
	}

	private function write(int! value = 0)
	{
		let this->memory[(string) this->pointer] = value;

		return this;
	}

}