#
# == Define: cron::job
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


define cron::job (
        String[1]                       $command,
        Ddolib::File::Ensure::Limited   $ensure='present',
        String[1]                       $filename=$title,
        String[1]                       $minute='*',
        String[1]                       $hour='*',
        String[1]                       $dom='*',
        Pattern[/[0-7]{4}/]             $mode='0644',
        String[1]                       $month='*',
        String[1]                       $dow='*',
        String                          $mailto='root',
        String[1]                       $path='/sbin:/bin:/usr/sbin:/usr/bin',
        String[1]                       $user='root',
        String[1]                       $location='/etc/cron.d',
    ) {

    include 'cron'

    file { "${location}/${filename}":
        ensure  => $ensure,
        owner   => 'root',
        group   => 'root',
        mode    => $mode,
        seluser => 'system_u',
        selrole => 'object_r',
        seltype => 'system_cron_spool_t',
        content => template('cron/job.erb'),
    }

}
