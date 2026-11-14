from pathlib import Path
import json,subprocess,os,re,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'))
s=(r/'SFT/Physics/ProtonComparison.lean').read_text();names=['SFT.Physics.ProtonComparison.'+x for x in re.findall(r'^(?:def|theorem|inductive|abbrev) (\w+)',s,re.M)];p=r/'ProtonComparisonAudit927.lean';p.write_text('import SFT.Physics.ProtonComparison\n'+''.join('#print axioms '+n+'\n' for n in names));a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'protoncomparison927_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'ProtonComparisonCompare927.lean';p.write_text('''import SFT.Physics.ProtonComparison
import SFT.Host.Canonical
open SFT.Physics.ProtonComparison SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept protonRatioInterval
 IO.println (render (.array [fraction l,fraction u]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True));expected=json.loads((w/'protoncomparison927_original.json').read_text())['ratio'];assert actual==expected;(w/'protoncomparison927_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,audited_declarations=names,axioms=[]),indent=2));print('PASS exact source ratio and',len(names),'empty-axiom declarations')
