# How to get to work in a Corporate Security env

## Building the image

To build and install the local images had to add proxy arguments to the build instruction.

`docker build -t slate_app --build-arg http_proxy="http://proxy.corp:8080" --build-arg https_proxy="http://proxy.corp:8080" --build-arg no_proxy="*.corp" .`

## Hacking the Dockerfile

Had to add the following lines

### Vanilla (from https://github.com/lord/slate/wiki/Docker)
```
FROM ruby:onbuild
MAINTAINER Adrian Perez <adrian@adrianperez.org>
VOLUME /usr/src/app/source
EXPOSE 4567

RUN apt-get update && apt-get install -y nodejs \
&& apt-get clean && rm -rf /var/lib/apt/lists/*

CMD ["bundle", "exec", "middleman", "server", "--force-polling"]

```

### Corporate

[Dockerfile](Dockerfile) 

Had to add http_proxy, https_proxy, no_proxy settings and also copy across the Gemfile locations.


## Hacking the nameservers

In my particular example (running on an Ubuntu VM, Oracle Virtualbox) inside network.  Had to set the DNS nameservers specifically in `/etc/resolve.conf`


## Running the image

As per instruction `docker-compose up` runs on `http://localhost:4567`

