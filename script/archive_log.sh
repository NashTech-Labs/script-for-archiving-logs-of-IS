#!/bin/bash

#* Purpose: This script archives all the log files for a given month.


# Is the current user wmadmin?
if [[ `whoami` != "wmroot" ]]
then
   echo "\nYou are logged in as `whoami`."
   echo "You must log in as wmadmin to run this script!\n"
   exit 1
fi

month=$1


Log_directory_IS=${ISA2A_HOME}/logs
tarfile="$month`date +%Y`.tar"

#Check to see if the month was specified
if [[ $# -lt 1 ]]
then
   echo "\nError: No Parameters Specified"
   echo "\nExample: archive_log.sh Apr\n"
   exit 1
else
   #Check to see if the archive directory exists
   if [[ ! -d $Log_directory_IS/$month ]]
   then
      echo "Creating archive directory..."
      mkdir $Log_directory_IS/$month
   fi

   #Move all files for a specified month to the archive directory
   echo "Moving files for $month to archive directory..."
   for log in `ls -l $Log_directory_IS/*.log|grep -i $month|awk '{print $9}'`
   do
       if [[ -f $log ]]
       then
          echo "Moving the logs now  $log..."
          mv $log $Log_directory_IS/$month > /dev/null
       fi
   done
# Now if there are more than 1 log file then the below would cretae archeive of all the logs file.

   if [[ `ls $Log_directory_IS/$month|wc -l` -gt 1 ]]
   then 
      cd $Log_directory_IS/$month
      #tar -cvf $Log_directory_IS/$month/$month`date +%Y`.tar $Log_directory_IS/$month/*.log
      echo "Creating tarfile for the logs  $tarfile..."

      #the below command will create tar for the logs file.

      tar -cvf $tarfile *.log
      if (( $? == 0 ))
      then
         echo "Compressing $tarfile..."
         compress $tarfile
         if (( $? == 0 ))
         then
            echo "Removing old log files..."
            rm -f $Log_directory_IS/$month/*.log 
         fi
      fi
   fi

   #If a compressed tar file was created, move it to the logs directory

   #the script moves the compressed tar file to the logs directory and removes the temporary archive directory. 
   if [[ -f $Log_directory_IS/$month/$tarfile.Z ]]
   then
      echo "Moving $tarfile.Z to $Log_directory_IS"
      mv $Log_directory_IS/$month/$tarfile.Z $Log_directory_IS
      cd $Log_directory_IS
      echo "Removing temp directory $month..."
      rmdir $Log_directory_IS/$month
   fi
fi

echo "Finished."
