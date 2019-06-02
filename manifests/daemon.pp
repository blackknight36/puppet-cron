#
# == Class: cron::daemon
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


class cron::daemon (
        Ddolib::Service::Ensure $ensure,
        Boolean                 $enable,
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

}
