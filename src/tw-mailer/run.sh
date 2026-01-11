#!/usr/bin/env bash

TASKRC=/root/.taskrc

echo "Creating .taskrc from secrets..."

cat > "$TASKRC" <<EOF
data.location=/root/.task

taskd.server=${TASKD_SERVER}
taskd.credentials=${TASKD_CREDENTIALS}
taskd.key=/secrets/client.key.pem
taskd.certificate=/secrets/client.cert.pem
taskd.ca=/secrets/ca.cert.pem
EOF

task sync > /dev/null 2>&1

DATE=$(date +"%A, %B %d")

NEXT=$(task status:pending +next \
  rc.report.nextmail.columns=description,due.relative \
  rc.report.nextmail.labels=Task,Due \
  rc.report.nextmail.sort=due+ \
	rc.report.nextmail.header=off \
  nextmail)

SOON=$(task status:pending "(overdue or due.before:today+5d)" \
  rc.report.soonmail.columns=description,due.relative \
  rc.report.soonmail.labels=Task,Due \
  rc.report.soonmail.sort=due+ \
	rc.report.soonmail.header=off \
  soonmail)

echo "Creating msmtp config"
cat > /etc/msmtprc <<EOF
defaults
auth on
tls on
tls_trust_file /etc/ssl/certs/ca-certificates.crt
logfile /dev/stdout

account mailer
host ${SMTP_HOST}
port ${SMTP_PORT}
from ${SMTP_FROM}
user ${SMTP_USER}
password ${SMTP_APPKEY}
EOF

chmod 600 /etc/msmtprc

cat <<EOF | msmtp -a mailer "${RECIPIENT}"
Subject: TW Update ($DATE)
MIME-Version: 1.0
Content-Type: text/html; charset=UTF-8

<html>
<body style="font-family: monospace; font-size: 12px;">
<pre style="color:#eab308;">$NEXT</pre>

<pre>$SOON</pre>
</body>
</html>
EOF

echo "RAN at $(date)"