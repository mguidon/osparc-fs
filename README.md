# Playground for S3 storage file system mounts in osparc

## s3fs

https://github.com/s3fs-fuse/s3fs-fuse

## goofys

https://github.com/kahing/goofys


## how to use

```
make build
make shell
```

Runs container with bucket mounted in ```/opt/s3fs/bucket``` or ```/opt/goofys/bucket```.

The minio command line client ```mc``` is also included for testing and benchmarking. See 
https://docs.min.io/docs/minio-client-complete-guide.html
Credentials are taken from ```.env```. Example in ```.env-template```.

## benchmark

```
make bench
```
Creates random files with sizes ranging from 1 MB to 1024 MB. Uploads/Donwload via mount and minio client.

**Note**: Turn cache off to get real download times