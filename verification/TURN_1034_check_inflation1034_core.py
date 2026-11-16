from pathlib import Path
import ast,json,os,subprocess,re,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'inflation1034_law.py').read_text();env={'Fraction':Fraction,'BINARY':2,'GENERATOR':3,'SPACE_RANK':3};exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-inflation-functions','exec'),env)
ns=[True,False]+list(range(-2,130))+[2**k for k in range(8,14)];rs=[Fraction(n,d) for n in range(-1,8)for d in [1,2,3,7]]
ci=lambda n:'.boolean '+str(n).lower()if isinstance(n,bool)else'.integer ('+str(n)+')'
rat=lambda q:f'(normalize ({q.numerator} : Int) {q.denominator} (by decide))'
s='''import SFT.Physics.InflationGrowth
open SFT.Physics SFT.Physics.InflationGrowth LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rr(q:Rat):String := toString q.num ++ "/" ++ toString q.den
def countResult : Except String Nat → String | .error e => e | .ok n => toString n
#eval (['''+','.join('countResult (leastBinaryCoverDepth ('+ci(n)+'))'for n in ns)+'],['+','.join('countResult (exactDoublingDepth ('+ci(n)+'))'for n in ns)+'],['+','.join('(match forwardComponentTransfer '+rat(q)+' with | .error e => [e] | .ok t => [rr t.matterRetention,rr t.radiationRetention,rr t.matterOverRadiation])'for q in rs)+'])\n';p=w/'inflation1034_cases.lean';p.write_text(s);e={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=e,capture_output=True,text=True);(w/'inflation1034_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=ast.literal_eval(x.stdout)
def cr(name,n):
 try:return str(env[name](n))
 except ValueError as e:return str(e)
expected=([cr('least_binary_cover_depth',n)for n in ns],[cr('exact_doubling_depth',n)for n in ns],[])
for q in rs:
 try: expected[2].append([f'{v.numerator}/{v.denominator}'for v in env['forward_component_transfer'](q).values()])
 except ValueError as e:expected[2].append([str(e)])
assert actual==expected
body=(r/'SFT/Physics/InflationGrowth.lean').read_text();names=re.findall(r'^(?:def|theorem|structure) (\w+)',body,re.M);p=w/'inflation1034_audit.lean';p.write_text('import SFT.Physics.InflationGrowth\n'+''.join('#print axioms SFT.Physics.InflationGrowth.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'inflation1034_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'inflation1034_core_report.json').write_text(json.dumps(dict(status='PASS',cases=2*len(ns)+len(rs),axioms=[],declarations=names,source_sha256=hashlib.sha256(body.encode()).hexdigest(),scope='Original cover/doubling guards and exact outputs; complete3field componenttransfer outputs;general leastcover theorem reused;remainingcertificate/generaltransfer/grammar/entry not registered'),indent=2));print('PASS',2*len(ns)+len(rs),'outputs,',len(names),'emptyaxiom declarations')
