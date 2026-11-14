from pathlib import Path
import json,sys,re,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
text=(r/'SFT/Physics/MajoranaComparisonMeasurement.lean').read_text();names=['SFT.Physics.MajoranaComparisonMeasurement.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',text,re.M)];driver=r/'MajoranaComparisonAudit929.lean';driver.write_text('import SFT.Physics.MajoranaComparisonMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';audit=subprocess.check_output([lean,'-j1',str(driver)],env=env,text=True);(w/'majoranacomparison929_core_audit.log').write_text(audit);assert all("'"+n+"' does not depend on any axioms" in audit for n in names),audit
p=r/'MajoranaComparisonCompare929.lean';p.write_text('''import SFT.Physics.MajoranaComparisonMeasurement
open SFT.Physics SFT.Physics.MajoranaComparisonMeasurement SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept (predictionBounds (LeptonIntervals.normalize 749 10000000 (by decide)))
 let label ← IO.ofExcept (majoranaClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord)
 IO.println (render (.object [("floor",fraction l),("ceiling",fraction u),("classification",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));rows=src.source_rows((w/'v3-runtime500').resolve(),'PDG-2025-NEUTRINO-MIXING');anchor=Fraction(rows['solar_delta_mass_squared_eV2']['value']);mass=src.neutrino_mass_squares();weights=src.pmns_cp_structure()['electron_weights'];b=[src.sqrt_refined(anchor*mass[k]) for k in ['lightest','middle','heavy']];lo=weights[1]*b[1][0]-weights[0]*b[0][1]-weights[2]*b[2][1];hi=sum((weights[i]*b[i][1] for i in range(3)),Fraction(0));pair=lambda x:[x.numerator,x.denominator];expected=dict(floor=pair(lo),ceiling=pair(hi),classification=src.majorana_classification((w/'v3-runtime500').resolve()));assert actual==expected;(w/'majoranacomparison929_science_report.json').write_text(json.dumps(dict(status='PASS',source='sft/physics/matter_flavour_validation_v1.py:majorana_classification',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS full original classification and exact effective-mass bounds;',len(names),'empty-axiom declarations')
