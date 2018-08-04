
CNAME="my-kali"
DATA_PATH="$1"
SCRIPTS="$2"

USERNAME="$USER"
HNAME="$CNAME"

XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
# show X authorisation entries for $DISPLAY in numerical format, 
# mask the first 2 octets with ffff, merge these entries into .docker.xauth
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -

sudo docker run -it --hostname "$HNAME" --name "$CNAME"\
    -w="/root" \
    --rm \
    --net=host \
    --volume="$DATA_PATH":/root/data \
    --volume="$SCRIPTS":/root/scripts \
    --volume="$XSOCK":"$XSOCK":rw \
    --volume="$XAUTH":"$XAUTH":rw \
    --env="XAUTHORITY=${XAUTH}" \
    --env="DISPLAY=$DISPLAY" \
    kali sh -c "stty cols $(tput cols) rows $(tput lines) && bash"
