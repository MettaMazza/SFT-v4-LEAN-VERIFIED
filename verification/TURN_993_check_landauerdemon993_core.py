from pathlib import Path
from fractions import Fraction
import sys,json,re,subprocess,os,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import landauer_demon_ledger_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expr=[]
def case(f,s):
 try:v=canonical_value(f())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expr.append(s)
def rat(x):return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
for value in [False,True,0,1]+[Fraction(n,d) for d in range(1,13) for n in range(-1,d+2)]:case(lambda:src.fold_part(value),'result rational (foldPart ('+('.fraction '+rat(value) if isinstance(value,Fraction) else '.nonFraction')+'))')
for label in ['', 'lower-preimage','upper-preimage','ready-half-One','environment-reverse-label','LOWER-PREIMAGE','lower-preimage ','α']:
 case(lambda:src.reset_is_reversible_with_record(label),'Value.boolean (resetIsReversibleWithRecord '+json.dumps(label,ensure_ascii=False)+')')
case(src.reset_preimages,'result pair resetPreimages');case(src.erased_distinction_count,'result (fun n => Value.integer (.ofNat n)) erasedDistinctionCount');case(src.minimum_throw,'result rational minimumThrow');case(src.reversible_reset_labels,'strings reversibleResetLabels');case(src.demon_cycle_ledger,'result ledger demonCycleLedger')
s='''import SFT.Physics.LandauerDemonLedger
import SFT.Host.Canonical
open SFT.Physics.LandauerDemonLedger SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def pair (p : Rat × Rat) : Value := .array [rational p.1,rational p.2]
def strings (s : List String) : Value := .array (s.map Value.text)
def ledger (r : CycleLedger) : Value := .object [("sorting_gain",strings r.sortingGain),("memory_support",strings r.memorySupport),("reset_image",strings r.resetImage),("erased_distinctions",.integer (.ofNat r.erasedDistinctions)),("environment_record",strings r.environmentRecord),("complete",.boolean r.complete)]
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join(expr)+']))\n';p=w/'constants-recovery/LandauerDemon993.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'landauerdemon993_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
code=(r/'SFT/Physics/LandauerDemonLedger.lean').read_text();names=['SFT.Physics.LandauerDemonLedger.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)];p=w/'landauerdemon993_core_audit.lean';p.write_text('import SFT.Physics.LandauerDemonLedger\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output([lean,str(p)],env=env,text=True);(w/'landauerdemon993_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names),out
(w/'landauerdemon993_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(names),'emptydeclarations')
