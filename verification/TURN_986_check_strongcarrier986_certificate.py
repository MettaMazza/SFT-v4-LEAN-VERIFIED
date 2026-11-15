from pathlib import Path
import sys,json,subprocess,os,re,hashlib
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()));from sft.physics import strong_carrier_massless_confined_terminal_law_v1 as src
from sft.engine.canonical import canonical_value
inputs=[False,True,-2,0,1,2,3,5,12,16,32];expected=[]
for n in inputs:
 try:expected.append(canonical_value(src.simultaneous_carrier_certificate(n)))
 except ValueError as e:expected.append({'error':str(e)})
cv='''def certificateValue (c : Certificate) : Value := .object [("structure",sectorValue c.sector),("causal",causalValue c.causal),("tube",tubeValue c.tube),("bound_witnesses",.array (c.boundWitnesses.map boundValue)),("all_registered_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("simultaneously_massless_and_One_speed",.boolean c.simultaneouslyMasslessAndOneSpeed),("simultaneously_confined",.boolean c.simultaneouslyConfined),("masslessness_is_local_propagation_record",.boolean c.masslessnessIsLocalPropagationRecord),("confinement_is_asymptotic_observation_record",.boolean c.confinementIsAsymptoticObservationRecord),("confinement_does_not_create_mass_label",.boolean c.confinementDoesNotCreateMassLabel),("general_bound_identity",.text c.generalBoundIdentity),("general_successor_identity",.text c.generalSuccessorIdentity),("negative_zero_irrational_imaginary_or_completed_infinity_used",.boolean c.forbiddenProofScalarUsed)]
'''
(w/'strongcarrier986_certificate_serializer.txt').write_text(cv)
s='''import SFT.Physics.StrongCarrierMasslessConfinedCertificate
import SFT.Host.Canonical
open SFT.Physics.StrongCarrierMasslessConfined SFT.Physics.StrongCarrierMasslessConfinedCertificate SFT.Physics.LeptonIntervals SFT.Host.Canonical
'''+(w/'strongcarrier986_serializers.txt').read_text()+cv+'''def result : Except String Certificate → Value | .error e => .object [("error",.text e)] | .ok c => certificateValue c
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
#eval IO.println (render (.array [
'''+',\n'.join('result (simultaneousCarrierCertificate ('+('.boolean '+str(n).lower() if isinstance(n,bool) else '.integer ('+str(n)+')')+'))' for n in inputs)+']))\n';p=w/'constants-recovery/StrongCarrierCertificate986.lean';p.write_text(s);env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')};proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env=env,text=True,capture_output=True);(w/'strongcarrier986_certificate_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:2000];actual=json.loads(proc.stdout);assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:1]
mods=['StrongCarrierMasslessConfined','StrongCarrierMasslessConfinedCertificate'];decl=[]
for m in mods:decl += ['SFT.Physics.'+m+'.'+n for n in re.findall(r'^(?:def|theorem) (\w+)',(r/f'SFT/Physics/{m}.lean').read_text(),re.M)]
p=w/'strongcarrier986_certificate_audit.lean';p.write_text('import SFT.Physics.StrongCarrierMasslessConfinedCertificate\n'+''.join('#print axioms '+n+'\n' for n in decl));out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean',str(p)],env=env,text=True);(w/'strongcarrier986_certificate_audit.log').write_text(out);assert all("'"+n+"' does not depend on any axioms" in out for n in decl);(w/'strongcarrier986_certificate_report.json').write_text(json.dumps(dict(status='PASS',cases=len(inputs),all13fields=True,declarations=decl,axioms=[],source_sha256={m:hashlib.sha256((r/f'SFT/Physics/{m}.lean').read_bytes()).hexdigest() for m in mods}),indent=2));print('PASS',len(inputs),'complete13fieldcertificates/domaincases;',len(decl),'empty declarations')
