docker build -t ansible .
mkdir /tmp/ansible_logs/`date +%Y%m%d`
docker run --name ansible --rm -v /tmp/ansible_logs/`date +%Y%m%d`:/tmp/ansible_logs -v /root/.ssh:/root/.ssh -v `pwd`:/ansible -itd ansible sh
docker exec -it ansible sh
