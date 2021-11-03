#!/usr/bin/env bash

function _runJekyll()
{
  local cmd="bundle exec jekyll serve --incremental $*"
  echo "executing: ${cmd}"
  eval "${cmd}"
}

function _cleanGenerated()
{
  local cmd="bundle exec jekyll clean"
    echo "executing: ${cmd}"
    eval "${cmd}"
}

function _startJekyllMain()
{
  local sname="start.sh"
  local opt="$1"
  echo "opt: ${opt}"

  if [[ "${opt}" = "-h" ]]; then
    echo "usage: ${sname} <option>"
    echo "  ./${sname}        : start server in incremental mode"
    echo "  ./${sname} -c     : clean before starting server"
    echo "  ./${sname} -h     : show this help text"
  elif [[ "${opt}" = "-c" ]]; then
    _cleanGenerated && _runJekyll
  else
    _runJekyll
  fi

}

_startJekyllMain $*
