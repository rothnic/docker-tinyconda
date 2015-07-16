
## docker-tinyconda
A minimal base image for miniconda, starting with the smallest glibc compatible docker image (debian), adding in miniconda runtime requirements, adding miniconda, then cleaning out as much as possible that isn't required for a dockerized python application.

Currently, there is a smaller miniconda distribution available that utilizes busybox, but this can no longer be built at the moment, due to the move from glibc to musl c compiler. There is some work to utilize glibc with alpine, but this is immature at the moment.

The dockerfile is available for customization, but the most common use should be by using the pre-built version from docker hub.

`rothnic/tinyconda:latest`
