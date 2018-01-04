FROM selenium/standalone-chrome:3.8.1

USER root

RUN /bin/cp -f /usr/share/zoneinfo/Asia/Tokyo /etc/localtime \
 && apt-get update 1> /dev/null \
 && apt-get upgrade -y -q --no-install-recommends \
 \
 && apt-get -qqy install git make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev \
 \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

# ライセンスの承認を飛ばす
# https://serverfault.com/questions/583035/install-java-1-7-non-interatively-on-ubuntu-12-04
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | debconf-set-selections \
 && echo debconf shared/accepted-oracle-license-v1-1 seen true | debconf-set-selections \
# Javaのインストール
 && apt update 1> /dev/null \
 && apt install -y apt-file \
 && apt-file update \
 && apt-file search add-apt-repository \
 && apt install -y software-properties-common \
 && add-apt-repository -y ppa:webupd8team/java \
 && apt update 1> /dev/null \
 && apt -y install oracle-java9-installer \
 && rm -rf /var/lib/apt/lists/* /var/cache/apt/* /var/cache/oracle-jdk9-installer

USER seluser

#==================
# Anyenv
#==================
# ENV HOME /home/seluser
# ENV ANYENV_HOME $HOME/.anyenv
# ENV ANYENV_ENV  $ANYENV_HOME/envs
# RUN git clone https://github.com/riywo/anyenv $ANYENV_HOME
# ENV PATH $ANYENV_HOME/bin:$PATH
# RUN mkdir $ANYENV_ENV


#==================
# Python3
#==================
# ARG PYTHON_VERSION=3.6.1
# RUN anyenv install pyenv
# ENV PATH $ANYENV_ENV/pyenv/bin:$ANYENV_ENV/pyenv/shims:$PATH
# ENV PYENV_ROOT $ANYENV_ENV/pyenv
# COPY require.txt /tmp/require.txt
# RUN pyenv install $PYTHON_VERSION \
#  && pyenv global $PYTHON_VERSION \
#  && pyenv rehash \
#  && pip install -r /tmp/require.txt
#
# ENV PYTHONIOENCODING=utf-8
