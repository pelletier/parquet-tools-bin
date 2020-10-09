# parquet-tools-bin

This reprository contains a pre-compiled version of parquet-tools, with
launcher scripts.

## usage

1. Add `parquet-tools-bin` to your `PATH`.
2. Run one of:
  * Windows: `mklink parquet-tools parquet-tools.bat`
  * Linux: `ln -s parquet-tools parquet-tools.sh`

Then use the `parquet-tools` command from anywhere.

## docker

```
docker run -v /path/do/dir:/data -ti parquet-tools meta /data/file-in-dir.parquet
```
