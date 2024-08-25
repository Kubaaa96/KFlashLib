$PROJECT_NAME="kflash"
$DOCKER_NETWORK="172.204.1.0/24"
$CONTAINER_IP="172.204.1.2"

echo $CONTAINER_IP

docker build -t $PROJECT_NAME-env -f docker/Dev.Dockerfile .
docker rm -f $PROJECT_NAME-env
docker network rm $PROJECT_NAME-net
docker network create $PROJECT_NAME-net --subnet "$DOCKER_NETWORK"
docker run --gpus all -d --privileged -p 2225:22 --restart always --net $PROJECT_NAME-net --ip "$CONTAINER_IP" --name $PROJECT_NAME-env $PROJECT_NAME-env