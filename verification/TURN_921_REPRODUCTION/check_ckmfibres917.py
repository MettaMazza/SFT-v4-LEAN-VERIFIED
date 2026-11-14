from pathlib import Path
import subprocess,sys,os,json,re,ast
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_laws_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_laws_v1.py').read_bytes()==(w/'original916_matter_flavour_laws_v1.py').read_bytes()
s=(r/'SFT/Physics/CKMFibres.lean').read_text();names=['SFT.Physics.CKMFibres.'+n for n in re.findall(r'^(?:def|theorem|structure) (\w+)',s,re.M)];p=r/'CKMFibresAudit917.lean';p.write_text('import SFT.Physics.CKMFibres\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'ckmfibres917_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
p=r/'CKMFibresCompare917.lean';p.write_text('''import SFT.Physics.CKMFibres
#eval match SFT.Physics.CKMFibres.ckmFibres with
 | .error e => IO.println e
 | .ok f => IO.println (reprStr (f.massBasis.map (fun (r : Rat) => (r.num,r.den)), f.channelBasis.map (fun (r : Rat) => (r.num,r.den)), f.matrix.map (fun (row : List Rat) => row.map (fun (r : Rat) => (r.num,r.den)))))
''');actual=ast.literal_eval(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True));o=src.ckm_fibres();pair=lambda q:(q.numerator,q.denominator);expected=([pair(q) for q in o['mass_basis']],[pair(q) for q in o['channel_basis']],[[pair(q) for q in row] for row in o['matrix']]);assert actual==expected
(w/'ckmfibres917_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_laws_v1.py:ckm_fibres','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS complete two bases and nine-cell matrix;',len(names),'empty-axiom declarations')
