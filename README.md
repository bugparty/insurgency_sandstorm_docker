# insurgency sandstorm steam server docker image

A docker container for running a dedicated Insurgency sandstorm server

## Quick start

Install the latest version of insurgency and create a volume to `/opt/insurgency` to persist the game files outside of the container.

```shell
$ docker run -ti --rm \
    -p 27102:27102/udp -p 27131:27131 \
    -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
    update
```

Create a `server.cfg` file in your game file volume at `insurgency/cfg/server.cfg`. 



Then start the server

```shell
$ docker run -ti --rm \
    -p 27102:27102/udp -p 27131:27131 \
    -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
```

## Updates

You can disable check for updates by specifying `run -console` as the startup command. The default command is `updaterun -console` which will check for updates and verify game files before starting the server.

```shell
$ docker run -ti --rm \
    -p 27102:27102/udp -p 27131:27131 \
    -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
    run -console
```

## Official Server Manual

https://docs.google.com/document/d/1GDLg5p9jjeIya7EgBk0ibzDtDlyQ-U_jpspOzby-JmM/edit
