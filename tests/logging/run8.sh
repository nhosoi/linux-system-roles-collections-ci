#!/bin/bash -eu

artifacts="/tmp/LSR_Logging8.$(date +%y%m%d-%H%M%S)"

if [ -d "$artifacts" ]; then
  rm -rf "$artifacts"
fi
mkdir "$artifacts"


tests="tests_basics_files tests_files_elasticsearch tests_relp \
tests_basics_forwards tests_files_files tests_remote \
tests_combination tests_imuxsock_files tests_server \
tests_default tests_include_vars_from_parent tests_version \
tests_enabled tests_ovirt_elasticsearch"

image="CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2"
#image="CentOS-Stream-GenericCloud-8-20200113.0.x86_64.qcow2"
for atest in $tests
do
ANSIBLE_STDOUT_CALLBACK=debug \
TEST_SUBJECTS=/home/nhosoi/Downloads/$image \
ansible-playbook -vv -i /usr/share/ansible/inventory/standard-inventory-qcow2 \
"$atest".yml 2>&1 | tee /"$artifacts"/"$atest".out
done
