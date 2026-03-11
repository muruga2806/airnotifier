FROM python:3.6

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive TERM=linux

EXPOSE 8801

RUN apt-get update && \
    apt-get install -y --no-install-recommends git ca-certificates

RUN pip3 install pipenv

RUN git clone -b 2.x https://github.com/airnotifier/airnotifier.git /airnotifier

RUN mkdir -p /var/airnotifier/pemdir && \
    mkdir -p /var/log/airnotifier

WORKDIR /airnotifier

RUN pipenv install --deploy



VOLUME ["/var/log/airnotifier", "/var/airnotifier/pemdir"]

ENTRYPOINT ["/airnotifier/start.sh"]

