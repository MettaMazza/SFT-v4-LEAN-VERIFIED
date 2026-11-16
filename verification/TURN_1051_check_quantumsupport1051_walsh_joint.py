from pathlib import Path
from fractions import Fraction
from functools import lru_cache
from itertools import product,combinations
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'quantumsupport1051_law.py').read_text();ns=dict(Fraction=Fraction,lru_cache=lru_cache,product=product,combinations=combinations,HELD='held',RETURNED='returned',EMPTY_ONE=());exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'original-quantum-support','exec'),ns)
tree=ast.parse((w/'check_quantumsupport1051_preparation.py').read_text());header=ast.literal_eval(next(n.value for n in tree.body if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='header'for t in n.targets))).replace('import SFT.Physics.QuantumSupportBell','import SFT.Physics.QuantumSupportCertificate').replace('open SFT.Physics QuantumSupportPreparation','open SFT.Physics QuantumSupportWalsh QuantumSupportJoint QuantumSupportCertificate QuantumSupportPreparation')
header+='''
def imbalanceValue : Option Nat → Value | none => .array [] | some n => nn n
def supportValue(a:SupportCertificate):Value := .object [("depth",nn a.depth),("branch_count",nn a.branchCount),("position_support",nn a.positionSupport),("frequency_support",nn a.frequencySupport),("mode_rows",.array (a.modeRows.map (fun (w,h,r,i) => .array [word w,nn h,nn r,imbalanceValue i]))),("parseval_sum",nn a.parsevalSum),("parseval_identity",.boolean a.parsevalIdentity),("support_product",nn a.supportProduct),("support_bound",.boolean a.supportBound),("normalized_support_spread_product",rr a.normalizedProduct),("unit_free_bound",.boolean a.unitFreeBound),("squared_grid_spread_product",rr a.squaredProduct),("squared_grid_floor",rr a.squaredFloor),("squared_grid_bound",.boolean a.squaredBound)]
def orthogonalValue(a:Orthogonality):Value := .object [("depth",nn a.depth),("branch_count",nn a.branchCount),("diagonal_complete",.boolean a.diagonalComplete),("off_diagonal_cancels",.boolean a.offDiagonalCancels),("rows",.array (a.rows.map (fun (l,r,h,t) => .array [word l,word r,nn h,nn t])))]
def censusValue(a:WalshCensus):Value := .object [("max_depth",nn a.maxDepth),("candidate_supports",nn a.candidateSupports),("saturated_supports",nn a.saturatedSupports),("all_pass",.boolean a.allPass)]
def spacingValue(a:SpacingCertificate):Value := .object [("position_spread",rr a.positionSpread),("frequency_spread",rr a.frequencySpread),("product",rr a.product),("spacing_cancelled",.boolean a.spacingCancelled)]
def jointValue(a:JointCensus):Value := .object [("left_size",nn a.leftSize),("right_size",nn a.rightSize),("joint_cells",nn a.jointCells),("nonempty_supports",nn a.nonemptySupports),("factorable_supports",nn a.factorableSupports),("nonfactorable_supports",nn a.nonfactorableSupports),("expected_factorable_supports",nn a.expectedFactorable),("factorability_census_complete",.boolean a.censusComplete),("full_product_factorable",.boolean a.fullProductFactorable),("projections_complete",.boolean a.projectionsComplete),("remote_relabel_invariant",.boolean a.remoteRelabelInvariant)]
def coprimeValue(a:CoprimeCensus):Value := .object [("left",nn a.left),("right",nn a.right),("joint",nn a.joint),("rows",.array (a.rows.map (fun (l,r) => .array [nn l,nn r]))),("one_visit_per_cell",.boolean a.oneVisit),("product_exceeds_sum",.boolean a.productExceedsSum),("product_alone_is_entanglement",.boolean a.productAloneIsEntanglement)]
def certValue(a:QuantumSupportCertificate.Certificate):Value := .object [("walsh",.boolean a.walsh),("depth",.boolean a.depth),("spacing",.boolean a.spacing),("depth_two_floor",.boolean a.depthTwoFloor),("joints",.boolean a.joints),("coprime",.boolean a.coprime),("bell",.boolean a.bell)]
'''
ci=lambda n:'.boolean '+str(n).lower()if type(n)==bool else '.integer ('+str(n)+')';tests=[]
for d in range(1,4):
 ws=ns['binary_words'](d)
 for k in range(1,len(ws)+1):
  for selected in combinations(ws,k):tests.append(('walsh_support_certificate',(d,selected),'result supportValue (walshSupportCertificate ('+ci(d)+') '+json.dumps(selected)+')'))
for d in [1,2,3,4]:tests.append(('orthogonality_certificate',(d,),'result orthogonalValue (orthogonalityCertificate ('+ci(d)+'))'))
for d in [False,0,-1,1,2,3,4]:tests.append(('complete_walsh_census',(d,),'result censusValue (completeWalshCensus ('+ci(d)+'))'))
for selected in [[],[('held',),('held',)],[('invalid',)],[('held','returned')]]:tests.append(('walsh_support_certificate',(1,selected),'result supportValue (walshSupportCertificate (.integer 1) '+json.dumps(selected)+')'))
for spacing in [Fraction(1,8),Fraction(2,9),Fraction(3,7),Fraction(5,11),Fraction(0),Fraction(-1,3)]:
 selected=(ns['binary_words'](3)[0],);q=f'normalize ({spacing.numerator}) {spacing.denominator} (by decide)';tests.append(('spacing_cancellation_certificate',(3,selected,spacing),'result spacingValue (spacingCancellationCertificate (.integer 3) '+json.dumps(selected)+' ('+q+'))'))
for a,b in [(1,1),(1,3),(2,2),(2,3),(3,5),(False,2),(0,2),(2,False),(2,0)]:tests.append(('joint_subset_census',(a,b),'result jointValue (jointSubsetCensus ('+ci(a)+') ('+ci(b)+'))'))
for a in range(1,5):
 for b in range(1,6):tests.append(('coprime_trace_census',(a,b),'result coprimeValue (coprimeTraceCensus ('+ci(a)+') ('+ci(b)+'))'))
for rows in [[],[('a','b')],[('a','b'),('a','b')],[('a','x'),('b','y')],[('a','x'),('a','y'),('b','x'),('b','y')]]:
 syntax='['+','.join('('+json.dumps(a)+','+json.dumps(b)+')'for a,b in rows)+']';tests.append(('is_factorable_joint',(rows,),'result Value.boolean (isFactorableJoint '+syntax+')'))
tests.append(('theorem_certificate',(),'result certValue QuantumSupportCertificate.theoremCertificate'))
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(list,tuple)):return [cv(x)for x in v]
 if isinstance(v,dict):return {k:cv(x)for k,x in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(ns[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
(w/'quantumsupport1051_walsh_expected.json').write_text(json.dumps(expected));print('Original full65808Walsh/32767joint source computations retained',flush=True)
p=w/'quantumsupport1051_walsh_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(x for _,_,x in tests)+']))\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1','-M12288',str(p)],env=ev,text=True,capture_output=True);(w/'quantumsupport1051_walsh_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=json.loads(x.stdout);assert actual==expected,[(i,tests[i][:2],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:1]
mods=['QuantumSupportWalsh','QuantumSupportJoint','QuantumSupportCertificate'];names=[];hashes={}
for m in mods:
 body=(r/f'SFT/Physics/{m}.lean').read_text();names+=['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem|structure|abbrev) (\w+)',body,re.M)];hashes[m]=hashlib.sha256(body.encode()).hexdigest()
p=w/'quantumsupport1051_walsh_audit.lean';p.write_text('import SFT.Physics.QuantumSupportCertificate\n'+''.join('#print axioms '+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,text=True,capture_output=True);(w/'quantumsupport1051_walsh_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and all("'"+n+"' does not depend on any axioms"in x.stdout for n in names),x.stdout[-2000:]
(w/'quantumsupport1051_walsh_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),modules=mods,declarations=names,source_sha256=hashes,axioms=[],scope='All fullsource operation fields, complete65808-supportWalshcensus, complete2x3/3x5jointcensuses and original7fieldcertificate. Nativeoperation parity, notyet complete049proofregistration.'),indent=2));print('PASS',len(tests),'whole source outputs;',len(names),'zeroaxiom declarations',flush=True)
