#!/bin/bash
op get item github | jq -r '.details.sections[].fields|select(. != null)|select(.[].t=="git cli")[0].v'
