from pathlib import Path
import subprocess,sys,os,json,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/MatterIdentityGraphs.lean').read_text();names=['SFT.Physics.MatterIdentityGraphs.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'MatterIdentityAudit918.lean';p.write_text('import SFT.Physics.MatterIdentityGraphs\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'matteridentity918_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'MatterIdentityCompare918.lean';p.write_text('''import SFT.Physics.MatterIdentityGraphs
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MatterIdentityGraphs
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let c ← IO.ofExcept ckmPhysicalIdentity
 let p ← IO.ofExcept protonElectronIdentity
 IO.println (render (.object [("ckm",.object [("s12_squared",.text c.s12Squared),("s23",.text c.s23),("s13_squared",.text c.s13Squared),("apex_squared",fraction c.apexSquared),("phase",fraction c.phase)]),("proton",.object [("lepton_polynomial",.array [fraction p.leptonPolynomial.1,fraction p.leptonPolynomial.2.1,fraction p.leptonPolynomial.2.2]),("proton_share",fraction p.protonShare),("ratio_graph",.text p.ratioGraph)])]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
from fractions import Fraction
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 if isinstance(x,tuple):return list(map(cv,x))
 return x
expected=cv({'ckm':src.ckm_physical_identity(),'proton':src.proton_electron_identity()});assert actual==expected
(w/'matteridentity918_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:ckm_physical_identity,proton_electron_identity','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS all original5+3 identity fields;',len(names),'empty-axiom declarations')
