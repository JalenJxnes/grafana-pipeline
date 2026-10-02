#!/bin/bash

container_name=("docmost" "jellyfin" "keycloak" "nextcloud-data-nextcloud-1" "wiki-server" "grafana" "grafana-loki" "hbbr" "hbbs" "grafana-alloy")
log_file="/etc/alloy/docker-monitor.log"

#Check if important Docker containers are running
for variable in "${container_name[@]}"; do

	status=$(docker container inspect -f '{{.State.Running}}' "$variable" 2>/dev/null )
	if [ "$status" = "true" ]; then
	state="running"

	elif [ "$status" = "false" ]; then
	state="stopped"
	source /usr/bin/container-restart.bash

	else state="not_found"

	fi

#Log results as JSON to log file
printf '{"time":"%s","container":"%s","status":"%s","host":"%s"}\n' \
	"$(date --iso-8601=ns)" "$variable" "$state" "$(hostname)" >> "$log_file" 

done
