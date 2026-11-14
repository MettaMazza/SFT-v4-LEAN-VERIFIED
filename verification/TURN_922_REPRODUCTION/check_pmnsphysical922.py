from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/PMNSPhysical.lean').read_text();names=['SFT.Physics.PMNSPhysical.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'PMNSPhysicalAudit922.lean';p.write_text('import SFT.Physics.PMNSPhysical\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'pmnsphysical922_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'PMNSPhysicalCompare922.lean';p.write_text('''import SFT.Physics.PMNSPhysical
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.PMNSPhysical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept pmnsCPStructure
 IO.println (render (.object [("atmospheric",fraction p.atmospheric),("solar",fraction p.solar),("reactor",fraction p.reactor),("cp_phase",fraction p.cpPhase),("electron_weights",.array [fraction p.electronWeights.1,fraction p.electronWeights.2.1,fraction p.electronWeights.2.2])]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 if isinstance(x,tuple):return list(map(cv,x))
 return x
expected=cv(src.pmns_cp_structure());assert actual==expected
(w/'pmnsphysical922_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:pmns_cp_structure','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS all original PMNS fields;',len(names),'empty-axiom declarations')
