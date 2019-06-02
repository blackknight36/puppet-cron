#
# == Type: Cron::Timespec
#
# === Authors
#
#   John Florian <jflorian@doubledog.org>
#
# === Copyright
#
# This file is part of the doubledog-Cron Puppet module.
# Copyright 2019 John Florian
# SPDX-License-Identifier: GPL-3.0-or-later


type Cron::Timespec = Variant[
    # Integer is common for hours, minutes, etc.
    Integer[0],
    # String is common for DoW, month, '*' and other operators.
    String[1],
]
