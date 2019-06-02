<!--
This file is part of the doubledog-cron Puppet module.
Copyright 2018-2019 John Florian <jflorian@doubledog.org>
SPDX-License-Identifier: GPL-3.0-or-later
-->
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

Here is a pair of quick and useful examples I apply to all of my Puppet nodes.

```puppet
::cron::job { 'puppet-failsafe':
    hour    => '5',
    minute  => '55',
    command => "systemctl is-active puppet &> /dev/null || systemctl status puppet | mailx -s 'Puppet Inactive on ${::hostname}' root",
}

$get_env_cmd = "$(puppet config print environment --section agent)"

::cron::job { 'puppet-env-check':
    hour    => '5',
    minute  => '57',
    command => "test ${get_env_cmd} = 'production' || echo \"The default environment is presently '${get_env_cmd}'.\" | mailx -s 'Puppet on ${::hostname} not using production environment' root",
}
```


## Reference

**Classes:**

* [cron::daemon](#crondaemon-class)

**Defined types:**

* [cron::job](#cronjob-defined-type)
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

#### cron::job defined type

This defined type manages a single job configuration for cron.  It provides full parametric control of the job definition from Puppet.  If you would rather just push a file with the relevant content, look to `cron::jobfile` instead.

##### `namevar` (required)
An arbitrary identifier for the job instance unless the `filename` parameter is not set in which case this must provide the value normally set with the `filename` parameter.

##### `ensure`
Instance is to be `present` (default) or `absent`.  Alternatively, a Boolean value may also be used with `true` equivalent to `present` and `false` equivalent to `absent`.

##### `filename`
Name to be given to the job file file, without any path details.  This may be used in place of `namevar` if it is beneficial to give `namevar` an arbitrary value.

##### `location`
File system path to where the cron job file is to be installed.  Defaults to `/etc/cron.d` which is appropriate for most job files.  See also the `namevar` and `filename` parameters.

##### `mailto`
Any stdout/stderr will be mailed here.  May be a user name for localhost mail or a fully qualified email address.  If set to `""` (an empty string), no mail will be sent.  Defaults to `root`.

##### `mode`
File access mode.  Defaults to `0644` which is appropriate for most job files.  This might need to be something like `0755` if `location` is `/etc/cron.daily` or similar.  If in doubt, consult your CRONTAB(5) man page.

##### `path`
The environment `PATH` to be used while running `command`.  Defaults to `/sbin:/bin:/usr/sbin:/usr/bin`.

##### `user`
Identity that cron should should assume when running the command.  Defaults to "root".


**The following parameters are passed directly into the crontab.  They are  implementation dependent and are not validated here.  Consult your CRONTAB(5) man page for specifications.**

##### `command` (required)
Command to be executed by cron.  Some implementations allow magic characters (e.g., `%`) leading to special features.

##### `dom`
A string expressing the days of the month that the job is to be executed.  Typically an integer ranging from `1` to `31` but often may allow ranges, lists and step values.  The default is `*`.

##### `dow`
A string expressing the days of the week that the job is to be executed.  Typically an integer ranging from `0` (Sunday) to `7` (also Sunday) but often may allow ranges, lists and step values.  Mnemonics (e.g., `Fri`) are often accepted.  The default is `*`.

##### `hour`
A string expressing the hours of the day that the job is to be executed.  Typically an integer ranging from `0` to `23` but often may allow ranges, lists and step values.  The default is `*`.

##### `minute`
A string expressing the minutes of the hour that the job is to be executed.  Typically an integer ranging from `0` to `59` but often may allow ranges, lists and step values.  The default is `*`.

##### `month`
A string expressing the months of the year that the job is to be executed.  Typically an integer ranging from `1` (January) to `12` (December) but often may allow ranges, lists and step values.  Mnemonics (e.g., `Oct`) are often accepted.  The default is `*`.


#### cron::jobfile defined type

This defined type manages a single job configuration file for cron.  The job file may actually consist of any number of cron jobs.  It provides a brute force approach where Puppet is merely dealing with a file (static or dynamic via a template) containing the (presumed) correct content.  For full parametric control of the job definition from Puppet, look to `cron::job` instead.

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
