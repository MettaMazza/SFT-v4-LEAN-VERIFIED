from pathlib import Path
import json,subprocess,os
exec(Path('work/algebraic_spec858.py').read_text())
r=Path('work/constants-recovery').resolve();p=subprocess.run(['/Users/dolltrading/.elan/bin/lean','--run',str(r/'AlgebraicNumeric858.lean')],capture_output=True,text=True,env=dict(os.environ,LEAN_PATH=str(r/'.lake/build/lib/lean')));(Path('work/algebraic858_numeric_output.json')).write_text(p.stdout);p.check_returncode();rows=json.loads(p.stdout)
for row in rows:
 a,b=ns['_square_two_bracket'](row['rounds']);assert row['lower']==[a.numerator,a.denominator];assert row['upper']==[b.numerator,b.denominator]
Path('work/algebraic858_numeric_report.json').write_text(json.dumps(dict(status='PASS',source_commit=pin,cases=rows,source_operation='sft/mathematics/lineage_laws.py:_square_two_bracket',fresh_lean_execution=True),indent=2));print('PASS',len(rows),'original exact iteration cases')
