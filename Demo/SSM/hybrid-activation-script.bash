# Script to install SSM agent on a Linux instance and activate it using hybrid activation
# using API Gateway endpoint
sudo yum erase amazon-ssm-agent --assumeyes

credentials=$(curl https://xxxxxxxxxx.execute-api.us-east-1.amazonaws.com/lambdastage)
activationCode=$(echo $credentials | jq -r '.ActivationCode')
activationId=$(echo $credentials | jq -r '.ActivationId')


mkdir /tmp/ssm
curl https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm -o /tmp/ssm/amazon-ssm-agent.rpm
sudo dnf install -y /tmp/ssm/amazon-ssm-agent.rpm
sudo systemctl stop amazon-ssm-agent
sudo -E amazon-ssm-agent -register -code "$activationCode" -id "$activationId" -region us-east-1
sudo systemctl start amazon-ssm-agent