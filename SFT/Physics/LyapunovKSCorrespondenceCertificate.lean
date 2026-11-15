import SFT.Physics.LyapunovKSCorrespondence
namespace SFT.Physics.LyapunovKSCorrespondenceCertificate
open LyapunovKSCorrespondence
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
structure CarrierCase where
 labelCount : Nat
 depthSupport : List Nat
 successorRatios : List Nat
 separationMultipliers : List Int
structure Certificate where
 cases : List CarrierCase
 supportIsPower : Bool
 successorMultiplier : Bool
 localSeparationMultiplier : Bool
 commonCarrier : Bool
 analyticProofValueRequired : Bool
def carrierCase (m : Nat) : Except String CarrierCase := do
 let support ← [1,2,3,4].mapM (fun d => exactSupportCount (.integer (.ofNat m)) (.integer (.ofNat d)))
 let ratios ← [1,2,3].mapM (fun d => do
  let above ← exactSupportCount (.integer (.ofNat m)) (.integer (.ofNat (d+1)))
  let below ← exactSupportCount (.integer (.ofNat m)) (.integer (.ofNat d))
  pure (above/below))
 let separation ← [1,2,3,5].mapM (fun parts => do
  let value ← separationCarrier (.integer (.ofNat m)) (.integer (.ofNat parts))
  pure (value/Int.ofNat parts))
 pure ⟨m,support,ratios,separation⟩
def carrierCertificate : Except String Certificate := do
 let rows ← [2,3,5].mapM carrierCase
 let common ← rows.mapM (fun row =>
  match row.successorRatios,row.separationMultipliers with
  | a::_,b::_ => .ok (decide (Int.ofNat a=b) && a==row.labelCount)
  | [],_ => .error "IndexError"
  | _::_,[] => .error "IndexError")
 pure ⟨rows,
  rows.all (fun row => row.depthSupport==[1,2,3,4].map (fun d => row.labelCount^d)),
  rows.all (fun row => row.successorRatios==[row.labelCount,row.labelCount,row.labelCount]),
  rows.all (fun row => decide (row.separationMultipliers=[.ofNat row.labelCount,.ofNat row.labelCount,.ofNat row.labelCount,.ofNat row.labelCount])),
  common.all id,false⟩
def certificateFacts : Except String Bool := do
 let c ← carrierCertificate
 pure (c.supportIsPower && c.successorMultiplier && c.localSeparationMultiplier && c.commonCarrier && !c.analyticProofValueRequired)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.LyapunovKSCorrespondenceCertificate
