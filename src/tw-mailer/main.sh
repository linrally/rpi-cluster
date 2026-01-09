#!/usr/bin/env bash

task sync >/dev/null 2>&1

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

cat <<EOF | msmtp rally.lin@duke.edu
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