# scheduled-swagger-diff-slack-notification
scheduled swagger diff slack notification

INSTALLATION STEPS
==================

1- create a hook for your slack channel notification
EX: https://hooks.slack.com/services/SOME-KEYS/FOR-YOUR/SLACK-CHANNEL

2- install ruby
sudo apt-get install ruby-full

3- install swagger-diff tool (https://github.com/civisanalytics/swagger-diff)
sudo gem install swagger-diff

4- create a folder "api-diff"
mkdir api-diff

5- put "api-diff.sh" file into the folder.
Edit your SLACK_URL variable in "api-diff.sh" script.

6- set "api-diff.sh" execute permission.
chmod +x api-diff.sh

7- create your sample "environmet.list" file as seen in repository

8- schedule your crontab to run every 5 min
*/5 * * * * /home/olgac/api-diff/api-diff.sh &

9- ENJOY IT :)
