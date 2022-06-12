
. docker/conf/deployment.conf

name="$IMAGE_NAME_PREFIX"
config=$1
image_name="$name-$config"
container_name="$image_name"

docker rm -f $container_name
docker rmi $name-$config