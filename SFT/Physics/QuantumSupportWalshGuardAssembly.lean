import SFT.Physics.QuantumSupportWalshCensusAssembly
import SFT.Physics.QuantumSupportOrthogonality
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalDepthGuard (p : Nat × Nat) (index : Nat) (ws : List Word)
 (hw : binaryWords (.integer (.ofNat (index+1)))=.ok ws)
 (ho : (do let c ← orthogonalityCertificate (.integer (.ofNat (index+1))); pure (c.diagonalComplete && c.offDiagonalCancels))=Except.ok true) :
 depthStep p index = (List.range ws.length).foldlM (fun counts size => (combinations (size+1) ws).foldlM (step (.integer (.ofNat (index+1)))) counts) p := by
 unfold depthStep
 dsimp only
 rw [hw]
 generalize hc : orthogonalityCertificate (.integer (.ofNat (index+1)))=op at ho ⊢
 cases op with
 | error e => cases ho
 | ok c =>
  cases c with
  | mk d n diagonal off rows =>
   cases diagonal <;> cases off <;> cases ho
   all_goals rfl
theorem originalFourthGuard (p : Nat × Nat) :
 depthStep p 3 = (List.range 16).foldlM (fun counts size => (combinations (size+1) (words 4)).foldlM (step (.integer 4)) counts) p :=
 originalDepthGuard p 3 (words 4) rfl QuantumSupportOrthogonality.originalDepthFour
theorem depthAppend (xs ys : List Nat) (p : Nat × Nat) :
 (xs++ys).foldlM depthStep p = (do let q ← xs.foldlM depthStep p; ys.foldlM depthStep q) := by
 induction xs generalizing p with
 | nil => rfl
 | cons x xs ih =>
  change (do let q ← depthStep p x; (xs++ys).foldlM depthStep q) = (do let q ← (do let v ← depthStep p x; xs.foldlM depthStep v); ys.foldlM depthStep q)
  cases h : depthStep p x with
  | error e => rfl
  | ok q => exact ih q
#print axioms originalDepthGuard
#print axioms originalFourthGuard
#print axioms depthAppend
end SFT.Physics.QuantumSupportWalshBatch
