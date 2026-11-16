from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tree=ast.parse((w/'commonmeasured1056.py').read_text());const={}
for n in tree.body:
 if isinstance(n,ast.Assign):
  try:const[n.targets[0].id]=ast.literal_eval(n.value)
  except (ValueError,TypeError):pass
q=json.dumps;pairs=[(const['SOURCE_PATH'],const['SOURCE_HASH'])]+list(const['SOURCE_FILES'])
s='''import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CommonMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
'''
s+='def sourcePath : String := '+q(const['SOURCE_PATH'])+'\ndef sourceHashes : List (String × String) := ['+','.join('('+q(a)+','+q(b)+')'for a,b in pairs)+']\ndef sourceIds : List String := '+q(const['SOURCE_IDS'])+'\n'
s+='''def boundaryValuesTrue (boundary : Value) : Bool :=
 match boundary with
 | .object fs => fs.all (fun (key,value) => Text.equal key "measurement_selected_formal_survivor" || ThermometryMeasurement.literalBoolean value true)
 | .null | .boolean _ | .integer _ | .text _ | .array _ => false

def measurementNotSelected (boundary : Value) : Bool :=
 ThermometryMeasurement.literalBoolean (getDefault boundary "measurement_selected_formal_survivor") false

def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "common-scale successor source changed: " relative)
  pure ())
 if !sameValue (getDefault payload "schema") (.text "sft-v3-common-scale-measured-value-successor-source-record/1") then
  throw "common-scale successor schema changed"
 if !sameValue (getDefault payload "formal_receipt_hash") (.text "sha256:44d542f87d12844c02c321ac651008ae7ddd738a3b16e7d2c3d8700ec89eca55") then
  throw "common-scale formal receipt binding changed"
 if !sameValue (getDefault payload "electroweak_successor_receipt_hash") (.text "sha256:e93f04515944a1951b78463db3083350fbc77e6d8506edbcdc13178cedfbc852") then
  throw "electroweak successor receipt binding changed"
 let sources ← array (getDefault payload "sources" (.array []))
 if !sameValue (.array (sources.map (fun row => getDefault row "source_id"))) (.array (sourceIds.map Value.text)) then
  throw "complete common-scale source vector required"
 let boundary := getDefault payload "methodological_boundary" (.object [])
 if !boundaryValuesTrue boundary then throw "common-scale methodological boundary changed"
 if !measurementNotSelected boundary then throw "measurement-selection boundary changed"
 pure payload
'''
boundary=json.load(open(w/'commonmeasured1056_record.json'))['methodological_boundary'];s+='def originalBoundary : Value := .object ['+','.join('('+q(k)+',.boolean '+str(v).lower()+')'for k,v in boundary.items())+']\n'
s+='''theorem originalBoundaryValues : boundaryValuesTrue originalBoundary = true := rfl
theorem originalMeasurementBoundary : measurementNotSelected originalBoundary = true := rfl
#print axioms boundaryValuesTrue
#print axioms measurementNotSelected
#print axioms authoritativeRecord
#print axioms originalBoundaryValues
#print axioms originalMeasurementBoundary
end SFT.Physics.CommonMeasuredRecords
''';(r/'SFT/Physics/CommonMeasuredRecords.lean').write_text(s)
