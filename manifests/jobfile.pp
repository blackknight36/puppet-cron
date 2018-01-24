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
# Copyright 2011-2018 John Florian


define cron::jobfile (
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        String[1]           $filename=$title,
        Optional[String[1]] $content=undef,
        Optional[String[1]] $source=undef,
        String[1]           $location='/etc/cron.d',
        Pattern[/[0-7]{4}/] $mode='0644',
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
