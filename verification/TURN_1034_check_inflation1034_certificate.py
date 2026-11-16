from pathlib import Path
import ast,subprocess,os,json,re,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');env={'Fraction':Fraction,'BINARY':2,'GENERATOR':3,'SPACE_RANK':3};src=(w/'inflation1034_law.py').read_text();exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-certificate','exec'),env);v=env['theorem_certificate']();rr=lambda q:f'{q.numerator}/{q.denominator}';expected=([v[k]for k in ['volume','depth','support','exact_duration']],[rr(v['scalar']),rr(v['tensor'])],[v[k]for k in ['complete_primordial_partition','strict_growth','transfer']],list(map(rr,v['growth_trace'])))
p=w/'inflation1034_certificate_check.lean';p.write_text('''import SFT.Physics.InflationGrowthCertificate
open SFT.Physics.InflationGrowthCertificate
def rr(q:Rat):String := toString q.num ++ "/" ++ toString q.den
#eval match certificate with
 | .error e => throw (IO.userError e)
 | .ok c => IO.println (reprStr ([c.volume,c.depth,c.support,c.exactDuration],[rr c.scalar,rr c.tensor],[c.completePrimordialPartition,c.strictGrowth,c.transfer],c.growthTrace.map rr))
''');e={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);assert x.returncode==0,x.stdout;actual=ast.literal_eval(x.stdout.replace('true','True').replace('false','False'));assert actual==expected
body=(r/'SFT/Physics/InflationGrowthCertificate.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'inflation1034_certificate_audit.lean';p.write_text('import SFT.Physics.InflationGrowthCertificate\n'+''.join('#print axioms SFT.Physics.InflationGrowthCertificate.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);(w/'inflation1034_certificate_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'inflation1034_certificate_report.json').write_text(json.dumps(dict(status='PASS',all_ten_fields=True,declarations=names,axioms=[],source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS full10fieldcertificate,4zeroaxiom declarations')
