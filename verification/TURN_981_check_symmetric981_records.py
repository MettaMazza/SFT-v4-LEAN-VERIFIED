from pathlib import Path
import sys,json,subprocess,os,copy,hashlib
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.physics import symmetric_source_conservation_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
record=src.authoritative_record(root);v1=json.load(open(root/src.V1_PATH));prereq=json.load(open(root/src.PREREQ_PATH));expected=[];expr=[]
class FakePath:
 def __init__(self,rel=''):self.rel=rel
 def __truediv__(self,rel):return FakePath(rel)
 def read_text(self,**kw):return current[self.rel]
originalhash=src.hash_file
try:
 src.hash_file=lambda p:src.source_hashes()[p.rel]
 tests=[('original',record,v1,prereq)]
 reordered=copy.deepcopy(record);reordered['registered_target']=dict(reversed(list(reordered['registered_target'].items())));tests.append(('reordered_target',reordered,v1,prereq))
 for field in ['source_id','snapshots','registered_target','custody']:
  p=copy.deepcopy(record);p.pop(field);tests.append(('missing_'+field,p,v1,prereq))
 for field,value in record['registered_target'].items():
  p=copy.deepcopy(record);p['registered_target'][field]=not value if isinstance(value,bool) else 'changed';tests.append(('target_'+field,p,v1,prereq))
 for field,value in record['custody'].items():
  p=copy.deepcopy(record);p['custody'][field]=(not value) if isinstance(value,bool) else 'changed';tests.append(('custody_'+field,p,v1,prereq))
 for field in ['v1_balanced_source_conserved','v1_leaking_source_rejected']:
  for value in ['yes',[],{},0,1,None]:
   p=copy.deepcopy(record);p['registered_target'][field]=value;tests.append(('truth_'+field,p,v1,prereq))
 selected=next(row for row in v1['rows'] if row['v1_claim_id']=='D9n')
 for name,first,second in [('minimal',{'rows':[selected]},prereq),('empty_v1',{'rows':[]},prereq),('wrong_v1',{'rows':[dict(selected,prior_result_observation='changed')]},prereq),('first_wins',{'rows':[dict(selected,prior_result_observation='changed'),selected]},prereq),('empty_prereq',v1,{}),('wrong_claim',v1,dict(prereq,claim_id='changed')),('wrong_exact',v1,dict(prereq,exact_result='changed'))]:tests.append((name,record,first,second))
 for name,payload,first,second in tests:
  current={src.SOURCE_RECORD_PATH:json.dumps(payload),src.V1_PATH:json.dumps(first),src.PREREQ_PATH:json.dumps(second)}
  try:e=src.authoritative_record(FakePath())
  except (ValueError,StopIteration) as ex:e={'error':str(ex) if isinstance(ex,ValueError) else 'StopIteration'}
  expected.append(e);firstCode='v1' if first is v1 else '('+val(first)+')';secondCode='prereq' if second is prereq else '('+val(second)+')';expr.append('result (do let record ← SymmetricRecords.payloadBoundary ('+val(payload)+'); let _ ← SymmetricRecords.historicalBoundary '+firstCode+' '+secondCode+'; SymmetricRecords.custodyBoundary record)')
finally:src.hash_file=originalhash
s='''import SFT.Physics.SymmetricExperiment
import Lean
open SFT.Host.Canonical SFT.Physics
def result : Except String Value → Value | .ok x => x | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
 let v1text ← IO.FS.readFile '''+q(str(root/src.V1_PATH))+'''
 let v1 ← IO.ofExcept (do convert (v1text.utf8ByteSize+1) (← Lean.Json.parse v1text))
 let prereq : Value := '''+val(prereq)+'''
 IO.println (render (.array [
'''+',\n'.join(expr+['result SymmetricExperiment.registrationRecord'])+']))\n'
expected += [src.experiment_registration_record()];driver=(w/'constants-recovery/SymmetricEmpirical981.lean').read_text();convert=driver[driver.index('def convert'):driver.index('def main')];s=s.replace('def result',convert+'\ndef result',1)
p=w/'constants-recovery/SymmetricRecordsCompare981.lean';p.write_text(s);proc=subprocess.run(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True,capture_output=True);(w/'symmetric981_records_lean.log').write_text(proc.stdout+proc.stderr);assert proc.returncode==0,proc.stdout[:3000];actual=json.loads(proc.stdout);expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:2];(w/'symmetric981_records_report.json').write_text(json.dumps({'status':'PASS','cases':len(expected),'full_file_identities':src.source_hashes(),'full_metadata':True,'original_guard_source':'authoritative_record; mockhash only reaches internal record/historical mutations. Fresh full original and native empirical validator separately check all actual source bytes.'},indent=2));print('PASS',len(expected),'record/historical/prerequisite/custody cases andmetadata')
