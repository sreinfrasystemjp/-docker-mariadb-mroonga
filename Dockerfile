################################
FROM gunosy/neologd-for-mecab:2019.05.24 as neologd
LABEL maintainer="https://sre-infra-system.jp/"

################################
FROM centos:7.6.1810
LABEL maintainer="https://sre-infra-system.jp/"

ENV GROONGA_RELEASE_VERSION 1.4.0-1
ENV MARIADB_VERSION 10.3.15
ENV GROONGA_VERSION 9.0.2
ENV MROONGA_VERSION 9.01

COPY MariaDB.repo /etc/yum.repos.d/MariaDB.repo
RUN yum update -y && \
    yum install -y \
      which \
      http://packages.groonga.org/centos/groonga-release-${GROONGA_RELEASE_VERSION}.noarch.rpm \
    && \
    yum install -y \
      MariaDB-common-${MARIADB_VERSION} \
      MariaDB-compat-${MARIADB_VERSION} \
      MariaDB-client-${MARIADB_VERSION} \
      MariaDB-server-${MARIADB_VERSION} \
    && \
    yum install -y --enablerepo=epel \
      groonga-${GROONGA_VERSION} \
      groonga-tokenizer-mecab-${GROONGA_VERSION} \
      groonga-normalizer-mysql-${GROONGA_VERSION} \
      mariadb-10.3-mroonga-${MROONGA_VERSION} \
    && \
    yum clean all

COPY entrypoint.sh /root/entrypoint.sh
RUN chmod +x /root/entrypoint.sh

COPY --from=neologd /usr/lib/mecab/dic/neologd /usr/lib64/mecab/dic/neologd
RUN sed -i "s|/usr/lib64/mecab/dic/ipadic|/usr/lib64/mecab/dic/neologd|" /etc/mecabrc

EXPOSE 3306
ENTRYPOINT ["/root/entrypoint.sh"]
