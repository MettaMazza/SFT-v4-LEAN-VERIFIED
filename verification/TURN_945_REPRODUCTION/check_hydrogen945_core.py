from pathlib import Path
import json,re,subprocess,sys,os
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.atomic_spectra_completion_laws_v1 import hydrogen_level,hydrogen_transition
p=r/'HydrogenAudit945.lean';names=['SFT.Physics.HydrogenSpectrum.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/'SFT/Physics/HydrogenSpectrum.lean').read_text(),re.M)];p.write_text('import SFT.Physics.HydrogenSpectrum\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';a=subprocess.check_output([lean,'-j1',str(p)],env=env,text=True);(w/'hydrogen945_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names)
values=[False,True]+list(range(-3,13));encoded=['.boolean '+str(v).lower() if isinstance(v,bool) else '.integer ('+str(v)+')' for v in values]
p=r/'HydrogenCompare945.lean';p.write_text('''import SFT.Physics.HydrogenSpectrum
open SFT.Physics SFT.Host.Canonical GeneratorOperations
def output : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let values : List CountInput := ['''+','.join(encoded)+''']
 IO.println (render (.object [("levels",.array (values.map fun x => output (HydrogenSpectrum.hydrogenLevel x))),
 ("transitions",.array (values.flatMap fun u => values.map fun l => output (HydrogenSpectrum.hydrogenTransition u l)))]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p)],env=env,text=True))
def call(f,*args):
 try:q=f(*args);return [q.numerator,q.denominator]
 except ValueError as e:return {'error':str(e)}
expected={'levels':[call(hydrogen_level,v) for v in values],'transitions':[call(hydrogen_transition,u,l) for u in values for l in values]};assert actual==expected;(w/'hydrogen945_science_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=expected,axioms=[],audited_declarations=names,general_source_proofs=['everyPositivePrincipal','positivePrincipalSuccessor','principalPositive','orderedPrincipalSupports','everyOrderedEmission']),indent=2));print('PASS',len(names),'empty-axiom declarations,18 level cases,324 transition cases and original general source proofs')
