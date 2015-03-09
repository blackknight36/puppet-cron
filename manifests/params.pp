# modules/cron/manifests/params.pp
#
# == Class: cron::params
#
# Parameters for the cron puppet module.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2015 John Florian


class cron::params {

    case $::operatingsystem {
        Fedora: {

            $packages = 'cronie'
            $services = 'crond'

        }

        default: {
            fail ("${title}: operating system '${::operatingsystem}' is not supported")
        }

    }

}
