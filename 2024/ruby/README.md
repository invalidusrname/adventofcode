# Advent of Code

[![2024-ruby](https://github.com/invalidusrname/adventofcode/actions/workflows/2024-ruby.yaml/badge.svg)](https://github.com/invalidusrname/adventofcode/actions/workflows/2024-ruby.yaml)

Solutions for [Advent of Code 2024](https://adventofcode.com/2024) done in ruby

## Setup

    bundle install --binstubs

### Runnning tests

    ./bin/rspec spec

### Code style

Keep style up to date with rubocop:

    ./bin/rubocop --auto-gen-config
    # remove auto-correctable files from rubocop_todo.yml
    ./bin/rubocop -a
