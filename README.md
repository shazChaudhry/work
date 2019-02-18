



### Terraform
```
alias terraform='docker container run \
--tty --interactive \
--rm --name terraform \
--volume $PWD:/usr/src/terraform \
--workdir /usr/src/terraform \
--volume $HOME/.aws:/root/.aws \
--volume $HOME/.ssh:/root/.ssh \
hashicorp/terraform'

terraform --version
terraform init
terraform plan -out=tfplan
terraform apply tfplan
terraform show
```

### Python
```
alias python='docker container run \
--tty --interactive \
--rm --name python \
--volume $PWD:/usr/src/python \
--workdir /usr/src/python \
--volume $HOME/.aws:/root/.aws \
--volume $HOME/.ssh:/root/.ssh \
python python'

docker container run \
--tty --interactive \
--rm --name python \
--volume $PWD:/usr/src/python \
--workdir /usr/src/python \
--volume /var/run/docker.sock:/var/run/docker.sock \
--network host
python bash

python --version
```

### Ansible
```
alias ansible='docker container run -it --rm --name ansible \
-e "ANSIBLE_CONFIG=./ansible.cfg" \
--volume $HOME/.ssh:/root/.ssh \
--volume $PWD:/usr/src/ansible \
--workdir /usr/src/ansible \
shazchaudhry/docker-centos ansible'

ansible --version
```

```
alias ansible-playbook='docker container run -it --rm --name ansible-playbook \
-e "ANSIBLE_CONFIG=./ansible.cfg" \
--volume $HOME/.ssh:/root/.ssh \
--volume $PWD:/usr/src/playbook \
--workdir /usr/src/playbook \
shazchaudhry/docker-centos ansible-playbook'

ansible-playbook --version
```

```
alias ansible-galaxy='docker container run -it --rm --name ansible-galaxy \
-e "ANSIBLE_CONFIG=./ansible.cfg" \
--volume $PWD:/usr/src/galaxy \
--workdir /usr/src/galaxy \
shazchaudhry/docker-centos ansible-galaxy'

ansible-galaxy --version
```
