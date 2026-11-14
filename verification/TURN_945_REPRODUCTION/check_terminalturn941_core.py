from pathlib import Path
import json,sys,subprocess,os,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.matter_flavour_terminal_anomaly_laws_v1 import terminal_turn_support,terminal_turn_projection
p=r/'TerminalTurnCompare941.lean';p.write_text('''import SFT.Physics.TerminalTurn
open SFT.Physics SFT.Host.Canonical
#eval do
 let s ← IO.ofExcept TerminalTurn.terminalTurnSupport
 let q ← IO.ofExcept TerminalTurn.terminalTurnProjection
 IO.println (render (.array [.integer (.ofNat s),.integer q.num,.integer (.ofNat q.den)]))
''');env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));q=terminal_turn_projection();expected=[terminal_turn_support(),q.numerator,q.denominator];assert actual==expected
names=['SFT.Physics.TerminalTurn.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/TerminalTurn.lean').read_text(),re.M)];p=r/'TerminalTurnAudit941.lean';p.write_text('import SFT.Physics.TerminalTurn\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'terminalturn941_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names);(w/'terminalturn941_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names),indent=2));print('PASS generated support and full nested projection, five empty-axiom declarations')
