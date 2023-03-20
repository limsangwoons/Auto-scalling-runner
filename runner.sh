#!/bin/bash


sed 's/PasswordAuthentication no/PasswordAuthentication yes/' -i /etc/ssh/sshd_config
echo "1234" | passwd --stdin ec2-user
systemctl restart sshd

yum update -y
yum install jq -y 



mkdir actions-runner && cd actions-runner

curl -O -L https://github.com/actions/runner/releases/download/v2.296.2/actions-runner-linux-x64-2.296.2.tar.gz
tar xzf ./actions-runner-linux-x64-2.296.2.tar.gz


export RUNNER_ALLOW_RUNASROOT=true
PAT=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
token=$(curl -s -XPOST \
    -H "authorization: token $PAT" \
    https://abcd.tangunsoft.com/api/v3/enterprises/tangunsoft-partner-demo/actions/runners/registration-token \
    | jq -r .token)

./config.sh --url https://abcd.tangunsoft.com/enterprises/tangunsoft-partner-demo --token $token --name "$(date "+%m%d%H%M")" --work _work --labels Game --runnergroup Game
./run.sh




