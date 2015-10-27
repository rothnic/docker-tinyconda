FROM tinyconda

ADD /config_env.sh /config_env.sh

ONBUILD ADD ./environment.yml /app/environment.yml
ONBUILD RUN conda env create -f /app/environment.yml -n app
ONBUILD ADD . /app

ENTRYPOINT ["/opt/conda/envs/app/bin/python"]
