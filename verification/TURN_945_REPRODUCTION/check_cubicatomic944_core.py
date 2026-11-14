from pathlib import Path
import json,sys,subprocess,os,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.atomic_spectra_completion_laws_v1 import cubic_coordination,cubic_neighbour_weight,cubic_balance
p=r/'CubicAtomicSupportCompare944.lean';p.write_text('''import SFT.Physics.CubicAtomicSupport
open SFT.Physics SFT.Host.Canonical
#eval do
 let n ← IO.ofExcept CubicAtomicSupport.cubicCoordination
 let w ← IO.ofExcept CubicAtomicSupport.cubicNeighbourWeight
 let b ← IO.ofExcept CubicAtomicSupport.cubicBalance
 IO.println (render (.array [.integer (.ofNat n),.integer w.num,.integer (.ofNat w.den),.integer b.num,.integer (.ofNat b.den)]))
''');env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));a=cubic_neighbour_weight();b=cubic_balance();expected=[cubic_coordination(),a.numerator,a.denominator,b.numerator,b.denominator];assert actual==expected
names=['SFT.Physics.CubicAtomicSupport.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/CubicAtomicSupport.lean').read_text(),re.M)];p=r/'CubicAtomicSupportAudit944.lean';p.write_text('import SFT.Physics.CubicAtomicSupport\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'cubicatomic944_core_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in names);(w/'cubicatomic944_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original cubic coordination,weight,balance;6 empty axioms')
