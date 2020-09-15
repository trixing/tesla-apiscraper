mkdir ./tmp
# curl -v -H 'Content-Type: application/json' -d @./grafana-datasources/influxdb.json http://admin:admin@localhost:3000/api/datasources && \
for f in grafana-dashboards/*.json; do
	t=./tmp/$(basename "$f")
	echo "$f" "$t"
	echo '{"dashboard":' > "$t"
        cat "$f" >> "$t"
	echo '}' >> "$t"
	sed -i 's/\${DS_TESLA}/InfluxDB/g' "$t"
	sed -i 's/\${VAR_RANGEUNIT}/km/g' "$t"

	curl -v -H 'Content-Type: application/json' -d "@$t" http://admin:admin42@localhost:3000/api/dashboards/db
done
