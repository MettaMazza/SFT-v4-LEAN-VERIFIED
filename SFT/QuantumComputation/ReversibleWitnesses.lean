import SFT.QuantumComputation.ReversibleCorrection
namespace SFT.QuantumComputation.ReversibleWitnesses
open SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleComposition
open SFT.QuantumComputation.ReversibleObservation
open SFT.QuantumComputation.ReversibleFaults

def cycle : List String := ["phase-held","phase-returned"]
def state : State := ⟨[(["held"],"phase-held"),(["returned"],"phase-held")],cycle⟩
def gate : Gate := ⟨[(["held"],["returned"]),(["returned"],["held"])],["phase-step"]⟩
theorem stateGenerated : completeSupport ["held","returned"] ["position-1"] cycle = .ok state := rfl
theorem gateGenerated : makeGate gate.wordMap gate.phaseSuccessors = .ok gate := rfl

def supportCheck : Bool := decide (support state = [["held"],["returned"]])
def phaseCheck : Bool := match phaseAction state ["phase-step"] with
  | .error _ => false
  | .ok result => match result.branches with
    | [] => false
    | first::_ => decide (first.2 = "phase-returned")
def compositionCheck : Bool := match compose state state with
  | .error _ => false
  | .ok result => decide (result.branches.length = 4)
def mergeCheck : Bool := match predecessorMerge state [(["held"],"image"),(["returned"],"image")] with
  | .error _ => false
  | .ok result => match result with
    | [] => false
    | first::_ => decide (first.2.length = 2)
def factorCheck : Bool := match isFactorable [("held","held"),("returned","returned")] with
  | .error _ => false
  | .ok result => !result
def observationCheck : Bool := match observe state [(["held"],"left"),(["returned"],"right")] "left" with
  | .error _ => false
  | .ok (measured,record) => decide (support measured = [["held"]]) && decide (record.length = 2)
def inverseCheck : Bool := match applyGate state gate with
  | .error _ => false
  | .ok transformed => match applyGate transformed (inverse gate) true with
    | .error _ => false
    | .ok restored => decide (restored.branches = state.branches) && decide (restored.phaseCycle = state.phaseCycle)
def faultsCheck : Bool := [["fault-1"],["fault-1","fault-2"],["fault-1","fault-2","fault-3"]].all
  (fun trace => match exhaustiveFaultCensus "held" trace with
    | .error _ => false
    | .ok rows => rows.all (fun row => decide (row.2 = "held")))
def checks : List Bool := [supportCheck,phaseCheck,compositionCheck,mergeCheck,factorCheck,observationCheck,inverseCheck,faultsCheck]
theorem allWitnessesPassed : checks = [true,true,true,true,true,true,true,true] := rfl

def operationalWitnesses (claimId : String) : List (String × String × Bool) :=
  checks.zipIdx.map (fun (passed,index) =>
    (SFT.Host.Text.append "quantum-witness-" (toString (index+1)),
     SFT.Host.Text.append (SFT.Host.Text.append (SFT.Host.Text.append "exact Fold quantum operational witness " (toString (index+1))) " for ") claimId,passed))
end SFT.QuantumComputation.ReversibleWitnesses
