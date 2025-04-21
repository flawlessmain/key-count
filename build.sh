#! /bin/bash

#to specify a key_event_file use ./build.sh --strict /path/to/eventfile
if [ "$1" == "--strict" ]
    then 
        if [ -e "$2" ] 
            then
                keyboard_event_path="$2"
        else
            echo "ERROR: "$2" does not exist!"
        fi
    elif [ "$1" == "--help" ]
        then
            echo "type ./build.sh --strict /path/to/eventX which represents your keyboard event listener to specify path by hands"
    else
        #                   where all input event                                       key_ev = 120013
        keyboard_event_path=/dev/input/$(grep -E 'Handlers|EV=' /proc/bus/input/devices | grep -B1 'EV=120013' | grep -Eo 'event[0-9]+')
fi 

# if key-count.c is not modified; this meant to avoid duplicate final string
condition=$(tail -1 key-count.c)
if [ ${condition:0:2} == "}" ]
    then
        echo 'char PATH[] = "'$keyboard_event_path'";' >> key-count.c
fi

gcc key-count.c -o key-count