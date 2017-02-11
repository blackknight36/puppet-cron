# == Class: cron::daemon
#
# Manages the cron daemon.
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
#   Instance is to be 'running' (default) or 'stopped'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'running' and
#   false equivalent to 'stopped'.
#
# [*packages*]
#   An array of package names needed for a cron daemon installation.
#
# [*service*]
#   The service name of the cron daemon.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2017 John Florian


class cron::daemon (
        Variant[Boolean, Enum['running', 'stopped']] $ensure='running',
        Boolean         $enable=true,
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
