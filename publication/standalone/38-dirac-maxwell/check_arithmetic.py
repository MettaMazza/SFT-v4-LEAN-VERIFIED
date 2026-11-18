from pathlib import Path
from fractions import Fraction
import ast,json,hashlib,copy
root=Path(__file__).resolve().parents[1];dest=root;dest.mkdir(exist_ok=True)
hashes={}
def load(name,extra=None,only=None):
 f=root/'v3/sft/physics'/(name+'.py');g={'Fraction':Fraction};g.update(extra or {});hashes[str(f.relative_to(root/'v3'))]=hashlib.sha256(f.read_bytes()).hexdigest()
 for n in ast.parse(f.read_text()).body:
  if isinstance(n,ast.FunctionDef) and (only is None or n.name in only):exec(compile(ast.fix_missing_locations(ast.Module(body=[ast.ImportFrom(module='__future__',names=[ast.alias(name='annotations')],level=0),n],type_ignores=[])),str(f),'exec'),g)
  elif isinstance(n,ast.Assign) and len(n.targets)==1 and isinstance(n.targets[0],ast.Name):
   try:g[n.targets[0].id]=ast.literal_eval(n.value)
   except (ValueError,TypeError):
    if isinstance(n.value,ast.Call) and isinstance(n.value.func,ast.Name) and n.value.func.id=='Fraction':g[n.targets[0].id]=Fraction(*(ast.literal_eval(x) for x in n.value.args))
 return g

s=load('structural_constants');a=load('atomic_constants',s);f=load('relativistic_field_laws_v1',{**s,**a})
records={'two_hand':f['two_hand_dirac_square'](),'full':f['full_dirac_square'](),'coulomb_inner':f['coulomb_gauss_closure'](Fraction(1,8),Fraction(1,4)),'coulomb_outer':f['coulomb_gauss_closure'](Fraction(1,8),Fraction(1,2)),'magnetic_half':f['magnetic_relativistic_factor'](Fraction(1,2)),'magnetic_third':f['magnetic_relativistic_factor'](Fraction(1,3)),'lorentz':f['lorentz_transfer'](Fraction(1,4),Fraction(1,2)),'planar':f['maxwell_closure'](2),'spatial':f['maxwell_closure'](3)}
assert records['two_hand']=={'momentum':Fraction(3,5),'mass':Fraction(4,5),'energy_square':Fraction(1)}
assert records['full']['direct_square']==records['full']['polarized_square']==1 and records['full']['held_equal_differences']==((),())
assert records['coulomb_inner']['flux']==records['coulomb_outer']['flux']==Fraction(1,8)
assert records['magnetic_half']['folded_remainder']==Fraction(1,2) and records['magnetic_third']['folded_remainder']==Fraction(7,9)
assert records['lorentz']=={'retained_force':Fraction(3,16),'motion_share':Fraction(1,16),'source_force':Fraction(1,4)}
assert records['planar']['speed_square']==records['spatial']['speed_square']==1
boundary=[]
for name,args in [('magnetic_relativistic_factor',(Fraction(0),)),('magnetic_relativistic_factor',(Fraction(1),)),('magnetic_relativistic_factor',(0.5,)),('lorentz_transfer',(Fraction(0),Fraction(1,2))),('coulomb_gauss_closure',(Fraction(1,2),Fraction(1,2))),('coulomb_gauss_closure',(Fraction(1,4),Fraction(2))),('maxwell_closure',(1,)),('maxwell_closure',(4,))]:
 try:f[name](*args)
 except ValueError:boundary.append((name,str(args),'rejected'))
 else:raise AssertionError((name,args))
record=json.loads((root/'v3/experiments/external_sources/physics/snapshots/relativistic-field-source-record.json').read_text());assert len(record['sources'])==7 and len(record['unfavorable_and_scope_controls'])==5 and record['formal_seal_boundary']['sealed_claim_count']==12
for row in record['sources']:
 if 'snapshot' in row:
  b=(root/'v3/experiments/external_sources/physics/snapshots'/row['snapshot']).read_bytes();assert 'sha256:'+hashlib.sha256(b).hexdigest()==row['snapshot_hash']
aps=(Fraction(27-31,10**17),Fraction(27+31,10**17));assert aps[0]<0<aps[1]
def clean(v):
 if isinstance(v,Fraction):return str(v)
 if isinstance(v,dict):return {k:clean(x) for k,x in v.items()}
 if isinstance(v,(tuple,list)):return [clean(x) for x in v]
 return v
out={'source_sha256':hashes,'records':records,'guards':boundary,'authoritative_record':record,'aps_exponent_interval':aps,'source_component_hashes_verified':True,'interpretation':'The original sealed comparator compares the complete registered classification label. Interval arithmetic here displays the original APS record; it is not a newly substituted validator.'};(dest/'arithmetic_check.json').write_text(json.dumps(clean(out),indent=2)+'\n');print({'records':len(records),'guards':len(boundary),'sources':7,'retained_controls':5,'status':'PASS'})
