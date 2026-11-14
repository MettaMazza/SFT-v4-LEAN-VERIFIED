from pathlib import Path
import re,json,sys,subprocess,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_spectra_postseal_validation_v1 as src
names=[]
for m in ['AtomicPostsealRecords','AtomicPostsealMeasurement']:
 names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
p=r/'AtomicPostsealAudit949.lean';p.write_text('import SFT.Physics.AtomicPostsealMeasurement\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'atomicmeasurement949_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
mapping={'scale':'scale','lyman_prediction':'lymanPrediction','lyman_lower':'lymanLower','lyman_upper':'lymanUpper','lyman_passed':'lymanPassed','balmer_prediction':'balmerPrediction','balmer_lower':'balmerLower','balmer_upper':'balmerUpper','balmer_passed':'balmerPassed'}
p=r/'AtomicPostsealCompare949.lean';p.write_text('''import SFT.Physics.AtomicPostsealMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let record := AtomicPostsealRecords.registeredRecord
 let observed ← IO.ofExcept (AtomicPostsealMeasurement.cubicObservedCoordination record)
 let h ← IO.ofExcept (AtomicPostsealMeasurement.hydrogenComparison record)
 IO.println (render (.object [("record",record),("observed",.integer (.ofNat observed)),("hydrogen",.object ['''+','.join('('+json.dumps(k)+','+('.boolean h.' if k.endswith('passed') else 'frac h.')+v+')' for k,v in mapping.items())+'])]))\n')
actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));expected={'record':src.source_record(w/'v3-runtime500'),'observed':src.cubic_observed_coordination(w/'v3-runtime500'),'hydrogen':{k:([v.numerator,v.denominator] if isinstance(v,Fraction) else v) for k,v in src.hydrogen_comparison(w/'v3-runtime500').items()}}
assert actual==expected
(w/'atomicmeasurement949_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2))
print('PASS original record,count,and all nine hydrogen fields;',len(names),'empty axioms')
