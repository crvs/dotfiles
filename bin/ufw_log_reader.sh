#!/bin/bash

AWK_SCRIPT={print $8}
tail -f /var/log/ufw.log | awk -F' ' $AWK_SCRIPT

