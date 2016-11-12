#!/bin/sh

(grep "^\[INSTALLÉ\]" /var/log/aptitude & zgrep "^\[INSTALLÉ\]" /var/log/aptitude*.gz) | awk '{print $2}' | sed -r "s/:i386//" | sort

