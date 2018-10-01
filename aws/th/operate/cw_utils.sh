
#start cloudwatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -a fetch-config -m ec2 -c file:/opt/aws/amazon-cloudwatch-agent/bin/config.json -s

#query cloudwatch agent status
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a status

#stop cloudwatch agent
sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl -m ec2 -a stop




#get cw metrics
#see https://docs.aws.amazon.com/cli/latest/reference/cloudwatch/get-metric-data.html
aws cloudwatch get-metric-data --metric-data-queries <<json file here>> --start-time  2018-09-10T00:00:00.000 --end-time  2018-09-14T00:00:00.000


