import SFT.Chemistry.ElectrochemicalWork
import Lean
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.DihedralTorsion SFT.Chemistry.ElectrochemicalWork
open SFT.Physics.CapabilityValues hiding Value
namespace WorkCases
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

def accountInput (j : Lean.Json) : Except String ElectrochemicalWorkAccount := do
 makeAccount (← field j "cell" >>= labelInput) (← field j "chemical" >>= labelInput)
  (← field j "electrical" >>= labelInput) (← field j "condition" >>= labelInput)
  (← field j "orientation" >>= labelInput) (← field j "carriers" >>= countInput)
  (← field j "potential" >>= heightInput)
def accountValue (a : ElectrochemicalWorkAccount) : SFT.Host.Canonical.Value := .object [
 ("cell_identity",labelValue a.cellIdentity),("chemical_path",labelValue a.chemicalPath),
 ("electrical_path",labelValue a.electricalPath),("condition",labelValue a.condition),
 ("reaction_orientation",labelValue a.reactionOrientation),("transferred_carriers",countValue a.transferredCarriers),
 ("potential_separation",heightValue a.potentialSeparation)]
def workValue (a : ElectrochemicalWorkResult) : SFT.Host.Canonical.Value := .object [
 ("orientation",labelValue a.orientation),("work_magnitude",heightValue a.workMagnitude),
 ("chemical_path",labelValue a.chemicalPath),("electrical_path",labelValue a.electricalPath),
 ("transferred_carriers",countValue a.transferredCarriers),("condition",labelValue a.condition)]
def runCase (j : Lean.Json) : Except String Value := do
 let a ← accountInput j
 let b ← reverseWorkAccount a
 let c ← reverseWorkAccount b
 pure (.object [("account",accountValue a),("result",workValue (← electrochemicalWork a)),
  ("reverse",accountValue b),("reverse_result",workValue (← electrochemicalWork b)),("reverse_twice",accountValue c)])
def resultValue : Except String Value → SFT.Host.Canonical.Value
 | .ok v => .object [("ok",v)]
 | .error e => .object [("error",.text e)]
end WorkCases
def main : IO Unit := do
 let input ← IO.FS.readFile "work/echemwork1365_core_inputs.json"
 let rows ← IO.ofExcept (Lean.Json.parse input >>= Lean.Json.getArr?)
 for row in rows do IO.println (SFT.Host.Canonical.render (WorkCases.resultValue (WorkCases.runCase row)))
