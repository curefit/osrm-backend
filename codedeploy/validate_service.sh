#!/usr/bin/env bash
PORT=80

if [ "$DEPLOYMENT_GROUP_NAME" == "DistanceService" ]
then
  PORT=5200
else
  PORT=20000
fi
echo ${PORT}

while true
do
  result=$(curl --write-out %{http_code} --silent --output /dev/null  "http://127.0.0.1:${PORT}/route/v1/driving/77.623332,13.036153;77.62199096381664,13.050302955222222?alternatives=true&overview=false")
  if [ "$result" == "200" ]; then
    echo "status = $result ok"
    break
  fi
  sleep 2
  echo status = $result
done

