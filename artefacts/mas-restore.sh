export MAS_INSTANCE_ID="mas1"
export MASBR_STORAGE_LOCAL_FOLDER="artefacts/backup"
export MASBR_LOCAL_TEMP_FOLDER="artefacts/backup-temp"
export MASBR_ACTION=restore
export MASBR_BACKUP_TYPE=full # full|incr
export MASBR_BACKUP_FROM_VERSION="" #YYYMMDDHHMMSS e.g 202503011030. Latest if empty
export MASBR_RESTORE_OVERWRITE=Yes
export DB2_INSTANCE_NAME==db2w-shared
export MAS_WORKSPACE_ID=ws1

# ibm.mas_devops.br_mongodb -  mongodb backup
# ibm.mas_devops.br_db2 - DB2 Backup and restore
# ibm.mas_devops.br_core - Core backup and restore
# ibm.mas_devops.br_manage - Backup and restore of mongodb, db2, core, manage
# ibm.mas_devops.br_iot - Backup and restore of mongodb, db2, core, iot
# ibm.mas_devops.br_monitor - Backup and restore of mongodb, db2, core, iot, monitor
# ibm.mas_devops.br_health - Backup and restore of mongodb, db2, core, manage, health
# ibm.mas_devops.br_optimizer - Backup and restore of mongodb, db2, suite_backup_restore, suite_backup_restore
# ibm.mas_devops.br_visualinspection - Back and restore of mongodb, suite_back_restore and visualinspection



