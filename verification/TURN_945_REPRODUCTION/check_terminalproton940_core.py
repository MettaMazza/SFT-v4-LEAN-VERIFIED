from pathlib import Path
import json,re,subprocess,sys,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_proton_laws_v1 as law,matter_flavour_terminal_proton_validation_v1 as validation
mods=['TerminalProton','TerminalProtonComparison','TerminalProtonRecords','TerminalProtonMeasurement'];names=[]
for m in mods:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive|abbrev) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'TerminalProtonAudit940.lean';p.write_text(''.join('import SFT.Physics.'+m+'\n' for m in mods)+''.join('#print axioms '+n+'\n' for n in names));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalproton940_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'TerminalProtonCompare940.lean';p.write_text('''import SFT.Physics.TerminalProtonMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (p : Rat × Rat) : Value := .array [frac p.1,frac p.2]
#eval do
 let r ← IO.ofExcept TerminalProton.terminalProtonRelation
 let p ← IO.ofExcept TerminalProtonComparison.protonRatioInterval
 let target ← IO.ofExcept (TerminalProtonMeasurement.sourceIntervalFromRecord TerminalProtonRecords.registeredRecord)
 let label ← IO.ofExcept (TerminalProtonMeasurement.classificationFromRecord TerminalProtonRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("base",.text r.base),("composite_depth",.integer (.ofNat r.compositeDepth)),("heavy_complement",frac r.heavyComplement),("bulk_boundary_support",.integer (.ofNat r.bulkBoundarySupport)),("self_coupling_order",.integer (.ofNat r.selfCouplingOrder)),("terminal_transport",frac r.terminalTransport),("dressing",frac r.dressing),("retention",frac r.retention),("result",.text r.result)]),("roots",.array (TerminalProtonComparison.refinedBrackets.map interval)),("prediction",interval p),("record",TerminalProtonRecords.registeredRecord),("target",interval target),("classification",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=cv(dict(relation=law.terminal_proton_relation(),roots=validation.refined_roots(),prediction=validation.terminal_proton_prediction_interval(),record=validation.authoritative_record(w/'v3-runtime500'),target=validation.source_interval(w/'v3-runtime500'),classification=validation.terminal_proton_classification(w/'v3-runtime500')));assert actual==expected
(w/'terminalproton940_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete9-field relation,all3 refined root intervals,exact prediction,full source record,target and classification;',len(names),'empty-axiom declarations')
