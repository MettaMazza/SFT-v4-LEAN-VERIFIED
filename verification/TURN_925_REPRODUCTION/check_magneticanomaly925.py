from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/MagneticAnomaly.lean').read_text();names=['SFT.Physics.MagneticAnomaly.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'MagneticAnomalyAudit925.lean';p.write_text('import SFT.Physics.MagneticAnomaly\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'magneticanomaly925_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'MagneticAnomalyCompare925.lean';p.write_text('''import SFT.Physics.MagneticAnomaly
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.MagneticAnomaly
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let p ← IO.ofExcept magneticAnomalyStructure
 IO.println (render (.object [("bare_g",.integer (.ofNat p.bareG)),("terminal_alpha",fraction p.terminalAlpha),("phase_normalized_leading_anomaly",fraction p.phaseNormalizedLeadingAnomaly),("mass_sensitivity_graph",.text p.massSensitivityGraph),("physical_turn_translation",.text p.physicalTurnTranslation)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
expected={k:([v.numerator,v.denominator] if isinstance(v,Fraction) else v) for k,v in src.magnetic_anomaly_structure().items()};assert actual==expected
(w/'magneticanomaly925_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:magnetic_anomaly_structure','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS all original5 fields;',len(names),'empty-axiom declarations')
