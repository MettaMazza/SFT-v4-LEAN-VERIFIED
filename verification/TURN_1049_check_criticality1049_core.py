from pathlib import Path
from fractions import Fraction
import ast,json,subprocess,os,hashlib,re
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=(w/'criticality1049_law.py').read_text();env={'Fraction':Fraction};exec(compile(ast.Module(body=[n for n in ast.parse(src).body if isinstance(n,ast.FunctionDef)],type_ignores=[]),'pinned-criticality','exec'),env)
header='''import SFT.Physics.CriticalityUniversality
import SFT.Host.Canonical
open SFT.Physics SFT.Physics.CriticalityUniversality LeptonIntervals SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def nn(n:Nat):Value := .integer (.ofNat n)
def rr(q:Rat):Value := .text (toString q.num ++ "/" ++ toString q.den)
def ns(xs:List Nat):Value := .array (xs.map nn)
def result {α : Type} (convert : α→Value) : Except String α → Value
 | .ok a => .object [("ok",convert a)]
 | .error e => .object [("error",.text e)]
def meanValue(a:MeanExponents):Value := .object [("beta",rr a.beta),("nu",rr a.nu),("gamma",rr a.gamma),("delta",rr a.delta),("alpha",ns a.alpha),("eta",ns a.eta)]
def cascadeValue(a:CascadeExponents):Value := .object [("spatial_branch_count",nn a.branchCount),("structure_function",rr a.structureFunction),("spectrum_magnitude",rr a.spectrumMagnitude),("spectrum_orientation",.text a.spectrumOrientation)]
def meanScale(a:MeanScale):Value := .object [("excess",nn a.excess),("order",nn a.order),("inverse_correlation",nn a.inverseCorrelation),("inverse_response",nn a.inverseResponse),("critical_field",nn a.criticalField),("order_square_is_excess",.boolean a.orderSquareIsExcess),("correlation_square_is_excess",.boolean a.correlationSquareIsExcess),("response_is_linear_in_excess",.boolean a.responseIsLinearInExcess),("field_is_order_cube",.boolean a.fieldIsOrderCube)]
def cascadeScale(a:CascadeScale):Value := .object [("length_refinement",nn a.lengthRefinement),("second_order_structure_factor",nn a.structureFactor),("wavenumber_refinement",nn a.wavenumberRefinement),("spectral_energy_divisor",nn a.energyDivisor),("structure_cube_equals_length_square",.boolean a.structureCubeEqualsLengthSquare),("spectrum_cube_equals_wavenumber_fifth",.boolean a.spectrumCubeEqualsWavenumberFifth),("falling_orientation_retained",.boolean a.fallingOrientationRetained)]
def classValue(a:GeneratedClass):Value := .object [("class_id",.text a.classId),("generator_key",.array [nn a.generatorKey.1,nn a.generatorKey.2.1,nn a.generatorKey.2.2]),("threshold",rr a.threshold),("carriers",match a.carriers with | .mean m => meanValue m | .cascade c => cascadeValue c)]
def identitiesValue(a:Identities):Value := .object [("widom",.boolean a.widom),("rushbrooke_with_empty_alpha",.boolean a.rushbrooke),("fisher_with_empty_eta",.boolean a.fisher),("values",meanValue a.values)]
def certificateValue(a:Certificate):Value := .object [("mean_field",.boolean a.meanField),("identities",.boolean a.identities),("cascade",.boolean a.cascade),("classes",.boolean a.classes)]
'''
ci=lambda n:'.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')'
tests=[]
for name,lean,cv in [('mean_field_exponents','meanFieldExponents','meanValue'),('cascade_exponents','cascadeExponents','cascadeValue'),('critical_scaling_identities','criticalScalingIdentities','identitiesValue')]:tests.append((name,(),f'result {cv} (.ok {lean})'))
for q,d in [(q,d)for q in range(1,9)for d in range(1,8)]+[(False,1),(0,1),(-1,1),(2,False),(2,0),(2,-1)]:
 for name,lean,cv in [('mean_field_scale_witness','meanFieldScaleWitness','meanScale'),('cascade_scale_witness','cascadeScaleWitness','cascadeScale')]:tests.append((name,(q,d),f'result {cv} ({lean} ({ci(q)}) ({ci(d)}))'))
for a in ['binary-self-antipodal-local-order','generator-three-conserved-cascade','unknown']:
 for b in ['binary-self-antipodal-local-order','generator-three-conserved-cascade','unknown']:tests.append(('universality_equivalence',(a,b),'result Value.boolean (universalityEquivalence '+json.dumps(a)+' '+json.dumps(b)+')'))
tests.extend([('generated_universality_classes',(),'result (fun cs => Value.array (cs.map classValue)) generatedUniversalityClasses'),('theorem_certificate',(),'result certificateValue theoremCertificate')])
def cv(v):
 if isinstance(v,Fraction):return f'{v.numerator}/{v.denominator}'
 if isinstance(v,(tuple,list)):return list(map(cv,v))
 if isinstance(v,dict):return {k:cv(a)for k,a in v.items()}
 return v
expected=[]
for name,args,_ in tests:
 try:expected.append({'ok':cv(env[name](*args))})
 except ValueError as e:expected.append({'error':str(e)})
p=w/'criticality1049_cases.lean';p.write_text(header+'#eval IO.println (render (.array ['+',\n'.join(e for _,_,e in tests)+']))\n');ev={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};x=subprocess.run(['/Users/dolltrading/.elan/bin/lean','-j1',str(p)],env=ev,capture_output=True,text=True);(w/'criticality1049_cases.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2500:];actual=json.loads(x.stdout);assert actual==expected,[(i,a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b][:2]
body=(r/'SFT/Physics/CriticalityUniversality.lean').read_text();names=re.findall(r'^(?:def|theorem|structure|inductive) (\w+)',body,re.M);p=w/'criticality1049_audit.lean';p.write_text('import SFT.Physics.CriticalityUniversality\n'+''.join('#print axioms SFT.Physics.CriticalityUniversality.'+n+'\n'for n in names));x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env=ev,capture_output=True,text=True);(w/'criticality1049_audit.log').write_text(x.stdout+x.stderr);assert x.returncode==0 and x.stdout.count('does not depend on any axioms')==len(names),x.stdout
(w/'criticality1049_core_report.json').write_text(json.dumps(dict(status='PASS',cases=len(tests),all_source_operation_fields=True,declarations=names,axioms=[],source_sha256=hashlib.sha256(body.encode()).hexdigest()),indent=2));print('PASS',len(tests),'whole source outputs;',len(names),'zeroaxiom declarations')
