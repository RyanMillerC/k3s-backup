.PHONY: run

run:
	ansible-playbook --inventory ./inventory backup-apps.yml
