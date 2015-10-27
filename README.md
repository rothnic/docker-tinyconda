
# docker-tinyconda
A minimal base image for miniconda, starting with the smallest glibc compatible
docker image (debian), adding in miniconda runtime requirements, adding
miniconda, then cleaning out as much as possible that isn't required for a
dockerized python application.

## Overview

### What does this do for me?

* Gives you a configurable python runtime in a smallish docker image.
* Leverages conda, so widely used, compiled packages are simple and fast to install
* Formalizes an application structure utilizing conda **and** pip, dependent on
how you setup the environment. (see example `environment.yml`)
* Provides a deployment environment that is very similar to a local development
environment.

### Why not utilize a micro linux distribution?
Currently, there is a smaller miniconda distribution available that utilizes
busybox, but this can no longer be built at the moment due to the move from
glibc to musl c compiler. There is [some work](http://wiki.alpinelinux.org/wiki/Running_glibc_programs) to utilize glibc with alpine, but
this is immature at the moment, and likely to cause issues with conda at some
point. This could move to alpine if it is found to avoid issues with all the pre-built
binaries that conda is useful for in the first place.

## Tutorial

1. Most users should start with the [Docker Toolbox](https://www.docker.com/docker-toolbox)
2. Install [Miniconda](http://conda.pydata.org/miniconda.html) on local machine.
3. You will either create a new project (git repository), or use an existing one. Open a console and change to this directory.
4. enter `conda create -n <your_app_name> python=3` (or just python for python=2)
5. enter `source activate <your_app_name>`
6. Now install everything your app requires with `conda install <dependency>`. If conda doesn't have the requirement for your or your target platform (this debian image), you have these options:

  1. [Build the conda package](http://conda.pydata.org/docs/build_tutorials/pkgs.html) and upload to [Anaconda.org](anaconda.org). Then proceed to the next dependency.
  2. If the dependency is available through `pip` and doesn't require compilation, just install it via pip in your environment.
  3. (last resort) Extend this docker image to install required dependencies to compile the package, if required. The downside to this is rebuilds of the image will take much longer, compared to just downloading and installing a pre-compiled dependency via conda.

7. enter `conda env export > environment.yml` (see example app's file for reference)

  * Note: The `tinyconda-onbuild` image will automatically look for this file by name and install the requirements for you.

8. Start up docker (see [setup instructions](http://docs.docker.com/mac/step_one/) if needed)
9. Copy example app's Dockerfile to the root of your application's project
10. Modify the `CMD` line as needed to setup the default python script called. This is passed to the environment's python.

  * Changing CMD results in the default of `/path/to/env/python <CMD's arguments here>` being run.
  * Note, you can override CMD when running your image.
11. Build image with `docker build -t <your_app_name> .`
12. Run the app with `docker run --rm -it <your_app_name>` or `docker run --rm -it <your_app_name> /app/<script_name>.py arg1 arg2`

## Docker Images
The dockerfile is available for customization, but the most common use should be
by using the pre-built version from docker hub. This currently comes in two
flavors, `tinyconda` and `tinyconda-onbuild`.

* `rothnic/tinyconda:latest`
* `rothnic/tinyconda-onbuild:latest`

## Python/Miniconda Version
The miniconda version is python3, but your `environment.yml` will specify the
python version, and all package versions that you installed in your local environment
before executing the creation of the environment.yml file.
