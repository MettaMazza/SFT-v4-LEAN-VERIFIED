from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
text=(r/'SFT/Physics/MagneticComparisonMeasurement.lean').read_text();names=['SFT.Physics.MagneticComparisonMeasurement.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',text,re.M)];driver=r/'MagneticComparisonAudit930.lean';driver.write_text('import SFT.Physics.MagneticComparisonMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';audit=subprocess.check_output([lean,'-j1',str(driver)],env=env,text=True);(w/'magneticcomparison930_core_audit.log').write_text(audit);assert all("'"+n+"' does not depend on any axioms" in audit for n in names),audit
p=r/'MagneticComparisonCompare930.lean';p.write_text('''import SFT.Physics.MagneticComparisonMeasurement
open SFT.Physics SFT.Physics.MagneticComparisonMeasurement SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept leadingInterval
 let label ← IO.ofExcept (magneticClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord)
 IO.println (render (.object [("lower",fraction l),("upper",fraction u),("classification",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));alpha=1/Fraction(503846395469,3676744786);lo=alpha/(2*Fraction(355,113));hi=alpha/(2*Fraction(333,106));pair=lambda x:[x.numerator,x.denominator];expected=dict(lower=pair(lo),upper=pair(hi),classification=src.magnetic_classification((w/'v3-runtime500').resolve()));assert actual==expected;(w/'magneticcomparison930_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_validation_v1.py:magnetic_classification',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS original full-turn bounds and complete classification;',len(names),'empty-axiom declarations')
