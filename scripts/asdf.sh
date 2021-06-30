#!/usr/bin/env bash

asdf plugin-add nodejs
asdf install nodejs latest
asdf global nodejs latest

asdf plugin-add python
asdf install python latest:2
asdf install python latest
asdf global python latest latest:2
