#!/usr/bin/env python
""" refresh CS
"""

from __future__ import print_function
from DIRAC.Core.Base import Script
Script.parseCommandLine()

from DIRAC.ConfigurationSystem.private.Refresher import gRefresher
res = gRefresher.forceRefresh()
if not res['OK']:
  print(res['Message'])
