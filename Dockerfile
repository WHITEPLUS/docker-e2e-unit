FROM selenium/standalone-chrome:3.3.1

USER root

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 \
 && apt-get -qqy install git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
 \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

USER seluser

#==================
# Anyenv
#==================
ENV HOME /home/seluser
ENV ANYENV_HOME $HOME/.anyenv
ENV ANYENV_ENV  $ANYENV_HOME/envs
RUN git clone https://github.com/riywo/anyenv $ANYENV_HOME
ENV PATH $ANYENV_HOME/bin:$PATH
RUN mkdir $ANYENV_ENV


#==================
# Python3
#==================
ARG PYTHON_VERSION=3.6.1
RUN anyenv install pyenv
ENV PATH $ANYENV_ENV/pyenv/bin:$ANYENV_ENV/pyenv/shims:$PATH
ENV PYENV_ROOT $ANYENV_ENV/pyenv
COPY require.txt /tmp/require.txt
RUN pyenv install $PYTHON_VERSION \
 && pyenv global $PYTHON_VERSION \
 && pyenv rehash \
 && pip install -r /tmp/require.txt

ENV PYTHONIOENCODING=utf-8
