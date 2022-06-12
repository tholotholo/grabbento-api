. docker/conf/deployment.conf
config=$1
mount=$2
name="$IMAGE_NAME_PREFIX"


start_time="$(date -u +%s)"
echo "====== start ======"
./docker/bin/stop.sh "$config" 
./docker/bin/build.sh "$config" || exit 1
./docker/bin/run.sh "$config" "$mount" || exit 1
echo "====== end ======"
end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for build-deploy-process"



