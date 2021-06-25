

#!/bin/sh

# De adaugat PATH-ul
LOGDIR=/data/logs

# Maximum number of archive logs to keep
MAXNUM=30

#Log files to be handled in that log directory 
files=(access.log error.log)

for LOGFILE in "${files[@]}"
do 

## Check if the last log archive exists and delete it.
if [ -f $LOGDIR/$LOGFILE.$MAXNUM.gz ]; then
rm $LOGDIR/$LOGFILE.$MAXNUM.gz
fi

NUM=$(($MAXNUM - 1))

## Check the previous log file.
while [ $NUM -ge 0 ]
do
NUM1=$(($NUM + 1))
if [ -f $LOGDIR/$LOGFILE.$NUM.gz ]; then
mv $LOGDIR/$LOGFILE.$NUM.gz $LOGDIR/$LOGFILE.$NUM1.gz
fi

NUM=$(($NUM - 1))
done


# Compress and clear the log file
if [ -f $LOGDIR/$LOGFILE ]; then
cat $LOGDIR/$LOGFILE | gzip > $LOGDIR/$LOGFILE.0.gz
cat /dev/null > $LOGDIR/$LOGFILE
fi
echo -e "---===Made by Catalin===---"
done
