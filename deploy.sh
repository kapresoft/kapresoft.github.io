#!/usr/bin/env bash

template_dir=../gh-pages/leap-day

cmd="cp assets/css/style.scss $template_dir/assets/css/style.scss"
echo running: $cmd
eval $cmd

cmd="cp _layouts/* $template_dir/_layouts/."
echo running: $cmd
eval $cmd

cmd="cp *.md $template_dir/."
echo running: $cmd
eval $cmd

echo; echo "$template_dir/:"
ls -ltr $template_dir/*.md

echo; echo "$template_dir/_layouts/:"
ls -ltr $template_dir/_layouts/*.html