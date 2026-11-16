from pathlib import Path
import sys,os,json,subprocess,hashlib,copy,re
from fractions import Fraction
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');runtime=w/'v3-runtime500';sys.path.insert(0,str(runtime.resolve()));pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
from sft.physics.grand_lock_empirical_v1 import source_record,record_certificate
from sft.engine.canonical import canonical_value
original=source_record();cases=[('original',original)]
def mutate(name,path,value):
 row=copy.deepcopy(original);a=row
 for k in path[:-1]:a=a[k]
 a[path[-1]]=value;cases.append((name,row))
mutate('missingRow',['empirical_claims'],original['empirical_claims'][1:])
mutate('missingAdverse',['unfavorable_or_scope_boundary_ids'],original['unfavorable_or_scope_boundary_ids'][1:])
mutate('falseLegacy',['legacy_empirical_materialization_without_separate_measurement_receipt'],[])
mutate('selector',['methodological_boundary','measurements_select_formal_survivor'],True)
mutate('duplicateClaim',['empirical_claims'],original['empirical_claims']+[original['empirical_claims'][0]])
mutate('missingEmpiricalHash',['empirical_claims',0,'empirical_validation_hash'],'')
mutate('missingExternalHash',['empirical_claims',0,'external_validation_hash'],'')
mutate('wrongFormalReceipt',['formal_grand_lock','receipt_hash'],'changed')
mutate('sourceCount',['unique_external_source_id_count'],146)
mutate('extraBoundary',['methodological_boundary','new-retained-boundary'],False)
exact_analysis=record_certificate
def val(x):
 if isinstance(x,Fraction):return '.object [("numerator",.integer ('+str(x.numerator)+')),("denominator",.integer ('+str(x.denominator)+'))]'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+json.dumps(x)
 if isinstance(x,(tuple,list)):return '.array ['+','.join(map(val,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+json.dumps(k)+','+val(v)+')'for k,v in x.items())+']'
 if x is None:return '.null'
 raise TypeError(x)
s='import SFT.Physics.GrandLockObservationAnalysis\nopen SFT.Physics.GrandLockObservationAnalysis SFT.Host.Canonical\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n';expected=[]
proof='import SFT.Physics.GrandLockObservationAnalysis\nnamespace SFT.Physics.GrandLockObservationAnalysisProofs\nopen SFT.Host.Canonical\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n'
for i,(name,record)in enumerate(cases):
 out=exact_analysis(record);expected.append(canonical_value(out));s+='#eval IO.println (render (match recordCertificate ('+val(record)+') with | .error e=>.text e | .ok v=>v))\n'
 if i<5:proof+='def '+name+'Target : Value := '+val(record)+'\ntheorem '+name+'Complete : GrandLockObservationAnalysis.recordCertificate '+name+'Target=.ok ('+val(out)+') := rfl\n#print axioms '+name+'Complete\n'
p=w/'grandlockobservation1064_analysis_cases.lean';p.write_text(s);x=subprocess.run(['/Users/dolltrading/.elan/bin/lean',str(p)],env={**os.environ,'LEAN_PATH':str(r/'.lake/build/lib/lean')},capture_output=True,text=True);(w/'grandlockobservation1064_analysis_check.log').write_text(x.stdout+x.stderr);assert x.returncode==0,x.stdout[-2000:];actual=[json.loads(l)for l in x.stdout.splitlines()if l.startswith('{')];assert actual==expected,[(cases[i][0],a,b)for i,(a,b)in enumerate(zip(actual,expected))if a!=b];proof+='end SFT.Physics.GrandLockObservationAnalysisProofs\n';None if os.environ.get('SFT_PRESERVE_PROOFS') else (r/'SFT/Physics/GrandLockObservationAnalysisProofs.lean').write_text(proof);report=dict(status='PASS',complete_outputs=len(cases),fields=len(expected[0]),source_sha256=hashlib.sha256((runtime/'sft/physics/grand_lock_empirical_v1.py').read_bytes()).hexdigest(),lean_sha256=hashlib.sha256((r/'SFT/Physics/GrandLockObservationAnalysis.lean').read_bytes()).hexdigest());(w/'grandlockobservation1064_analysis_report.json').write_text(json.dumps(report,indent=2));print(report)
