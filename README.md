# wsgis
to compute performance for {gunicon, uwsgi} x {falcon, flask, responder}
by using h2load

## Test Environment

| Env | Value |
| --- | -------------------- |
| OS | Ubuntu 18.04 on WSL2 |
| CPU | Intel(R) Core(TM) i7-7700K CPU @ 4.20GHz |
| Memory | Around 48GiB Free |
| HDD | 227GiB Avail |
| docker | version 18.09.7 |
| docker-compose | version 1.25.3 |

## Simple Usage

### build images

```
make
```


### do stress test

```
make stress
```


### do all above

```
make all
```
