docker build -t ansible .
docker run --name ansible --rm -v `pwd`:/tmp/ -itd ansible sh
docker exec ansible mkdir /root/.ssh/
docker cp ~/.ssh/1mg_rsa ansible:/root/.ssh/id_rsa
docker exec ansible chmod 400 /root/.ssh/id_rsa
docker exec -it ansible sh
