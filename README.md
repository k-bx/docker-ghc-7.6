Dockerfile for GHC 7.6 on Ubuntu 12.04
======================================

Building:

```
sudo docker build -t kobx/ghc-7.6 .
```

Running:

First, pull an image:

```
sudo docker pull kobx/ghc-7.6
```

Then run it:

```
sudo docker run -d -P --name ghc -v /home/username/workspace/myproj:/root/myproj:rw kobx/ghc-7.6
```

Connecting (password is "docker"):

```
➜  docker-ghc-7.6  sudo docker port ghc 22
0.0.0.0:49153
➜  docker-ghc-7.6  ssh root@127.0.0.1 -p 49153
root@127.0.0.1's password:
Welcome to Ubuntu 12.04 LTS (GNU/Linux 3.13.0-24-generic x86_64)

 * Documentation:  https://help.ubuntu.com/
Last login: Sat Apr 12 21:15:37 2014 from 172.17.42.1
root@e7bee61ffb12:~# ghci
GHCi, version 7.6: http://www.haskell.org/ghc/  :? for help
Loading package ghc-prim ... linking ... done.
Loading package integer-gmp ... linking ... done.
Loading package base ... linking ... done.
```

Stopping / removing running image:

```
sudo docker stop ghc
sudo docker rm ghc
```
