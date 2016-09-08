# Pintos for Docker

Pintos in a Docker container

```bash
# 1) Pull the image
docker pull johnstarich/pintos

# 2) Test with the following:
docker run --rm -it johnstarich/pintos
root@52bab93f4f85:/pintos# pintos -q run alarm-multiple
# Expected output:
    <snip logs>
    (alarm-multiple) end
    Execution of 'alarm-multiple' complete.
    Timer: 616 ticks
    Thread: 0 idle ticks, 617 kernel ticks, 0 user ticks
    Console: 2954 characters output
    Keyboard: 0 keys pressed
    Powering off...
# End expected output

# 3) If the above worked, then you should be all set to run your own persistent Pintos container
docker run --detach --name pintos johnstarich/pintos
docker exec -it pintos bash
root@fee7c5371398:/pintos# echo 'Hello World!'
root@fee7c5371398:/pintos# exit

# To stop the pintos container
docker stop pintos

# If it is not stopping for some reason, then you can kill the container
docker kill pintos
```
