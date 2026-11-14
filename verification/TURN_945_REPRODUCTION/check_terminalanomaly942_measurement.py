from pathlib import Path
import json,re,subprocess,sys,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_anomaly_validation_v1 as source
names=[]
for m in ['TerminalAnomalyRecords','TerminalAnomalyMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'TerminalAnomalyMeasurementAudit942.lean';p.write_text('import SFT.Physics.TerminalAnomalyMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalanomaly942_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'TerminalAnomalyMeasurementCompare942.lean';p.write_text('''import SFT.Physics.TerminalAnomalyMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let record := TerminalAnomalyRecords.registeredRecord
 let e ← IO.ofExcept (TerminalAnomalyMeasurement.sourceIntervalFromRecord record "electron")
 let m ← IO.ofExcept (TerminalAnomalyMeasurement.sourceIntervalFromRecord record "muon")
 let el ← IO.ofExcept (TerminalAnomalyMeasurement.classificationFromRecord record "electron")
 let ml ← IO.ofExcept (TerminalAnomalyMeasurement.classificationFromRecord record "muon")
 IO.println (render (.object [("record",record),("electron",.array [frac e.1,frac e.2,.text el]),("muon",.array [frac m.1,frac m.2,.text ml])]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));expected={'record':source.authoritative_record(w/'v3-runtime500')}
for key in ['electron','muon']:
 interval=source.source_interval(w/'v3-runtime500',key);expected[key]=[[x.numerator,x.denominator] for x in interval]+[source.anomaly_classification(w/'v3-runtime500',key)]
assert actual==expected;(w/'terminalanomaly942_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS entire original record,both intervals and classifications;',len(names),'empty axioms')
