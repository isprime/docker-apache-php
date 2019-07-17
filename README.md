# PHP 5.3.29 + Apache Docker container

Change Web port if you need in .env file and type in console `make install`.

Access your PHP files through `127.0.0.1:YOUR_PORT_IN_ENV_FILE` if your are using linux or 
`192.168.99.100:YOUR_PORT_IN_ENV_FILE` if you use OSX.

`192.168.99.100` is your docker-machine ip address, you can get it by running `docker-machine ip YOURDOCKERMACHINENAME`
