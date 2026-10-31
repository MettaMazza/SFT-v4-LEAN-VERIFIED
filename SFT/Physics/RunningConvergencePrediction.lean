import SFT.Physics.RunningConvergenceMeasurement
import SFT.Physics.HostilePackage
import SFT.Physics.TargetCustody
import SFT.Computation.MathematicalModelling
namespace SFT.Physics.RunningConvergencePrediction
open SFT.Host SFT.Host.Canonical RunningConvergence

def claimId : String := "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"
def experimentId : String := "SFT-EXP-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"

def item {α : Type} : List α → Nat → Except String α
 | [],_ => .error "IndexError: formal certificate item absent"
 | x::_,0 => .ok x
 | _::xs,n+1 => item xs n

def ratio (q : Rat) : Except String CapabilityValues.Value :=
 if h : 0 < q.num.toNat then
  .ok (.ratio ⟨q.num.toNat,h⟩ ⟨q.den,Nat.pos_of_ne_zero q.den_nz⟩)
 else .error "coupling prediction input must remain exact and positive"

def wholeRatio (n : Nat) : Except String CapabilityValues.Value :=
 ratio (LeptonIntervals.normalize (.ofNat n) 1 (by decide))

def sectorValue (xs : List (Nat × Rat)) (p : Nat) : Except String Rat :=
 match xs.find? (fun kv => kv.1==p) with | some (_,q) => .ok q | none => .error "KeyError: formal sector absent"

def label (family name : String) : Except String CapabilityValues.Value := do
 pure (.label (← CapabilityValues.heldLabel family name))

def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← formalCertificate
 let first ← item c.commonScaleVectors 0
 let fourth ← item c.commonScaleVectors 3
 let firstGaps ← item c.pairGapVectors 0
 let fourthGaps ← item c.pairGapVectors 3
 let w ← item c.convergenceWitnesses (c.convergenceWitnesses.length-1)
 let base : List (String × CapabilityValues.Value) := [
  ("support_one",← wholeRatio (← item c.supports 0)),
  ("support_two",← wholeRatio (← item c.supports 1)),
  ("support_four",← wholeRatio (← item c.supports 2)),
  ("support_eight",← wholeRatio (← item c.supports 3)),
  ("pair_gap_base",← ratio (← item firstGaps (firstGaps.length-1))),
  ("pair_gap_level_four",← ratio (← item fourthGaps (fourthGaps.length-1))),
  ("finite_tolerance",← ratio w.tolerance),
  ("finite_witness_gap",← ratio w.gap),
  ("scale_relation",← label "coupling-scale" "One-base-binary-successor"),
  ("running_relation",← label "coupling-running" "one-shortfall-of-sector-plus-support"),
  ("gap_relation",← label "coupling-gap" "exact-pair-gap-shrinks-at-successor"),
  ("convergence_relation",← label "coupling-convergence" "finite-positive-tolerance-witness"),
  ("translation_relation",← label "coupling-translation" "carrier-specific-coordinate-orientation")]
 let sectorInputs ← c.sectors.flatMapM fun p => do
  let sectorPrefix := Text.append "sector_" (render (.integer (.ofNat p)))
  pure [(Text.append sectorPrefix "_base",← ratio (← sectorValue first p)),
    (Text.append sectorPrefix "_level_four",← ratio (← sectorValue fourth p))]
 pure (base++sectorInputs)

def predictionProgram (inputs : List (String × CapabilityValues.Value)) : CapabilityAdmission.Program :=
 let keys := inputs.map Prod.fst
 ⟨Text.append experimentId "-exact-prediction",
  keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩

def predictionDocument (inputs : List (String × CapabilityValues.Value)) : Value :=
 let program := predictionProgram inputs
 .object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),
  ("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))]

def inputsValue (inputs : List (String × CapabilityValues.Value)) : Value :=
 .object (inputs.map (fun (key,v) => (key,CapabilityValues.canonical v)))


def registration (inputs : List (String × CapabilityValues.Value)) : Value := .object [
 ("schema",.text "sft-v3-coupling-running-convergence-experiment/1"),
 ("claim_id",.text "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"),
 ("experiment_id",.text "SFT-EXP-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006"),
 ("registered_by",.text "Maria Smith"),
 ("evidence_mode",.text "observational_derivation"),
 ("protocol",.text "observational-data-informed_target-inaccessible_sealed-prediction"),
 ("frozen_relation",.text "The complete prime-sector ladder shares One-base binary support; each running share is the holding part of sector plus support, every share increases with support, every exact pair gap decreases, and every finite tolerance has a generated witness. Physical energy orientation is carrier-specific."),
 ("prediction_program",predictionDocument inputs),
 ("withheld_target_ids",.array [.text "PDG-COMPLETE-STRONG-RUNNING-VECTOR",.text "PDG-COMPLETE-ELECTROMAGNETIC-RUNNING-VECTOR",.text "PDG-EXPLICIT-ELECTROMAGNETIC-ENDPOINT-PAIR"]),
 ("source_id",.text "PDG-COUPLING-RUNNING-CONVERGENCE-2025-2026"),
 ("source_ids",.array [.text "PDG-2026-QCD-REVIEW",.text "PDG-2026-ELECTROWEAK-REVIEW",.text "PDG-2025-ELECTROMAGNETIC-RUNNING-ENDPOINT"]),
 ("source_record_path",.text "experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json"),
 ("source_record_hash",.text "sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),
 ("source_hashes",.object [("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json",.text "sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),("experiments/external_sources/physics/snapshots/pdg-2026-qcd.pdf",.text "sha256:c04c628d76b18610c5fa2a919c6081918a25b55fb971b6af5829f4ca2baa386f"),("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf",.text "sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("experiments/external_sources/physics/snapshots/pdg-2025-electroweak-model.pdf",.text "sha256:8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a")]),
 ("row_retention_policy",.text "all seven PDG QCD Table 9.1 rows and all three columns; all nine Figure 9.4 measurement classes and its full immutable figure; both exact multi-scale strong rows; all five current alpha(0) rows; all eleven current Delta-alpha rows; the direct-observation statement, published relation and explicit prior high-scale endpoint"),
 ("target_access_policy",.text "capability-closed prediction; release only after matching seal"),
 ("comparison_protocol",.text "exact rational interval ordering, complete-row and figure-class custody, opposite carrier-specific energy-direction control, non-promotion of formal convergence to measurement and hostile controls"),
 ("falsification_condition",.text "Reject if any of the seven PDG QCD Table 9.1 rows, nine Figure 9.4 measurement classes, exact low- and m_Z-scale strong-coupling rows, five current alpha(0) rows, eleven current hadronic Delta-alpha rows, published electromagnetic running relation, direct LEP observation or explicit prior Z-scale endpoint is omitted or altered; if the separated strong-coupling intervals do not decrease from 1.37 GeV to m_Z; if the explicit inverse electromagnetic endpoint intervals do not decrease from the Thomson limit to the Z scale; if a universal physical energy sign is imposed despite the sealed carrier-specific coordinates; if the exact Fold support successor, running-share increment, pair-gap shrinkage or finite tolerance witness fails; if the formal convergence prediction is falsely labelled a direct measurement; or if any target content enters before the prediction seal.")]

def frozenRelation : String := "The complete prime-sector ladder shares One-base binary support; each running share is the holding part of sector plus support, every share increases with support, every exact pair gap decreases, and every finite tolerance has a generated witness. Physical energy orientation is carrier-specific."

end SFT.Physics.RunningConvergencePrediction
