#!/bin/bash


function print-operating-dir () {
    echo "$(readlink -f "${0}")"
}

function print-self-path () {
    echo "$(readlink -f "${BASH_SOURCE[0]}")"
}

function print-self-dir () {
    echo "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"
}

print-operating-dir
print-self-dir
print-self-path