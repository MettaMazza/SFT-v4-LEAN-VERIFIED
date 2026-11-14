from pathlib import Path
import sys,json,subprocess,os,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import hydrogen_rydberg_successor_laws_v1 as src
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
names=['SFT.Physics.HydrogenRydberg.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/HydrogenRydberg.lean').read_text(),re.M)];p=r/'HydrogenRydbergAudit955.lean';p.write_text('import SFT.Physics.HydrogenRydberg\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'hydrogenrydberg955_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
values=[False,True,0,2,Fraction(-2),Fraction(0),Fraction(1,2),Fraction(1),Fraction(1001,1000),Fraction(2),Fraction(53,3),Fraction(1836),Fraction(10000)]
def value(x):return '.fraction (LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))' if isinstance(x,Fraction) else '.nonFraction'
p=r/'HydrogenRydbergCompare955.lean';p.write_text('''import SFT.Physics.HydrogenRydberg
open SFT.Physics SFT.Host.Canonical HydrogenRydberg
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
#eval do
 let inputs : List FoldFirstReturn.Input := ['''+','.join(value(x) for x in values)+''']
 let scale ← IO.ofExcept terminalHydrogenScaleInterval
 let rest ← IO.ofExcept terminalIonizationToElectronRestInterval
 IO.println (render (.object [("scale",.array [frac scale.1,frac scale.2]),("rest",.array [frac rest.1,frac rest.2]),("scaleAt",.array (inputs.map (fun x => result (terminalHydrogenScaleAt x))))]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def out(fn,*args):
 try:q=fn(*args);return [q.numerator,q.denominator]
 except ValueError as e:return {'error':str(e)}
expected={'scale':[[q.numerator,q.denominator] for q in src.terminal_hydrogen_scale_interval()],'rest':[[q.numerator,q.denominator] for q in src.terminal_ionization_to_electron_rest_interval()],'scaleAt':[out(src.terminal_hydrogen_scale_at,x) for x in values]};assert actual==expected
(w/'hydrogenrydberg955_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names,remaining=[]),indent=2));print('PASS original hydrogen scale, interval, electron-rest composition and13input cases;',len(names),'empty axioms')
