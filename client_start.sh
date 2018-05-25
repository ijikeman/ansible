docker build -t ansible .
docker run --name ansible --rm -v /root/.ssh:/root/.ssh -v `pwd`:/tmp/ -itd ansible sh
docker exec -it ansible sh
