# Backup and Restore Snapshots in Elasticsearch Docker Container

## Overview
This README accompanies the detailed guide titled "Backup and Restore Snapshots in Elasticsearch Docker Container: A DevOps Guide." It provides a condensed version of the guide with commands and key steps for DevOps teams.

## Prerequisites
- Elasticsearch running in a Docker container.
- Access to Docker Compose and Elasticsearch configuration files.
- Familiarity with Elasticsearch and Docker commands.

## Backup Process

### 1. Set Repository Path
- **Docker Compose Method**: Add `- 'path.repo=/tmp/esbackup/snapshots'` to your Elasticsearch service in the Docker Compose file.
- **Elasticsearch Configuration Method**: Bind the Elasticsearch.yml to the container (`./elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml`) and set `path.repo` in it.

### 2. Initialize Backup Repository
Run the following command to let Elasticsearch know about the repository:
```json
PUT /_snapshot/snapshots            
{
  "type": "fs",
  "settings": {
      "location": "/usr/share/elasticsearch/data/snapshots",
      "compress": true
  }
}
```

### 3. Check Repositories
List all repositories:
```
GET /_snapshot/*
```

### 4. Create a Snapshot
Take a snapshot:
```
PUT /_snapshot/snapshots/2024-01-30?wait_for_completion=true&pretty
```
`2024-01-30` is the snapshot name; `snapshots` is the repository name.

### 5. Verify Snapshots
List snapshots in the repository:
```
GET /_snapshot/snapshots/*?pretty&verbose=true
```

### 6. Backup Snapshot Directory
In the container, create a tar file of the snapshot folder:
```
cd /var/lib/docker/volumes/elkdata/_data/
tar -czvf ~/snapshots.tar.gz snapshots/
```

### 7. Transfer Backup
Move the `snapshots.tar.gz` to a secure location.

## Restore Process

### 1. Prepare Snapshot Directory
Unzip and place the snapshot directory in the Elasticsearch volume.

### 2. Register Repository
Register the repository (same as in the backup process).

### 3. Verify Snapshot
Check the snapshot:
```
GET /_snapshot/snapshots/*?pretty&verbose=true
```

### 4. Restore Snapshot
Restore the snapshot:
```
POST /_snapshot/snapshots/2024-01-28/_restore
{
}
```

### 5. Troubleshooting
Close indices or remove aliases if necessary:
```json
POST /.ds-.logs-deprecation.elasticsearch-default-2023.12.30-000001/_close
POST /_aliases
{
  "actions": [
    { "remove": { "index": ".kibana-event-log-8.6.1-000001", "alias": ".kibana-event-log-8.6.1" } }
  ]
}
```

## Conclusion
This README provides a quick reference for backing up and restoring Elasticsearch snapshots within Docker. For detailed explanations and additional context, refer to the main guide.

