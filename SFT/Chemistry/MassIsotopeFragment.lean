import SFT.Chemistry.XrayDiffraction
namespace SFT.Chemistry.MassIsotopeFragment
open SFT.Host SFT.Physics.CapabilityValues
open AnalyticalAccuracy (PositiveRatio rational ratio)
open IsotopeExchange (sameLabel)
-- The original family uses these same operations for ANAL-014 and ANAL-016.
-- Reuse their actual implementation and source-domain proof, without recoding it.
abbrev ExactSupport := XrayDiffraction.ExactSupport
abbrev Coordinate := XrayDiffraction.Coordinate
abbrev construct := XrayDiffraction.construct
abbrev exactSideRelation := XrayDiffraction.exactSideRelation
abbrev completeVector := XrayDiffraction.completeVector
abbrev sameSupport := XrayDiffraction.sameSupport
abbrev sameVector := XrayDiffraction.sameVector
theorem acceptedVectorExact (rows out : List Coordinate) (accepted : completeVector rows = .ok out) : out=rows :=
 XrayDiffraction.acceptedVectorExact rows out accepted
def originalRows : Except String (List Coordinate) := do
 let carrier ← heldLabel "analytical-carrier" "carrier-014"
 let condition ← heldLabel "analytical-condition" "condition-014"
 let (side,coordinate) := exactSideRelation (← ratio 3 1) (← ratio 5 1)
 let a ← construct carrier (← heldLabel "analytical-coordinate-kind" "coordinate-a") coordinate
  (← heldLabel "analytical-response-kind" "response-a") (.positive (← ratio 2 3)) side condition (← count 1)
 let b ← construct carrier (← heldLabel "analytical-coordinate-kind" "coordinate-b") (.positive (← ratio 7 2))
  (← heldLabel "analytical-response-kind" "response-b") .emptyOne (← heldLabel "held-side" "unresolved") condition (← count 2)
 completeVector [a,b]
def witness (index : Nat) : Bool := match originalRows with
 | .error _ => false
 | .ok [] => false
 | .ok (a::rest) => match rest with
  | [] => false
  | b::tail =>
   let rows := a::b::tail
   match index with
   | 0 => rows.all (fun row => sameLabel row.carrier a.carrier)
   | 1 => !sameSupport a.coordinate .emptyOne
   | 2 => match a.response with | .emptyOne => false | .positive q => rational q == (2,3)
   | 3 => Text.equal a.side.label "higher"
   | 4 => sameSupport b.response .emptyOne
   | 5 => rows.all (fun row => sameLabel row.condition a.condition)
   | 6 => rows.length==2
   | _ => match completeVector rows with | .error _ => false | .ok out => sameVector out rows
theorem carrierWitness : witness 0 = true := rfl
theorem probeWitness : witness 1 = true := rfl
theorem supportWitness : witness 2 = true := rfl
theorem coordinateWitness : witness 3 = true := rfl
theorem responseWitness : witness 4 = true := rfl
theorem structureWitness : witness 5 = true := rfl
theorem custodyWitness : witness 6 = true := rfl
theorem extensionWitness : witness 7 = true := rfl
end SFT.Chemistry.MassIsotopeFragment
