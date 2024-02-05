# MongoDB Backup and Restore Guide for Docker Containers

This guide provides detailed instructions on how to back up and restore a MongoDB database running inside a Docker container on a server.

## Prerequisites

- SSH access to the server hosting your MongoDB container.
- Docker installed on your server.
- MongoDB database running inside a Docker container.

## Backup Process

### 1. SSH to the Server

First, log in to the server hosting your MongoDB container using SSH:

```bash
ssh your_username@your_server_address
```

Replace `your_username` and `your_server_address` with your server's login credentials and address.

### 2. Backup MongoDB Using docker exec

Run `mongodump` inside your MongoDB container to create a backup:

```bash
docker exec -it database mongodump --db dbName --authenticationDatabase admin -u root -p "password" --archive=/tmp/mongo_backup_myserver_$(date +"%Y-%m-%d").gz --gzip
```

**Command Explanation:**

- `docker exec -it database`: Executes a command in a running container named `database`.
- `mongodump`: Utility for creating a backup of the MongoDB database.
- `--db dbName`: Specifies the database name to be backed up.
- `--authenticationDatabase admin`: Uses the `admin` database for authentication.
- `-u root -p "password"`: MongoDB credentials (username: `root`, password: `password`).
- `--archive=...`: Path in the container where the backup will be saved, with the current date in the file name.
- `--gzip`: Compresses the backup file using gzip.

### 3. Copy the Backup File from the Container to the Server

After the backup is created, copy it from the Docker container to the server's file system:

```bash
docker cp database:/tmp/mongo_backup_myserver_$(date +"%Y-%m-%d").gz /desired/path/on/server
```

**Command Explanation:**

- `docker cp`: Copies files/folders between a Docker container and the local filesystem.
- `database`: The name of your Docker container.
- `/tmp/mongo_backup_myserver_YYYY-MM-DD.gz`: The source path in the container (replace `YYYY-MM-DD` with the actual date).
- `/desired/path/on/server`: The destination path on your server.

## Restore Process

### 1. Transfer the Backup File To Destination Server (if needed)

If the backup file is not on the server where you intend to restore the database, upload it using `scp`:

```bash
scp /local/path/mongo_backup_myserver_YYYY-MM-DD.gz your_username@your_server_address:/tmp
```

Replace `YYYY-MM-DD` with the actual date of the backup.

### 2. Copy the Backup File from the Server to the Container

After the backup is transferred to the destination server, copy it from the system to the Docker container:

```bash
docker cp /tmp/mongo_backup_myserver_YYYY-MM-DD.gz database:/tmp/mongo_backup_myserver_YYYY-MM-DD.gz
```

### 3. Restore MongoDB Using docker exec

Restore the database from the backup file:

```bash
docker exec -it database mongorestore --authenticationDatabase admin -u root -p "password" --archive=/tmp/mongo_backup_myserver_YYYY-MM-DD.gz --gzip
```

**Command Explanation:**

- Similar to the backup process, specifying the authentication details and the backup file path.

### 4. Verify the Restoration

Connect to your MongoDB instance and verify that the data has been restored correctly.

## Conclusion

This guide covers the essential steps for backing up and restoring MongoDB databases running in Docker containers. It's crucial to regularly backup your data to prevent loss and ensure that your backup procedures are correctly followed and tested regularly for data integrity.

```

Replace placeholders like `your_username`, `your_server_address`, `dbName`, and `/desired/path/on/server` with actual values when you implement the guide.
