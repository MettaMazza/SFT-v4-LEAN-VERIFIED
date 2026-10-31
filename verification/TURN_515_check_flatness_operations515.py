from pathlib import Path
from fractions import Fraction
from typing import Sequence
import ast,subprocess,json,os,hashlib
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';source='sft/physics/spatial_flatness_law.py';raw=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+source],text=True)
ns=dict(Fraction=Fraction,Sequence=Sequence,EMPTY_ONE=object());tree=ast.parse(raw);nodes=[n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name in ['closed_partition','refine_partition']];exec(compile(ast.fix_missing_locations(ast.Module(body=nodes,type_ignores=[])),source,'exec'),ns)
F=Fraction
closed=[[F(1,3),F(2,3)],[F(1,3),F(1,6),F(1,2)],[F(1)],[],[F(1,2)],[F(0),F(1)],[F(-1),F(2)],[F(2)],[1],[True],[F(1,2),F(1,2)]]
refined=[([F(1,3),F(2,3)],1,F(1,6),F(1,2)),([F(-1),F(2)],1,F(1),F(1)),([F(1)],False,F(1,3),F(2,3)),([F(1,3),F(2,3)],True,F(1,3),F(1,3)),([],0,F(1),F(1)),([F(1)],-1,F(1,2),F(1,2)),([F(1)],1,F(1,2),F(1,2)),([F(1)],0,F(0),F(1)),([F(1)],0,F(1,3),F(1,3)),([F(1)],0,F(-1),F(2))]
def outcome(fn,args):
 try:
  result=ns[fn](*args)
  return 'empty-One' if result is ns['EMPTY_ONE'] else [[str(x.numerator),str(x.denominator)] for x in result]
 except ValueError as e:return 'error: '+str(e)
expected=[outcome('closed_partition',(p,)) for p in closed]+[outcome('refine_partition',x) for x in refined]
def rat(f):return '(SFT.Physics.LeptonIntervals.normalize ('+str(f.numerator)+') '+str(f.denominator)+' (by decide))'
def idx(i):return '.boolean '+str(i).lower() if isinstance(i,bool) else '.integer ('+str(i)+')'
s='''import SFT.Physics.CosmoSpatialFlatness
import Lean
open SFT.Physics.CosmoSpatialFlatness
def closedResult (r : Except String SFT.Mathematics.FoldScalar.Scalar) : Lean.Json :=
 match r with
 | .error e => .str ("error: "++e)
 | .ok v => match v with
   | .emptyOne => .str "empty-One"
   | .positive _ _ => .str "unexpected-present-remainder"
def refinedResult (r : Except String (List Rat)) : Lean.Json :=
 match r with
 | .error e => .str ("error: "++e)
 | .ok ps => .arr ((ps.map fun q => Lean.toJson [toString q.num,toString q.den]).toArray)
def main : IO Unit := do
'''
for p in closed:s+=' IO.println ((closedResult (closedPartitionInput ['+','.join('some '+rat(x) if isinstance(x,Fraction) else 'none' for x in p)+'])).compress)\n'
for p,i,a,b in refined:s+=' IO.println ((refinedResult (refinePartition ['+','.join(rat(x) for x in p)+'] ('+idx(i)+') '+rat(a)+' '+rat(b)+')).compress)\n'
p=Path('work/constants-recovery/FlatnessOperations515.lean');p.write_text(s);env=dict(os.environ,LEAN_PATH=str(Path('work/constants-recovery/.lake/build/lib/lean').resolve()))
res=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M2048','--run',str(p)],env=env,text=True,capture_output=True);Path('work/flatness_operations515.log').write_text(res.stdout+res.stderr);assert res.returncode==0,res.stdout+res.stderr
actual=[json.loads(x) for x in res.stdout.splitlines()];assert actual==expected,(actual,expected)
report=dict(status='PASS',source_commit=pin,source_path=source,source_sha256=hashlib.sha256(raw.encode()).hexdigest(),cases=len(expected),closed_partition_cases=len(closed),refine_partition_cases=len(refined),actual=actual,driver_sha256=hashlib.sha256(s.encode()).hexdigest(),scope='Fresh native Lean operation outputs compared directly with the two functions extracted unchanged from the pinned V3 source; includes non-Fraction and nonpositive closure guards, exact sum, Boolean/negative/out-of-range indices, nonpositive/mismatched children and preservation of an untouched negative prefix.')
Path('work/flatness_operations515_report.json').write_text(json.dumps(report,indent=2)+'\n');print('PASS',len(expected),'source-operation cases')
