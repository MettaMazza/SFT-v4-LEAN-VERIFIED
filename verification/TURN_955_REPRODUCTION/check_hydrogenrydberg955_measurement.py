from pathlib import Path
import json,re,subprocess,sys,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import hydrogen_rydberg_successor_validation_v1 as src
names=[]
for m in ['HydrogenRydbergRecords','HydrogenRydbergMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';p=r/'HydrogenRydbergMeasurementAudit955.lean';p.write_text('import SFT.Physics.HydrogenRydbergMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'hydrogenrydberg955_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'HydrogenRydbergMeasurementCompare955.lean';p.write_text('''import SFT.Physics.HydrogenRydbergMeasurement
open SFT.Physics SFT.Host.Canonical HydrogenRydbergMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := HydrogenRydbergRecords.registeredRecord
 let r ← IO.ofExcept (rydbergInterval record)
 let t ← IO.ofExcept (ionizationTargetInterval record)
 let p ← IO.ofExcept (predictedIonizationInterval record)
 let l ← IO.ofExcept (predictedLineInterval record (LeptonIntervals.normalize 3 4 (by decide)))
 let b ← IO.ofExcept (predictedLineInterval record (LeptonIntervals.normalize 5 36 (by decide)))
 let lt ← IO.ofExcept (lineTargetInterval record "lyman_alpha")
 let bt ← IO.ofExcept (lineTargetInterval record "balmer_alpha")
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("rydberg",pair r),("target",pair t),("prediction",pair p),("lyman",pair l),("balmer",pair b),("lymanTarget",pair lt),("balmerTarget",pair bt),("label",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));root=w/'v3-runtime500';pair=lambda p:[[x.numerator,x.denominator] for x in p]
from fractions import Fraction
expected=dict(record=src.authoritative_record(root),rydberg=pair(src.rydberg_interval(root)),target=pair(src.ionization_target_interval(root)),prediction=pair(src.predicted_ionization_interval(root)),lyman=pair(src.predicted_line_interval(root,Fraction(3,4))),balmer=pair(src.predicted_line_interval(root,Fraction(5,36))),lymanTarget=pair(src.line_target_interval(root,'lyman_alpha')),balmerTarget=pair(src.line_target_interval(root,'balmer_alpha')),label=src.hydrogen_rydberg_classification(root));assert actual==expected
(w/'hydrogenrydberg955_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original full record,carrier and target intervals,translated prediction and classification;',len(names),'empty axioms')
