.PHONY: run

run:
	ansible-playbook --inventory ./inventory backup-pvs.yml
