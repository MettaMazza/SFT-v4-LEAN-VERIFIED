from pathlib import Path
import subprocess,sys,os,json,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/QuarkDressing.lean').read_text();names=['SFT.Physics.QuarkDressing.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'QuarkDressingAudit916.lean';p.write_text('import SFT.Physics.QuarkDressing\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'quarkdressing916_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'QuarkDressingCompare916.lean';p.write_text('''import SFT.Physics.QuarkDressing
#eval match SFT.Physics.QuarkDressing.quarkDressingFactors with
 | .error e => IO.println e
 | .ok f => IO.println ("[[" ++ toString f.centralDownLift.num ++ "," ++ toString f.centralDownLift.den ++ "],[" ++ toString f.upperUpRetention.num ++ "," ++ toString f.upperUpRetention.den ++ "]]")
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True));original=src.quark_dressing_factors();expected=[[q.numerator,q.denominator] for q in original.values()];assert actual==expected
(w/'quarkdressing916_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:quark_dressing_factors','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS complete source factors and',len(names),'empty-axiom declarations')
