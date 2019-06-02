#
# == Define: cron::jobfile
#
# Manages a single job configuration for cron.
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


define cron::jobfile (
        Ddolib::File::Ensure::Limited   $ensure='present',
        String[1]                       $filename=$title,
        Optional[String[1]]             $content=undef,
        Optional[String[1]]             $source=undef,
        String[1]                       $location='/etc/cron.d',
        Pattern[/[0-7]{4}/]             $mode='0644',
    ) {

    include '::cron::daemon'

    file { "${location}/${filename}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => $mode,
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_cron_spool_t',
        content => $content,
        source  => $source,
    }

}
