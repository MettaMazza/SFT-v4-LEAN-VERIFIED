import SFT.Chemistry.IonicMobilityTransference
import Lean
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.DihedralTorsion SFT.Chemistry.IonicMobilityTransference
open SFT.Physics.CapabilityValues hiding Value
namespace MobilityCases
def field (j : Lean.Json) (k : String) := j.getObjVal? k
def labelInput (j : Lean.Json) : Except String HeldLabel := do
 let xs ← j.getArr?
 heldLabel (← xs[0]!.getStr?) (← xs[1]!.getStr?)
def countInput (j : Lean.Json) : Except String SFT.Chemistry.DihedralTorsion.CountInput := do
 if j==.null then pure .other else pure (.count (← count (← j.getNat?)))
def ratioInput (j : Lean.Json) : Except String Ratio := do
 let xs ← j.getArr?
 pure ⟨← count (← xs[0]!.getNat?),← count (← xs[1]!.getNat?)⟩
def heightInput (j : Lean.Json) : Except String Height := do
 if j==.null then pure .emptyOne else
  match j.getObjValAs? String "identity" with
  | .ok identityText => pure (.otherEmptyOne identityText)
  | .error _ => pure (.ratio (← ratioInput j))
def labelValue (l : HeldLabel) : SFT.Host.Canonical.Value := .object [("family",.text l.family),("label",.text l.label)]
def countValue (n : PositiveCount) : SFT.Host.Canonical.Value := .object [("value",.integer n.value)]
def ratioValue (r : Ratio) : SFT.Host.Canonical.Value := .object [("numerator",countValue r.numerator),("denominator",countValue r.denominator)]
def heightValue : Height → SFT.Host.Canonical.Value
 | .emptyOne=>.object [("identity",.text "empty-One")]
 | .otherEmptyOne s=>.object [("identity",.text s)]
 | .ratio r=>ratioValue r
 | .invalid=>.null

def accountInput (j : Lean.Json) : Except String IonicMobilityAccount := do
 makeAccount (← field j "species" >>= labelInput) (← field j "direction" >>= labelInput)
  (← field j "composition" >>= labelInput) (← field j "condition" >>= labelInput) (← field j "path" >>= labelInput)
  (← field j "traversals" >>= countInput) (← field j "carriers" >>= countInput) (← field j "resource" >>= countInput)
def accountValue (r : IonicMobilityAccount) : SFT.Host.Canonical.Value := .object [
 ("species",labelValue r.species),("direction",labelValue r.direction),("composition",labelValue r.composition),
 ("condition",labelValue r.condition),("path",labelValue r.path),("traversals",countValue r.traversals),
 ("carriers",countValue r.carriers),("path_resource",countValue r.pathResource)]
def fractionValue (r : SFT.Foundation.ExactOperations.PositiveFraction) : SFT.Host.Canonical.Value :=
 .object [("numerator",.integer r.numerator),("denominator",.integer r.denominator)]
def partValue (p : ExactPart) : SFT.Host.Canonical.Value := .object [("value",fractionValue p.value)]
def rowValue (r : TransferenceRow) : SFT.Host.Canonical.Value := .object [("species",labelValue r.species),("direction",labelValue r.direction),
 ("mobility",ratioValue r.mobility),("transference",partValue r.transference)]
def partitionValue (r : MobilityTransferenceResult) : SFT.Host.Canonical.Value := .object [
 ("rows",.array (r.rows.map rowValue)),("complete_partition",partValue r.completePartition),
 ("composition",labelValue r.composition),("condition",labelValue r.condition)]
def resultValue : Except String Value → SFT.Host.Canonical.Value
 | .ok v => .object [("ok",v)]
 | .error e => .object [("error",.text e)]
def runCase (j : Lean.Json) : Except String Value := do
 let accounts ← j.getArr? >>= fun xs=>xs.toList.mapM accountInput
 let result ← mobilityAndTransference accounts
 pure (.object [("accounts",.array (accounts.map accountValue)),("mobilities",.array (accounts.map fun r=>ratioValue (mobility r))),
  ("contributions",.array (accounts.map fun r=>fractionValue (contribution r))),("result",partitionValue result),("absence",heightValue absentSpeciesTransference)])
end MobilityCases
def main : IO Unit := do
 let input ← IO.FS.readFile "work/mobility1368_core_inputs.json"
 let rows ← IO.ofExcept (Lean.Json.parse input >>= Lean.Json.getArr?)
 for row in rows do IO.println (SFT.Host.Canonical.render (MobilityCases.resultValue (MobilityCases.runCase row)))
