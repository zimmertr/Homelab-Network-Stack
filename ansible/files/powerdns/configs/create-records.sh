#!/bin/sh

pdnsutil create-zone    sol.milkyway NATIVE

pdnsutil add-record     DOMAIN       HOSTNAME       IP_ADDRESS
