FROM alpine:latest

RUN apk update && \
	apk add --no-cache --update bash && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	mkdir -p /aria2-ng && \
	mkdir -p /usr/local/nginx/html && \
	apk add --no-cache --update aria2 && \
	apk add --no-cache wget && \
	apk add --no-cache curl && \
    export ARIA_NG_VERSION=$(curl -s https://api.github.com/repos/mayswind/AriaNg/releases/latest | grep tag_name | cut -f4 -d "\"") && \
    wget https://github.com/mayswind/AriaNg/releases/download/${ARIA_NG_VERSION}/AriaNg-${ARIA_NG_VERSION}.zip -O /aria2-ng/archive.zip && \
    cd /aria2-ng && \
    unzip archive.zip && \
    rm archive.zip && \
    apk del wget && \
    apk add --update nginx && \
    rm -rf /var/cache/apk/*

ADD config/start.sh /conf-copy/start.sh
ADD config/aria2.conf /conf-copy/aria2.conf
ADD config/nginx.conf /etc/nginx/nginx.conf

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80

CMD ["/conf-copy/start.sh"]
