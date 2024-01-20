#!/usr/bin/env bash

jekyll_port=4000

function _stopJekyllMain()
{
  local jekyllPID
  local cmd

  jekyllPID="$(lsof -i :$jekyll_port|grep -i ruby|awk '{print $2}'|awk '{print $1}')"
  [ "${jekyllPID}" = "" ] && {
    echo "Jekyll server already stopped."
    exit 0
  }
  cmd="kill -9 ${jekyllPID}"
  echo "Executing: ${cmd}"
  eval "${cmd}"
}

_stopJekyllMain "$*"
