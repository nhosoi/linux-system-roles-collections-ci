#!/bin/bash -eu

artifacts="/tmp/LSR_Logging8.$(date +%y%m%d-%H%M%S)"

if [ -d "$artifacts" ]; then
  rm -rf "$artifacts"
fi
mkdir "$artifacts"

defaults="tests_default tests_enabled tests_version tests_include_vars_from_parent"
basics="tests_basics_files tests_basics_forwards tests_imuxsock_files"
files="tests_files_files"
combs="tests_combination"
files_el="tests_files_elasticsearch"
ovirt="tests_ovirt_elasticsearch"
remote="tests_remote tests_server"
relp="tests_relp"

tests="${defaults} ${basics} ${files} ${combs} ${files_el} ${ovirt} ${remote} ${relp}"

image="CentOS-8-GenericCloud-8.3.2011-20201204.2.x86_64.qcow2"
#image="CentOS-Stream-GenericCloud-8-20200113.0.x86_64.qcow2"
for atest in $tests
do
ANSIBLE_STDOUT_CALLBACK=debug \
TEST_SUBJECTS=/home/nhosoi/Downloads/$image \
ansible-playbook -vv -i /usr/share/ansible/inventory/standard-inventory-qcow2 \
"$atest".yml 2>&1 | tee /"$artifacts"/"$atest".out
done
