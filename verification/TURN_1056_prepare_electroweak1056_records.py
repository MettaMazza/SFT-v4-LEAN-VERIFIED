from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tree=ast.parse((w/'weakobservation1056_empirical.py').read_text());const={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
q=lambda x:json.dumps(x,ensure_ascii=False)
pairs=[(const['SOURCE_PATH'],const['SOURCE_HASH'])]+list(const['SOURCE_FILES'])
s='''import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ElectroweakMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
'''
s+='def sourcePath : String := '+q(const['SOURCE_PATH'])+'\ndef sourceHashes : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')'for a,b in pairs)+']\ndef sourceIds : List String := '+q(const['SOURCE_IDS'])+'\n'
s+='''-- Original required_true traverses the actual keys, not an invented fixed list.
def boundariesRetained (boundary : Value) : Bool :=
 match boundary with
 | .object fields =>
  fields.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" ||
   ThermometryMeasurement.literalBoolean value true) &&
  ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "electroweak successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-electroweak-measured-value-successor-source-record/1") then
  throw "electroweak successor source schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:263cf79e79ed1d7ba0246f84abe869084aa4db7b195dd0c07300d1dabdef72f4") then
  throw "electroweak formal receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id")))
    (.array (sourceIds.map Value.text)) then
  throw "complete two-source electroweak record required"
 if !boundariesRetained (getDefault payload "methodological_boundary" (.object [])) then
  throw "electroweak measurement-method boundary changed"
 pure payload
'''
boundary=json.load(open(w/'weakobservation1056_record.json'))['methodological_boundary']
s+='def originalBoundary : Value := .object ['+','.join('('+q(k)+',.boolean '+str(v).lower()+')'for k,v in boundary.items())+']\n'
s+='''theorem originalBoundaryRetained : boundariesRetained originalBoundary = true := rfl
#print axioms boundariesRetained
#print axioms authoritativeRecord
#print axioms originalBoundaryRetained
end SFT.Physics.ElectroweakMeasuredRecords
'''
(r/'SFT/Physics/ElectroweakMeasuredRecords.lean').write_text(s)
