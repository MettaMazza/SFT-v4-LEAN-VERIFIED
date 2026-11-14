from pathlib import Path
import json,re,subprocess,sys,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_transition_rate_successor_validation_v1 as src
names=[]
for m in ['AtomicTransitionRateRecords','AtomicTransitionRateMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';p=r/'AtomicTransitionRateMeasurementAudit957.lean';p.write_text('import SFT.Physics.AtomicTransitionRateMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'atomictransitionrate957_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'AtomicTransitionRateMeasurementCompare957.lean';p.write_text('''import SFT.Physics.AtomicTransitionRateMeasurement
open SFT.Physics SFT.Host.Canonical AtomicTransitionRateMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicTransitionRateRecords.registeredRecord
 let argon ← IO.ofExcept (measuredInterval record "nist_argon_metastable")
 let aluminium ← IO.ofExcept (measuredInterval record "nist_aluminium_clock")
 let allowed ← IO.ofExcept (allowedExampleLifetime record)
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("argon",pair argon),("aluminium",pair aluminium),("allowed",frac allowed),("label",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));root=w/'v3-runtime500';pair=lambda p:[[x.numerator,x.denominator] for x in p]
record=src.authoritative_record(root);allowed=src.allowed_example_lifetime(root)
expected=dict(record=record,argon=pair(src.measured_interval(root,'nist_argon_metastable')),aluminium=pair(src.measured_interval(root,'nist_aluminium_clock')),allowed=[allowed.numerator,allowed.denominator],label=src.transition_rate_classification(root));assert actual==expected
(w/'atomictransitionrate957_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original full record,carrier and target intervals,translated prediction and classification;',len(names),'empty axioms')
