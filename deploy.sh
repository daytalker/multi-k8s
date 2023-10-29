docker build -t daytalker/multi-client:latest -t daytalker/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t daytalker/multi-server:latest -t daytalker/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t daytalker/multi-worker:latest -t daytalker/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push daytalker/multi-client:latest
docker push daytalker/multi-server:latest
docker push daytalker/multi-worker:latest

docker push daytalker/multi-client:$SHA
docker push daytalker/multi-server:$SHA
docker push daytalker/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=daytalker/multi-server:$SHA
kubectl set image deployments/client-deployment client=daytalker/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=daytalker/multi-worker:$SHA