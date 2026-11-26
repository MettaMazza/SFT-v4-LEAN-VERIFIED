import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.ParallelMechanism
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure RetainedParallelPath where
 pathIdentity : HeldLabel
 sourceRow : PositiveCount
 mechanism : CompleteSequentialMechanism
 pathStatus : HeldLabel
def makePath (identity : LabelInput) (source : SequentialMechanism.CountInput) (mechanism : MechanismInput) (status : LabelInput) : Except String RetainedParallelPath := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-parallel-path" then pure l else throw "parallel composition requires a registered path identity"
  | .other=>throw "parallel composition requires a registered path identity"
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "parallel composition requires a positive source-row occurrence"
 let mechanism ← match mechanism with
  | .mechanism m=>pure m
  | .other=>throw "parallel composition requires a complete sequential path word"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-path-status" then pure l else throw "parallel composition retains favorable, weak, adverse or unresolved status"
  | .other=>throw "parallel composition retains favorable, weak, adverse or unresolved status"
 pure ⟨identity,source,mechanism,status⟩
inductive PathInput where
 | path (value : RetainedParallelPath)
 | other
structure CompleteParallelMechanism where
 reactionIdentity : HeldLabel
 commonInitialStateIdentity : HeldLabel
 orderedPaths : List RetainedParallelPath
def equalStateWord (a b : List HeldLabel) : Bool :=
 a.length==b.length && (a.zip b).all (fun (x,y)=>equalLabel x y)
def makeParallel (reaction initial : LabelInput) (paths : List PathInput) : Except String CompleteParallelMechanism := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "registered-reaction" then pure l else throw "parallel composition requires one registered reaction"
  | .other=>throw "parallel composition requires one registered reaction"
 let initial ← match initial with
  | .held l=>if Text.equal l.family "registered-mechanism-state" then pure l else throw "parallel composition requires one retained common initial state"
  | .other=>throw "parallel composition requires one retained common initial state"
 if paths.length<2 then throw "parallel composition requires at least two complete registered paths"
 let paths ← paths.mapM fun path=>match path with
  | .path p=>pure p
  | .other=>throw "parallel composition requires at least two complete registered paths"
 let identities := paths.map RetainedParallelPath.pathIdentity
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != paths.length then
  throw "parallel path identities must remain distinct"
 if !(paths.zipIdx.all fun (p,i)=>p.sourceRow.value==i+1) then throw "parallel paths require complete source order without a gap"
 let words ← paths.mapM fun path=>do
  if !equalLabel path.mechanism.reactionIdentity reaction then throw "parallel paths cannot combine different registered reactions"
  let first ← match path.mechanism.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
  if !equalLabel first.stateIdentity initial then throw "every parallel path must meet the common initial boundary"
  pure (path.mechanism.orderedStates.map RetainedMechanismState.stateIdentity)
 if (words.foldl (fun found word=>if found.any (equalStateWord word) then found else found++[word]) []).length != words.length then
  throw "duplicated state words are not distinct parallel paths"
 pure ⟨reaction,initial,paths⟩
structure ExactParallelComposition where
 reactionIdentity : HeldLabel
 commonInitialStateIdentity : HeldLabel
 orderedPaths : List RetainedParallelPath
 terminalStateWord : List HeldLabel
 pathCount : PositiveCount
 compositionIdentity : HeldLabel
inductive ParallelInput where
 | mechanism (value : CompleteParallelMechanism)
 | other
def forcedParallelMechanismComposition (input : ParallelInput) : Except String ExactParallelComposition := do
 let mechanism ← match input with
  | .mechanism m=>pure m
  | .other=>throw "parallel composition requires one complete parallel mechanism"
 let terminals ← mechanism.orderedPaths.mapM fun path=>match path.mechanism.orderedStates.getLast? with
  | some s=>pure s.stateIdentity
  | none=>throw "tuple index out of range"
 let count ← count mechanism.orderedPaths.length
 pure ⟨mechanism.reactionIdentity,mechanism.commonInitialStateIdentity,mechanism.orderedPaths,terminals,count,
  ⟨"exact-parallel-composition","every-path-state-edge-shared-boundary-condition-status-and-terminal-occurrence-retained",rfl,rfl⟩⟩
def equalMechanism (a b : CompleteSequentialMechanism) : Bool :=
 equalLabel a.reactionIdentity b.reactionIdentity && a.orderedStates.length==b.orderedStates.length &&
 (a.orderedStates.zip b.orderedStates).all (fun (x,y)=>equalState x y) &&
 a.orderedTransitions.length==b.orderedTransitions.length && (a.orderedTransitions.zip b.orderedTransitions).all (fun (x,y)=>equalTransition x y)
def equalPath (a b : RetainedParallelPath) : Bool :=
 equalLabel a.pathIdentity b.pathIdentity && a.sourceRow.value==b.sourceRow.value && equalMechanism a.mechanism b.mechanism && equalLabel a.pathStatus b.pathStatus
def appendParallelPathPreservesCompleteFamily (mechanism : CompleteParallelMechanism) (successor : RetainedParallelPath) : Except String Bool := do
 if successor.sourceRow.value != mechanism.orderedPaths.length+1 then throw "parallel successor must be the next complete source row"
 let prior ← forcedParallelMechanismComposition (.mechanism mechanism)
 let extended ← makeParallel (.held mechanism.reactionIdentity) (.held mechanism.commonInitialStateIdentity) ((mechanism.orderedPaths++[successor]).map PathInput.path)
 let result ← forcedParallelMechanismComposition (.mechanism extended)
 let retained := result.orderedPaths.take prior.orderedPaths.length
 pure (retained.length==prior.orderedPaths.length && (retained.zip prior.orderedPaths).all (fun (a,b)=>equalPath a b) &&
  equalStateWord (result.terminalStateWord.take prior.terminalStateWord.length) prior.terminalStateWord &&
  equalLabel result.commonInitialStateIdentity prior.commonInitialStateIdentity)
def witnessPath (name : String) (row : Nat) (labels : List String) : Except String RetainedParallelPath := do
 let states ← labels.zipIdx.mapM fun (label,i)=>witnessState label (i+1)
 let edges ← (states.zip (states.drop 1)).zipIdx.mapM fun ((a,b),i)=>do
  let identity ← heldLabel "registered-elementary-transition" (Text.intercalate "" [name,"-edge-",toString (i+1)])
  let occurrence ← count (i+1)
  let condition ← heldLabel "held-transition-condition" (Text.intercalate "" [name,"-boundary-",toString (i+1)])
  makeTransition (.held identity) (.count occurrence) (.held a.stateIdentity) (.held b.stateIdentity) (.held condition) (.held ⟨"held-transition-status","retained",rfl,rfl⟩)
 let mechanism ← makeMechanism (.held ⟨"registered-reaction","reaction-a",rfl,rfl⟩) (states.map StateInput.state) (edges.map TransitionInput.transition)
 let identity ← heldLabel "registered-parallel-path" name
 let row ← count row
 makePath (.held identity) (.count row) (.mechanism mechanism) (.held ⟨"held-path-status","retained",rfl,rfl⟩)
def base : Except String CompleteParallelMechanism := do
 let first ← witnessPath "path-one" 1 ["source-a","state-b","terminal-d"]
 let second ← witnessPath "path-two" 2 ["source-a","state-c","terminal-d"]
 makeParallel (.held ⟨"registered-reaction","reaction-a",rfl,rfl⟩) (.held ⟨"registered-mechanism-state","source-a",rfl,rfl⟩) [.path first,.path second]
def completeFamilyWitness : Except String Bool := do
 let result ← forcedParallelMechanismComposition (.mechanism (← base))
 pure (result.orderedPaths.length==2)
def commonSourceWitness : Except String Bool := do
 let result ← forcedParallelMechanismComposition (.mechanism (← base))
 pure (result.orderedPaths.all fun p=>match p.mechanism.orderedStates.head? with | some s=>equalLabel s.stateIdentity result.commonInitialStateIdentity | none=>false)
def sharedTerminalWitness : Except String Bool := do
 let result ← forcedParallelMechanismComposition (.mechanism (← base))
 pure (equalStateWord result.terminalStateWord [⟨"registered-mechanism-state","terminal-d",rfl,rfl⟩,⟨"registered-mechanism-state","terminal-d",rfl,rfl⟩])
def successorWitness : Except String Bool := do
 appendParallelPathPreservesCompleteFamily (← base) (← witnessPath "path-three" 3 ["source-a","state-e","state-f","terminal-d"])
theorem completeFamily : completeFamilyWitness=.ok true := rfl
theorem commonSource : commonSourceWitness=.ok true := rfl
theorem sharedTerminal : sharedTerminalWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.ParallelMechanism
