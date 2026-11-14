import SFT.Physics.DeuteronDinucleonProofs
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.DeuteronPrediction
open SFT.Host SFT.Host.Canonical DeuteronDinucleon LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (q : Rat) : Except String CapabilityValues.Value := do
 if !zero.blt q then throw "formal deuteron input must remain exact and positive"
 let n ← CapabilityValues.count q.num.toNat
 let d ← CapabilityValues.count q.den
 pure (.ratio n d)
def countValue (n : Nat) : Except String CapabilityValues.Value := do pure (.count (← CapabilityValues.count n))
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let spin ← compositeSpinCertificate
 let outcomes ← bindingOutcomes
 let preservingRemainder ← match spin.preservingRemainder with
  | some q => .ok q | none => .error "formal deuteron input must remain exact and positive"
 let protonPair ← channelByPair "proton-proton"
 let charge ← match protonPair.chargePath with
  | some q => .ok q | none => .error "formal deuteron input must remain exact and positive"
 let pn ← match outcomes.find? (fun p => Text.equal p.1 "proton-neutron") with
  | some p => .ok p.2 | none => .error "KeyError"
 let pp ← match outcomes.find? (fun p => Text.equal p.1 "proton-proton") with
  | some p => .ok p.2 | none => .error "KeyError"
 let nn ← match outcomes.find? (fun p => Text.equal p.1 "neutron-neutron") with
  | some p => .ok p.2 | none => .error "KeyError"
 pure [("preserving_support",← positiveRatio spin.preservingSupport),("alternating_support",← positiveRatio spin.alternatingSupport),("residual_boundary",← positiveRatio spin.residualBoundary),("preserving_remainder",← positiveRatio preservingRemainder),("preserving_readings",← countValue spin.preservingReadingCount),("alternating_readings",← countValue spin.alternatingReadingCount),("composite_spin",← positiveRatio spin.preservingCompositeSpin),("alternating_remainder",.label (← CapabilityValues.heldLabel "structural-absence" "empty-form")),("pn_spin_hand",.label (← CapabilityValues.heldLabel "spin-exchange" preserving)),("pp_spin_hand",.label (← CapabilityValues.heldLabel "spin-exchange" alternating)),("nn_spin_hand",.label (← CapabilityValues.heldLabel "spin-exchange" alternating)),("pn_binding",.label (← CapabilityValues.heldLabel "binding-outcome" (if pn then "bound" else "unbound"))),("pp_binding",.label (← CapabilityValues.heldLabel "binding-outcome" (if pp then "bound" else "unbound"))),("nn_binding",.label (← CapabilityValues.heldLabel "binding-outcome" (if nn then "bound" else "unbound"))),("pp_charge_path",← positiveRatio charge)]
def experimentId : String := "SFT-EXP-PHYS-NUCLEAR-DEUTERON-DINUCLEON-TERMINAL-006"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "deuteron prediction has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "deuteron prediction has the wrong exact Fold shape"
 | .count _ => .error "deuteron prediction has the wrong exact Fold shape"
 | .ratio _ _ => .error "deuteron prediction has the wrong exact Fold shape"
 | .label _ => .error "deuteron prediction has the wrong exact Fold shape"
 | .pair _ _ => .error "deuteron prediction has the wrong exact Fold shape"
 | .table _ => .error "deuteron prediction has the wrong exact Fold shape"
end SFT.Physics.DeuteronPrediction
