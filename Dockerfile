FROM bitnami/minideb-runtimes:stretch

# Install required system packages and dependencies
RUN install_packages build-essential ca-certificates curl git libbz2-1.0 libc6 libffi6 libncurses5 libreadline7 libsqlite3-0 libssl1.1 libtinfo5 pkg-config unzip wget zlib1g
RUN wget -nc -P /tmp/bitnami/pkg/cache/ https://downloads.bitnami.com/files/stacksmith/python-3.8.1-0-linux-amd64-debian-9.tar.gz && \
    echo "1b753811d96b46a7900b1e9aded424d9a35c9b53983202aa0db456e43ab9b0f5  /tmp/bitnami/pkg/cache/python-3.8.1-0-linux-amd64-debian-9.tar.gz" | sha256sum -c - && \
    tar -zxf /tmp/bitnami/pkg/cache/python-3.8.1-0-linux-amd64-debian-9.tar.gz -P --transform 's|^[^/]*/files|/opt/bitnami|' --wildcards '*/files' && \
    rm -rf /tmp/bitnami/pkg/cache/python-3.8.1-0-linux-amd64-debian-9.tar.gz

ENV BITNAMI_APP_NAME="python" \
    BITNAMI_IMAGE_VERSION="3.8.1-r0" \
    PATH="/opt/bitnami/python/bin:$PATH"

RUN curl https://bootstrap.pypa.io/get-pip.py --output get-pip.py
RUN python ./get-pip.py

RUN pip install tornado prometheus_client uvloop

WORKDIR /
ADD kubeless.py .

CMD ["python", "/kubeless.py"]
