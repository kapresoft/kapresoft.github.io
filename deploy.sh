#!/usr/bin/env bash

template_dir=~/sandbox/github/nfet/gh-pages/leap-day

dirs=( "_posts" "_layouts" "_includes" "assets/images" )

cmd="cp *.md $template_dir/."
echo running: $cmd
eval $cmd

cmd="cp assets/css/style.scss $template_dir/assets/css/style.scss"
echo running: $cmd
eval $cmd

for d in "${dirs[@]}"
do
    target_dir="$template_dir/${d}"
    if [ ! -d "${target_dir}" ]; then
        mkdir -p ${target_dir}
    fi
    cmd="cp ${d}/* ${target_dir}/."
    echo running: $cmd
    eval $cmd
done

echo; echo "$template_dir/:"
ls -ltr $template_dir/*.md

echo; echo "$template_dir/_layouts/:"
ls -ltr $template_dir/_layouts/*.html

echo; echo "$template_dir/_posts/:"
ls -ltr $template_dir/_posts/*
