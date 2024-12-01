# Advent of Code

[![2021-ruby](https://github.com/invalidusrname/adventofcode/actions/workflows/2021-ruby.yaml/badge.svg)](https://github.com/invalidusrname/adventofcode/actions/workflows/2021-ruby.yaml)


Solutions for [Advent of Code 2021](https://adventofcode.com/2021) done in Ruby

## Setup

    bundle install --binstubs

### Runnning tests

    ./bin/rspec spec

### Code style

Keep style up to date with rubocop:

    ./bin/rubocop --auto-gen-config
    # remove auto-correctable files from rubocop_todo.yml
    ./bin/rubocop -a
