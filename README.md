# cron

#### Table of Contents

1. [Description](#description)
1. [Setup - The basics of getting started with cron](#setup)
    * [What cron affects](#what-cron-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with cron](#beginning-with-cron)
1. [Usage - Configuration options and additional functionality](#usage)
1. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
    * [Classes](#classes)
    * [Defined types](#defined-types)
1. [Limitations - OS compatibility, etc.](#limitations)
1. [Development - Guide for contributing to the module](#development)

## Description

This module lets you manage the configuration of the cron daemon and more importantly, its jobs.

## Setup

### What cron Affects

### Setup Requirements

### Beginning with cron

## Usage

## Reference

**Classes:**

* [cron::daemon](#crondaemon-class)

**Defined types:**

* [cron::jobfile](#cronjobfile-defined-type)


### Classes

#### cron::daemon class

This class manages the cron package and service.  It is generally unnecessary to include this class directly.  Instead, simply define any `cron::job` or `cron::jobfile` instances you need and this will be included, as necessary.

##### `enable`
Instance is to be started at boot.  Either `true` (default) or `false`.

##### `ensure`
Instance is to be `running` (default) or `stopped`.  Alternatively, a Boolean value may also be used with `true` equivalent to `running` and `false` equivalent to `stopped`.

##### `packages`
An array of package names needed for the cron installation.  The default should be correct for supported platforms.

##### `service`
The service name of the cron daemon.


### Defined types

#### cron::jobfile defined type

This defined type manages a single job configuration file for cron.  The job file may actually consist of any number of cron jobs.

##### `namevar` (required)
An arbitrary identifier for the job instance unless the `filename` parameter is not set in which case this must provide the value normally set with the `filename` parameter.

##### `content`
Literal content for the job file file.  If neither `content` nor `source` is given, the content of the file will be left unmanaged, though other aspects will continue to be managed.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `filename`
Name to be given to the job file file, without any path details.  This may be used in place of `namevar` if it is beneficial to give `namevar` an arbitrary value.

##### `location`
File system path to where the cron job file is to be installed.  Defaults to `/etc/cron.d` which is appropriate for most job files.  See also the `namevar` and `filename` parameters.

##### `mode`
File access mode.  Defaults to `0644` which is appropriate for most job files.  This might need to be something like `0755` if `location` is `/etc/cron.daily` or similar.  If in doubt, consult your CRONTAB(5) man page.

##### `source`
URI of the job file file content.  If neither `content` nor `source` is given, the content of the file will be left unmanaged, though other aspects will continue to be managed.


## Limitations

Tested on modern Fedora and CentOS releases, but likely to work on any Red Hat variant.  Adaptations for other operating systems should be trivial as this module follows the data-in-module paradigm.  See `data/common.yaml` for the most likely obstructions.  If "one size can't fit all", the value should be moved from `data/common.yaml` to `data/os/%{facts.os.name}.yaml` instead.  See `hiera.yaml` for how this is handled.

This should be compatible with Puppet 3.x and is being used with Puppet 4.x as well.

## Development

Contributions are welcome via pull requests.  All code should generally be compliant with puppet-lint.
