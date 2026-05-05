#!/bin/bash
mkdir -p /cats/
cd /cats/
ls
echo 1 Wipe All
echo 2 Wipe One
read what
if [ "${what}" = "1" ]; then
rm -rf /cats/
else
read wth
rm "${wth}"
fi
