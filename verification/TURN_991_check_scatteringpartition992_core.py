from pathlib import Path
from fractions import Fraction
import sys,json,re,subprocess,os,hashlib,itertools
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import scattering_partition_path_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
expected=[];expressions=[]
def case(f,s):
 try:v=canonical_value(f())
 except ValueError as e:v={'error':str(e)}
 expected.append(v);expressions.append(s)
def rat(x):return '(SFT.Physics.LeptonIntervals.normalize ('+str(x.numerator)+') '+str(x.denominator)+' (by decide))'
def fraction(x):return '.fraction '+rat(x) if isinstance(x,Fraction) else '.nonFraction'
def count(x):return '.boolean '+str(x).lower() if isinstance(x,bool) else '.integer ('+str(x)+')'
def ordered(x):return ('.fraction ' if isinstance(x,Fraction) else '.nonFractionNumber ')+rat(Fraction(x))
for labels in [(),('a',),('a','a'),('a','b'),('a','b','a','b'),('a','b','c'),('α','é','α'),('','b')]:
 code=json.dumps(list(labels),ensure_ascii=False);case(lambda:src.two_fibre_outcome_measure(labels),'result pair (twoFibreOutcomeMeasure '+code+')');case(lambda:src.partition_is_complete(labels),'result Value.boolean (partitionIsComplete '+code+')')
for a,b in itertools.product([False,True,-1,0,1,2,3,5],repeat=2):case(lambda:src.cross_section(a,b),'result rational (crossSection ('+count(a)+') ('+count(b)+'))')
values=[Fraction(-1),Fraction(0),Fraction(1,4),Fraction(1),Fraction(3,2),1,True]
for a,b in itertools.product(values,repeat=2):case(lambda:src.mean_free_path(a,b),'result rational (meanFreePath ('+fraction(a)+') ('+fraction(b)+'))')
for d,a,b in itertools.product([Fraction(0),Fraction(3,2),1],values,values):case(lambda:src.larger_section_shortens_path(d,a,b),'result Value.boolean (largerSectionShortensPath ('+fraction(d)+') ('+ordered(a)+') ('+ordered(b)+'))')
s='''import SFT.Physics.ScatteringPartitionPath
import SFT.Host.Canonical
open SFT.Physics.ScatteringPartitionPath SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def rational (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def pair (p : Rat × Rat) : Value := .array [rational p.1,rational p.2]
def result (f : α → Value) : Except String α → Value | .ok x => f x | .error e => .object [("error",.text e)]
#eval IO.println (render (.array [
'''+',\n'.join(expressions)+']))\n';p=w/'constants-recovery/ScatteringPartition992.lean';p.write_text(s)
env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};lean='/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean';x=subprocess.run([lean,'-j1',str(p)],env=env,capture_output=True,text=True);(w/'scatteringpartition992_core_lean.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:3]
code=(r/'SFT/Physics/ScatteringPartitionPath.lean').read_text();names=['SFT.Physics.ScatteringPartitionPath.'+n for n in re.findall(r'^def (\w+)',code,re.M)];p=w/'scatteringpartition992_core_audit.lean';p.write_text('import SFT.Physics.ScatteringPartitionPath\n'+''.join('#print axioms '+n+'\n' for n in names));out=subprocess.check_output([lean,str(p)],env=env,text=True);(w/'scatteringpartition992_core_audit.log').write_text(out);assert out.count('does not depend on any axioms')==len(names),out
(w/'scatteringpartition992_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(expected),axioms=[],declarations=names,sha256=hashlib.sha256(code.encode()).hexdigest()),indent=2));print('PASS',len(expected),'originalcases;',len(names),'emptydeclarations')
