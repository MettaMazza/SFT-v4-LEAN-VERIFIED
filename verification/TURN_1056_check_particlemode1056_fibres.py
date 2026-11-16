from pathlib import Path
import ast,json,subprocess,os,hashlib
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');tree=ast.parse((w/'particlemode1055_law.py').read_text());ns={'Fraction':Fraction,'EMPTY_ONE':()};exec(compile(ast.Module(body=[x for x in tree.body if isinstance(x,ast.FunctionDef)and x.name in ['positive_whole','positive_fraction','m_fold_fibre','interior_fixed_modes','m_fold_theorem_certificate']],type_ignores=[]),'original051fibres','exec'),ns)
def canonical(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(tuple,list)):return [canonical(v)for v in x]
 if isinstance(x,dict):return {k:canonical(v)for k,v in x.items()}
 return x
def count(x):return '.boolean '+str(x).lower()if type(x)is bool else '.integer ('+str(x)+')'
def rat(x):return f'(normalize ({x.numerator}) {x.denominator} (by decide))'
inputs=[]
for m in [False,True,-2,0,1]+list(range(2,17)):
 for y in [Fraction(-1,2),Fraction(0),Fraction(1,17),Fraction(1,2),Fraction(2,3),Fraction(1),Fraction(3,2)]:inputs.append(('m_fold_fibre',[m,y]))
for m in [False,True,-2,0,1]+list(range(2,25)):inputs.append(('interior_fixed_modes',[m]))
for m in [False,True,-1,0,1,2,3,5,12,16]:inputs.append(('m_fold_theorem_certificate',[m]))
s='''import SFT.Physics.ParticleModeFibres
import SFT.Host.Canonical
open SFT.Physics.ParticleModeFibres SFT.Physics.LeptonIntervals SFT.Host.Canonical
def n (v : Nat) : Value := .integer (.ofNat v)
def ratio (v : Rat) : Value := .array [.integer v.num,n v.den]
def enc {α : Type} (f : α → Value) : Except String α → Value
 | .error e => .object [("error",.text e)]
 | .ok v => .object [("ok",f v)]
def fibre (v : Fibre) : Value := .object [("multiplicity",n v.multiplicity),("image",ratio v.image),("preimages",.array (v.preimages.map ratio)),("complete",.boolean v.complete),("all_positive_inside_one",.boolean v.allPositiveInsideOne),("exact_return",.boolean v.exactReturn)]
def cert (v : FibreCertificate) : Value := .object [("checked_through",n v.checkedThrough),("all_fibres_complete",.boolean v.allFibresComplete),("fixed_mode_formula",.boolean v.fixedModeFormula),("induction",.text v.induction)]
'''
expected=[]
for name,args in inputs:
 try:expected.append({'ok':canonical(ns[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
 if name=='m_fold_fibre': expr=f'enc fibre (mFoldFibre ({count(args[0])}) {rat(args[1])})'
 elif name=='interior_fixed_modes':expr=f'enc (fun xs=>Value.array (xs.map ratio)) (interiorFixedModes ({count(args[0])}))'
 else:expr=f'enc cert (mFoldTheoremCertificate ({count(args[0])}))'
 s+='#eval IO.println (render ('+expr+'))\n'
p=w/'particlemode1056_fibres_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'particlemode1056_fibres_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(v)for v in x.stdout.splitlines()];assert actual==expected,[(inputs[i],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
(w/'particlemode1056_fibres_report.json').write_text(json.dumps(dict(status='PASS',cases=len(inputs),source_operation=['m_fold_fibre','interior_fixed_modes','m_fold_theorem_certificate'],source_sha256=hashlib.sha256((w/'particlemode1055_law.py').read_bytes()).hexdigest(),native_sha256=hashlib.sha256((r/'SFT/Physics/ParticleModeFibres.lean').read_bytes()).hexdigest(),all_fields_and_errors=True),indent=2));print('PASS',len(inputs),'complete original operations and errors')
