#!/usr/bin/env bash



function _stopJekyllMain()
{
  local jekyllPID
  local cmd

  jekyllPID="$(pgrep jekyll)"
  [ "${jekyllPID}" = "" ] && {
    echo "Jekyll server already stopped."
    exit 0
  }
  cmd="kill -9 ${jekyllPID}"
  echo "Executing: ${cmd}"
  eval "${cmd}"
}

_stopJekyllMain "$*"
