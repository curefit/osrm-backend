#true is given so that even if the container doesn't exists, the command should not fail, because if the command fails, it will fail the CodeDeploy process also.
sudo docker stop osrm-app || true
sudo docker rm osrm-app || true
sudo rm -rf /home/ubuntu/osrm