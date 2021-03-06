#!/bin/sh -e
# upstart-job
#
# Symlink target for initscripts that have been converted to Upstart.
 
set -e
APP_PATH="{{ seek_project_root }}"
 
start_sunspot(){
        echo "Starting Sunspot"
        sudo -iu {{ www_user }} bash -lc "cd ${APP_PATH} && rake sunspot:solr:start RAILS_ENV={{ rails_env }}"
}
 
stop_sunspot(){
        echo "Stopping Sunspot"
        sudo -iu {{ www_user }} bash -lc "cd ${APP_PATH} && rake sunspot:solr:stop RAILS_ENV={{ rails_env }}"
}
 
COMMAND="$1"
shift
 
case $COMMAND in
status)
    ;;
start|stop|restart)
    $ECHO
    if [ "$COMMAND" = "stop" ]; then
        stop_sunspot
    elif [ "$COMMAND" = "start" ]; then
        start_sunspot
    elif  [ "$COMMAND" = "restart" ]; then
        stop_sunspot
        sleep 1s
        start_sunspot
        exit 0
    fi
    ;;
esac
