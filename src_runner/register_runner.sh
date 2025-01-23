#!/bin/sh

waiting_container () {
    local command=$1
    local state=$2

    echo "Whaiting for container to $state"
    while ! eval "$command" | grep -q "$state"; do
        sleep 1
    done
    sleep 1
    echo "Container is $state"
}

up_container() {
    docker compose up -d
    waiting_container "docker compose ps" "Up"
}

down_container() {
    docker compose stop
    waiting_container "docker compose ps -a" "Exited"
}

restart_container() {
    docker compose restart
    waiting_container "docker compose ps" "Up"
}

register_runner () {
    local url=$1
    local token=$2

    docker exec cl_runner gitlab-runner register \
    --non-interactive \
    --url "$url" \
    --registration-token "$token" \
    --executor docker \
    --docker-image docker:dind
}

read -p "Input URL for your runner(default=https://gitlab.com): " URL
URL=${URL:-https://gitlab.com}
echo "$URL"

read -p "Iput TOKEN for your runner: " TOKEN

sudo rm -f ./config/config.toml
up_container
register_runner "$URL" "$TOKEN"
down_container
sudo nano ./config/config.toml
restart_container
