#!/bin/bash

pip_packages=(
	proselint
	tornado
	virtualenv
)

pip install "${pip_packages[@]}"
