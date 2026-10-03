#!/bin/bash

services=("docmost" "jellyfin" "keycloak" "nextcloud-data-nextcloud-1" "wiki-server" "grafana" "grafana-loki" "hbbr" "hbbs" "grafana-alloy")
log_file="/etc/alloy/docker-monitor.log"
max_wait=30 #max time to wait for containers to start

log () {
	printf '{"time":"%s","container":"%s","status":"%s","action":"%s","host":"%s"}\n' \
		"$(date -Iseconds)" "$1" "$2" "$3" "$(hostname)" >> "$log_file"
}

for svc in "${services[@]}"; do
	cid=$(docker ps -aq -f "name=^/${svc}$" | head -n1)

	# Container doesn't exist
	if [ -z "$cid" ]; then
		log "$svc" "not_found" "none"
		continue
	fi

	# Check current state 
	running=$(docker inspect -f '{{.State.Running}}' "$cid" 2>/dev/null)

	#Container already running, skip restart
	if [ "$running" = "true" ]; then
		log "$svc" "running" "none"
		continue
	fi

	#Container is down: attempt restart
	log "$svc" "stopped" "restart_attempted"
	docker start "$cid" >/dev/null 2>&1

	#Wait for container to start
	elapsed=0
	while [ "$elapsed" -lt "$max_wait" ]; do
		running=$(docker inspect -f '{{.State.Running}}' "$cid" 2>/dev/null)
		if [ "$running" = "true" ]; then
			log "$svc" "running" "restarted_ok"
			break
		fi
		sleep 2
		elapsed=$((elapsed + 2))
	done

	if [ "$running" != "true" ]; then
		log "$svc" "stopped" "restart_failed"
	fi
done
