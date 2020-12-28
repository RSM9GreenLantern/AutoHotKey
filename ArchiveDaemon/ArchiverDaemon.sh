#!/usr/bin/env
CONF_expire_time_DAYS=7
CONF_archive_path_STR=D:/Documents/ArchivedCode/Autohotkey/Unsorted

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

GEN_expire_time_SECONDS=$((CONF_expire_time_DAYS*86400))
NEW_today_DATE=$(date +%s)
NEW_expire_DATE=$((NEW_today_DATE-GEN_expire_time_SECONDS))

for entry in "$DIR"/*
do
  LAST_modified_DATE=$(stat -c %Y "$entry")
  if [[ -d $entry ]]; then
    echo $entry
    echo $LAST_modified_DATE
    echo $NEW_expire_DATE
    if [[ $NEW_expire_DATE -gt $LAST_modified_DATE ]]; then
      mv $
    else
      echo modified $(stat -c %y "$entry")
    fi
  fi
  echo
done