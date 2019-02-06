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
