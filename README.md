# [DevOps](https://gitlab.com/skobyalko/devops)

## Runner

Edit compose.yml for your purposes.

Dependencies:

- docker:

    [install docker](https://docs.docker.com/engine/install/)

- make:

    $ sudo apt install make

First running:

    $ make first_launch

Set your runner-url and runner-token

If you want edit the runner config

For example:

    [runners.docker]
        # change privelegies
        privileged = true
        # pass the docker socket to the runner itself
        volumes = ["/cache", "/var/run/docker.sock:/var/run/docker.sock"]
        # set network mode
        network_mode = "ypur_network_name"

Whait until it's finished


After the runner is launched, a config directory will appear that will contain the config.toml of the runner running in the container. It can be edited and by restarting the runner container, the settings will be applied.






