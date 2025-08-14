#!/bin/bash
/run/current-system/sw/bin/dconf reset -f /
/run/current-system/sw/bin/dconf load / < $HOME/.config/dconf/dconf.ini