# == Define: cron::job
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
# [*command*]
#   Command to be executed by cron.
#
# ==== Optional
#
# [*dom*]
#   Valid: 1-31, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*dow*]
#   Valid: 0-7, names (e.g., "Mon"), ranges via hyphen, lists via comma or
#   steps via slashes or no restriction via star.  Defaults to "*".  Note that
#   either 0 or 7 may be used to indicate Sunday.
#
# [*ensure*]
#   Instance is to be 'present' (default) or 'absent'.  Alternatively,
#   a Boolean value may also be used with true equivalent to 'present' and
#   false equivalent to 'absent'.
#
# [*filename*]
#   This may be used in place of "namevar" if it's beneficial to give namevar
#   an arbitrary value.
#
# [*hour*]
#   Valid: 0-23, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*location*]
#   File system path to where the cron job file is to be installed.  Defaults
#   to "/etc/cron.d" which is appropriate for most job files.  See also the
#   "namevar" parameter.
#
# [*mailto*]
#   Any stdout/stderr will be sent here.  May be a user name for localhost
#   mail or a fully qualified email address.  If set to "" (an empty string),
#   no mail will be sent.  Defaults to "root".
#
# [*minute*]
#   Valid: 0-59, ranges via hyphen, lists via comma or steps via slashes or no
#   restriction via star.  Defaults to "*".
#
# [*mode*]
#   File access mode.  Defaults to '0644' which is appropriate for most jobs.
#   This might need to be something like '0755' if "location" is
#   "/etc/cron.daily" or similar.
#
# [*month*]
#   Valid: 1-12, names (e.g., "Feb"), ranges via hyphen, lists via comma or
#   steps via slashes or no restriction via star.  Defaults to "*".
#
# [*path*]
#   Executable search path to be used in environment while running command.
#   Defaults to "/sbin:/bin:/usr/sbin:/usr/bin".
#
# [*user*]
#   Identity that cron should should assume when running the command.
#   Defaults to "root".
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# Copyright 2011-2017 John Florian


define cron::job (
        Variant[Boolean, Enum['present', 'absent']] $ensure='present',
        String[1]           $command,
        String[1]           $filename=$title,
        String[1]           $minute='*',
        String[1]           $hour='*',
        String[1]           $dom='*',
        Pattern[/[0-7]{4}/] $mode='0644',
        String[1]           $month='*',
        String[1]           $dow='*',
        String              $mailto='root',
        String[1]           $path='/sbin:/bin:/usr/sbin:/usr/bin',
        String[1]           $user='root',
        String[1]           $location='/etc/cron.d',
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
        content => template('cron/job.erb'),
    }

}
