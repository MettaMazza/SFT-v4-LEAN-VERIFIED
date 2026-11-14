from pathlib import Path
from fractions import Fraction
import json,subprocess,os
from sft.physics.precision_value_validation_v1 import interval,squared_ratio_interval,pdg_rows,codata_row
w=Path('work');root=(w/'v3-runtime500').resolve();r=(w/'constants-recovery').resolve()
def outcome(f):
 try:f();return 'accepted'
 except Exception as e:return str(e)
expected={k:outcome(f) for k,f in [('width_exceeds_centre',lambda:interval('0.1','0.2')),('equal_width',lambda:interval('0.1','0.1')),('zero_width',lambda:interval('1','0')),('zero_lower',lambda:squared_ratio_interval((Fraction(0),Fraction(1)),(Fraction(1),Fraction(2)))),('inverted_upper',lambda:squared_ratio_interval((Fraction(2),Fraction(1)),(Fraction(2),Fraction(1))))]}
import tempfile
with tempfile.TemporaryDirectory() as d:
 base=Path(d);p=base/'experiments/external_sources/physics/snapshots/pdg-electroweak-precision-source-record.json';p.parent.mkdir(parents=True);p.write_text('{}');expected['missing_record_identity']=outcome(lambda:pdg_rows(base));p.write_text(json.dumps({'record_id':'PDG-ELECTROWEAK-PRECISION-2024-2025'}));expected['missing_sources']=outcome(lambda:pdg_rows(base));empty=base/'empty.txt';empty.write_text('');expected['missing_codata_row']=outcome(lambda:codata_row(empty,'Planck mass'))
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','--run',str(r/'PrecisionGuards873.lean')],env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')),text=True));actual={k:v.removeprefix('ValueError: ').removeprefix('ZeroDivisionError: ') for k,v in actual.items()};assert actual==expected,(actual,expected)
report=dict(status='PASS',cases=actual,scope='Eight actual original input-guard cases,including preserving acceptance of an inverted upper endpoint because V3 guards lower endpoints only');(w/'precision873_guards_report.json').write_text(json.dumps(report,indent=2));print(json.dumps(report))
