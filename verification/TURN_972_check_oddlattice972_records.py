from pathlib import Path
import sys,json,subprocess,os,copy
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');root=(w/'v3-runtime500').resolve();sys.path.insert(0,str(root));from sft.physics import odd_lattice_all_region_terminal_validation_v1 as src
q=json.dumps
def val(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,(list,tuple)):return '.array ['+','.join(map(val,x))+']'
 return '.object ['+','.join('('+q(k)+','+val(v)+')' for k,v in x.items())+']'
record=src.authoritative_record(root);claims=(root/src.CLAIMS_SNAPSHOT_PATH).read_text();density=(root/src.DENSITY_SNAPSHOT_PATH).read_text();expected=[];expr=[]
class FakePath:
 def __init__(self,rel=''):self.rel=rel
 def __truediv__(self,rel):return FakePath(rel)
 def read_text(self,**kw):return current[self.rel]
originalhash=src.hash_file
try:
 src.hash_file=lambda p:src.source_hashes()[p.rel]
 tests=[('original',record)]
 for field in ['source_id','snapshots','registered_target','custody']:
  p=copy.deepcopy(record);p.pop(field);tests.append(('missing_'+field,p))
 for field in record['registered_target']:
  p=copy.deepcopy(record);p['registered_target'][field]='changed';tests.append(('target_'+field,p))
 for field,value in record['custody'].items():
  p=copy.deepcopy(record);p['custody'][field]=(not value) if isinstance(value,bool) else 'changed';tests.append(('custody_'+field,p))
 for name,payload in tests:
  current={src.SOURCE_RECORD_PATH:json.dumps(payload),src.CLAIMS_SNAPSHOT_PATH:claims,src.DENSITY_SNAPSHOT_PATH:density}
  try:e=src.authoritative_record(FakePath())
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);expr.append('result (OddLatticeRecords.payloadBoundary ('+val(payload)+'))')
 for old in ['occ=D.occupancy(D.even_lattice(255),12,8)','return all(occ)','def occupancy(starts, folds, regions):','def even_lattice(N):  return [Fraction(i,N) for i in range(1,N+1)]']:
  a=claims.replace(old,'changed');b=density.replace(old,'changed');current={src.SOURCE_RECORD_PATH:json.dumps(record),src.CLAIMS_SNAPSHOT_PATH:a,src.DENSITY_SNAPSHOT_PATH:b}
  try:src.authoritative_record(FakePath());e=True
  except ValueError as ex:e={'error':str(ex)}
  expected.append(e);expr.append('unitResult (OddLatticeRecords.sourceLines '+q(a)+' '+q(b)+')')
finally:src.hash_file=originalhash
for rel in src.source_hashes():
 expected.append({'error':'odd-lattice observation source identity changed: '+rel})
 expr.append('result (OddLatticeRecords.authoritativeRecord (files.map (fun (pair : String × ByteArray) => if SFT.Host.Text.equal pair.1 '+q(rel)+' then (pair.1,pair.2.push 0) else pair)) payload)')
s='''import SFT.Physics.OddLatticeExperiment
open SFT.Host.Canonical SFT.Physics
def result : Except String Value → Value | .ok x => x | .error e => .object [("error",.text e)]
def unitResult : Except String Unit → Value | .ok _ => .boolean true | .error e => .object [("error",.text e)]
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
#eval do
 let files ← OddLatticeRecords.sourceHashes.mapM (fun (pair : String × String) => do pure (pair.1,← IO.FS.readBinFile (System.FilePath.mk ('''+q(str(root))+''' ++ "/" ++ pair.1))))
 let payload : Value := '''+val(record)+'''
 IO.println (render (.array [
'''+',\n'.join(expr+['result (OddLatticeRecords.authoritativeRecord files payload)','result OddLatticeExperiment.registrationRecord','result (do pure (.object (← OddLatticeExperiment.releasedTargets files payload)))'])+']))\n'
expected += [record,src.experiment_registration_record(),src.released_targets(root)]
p=w/'constants-recovery/OddLatticeRecordsCompare972.lean';p.write_text(s);out=subprocess.check_output(['/Users/dolltrading/.elan/toolchains/leanprover--lean4---v4.35.0/bin/lean','-j1',str(p)],env={**os.environ,'LEAN_PATH':str(c/'.lake/build/lib/lean')},text=True);actual=json.loads(out);expected=json.loads(json.dumps(expected));assert actual==expected,[(i,a,e) for i,(a,e) in enumerate(zip(actual,expected)) if a!=e][:2];(w/'oddlattice972_records_report.json').write_text(json.dumps({'status':'PASS','cases':len(expected),'full_file_identities':src.source_hashes(),'full_metadata_and_released_target':True,'original_guard_source':'authoritative_record; file hash mocked only for payload/line mutation comparisons; unmodified full original and native records separately check actual bytes'},indent=2));print('PASS',len(expected),'record/line guard cases, actual file identities and full metadata/target')
