from pathlib import Path
import json,sys,subprocess,os,itertools,hashlib,re
from fractions import Fraction as F
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import scattering_rutherford_compton_terminal_law_v1 as src
q=json.dumps
def enc(x):
 if isinstance(x,F):return [x.numerator,x.denominator]
 if isinstance(x,(tuple,list)):return list(map(enc,x))
 return x
def rat(x):return f'(LeptonIntervals.normalize ({x.numerator}) {x.denominator} (by decide))'
s='''import SFT.Physics.ScatteringRutherfordCompton
import SFT.Host.Canonical
open SFT.Physics ScatteringRutherfordCompton SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def opt : Option Rat → Value | none => .array [] | some q => frac q
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''
xs=[F(-1),F(0),F(1,7),F(1,4),F(1,2),F(3,4),F(1),F(7,5),F(5)]
ops=[('positive_transfer_part','positiveTransferPart',list(itertools.product(range(-1,5),repeat=2)),'frac',lambda x:f'({x})'),('overlap_leg','overlapLeg',[(x,) for x in xs],'frac',rat),('direction_complement','directionComplement',[(x,) for x in xs],'opt',rat),('cumulative_impact_area','cumulativeImpactArea',[(x,) for x in xs],'opt',rat),('annular_transfer_density','annularTransferDensity',list(itertools.product(xs,repeat=2)),'frac',rat),('paired_overlap_density','pairedOverlapDensity',[(x,) for x in xs],'frac',rat),('coulomb_backscatter_scale','coulombBackscatterScale',list(itertools.product(xs,repeat=2)),'frac',rat),('coulomb_differential_support','coulombDifferentialSupport',list(itertools.product(xs[2:7],repeat=3)),'frac',rat),('photon_shift_in_compton_carriers','photonShiftInComptonCarriers',[(x,) for x in xs],'frac',rat),('scattered_photon_energy_ratio','scatteredPhotonEnergyRatio',list(itertools.product(xs,repeat=2)),'frac',rat),('compton_conservation_transfer','comptonConservationTransfer',list(itertools.product(xs,repeat=2)),'frac',rat),('scattered_photon_in_rest_units','scatteredPhotonInRestUnits',list(itertools.product(xs,repeat=2)),'frac',rat),('high_energy_ceiling_in_rest_units','highEnergyCeilingInRestUnits',[(x,) for x in xs],'frac',rat)]
expected=[];fields=[];counts={}
for py,lean,args,renderer,arg in ops:
 counts[py]=len(args)
 for aa in args:
  try:v=enc(getattr(src,py)(*aa))
  except ValueError as e:v={'error':str(e)}
  expected.append(v);fields.append(f'result {renderer} ({lean} '+ ' '.join(map(arg,aa))+')')
for py,lean in [('high_energy_gap','highEnergyGap'),('high_energy_step','highEnergyStep')]:
 aa=list(itertools.product(range(-1,7),xs));counts[py]=len(aa)
 for n,u in aa:
  try:v=enc(getattr(src,py)(n,u))
  except ValueError as e:v={'error':str(e)}
  expected.append(v);fields.append(f'result frac ({lean} ({n}) {rat(u)})')
s+=',\n'.join(fields)+']))\n'
p=w/'constants-recovery/ScatteringCompare969.lean';p.write_text(s)
env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')}
out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True)
a=json.loads(out);assert a==expected,[(i,a[i],v) for i,v in enumerate(expected) if a[i]!=v][:5]
module=c/'SFT/Physics/ScatteringRutherfordCompton.lean'
decls=re.findall(r'^def (\w+)',module.read_text(),re.M)
audit=w/'constants-recovery/ScatteringAudit969.lean';audit.write_text('import SFT.Physics.ScatteringRutherfordCompton\n'+'\n'.join('#print axioms SFT.Physics.ScatteringRutherfordCompton.'+d for d in decls)+'\n')
log=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(audit)],env=env,text=True);(w/'scattering969_core_audit.log').write_text(log);assert log.count('does not depend on any axioms')==len(decls),log
(w/'scattering969_core_report.json').write_text(json.dumps(dict(status='PASS',cases=counts,total=len(expected),source='sft/physics/scattering_rutherford_compton_terminal_law_v1.py',source_sha256=hashlib.sha256(Path(src.__file__).read_bytes()).hexdigest(),lean_sha256=hashlib.sha256(module.read_bytes()).hexdigest(),audited_declarations=decls,axioms=[]),indent=2)+'\n');print('PASS',len(expected),'source cases;',len(decls),'declarations empty axioms',flush=True)
