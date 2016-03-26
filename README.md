# jiji_itamae

Initial setup recipe for [jiji](http://jiji2.unageanu.net/install/020300_install_server_to_docker.html) on Debian server.

## Setup

```
$ gem install itamae
```

Then prepare a server of Debian(jessie).

```
$ git clone git@github.com:tanukiti1987/jiji_itamae.git
$ cd jiji_itamae
$ USER_NAME=#{SERVER_USER_NAME} itamae ssh -h #{SERVER_IP} recipe.rb
```

