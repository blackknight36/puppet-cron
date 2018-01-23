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
# Copyright 2011-2018 John Florian


class cron::daemon (
        Variant[Boolean, Enum['running', 'stopped']] $ensure,
        Boolean         $enable,
        Array[String]   $packages,
        String          $service,
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
