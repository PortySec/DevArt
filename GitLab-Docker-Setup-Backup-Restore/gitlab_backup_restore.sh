#!/bin/bash

# Set variables
GITLAB_CONTAINER_NAME="gitlab"
BACKUP_DIR="/path/to/backup/directory" # Change this to your backup directory path
NEW_GITLAB_CONTAINER_NAME="new_gitlab" # Name of your new GitLab container

# Step 1: Create a GitLab Backup
echo "Creating GitLab backup..."
docker exec -it $GITLAB_CONTAINER_NAME gitlab-backup create

# Step 2: Copy Backup Files from Container
echo "Copying backup files from container..."
docker cp $GITLAB_CONTAINER_NAME:/var/opt/gitlab/backups/backupfile.tar $BACKUP_DIR
docker cp $GITLAB_CONTAINER_NAME:/etc/gitlab/gitlab-secrets.json $BACKUP_DIR
docker cp $GITLAB_CONTAINER_NAME:/etc/gitlab/gitlab.rb $BACKUP_DIR

# Step 3: Prepare New Docker Container (Assuming the container is already set up and ready)

# Step 4: Copy Backup Files to New Container
echo "Copying backup files to new container..."
docker cp $BACKUP_DIR/backupfile.tar $NEW_GITLAB_CONTAINER_NAME:/var/opt/gitlab/backups/
docker cp $BACKUP_DIR/gitlab-secrets.json $NEW_GITLAB_CONTAINER_NAME:/etc/gitlab/
docker cp $BACKUP_DIR/gitlab.rb $NEW_GITLAB_CONTAINER_NAME:/etc/gitlab/

# Step 5: Restore Backup
echo "Restoring backup in new container..."
docker exec -it $NEW_GITLAB_CONTAINER_NAME gitlab-backup restore

# Step 6: Restart GitLab
echo "Restarting GitLab..."
docker exec -it $NEW_GITLAB_CONTAINER_NAME gitlab-ctl restart

echo "Backup and restore process completed."
