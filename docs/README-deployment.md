## Deployment

See Github Version Compatibility
- https://pages.github.com/versions.json

### Github Deployment (Automatic)

Site is deployed using Github Pages
- See https://github.com/kapresoft/kapresoft.github.io/settings/pages

### Deploy to S3

```shell
# Build for production
$ ./start -pc

# Upload new :: live-<date-format>
# The following command will upload the contents 
# of _site folder to s3 path /live-2023-Dec-28
$ aws-k-upload live-2023-Dec-28
```

#### Spring Shell

Use spring shell command line tool to update to the new live-<date-format> path.

```shell
$ aws-k-shell
# The following command will redirect the CDN 
# to the new path content
cdn:> update-path live-2023-Dec-28
# then invalidate all paths
cdn:> invalidate /*
```

