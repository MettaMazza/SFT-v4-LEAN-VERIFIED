import SFT.Chemistry.IonicConductivity
import Lean
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.DihedralTorsion SFT.Chemistry.IonicConductivity
open SFT.Physics.CapabilityValues hiding Value
namespace ConductivityCases
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

def contributionInput (j : Lean.Json) : Except String IonicTransportContribution := do
 makeContribution (← field j "species" >>= labelInput) (← field j "direction" >>= labelInput)
  (← field j "composition" >>= labelInput) (← field j "condition" >>= labelInput) (← field j "path" >>= labelInput)
  (← field j "carried" >>= countInput) (← field j "resource" >>= countInput)
def contributionValue (r : IonicTransportContribution) : SFT.Host.Canonical.Value := .object [
 ("species",labelValue r.species),("direction",labelValue r.direction),("composition",labelValue r.composition),
 ("condition",labelValue r.condition),("path",labelValue r.path),("carried_distinctions",countValue r.carriedDistinctions),
 ("counted_path_resource",countValue r.countedPathResource)]
def conductivityValue (r : IonicConductivityResult) : SFT.Host.Canonical.Value := .object [
 ("exact_total_response",ratioValue r.exactTotalResponse),("species_contributions",.array (r.speciesContributions.map contributionValue)),
 ("composition",labelValue r.composition),("condition",labelValue r.condition),("path",labelValue r.path)]
def fractionValue (r : SFT.Foundation.ExactOperations.PositiveFraction) : SFT.Host.Canonical.Value :=
 .object [("numerator",.integer r.numerator),("denominator",.integer r.denominator)]
def resultValue : Except String Value → SFT.Host.Canonical.Value
 | .ok v => .object [("ok",v)]
 | .error e => .object [("error",.text e)]
def runCase (j : Lean.Json) : Except String Value := do
 let rows ← (field j "rows" >>= Lean.Json.getArr?) >>= fun xs=>xs.toList.mapM contributionInput
 let successor ← field j "successor" >>= contributionInput
 let result ← ionicConductivity rows
 pure (.object [("contributions",.array (rows.map contributionValue)),("responses",.array (rows.map fun r=>fractionValue (exactResponse r))),
  ("result",conductivityValue result),("append",resultValue ((appendSpecies rows successor).map Value.boolean))])
end ConductivityCases
def main : IO Unit := do
 let input ← IO.FS.readFile "work/conductivity1367_core_inputs.json"
 let rows ← IO.ofExcept (Lean.Json.parse input >>= Lean.Json.getArr?)
 for row in rows do IO.println (SFT.Host.Canonical.render (ConductivityCases.resultValue (ConductivityCases.runCase row)))
