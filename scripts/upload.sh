#!/bin/bash

# Rclone cycling upload script with Discord notification upon move completion (if something is moved)

lastsync=$(tail -1 $HOME/logs/rclone/lastsync.txt | head -1)

if [[ $lastsync = "Gcrypt" ]]; then
accnum=""
echo "Gcrypt1" > lastsync.txt

elif [[ $lastsync = "Gcrypt1" ]]; then
accnum="1"
echo "Gcrypt2" > lastsync.txt

elif [[ $lastsync = "Gcrypt2" ]]; then
accnum="2"
echo "Gcrypt3" > lastsync.txt

elif [[ $lastsync = "Gcrypt3" ]]; then
accnum="3"
echo "Gcrypt4" > lastsync.txt

elif [[ $lastsync = "Gcrypt4" ]]; then
accnum="4"
echo "Gcrypt5" > lastsync.txt

elif [[ $lastsync = "Gcrypt5" ]]; then
accnum="5"
echo "Gcrypt" > lastsync.txt

fi

SOURCE_DIR="$HOME/data/media/local/"
DESTINATION_DIR="Gcrypt$accnum:"

DISCORD_WEBHOOK_URL="xxxxxxxxxxxxxxxxxxxxxxx"
DISCORD_ICON_OVERRIDE="https://i.imgur.com/lNe3cpn.gif"
DISCORD_NAME_OVERRIDE="RCLONE UPLOAD"

LOCK_FILE="$HOME/rclone-upload.lock"
LOG_FILE="$HOME/.config/rclone/rclone-upload.log"


# -----------------------------------------------------------------------------

trap 'rm -f $LOCK_FILE; exit 0' SIGINT SIGTERM
if [ -e "$LOCK_FILE" ]
then
  echo "$0 is already running."
  exit
else
  touch "$LOCK_FILE"
  
  rclone_move() {
    rclone_command=$(
      /usr/bin/rclone move -vP  \
      --config="$HOME"/.config/rclone/rclone.conf \
      --drive-chunk-size 128M \
      --use-mmap \
      --delete-empty-src-dirs \
      --fast-list \
      --log-file="$LOG_FILE" \
      --tpslimit=5 \
      --stats=9999m \
      --transfers=4 \
      --max-transfer 600G \
      --checkers=4 \
      --bwlimit=100M \
      "$SOURCE_DIR" "$DESTINATION_DIR" 2>&1
    )
    # "--stats=9999m" mitigates early stats output 
    # "2>&1" ensures error output when running via command line
    echo "$rclone_command"
  }
  rclone_move

  if [ "$DISCORD_WEBHOOK_URL" != "" ]; then
  
    rclone_sani_command="$(echo $rclone_command | sed 's/\x1b\[[0-9;]*[a-zA-Z]//g')" # Remove all escape sequences


    transferred_amount=${rclone_sani_command#*Transferred: }
    transferred_amount=${transferred_amount%% /*}
    
    send_notification() {
      output_transferred_main=${rclone_sani_command#*Transferred: }
      output_transferred_main=${output_transferred_main% Errors*}
      output_errors=${rclone_sani_command#*Errors: }
      output_errors=${output_errors% Checks*}
      output_checks=${rclone_sani_command#*Checks: }
      output_checks=${output_checks% Transferred*}
      output_transferred=${rclone_sani_command##*Transferred: }
      output_transferred=${output_transferred% Elapsed*}
      output_elapsed=${rclone_sani_command##*Elapsed time: }
      
      notification_data='{
        "username": "'"$DISCORD_NAME_OVERRIDE"'",
        "avatar_url": "'"$DISCORD_ICON_OVERRIDE"'",
        "content": null,
        "embeds": [
          {
            "title": "Rclone Upload Task: Success!",
            "color": 4094126,
            "fields": [
              {
                "name": "Transferred",
                "value": "'"$output_transferred_main"'"
              },
              {
                "name": "Errors",
                "value": "'"$output_errors"'"
              },
              {
                "name": "Checks",
                "value": "'"$output_checks"'"
              },
              {
                "name": "Transferred",
                "value": "'"$output_transferred"'"
              },
              {
                "name": "Elapsed time",
                "value": "'"$output_elapsed"'"
              }
            ],
            "thumbnail": {
              "url": null
            }
          }
        ]
      }'
      
      /usr/bin/curl -H "Content-Type: application/json" -d "$notification_data" $DISCORD_WEBHOOK_URL 
    }
    
    if [ "$transferred_amount" != "0" ]; then
      send_notification
    fi

  fi

  rm -f "$LOCK_FILE"
  trap - SIGINT SIGTERM
  exit
fi
