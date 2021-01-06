#!/bin/bash

V="2.2"

curl -o /tmp/autopkg.pkg -fsSL "https://github.com/autopkg/autopkg/releases/download/v$V/autopkg-$V.pkg"
installer -pkg /tmp/autopkg.pkg -target /

exit 0
