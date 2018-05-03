#!/usr/bin/env bash

find app src test *.yaml | entr -cr stack test
