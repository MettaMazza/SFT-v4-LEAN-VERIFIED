from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import strong_field_nonlinear_fixed_point_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
inputs=[False,True,-2,0,1,2,3,4,6,8];expected=[]
for n in inputs:
 try:expected.append(canonical_value(src.field_iteration_certificate(n)))
 except ValueError as e:expected.append({'error':str(e)})
cv='''def certificateValue (c : Certificate) : Value := .object [("neutral",neutralValue c.neutral),("gravity",SFT.Physics.PostNewtonianFixedPointEvidence.certificateValue c.gravity),("strong",strongValue c.strong),("fixed_point_candidates",.array (c.fixedPointCandidates.map fixedValue)),("bound_witnesses",.array (c.boundWitnesses.map boundValue)),("neutral_linear_hold",.boolean c.neutralLinearHold),("gravity_self_source_contracts",.boolean c.gravitySelfSourceContracts),("strong_self_source_persists",.boolean c.strongSelfSourcePersists),("strong_has_no_positive_finite_fixed_point",.boolean c.strongHasNoPositiveFiniteFixedPoint),("all_registered_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("general_fixed_point_identity",.text c.generalFixedPointIdentity),("general_bound_identity",.text c.generalBoundIdentity),("structural_nonlinearity",.text c.structuralNonlinearity),("strong_finite_fixed_point_record",rs c.strongFiniteFixedPointRecord),("completed_infinity_used",.boolean c.completedInfinityUsed),("negative_zero_irrational_or_imaginary_proof_value_used",.boolean c.forbiddenProofScalarUsed)]
''' 
(w/'strongfield987_certificate_serializer.txt').write_text(cv)
s='''import SFT.Physics.StrongFieldNonlinearFixedPointCertificate
import SFT.Host.Canonical
import SFT.Physics.PostNewtonianFixedPointEvidence
open SFT.Physics.StrongFieldNonlinearFixedPoint SFT.Physics.StrongFieldNonlinearFixedPointCertificate SFT.Physics.LeptonIntervals SFT.Host.Canonical
'''+(w/'strongfield987_serializers.txt').read_text()+cv+'''def result : Except String Certificate → Value | .error e => .object [("error",.text e)] | .ok c => certificateValue c
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (fieldIterationCertificate ('+('.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')')+'))' for n in inputs)+']))\n';p=w/'constants-recovery/StrongFieldCertificate987.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'strongfield987_certificate_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
mods=['StrongFieldNonlinearFixedPoint','StrongFieldNonlinearFixedPointCertificate'];decl=[]
for m in mods:decl += ['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/f'SFT/Physics/{m}.lean').read_text(),re.M)]
p=w/'strongfield987_certificate_audit.lean';p.write_text('import SFT.Physics.StrongFieldNonlinearFixedPointCertificate\n'+''.join('#print axioms '+n+'\n' for n in decl));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env=env,text=True);(w/'strongfield987_certificate_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in decl);(w/'strongfield987_certificate_report.json').write_text(json.dumps(dict(status='PASS',cases=len(inputs),all16fields=True,declarations=decl,axioms=[],source_sha256={m:hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest() for m in mods}),indent=2));print('PASS',len(inputs),'complete16fieldcertificates/domaincases;',len(decl),'empty declarations')
