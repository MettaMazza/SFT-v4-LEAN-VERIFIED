import SFT.Physics.CapabilityValues
import SFT.QuantumComputation.ClassicalCorrespondence
import SFT.QuantumComputation.ReversibleObservation
namespace SFT.Chemistry.MolecularCorrespondence
open SFT.Host
open SFT.Physics.CapabilityValues (HeldLabel heldLabel count)
open SFT.Mathematics.DiscreteObjects
open SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleObservation
set_option maxHeartbeats 100000000

-- V3 classical_quantum_correspondence_law_v1.py:MolecularProcess.
structure Process where
 carrier : HeldLabel
 transitionRows : List (String × String)
 transitionLaw : HeldLabel

def construct (carrier : HeldLabel) (rows : List (String × String))
 (law : HeldLabel) : Except String Process := do
 if !Text.equal carrier.family "molecular-carrier" then
  throw "molecular process lost its chemical carrier"
 if !Text.equal law.family "admitted-chemical-transition-law" then
  throw "molecular process lost its admitted Chemistry law"
 if rows.isEmpty then throw "molecular correspondence requires generated support"
 if !distinct (rows.map Prod.fst) || !distinct (rows.map Prod.snd) then
  throw "molecular transition must be a finite bijection"
 return ⟨carrier,rows,law⟩

def classicalRow (law : HeldLabel) (row : String × String) : String × String × List String :=
 (row.1,row.2,["classical-input",row.1,"chemical-law",law.label,"chemical-result",row.2])
def classicalRows (process : Process) : List (String × String × List String) :=
 process.transitionRows.map (classicalRow process.transitionLaw)
def initialBranches (rows : List (String × String)) : List (Word × String) :=
 rows.map (fun row => ([row.1],"phase-held"))
def gateRows (rows : List (String × String)) : List (Word × Word) :=
 rows.map (fun row => ([row.1],[row.2]))
def phaseCycle : List String := ["phase-held","phase-returned"]
def initialState (process : Process) : Except String State :=
 makeState (initialBranches process.transitionRows) phaseCycle
def processGate (process : Process) : Except String Gate :=
 makeGate (gateRows process.transitionRows) ["phase-successor"]
-- All gate words constructed above are singletons. The pattern decomposition
-- preserves V3's tuple unpacking on precisely those generated rows.
def decodeRows (rows : List (Word × Word)) : List (String × String) :=
 rows.flatMap (fun row => match row.1 with
  | [] => []
  | source::sources => match sources with
    | _::_ => []
    | [] => match row.2 with
      | [] => []
      | target::targets => match targets with
        | [] => [(source,target)]
        | _::_ => [])
def observationMap (words : List Word) : Classification :=
 words.flatMap (fun word => match word with
  | [] => []
  | label::rest => match rest with
    | [] => [(word,label)]
    | _::_ => [])
def measurementRecords (state : State) : Except String (List (List Record)) :=
 state.branches.mapM' fun branch => do
  match branch.1 with
  | [] => throw "molecular execution did not retain singleton words"
  | label::rest => match rest with
    | [] => return (← observe state (observationMap (support state)) label).2
    | _::_ => throw "molecular execution did not retain singleton words"

structure Execution where
 initial : State
 transformed : State
 decodedRows : List (String × String)
 records : List (List Record)
 inverseRestores : Bool

def quantumExecution (process : Process) : Except String Execution := do
 let initial ← initialState process
 let gate ← processGate process
 let transformed ← applyGate initial gate
 let records ← measurementRecords transformed
 let restored ← applyGate transformed (inverse gate) true
 return ⟨initial,transformed,decodeRows gate.wordMap,records,
   decide (restored.branches = initial.branches ∧ restored.phaseCycle = initial.phaseCycle)⟩

def stringsValue (xs : List String) : SFT.Host.Canonical.Value := .array (xs.map .text)
def branchValue (row : Word × String) : SFT.Host.Canonical.Value :=
 .array [stringsValue row.1,.text row.2]
def rowValue (row : String × String) : SFT.Host.Canonical.Value := .array [.text row.1,.text row.2]
def classicalValue (row : String × String × List String) : SFT.Host.Canonical.Value :=
 .array [.text row.1,.text row.2.1,stringsValue row.2.2]
def recordValue (record : List Record) : SFT.Host.Canonical.Value :=
 .array (record.map (fun row => .array [stringsValue row.1.1,.text row.1.2,.text row.2]))
def countValue (n : Nat) : Except String SFT.Host.Canonical.Value := do
 let positive ← count n
 return SFT.Physics.CapabilityValues.canonical (.count positive)

-- On an admitted Process both dictionaries have distinct keys; equality of
-- the ordered decoded rows is exactly equality of their generated dictionaries.
def branchwiseCertificate (process : Process) : Except String SFT.Host.Canonical.Value := do
 let classical := classicalRows process
 let quantum ← quantumExecution process
 let complete := quantum.records.all (fun record => record.length == process.transitionRows.length)
 let sameMap := classical.map (fun row => (row.1,row.2.1)) == quantum.decodedRows
 let ledger := SFT.Host.Canonical.Value.object [
  ("input_classes",← countValue process.transitionRows.length),
  ("classical_transition_rows",← countValue classical.length),
  ("quantum_branch_rows",← countValue quantum.decodedRows.length),
  ("reversible_gate_count",← countValue 1),
  ("observation_records",← countValue quantum.records.length)]
 return .object [("carrier",.text process.carrier.label),
  ("transition_law",.text process.transitionLaw.label),
  ("classical_rows",.array (classical.map classicalValue)),
  ("quantum_initial_branches",.array (quantum.initial.branches.map branchValue)),
  ("quantum_transformed_branches",.array (quantum.transformed.branches.map branchValue)),
  ("quantum_decoded_rows",.array (quantum.decodedRows.map rowValue)),
  ("measurement_records",.array (quantum.records.map recordValue)),
  ("inverse_restores",.boolean quantum.inverseRestores),
  ("complete_records",.boolean complete),("resource_ledger",ledger),
  ("passed",.boolean (sameMap && quantum.inverseRestores && complete))]

theorem classicalRowsNil (carrier law : HeldLabel) : classicalRows ⟨carrier,[],law⟩ = [] := rfl
theorem classicalRowsCons (carrier law : HeldLabel) (row : String × String)
 (rest : List (String × String)) :
 classicalRows ⟨carrier,row::rest,law⟩ = classicalRow law row :: classicalRows ⟨carrier,rest,law⟩ := rfl

theorem decodedGateRows (rows : List (String × String)) : decodeRows (gateRows rows) = rows := by
 induction rows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row) ih

theorem classicalDecodedRows (law : HeldLabel) (rows : List (String × String)) :
 (rows.map (classicalRow law)).map (fun row => (row.1,row.2.1)) = rows := by
 induction rows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons row) ih

theorem completeDecodedCorrespondence (process : Process) :
 (classicalRows process).map (fun row => (row.1,row.2.1)) = decodeRows (gateRows process.transitionRows) :=
 (classicalDecodedRows process.transitionLaw process.transitionRows).trans
  (decodedGateRows process.transitionRows).symm

theorem classicalResourceCount (process : Process) :
 (classicalRows process).length = process.transitionRows.length :=
 SFT.Foundation.CommonRefinement.mapLength (classicalRow process.transitionLaw) process.transitionRows

theorem decodedResourceCount (process : Process) :
 (decodeRows (gateRows process.transitionRows)).length = process.transitionRows.length :=
 congrArg List.length (decodedGateRows process.transitionRows)

-- These are the existing source-domain quantum results used at the two calls
-- in quantumExecution, with no new equilibrium, convergence or model premise.
theorem inverseExecution (initial transformed : State) (gate : Gate)
 (stateAccepted : makeState initial.branches initial.phaseCycle = .ok initial)
 (gateAccepted : makeGate gate.wordMap gate.phaseSuccessors = .ok gate)
 (forward : applyGate initial gate false = .ok transformed) :
 applyGate transformed (inverse gate) true = .ok initial :=
 applicationInverse initial transformed gate stateAccepted gateAccepted forward

theorem observationRetainsEveryBranch (state selected : State) (mapping : Classification)
 (label : String) (record : List Record)
 (accepted : observe state mapping label = .ok (selected,record)) :
 record.length = state.branches.length :=
 recordCount mapping state.branches record (observationSource state selected mapping label record accepted).2.1

def registeredProcess : Except String Process := do
 construct (← heldLabel "molecular-carrier" "registered-two-state-molecule")
  [("state-held","state-returned"),("state-returned","state-held")]
  (← heldLabel "admitted-chemical-transition-law" "SFT-CHEM-MOLECULAR-STATE-TRANSITION-009")
def registeredCertificate : Except String SFT.Host.Canonical.Value := do
 branchwiseCertificate (← registeredProcess)
def branchwiseWitness : Except String Bool := do
 let process ← registeredProcess
 let quantum ← quantumExecution process
 return (classicalRows process).map (fun row => (row.1,row.2.1)) == quantum.decodedRows &&
  quantum.inverseRestores && quantum.records.all (fun record => record.length == process.transitionRows.length)
def inverseWitness : Except String Bool := do
 return (← quantumExecution (← registeredProcess)).inverseRestores
def recordWitness : Except String Bool := do
 let process ← registeredProcess
 return (← quantumExecution process).records.all (fun record => record.length == process.transitionRows.length)
theorem branchwisePassed : branchwiseWitness = .ok true := rfl
theorem inversePassed : inverseWitness = .ok true := rfl
theorem recordsPassed : recordWitness = .ok true := rfl
end SFT.Chemistry.MolecularCorrespondence
