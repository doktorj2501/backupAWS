#backupAWS                                         
#A script that takes snapshot of an EC2 instance at midnight, Tues-Saturday. You could change                                                  
#the crontab to make it backup weekend work, too, or only run once a month. Your call.                              
#You will have to plug in your unique Volume ID, obviously. If your volume ID changes, you will                              
#need to update this script to reflect the new volume ID.                                      
#There is also a way to use AWS-CLI to pull the volume ID of the native or any other instance                                                         
#Also, this script is self-pruning, to cut AWS storage costs. That means,                          
#It deletes the oldest backup before making a new one.                               
#Even if the create snapshot fails to fire, it will only delete the 5th oldest backup before that.                                
#After that, it will have no 5th oldest backup to delete, but it will still attempt to make a new snapshot.                           
#Currently, this is set for one business week. (obs_iter = ($iter-4))                             
#The way it sits, last Tuesday's backup of last Monday's work gets replaced by this Tuesday's                          
#backup of this Monday's work, and so on throught the week.                                           
#You could reset this to a whole 2-week sprint (ten business days)                        
#by changing obs_iter to iter-9. As it is 5-4=1, the backup that gets deleted.                              
#Then, when a new backup is made, you have 2-6, so 5 backups on hand.                                
#This script will error the first 4 times it is run, because there is nothing to delete,                           
#but because it's in BASH, the script keeps going to take the snapshot, and once there are 5                                
#It will stop outputting errors to the log.                                 
#Each snapshot created outputs its metadata to a .json object, stored in the json directory                                       
#Preliminary obsolete backup delete gets rid of the 5th oldest backup as well as its json file,                                         
#before generating a new snapshot and json.                                                 
#Finally, be sure to set your permissions so crontab can run it correctly!                          
