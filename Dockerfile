FROM node:22-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
COPY app.b64 /tmp/app.b64
COPY apk.b64 /tmp/apk.b64
RUN base64 -d /tmp/app.b64 > /tmp/otc-app.zip && unzip -q /tmp/otc-app.zip -d /srv && rm /tmp/otc-app.zip /tmp/app.b64
RUN base64 -d /tmp/apk.b64 > /srv/otc-app/public/alosra-manage.apk && rm /tmp/apk.b64
WORKDIR /srv/otc-app
ENV DB_FILE=/tmp/otc.db SECURE_COOKIE=1
CMD ["node","--no-warnings","src/start.js"]
