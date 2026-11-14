from pathlib import Path
import ast,sys,json,os,subprocess,re
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
p=w/'v3-runtime500/sft/physics/nuclear_binding_curve_successor_laws_v1.py'
# Execute the original imports and operation definitions, without eagerly executing
# the module's unrelated all-candidate peak census a second time.
tree=ast.parse(p.read_text());nodes=[]
for node in tree.body:
 if isinstance(node,(ast.Import,ast.ImportFrom,ast.FunctionDef)):nodes.append(node)
ns={'__name__':'source_operations962'};exec(compile(ast.Module(body=nodes,type_ignores=[]),str(p),'exec'),ns)
expected=ns['tail_upper_bounds']()
from fractions import Fraction
def enc(x):
 if isinstance(x,Fraction):return [x.numerator,x.denominator]
 if isinstance(x,dict):return {k:enc(v) for k,v in x.items()}
 return x
s='''import SFT.Physics.NuclearBindingTail
open SFT.Physics SFT.Host.Canonical NuclearBindingTail LeptonIntervals
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 match tailUpperBounds with
 | .error e => throw (IO.userError e)
 | .ok v => IO.println (render (.object [("cutoff_mass",.integer (.ofNat v.cutoffMass)),("cutoff_radius",.integer v.cutoffRadius),("low_charge_upper",frac v.lowChargeUpper),("high_charge_upper",frac v.highChargeUpper),("coulomb_tail_successor_monotone",.boolean v.coulombTailSuccessorMonotone)]))
'''
p=r/'NuclearBindingTailCompare962.lean';p.write_text(s);env=dict(os.environ,LEAN_PATH=str(c/'.lake/build/lib/lean'));tc='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
actual=json.loads(subprocess.check_output([tc,'-j1',str(p)],env=env,text=True));assert actual==enc(expected)
names=[]
for m in ['NuclearBindingRadius','NuclearBindingTail']:names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',(r/'SFT/Physics'/f'{m}.lean').read_text(),re.M)]
p=r/'NuclearBindingRadiusTailAudit962.lean';p.write_text('import SFT.Physics.NuclearBindingTail\n'+'\n'.join('#print axioms '+n for n in names))
a=subprocess.check_output([tc,'-j1',str(p)],env=env,text=True);(w/'nuclearbindingcurve962_radiustail_audit.log').write_text(a)
assert all("'"+n+"' does not depend on any axioms" in a for n in names)
(w/'nuclearbindingcurve962_tail_report.json').write_text(json.dumps(dict(status='PASS',actual=actual,expected=enc(expected),audited_declarations=names,axioms=[]),indent=2));print('PASS five original tail fields;',len(names),'empty declarations including all-input source whole-loop correspondence')
