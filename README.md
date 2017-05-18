# scheduled-swagger-diff-slack-notification
scheduled swagger diff slack notification

INSTALLATION STEPS
==================

1- create a hook for your slack channel notification
EX: https://hooks.slack.com/services/SOME-KEYS/FOR-YOUR/SLACK-CHANNEL

2-i nstall ruby
sudo apt-get install ruby-full

3- install swagger-diff tool (https://github.com/civisanalytics/swagger-diff)
sudo gem install swagger-diff

4- create a folder "api-diff"
mkdir api-diff

5- put "api-diff.sh" file into the folder.

6- set "api-diff.sh" execute permission.
chmod +x api-diff.sh

7- create your sample "environmet.list" file as seen in repository
ACTIVE;NAME;ENV;URL
1;sample-project-1;dev;http://dev-api1.sample-project.com/v2/api-docs.json
1;sample-project-1;test;http://test-api1.sample-project.com/v2/api-docs.json
1;sample-project-2;dev;http://dev-api2.sample-project.com/v2/api-docs.json
1;sample-project-2;test;http://test-api2.sample-project.com/v2/api-docs.json
1;sample-project-3;dev;http://dev-api3.sample-project.com/v2/api-docs.json
1;sample-project-3;test;http://test-api3.sample-project.com/v2/api-docs.json

8- schedule your crontab to run every 5 min
crontab -e

*/5 * * * * /home/olgac/api-diff/api-diff.sh &

9- ENJOY IT :)
