#! /usr/bin/env bash

# this script regexes the config values out of config.json
# the regex is a wee bit brittle, and expects each key:value
# to be on its own line.

function get_val {
    echo $(sed -n "s/^ *\"$1\": *\"*\([a-z0-9A-Z.]*\)\"* *,*/\1/p" ./config.json)
}

function config_vars {
    user=$(get_val User)
    pass=$(get_val Pass)
    host=$(get_val Host)
    port=$(get_val Port)
    dbname=$(get_val DBName)

    if [[ -z $user ]]; then
        echo 'No user found, add "User" to config.json'
        exit 0
    fi

    if [[ -z $pass ]]; then
        echo 'No password found, add "Pass" to config.json'
        exit 0
    fi

    if [[ -z $host ]]; then
        echo 'No host found, add "Host" to config.json'
        exit 0
    fi

    if [[ -z $port ]]; then
        echo 'No port found, add "Port" to config.json'
        exit 0
    fi

    if [[ -z $dbname ]]; then
        echo 'No dbname found, add "DBName" to config.json'
        exit 0
    fi
}

