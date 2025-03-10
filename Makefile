SHELL := /bin/bash

# https://ibm-mas.github.io/ansible-devops/playbooks/oneclick-core/
# Other actions - add components|update|upgrade|uninstall|backup|restore

# Catalog Versions - https://ibm-mas.github.io/cli/catalogs/
# v9-250306-amd64
# v9-250206-amd64
# v9-250109-amd64
# v9-241205-amd64
# v9-241107-amd64
# v9-241003-amd64
# v9-240827-amd64
# v9-240730-amd64
# v9-240625-amd64
# v8-240528-amd64
# v8-240430-amd64
# v8-240405-amd64
# v8-240326-amd64


# Default goal when no target is specified
.DEFAULT_GOAL := help

# Variables
VIRTUALENV ?= "venv"
CONFIGPATH ?= "ansible.cfg"
TEMPFILE ?= "temp_file"

# Help target
.PHONY: help
help:
	@echo "Usage:"
	@echo "  make virtualenv               - Create a virtual environment and install dependencies"
	@echo "  make deploy-mas               - Deploy MAS using Ansible"
	@echo "  make deploy-mas-full          - Deploy full MAS installation"
	@echo "  make restore-mas              - Restore MAS and its components"
	@echo "  make install-mas-dependencies - Install MAS Dependencies"
	@echo "  make uninstall-mas            - Uninstall MAS and its components"
	@echo "  make backup-mas               - Backup MAS and its components"
	@echo "  make restore-mas              - Restore MAS and its components"
	@echo "  make upgrade-mas              - Upgrade MAS"
	@echo "  make update-mas               - update MAS"

# Target to create virtual environment and configure Ansible
.PHONY: virtualenv
virtualenv:
	# Remove old ansible.cfg and virtual environment if they exist
	rm -rf $(CONFIGPATH) $(VIRTUALENV)
	# Create a new virtual environment
	LC_ALL=en_US.UTF-8 python3 -m venv $(VIRTUALENV) --prompt "MAS on ROSA Ansible Environment"
	# Activate virtual environment and install dependencies
	@echo "Activating virtual environment and installing dependencies..."
	source $(VIRTUALENV)/bin/activate && \
	pip3 install --upgrade pip setuptools && \
	pip3 install openshift-client ansible-lint junit_xml pymongo xmljson jmespath kubernetes openshift && \
	pip3 install boto3 botocore && \
	ansible-galaxy collection install community.general community.okd amazon.aws community.aws ibm.mas_devops && \
	ansible-config init --disabled -t all > $(CONFIGPATH) && \
	awk 'NR==2{print "callbacks_enabled=ansible.posix.profile_tasks"} 1' $(CONFIGPATH) > $(TEMPFILE) && \
	cat $(TEMPFILE) > $(CONFIGPATH) && \
	rm -rf $(TEMPFILE) && \
	deactivate 

# Target to deploy MAS Full
.PHONY: deploy-mas-full
deploy-mas-full:
	source $(VIRTUALENV)/bin/activate && \
	ansible-playbook mas-deployment-prep.yaml && \
	source artefacts/setenv-install.sh && \
	ansible-playbook ibm.mas_devops.oneclick_core && \
	deactivate

# Target to deploy MAS
.PHONY: deploy-mas
deploy-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/setenv-install.sh && \
	ansible-playbook ibm.mas_devops.oneclick_core && \
	deactivate

# Target to Install MAS Dependencies
.PHONY: install-mas-dependencies
install-mas-dependencies:
	source $(VIRTUALENV)/bin/activate && \
	ansible-playbook mas-deployment-prep.yaml && \
	deactivate

# Target to delete MAS Dependencies
.PHONY: remove-mas-dependencies
remove-mas-dependencies:
	source $(VIRTUALENV)/bin/activate && \
	ansible-playbook mas-remove-prep.yaml && \
	deactivate

# Target to uninstall MAS 
.PHONY: uninstall-mas
uninstall-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/mas-uninstall.sh && \
    ansible-playbook ibm.mas_devops.uninstall_core && \
	deactivate

# Target to Backup MAS and its components
.PHONY: backup-mas
backup-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/mas-backup.sh && \
	ansible-playbook mas-backup.yaml && \
	deactivate

# Target to Backup MAS and its components
.PHONY: restore-mas
restore-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/mas-backup.sh && \
	ansible-playbook mas-restore.yaml && \
	deactivate

# Target to Upgrade MAS and its components
.PHONY: upgrade-mas
upgrade-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/mas-upgrade.sh && \
	ansible-playbook ibm.mas_devops.oneclick_upgrade && \
	deactivate

# Target to Update MAS and its components
.PHONY: update-mas
update-mas:
	source $(VIRTUALENV)/bin/activate && \
	source artefacts/mas-upgrade.sh && \
	ansible-playbook ibm.mas_devops.oneclick_update && \
	deactivate
