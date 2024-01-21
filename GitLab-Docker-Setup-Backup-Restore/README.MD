# GitLab Docker Backup and Restore Tutorial

This repository provides a comprehensive guide on how to backup and restore a GitLab instance running in a Docker container. This process is crucial for ensuring the safety and integrity of your GitLab data.

## Prerequisites

Before you begin, ensure you have a running GitLab container. If you haven't set this up yet, please refer to the [GitLab Docker Setup Guide](link-to-another-repo-for-setup).

## Backup Process

### Step 1: Create a GitLab Backup

Run the following command to create a backup of your GitLab instance. This command triggers GitLab's built-in backup utility:

```bash
docker exec -it gitlab gitlab-backup create
```

### Step 2: Copy Backup Files from Container

After creating the backup, you need to copy the backup files from your Docker container to your host machine:

- Backup archive:
  ```bash
  docker cp gitlab:/var/opt/gitlab/backups/backupfile.tar .
  ```
- GitLab's secrets file:
  ```bash
  docker cp gitlab:/etc/gitlab/gitlab-secrets.json .
  ```
- GitLab's configuration file:
  ```bash
  docker cp gitlab:/etc/gitlab/gitlab.rb .
  ```

### Step 3: Organize Backup Files

Move the copied backup files (`backupfile.tar`, `gitlab-secrets.json`, and `gitlab.rb`) to a new directory. This directory will be used for restoring GitLab in a new Docker container.

## Restore Process

### Step 4: Prepare New Docker Container

Set up a new Docker container for GitLab. Ensure it's properly configured and ready for the restore process.

### Step 5: Copy Backup Files to New Container

Copy the backup files from your host machine to the new Docker container:

- Backup archive:
  ```bash
  docker cp backupfile.tar gitlab:/var/opt/gitlab/backups/
  ```
- Secrets and configuration files:
  ```bash
  docker cp gitlab-secrets.json gitlab:/etc/gitlab/
  docker cp gitlab.rb gitlab:/etc/gitlab/
  ```

### Step 6: Restore Backup

Execute the following command in your new GitLab container to start the restoration process:

```bash
docker exec -it gitlab gitlab-backup restore
```

This command will use the backup files you've placed in the container to restore your GitLab instance.

### Step 7: Restart GitLab

After the restoration process is complete, restart the GitLab instance to apply the changes:

```bash
docker exec -it gitlab gitlab-ctl restart
```

## Access Restored GitLab Instance

Once the new GitLab instance is up and running, you can access it using the same credentials as your old instance. All your data, including projects, users, and configurations, should be as they were at the time of the backup.

## Conclusion

This guide covers the essential steps for backing up and restoring a GitLab instance running in a Docker container. Regular backups are vital for data integrity and disaster recovery. For more advanced configurations and troubleshooting, refer to the official [GitLab documentation](https://docs.gitlab.com/ee/administration/backup_restore/backup_gitlab.html?tab=Docker).

