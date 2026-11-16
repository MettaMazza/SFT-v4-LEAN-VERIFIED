import SFT.Physics.QuantumSupportWalshBatchAssembly
import SFT.Physics.QuantumSupportWalshThreeProof
namespace SFT.Physics.QuantumSupportWalshBatch
open QuantumSupportWalsh QuantumSupportPreparation GeneratorOperations
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
def depthStep (counts : Nat × Nat) (index : Nat) : Except String (Nat × Nat) := do
 let depth := index+1
 let input := CountInput.integer (.ofNat depth)
 let ws ← binaryWords input
 let orthogonal ← orthogonalityCertificate input
 if !orthogonal.diagonalComplete || !orthogonal.offDiagonalCancels then throw "Walsh orthogonality failed"
 (List.range ws.length).foldlM (fun counts size => (combinations (size+1) ws).foldlM (step input) counts) counts
def assembledCensus (maxDepth : CountInput) : Except String WalshCensus := do
 let limit ← SpinStatisticsCondensation.positiveWhole maxDepth "Walsh census depth"
 let (total,saturated) ← (List.range limit).foldlM depthStep (0,0)
 pure ⟨limit,total,saturated,true⟩
theorem originalRepresentation (input : CountInput) : completeWalshCensus input=assembledCensus input := rfl
theorem originalFirstThreeTotals : [0,1,2].foldlM depthStep (0,0)=.ok (273,65) := by
 have h := QuantumSupportWalshThreeProof.originalFirstThreeDepths
 rw [originalRepresentation] at h
 change (do let p ← [0,1,2].foldlM depthStep (0,0); pure (WalshCensus.mk 3 p.1 p.2 true))=Except.ok (WalshCensus.mk 3 273 65 true) at h
 cases he : [0,1,2].foldlM depthStep (0,0) with
 | error e => rw [he] at h;cases h
 | ok p =>
  rw [he] at h
  have totals := congrArg (fun v : Except String WalshCensus => v.map (fun c => (c.candidateSupports,c.saturatedSupports))) h
  change Except.ok p=Except.ok (273,65) at totals
  cases totals
  rfl
#print axioms originalRepresentation
#print axioms originalFirstThreeTotals
end SFT.Physics.QuantumSupportWalshBatch
