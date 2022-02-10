# Changelog

Toutes les changements relatives au projet sont documentés dans ce fichier.

Le format est basé sur [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
et le projet suit les pratiques [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.11.0] - 2021-11-23

### Commit comments

- 📝 Update contributing
- :arrow_up: dbclients v17.8.1.1
- :arrow_up: helm v3.7.1
- :arrow_up: popeye v0.9.8
- :arrow_up: yq v4.14.2
- :arrow_up: k9s v0.25.3
- :arrow_up: kubectx v0.9.4
- :arrow_up: kubectl v1.22.4
- :arrow_up: docker 20.10.11
- :arrow_up: gcloud-sdk 365.0.0
- :arrow_up: kustomize v4.4.1
- :arrow_up: kompose v1.26.0
- :arrow_up: skaffold v1.35.0
- :arrow_up: Teectl v2.5.0

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.10.1] - 2021-05-13

### Commit comments

- :bug: FIX Contextual help for KDT Rules
- :arrow_up: AMF v0.1.0
- :recycle: Suppression de mon profil

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.10.0] - 2021-05-12

### Commit comments

- :zap: Add AMF Change log
- :bug: fix appel bastion
- :bug: fix print-alias makefile content
- :zap: remove DS_Store folder
- :bug: Fix Helm install
- :memo: fix markdown error in docs
- :memo: Update documentations
- :boom: Implement AMF as make file framework
- :zap: Register all modules in all profile
- :zap: Change kustomize bash integration
- :arrow_up: Teectl v2.4.4
- :arrow_up: Skaffold v1.23.0
- :arrow_up: Kompose v1.22.0
- :arrow_up: Kustomize v4.1.2
- :arrow_up: Helm v3.5.4
- :heavy_minus_sign: Remove HELM2
- :arrow_up: Popeye v0.9.1
- :arrow_up: YQ v4.8.0
- :arrow_up: K9s v0.24.9
- :arrow_up: Kube CTX v0.9.3
- :arrow_up: KubeCTL v1.21.0
- :arrow_up: Docker v20.10.6
- :arrow_up: Cloud SDK v339

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.9.4] - 2020-10-29

### Commit comments

- :zap: version stable de TEECTL v2.3
- :zap: maj version teectl
- :bug: Fix upgrade version
- :bug: fix teectl chmod
- url curln

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.9.3] - 2020-10-14

### Commit comments

- :bug: fix traefik URL
- :bug: fix tar
- :bug: fix traefkn

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.9.2] - 2020-10-14

### Commit comments

- ajout dans changelog
- :zap: Ajout de Teectln

### Added

- Ajout de Teectl pour Traefik

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.9.1] - 2020-09-28

### Commit comments

- :arrow_up: Update version of Skaffold to v1.14.0
- :arrow_up: Update version of Kustomize to v3.8.4
- :arrow_up: Update version of popeye to v0.8.10
- :arrow_up: Update version of YQ to v3.4.0
- :arrow_up: Update version of k9s to v0.22.1
- :arrow_up: Update version of Kubectx to v0.9.1
- :arrow_up: Update version of Kubectl to v1.19.2
- :arrow_up: Update version of docker client to v19.03.13
- :arrow_up: Update version of google/cloud-sdk to v311.0.0
- :bug: Fix profile auto save/update
- :bug: Fix check update and auto update detectorn

### Added

- :arrow_up: Update version of google/cloud-sdk to v311.0.0
- :arrow_up: Update version of docker client to v19.03.13
- :arrow_up: Update version of Kubectl to v1.19.2
- :arrow_up: Update version of Kubectx to v0.9.1
- :arrow_up: Update version of k9s to v0.22.1
- :arrow_up: Update version of YQ to v3.4.0
- :arrow_up: Update version of popeye to v0.8.10
- :arrow_up: Update version of Kustomize to v3.8.4
- :arrow_up: Update version of Skaffold to v1.14.0

### Changed

### Deprecated

### Removed

### Fixed

- :bug: Fix check update and auto update detector
- :bug: Fix profile auto save/update

### Security

## [0.9.0] - 2020-09-14

### Commit comments

- :heavy_plus_sign: Auto update detector
- :recycle: Rebasculer les dossiers Kubernetes GCloud dans les dossiers standards
- :bug: Correction webhook slack pour le channel Dev
- :bug: Paramètre DOCKER activation automatique de AS_ROOT
- Kube CTX Fix
- SKAFFOLD
- FIX Kustomize
- FIX Helm
- FIX Docker
- SKAFFOLD
- :sparkles: Amélioration du mode Debug
- :bug: Fix de la sauvegarde du profile
- :sparkles: Mise en place des URL en plus des versions en variable docker
- :sparkles: installation du client docker uniquement
- Merge branch ‘bddsClient‘ into ‘master‘
- doc sqlcmd + dns name mssql
- doc sqlcmd
- add mssql to path
- DBCLIENTS README.md
- KDT Feature DBCLIENTSn

### Added

- :heavy_plus_sign: Fonctionnalité dbclients
- :heavy_plus_sign: Auto update detector

### Changed

- :sparkles: installation du client docker uniquement
- :sparkles: Mise en place des URL en plus des versions en variable docker
- :sparkles: Amélioration du mode Debug

### Deprecated

### Removed

- :recycle: Rebasculer les dossiers Kubernetes GCloud dans les dossiers standards pour
  pour compatibilité avec des exécutions kubectl sur la machine hôte.

### Fixed

- :bug: Fix de la sauvegarde du profile
- :bug: Paramètre DOCKER activation automatique de AS_ROOT
- :bug: Correction webhook slack pour le channel Dev

### Security

## [0.8.1] - 2020-07-23

### Commit comments

- :bug: fix gitlab-ci pour la notification
- :sparkles: Ajout du message d‘alert nouvelle version via la CI gitlab.
- :sparkles: Ajout de la sauvegarde du profile sélectionné.
- :fix: upgrade cmd avec last tag version
- :bug: fix splash quand QUIET est actif
- :heavy_plus_sign: Ajout de la commande upgrade pour la mise à jour automatique.
- :zap: Auto inclusion de quand CMD est invoqué.
- :bug: Activation volume partagés avec le user Root quand celui-ci est actif.
- :zap: Si option actif l‘option est automatiquement actif aussi.
- :heavy_plus_sign: Ajout des alias docker dcc et dci pour le nettoyage de docker.n

### Added

- :heavy_plus_sign: Ajout des alias docker dcc et dci pour le nettoyage de docker.
- :heavy_plus_sign: Ajout de la commande upgrade pour la mise à jour automatique.
- :sparkles: Ajout de la sauvegarde du profile sélectionné.
- :sparkles: Ajout du message d'alert nouvelle version via la CI gitlab.

### Changed

- :zap: Si option `DOCKER` actif l'option `AS_ROOT` est automatiquement actif aussi.
- :zap: Auto inclusion de `/bin/bash -ic` quand CMD est invoqué.

### Deprecated

### Removed

### Fixed

- :bug: Activation volume partagés avec le user Root quand celui-ci est actif.

### Security

## [0.8.0] - 2020-07-22

### Commit comments

- :sparkles: Ajout des profiles pour le build
- :sparkles: Possibilité de monter plusieurs ports sur une même instance de KDT
- :wastebasket: Netoyage d‘éléments inutiles
- :wastebasket: Suppression de wget
- :wastebasket: Suppression de Google Command Interactive
- :pencil: Mise à jour de la documentation
- :wastebasket: Suppression de Krewn

### Added

- :sparkles: Ajout des profiles pour le build
- :sparkles: Possibilité de monter plusieurs ports sur une même instance de KDT

### Changed

- :wastebasket: Netoyage d'éléments inutiles
- :pencil: Mise à jour de la documentation

### Deprecated

### Removed

- :wastebasket: Suppression de Krew
- :wastebasket: Suppression de Google Command Interactive
- :wastebasket: Suppression de wget

### Fixed

### Security

## [0.7.2] - 2020-06-17

### Commit comments

- :zap: Ajout de la capacité d‘exécuter directement des commandes
- :recycle: Suppression d‘éléments inutile dans le changelog
- :bug: Correction de la comparaison dans le changelogn

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security

## [0.7.1] - 2020-06-17

### Commit comments

- :bug: Fix changelog updaten

### Added

### Changed

### Deprecated

### Removed

### Fixed

### Security




[Unreleased]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkitcompare/v0.11.0...master
[0.11.0]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkitcompare/v0.10.1...v0.11.0
[0.10.1]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkitcompare/v0.10.0...v0.10.1
[0.10.0]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkitcompare/v0.9.4...v0.10.0
[0.9.4]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.9.3...v0.9.4
[0.9.3]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.9.2...v0.9.3
[0.9.2]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.9.1...v0.9.2
[0.9.1]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.9.0...v0.9.1
[0.9.0]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.8.1...v0.9.0
[0.8.1]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.8.0...v0.8.1
[0.8.0]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.7.2...v0.8.0
[0.7.2]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.7.1...v0.7.2
[0.7.1]: https://gitlab.com/dolmen-tech/tools/k8s-devops-toolkit/compare/v0.7.0...v0.7.1
