FROM python:3.12-slim-bullseye
LABEL maintainer="Karlos Helton Braga <Konkah>"

RUN apt update \
  && DEBIAN_FRONTEND=noninteractive apt install -y \
    net-tools \
    nano \
    curl \
    unzip \
    pkg-config \
    libssl-dev \
    libffi-dev \
    libjpeg-dev \
    libtiff-dev \
    libjpeg62-turbo-dev \
    zlib1g-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    build-essential \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

RUN apt upgrade -y \
  && apt autoremove -y \
  && apt autoclean -y

WORKDIR /var/www

RUN pip install pip-tools
COPY ./application/src/requirements.in requirements.in
RUN pip-compile --upgrade requirements.in
RUN pip install --no-cache-dir --upgrade -r requirements.txt

COPY ./application/src/main.py main.py

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
