#!/usr/bin/env bash
LAB=CVD_3_MSD
ARGS="--connect-timeout 1 --max-time 1"
EXEC_HOST="docker exec -it"
EXEC_CONTAINER=/usr/bin/curl
IP_1411="192.168.10.201"
IP_1412="192.168.10.202"
IP_2411="192.168.11.203"
IP_2412="192.168.11.204"
for CONTAINER in clab-nxos-host_{1411,1412,2411,2412}
    do
        echo ${LAB} ${CONTAINER}
        sudo ${EXEC_HOST} ${CONTAINER} sh -c "${EXEC_CONTAINER} ${IP_1411} ${ARGS}"
        sudo ${EXEC_HOST} ${CONTAINER} sh -c "${EXEC_CONTAINER} ${IP_1412} ${ARGS}"
        sudo ${EXEC_HOST} ${CONTAINER} sh -c "${EXEC_CONTAINER} ${IP_2411} ${ARGS}"
        sudo ${EXEC_HOST} ${CONTAINER} sh -c "${EXEC_CONTAINER} ${IP_2412} ${ARGS}"
    done
