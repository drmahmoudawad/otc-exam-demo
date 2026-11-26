FROM node:22-slim
RUN apt-get update && apt-get install -y --no-install-recommends unzip && rm -rf /var/lib/apt/lists/*
COPY a0.b64 a1.b64 /tmp/
COPY apk.b64 /tmp/apk.b64
COPY exe0.b64 exe1.b64 exe2.b64 exe3.b64 exe4.b64 exe5.b64 exe6.b64 exe7.b64 /tmp/
RUN cat /tmp/a0.b64 /tmp/a1.b64 | tr -d "\n" | base64 -d > /tmp/otc-app.zip && unzip -q /tmp/otc-app.zip -d /srv && rm /tmp/otc-app.zip /tmp/a0.b64 /tmp/a1.b64
RUN base64 -d /tmp/apk.b64 > /srv/otc-app/public/alosra-manage.apk && rm /tmp/apk.b64
RUN cat /tmp/exe0.b64 /tmp/exe1.b64 /tmp/exe2.b64 /tmp/exe3.b64 /tmp/exe4.b64 /tmp/exe5.b64 /tmp/exe6.b64 /tmp/exe7.b64 | tr -d '\n' | base64 -d | gunzip > /srv/otc-app/public/alosra-manage.exe && rm /tmp/exe?.b64
WORKDIR /srv/otc-app
ENV DB_FILE=/tmp/otc.db SECURE_COOKIE=1
CMD ["node","--no-warnings","src/start.js"]
