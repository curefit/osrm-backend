#!/bin/bash

# Build Docker Image from Dockerfile
# sudo docker build -t osrm:latest /home/ubuntu/osrm/

ENVIRONMENT=`echo $DEPLOYMENT_GROUP_NAME`

echo "ENVIRONMENT = $ENVIRONMENT"
if [[ $DEPLOYMENT_GROUP_NAME == "osrm" ]]
then
    echo "Will run Docker container for osrm."

    #:v5.18.0

    sudo docker run --name osrm-extract-temp -t -v /home/ubuntu/osrm:/data osrm/osrm-backend osrm-extract -p /opt/car.lua /data/bengaluru_now.osm.pbf

    sudo docker run --name osrm-partition-temp -t -v /home/ubuntu/osrm:/data osrm/osrm-backend osrm-partition /data/bengaluru_now.osrm

    sudo docker run --name osrm-customize-temp -t -v /home/ubuntu/osrm:/data osrm/osrm-backend osrm-customize /data/bengaluru_now.osrm


    sudo docker stop osrm-extract-temp || true
    sudo docker rm osrm-extract-temp || true
    sudo docker stop osrm-partition-temp || true
    sudo docker rm osrm-partition-temp || true
    sudo docker stop osrm-customize-temp || true
    sudo docker rm osrm-customize-temp || true



    #docker rm temp1, temp2, temp3
    sudo docker run --name osrm-app -t -d -p 5200:5000 -v /home/ubuntu/osrm:/data osrm/osrm-backend osrm-routed --algorithm mld /data/bengaluru_now.osrm

elif [[ $DEPLOYMENT_GROUP_NAME == "stage" ]]
then
    echo "Will run Docker container for stage"
    sudo docker run --name albus --storage-opt size=11G --log-opt max-size=1m -v /home/ubuntu/albus-app:/app -d -p 20000:8080 albus:latest


else
    echo "Unknown DEPLOYMENT_GROUP_NAME : $DEPLOYMENT_GROUP_NAME"
    echo "Will run the container with default settings."
    sudo docker run --name albus --storage-opt size=11G --log-opt max-size=1m -v /home/ubuntu/albus-app:/app -d -p 20000:8080 albus:latest
fi

sleep 60   # sleeping 60 seconds so the code-deploy waits here before picking up the next box. This 60 seconds ensure that the service inside the container is up and running. (if no errors)

echo "Docker container started..."