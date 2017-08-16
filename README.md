#backupAWS
#A script that takes snapshot of an EC2 instance at midnight, Tues-Saturday. You could change
#the crontab to make it backup weekend work, too, or only run once a month. Your call.
#You will have to plug in your unique Volume ID, obviously.
#Also, this script is self-pruning, to cut AWS storage costs. That means,
#It deletes the oldest backup before making a new one.
#Currently, this is set for one business week. (obs_iter = ($iter-4))
#The way it sits, last Tuesday's backup of last Monday's work gets replaced by this Tuesday's
#backup of this Monday's work. You could reset this to a whole 2-week sprint (ten business days)
#by changing obs_iter to iter-9. As it is 5-4=1, the backup that gets deleted.
#Then, when a new backup is made, you have 2-6, so 5 backups on hand. 
#This script will error the first 4 times it is run, because there is nothing to delete, 
#but because it's in BASH, the script keeps going to take the snapshot, and once there are 5
#It will stop outputting errors to the log.
#Finally, be sure to set your permissions so crontab can run it correctly!
