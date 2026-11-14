from pathlib import Path
import sys,json,subprocess,ast
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rt=w/'v3-runtime500';sys.path.insert(0,str(rt.resolve()))
from sft.physics import atomic_field_splitting_successor_validation_v1 as src
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def stage(rel):
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=rt/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 return b
record=json.loads(stage(src.SOURCE_PATH));assert src.authoritative_record(rt)==record
(w/'atomicfieldsplitting958_original_record.json').write_text(json.dumps(record,indent=2))
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,list):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
source=(rt/'sft/physics/atomic_field_splitting_successor_validation_v1.py').read_text();fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name=='authoritative_record');required=next(ast.literal_eval(n.value) for n in fn.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='required')
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicFieldSplittingRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
'''+f'def sourceHash : String := {q(src.SOURCE_HASH)}\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
'''+''.join(' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "atomic field-splitting custody disclosure changed"\n' for k,v in required.items())+''' let sources := (field payload "sources").toOption.getD (.object [])
 let pairs ← match sources with
  | .object xs => .ok xs
  | .text _ => .error "atomic field-splitting source set changed"
  | .boolean _ => .error "atomic field-splitting source set changed"
  | .integer _ => .error "atomic field-splitting source set changed"
  | .null => .error "atomic field-splitting source set changed"
  | .array _ => .error "atomic field-splitting source set changed"
 let required := ["nist_zeeman","nbs_hydrogen_linear_stark","nist_cesium_quadratic_stark"]
 if !(pairs.all (fun p => required.any (fun s => Text.equal s p.1))) || !(required.all (fun s => pairs.any (fun p => Text.equal s p.1))) then
  throw "atomic field-splitting source set changed"
 pure payload
'''
s+='''def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic field-splitting source record identity changed"
 let record ← payloadBoundary payload
 pure record
'''
s+='def componentFiles : List (String × String) := []\n'
s+='def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.AtomicFieldSplittingRecords\n'
for root in [r,c]:(root/'SFT/Physics/AtomicFieldSplittingRecords.lean').write_text(s)
