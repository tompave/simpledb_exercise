#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/_setup.bash"

function test_hello_world() {
    local expected_output="Hello World!"
    local actual_output=$($PROGRAM hello)

    if [[ "$actual_output" != "$expected_output" ]]; then
        _fail "Hello World test failed. The program should handle the basic 'Hello World!' command."

        echo -e "
${_escape_bold}For input:${_escape_normal}

hello

${_escape_bold}the program should have produced this output:${_escape_normal}

$expected_output

${_escape_bold}but instead it was:${_escape_normal}

$actual_output

---------------------------------------------
        "
        return 1
    fi;

    _pass "The program and the tests are working! 🎉"
}

test_hello_world
