from pathlib import Path
import sys,json,subprocess,ast
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');rt=w/'v3-runtime500';sys.path.insert(0,str(rt.resolve()))
from sft.physics import atomic_shell_periodicity_successor_validation_v1 as src
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1'
def stage(rel):
 b=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':'+rel]);p=rt/rel;p.parent.mkdir(parents=True,exist_ok=True)
 if p.exists():assert p.read_bytes()==b
 else:p.write_bytes(b)
 return b
record=json.loads(stage(src.SOURCE_PATH));stage(record['sources']['periodic_table']['snapshot_path']);assert src.authoritative_record(rt)==record
(w/'atomicshell956_original_record.json').write_text(json.dumps(record,indent=2))
q=lambda x:json.dumps(x,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,list):return '.array ['+','.join(cv(y) for y in x)+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
source=(rt/'sft/physics/atomic_shell_periodicity_successor_validation_v1.py').read_text();fn=next(n for n in ast.parse(source).body if isinstance(n,ast.FunctionDef) and n.name=='authoritative_record');vals={n.targets[0].id:ast.literal_eval(n.value) for n in fn.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id in ['required','required_rows']}
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.AtomicShellRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
'''+f'def sourceHash : String := {q(src.SOURCE_HASH)}\ndef iupacHash : String := {q(src.IUPAC_HASH)}\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
'''+''.join(' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "atomic periodicity custody disclosure changed"\n' for k,v in vals['required'].items())+' pure payload\n'
s+='def requiredRows : List String := '+str(sorted(vals['required_rows'])).replace("'",'"')+'\n'
s+='''def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then
  throw "atomic periodicity source record identity changed"
 let record ← payloadBoundary payload
 let sources ← field record "sources"
 let periodic ← field sources "periodic_table"
 let path ← text (← field periodic "snapshot_path")
 if !sameValue (← field periodic "snapshot_hash") (.text iupacHash) then
  throw "IUPAC periodic-table identity changed"
 let component ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest component)) iupacHash then
  throw "IUPAC periodic-table identity changed"
 let rows ← field (← field sources "ionization") "rows"
 let pairs ← match rows with
  | .object xs => .ok xs
  | .text _ => .error "NIST periodicity row set changed"
  | .boolean _ => .error "NIST periodicity row set changed"
  | .integer _ => .error "NIST periodicity row set changed"
  | .null => .error "NIST periodicity row set changed"
  | .array _ => .error "NIST periodicity row set changed"
 if !(pairs.all (fun p => requiredRows.any (fun s => Text.equal s p.1))) || !(requiredRows.all (fun s => pairs.any (fun p => Text.equal s p.1))) then
  throw "NIST periodicity row set changed"
 pure record
'''
row=record['sources']['periodic_table'];s+='def componentFiles : List (String × String) := [('+q(row['snapshot_path'].split('/')[-1])+','+q(src.IUPAC_HASH)+')]\n'
s+='def registeredRecord : Value := '+cv(record)+'\ntheorem originalPayloadBoundary : payloadBoundary registeredRecord=.ok registeredRecord := rfl\nend SFT.Physics.AtomicShellRecords\n'
for root in [r,c]:(root/'SFT/Physics/AtomicShellRecords.lean').write_text(s)
