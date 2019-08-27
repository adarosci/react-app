cd ~/compose-services
git pull
cd ..
docker-compose -f ~/compose-services/docker-compose.yml up -d
docker system prune -f