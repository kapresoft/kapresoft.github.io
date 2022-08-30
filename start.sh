#!/usr/bin/env bash

function _runJekyll()
{
  local cmd="bundle exec jekyll serve --incremental --config _config.yml,_config_dev.yml"
  echo "executing: ${cmd} [DEV]"
  eval "${cmd}"
}
function _runJekyllProd()
{
  local cmd="bundle exec jekyll serve --incremental --config _config.yml"
  echo "executing: ${cmd} [PROD]"
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
  elif [[ "${opt}" = "-p" ]]; then
    _runJekyllProd
  elif [[ "${opt}" = "-pc" ]] || [[ "${opt}" = "-cp" ]]; then
    _cleanGenerated && _runJekyllProd
  else
    _runJekyll
  fi

}

_startJekyllMain "$*"
