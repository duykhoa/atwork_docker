FROM ubuntu:16.04

MAINTAINER Duy Khoa<duykhoa12t@gmail.com>

ENV RUBY_VERSIONS="2.2.5,2.3.0,2.3.1" \
    PACKAGES="git-core curl build-essential libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev" \
    PATH="$PATH:/usr/local/rvm/bin/rvm"

RUN   apt-get -y update && apt-get install -yq --fix-missing $PACKAGES &&  \
      gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 && \
      curl -sSL https://get.rvm.io | bash -s stable

RUN   /bin/bash -c "source /etc/profile.d/rvm.sh" && \
      /usr/local/rvm/bin/rvm install $RUBY_VERSIONS && \
      /usr/local/rvm/bin/rvm $RUBY_VERSIONS --verbose do gem install bundler

USER ninja

VOLUME ["/root/.gitconfig", "/root/workspace"]
EXPOSE 2300 3000 9292
