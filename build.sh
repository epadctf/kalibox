
USERNAME="$USER"

sudo docker build \
    --build-arg USERNAME=$USERNAME  \
    --build-arg UID=$(id -u) \
    --build-arg GID=$(id -g) \
    -t kali \
    docker/

