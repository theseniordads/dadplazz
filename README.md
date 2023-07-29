# Dadplazz

Full assembler source for the "Dadplazz" demo by The Senior Dads, which was released by The Senior Dads on the Atari Falcon 030 on the 20th January 1998.

## Specifications
* An Atari Falcon 030 with 4 megabytes of memory, TOS 4.04, and an internal hard drive.
* ... Alternatively, a decent emulator like Hatari, configured as above.
* Devpac 3 to assemble the code.

## How to assemble on an Atari Falcon 030
* Load "DADPLAZZ.S" into Devpac 3.
* Make sure settings are set to assemble to Motorola 68030!
* Assemble to executable file "DADPLAZZ.PRG".
* Set desktop to true colour mode low res.
* Run "DADPLAZZ.PRG".

## How to assemble on modern systems

This requires [VASM](http://sun.hasenbraten.de/vasm/) and [Vlink](http://www.compilers.de/vlink.html), which you can get for most modern systems.

To compile the source:

`vasmm68k_mot DADPLAZZ.S build/main.o -m68030 -Felf -noesc -quiet -no-opt`

To turn the compiled binary to an Atari executable:

`vlink build/main.o build/DADPLAZZ.PRG -bataritos`

## Folders
* `COMPILED` - Original compiled demo and accompanying [README](https://github.com/theseniordads/dadplazz/blob/master/COMPILED/README.1ST).
