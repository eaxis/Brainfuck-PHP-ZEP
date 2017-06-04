namespace Brainfuck;

interface ProgramInterface
{
	public function getScript() -> string;

	public function setScript(string! script) -> <ProgramInterface>;

	public function getInput() -> array;

	public function setInput(array! input) -> <ProgramInterface>;

	public function getOutput() -> string;

	public function setOutput(string! output) -> <ProgramInterface>;

	public function getDebug() -> boolean;

	public function setDebug(boolean! debug) -> <ProgramInterface>;
}