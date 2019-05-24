# docker-mariadb-mroonga
docker mariadb with mroonga, mecab-ipadic-neologd


## Functions

|target|function|note|
|---|---|---|
|Fulltext search|mariadb + mroonga||
|new word search|mecab-ipadic-neologd|https://github.com/neologd/mecab-ipadic-neologd |

* mecab-ipadic-neologd see
    * jp : http://diary.overlasting.net/2015-03-13-1.html
    * jp : http://kivantium.hateblo.jp/entry/2015/03/15/175612


## Install

```
docker pull sreinfrasystemjp/docker-mariadb-mroonga

git clone https://github.com/sreinfrasystemjp/docker-mariadb-mroonga.git
cd docker-mariadb-mroonga
docker run --rm \
  --name mariadb_mroonga \
  -p 13306:3306 \
  -v $(pwd)/mysql:/var/lib/mysql \
  sreinfrasystemjp/docker-mariadb-mroonga

docker exec -it mariadb_mroonga /bin/bash
    mysql -e "show engines"
    mysql < /usr/share/mroonga/install.sql
    mysql -e "show engines"
```


## Usage

```
docker run --rm \
  --name mariadb_mroonga \
  -p 13306:3306 \
  -v $(pwd)/mysql:/var/lib/mysql \
  sreinfrasystemjp/docker-mariadb-mroonga

mysql -S mysql/mysql.sock -u root \
-e "select mroonga_command('tokenize TokenMecab \"形態素解析で問題なのはなのはのような解析が難しい単語です\" NormalizerAuto') as text\G" \
| sed "s/[\[,]/\n/g" \
| grep value \
| sed "s/{\"value\"://g"
```

```
"形態素解析"
"で"
"問題"
"な"
"の"
"は"
"なのは"
"の"
"よう"
"な"
"解析"
"が"
"難しい"
"単語"
"です"
```


## Library's Version

|production|version|url|note|
|---|---|---|---|
|centos|7.6.1810|https://hub.docker.com/_/centos/ |docker image|
|mariadb|10.3.15|http://yum.mariadb.org/10.3/centos7-amd64 ||
|groonga|9.0.2-1|http://packages.groonga.org/centos/ ||
|mroonga|9.01-3|http://packages.groonga.org/centos/ ||
|gunosy/neologd-for-mecab(neologd/mecab-ipadic-neologd)|2019.05.24|https://github.com/gunosy/neologd-for-mecab ||


## Licence

Apache License 2.0

* Library's License

|production|license|license url|note|
|---|---|---|---|
|docker|Apache-2.0|https://github.com/moby/moby/blob/master/LICENSE ||
|centos|GPL,etc|http://mirror.centos.org/centos/7/os/x86_64/EULA ||
|mariadb|GPL-2.0|https://mariadb.com/kb/en/library/mariadb-license/ ||
|groonga|LGPL-2.1|http://groonga.org/ ||
|mroonga|LGPL-2.1|http://mroonga.org/ ||
|neologd/mecab-ipadic-neologd|Apache-2.0|https://github.com/neologd/mecab-ipadic-neologd/blob/master/COPYING ||


## Author

[ihironao](https://github.com/ihironao)
