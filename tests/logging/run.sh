#!/bin/bash -eu

artifacts="/tmp/LSR_Logging.$(date +%y%m%d-%H%M%S)"

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

for atest in $tests
do
ANSIBLE_STDOUT_CALLBACK=debug \
TEST_SUBJECTS=/home/nhosoi/Downloads/CentOS-7-x86_64-GenericCloud.qcow2c \
ansible-playbook -vv -i /usr/share/ansible/inventory/standard-inventory-qcow2 \
"$atest".yml 2>&1 | tee /"$artifacts"/"$atest".out
done
