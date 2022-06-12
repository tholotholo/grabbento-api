#/bin/bash
. docker/conf/deployment.conf
set -e
echo "====== start RUN script ======"
start_time="$(date -u +%s)"
name="$IMAGE_NAME_PREFIX"
#mount=$2

config=$1
image_name="$name-$config"
container_name="$image_name"
echo "$container_name"

port=$PORT_APP

docker run -dit --restart always --name "$container_name" -p "$port":8080 "$name-$config"

echo "====== end RUN script ======"
end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for RUN process"
