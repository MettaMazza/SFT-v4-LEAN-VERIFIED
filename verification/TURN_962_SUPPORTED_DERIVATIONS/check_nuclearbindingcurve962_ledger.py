from pathlib import Path
from fractions import Fraction as F
import json,sys,subprocess,os,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import nuclear_binding_curve_successor_laws_v1 as src
values=[False,True,-1,0,1,2,3,4,5,8,28,34,62,63,4096]
pairs=[(a,z) for a in values for z in values]
def ci(x):return '.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
s='''import SFT.Physics.NuclearBindingCurve
open SFT.Physics SFT.Host.Canonical NuclearBindingCurve LeptonIntervals
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def nat (n : Nat) : Value := .integer (.ofNat n)
def opt (f : α → Value) : Option α → Value | none => .array [] | some v => f v
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
def ledger (v : Ledger) : Value := .object [("mass_number",.integer v.massNumber),("charge_count",.integer v.chargeCount),("neutron_count",nat v.neutronCount),("bulk_support",frac v.bulkSupport),("surface_radial_loss",frac v.surfaceRadialLoss),("ordered_charge_paths",opt nat v.orderedChargePaths),("coulomb_radial_loss",opt frac v.coulombRadialLoss),("asymmetry_loss",opt frac v.asymmetryLoss),("pairing_radial_part",frac v.pairingRadialPart),("pairing_class",.text v.pairingClass)]
#eval do
 IO.println (render (.object [
 ("surface",result frac surfaceDeficitShare),("alpha",result frac electromagneticShare),("asymmetry",result frac asymmetryShare),("pairing",result frac pairingShare),
'''
ops=[('neutrons','neutronCount','nat',src.neutron_count),('unmatched','unmatchedLabelCount','(opt nat)',src.unmatched_label_count),('class','pairingClass','Value.text',src.pairing_class),('ledger','bindingLedger','ledger',src.binding_ledger),('radial','netRadialLoss','frac',src.net_radial_loss),('retention','nonradialRetention','frac',src.nonradial_retention)]
s+=',\n'.join('("'+key+'",.array ['+','.join(f'result {enc} ({name} ({ci(a)}) ({ci(z)}))' for a,z in pairs)+'])' for key,name,enc,fn in ops)
s+=',("paths",.array ['+','.join(f'result (opt nat) (orderedChargePaths ({ci(z)}))' for z in values)+'])]))\n'
p=r/'NuclearBindingCurveCompare962.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True))
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 if isinstance(x,(list,tuple)):return [enc(v) for v in x]
 return x
def call(fn,*args):
 try:
  for cached in (src.binding_ledger,src.net_radial_loss,src.nonradial_retention):cached.cache_clear()
  return enc(fn(*args))
 except ValueError as e:return {'error':str(e)}
expected={key:[call(fn,*args) for args in pairs] for key,_,_,fn in ops}
expected.update(surface=call(src.surface_deficit_share),alpha=call(src.electromagnetic_share),asymmetry=call(src.asymmetry_share),pairing=call(src.pairing_share),paths=[call(src.ordered_charge_paths,z) for z in values])
for key in expected:
 if actual[key]!=expected[key]:
  if isinstance(expected[key],list):
   for i,(x,y) in enumerate(zip(actual[key],expected[key])):
    if x!=y:print(key,i,pairs[i] if i<len(pairs) else None,x,y,flush=True);break
  else: print(key,actual[key],expected[key],flush=True)
  raise AssertionError(key)
names=['SFT.Physics.NuclearBindingCurve.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',(r/'SFT/Physics/NuclearBindingCurve.lean').read_text(),re.M)]
a=(w/'nuclearbindingcurve962_core_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in names)
(w/'nuclearbindingcurve962_ledger_report.json').write_text(json.dumps(dict(status='PASS',domain_cases=len(pairs)*len(ops)+len(values),actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2))
(w/'nuclearbindingcurve962_original_peak.json').write_text(json.dumps(enc(src.binding_peak_certificate()),indent=2))
print('PASS 11 original operations; 1365 domain cases; 19 empty axiom declarations; original full peak retained')

radius_inputs=[(a,n) for a in [False,True,-1,0,1,2,3,8,26,27,28,62,64,4096,4097] for n in [False,True,-1,0,1,2,4,8]]
score_inputs=[(a,z,n) for a,z in [(2,1),(3,1),(4,2),(8,4),(62,28),(63,28),(4096,820)] for n in [1,2,4,8]]
t="""import SFT.Physics.NuclearBindingRadius
open SFT.Physics SFT.Host.Canonical NuclearBindingRadius GeneratorOperations LeptonIntervals
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def bounds (v : Rat × Rat) : Value := .array [frac v.1,frac v.2]
def result (f : α → Value) : Except String α → Value | .error e => .object [("error",.text e)] | .ok x => f x
#eval do
 IO.println (render (.object [
"""
t+='("radius",.array ['+','.join(f'result bounds (exactCubeRootEnclosure ({ci(a)}) ({ci(n)}))' for a,n in radius_inputs)+']),'
t+='("vertex",.array ['+','.join(f'result bounds (continuousVertexEnclosure ({ci(a)}) ({ci(n)}))' for a,n in radius_inputs)+']),'
t+='("score",.array ['+','.join(f'result bounds (bindingScoreEnclosure ({ci(a)}) ({ci(z)}) ({ci(n)}))' for a,z,n in score_inputs)+'])]))\n'
p=r/'NuclearBindingRadiusCompare962.lean';p.write_text(t)
actual=json.loads(subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True))
def fresh(fn,*args):
 src.exact_cube_root_enclosure.cache_clear()
 return call(fn,*args)
expected=dict(radius=[fresh(src.exact_cube_root_enclosure,*x) for x in radius_inputs],vertex=[fresh(src.continuous_vertex_enclosure,*x) for x in radius_inputs],score=[fresh(src.binding_score_enclosure,*x) for x in score_inputs])
for key in expected:assert actual[key]==expected[key],key
names=['SFT.Physics.NuclearBindingRadius.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/NuclearBindingRadius.lean').read_text(),re.M)]
a=(w/'nuclearbindingcurve962_radius_audit.log').read_text();assert all("'"+n+"' does not depend on any axioms" in a for n in names)
(w/'nuclearbindingcurve962_radius_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2))
print('PASS original cube-root,vertex and binding-score operations;268 domain cases;8 empty declarations')
