from pathlib import Path
import json,re,subprocess,sys,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_terminal_ckm_laws_v1 as law,matter_flavour_terminal_ckm_validation_v1 as validation
mods=['TerminalBaryon','TerminalBaryonMeasurement'];names=[]
for m in mods:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive|abbrev) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'TerminalBaryonAudit939.lean';p.write_text(''.join('import SFT.Physics.'+m+'\n' for m in mods)+''.join('#print axioms '+n+'\n' for n in names));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalbaryon939_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'TerminalBaryonCompare939.lean';p.write_text('''import SFT.Physics.TerminalBaryonMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r := TerminalBaryon.terminalBaryonRelation
 let p ← IO.ofExcept TerminalBaryon.predictionInterval
 let label ← IO.ofExcept (TerminalBaryonMeasurement.classificationFromRecord TerminalMatterRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("mixing_source",.text r.mixingSource),("cp_measure",.text r.cpMeasure),("imbalance_share",frac r.imbalanceShare),("eta_relation",.text r.etaRelation)]),("prediction",.array [frac p.1,frac p.2]),("classification",.text label)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def cv(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,(list,tuple)):return [cv(y) for y in x]
 if isinstance(x,dict):return {k:cv(v) for k,v in x.items()}
 return x
expected=cv(dict(relation=law.terminal_baryon_photon_relation(),prediction=validation.terminal_eta_prediction_interval(),classification=validation.terminal_eta_classification(w/'v3-runtime500')));assert actual==expected
(w/'terminalbaryon939_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS complete4-field relation,exact eta endpoints and both source comparison routes;',len(names),'empty-axiom declarations')
