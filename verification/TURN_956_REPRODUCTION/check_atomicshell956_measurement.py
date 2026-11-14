from pathlib import Path
import json,re,subprocess,sys,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_shell_periodicity_successor_validation_v1 as src
names=[]
for m in ['AtomicShellRecords','AtomicShellMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';p=r/'AtomicShellMeasurementAudit956.lean';p.write_text('import SFT.Physics.AtomicShellMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'atomicshell956_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'AtomicShellMeasurementCompare956.lean';p.write_text('''import SFT.Physics.AtomicShellMeasurement
open SFT.Physics SFT.Host.Canonical AtomicShellMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicShellRecords.registeredRecord
 let intervals ← AtomicShellRecords.requiredRows.mapM (fun symbol => do
  let p ← IO.ofExcept (ionizationInterval record symbol)
  pure (symbol,pair p))
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("intervals",.object intervals),("label",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));root=w/'v3-runtime500';pair=lambda p:[[x.numerator,x.denominator] for x in p]
record=src.authoritative_record(root)
expected=dict(record=record,intervals={symbol:pair(src.ionization_interval(root,symbol)) for symbol in sorted(record['sources']['ionization']['rows'])},label=src.atomic_periodicity_classification(root));assert actual==expected
(w/'atomicshell956_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original full record,carrier and target intervals,translated prediction and classification;',len(names),'empty axioms')
