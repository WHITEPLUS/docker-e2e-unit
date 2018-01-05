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

