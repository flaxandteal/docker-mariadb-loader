FROM centos:centos7

MAINTAINER "Phil Weir" <phil.weir@flaxandteal.co.uk>

# Install MariaDB
ADD config/MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum update -y
RUN yum install -y MariaDB-client

VOLUME ["/data"]

RUN useradd -s /bin/false mysql

ADD config/mariadb-seed.sh /opt/bin/mariadb-seed.sh
RUN chmod u=rwx /opt/bin/mariadb-seed.sh
RUN chown mysql:mysql /opt/bin/mariadb-seed.sh

# run all subsequent commands as the mysql user
USER mysql

ENTRYPOINT ["/opt/bin/mariadb-seed.sh"]
