from pathlib import Path
import json,re,subprocess,sys,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_field_splitting_successor_validation_v1 as src
names=[]
for m in ['AtomicFieldSplittingRecords','AtomicFieldSplittingMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';p=r/'AtomicFieldSplittingMeasurementAudit958.lean';p.write_text('import SFT.Physics.AtomicFieldSplittingMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'atomicfieldsplitting958_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'AtomicFieldSplittingMeasurementCompare958.lean';p.write_text('''import SFT.Physics.AtomicFieldSplittingMeasurement
open SFT.Physics SFT.Host.Canonical AtomicFieldSplittingMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicFieldSplittingRecords.registeredRecord
 let cesium ← IO.ofExcept (RunningConvergenceMeasurement.field (← IO.ofExcept (RunningConvergenceMeasurement.field (← IO.ofExcept (RunningConvergenceMeasurement.field record "sources")) "nist_cesium_quadratic_stark")) "reported_record")
 let operating ← IO.ofExcept (operatingField cesium)
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("operating",frac operating),("label",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));root=w/'v3-runtime500'
from fractions import Fraction
record=src.authoritative_record(root);row=record['sources']['nist_cesium_quadratic_stark']['reported_record'];operating=Fraction(row['quadratic_voltage_range_V'])/Fraction(row['electrode_spacing_m'])
expected=dict(record=record,operating=[operating.numerator,operating.denominator],label=src.field_splitting_classification(root));assert actual==expected
(w/'atomicfieldsplitting958_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original full record,carrier and target intervals,translated prediction and classification;',len(names),'empty axioms')
