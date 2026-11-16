import SFT.Chemistry.StateEnergyComparison
import SFT.Chemistry.StateEnergyOrderWitnesses
namespace SFT.Chemistry.StateEnergyControls
open SFT.Host
abbrev J := Canonical.Value

def field := ConjugatedSupportAnalysis.field

def boolField (row : J) (key : String) : Except String Bool := do
 match ← field row key with
 | .boolean b => pure b
 | .null | .text _ | .integer _ | .array _ | .object _ => throw "registered comparison boolean required"

def display : J → Except String String
 | .text s => .ok s
 | .integer n => .ok (Canonical.render (.integer n))
 | .boolean b => .ok (if b then "True" else "False")
 | .null => .ok "None"
 | .array _ | .object _ => .error "registered comparison scalar required"
def shown (row : J) (key : String) : Except String String := field row key >>= display

def adverse (comparisons : List J) (pairs : Nat) (firstHash expectedHash changedHash : String) : Except String (List (String × Bool)) := do
 let grounds ← comparisons.mapM (fun row=>boolField row "is_ground")
 pure [
 ("tied_ground_rejected",StateEnergyOrder.duplicateGroundWitness),
 ("negative_gap_rejected",!(1 > (2 : Nat))),
 ("omitted_row_rejected",(comparisons.take (comparisons.length-1)).length != 306),
 ("unit_confounded_row_rejected",!Text.equal "eV" "inverse-centimetre"),
 ("tampered_source_rejected",Text.equal firstHash expectedHash && !Text.equal changedHash expectedHash),
 ("complete_vector_retained",comparisons.length==306 && (grounds.filter id).length==22 &&
  (grounds.filter (fun b=>!b)).length==284 && pairs>0)]

def passed (comparisons : List J) (controls : List (String × Bool)) : Except String Bool := do
 let results ← comparisons.mapM (fun row=>boolField row "passed")
 pure (results.all id && controls.all Prod.snd)

def measurement (row : J) : Except String String := do
 let target ← shown row "target_id"
 let species ← shown row "species_row_id"
 let state ← shown row "NIST_state"
 let inscription ← shown row "measured_Te_inscription"
 let n ← shown row "exact_value_numerator"
 let d ← shown row "exact_value_denominator"
 let ground ← shown row "is_ground"
 let gn ← shown row "gap_from_ground_numerator"
 let gd ← shown row "gap_from_ground_denominator"
 let position ← shown row "forced_order_position"
 let result ← shown row "passed"
 pure (Text.join [target," (",species,"): NIST ",state,"; Te ",inscription," cm^-1 = ",n,"/",d,
  "; ground ",ground,"; exact gap ",gn,"/",gd,"; order ",position,"; pass ",result])

def measurements (comparisons : List J) (pairs : Nat) (controls : List (String × Bool)) : Except String (List String) := do
 let rows ← comparisons.mapM measurement
 pure (rows ++ [Text.append "complete strict measured state-pair comparisons: " (Canonical.render (.integer (.ofNat pairs)))] ++
  controls.map (fun (key,value)=>Text.join ["adverse ",key,": ",if value then "True" else "False"]))

def measurementPayload (registrationHash predictionHash : String) (comparisons : List J)
 (pairs : Nat) (controls : List (String × Bool)) (traceHash : String) : J := .object [
 ("registration_hash",.text registrationHash),("prediction_seal_hash",.text predictionHash),
 ("comparisons",.array comparisons),("pair_count",.integer (.ofNat pairs)),
 ("adverse",.object (controls.map fun (key,b)=>(key,.boolean b))),("trace_hash",.text traceHash)]

#print axioms field
#print axioms boolField
#print axioms display
#print axioms shown
#print axioms adverse
#print axioms passed
#print axioms measurement
#print axioms measurements
#print axioms measurementPayload
end SFT.Chemistry.StateEnergyControls
