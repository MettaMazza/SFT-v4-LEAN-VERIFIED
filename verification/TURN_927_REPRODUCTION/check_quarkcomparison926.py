from pathlib import Path
import subprocess,sys,os,json,re
from fractions import Fraction
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
assert (w/'v3-runtime500/sft/physics/matter_flavour_validation_v1.py').read_bytes()==(w/'original926_matter_flavour_validation_v1.py').read_bytes()
s=(r/'SFT/Physics/QuarkComparison.lean').read_text();names=['SFT.Physics.QuarkComparison.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive|abbrev) (\w+)',s,re.M)];p=r/'QuarkComparisonAudit926.lean';p.write_text('import SFT.Physics.QuarkComparison\n'+''.join('#print axioms '+n+'\n' for n in names));env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
a=subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True);(w/'quarkcomparison926_core_audit.log').write_text(a);assert all("'"+n+"' does not depend on any axioms" in a for n in names),a
p=r/'QuarkComparisonCompare926.lean';p.write_text('''import SFT.Physics.QuarkComparison
import SFT.Host.Canonical
open SFT.Host.Canonical SFT.Physics.QuarkComparison
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (r : Interval) : Value := .array [fraction r.1,fraction r.2]
#eval do
 let (d,u) ← IO.ofExcept refinedQuarkRoots
 let q ← IO.ofExcept quarkPredictionIntervals
 let c ← IO.ofExcept ckmPredictionIntervals
 IO.println (render (.object [("roots",.object [("down",.array (d.map interval)),("up",.array (u.map interval))]),("quark",.object [("s_over_d",interval q.sOverD),("b_over_s",interval q.bOverS),("t_over_c",interval q.tOverC)]),("ckm",.object [("s12_squared",interval c.s12Squared),("s23_squared",interval c.s23Squared),("s13_squared",interval c.s13Squared),("jarlskog_squared",interval c.jarlskogSquared)])]))
''');actual=json.loads(subprocess.check_output([lean,'-j1',str(p.resolve())],env=env,text=True))
def cv(v):
 if isinstance(v,Fraction):return [v.numerator,v.denominator]
 if isinstance(v,dict):return {k:cv(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [cv(x) for x in v]
 return v
expected=cv(dict(roots=src.refined_quark_roots(),quark=src.quark_prediction_intervals(),ckm=src.ckm_prediction_intervals()));assert actual==expected
(w/'quarkcomparison926_science_report.json').write_text(json.dumps({'status':'PASS','source':'sft/physics/matter_flavour_validation_v1.py:refined_quark_roots,square_ratio_interval,scaled,inverted,overlaps,quark_prediction_intervals,ckm_prediction_intervals','actual':actual,'expected':expected,'audited_declarations':names,'axioms':[]},indent=2));print('PASS original refined roots and all7 prediction intervals;',len(names),'empty-axiom declarations')
