# == Define: cron::jobfile
#
# Manages a single job configuration for cron.
#
# === Parameters
#
# ==== Required
#
# [*namevar*]
#   An arbitrary identifier for the job instance unless the "filename"
#   parameter is not set in which case this must provide the value normally
#   set with the "filename" parameter.
#
# ==== Optional
#
# [*content*]
#   Literal content for the job file file.  If neither "content" nor "source"
#   is given, the content of the file will be left unmanaged.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'present' and
#   false equivalent to 'absent'.
#
# [*filename*]
#   Name to be given to the job file file, without any path details.  This may
#   be used in place of "namevar" if it's beneficial to give namevar an
#   arbitrary value.
#
# [*location*]
#   File system path to where the cron job file is to be installed.  Defaults
#   to "/etc/cron.d" which is appropriate for most job files.  See also the
#   "namevar" parameter.
#
# [*mode*]
#   File access mode.  Defaults to '0644' which is appropriate for most job
#   files.  This might need to be something like '0755' if "location" is
#   "/etc/cron.daily" or similar.
#
# [*source*]
#   URI of the job file file content.  If neither "content" nor "source" is
#   given, the content of the file will be left unmanaged.
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2017 John Florian


define cron::jobfile (
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        String[1]           $filename=$title,
        Optional[String[1]] $content=undef,
        Optional[String[1]] $source=undef,
        String[1]           $location='/etc/cron.d',
        Pattern[/[0-7]{4}/] $mode='0644',
    ) {

    require '::cron'

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
