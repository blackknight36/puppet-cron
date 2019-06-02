<!--
This file is part of the doubledog-cron Puppet module.
Copyright 2018-2019 John Florian
SPDX-License-Identifier: GPL-3.0-or-later

Template

## [VERSION] DATE/WIP
### Added
### Changed
### Deprecated
### Removed
### Fixed
### Security

-->

# Change log

All notable changes to this project (since v1.2.0) will be documented in this file.  The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [2.0.0] WIP
### Added
- Fedora 28-30 support
- dependency on the `doubledog-ddolib` module
- `cron` class
- `cron::jobs` and `cron::jobfiles` parameters to permit entire control via Hiera
- `Cron::Timespec` data type
### Changed
- eliminated absolute namespaces in Puppet resource references
- `cron` class becomes simply `cron`
- `cron::job` parameters `minute`, `hour`, `dom`, `month` and `dow` now allow integers (in addition to strings)
### Deprecated
### Removed
- Fedora 25-27 support
- `cron` class
### Fixed
- `cron::job::ensure` and `cron::jobfile::ensure` cannot accept Boolean values
### Security

## [1.2.0 and prior] 2018-12-15

This and prior releases predate this project's keeping of a formal CHANGELOG.  If you are truly curious, see the Git history.
