import SFT.Chemistry.ElectrolysisProduct
import Lean
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Chemistry.DihedralTorsion SFT.Chemistry.ElectrolysisProduct
open SFT.Physics.CapabilityValues hiding Value
namespace ProductCases
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
def labelValue (l : HeldLabel) : Value := .object [("family",.text l.family),("label",.text l.label)]
def countValue (n : PositiveCount) : Value := .object [("value",.integer n.value)]
def ratioValue (r : Ratio) : Value := .object [("numerator",countValue r.numerator),("denominator",countValue r.denominator)]
def heightValue : Height → Value
 | .emptyOne=>.object [("identity",.text "empty-One")]
 | .otherEmptyOne s=>.object [("identity",.text s)]
 | .ratio r=>ratioValue r
 | .invalid=>.null

def accountInput (j : Lean.Json) : Except String ElectrolysisAccount := do
 makeAccount (← field j "process" >>= labelInput) (← field j "path" >>= labelInput)
  (← field j "product" >>= labelInput) (← field j "condition" >>= labelInput)
  (← field j "transferred" >>= countInput) (← field j "required" >>= countInput)
def accountValue (a : ElectrolysisAccount) : Value := .object [
 ("process_identity",labelValue a.processIdentity),("electrode_path",labelValue a.electrodePath),
 ("product_identity",labelValue a.productIdentity),("condition",labelValue a.condition),
 ("transferred_carriers",countValue a.transferredCarriers),("carriers_per_product",countValue a.carriersPerProduct)]
def productCountValue : CountOrEmpty → Value
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .count n => countValue n
def amountValue (a : ProductAmountResult) : Value := .object [
 ("complete_products",productCountValue a.completeProducts),("retained_carrier_remainder",productCountValue a.retainedCarrierRemainder),
 ("exact_product_amount",ratioValue a.exactProductAmount),("product_identity",labelValue a.productIdentity),("electrode_path",labelValue a.electrodePath)]
def resultValue : Except String Value → Value
 | .ok v => .object [("ok",v)]
 | .error e => .object [("error",.text e)]
def runCase (j : Lean.Json) : Except String Value := do
 let a ← field j "first" >>= accountInput
 let b ← field j "second" >>= accountInput
 let composed := (composeCarrierBatches a b).map fun c=>Value.object [("account",accountValue c),("amount",amountValue (electrolysisProductAmount c))]
 pure (.object [("first",accountValue a),("second",accountValue b),("amount",amountValue (electrolysisProductAmount a)),("composition",resultValue composed)])
end ProductCases
def main : IO Unit := do
 let input ← IO.FS.readFile "work/electrolysis1366_core_inputs.json"
 let rows ← IO.ofExcept (Lean.Json.parse input >>= Lean.Json.getArr?)
 for row in rows do IO.println (SFT.Host.Canonical.render (ProductCases.resultValue (ProductCases.runCase row)))
