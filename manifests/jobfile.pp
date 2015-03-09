# modules/cron/manifests/jobfile.pp
#
# == Define: cron::jobfile
#
# Installs a single job configuration for cron.
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
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.
#
# [*filename*]
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# [*content*]
#   Literal content for the job file file.  One and only one of "content"
#   or "source" must be given.
#
# [*source*]
#   URI of the job file file content.  One and only one of "content" or
#   "source" must be given.
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
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2015 John Florian


define cron::jobfile (
        $ensure='present',
        $filename=undef,
        $content=undef,
        $source=undef,
        $location='/etc/cron.d',
        $mode='0644',
    ) {

    include 'cron::params'

    if $filename {
        $_filename = $filename
    } else {
        $_filename = $name
    }

    file { "${location}/${_filename}":
        ensure      => $ensure,
        owner       => 'root',
        group       => 'root',
        mode        => $mode,
        seluser     => 'system_u',
        selrole     => 'object_r',
        seltype     => 'system_cron_spool_t',
        content     => $content,
        source      => $source,
    }

}
