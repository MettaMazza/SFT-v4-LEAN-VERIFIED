from pathlib import Path
import sys,subprocess,json,re,os
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_precision_successor_laws_v1 as src
lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
names=['SFT.Physics.TerminalFine.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/TerminalFine.lean').read_text(),re.M)];p=r/'TerminalFineAudit952.lean';p.write_text('import SFT.Physics.TerminalFine\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalfine952_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'TerminalFineCompare952.lean';p.write_text("import SFT.Physics.TerminalFine\nopen SFT.Physics SFT.Host.Canonical\n#eval do\n let q ← IO.ofExcept TerminalFine.terminalFineCarrier\n IO.println (render (.array [.integer q.num,.integer (.ofNat q.den)]))\n");actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));v=src.terminal_fine_carrier();expected=[v.numerator,v.denominator];assert actual==expected
(w/'terminalfine952_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS original terminal fine carrier;',len(names),'empty axioms')
