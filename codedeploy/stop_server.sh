#!/bin/bash

ENVIRONMENT=`echo $DEPLOYMENT_GROUP_NAME`
echo "ENVIRONMENT = $ENVIRONMENT"

# if [[ $DEPLOYMENT_GROUP_NAME == "DistanceService" ]]
# then
#   STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -X POST http://localhost:80/healthcheck/negate)  # removing from the ELB.
# else
#   STATUS_CODE=$(curl -s -o /dev/null -w '%{http_code}' -X POST http://localhost:20000/healthcheck/negate)  # removing from the ELB.
# fi

# if [ $STATUS_CODE -eq 200 ]; then
#     echo "Negated the healthcheck successfully."

#     # Sleeping for 60 seconds before stopping the container. This will ensure that if there are any current requests being served they should be completed.
#     sleep 60

# Stopping service
# sudo docker stop osrm || true
# else
#     echo "Got $STATUS_CODE while trying to negate the healthcheck. Can't remove from the ELB, hence aborting the deployment."
#     exit 1  # exiting with the non success code, so code deploy stops the deployment.
# fi
