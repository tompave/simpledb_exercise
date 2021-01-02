# SimpleDB coding interview

A simple language-agnostic coding interview exercise.

## Instructions

This repository contains a `test/` directory. The goal is to implement a program that makes the tests pass.

The exercise is designed to not assume anything about the implementation. The test suite is driven by black-box tests that exercise input and output, written in [Bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) and without external dependencies. The program can be implemented in any language, as long as it exists as an executable command that can be executed in a unix shell.

## Setup

Please clone this repository and work in your language of choice.

There is no need to modify any of the existing files.

First, verify that your local setup is correct by running, in the top-level direcotry of the repo:

```shell
test/hello_world.bash
```

That should produce an error. Run the following to make it green and verify that the provided example command can run.

```shell
PROGRAM=./example.bash test/hello_world.bash
```

Done that, implement your solution and run the tests to verify your progress:

```shell
export PROGRAM=./bin/yourprogram
test/black_box.bash
```

