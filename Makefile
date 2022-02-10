##############################################################
#    ______   _______  ___      __   __  _______  __    _
#   |      | |       ||   |    |  |_|  ||       ||  |  | |
#   |  _    ||   _   ||   |    |       ||    ___||   |_| |
#   | | |   ||  | |  ||   |    |       ||   |___ |       |
#   | |_|   ||  |_|  ||   |___ |       ||    ___||  _    |
#   |       ||       ||       || ||_|| ||   |___ | | |   |
#   |______| |_______||_______||_|   |_||_______||_|  |__|
#                     K8S DEVOPS TOOLKIT
##############################################################
## Author: Brice BROUSSOLLE <brice.broussolle@dolmen-tech.com
## Contributors: Cheunn Nourry <cheunn.nourry@dolmen-tech.com> / <cnourry.dev@protonmail.com>
##############################################################

-include mk/modules/version-standalone.mk
APP_NAME = KDT
VERSION_MAJOR = 0
VERSION_MINOR = 12
VERSION_PATCH = 0
VERSION_PRE_ID =
VERSION_PRE_NB = 0

-include mk/modules/splash.mk
_TITLE := \
H4sIAD43fV4AA3VQ2w2EMAz77xQe4wY4PhBIPQnErxfx8NAkfQC6qoocx07SgnYAsCJPjYkwlIxHkiuEAJAs9SAqm\
Fqyq2JjU/Np643KRC/RbT7IO+mvTWXJxhQbm62tdBeN01htY+0BJFrsjWK1JP8kIcCl6yDecmeuTAmvs3w2fKcj/z\
bsOa/LvJ8yr90opQEAAA==

# include mk/modules/amf-update-autocheck.mk

-include mk/modules/changelog-git-diff.mk
CHANGELOG_URL = https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit

-include mk/main.mk
AMF_VERSION_EARLY_MODE = true

IMAGE_NAME := dolmen/kdt
_OVERIDES_FILES := Dockerfile .bashrc
.DEFAULT_GOAL := attach
LB_HELP_OPTIONS := Global options

# PUBLIC TASKS
###############

PHONY += attach
ifeq ($(HELP),true)
attach: .init	##@Commands Start KDT container
	@echo "Usage: make attach"
	@echo
	@echo "The $(_BOLD)attach$(_END) rule run a KDT container"
	@echo
	@echo "${_WHITE}Options:${_END}"
	$(call _PRINT_OPTION,FOLDER,,Define folder to be mounted into the container)
	$(call _PRINT_OPTION,DOCKER,false,Define if container need to implement Docker\
	°daemon into the container)
	$(call _PRINT_OPTION,AS_ROOT,false,Define if container user is root)
	$(call _PRINT_OPTION,PORT,,Set a list of ports pushed to the host.\
	°Ports must be seperated by a comma)
	$(call _PRINT_OPTION,CMD,,Command executed only if is set)
	$(call _PRINT_OPTION,NETWORK,,ah ah I don t know)
	@echo
	$(call _OPT_DISPLAY)
	@echo "${_WHITE}Example:${_END}"
	@echo "  make attach"
	@echo "  make attach PORT=8080"
	@echo "  kdt PORT=9090,8080 DOCKER=true AS_ROOT=true CMD='my cmd'"
	@echo
else
FOLDER?=
PORT:=false
NETWORK:=false
DATE:=`date +'%Y%m%d-%H%M%S'`
HOSTNAME:=kdt-$(DATE)
DOCKER:=false
AS_ROOT:=$(if $(filter-out $(DOCKER),false),true,false)
CMD:=false
attach: .init
ifeq ($(QUIET),)
	$(call _PRINT_CMD,Attach KDT v$(VERSION) container)
endif
	$(eval ENV_ARGS := --rm --name "kdt-$(DATE)")
ifneq ($(FOLDER),)
	$(eval ENV_ARGS := $(ENV_ARGS) -v $(FOLDER):/home/devops/mounted -w /home/devops/mounted )
endif
ifneq ($(DOCKER),false)
	$(eval ENV_ARGS := $(ENV_ARGS) -v /var/run/docker.sock:/var/run/docker.sock:rw)
endif
ifneq ($(CMD),false)
	$(eval _CMD := /bin/bash -ic '$(CMD)')
endif
ifneq ($(AS_ROOT),false)
	$(eval ENV_ARGS= $(ENV_ARGS) -u root)
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.kube:/root/.kube:Z)
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.config:/root/.config/:Z)
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.history-kdt:/root/.bash_history:Z)
else
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.kube:/home/devops/.kube:Z)
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.config:/home/devops/.config/:Z)
	$(eval ENV_ARGS=$(ENV_ARGS) -v $(HOME)/.history-kdt:/home/devops/.bash_history:Z)
endif
ifneq ($(PORT),false)
	$(eval PORTS= $(subst $(_OPT_SEP), ,$(PORT)))
	$(foreach p, $(PORTS), $(eval ENV_ARGS= $(ENV_ARGS) -p $(p):$(p)))
endif
ifneq ($(NETWORK),false)
	$(eval ENV_ARGS= $(ENV_ARGS) --network="$(NETWORK)" )
endif
ifeq (,$(wildcard $(HOME)/.history-kdt))
	$(shell touch $(HOME)/.history-kdt)
endif
	$(eval ENV_ARGS=$(ENV_ARGS) --hostname $(HOSTNAME))
	@docker run --privileged -it $(ENV_ARGS) $(IMAGE_NAME):$(VERSION) $(_CMD)
endif

PHONY += build
ifeq ($(HELP),true)
build: .init	##@Application Build Docker image from current sources
	@echo "Usage: make build"
	@echo
	@echo "The $(_BOLD)build$(_END) rule build docker image for KDT"
	@echo
	@echo "${_WHITE}Options:${_END}"
	$(call _PRINT_OPTION,PROFILE,Default,User profile definition\
	°Available values are all files present in the\
	°$(_BOLD)profiles folder$(_END))
	@echo
	$(call _OPT_DISPLAY)
	@echo "${_WHITE}Example:${_END}"
	@echo "  make build"
	@echo "  make build PROFILE=all"
	@echo
else
PROFILE?=$(if $(wildcard $(PROJECT_DIR).profile),$(shell cat $(PROJECT_DIR).profile),none)
build: .init
	$(call _PRINT_CMD,Build KDT v$(VERSION))
	$(call _PRINT_TASK,Clean directory)
	@cd $(PROJECT_DIR) && git checkout .

	$(if $(filter "$(PROFILE)", "none"), \
		@echo "> No profile activated", \
		$(call _APPLY_PROFILE) \
	)

	$(call _PRINT_TASK,Create docker image)
	@cd $(PROJECT_DIR) && docker build \
	--build-arg PROFILE=$(PROFILE) \
	-t "$(IMAGE_NAME):$(VERSION)" . $(SHELL_DEBUG)

	$(call _PRINT_TASK,Restore files)
	@cd $(PROJECT_DIR) && git checkout $(_OVERIDES_FILES) $(SHELL_DEBUG)
endif

PHONY += print-alias
ifeq ($(HELP),true)
print-alias: .init	##@Other Print shortcut command for your alias file
	@echo "Usage: make print-alias"
	@echo
	@echo "The $(_BOLD)print-alias$(_END) rule give the line for used by the"
	@echo "user shell."
	@echo
	$(call _OPT_DISPLAY)
	@echo "${_WHITE}Example:${_END}"
	@echo "  make print-alias"
	@echo
else
print-alias:
	@echo "make -f $(CURDIR)/Makefile -I $(CURDIR)/ FOLDER=\\\`pwd\\\`"
endif
# PRIVATE TASKS
################

define _APPLY_PROFILE
	$(call _PRINT_TASK,Apply profile '$(PROFILE)')
	@echo "$(PROFILE)" > $(PROJECT_DIR).profile
	@if [ ! -f "$(PROJECT_DIR)profiles/$(PROFILE)" ]; then \
		echo "-> Profile not exist in folder '$(PROJECT_DIR)profiles'"; \
		exit 2; \
	 fi
	$(foreach file,$(_OVERIDES_FILES),$(call _APPLY_PROFILE_TO_FILE,$(file))${\n})
endef

define _APPLY_PROFILE_TO_FILE
	$(call _PRINT_SUBTASK,Apply profile to file '$(1)')
	@echo "-> Modify file '$(1)'"
	$(foreach feature,$(shell cat "$(PROJECT_DIR)profiles/$(PROFILE)"),$(call _APPLY_FEATURE_TO_FILE,$(PROJECT_DIR)$(1),$(feature))${\n})
endef

define _APPLY_FEATURE_TO_FILE
	@echo "--> Apply feature '$(2)' to file '$(1)'"
	@export LINE_START="`grep -nr "## FEATURE $(2)" $(1) | cut -d : -f2`" \
	&& export LINE_END="`grep -nr "## END FEATURE $(2)" $(1) | cut -d : -f2`" \
	&& if [[ "$${LINE_START}" == "" ]]; then \
			echo "---> Not Found"; \
		 elif [[ "$${LINE_END}" == "" ]]; then \
		 	echo "---> Malformed" ; \
		 else \
		 	sed -i.bak "$${LINE_START},$${LINE_END}s/# *//" $(1); \
			echo "---> Activated" ; \
		 fi
endef

define _UPDATE_NEEDS
	@echo "${_BOLD}${_YELLOW}KDT needs to be updated${_END}"
	@if $(MAKE) .prompt-yesno message="Do you want to updates KDT now" 2> /dev/null; then \
		$(MAKE) QUIET=true upgrade; \
		exit; \
	fi
endef
