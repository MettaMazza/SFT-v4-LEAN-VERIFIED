from pathlib import Path
from fractions import Fraction
from functools import lru_cache
from itertools import product,combinations
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'quantumsupport1051_law.py').read_text();ns=dict(Fraction=Fraction,lru_cache=lru_cache,product=product,combinations=combinations,HELD='held',RETURNED='returned',EMPTY_ONE=());exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'original-quantum-support','exec'),ns)
header='''import SFT.Physics.QuantumSupportBell
import SFT.Host.Canonical
open SFT.Physics QuantumSupportPreparation QuantumSupportBell LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nn(n:Nat):Value := .integer (.ofNat n)
def rr(q:Rat):Value := .text (toString q.num ++ "/" ++ toString q.den)
def ns(xs:List Nat):Value := .array (xs.map nn)
def word(xs:List String):Value := .array (xs.map Value.text)
def result {α : Type} (convert : α→Value) : Except String α → Value
 | .ok a => .object [("ok",convert a)]
 | .error e => .object [("error",.text e)]
def prepValue(a:Preparation):Value := .object [("branch_count",nn a.branchCount),("depth",nn a.depth),("trace",ns a.trace),("branch_unit",rr a.branchUnit)]
def partitionValue(a:Partition):Value := .object [("depth",nn a.depth),("branch_count",nn a.branchCount),("branch_unit",rr a.branchUnit),("class_sizes",ns a.classSizes),("class_weights",.array (a.classWeights.map rr)),("weights_sum_to_one",.boolean a.weightsSumToOne),("maximal_resolution",.boolean a.maximalResolution)]
def bellValue(a:LocalCensus):Value := .object [("strategy_count",nn a.strategyCount),("maximum_wins",nn a.maximumWins),("setting_count",nn a.settingCount),("local_bound",rr a.localBound),("all_local_records_bounded",.boolean a.allBounded),("rows",.array (a.rows.map (fun (l,r,n) => .array [word l,word r,nn n])))]
def inclusiveValue(a:Inclusive):Value := .object [("setting_rows",.array (a.settingRows.map (fun (l,r,os) => .array [.text l,.text r,.array (os.map (fun (a,b) => .array [.text a,.text b]))]))),("setting_count",nn a.settingCount),("outcomes_per_setting",ns a.outcomesPerSetting),("all_setting_relations_satisfied",.boolean a.allRelations),("local_counts_invariant",.boolean a.localCountsInvariant),("remote_counts_invariant",.boolean a.remoteCountsInvariant),("no_signalling",.boolean a.noSignalling)]
'''
ci=lambda n:'.boolean '+str(n).lower()if type(n)==bool else '.integer ('+str(n)+')';tests=[]
for d in [False,0,-1,1,2,3,4,5]:tests.append(('binary_words',(d,),'result (fun ws => Value.array (ws.map word)) (binaryWords ('+ci(d)+'))'))
for n in [False,-1,0,1,*range(2,18),32,64,128,256]:tests.append(('preparation_depth',(n,),'result prepValue (preparationDepth ('+ci(n)+'))'))
for d in [1,2,3,4]:
 n=2**d
 for sizes in [[n],[1]*n,[n//2,n//2],[],[n-1],[0,n],[False,n],[-1,n+1]]:tests.append(('measurement_partition',(d,sizes),'result partitionValue (measurementPartition ('+ci(d)+') ['+','.join(ci(n)for n in sizes)+'])'))
for d in [1,2,3]:
 ws=ns['binary_words'](d)
 for a in ws:
  for b in ws:tests.append(('walsh_phase',(a,b),'result Value.text (walshPhase '+json.dumps(a)+' '+json.dumps(b)+')'))
for a,b in [([],[]),(['held'],[]),(['other'],['returned']),(['returned'],['other']),(['held'],['held','returned'])]:tests.append(('walsh_phase',(a,b),'result Value.text (walshPhase '+json.dumps(a)+' '+json.dumps(b)+')'))
for a in range(6):
 for b in range(6):tests.append(('_imbalance',(a,b),'result (fun v => match v with | none => Value.array [] | some n => nn n) (.ok (imbalance '+str(a)+' '+str(b)+'))'))
tests.extend([('bell_local_record_census',(),'result bellValue (.ok bellLocalRecordCensus)'),('setting_inclusive_no_signal_support',(),'result inclusiveValue (.ok settingInclusiveNoSignalSupport)')])
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(list,tuple)):return [cv(x)for x in v]
 if isinstance(v,dict):return {k:cv(x)for k,x in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(ns[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
p=w/'quantumsupport1051_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(x for _,_,x in tests)+']))\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,text=True,capture_output=True);(w/'quantumsupport1051_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2200:];actual=json.loads(x.stdout);assert actual==expected,[(i,tests[i][:2],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
mods=['QuantumSupportPreparation','QuantumSupportBell'];names=[];hashes={}
for m in mods:
 body=(r/f'SFT/Physics/{m}.lean').read_text();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|abbrev) (\w+)',body,re.M)];hashes[m]=hashlib.sha256(body.encode()).hexdigest()
p=w/'quantumsupport1051_audit.lean';p.write_text('import SFT.Physics.QuantumSupportBell\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,text=True,capture_output=True);(w/'quantumsupport1051_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout[-2000:]
(w/'quantumsupport1051_preparation_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),modules=mods,declarations=names,source_sha256=hashes,axioms=[],scope='Original complete binary words, depth/trace/unit, partition, phase, imbalance, all16Bellrecords and all4setting-inclusive outcome records; 049 remains unregistered pending original Walsh and joint operations/proofs/censuses'),indent=2));print('PASS',len(tests),'whole source outputs;',len(names),'zeroaxiom declarations')
