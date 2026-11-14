import SFT.Physics.DeuteronDinucleonProofs
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.DeuteronDinucleonGrammar
open DeuteronDinucleon DeuteronDinucleonProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
inductive Partition where
 | c0
 | c1
 | c2
def partitionName : Partition → String
 | .c0 => "three-preserving-one-alternating"
 | .c1 => "two-preserving-two-alternating"
 | .c2 => "one-preserving-three-alternating"
def partitionPassed : Partition → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem partitionComputed (x : Partition) : exchangePartitionIsForced (partitionName x) = .ok (partitionPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.partition0
 | c1 => exact DeuteronDinucleonProofs.partition1
 | c2 => exact DeuteronDinucleonProofs.partition2
inductive Ground where
 | c0
 | c1
 | c2
def groundName : Ground → String
 | .c0 => "pn-preserving-spin-ppnn-alternating-spin"
 | .c1 => "pn-alternating-spin-ppnn-preserving-spin"
 | .c2 => "all-pairs-preserving-spin"
def groundPassed : Ground → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem groundComputed (x : Ground) : groundExchangeLedgerIsForced (groundName x) = .ok (groundPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.ground0
 | c1 => exact DeuteronDinucleonProofs.ground1
 | c2 => exact DeuteronDinucleonProofs.ground2
inductive Residual where
 | c0
 | c1
 | c2
def residualName : Residual → String
 | .c0 => "preserving-leaves-half-alternating-empty"
 | .c1 => "quarter-act-binds-both-spin-hands"
 | .c2 => "neither-spin-hand-retains-support"
def residualPassed : Residual → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem residualComputed (x : Residual) : residualDiscriminatorIsForced (residualName x) = .ok (residualPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.residual0
 | c1 => exact DeuteronDinucleonProofs.residual1
 | c2 => exact DeuteronDinucleonProofs.residual2
inductive Binding where
 | c0
 | c1
 | c2
 | c3
def bindingName : Binding → String
 | .c0 => "pn-only-bound"
 | .c1 => "all-pairs-bound"
 | .c2 => "no-pair-bound"
 | .c3 => "identical-pairs-only-bound"
def bindingPassed : Binding → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
 | .c3 => false
theorem bindingComputed (x : Binding) : bindingTableIsForced (bindingName x) = .ok (bindingPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.binding0
 | c1 => exact DeuteronDinucleonProofs.binding1
 | c2 => exact DeuteronDinucleonProofs.binding2
 | c3 => exact DeuteronDinucleonProofs.binding3
inductive Spin where
 | c0
 | c1
 | c2
def spinName : Spin → String
 | .c0 => "complete-One-with-three-readings"
 | .c1 => "empty-spin-with-one-reading"
 | .c2 => "spin-unresolved"
def spinPassed : Spin → Bool
 | .c0 => true
 | .c1 => false
 | .c2 => false
theorem spinComputed (x : Spin) : compositeSpinIsForced (spinName x) = .ok (spinPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.spin0
 | c1 => exact DeuteronDinucleonProofs.spin1
 | c2 => exact DeuteronDinucleonProofs.spin2
inductive Charged where
 | c0
 | c1
def chargedName : Charged → String
 | .c0 => "pp-positive-opposition-secondary-to-singlet-exclusion"
 | .c1 => "charged-path-selects-both-identical-outcomes"
def chargedPassed : Charged → Bool
 | .c0 => true
 | .c1 => false
theorem chargedComputed (x : Charged) : chargedPairRoleIsForced (chargedName x) = .ok (chargedPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.charged0
 | c1 => exact DeuteronDinucleonProofs.charged1
inductive Target where
 | c0
 | c1
def targetName : Target → String
 | .c0 => "sealed-before-release"
 | .c1 => "readable-before-seal"
def targetPassed : Target → Bool
 | .c0 => true
 | .c1 => false
theorem targetComputed (x : Target) : targetBoundaryIsForced (targetName x) = .ok (targetPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.target0
 | c1 => exact DeuteronDinucleonProofs.target1
inductive Extension where
 | c0
 | c1
def extensionName : Extension → String
 | .c0 => "empty-extension"
 | .c1 => "free-correction"
def extensionPassed : Extension → Bool
 | .c0 => true
 | .c1 => false
theorem extensionComputed (x : Extension) : extensionIsForced (extensionName x) = .ok (extensionPassed x) := by
 cases x with
 | c0 => exact DeuteronDinucleonProofs.extension0
 | c1 => exact DeuteronDinucleonProofs.extension1
structure Candidate where
 partition : Partition
 ground : Ground
 residual : Residual
 binding : Binding
 spin : Spin
 charged : Charged
 target : Target
 extension : Extension
def sourceFields (c : Candidate) : List String := [partitionName c.partition,groundName c.ground,residualName c.residual,bindingName c.binding,spinName c.spin,chargedName c.charged,targetName c.target,extensionName c.extension]
def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def candidateFacts (c : Candidate) : Except String (List (String × Bool)) := do
 let partition ← exchangePartitionIsForced (partitionName c.partition)
 let ground ← groundExchangeLedgerIsForced (groundName c.ground)
 let residual ← residualDiscriminatorIsForced (residualName c.residual)
 let binding ← bindingTableIsForced (bindingName c.binding)
 let spin ← compositeSpinIsForced (spinName c.spin)
 let charged ← chargedPairRoleIsForced (chargedName c.charged)
 let target ← targetBoundaryIsForced (targetName c.target)
 let extension ← extensionIsForced (extensionName c.extension)
 pure [("exchange_partition",partition),("ground_exchange_ledger",ground),("residual_discriminator",residual),("binding_table",binding),("composite_spin",spin),("charged_pair_role",charged),("target_boundary",target),("extension",extension)]
def computedFacts (c : Candidate) : List (String × Bool) := [("exchange_partition",partitionPassed c.partition),("ground_exchange_ledger",groundPassed c.ground),("residual_discriminator",residualPassed c.residual),("binding_table",bindingPassed c.binding),("composite_spin",spinPassed c.spin),("charged_pair_role",chargedPassed c.charged),("target_boundary",targetPassed c.target),("extension",extensionPassed c.extension)]
theorem factsComputed (c : Candidate) : candidateFacts c = .ok (computedFacts c) := by
 unfold candidateFacts
 rw [partitionComputed,groundComputed,residualComputed,bindingComputed,spinComputed,chargedComputed,targetComputed,extensionComputed]
 rfl
def survives (c : Candidate) : Bool := (computedFacts c).all Prod.snd
def sourceSurvives (c : Candidate) : Except String Bool := do
 pure ((← candidateFacts c).all Prod.snd)
theorem sourceDecision (c : Candidate) : sourceSurvives c = .ok (survives c) := by
 unfold sourceSurvives
 rw [factsComputed]
 rfl
def candidates : List Candidate :=
 [.c0,.c1,.c2].flatMap (fun partition =>
 [.c0,.c1,.c2].flatMap (fun ground =>
 [.c0,.c1,.c2].flatMap (fun residual =>
 [.c0,.c1,.c2,.c3].flatMap (fun binding =>
 [.c0,.c1,.c2].flatMap (fun spin =>
 [.c0,.c1].flatMap (fun charged =>
 [.c0,.c1].flatMap (fun target =>
 [.c0,.c1].map (fun extension => ⟨partition,ground,residual,binding,spin,charged,target,extension⟩))))))))
def survivor : Candidate := ⟨.c0,.c0,.c0,.c0,.c0,.c0,.c0,.c0⟩
theorem candidateCount : candidates.length = 2592 := rfl
theorem uniqueSurvivor (c : Candidate) : survives c = true → c = survivor := by
 rcases c with ⟨partition,ground,residual,binding,spin,charged,target,extension⟩
 cases partition <;> cases ground <;> cases residual <;> cases binding <;> cases spin <;> cases charged <;> cases target <;> cases extension <;> intro h <;> first | rfl | contradiction
theorem survivorAccepted : survives survivor = true := rfl
theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
 rcases c with ⟨partition,ground,residual,binding,spin,charged,target,extension⟩
 have hpartition : partition ∈ [Partition.c0,Partition.c1,Partition.c2] := by
  cases partition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hground : ground ∈ [Ground.c0,Ground.c1,Ground.c2] := by
  cases ground <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hresidual : residual ∈ [Residual.c0,Residual.c1,Residual.c2] := by
  cases residual <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hbinding : binding ∈ [Binding.c0,Binding.c1,Binding.c2,Binding.c3] := by
  cases binding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hspin : spin ∈ [Spin.c0,Spin.c1,Spin.c2] := by
  cases spin <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hcharged : charged ∈ [Charged.c0,Charged.c1] := by
  cases charged <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have htarget : target ∈ [Target.c0,Target.c1] := by
  cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 have hextension : extension ∈ [Extension.c0,Extension.c1] := by
  cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
 unfold candidates
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ partition _ hpartition
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ ground _ hground
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ residual _ hresidual
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ binding _ hbinding
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ spin _ hspin
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ charged _ hcharged
 apply SFT.Foundation.CommonRefinement.memFlatMap _ _ target _ htarget
 exact SFT.Foundation.Count.TraceDerivation.memMap _ extension _ hextension
def generationRule : String := "Generate the complete product of all exchange partitions of the four two-label spin states, every ground spatial/spin/charge exchange allocation, every quarter-residual binding discriminator, every three-pair binding table, every composite-spin reading class, both charged-pair roles, both target-custody states and both extension states."
def grammarBoundary : String := "Every ordered word over the two forced held spin labels; preserving and alternating exchange hands; the least exchange-preserving spatial recurrence; preserving identical or alternating proton/neutron charge support; the admitted quarter-One residual boundary act; all proton-neutron, proton-proton and neutron-neutron ground channels; sealed or exposed target custody; and empty or free extension. The certificate is independent of a finite Fold search depth."
end SFT.Physics.DeuteronDinucleonGrammar
