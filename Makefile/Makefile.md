# make

- `make` is a utility for building and maintaining groups of programs (and other types of files) from source code.

* The advantages of `make` over scripts is that we can specify the relationships between the elements of our program to make, and it knows through these relationships and timestamps exactly what steps need to be redone to produce the desired program each time. 
* Using this information, make can also optimize the build process avoiding unnecessary steps.

## Makefiles

* `make` searches the current directory for the makefile to use. 
* GNU make searches files for a file named one of `GNUmakefile`, `makefile`, and then `Makefile`, and runs the specified target(s) from that file.

* The makefile language is similar to declarative programming, in which necessary end conditions are described but the order in which actions are to be taken is not important. 

### Syntax Makefile:

```
target1 target2 target3 : prerequisite1 prerequisite2
        command1
        command2
        command3
```  
* One or more targets appear to the left of the colon and zero or more prerequisites can appear to the right of the colon. 
* If no prerequisites are listed to the right, then only the target(s) that do not exist are updated.   

* The comment character for make is the hash or pound sign, `#`. All text from the pound sign to the end of line is ignored. Comments can be indented and leading whitespace is ignored. 

* Long lines can be continued using the standard Unix escape character backslash `(\)`. It is common for commands to be continued in this way. It is also common for lists of prerequisites to be continued with backslash. 

Example:
```
jenkins:
	docker run -d biharimukund/jenkins
```

Executing `make`:

```
$ make
docker run -d biharimukund/jenkins
68bc5f318a769913b4e8019331d971681a151de1deb63e3e8d2de49414499240

$ docker ps
CONTAINER ID        IMAGE                  COMMAND                  CREATED              STATUS              PORTS                 NAMES
68bc5f318a76        biharimukund/jenkins   "/bin/tini -- /usr/l…"   19 seconds ago       Up 18 seconds       8080/tcp, 50000/tcp   frosty_morse

```

## Rules: Targets, Prerequisites and Commands

* Essentially a makefile contains a set of rules used to build an application. 
* The first rule seen by make is used as the default rule. 
* A rule consists of three parts: 
    - **target:** file or thing that must be made.
    - **prerequisites:**  files that must exist before the target can be successfully created. 
    - **command(s):** shell commands that will create the target from the prerequisites.

    ```
        target: prereq1 prereq2
            commands
    ``` 

* Each rule begins with a dependency line which defines a target followed by a colon (":") and optionally an enumeration of components (files or other targets) on which the target depends.    


```
jenkins: Dockerfile
	docker build -t biharimukund/jenkins .
```            
For this Makefile to execute successfully, Dockerfile must exist in the current directory.

### Execution order

- The order in which commands are executed by make are nearly the opposite to the order they occur in the makefile. This top-down style is common in makefiles. 
- Usually the most general form of target is specified first in the makefile and the details are left for later.


### Command lines

* With GNU make, the first command may appear on the same line after the prerequisites, separated by a semicolon:

```
hello: ; @echo "hello" 
```

* Each command is executed by a separate shell or command-line interpreter instance. 
* _Since operating systems use different command-line interpreters this can lead to unportable makefiles. For instance, GNU make by default executes commands with /bin/sh, which is the shell where Unix commands like cp are normally used._

* A rule may have no command lines defined. The dependency line can consist solely of components that refer to targets, for example:

```
realclean: clean distclean 
```

* Each command line **must begin with a tab character** to be recognized as a command. 

Command lines can have one or more of the following three prefixes:

1. a hyphen-minus (-), specifying that errors are ignored
2. an at sign (@), specifying that the command is not printed to standard output before it is executed
3. a plus sign (+), the command is executed even if make is invoked in a "do not execute" mode

Ignoring errors and silencing all echo output can also be obtained via the special targets ".IGNORE" and ".SILENT", respectively.

### Macros

*  Macros are usually referred to as variables when they hold simple string definitions.
* Macros in makefiles may be overridden in the command-line arguments passed to the make utility.The generic syntax for overriding macros on the command line is:

```
make MACRO="value" [MACRO="value" ...] TARGET [TARGET ...] 
```

* New macros are traditionally defined using capital letters:
```
MACRO = definition 
```

* A macro is used by expanding it. Traditionally this is done by enclosing its name inside $(). An equivalent form uses curly braces rather than parenthesis, i.e. ${}, which is the style used in BSD operating systems.

```
NEW_MACRO = $(MACRO)-$(MACRO2) 
```

* Macros can be composed of shell commands by using the command substitution operator, denoted by backticks ("` `").

```
YYYYMMDD = ` date ` 
```

* Makefiles can access any of a number of predefined internal macros, with "?" and "@" being the most common.

```
target: component1 component2
     echo $? contains those components, which need attention 
             (i.e. they ARE YOUNGER than current TARGET).
     echo $@ evaluates to current TARGET name from among those left of the colon.
```

