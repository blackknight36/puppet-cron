# modules/cron/manifests/daemon.pp
#
# == Class: cron::daemon
#
# Configures a host as a cron daemon.
#
# === Parameters
#
# ==== Required
#
# ==== Optional
#
# [*enable*]
#   Instance is to be started at boot.  Either true (default) or false.
#
# [*ensure*]
#   Instance is to be 'running' (default) or 'stopped'.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2016 John Florian


class cron::daemon (
        $enable=true,
        $ensure='running',
    ) inherits ::cron::params {

    package { $::cron::params::packages:
        ensure => installed,
        notify => Service[$::cron::params::services],
    }

    service { $::cron::params::services:
        ensure     => $ensure,
        enable     => $enable,
        hasrestart => true,
        hasstatus  => true,
    }

}
