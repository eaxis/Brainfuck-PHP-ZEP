# Brainfuck-PHP-ZEP

A Brainfuck interpreter for PHP powered by Zephir and delivered as a C-extension

## Installation

1. Download or compile this extension
2. Put this extension in the extensions directory
3. Enable by adding ```extension=brainfuck.so``` into php.ini

## Usage

### Program driven way
```
$script = '+++[>++++++++++<-]>+++.';

$program = new Brainfuck\Program();

$program->setScript($script);

echo $program->execute();
```
Output: ```!```

### Interpreter driven way

```
$script = '+++[>++++++++++<-]>+++.';

$program = new Brainfuck\Program();

$program->setScript($script);

$interpreter = new Brainfuck\Language\Interpreter();

$interpreter->setProgram($program);

echo $interpreter->run()->getOutput(); // $interpreter->run return your program
```
Output: ```!```

### With input

```
$script = '++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.>>,.>,.>,.>,.';
$input = ['G', 'u', 'y', 's'];

$program = new Brainfuck\Program();

$program->setScript($script);
$program->setInput($input);

echo $program->execute();
```
Output: ```Hello Guys```

### Debugging

When debugging is enabled every output command will prints current state of the interpreter.
This option is useful for debugging loops.

```
$script = '+[->+<.]';

$program = new Brainfuck\Program();

$program->setScript($script);
$program->setDebug(true);

$program->execute();
```

Print:
```
Running: +[->+<.]

With input: []

source: ->+<.
output: 
loop: true
iteration: 2
dump: {"memory":[0,1],"pointer":0}

Output: 
```

## Programs
### Hello World
```
++++++++++[>+++++++>++++++++++>+++>+<<<<-]>++.>+.+++++++..+++.>++.<<+++++++++++++
++.>.+++.------.--------.>+.>.
```
Output: ```Hello World!```
### PI Calculation
```
>+++++++++++++++
[<+>>>>>>>>++++++++++<<<<<<<-]>+++++[<+++++++++>-]+>>>>>>+[<<+++[>>[-<]<[>]<-]>>
[>+>]<[<]>]>[[->>>>+<<<<]>>>+++>-]<[<<<<]<<<<<<<<+[->>>>>>>>>>>>[<+[->>>>+<<<<]>
>>>>]<<<<[>>>>>[<<<<+>>>>-]<<<<<-[<<++++++++++>>-]>>>[<<[<+<<+>>>-]<[>+<-]<++<<+
>>>>>>-]<<[-]<<-<[->>+<-[>>>]>[[<+>-]>+>>]<<<<<]>[-]>+<<<-[>>+<<-]<]<<<<+>>>>>>>
>[-]>[<<<+>>>-]<<++++++++++<[->>+<-[>>>]>[[<+>-]>+>>]<<<<<]>[-]>+>[<<+<+>>>-]<<<
<+<+>>[-[-[-[-[-[-[-[-[-<->[-<+<->>]]]]]]]]]]<[+++++[<<<++++++++<++++++++>>>>-]<
<<<+<->>>>[>+<<<+++++++++<->>>-]<<<<<[>>+<<-]+<[->-<]>[>>.<<<<[+.[-]]>>-]>[>>.<<
-]>[-]>[-]>>>[>>[<<<<<<<<+>>>>>>>>-]<<-]]>>[-]<<<[-]<<<<<<<<]++++++++++.
```
Output: ```3.14070455282885```
### Quine (prints itself)
```
-->+++>+>+>+>+++++>++>++>->+++>++>+>>>>>>>>>>>>>>>>->++++>>>>->+++>+++>+++>+++>++
+>+++>+>+>>>->->>++++>+>>>>->>++++>+>+>>->->++>++>++>++++>+>++>->++>++++>+>+>++>+
+>->->++>++>++++>+>+>>>>>->>->>++++>++>++>++++>>>>>->>>>>+++>->++++>->->->+++>>>+
>+>+++>+>++++>>+++>->>>>>->>>++++>++>++>+>+++>->++++>>->->+++>+>+++>+>++++>>>+++>
->++++>>->->++>++++>++>++++>>++[-[->>+[>]++[<]<]>>+[>]<--[++>++++>]+[<]<<++]>>>[>
]++++>++++[--[+>+>++++<<[-->>--<<[->-<[--->>+<<[+>+++<[+>>++<<]]]]]]>+++[>+++++++
++++++++<-]>--.<<<]
```
Output:
```
-->+++>+>+>+>+++++>++>++>->+++>++>+>>>>>>>>>>>>>>>>->++++>>>>->+++>+++>+++>+++>++
+>+++>+>+>>>->->>++++>+>>>>->>++++>+>+>>->->++>++>++>++++>+>++>->++>++++>+>+>++>+
+>->->++>++>++++>+>+>>>>>->>->>++++>++>++>++++>>>>>->>>>>+++>->++++>->->->+++>>>+
>+>+++>+>++++>>+++>->>>>>->>>++++>++>++>+>+++>->++++>>->->+++>+>+++>+>++++>>>+++>
->++++>>->->++>++++>++>++++>>++[-[->>+[>]++[<]<]>>+[>]<--[++>++++>]+[<]<<++]>>>[>
]++++>++++[--[+>+>++++<<[-->>--<<[->-<[--->>+<<[+>+++<[+>>++<<]]]]]]>+++[>+++++++
++++++++<-]>--.<<<]
```
