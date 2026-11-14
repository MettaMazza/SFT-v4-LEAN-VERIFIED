from pathlib import Path
import json,ast
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');src=w/'v3-runtime500/sft/physics/nuclear_binding_curve_successor_validation_v1.py';tree=ast.parse(src.read_text());const={}
for node in tree.body:
 if isinstance(node,ast.Assign) and isinstance(node.targets[0],ast.Name):
  try:const[node.targets[0].id]=ast.literal_eval(node.value)
  except (ValueError,TypeError):pass
fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='authoritative_record');required=next(ast.literal_eval(n.value) for n in fn.body if isinstance(n,ast.Assign) and isinstance(n.targets[0],ast.Name) and n.targets[0].id=='required');record=json.load(open(w/'nuclearbindingcurve963_original_measurement.json'))['record'];q=lambda s:json.dumps(s,ensure_ascii=False)
def cv(x):
 if x is None:return '.null'
 if isinstance(x,bool):return '.boolean '+str(x).lower()
 if isinstance(x,int):return '.integer ('+str(x)+')'
 if isinstance(x,str):return '.text '+q(x)
 if isinstance(x,list):return '.array ['+','.join(map(cv,x))+']'
 if isinstance(x,dict):return '.object ['+','.join('('+q(k)+','+cv(v)+')' for k,v in x.items())+']'
 raise TypeError(x)
s='''import SFT.Physics.MatterAuthoritativeRecords
namespace SFT.Physics.NuclearBindingRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
set_option maxRecDepth 20000
'''
for name,key in [('sourceHash','SOURCE_HASH'),('rawHash','RAW_HASH'),('rawPath','RAW_PATH')]:s+=f'def {name} : String := {q(const[key])}\n'
s+='''def payloadBoundary (payload : Value) : Except String Value := do
 let custody := (field payload "custody").toOption.getD (.object [])
'''
for k,v in required.items():s+=' if !sameValue ((field custody '+q(k)+').toOption.getD .null) ('+cv(v)+') then throw "AME2020 binding custody disclosure changed"\n'
s+=''' let census ← field payload "complete_numeric_binding_census"
 if !sameValue (← field census "raw_numeric_row_count") (.integer 2550) || !sameValue (← field census "positive_composite_row_count") (.integer 2548) then throw "AME2020 registered binding census changed"
 let boundary ← array (← field census "singleton_empty_binding_boundary_rows")
 if boundary.length != 2 || !(boundary.all (fun row => sameValue ((field row "mass_number").toOption.getD .null) (.integer 1) && sameValue ((field row "binding_energy_per_nucleon_keV").toOption.getD .null) (.text "0.0"))) then
  throw "AME2020 singleton empty-binding boundary changed"
 pure payload
def authoritativeRecord (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let raw ← match files.find? (fun p => Text.equal p.1 rawPath) with
  | none => .error (Text.append "FileNotFoundError: " rawPath)
  | some pair => .ok pair.2
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash || !Text.equal (Text.append "sha256:" (SHA256Chunks.digest raw)) rawHash then throw "AME2020 binding source identity changed"
 payloadBoundary payload
'''
s+='def registeredRecord : Value := '+cv(record)+'\n'
s+='theorem originalPayload : payloadBoundary registeredRecord = .ok registeredRecord := rfl\nend SFT.Physics.NuclearBindingRecords\n'
for root in [r,c]:(root/'SFT/Physics/NuclearBindingRecords.lean').write_text(s)
