#!/bin/sh

vagrant up --provider=virtualbox --install-provider
vagrant package --output devenv.box --provider=virtualbox
vagrant cloud auth login --token $1
vagrant cloud publish c2v4/devenv 1.0.0 virtualbox devenv.box  --force --release
