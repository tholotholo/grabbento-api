. docker/conf/deployment.conf
set -e
echo "====== start BUILD script ======"
start_time="$(date -u +%s)"
name="$IMAGE_NAME_PREFIX"
config=$1
echo "$name-$config"

# copy necessary file for build into src
rm -rf docker/src/*
cp -r project docker/src
mkdir -p docker/src/log
cp requirements.txt docker/src 

docker build --build-arg DEPLOYMENT_ENV=staging --build-arg --no-cache -f `pwd`/docker/conf/Dockerfile -t "$name-$config" .

rm -rf docker/src/*
echo '*\n!.gitignore' > docker/src/.gitignore

echo "====== end BUILD script ======"
end_time="$(date -u +%s)"

elapsed="$(($end_time-$start_time))"
echo "Total of $elapsed seconds elapsed for BUILD process"