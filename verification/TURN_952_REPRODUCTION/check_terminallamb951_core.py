from pathlib import Path
import sys,subprocess,json,re,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_precision_successor_laws_v1 as src
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
names=['SFT.Physics.TerminalLamb.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/TerminalLamb.lean').read_text(),re.M)];p=r/'TerminalLambAudit951.lean';p.write_text('import SFT.Physics.TerminalLamb\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminallamb951_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'TerminalLambCompare951.lean';p.write_text('''import SFT.Physics.TerminalLamb
open SFT.Physics SFT.Host.Canonical TerminalLamb
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let alpha ← IO.ofExcept exactAlpha
 let heavy ← IO.ofExcept depthThreeHeavyComplement
 let support ← IO.ofExcept predecessorUpSupport
 let terminal ← IO.ofExcept terminalBinarySupport
 let lamb ← IO.ofExcept terminalLambCarrier
 IO.println (render (.object [("alpha",frac alpha),("heavy",.integer heavy),("support",.integer (.ofNat support)),("terminal",.integer (.ofNat terminal)),("lamb",frac lamb)]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));frac=lambda x:[x.numerator,x.denominator];expected=dict(alpha=frac(src.exact_alpha()),heavy=src.depth_three_heavy_complement(),support=src.predecessor_up_support(),terminal=src.terminal_binary_support(),lamb=frac(src.terminal_lamb_carrier()));assert actual==expected
(w/'terminallamb951_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS all five original operations;',len(names),'empty axioms')
