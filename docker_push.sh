export myNs=noneedrelax
# Build the image first
docker build -t ${myNs}/multi-client ./client
docker build -t ${myNs}/multi-server ./server
docker build -t ${myNs}/multi-nginx ./nginx
docker build -t ${myNs}/multi-worker ./worker
 

# making sure correct region is set
aws configure set default.region us-west-2

# Push image to ECR
###################

# I'm speculating it obtains temporary access token
# it expects aws access key and secret set
# in environmental vars
$(aws ecr get-login --no-include-email)

# update latest version
docker tag ${myNs}/multi-client:latest ${REGISTRY_ID}/multi-client:latest
docker tag ${myNs}/multi-client:latest ${REGISTRY_ID}/multi-server:latest
docker tag ${myNs}/multi-client:latest ${REGISTRY_ID}/multi-nginx:latest
docker tag ${myNs}/multi-client:latest ${REGISTRY_ID}/multi-worker:latest
docker push ${REGISTRY_ID}/multi-client:latest
docker push ${REGISTRY_ID}/multi-server:latest
docker push ${REGISTRY_ID}/multi-nginx:latest
docker push ${REGISTRY_ID}/multi-worker:latest

