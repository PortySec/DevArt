# GitLab Docker Backup and Restore Tutorial

This repository provides a comprehensive guide on how to backup and restore a GitLab instance running in a Docker container. This process is crucial for ensuring the safety and integrity of your GitLab data.

## Prerequisites

Before you begin, ensure you have a running GitLab container. If you haven't set this up yet, please refer to the [GitLab Docker Setup Guide](link-to-another-repo-for-setup).

### Important Considerations

**Consideration 1: Manual Restoration of Configuration Files**
- Ensure accurate manual restoration of `gitlab-secrets.json` and `gitlab.rb`. Improper handling of these files can cause data inconsistencies and authentication issues.

**Consideration 2: Matching GitLab Versions and Backup Types**
- The GitLab versions for backup and restoration must match to avoid errors or data loss. Also, ensure consistency in backup types (full or incremental) between the processes.

**Consideration 3: Sufficient Storage Space**
- Verify that there is adequate storage space on both the source and target systems for the backup and restoration processes. Insufficient space can lead to incomplete backups or failed restoration.

**Consideration 4: Network Stability**
- Ensure a stable network connection during the backup and restore processes, especially if your GitLab instance is large. Interruptions in network connectivity can corrupt the backup or restore process.

**Consideration 5: Testing Backup Integrity**
- Test the integrity of the backup file before proceeding with the restoration. This can be done by attempting a test restore on a separate system. This step helps to identify any potential issues with the backup file before it's needed for a critical restoration.

**Consideration 6: Regular Backup Verification**
- Regularly verify your backup process and backup files. This practice ensures that you always have a reliable and recent backup available in case of emergencies.

**Consideration 7: Access Control and Security**
- Maintain strict access control and security practices during the backup and restore process. Handle sensitive data (like `gitlab-secrets.json`) with care to prevent unauthorized access.

**Consideration 8: Familiarity with GitLab Documentation**
- Familiarize yourself with the official [GitLab documentation](https://docs.gitlab.com). The documentation provides valuable insights and detailed procedures that can be crucial in specific scenarios.

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

