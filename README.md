# insurgency sandstorm steam server docker image

A docker container for running a dedicated Insurgency sandstorm server

open box and use granted, no extra tweat needed

## Server Requirements

Processor: 2 gigahertz (GHz) or faster processor

RAM: 1.5 gigabyte (GB)

Hard disk space: 4 GB 

## Quick start

Install the latest version of insurgency and create a volume to `/opt/insurgency` to persist the game files outside of the container.

```shell
	
$ docker run -it --rm \
  -p 27102:27102/udp -p 27131:27131/udp \
  -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
   update

```

Create a `server.cfg` file in your game file volume at `insurgency/cfg/server.cfg`. 



Then start the server

```shell
$ docker run -it --rm \
  -p 27102:27102/udp -p 27131:27131/udp \
  -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
	   run -hostname="your server name"
```

## Updates

You can disable check for updates by specifying `run -console` as the startup command. The default command is `updaterun -console` which will check for updates and verify game files before starting the server.

```shell
$ docker run -it --rm \
  -p 27102:27102/udp -p 27131:27131/udp \
  -v $PWD/insurgency/:/opt/insurgency/ \
    bowmanhan/insurgency_sandstorm_server \
    run -console
```

## Official Server Manual

https://docs.google.com/document/d/1GDLg5p9jjeIya7EgBk0ibzDtDlyQ-U_jpspOzby-JmM/edit

## Best Server Config Files So Far

https://github.com/zWolfi/INS_Sandstorm
