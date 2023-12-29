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
