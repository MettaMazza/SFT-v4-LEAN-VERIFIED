from pathlib import Path
import json,re,subprocess,sys,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_ckm_laws_v1 as law,matter_flavour_terminal_ckm_validation_v1 as validation
mods=['TerminalCKM','TerminalQuarkRoots','TerminalCKMComparison','TerminalMatterRecords','TerminalCKMMeasurement'];names=[]
for m in mods:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive|abbrev) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'TerminalCKMAudit938.lean';p.write_text(''.join('import SFT.Physics.'+m+'\n' for m in mods)+''.join('#print axioms '+n+'\n' for n in names));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalckm938_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'TerminalCKMCompare938.lean';p.write_text('''import SFT.Physics.TerminalCKMMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (r : Rat × Rat) : Value := .array [frac r.1,frac r.2]
#eval do
 let r ← IO.ofExcept TerminalCKM.terminalCKMRelation
 let roots ← IO.ofExcept TerminalQuarkRoots.refinedQuarkRoots
 let p ← IO.ofExcept TerminalCKMComparison.predictionIntervals
 let label ← IO.ofExcept (TerminalCKMMeasurement.classificationFromRecord TerminalMatterRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("leading_s23",.text r.leadingS23),("terminal_contribution",frac r.terminalContribution),("terminal_s23",.text r.terminalS23),("s12_squared",.text r.s12Squared),("s13_squared",.text r.s13Squared),("phase",frac r.phase)]),("roots",.object [("down",.array (roots.1.map interval)),("up",.array (roots.2.map interval))]),("predictions",.object [("s12_squared",interval p.s12Squared),("s23_squared",interval p.s23Squared),("s13_squared",interval p.s13Squared),("jarlskog_squared",interval p.jarlskogSquared)]),("record",TerminalMatterRecords.registeredRecord),("classification",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=cv(dict(relation=law.terminal_ckm_relation(),roots=validation.refined_quark_roots(),predictions=validation.terminal_ckm_prediction_intervals(),record=validation.authoritative_record(w/'v3-runtime500'),classification=validation.terminal_ckm_classification(w/'v3-runtime500')));assert actual==expected
(w/'terminalckm938_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS original6-field law,all6 refined root intervals,all4 predictions,complete source record and classification;',len(names),'empty-axiom declarations')
