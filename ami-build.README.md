<!-- https://github.com/hmrc/txm-aws-provisioning/tree/master/packer -->

Build AMI
===============================================================================
```
eval $(ssh-agent)
ssh-add -k ~/.ssh/id_rsa

git clone git@github.com:hmrc/txm-aws-provisioning.git
cd txm-aws-provisioning/packer
source ./env.sh

export USER=shahzad.chaudhry
export PACKER_VARS='-on-error=ask'
export AWS_PROFILE=txm-sandbox
export PACKER_SSH_USER=shahzad.chaudhry
export PACKER_SSH_KEY=
printenv | grep AWS

make ami FOLDER=maps
```

Testing
===============================================================================
```
export TEST_KITCHEN_USER=shahzad.chaudhry
export TEST_KITCHEN_AMI=ami-04ae0c42e5b10f535
source /home/vagrant/.rvm/scripts/rvm
bundle install
cd maps
bundle exec kitchen test
```

Terraform
===============================================================================
```
cd /home/vagrant/txm-aws-provisioning/txm-terraform/maps/components
export AWS_PROFILE=txm-qa
aws-profile aws s3 ls
cat ~/.aws/cli/cache/133583c8a9f21890fcbd4183f6fee8c18d196755.json
make plan FOLDER=maps-server ENV=qa
```













==============================================================================

docker container run \
--tty --interactive \
--rm --name python \
--volume $PWD:/usr/src/python \
--workdir /usr/src/python/packer \
--volume $HOME/.aws:/root/.aws \
--volume $HOME/.ssh:/root/.ssh \
python bash

eval $(ssh-agent)
ssh-add -k ~/.ssh/id_rsa

pip3 install virtualenv
pip3 install awscli
apt update -y
apt install -y jq
apt install build-essential

source ./env.sh
export USER=shahzad.chaudhry
export PACKER_VARS='-on-error=ask'
export AWS_PROFILE=txm-sandbox
export PACKER_SSH_USER=shahzad.chaudhry
export PACKER_SSH_KEY=
printenv | grep AWS

make ami FOLDER=maps

ssh -A shahzad.chaudhry@[PUBLIC_IP]


Testing
==========================================
apt install build-essential curl nodejs
<!-- gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 -->
curl -sSL https://rvm.io/pkuczynski.asc | gpg2 --import -
curl -sSL https://get.rvm.io | bash -s stable --ruby
source /usr/local/rvm/scripts/rvm
rvm install 2.3.1
gem install bundler
export TEST_KITCHEN_USER=shahzad.chaudhry
export TEST_KITCHEN_AMI=ami-0cc6fff1935baa25c
bundle install
cd maps
bundle exec kitchen test

Run Terraform
============================================================================
pip3 uninstall awscli
pip uninstall boto3
pip uninstall botocore
pip install --no-cache-dir botocore==1.8.47
make plan FOLDER=maps-server ENV=qa
