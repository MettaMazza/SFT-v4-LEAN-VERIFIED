from pathlib import Path
import json,re,subprocess,os,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import molecular_spectroscopy_successor_validation_v1 as src
names=[]
for m in ['MolecularSpectroscopyRecords','MolecularSpectroscopyMeasurement']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));p=r/'MolecularMeasurementAudit954.lean';p.write_text('import SFT.Physics.MolecularSpectroscopyMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'molecular954_measurement_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'MolecularMeasurementCompare954.lean';p.write_text('''import SFT.Physics.MolecularSpectroscopyMeasurement
open SFT.Physics SFT.Host.Canonical MolecularSpectroscopyMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := MolecularSpectroscopyRecords.registeredRecord
 let intervals ← IO.ofExcept (measuredRatioIntervals record)
 let predictions ← IO.ofExcept sealedRatioVector
 let label ← IO.ofExcept (classificationFromRecord record)
 let rows ← ["hydrogen","deuterium"].flatMapM fun isotope => ["vibrational_constant_cm_inverse","anharmonic_constant_cm_inverse","rotational_constant_cm_inverse"].mapM fun name => do
  let interval ← IO.ofExcept (sourceInterval record isotope name)
  pure (Value.array [.text isotope,.text name,pair interval])
 IO.println (render (.object [("record",record),("rows",.array rows),("intervals",.object (intervals.map (fun (p : String × (Rat × Rat)) => (p.1,pair p.2)))),("predictions",.object (predictions.map (fun (p : String × Rat) => (p.1,frac p.2)))),("label",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));root=w/'v3-runtime500';frac=lambda q:[q.numerator,q.denominator];pair=lambda p:list(map(frac,p));expected=dict(record=src.authoritative_record(root),rows=[[i,n,pair(src.source_interval(root,i,n))] for i in ['hydrogen','deuterium'] for n in ['vibrational_constant_cm_inverse','anharmonic_constant_cm_inverse','rotational_constant_cm_inverse']],intervals={k:pair(v) for k,v in src.measured_ratio_intervals(root).items()},predictions={k:frac(v) for k,v in src.sealed_ratio_vector().items()},label=src.molecular_spectroscopy_classification(root));assert actual==expected
(w/'molecular954_measurement_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS entire record,six source rows,four outward intervals and predictions,classifier;',len(names),'empty axioms')
