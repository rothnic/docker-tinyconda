FROM debian:jessie

ENV PATH=/opt/conda/bin:$PATH

# all runtime requirements
RUN apt-get update && apt-get install -y --no-install-recommends \
    bzip2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    wget \
    ca-certificates && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.10.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.10.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.10.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.14.1 && \
    conda install conda-build && \
    conda remove tk --yes && \
    conda clean --yes --tarballs --packages --source-cache && \
    apt-get purge -y --auto-remove wget ca-certificates  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    find /opt/conda \
      \( -type d -a -name test -o -name tests \) \
      -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
      -exec rm -rf '{}' +

RUN for x in `ls /usr/share/locale | grep -v -i en | grep -v -i local`; \
      do rm -fr /usr/share/locale/$x; \
    done && \
    rm -fr /usr/share/locale/ca* \
        /usr/share/locale/den \
        /usr/share/locale/men \
        /usr/share/locale/wen \
        /usr/share/locale/zen && \
    rm -fr /usr/share/doc/* /usr/share/man/* /usr/share/groff/* /usr/share/info/* && \
    rm -rf /usr/share/lintian/* /usr/share/linda/* /var/cache/man/*
