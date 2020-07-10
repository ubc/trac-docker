FROM debian:buster

RUN apt update \
   && apt install -y --no-install-recommends python curl ca-certificates \
   && curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py \
   && python get-pip.py \
   && rm get-pip.py \
   && pip install trac babel pytz docutils pygments textile \
   && trac-admin /home/trac initenv trac sqlite:db/trac.db \
   && rm -rf /var/lib/apt/lists/*

VOLUME /home/trac

EXPOSE 3050

CMD ["/usr/bin/python", "/usr/local/bin/tracd", "--port", "3050", "--protocol=http", "--single-env", "/home/trac"]
