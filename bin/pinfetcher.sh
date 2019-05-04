#!/bin/bash
echo "GETPIN" | pinentry | grep '^D' | sed 's/^D //'
