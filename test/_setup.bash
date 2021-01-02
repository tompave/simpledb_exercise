# Import this file into the test files.

# -------------------------------------------------------------------
# Shell output utilities.

_escape_bold="$(tput bold)"
_escape_normal="$(tput sgr0)"
_escape_red='\033[31m'
_escape_green='\033[32m'

function _fail() {
    echo -en "${_escape_bold}${_escape_red}Fail:${_escape_normal} "
    echo -e  "${_escape_red}${1}${_escape_normal}"
}

function _pass() {
    echo -en "${_escape_bold}${_escape_green}Pass:${_escape_normal} "
    echo -e  "$_escape_green$1$_escape_normal"
}

# -------------------------------------------------------------------
# Test utilities.

# Counters for the tests.
test_counter=0
passed_counter=0
failed_counter=0

# Run a test.
#
function _run_test() {
    ((test_counter+=1))

    local test_name="${FUNCNAME[1]}"

    local input="$1"
    local expected_output="$2"

    # Invoke the program and capture its output.
    local actual_output=$($PROGRAM "$input")

    # Compare the values.
    if [[ "$actual_output" != "$expected_output" ]]; then
        ((failed_counter+=1))
        _fail "$test_name"

        echo -e "
${_escape_bold}For input:${_escape_normal}

$input

${_escape_bold}the program should have produced this output:${_escape_normal}

$expected_output

${_escape_bold}but instead it was:${_escape_normal}

$actual_output

---------------------------------------------
"

    else
        ((passed_counter+=1))
        _pass "$test_name"
    fi;
}

# Report the test results, then exit with a non-zero status code if any test failed.
#
function _report_test_results() {
    echo
    echo -e "Tests run: ${_escape_bold}${test_counter}${_escape_normal}, passed: ${_escape_green}${passed_counter}${_escape_normal}, failed: ${_escape_red}${failed_counter}${_escape_normal}."
    echo

    if [[ "$failed_counter" -gt "0" ]]; then
        exit 1
    fi
}

# -------------------------------------------------------------------
# Test setup checks.

# Ensure that the variable exists even when undefined, to bypass the shell
# errors and get to the more informative errors produced below.
PROGRAM="${PROGRAM:-}"

# Some help to set things up.
# Check if the command under test has been configured and it can be run.

if [[ -z $PROGRAM ]]; then
    _fail "\$PROGRAM is unset. Set it to the path of the executable being tested. Fix it with 'export PROGRAM=/path/to/file'."
    return 1
fi;

if [[ ! -e $PROGRAM ]]; then
    _fail "\$PROGRAM is set to '$PROGRAM', but no file exists at that path."
    return 1
fi;

if [[ ! -x $PROGRAM ]]; then
    _fail "\$PROGRAM is set to '$PROGRAM', but the file is not executable. Fix it with 'chmod 755 $PROGRAM'."
    return 1
fi;

# -------------------------------------------------------------------
