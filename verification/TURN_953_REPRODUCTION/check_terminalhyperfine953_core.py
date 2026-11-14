from pathlib import Path
import sys,json,subprocess,os,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_precision_successor_laws_v1 as src
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
names=['SFT.Physics.TerminalHyperfine.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/TerminalHyperfine.lean').read_text(),re.M)];p=r/'TerminalHyperfineAudit953.lean';p.write_text('import SFT.Physics.TerminalHyperfine\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalhyperfine953_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
values=[False,True,0,2,Fraction(-2),Fraction(0),Fraction(1,2),Fraction(1),Fraction(1001,1000),Fraction(2),Fraction(53,3),Fraction(1836),Fraction(10000)]
def value(x):return '.fraction (LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))' if isinstance(x,Fraction) else '.nonFraction'
p=r/'TerminalHyperfineCompare953.lean';p.write_text('''import SFT.Physics.TerminalHyperfine
open SFT.Physics SFT.Host.Canonical TerminalHyperfine
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
#eval do
 let inputs : List FoldFirstReturn.Input := ['''+','.join(value(x) for x in values)+''']
 let proton ← IO.ofExcept terminalProtonRatioInterval
 let interval ← IO.ofExcept terminalHyperfineCarrierInterval
 IO.println (render (.object [("proton",.array [frac proton.1,frac proton.2]),("interval",.array [frac interval.1,frac interval.2]),("magnetic",result terminalProtonMagneticProjection),("reduced",.array (inputs.map (fun x => result (reducedMassRetention x)))),("hyperfine",.array (inputs.map (fun x => result (hyperfineCarrierAt x))))]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def out(fn,*args):
 try:q=fn(*args);return [q.numerator,q.denominator]
 except ValueError as e:return {'error':str(e)}
expected={'proton':[[q.numerator,q.denominator] for q in src.terminal_proton_ratio_interval()],'interval':[[q.numerator,q.denominator] for q in src.terminal_hyperfine_carrier_interval()],'magnetic':out(src.terminal_proton_magnetic_projection),'reduced':[out(src.reduced_mass_retention,x) for x in values],'hyperfine':[out(src.hyperfine_carrier_at,x) for x in values]};assert actual==expected
(w/'terminalhyperfine953_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names,remaining=[]),indent=2));print('PASS original magnetic projection,reduced-mass guard and13input cases through hyperfine carrier;',len(names),'empty axioms')
