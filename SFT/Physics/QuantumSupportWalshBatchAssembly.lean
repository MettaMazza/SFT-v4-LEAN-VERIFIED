import SFT.Physics.QuantumSupportWalshBatch
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportPreparation QuantumSupportWalsh GeneratorOperations
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
theorem appendResults (input : CountInput) (xs ys : List (List Word)) (n k m l : Nat)
 (hx : xs.foldlM (step input) (0,0)=.ok (n,k))
 (hy : ys.foldlM (step input) (0,0)=.ok (m,l)) :
 (xs++ys).foldlM (step input) (0,0)=.ok (n+m,k+l) := by
 rw [foldAppend,hx]
 change ys.foldlM (step input) (n,k)=.ok (n+m,k+l)
 rw [foldFromZero input ys m l n k hy,Nat.add_comm m n,Nat.add_comm l k]
#print axioms appendResults
end SFT.Physics.QuantumSupportWalshBatch
