from pathlib import Path
import ast,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tree=ast.parse((w/'particlemode1055_law.py').read_text());ns={'Fraction':Fraction};exec(compile(ast.Module(body=[x for x in tree.body if isinstance(x,ast.FunctionDef)and x.name in ['positive_whole','mass_ratio_reach']],type_ignores=[]),'original051reach','exec'),ns)
args=[False,True,-10,-1,0]+list(range(1,33))+[64,128];expected=[]
for x in args:
 try:
  row=ns['mass_ratio_reach'](x);expected.append({'ok':{k:([v.numerator,v.denominator]if isinstance(v,Fraction)else v)for k,v in row.items()}})
 except ValueError as e:expected.append({'error':str(e)})
s='''import SFT.Physics.ParticleModeReach
import SFT.Host.Canonical
open SFT.Physics.ParticleModeReach SFT.Physics.LeptonIntervals SFT.Host.Canonical
def ratio (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def encode (x : Except String Result) : Value := match x with
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",.object [("depth",.integer (.ofNat v.depth)),("support",.integer (.ofNat v.support)),("light",ratio v.light),("heavy",ratio v.heavy),("heavy_to_light",.integer (.ofNat v.heavyToLight)),("subtraction_reach",.integer (.ofNat v.subtractionReach)),("identity",.boolean v.identity)])]
'''
for x in args:
 value='.boolean '+str(x).lower()if type(x)is bool else'.integer ('+str(x)+')';s+='#eval IO.println (render (encode (massRatioReach ('+value+'))))\n'
p=w/'particlemode1055_reach_cases.lean';p.write_text(s);ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,capture_output=True,text=True);(w/'particlemode1055_reach_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(line)for line in x.stdout.splitlines()];assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
build=(w/'particlemode1055_reach_build.log').read_text();assert "'SFT.Physics.ParticleModeReach.originalEveryPositiveDepth' does not depend on any axioms"in build
(w/'particlemode1055_reach_report.json').write_text(json.dumps(dict(status='PASS',cases=len(args),source_operation='sft/physics/particle_mode_generation_terminal_law_v1.py:mass_ratio_reach',source_sha256=hashlib.sha256((w/'particlemode1055_law.py').read_bytes()).hexdigest(),native_sha256=hashlib.sha256((r/'SFT/Physics/ParticleModeReach.lean').read_bytes()).hexdigest(),axioms=[],reused=['MassRatioFamily.wholeDivision','MassRatioFamily.allDepthRatio','MassRatioFamily.supportPositive'],general_result='SFT.Physics.ParticleModeReach.originalEveryPositiveDepth'),indent=2));print('PASS',len(args),'complete7field records/errors and all-depth native theorem')
