from pathlib import Path
import sys,os,re,json,subprocess,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import symmetry_action_terminal_law_v1 as src
expected=[];expressions=[]
def case(call,expr):
 try: value=call()
 except ValueError as e:value={'error':str(e)}
 expected.append(value);expressions.append(expr)
for x in [True,False,-2,0,1,2,3,8,16,128]:
 inp='.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
 case(lambda x=x:src.all_reduced_fold_parts_preserve_odd_core(x),'allReducedFoldPartsPreserveOddCore ('+inp+')')
for x in [True,False,-1,0,1,2,4,8]:
 inp='.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
 case(lambda x=x:src.all_dyadic_parts_descend(x),'allDyadicPartsDescend ('+inp+')')
case(src.all_small_paths_obey_action_boundary,'allSmallPathsObeyActionBoundary')
for i,name in [(2,'completeChargeWitness'),(3,'incidenceCarrierWitness'),(4,'telescopingWitness')]:case(lambda i=i:src.SPEC.witnesses[i].passed,name)
s='''import SFT.Physics.SymmetryActionWitnesses
import SFT.Host.Canonical
open SFT.Physics.SymmetryActionWitnesses SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def result : Except String Bool → Value | .error e => .object [("error",.text e)] | .ok b => .boolean b
#eval IO.println (render (.array [
'''+',\n'.join('result ('+e+')' for e in expressions)+']))\n'
p=w/'constants-recovery/SymmetryWitnesses990.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean'
x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'symmetry990_witness_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];assert json.loads(x.stdout)==expected
code=(r/'SFT/Physics/SymmetryActionWitnesses.lean').read_text();names=['SFT.Physics.SymmetryActionWitnesses.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',code,re.M)]
p=w/'symmetry990_witness_audit.lean';p.write_text('import SFT.Physics.SymmetryActionWitnesses\n'+''.join('#print axioms '+n+'\n' for n in names));x=subprocess.check_output([lean,str(p)],env=env,text=True);(w/'symmetry990_witness_audit.log').write_text(x);assert x.count('does not depend on any axioms')==len(names),x
(w/'symmetry990_witness_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),declarations=names,axioms=[],sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'original witness/domain cases',len(names),'empty declarations')
