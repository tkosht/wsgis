FROM python:3.10.6-slim-bullseye
MAINTAINER tkosht <takehito.oshita.business@gmail.com>

ENV TZ Asia/Tokyo
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update -y && apt-get upgrade -y \
    && apt-get install -y sudo build-essential curl \
        vim tmux tzdata locales dialog git openssh-server \
    && localedef -f UTF-8 -i ja_JP ja_JP.UTF-8

ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8" \
    TZ="Asia/Tokyo" \
    TERM="xterm"


RUN mkdir /var/run/sshd
RUN echo "PubkeyAuthentication yes" >> /etc/ssh/sshd_config
RUN echo "AuthorizedKeysFile workspace/.ssh/authorized_keys" >> /etc/ssh/sshd_config

# for h2load
RUN apt-get install -y g++ make binutils autoconf automake autotools-dev libtool pkg-config \
    zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
    libc-ares-dev libjemalloc-dev libsystemd-dev python3-dev
 # python-setuptools

ARG nghttp2=nghttp2-1.48.0
RUN python -m pip install cython
RUN curl -sSLO https://github.com/nghttp2/nghttp2/releases/download/v1.48.0/$nghttp2.tar.bz2 \
    && tar xf $nghttp2.tar.bz2 \
    && cd $nghttp2 \
    && ./configure \
    && make \
    && make install

# - upgrade system
RUN apt-get upgrade -y \
    && apt-get autoremove -y \
    && apt-get clean -y

    # && rm -rf /var/lib/apt/lists/*

COPY ./requirements.txt /requirements.txt
RUN pip install --upgrade pip \
    && pip install -r /requirements.txt

ARG user_id=1000
ARG group_id=1000
ARG user_name
ARG group_name

RUN groupadd --gid $group_id $group_name
RUN useradd -s /bin/bash --uid $user_id \
    --gid $group_id -m $user_name
ARG home_dir=/home/$user_name
COPY rc $home_dir

RUN echo $user_name ALL=\(root\) NOPASSWD:ALL \
    > /etc/sudoers.d/$user_name \
    && chmod 0440 /etc/sudoers.d/$user_name

RUN chown -R $user_name:$group_name $home_dir 
USER $user_name

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
