#!/bin/bash

rm ./workspaces.txt

tmc workspace list -o json | jq ".workspaces[].fullName.name" | sed 's/"//g' > workspaces.txt