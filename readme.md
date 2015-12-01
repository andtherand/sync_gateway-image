# Couchbase Sync Gateway

This is a docker image that installs and configures a [couchbase sync gateway](http://developer.couchbase.com/documentation/mobile/1.1.0/develop/training/build-first-ios-app/add-sync-gateway.xml/index.html).

The gateway is installed via dpkg that's downloaded from the official source over at couchbase.com and is currently using the 1.1.1 release.

## Major differences
The major differences to the official image are:

- uses [mychiara/base image](https://github.com/mychiara/base) which in turn is derived from phusion/baseimage 
- configures a bucket by default

## TODO

- make the container aware of a server
- add some users that can read/write or just read.



## License
Copyright (c) mychiara | svs under the GPLv2 license.