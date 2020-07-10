FROM python:2.7-slim-stretch

RUN apt update \
   && apt install -y --no-install-recommends curl ca-certificates python-dev libmariadbclient-dev gcc \
   && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
   && python get-pip.py \
   && rm get-pip.py \
   && pip install trac==1.2.6 babel pytz docutils pygments textile MySQL-python \
   && trac-admin /home/trac initenv trac sqlite:db/trac.db \
   && rm -rf /var/lib/apt/lists/*

VOLUME /home/trac

EXPOSE 3050

CMD ["/usr/bin/python", "/usr/local/bin/tracd", "--port", "3050", "--protocol=http", "--single-env", "/home/trac"]
