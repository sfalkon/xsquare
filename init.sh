#!/bin/bash

URL=https://lcdp.xsquare.ru/edu/files/pghs_xrad/6.4.5.5.5.5/xsquare.lcdp.6.4.5.5.5.5_release.zip
ARCHIVE=${URL##http*/}

if [ ! -f "${ARCHIVE}" ]; then
  echo "Download..."
  wget ${URL}
else
  echo "Skip. File ${ARCHIVE} is exist"
fi

if [ ! -d "xsquare" ]; then
  echo "Unzip..."
  unzip ${ARCHIVE}

  echo "Rename dir..."
  mv ${ARCHIVE%.zip} xsquare
else
  echo "Skip. Directory xsquare is exist"
fi

echo "Copy sql scripts..."
cp xsquare/db/appdb.xsquare.pgsql postgres/docker-entrypoint-initdb.d/02-appdb.xsquare.sql
cp xsquare/db/xraddb.xsquare.pgsql postgres/docker-entrypoint-initdb.d/03-xraddb.xsquare.sql

echo "Add database connection name..."
sed -i '1 s/^/\\c appdb\n/' postgres/docker-entrypoint-initdb.d/02-appdb.xsquare.sql
sed -i '1 s/^/\\c xraddb\n/' postgres/docker-entrypoint-initdb.d/03-xraddb.xsquare.sql

echo "Replace localhost to container name applications in nginx config files"
sed -i 's/127.0.0.1:8888/pghs:8888/' xsquare/etc/nginx/conf.d/pghs.xsquare.conf
sed -i 's/127.0.0.1:8889/xrad:8889/' xsquare/etc/nginx/conf.d/xrad.xsquare.conf
sed -i 's/127.0.0.1:8886/xreports:8886/' xsquare/etc/nginx/conf.d/pghs.xsquare.conf

echo "Replace localhost to container name database in app config files"
sed -i 's/127.0.0.1/postgres/g' xsquare/usr/local/xsquare.pghs/config.json
sed -i 's/127.0.0.1/postgres/g' xsquare/usr/local/xsquare.xrad/config.json

XDACURL=https://lcdp.xsquare.ru/edu/files/xdac/6.0.0.3/xsquare.xdac.6.0.0.3.deb
XDACARCHIVE=${XDACURL##http*/}

if [ ! -d "xdac" ]; then
  mkdir xdac
fi

cd xdac

if [ ! -f "${XDACARCHIVE}" ]; then
  echo "Download xdac..."
  wget ${XDACURL}
else
  echo "Skip. File ${XDACARCHIVE} is exist"
fi

if [ ! -d "usr" ]; then
  echo "Untar..."
  ar x ${XDACARCHIVE}
  tar -xzf data.tar.gz
else
  echo "Skip. Package is unpacked"
fi

echo "Replace localhost to container name database in app config files"
sed -i 's/127.0.0.1/postgres/g' usr/local/xsquare.xdac/config.json

cd ../

XREPORTURL=https://lcdp.xsquare.ru/edu/files/xreports/6.0.0.3/xsquare.xreports.6.0.0.3.zip
XREPORTARCHIVE=${XREPORTURL##http*/}

if [ ! -f "${XREPORTARCHIVE}" ]; then
  echo "Download..."
  wget ${XREPORTURL}
else
  echo "Skip. File ${XREPORTARCHIVE} is exist"
fi

if [ ! -d "xreport" ]; then
  echo "Unzip..."
  unzip ${XREPORTARCHIVE}

  echo "Rename dir..."
  mv ${XREPORTARCHIVE%.zip} xreport
else
  echo "Skip. Directory xreport is exist"
fi
