# Script for logs archieve of months Integration server

This shell script is designed to archive log files for a given month. The script takes one parameter, which is the month (three-letter abbreviation) for which log files need to be archived. The script checks if the current user is "wmadmin" and exits if it's not.

The script then looks for log files for the specified month and moves them to a newly created directory (if it doesn't already exist). If there is more than one log file for the specified month, the script creates a tar file for the log files and compresses it. The script then removes the old log files and moves the compressed tar file to the log directory. Finally, the script removes the temporary archive directory.

#### Usage
To use the script, run it from the command line, specifying the month you want to archive logs for. For example:


```bash
./archive_log.sh Apr
```
This will archive all log files for the month of April.

#### Note
This script is designed to be run by the "wmadmin" user. If you are not logged in as "wmadmin", the script will exit and display an error message.