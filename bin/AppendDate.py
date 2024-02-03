#! /usr/bin/env python3
#2019-09-27
"""
Rename a file by appending the modification date to the file name
2019-09-27
"""
import sys, os, time
sep = '.'
for infile in sys.argv[1:]:
    path, name = os.path.split(infile)
    splitname = name.split(sep)
    ltime = time.localtime(os.stat(infile).st_mtime)
    splitname[0] = '%s_%d%02d%02d' % (splitname[0], ltime.tm_year, ltime.tm_mon, ltime.tm_mday)
    newpath = os.path.join(path, sep.join(splitname))
    os.rename(infile, newpath)
