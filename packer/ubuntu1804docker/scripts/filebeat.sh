#!/bin/bash

wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
apt-get update && apt-get install filebeat metricbeat
# Configure filebeat & metricbeat
systemctl enable filebeat
systemctl start filebeat
systemctl enable metricbeat
systemctl start metricbeat
# Run once...?
metricbeat setup --dashboards
filebeat setup --dashboards
