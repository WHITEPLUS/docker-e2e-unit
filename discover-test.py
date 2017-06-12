#!/usr/bin/env python
import sys
import unittest

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('usage: %s path' % sys.argv[0])
        sys.exit(1)
    ts = unittest.TestSuite()
    for t in unittest.defaultTestLoader.discover(sys.argv[1], pattern="*_test.py"):
        ts.addTest(t)
    unittest.TextTestRunner().run(ts)
