## Installation

## Brew
```shell
$ brew install ruby ruby-build
```

Override the system ruby by making it first on the path

```shell
export PATH=/opt/homebrew/Cellar/ruby/3.3.4/bin:$PATH
```

## Ruby Management (Not my favorite at the moment)

##### Install _rbenv_
```shell
$ brew install rbenv ruby-build
```

##### Install Ruby Versions

Note that there's issues with rebenv on M1 macs

```shell
$ rbenv install 3.3.4
```
##### Switch to a Ruby Version
```shell
$ rbenv local 3.0.0

# then rehash
$ rebenv rehash

# check version
$ ruby -v
```

##### Setup Shell Environment
Run this command to generate what needs to be added to ~/.zshrc
```shell
rbenv init
```

## Bundler

Bundler can be installed with specific versions of ruby that it supports. To install or update a bundler

```shell
$ gem update bundler

# OR
$ gem isntall bundler:<version>  # i.e. bundler:2.4.10
```

## Troubleshooting

See Github Version Compatibility
- https://pages.github.com/versions.json

### Error

```shell
/usr/local/bin/bundle:23:in `load': cannot load such file -- /usr/lib/ruby/gems/2.3.0/gems/bundler-1.16.1/exe/bundle (LoadError) from /usr/local/bin/bundle:23:in `<main>'
```

Make sure gems are up to date
````shell
gem -v
gem update
# or
# gem update --system
````

Re-run bundler
```shell
bundle install
```

If errors are encountered, may need to upgrade versions in Gemfile

