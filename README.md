# Pintos for Docker

Pintos in a Docker container

## Setup

1) Pull the image
```bash
docker pull johnstarich/pintos:v1.0
```

2) Test with the following:
```bash
docker run --rm -it johnstarich/pintos:v1.0
root@52bab93f4f85:/pintos# pintos -q run alarm-multiple
    <snip logs>
    (alarm-multiple) end
    Execution of 'alarm-multiple' complete.
    Timer: 616 ticks
    Thread: 0 idle ticks, 617 kernel ticks, 0 user ticks
    Console: 2954 characters output
    Keyboard: 0 keys pressed
    Powering off...
```

3) If the above worked, then you should be all set to run your own persistent Pintos container
```bash
docker run --detach --name pintos johnstarich/pintos:v1.0
docker exec -it pintos bash
root@fee7c5371398:/pintos# echo 'Hello World!'
root@fee7c5371398:/pintos# exit
```

## Using your code

To use your code in the container, mount your project directory into the container using Docker volumes.

To use your project directory instead of the current working directory, just replace `$PWD` with your project path.

```bash
docker run --detach --name pintos --volume $PWD:/pintos johnstarich/pintos:v1.0
```

## Miscellaneous Docker commands

To stop the pintos container: `docker stop pintos`

If it is not stopping for some reason, then you can kill the container: `docker kill pintos`
