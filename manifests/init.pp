#
# == Class: cron
#
# Manages the cron daemon.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-cron Puppet module.
# Copyright 2011-2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


class cron (
        Ddolib::Service::Ensure $ensure,
        Boolean                 $enable,
        Hash[String[1], Hash]   $jobfiles,
        Hash[String[1], Hash]   $jobs,
        Array[String]           $packages,
        String                  $service,
    ) {

    package { $packages:
        ensure => installed,
        notify => Service[$service],
    }

    service { $service:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

    create_resources(cron::job, $jobs)
    create_resources(cron::jobfile, $jobfiles)

}
