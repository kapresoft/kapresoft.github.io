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

function _stopExisting()
{
  echo "Stopping existing instances" && ./stop.sh && sleep 2
}

# echo "Stopping existing instances" && ./stop.sh && sleep 2 && ./start.sh -c
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
    _stopExisting && _cleanGenerated && _runJekyll
  elif [[ "${opt}" = "-p" ]]; then
    _stopExisting && _runJekyllProd
  elif [[ "${opt}" = "-pc" ]] || [[ "${opt}" = "-cp" ]]; then
    _stopExisting && _cleanGenerated && _runJekyllProd
  else
    _stopExisting && _runJekyll
  fi

}

_startJekyllMain "$*"
