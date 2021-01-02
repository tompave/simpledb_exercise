#!/usr/bin/env bash

set -euo pipefail
source "$(dirname "$0")/_setup.bash"


function test_select_all_from_empty_dataset() {
    local input='SELECT *;'
    local expected_output="empty"

    _run_test "$input" "$expected_output"
}


function test_unknown_command() {
    local input='UPDATE;'
    local expected_output="unknown command UPDATE"

    _run_test "$input" "$expected_output"
}


function test_select_all_one_row_without_conditions() {
    local input='INSERT name: "Jane" surname: "Doe";
SELECT *;'
    local expected_output='id: 1 name: "Jane" surname: "Doe"'

    _run_test "$input" "$expected_output"
}


function test_select_all_two_rows_without_conditions() {
    local input='INSERT name: "Jane" surname: "Doe";
INSERT name: "Jessica" surname: "Fletcher";
SELECT *;'
    local expected_output='id: 1 name: "Jane" surname: "Doe"
id: 2 name: "Jessica" surname: "Fletcher"'

    _run_test "$input" "$expected_output"
}


function test_select_all_with_conditions() {
    local input='INSERT name: "Jane" surname: "Doe";
INSERT name: "Jessica" surname: "Fletcher";
INSERT name: "John" surname: "Doe";
SELECT * WHERE surname: "Doe";'
    local expected_output='id: 1 name: "Jane" surname: "Doe"
id: 3 name: "John" surname: "Doe"'

    _run_test "$input" "$expected_output"
}


function test_select_col_without_conditions() {
    local input='INSERT name: "Jane" surname: "Doe";
INSERT name: "Jessica" surname: "Fletcher";
INSERT name: "John" surname: "Doe";
SELECT name;'
    local expected_output='name: "Jane"
name: "Jessica"
name: "John"'

    _run_test "$input" "$expected_output"
}


function test_select_col_with_conditions() {
    local input='INSERT name: "Jane" surname: "Doe";
INSERT name: "Jessica" surname: "Fletcher";
INSERT name: "John" surname: "Doe";
SELECT name WHERE surname: "Doe";'
    local expected_output='name: "Jane"
name: "John"'

    _run_test "$input" "$expected_output"
}


test_select_all_from_empty_dataset
test_unknown_command
test_select_all_one_row_without_conditions
test_select_all_two_rows_without_conditions
test_select_all_with_conditions
test_select_col_without_conditions
test_select_col_with_conditions

_report_test_results
exit 0
