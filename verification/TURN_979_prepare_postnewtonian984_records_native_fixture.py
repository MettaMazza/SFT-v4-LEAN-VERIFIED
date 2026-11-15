from pathlib import Path
import sys,json,subprocess,os,copy
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.physics import post_newtonian_fixed_point_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
record=src.authoritative_record(root);v1=json.load(open(root/src.V1_PATH));v2=json.load(open(root/src.V2_PATH));expected=[];expr=[]
class FakePath:
 def __init__(self,rel=''):self.rel=rel
 def __truediv__(self,rel):return FakePath(rel)
 def read_text(self,**kw):return current[self.rel]
originalhash=src.hash_file
try:
 src.hash_file=lambda p:src.source_hashes()[p.rel]
 tests=[('original',record,v1,v2)]
 reordered=copy.deepcopy(record);reordered['registered_target']=dict(reversed(list(reordered['registered_target'].items())));tests.append(('reordered_target',reordered,v1,v2))
 for field in ['source_id','snapshots','registered_target','custody']:
  p=copy.deepcopy(record);p.pop(field);tests.append(('missing_'+field,p,v1,v2))
 for field in record['registered_target']:
  p=copy.deepcopy(record);p['registered_target'][field]='changed';tests.append(('target_'+field,p,v1,v2))
 for field,value in record['custody'].items():
  p=copy.deepcopy(record);p['custody'][field]=(not value) if isinstance(value,bool) else 'changed';tests.append(('custody_'+field,p,v1,v2))
 selected1=next(row for row in v1['rows'] if row['v1_claim_id']=='D9m');selected2=next(row for row in v2['steps'] if row['step']==179)
 for name,first,second in [('minimal',{'rows':[selected1]},{'steps':[selected2]}),('empty_v1',{'rows':[]},v2),('empty_v2',v1,{'steps':[]}),('wrong_v1',{'rows':[dict(selected1,prior_result_observation='changed')]},v2),('wrong_v2',v1,{'steps':[dict(selected2,prior_result_observation='changed')]}),('v1_first_wins',{'rows':[dict(selected1,prior_result_observation='changed'),selected1]},v2),('v2_first_wins',v1,{'steps':[dict(selected2,prior_result_observation='changed'),selected2]})]:tests.append((name,record,first,second))
 for name,payload,first,second in tests:
  current={src.SOURCE_RECORD_PATH:json.dumps(payload),src.V1_PATH:json.dumps(first),src.V2_PATH:json.dumps(second)}
  try:e=src.authoritative_record(FakePath())
  except (ValueError,StopIteration) as ex:e={'error':str(ex) if isinstance(ex,ValueError) else 'StopIteration'}
  expected.append(e)
  # Same parsed documents as the original; use shared constants for the unmodified full censuses.
  firstCode='v1' if first is v1 else '('+val(first)+')';secondCode='v2' if second is v2 else '('+val(second)+')'
  expr.append('result (do let record ← PostNewtonianRecords.payloadBoundary ('+val(payload)+'); let _ ← PostNewtonianRecords.historicalBoundary '+firstCode+' '+secondCode+'; PostNewtonianRecords.custodyBoundary record)')
finally:src.hash_file=originalhash
for rel in src.source_hashes():
 expected.append({'error':'D9m source changed: '+rel})
 expr.append('result (PostNewtonianRecords.authoritativeRecord (files.map (fun (pair : String × ByteArray) => if SFT.Host.Text.equal pair.1 '+q(rel)+' then (pair.1,pair.2.push 0) else pair)) payload v1 v2)')
s='''import SFT.Physics.PostNewtonianExperiment
import Lean
open SFT.Host.Canonical SFT.Physics
def result : Except String Value → Value | .ok x => x | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
 let files ← PostNewtonianRecords.sourceHashes.mapM (fun (pair : String × String) => do pure (pair.1,← IO.FS.readBinFile (System.FilePath.mk ('''+q(str(root))+''' ++ "/" ++ pair.1))))
 let payload : Value := '''+val(record)+'\n let v1text ← IO.FS.readFile '+q(str(root/src.V1_PATH))+'\n let v2text ← IO.FS.readFile '+q(str(root/src.V2_PATH))+'\n let v1 ← IO.ofExcept (do convert (v1text.utf8ByteSize+1) (← Lean.Json.parse v1text))\n let v2 ← IO.ofExcept (do convert (v2text.utf8ByteSize+1) (← Lean.Json.parse v2text))'+'''
 IO.println (render (.array [
'''+',\n'.join(expr+['result (PostNewtonianRecords.authoritativeRecord files payload v1 v2)','result PostNewtonianExperiment.registrationRecord','result (do pure (.object (← PostNewtonianExperiment.releasedTargets files payload v1 v2)))'])+']))\n'
expected += [record,src.experiment_registration_record(),{src.TARGET_IDS[0]:record['registered_target']}]
driver=(w/'constants-recovery/PostNewtonianEmpirical979.lean').read_text();convert=driver[driver.index('def convert'):driver.index('def main')];s=s.replace('def result',convert+'\ndef result',1)
p=w/'constants-recovery/PostNewtonianRecordsNative984.lean';p.write_text(s.replace('#eval do','def main : IO Unit := do'));(w/'postnewtonian984_records_expected.json').write_text(json.dumps(json.loads(json.dumps(expected)),indent=2));print('Prepared unchanged',len(expected),'cases for existing compiled Lean execution')
