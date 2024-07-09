#!/bin/bash

export ELM_HOME="elm-stuff"
npm install && cd /opt/build/repo/node_modules/elm-pages/generator/review && npx elm-json upgrade --unsafe --yes && cd /opt/build/repo/node_modules/elm-pages/generator/dead-code-review/ && npx elm-json upgrade --unsafe --yes && cd /opt/build/repo && npm run build

