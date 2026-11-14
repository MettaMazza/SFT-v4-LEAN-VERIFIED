import SFT.Physics.OddLatticeAllRegionCertificate
import SFT.Physics.CapabilityDocuments
import SFT.Physics.CapabilityExecution
namespace SFT.Physics.OddLatticePrediction
open SFT.Host SFT.Host.Canonical OddLatticeAllRegionCertificate LeptonIntervals
set_option maxRecDepth 20000
def positiveRatio (value : Int) : Except String CapabilityValues.Value := do
 if value < 1 then throw "formal prediction input must be positive"
 let n ← CapabilityValues.count value.toNat
 let d ← CapabilityValues.count 1
 pure (.ratio n d)
def formalPredictionInputs : Except String (List (String × CapabilityValues.Value)) := do
 let c ← formalCertificate
 match c.certificates with
 | [] => throw "IndexError"
 | first::_ =>
  match first.baseVector with
  | [] => throw "IndexError"
  | [_] => throw "IndexError"
  | a::b::_ => pure [
   ("sample_member_count",← positiveRatio first.permutation.memberCount),
   ("sample_region_count",← positiveRatio (.ofNat first.baseVector.length)),
   ("sample_first_region_count",← positiveRatio (.ofNat a)),
   ("sample_second_region_count",← positiveRatio (.ofNat b)),
   ("lattice_relation",.label (← CapabilityValues.heldLabel "odd-lattice" "complete-positive-odd-support")),
   ("Fold_relation",.label (← CapabilityValues.heldLabel "odd-lattice-Fold" "binary-residue-permutation")),
   ("observation_relation",.label (← CapabilityValues.heldLabel "odd-lattice-observation" "complete-positive-region-vector")),
   ("depth_relation",.label (← CapabilityValues.heldLabel "odd-lattice-depth" "every-positive-successor-invariant")),
   ("coverage_relation",.label (← CapabilityValues.heldLabel "odd-lattice-coverage" "all-regions-occupied-when-regions-do-not-exceed-members"))]
def experimentId : String := "SFT-EXP-PHYS-ODD-LATTICE-ALL-REGION-OCCUPANCY-TERMINAL-007"
def predictionProgram : Except String CapabilityAdmission.Program := do
 let keys := (← formalPredictionInputs).map Prod.fst
 pure ⟨Text.append experimentId "-exact-prediction",keys.map (fun key => ⟨.input,key,[key]⟩) ++ [⟨.word,"prediction",keys⟩,⟨.emit,"",["prediction"]⟩]⟩
def predictionProgramDocument : Except String Value := do
 let program ← predictionProgram
 pure (.object [("schema",.text "sft-v3-fold-program/1"),("program_id",.text program.programId),("instructions",.array (program.instructions.map CapabilityExecution.canonicalInstruction))])
def outputMapping (output : CapabilityValues.Value) (orderedKeys : List String) : Except String (List (String × CapabilityValues.Value)) :=
 match output with
 | .word cells => if cells.length != orderedKeys.length then .error "odd-lattice prediction has the wrong exact Fold shape" else .ok (orderedKeys.zip cells)
 | .emptyOne _ => .error "odd-lattice prediction has the wrong exact Fold shape"
 | .count _ => .error "odd-lattice prediction has the wrong exact Fold shape"
 | .ratio _ _ => .error "odd-lattice prediction has the wrong exact Fold shape"
 | .label _ => .error "odd-lattice prediction has the wrong exact Fold shape"
 | .pair _ _ => .error "odd-lattice prediction has the wrong exact Fold shape"
 | .table _ => .error "odd-lattice prediction has the wrong exact Fold shape"
end SFT.Physics.OddLatticePrediction
