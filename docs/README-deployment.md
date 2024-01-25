# Deployment

See Github Version Compatibility
- https://pages.github.com/versions.json

## Github Deployment (Automatic)

Site is deployed using Github Pages
- See https://github.com/kapresoft/kapresoft.github.io/settings/pages

## Releasing Locally

> Executing the following command to release. This will create the build.yml file and upload the site files to s3.

```shell
$ aws-k-release-local build-2024-Jan-24
```

You will be prompted a few times for the release:
```text
Release? y/[n]: y
Answer: y
executing: bundle exec jekyll clean
Configuration file: /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io/_config.yml
           Cleaner: Removing /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io/_site...
           Cleaner: Removing /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io/.jekyll-metadata...
           Cleaner: Removing .sass-cache...
executing: bundle exec jekyll build --incremental --config _config.yml,_config_dev.yml [DEV]
Configuration file: _config.yml
Configuration file: _config_dev.yml
            Source: /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io
       Destination: /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io/_site
 Incremental build: enabled
      Generating...
                    done in 7.238 seconds.
 Auto-regeneration: disabled. Use --watch to enable.
: ------ VARS ------- :
K_DATE_TEXT
K_UNIX_DATE
K_COMMIT_HASH
K_SITE_DEPLOY
: ---- DEPLOY FILE ---- :
date: Wed Jan 24 13:06:06 PST 2024 America/Los_Angeles
date-long: 1706130366
id: Kapresoft-Articles:manual-build
commit-hash: 561b57c3c0a04de85ab4963c84b560eb8cdbe1d8
build-number: manual
deploy-key: site/manual
: --------------------- :
Deploy file created: -rw-r--r--@ 1 devuser  staff  212 Jan 24 13:06 ./_site/build.yml
Project Dir: /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io
AWS Command: aws s3 cp /Users/devuser/sandbox/github/kapresoft/kapresoft.github.io/_site/. s3:/ksft/site/build-2024-Jan-24-DEV --recursive  --exclude "Gemfile*" --exclude "docs" --exclude ".*"
Execute? y/[n]: y
```

#### Spring Shell

> Use spring shell command line tool to update to the new live-<date-format> path.

```shell
$ aws-k-shell
# The following command will redirect the CDN 
# to the new path content
cdn:> ls
```

The files you released on the previous step should show up in the output below.

The `ls` command should produce the following results:

```text
[main] - INFO DefaultCDNService    : DistID: A1OROZ4NQJ44SP

CDN: https://x3prd15h23cxec.cloudfront.net

❯❯ Build-Version: build-2024-Jan-16-2 (Local Build)
  → Git-Hash : 63b48b9203e1482acfeb7bb5df1c4791ba58b522   Build-Date : Tue Jan 16 13:53:47 PST 2024
  → S3-URI   : s3:/ksft/site/build-2024-Jan-16-2

❯❯ Build-Version: build-2024-Jan-07 (Local Build) ✔ [LIVE]
  → Git-Hash : 1f9ce123ac6853275546a3adc4162b920c5bfb9b   Build-Date : Wed Jan 17 18:25:20 PST 2024
  → S3-URI   : s3:/ksft/site/build-2024-Jan-07

❯❯ Build-Version: build-2024-Jan-24 (Local Build)
  → Git-Hash : 561b57c3c0a04de85ab4963c84b560eb8cdbe1d8   Build-Date : Wed Jan 24 13:06:06 PST 2024
  → S3-URI   : s3:/ksft/site/build-2024-Jan-24-DEV
```

### Release the Build-Version

The following command defaults to dry-run mode:

```shell
cdn:/> release build-2024-Jan-24
```

#### Output

```text
[main] - INFO CDNCommands          : CDN Path found: /site/build-2024-Jan-24. Version is a valid candidate for release.
[main] - INFO CDNCommands          : PathPrefix to deploy: /site/build-2024-Jan-24
Success; DryRun=true
```

```shell
cdn:/> release build-2024-Jan-24
```

Once you are satisfied with what you see, just execute again with `--dryRun false` or `--dryRun 0`.

```shell
cdn:/> release build-2024-Jan-24 --dryRun 0
```

#### Output

```text
main] - INFO CDNCommands          : CDN Path found: /site/build-2024-Jan-24-DEV. Version is a valid candidate for release.
[main] - INFO CDNCommands          : DistID: A1OROZ4NQJ44SP
Success; etag=E3R3W4P4URRIIM Don't forget to invalidate-path on /*
```

### Invalidate the CDN Cache

```shell
cdn:> invalidate /*
```

