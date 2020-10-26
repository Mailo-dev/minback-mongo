#! /bin/bash
set -e -o pipefail

DB="$1"
ARGS="${@:2}"

mc config host add mongodb "$MINIO_SERVER" "$MINIO_ACCESS_KEY" "$MINIO_SECRET_KEY" --api "$MINIO_API_VERSION" > /dev/null

ARCHIVE="${MINIO_BUCKET}/${DB}-$(date $DATE_FORMAT).archive"

echo "Dumping $DB to $ARCHIVE"
echo "> mongodump $ARGS -d $DB"

mongodump $ARGS -d "$DB" --archive | mc pipe "mongodb/$ARCHIVE" || { echo "Backup failed"; mc rm "mongodb/$ARCHIVE"; exit 1; }

echo "Backup complete"
