"""Submission policy tests without generating a fictional demonstration video."""
import importlib.util
from pathlib import Path
import subprocess
import sys
import unittest

SRC=Path(__file__).resolve().parents[1]
spec=importlib.util.spec_from_file_location('packager',SRC/'tools/package_submission.py')
packager=importlib.util.module_from_spec(spec)
spec.loader.exec_module(packager)

class PackageTests(unittest.TestCase):
    def test_secrets_and_transient_files_excluded(self):
        self.assertFalse(packager.allowed(SRC/'.env'))
        self.assertTrue(packager.allowed(SRC/'.env.example'))
        self.assertFalse(packager.allowed(SRC/'__pycache__'/'app.cpython-313.pyc'))

    def test_missing_video_rejected(self):
        result=subprocess.run([sys.executable,str(SRC/'tools/package_submission.py'),'999999','/nonexistent/real.mp4'],capture_output=True,text=True)
        self.assertNotEqual(result.returncode,0)
        self.assertIn('existing real .mp4',result.stderr)
