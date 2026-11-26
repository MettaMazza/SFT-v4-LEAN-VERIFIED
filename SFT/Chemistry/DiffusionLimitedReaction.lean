import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.DiffusionLimitedReaction
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure ExactPositiveCompletionRatio where
 value : Rat
inductive RatioInput where
 | fraction (value : Rat)
 | other
def makeExactPositiveCompletionRatio (input : RatioInput) : Except String ExactPositiveCompletionRatio := do
 let value ← match input with
  | .fraction r=>pure r
  | .other=>throw "completion relation must be exact and positive"
 if value.num ≤ 0 then throw "completion relation must be exact and positive"
 pure ⟨value⟩
def ratioFromCounts (cycles interval : SequentialMechanism.CountInput) : Except String ExactPositiveCompletionRatio := do
 let cycles ← match cycles with
  | .count n=>pure n
  | .other=>throw "diffusion-limited completion relation requires exact positive counts"
 let interval ← match interval with
  | .count n=>pure n
  | .other=>throw "diffusion-limited completion relation requires exact positive counts"
 makeExactPositiveCompletionRatio (.fraction (LeptonIntervals.normalize (.ofNat cycles.value) interval.value interval.positive))
structure RetainedTransportState where
 stateIdentity : HeldLabel
 transportedIdentity : HeldLabel
 pathPosition : PositiveCount
 stateStatus : HeldLabel
def makeState (identity transported : LabelInput) (position : SequentialMechanism.CountInput) (status : LabelInput) : Except String RetainedTransportState := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-transport-reaction-state" then pure l else throw "transport state identity must remain registered"
  | .other=>throw "transport state identity must remain registered"
 let transported ← match transported with
  | .held l=>if Text.equal l.family "held-transported-reactant" then pure l else throw "transported reactant identity must remain held"
  | .other=>throw "transported reactant identity must remain held"
 let position ← match position with
  | .count v=>pure v
  | .other=>throw "transport path position must be positive"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-transport-state-status" then pure l else throw "transport state status must remain held"
  | .other=>throw "transport state status must remain held"
 pure ⟨identity,transported,position,status⟩
structure RetainedTransportTransition where
 transitionIdentity : HeldLabel
 entryState : HeldLabel
 exitState : HeldLabel
 conditionBoundary : HeldLabel
 evidenceStatus : HeldLabel
def makeTransition (identity entry exit condition status : LabelInput) : Except String RetainedTransportTransition := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-transport-transition" then pure l else throw "transport transition identity must remain registered"
  | .other=>throw "transport transition identity must remain registered"
 let entry ← match entry with
  | .held l=>if Text.equal l.family "registered-transport-reaction-state" then pure l else throw "transport transition requires distinct registered states"
  | .other=>throw "transport transition requires distinct registered states"
 let exit ← match exit with
  | .held l=>if Text.equal l.family "registered-transport-reaction-state" then pure l else throw "transport transition requires distinct registered states"
  | .other=>throw "transport transition requires distinct registered states"
 if equalLabel entry exit then throw "transport transition requires distinct registered states"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-transport-reaction-condition" then pure l else throw "transport condition boundary must remain held"
  | .other=>throw "transport condition boundary must remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-transport-transition-status" then pure l else throw "transport evidence status must remain held"
  | .other=>throw "transport evidence status must remain held"
 pure ⟨identity,entry,exit,condition,status⟩
inductive TransportStateInput where
 | state (value : RetainedTransportState)
 | other
inductive TransportTransitionInput where
 | transition (value : RetainedTransportTransition)
 | other
structure CompleteFiniteTransportPath where
 pathIdentity : HeldLabel
 orderedStates : List RetainedTransportState
 orderedTransitions : List RetainedTransportTransition
def makePath (identity : LabelInput) (states : List TransportStateInput) (transitions : List TransportTransitionInput) : Except String CompleteFiniteTransportPath := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-finite-transport-path" then pure l else throw "finite transport path identity must remain registered"
  | .other=>throw "finite transport path identity must remain registered"
 if states.length<2 || transitions.length != states.length-1 then throw "finite transport path requires every state and adjacent transition"
 let states ← states.mapM fun s=>match s with
  | .state s=>pure s
  | .other=>throw "transport path contains an unregistered state"
 let transitions ← transitions.mapM fun t=>match t with
  | .transition t=>pure t
  | .other=>throw "transport path contains an unregistered transition"
 if !(states.zipIdx.all fun (s,i)=>s.pathPosition.value==i+1) then throw "transport path positions must be complete and gap-free"
 let first ← match states.head? with | some s=>pure s | none=>throw "tuple index out of range"
 if states.any (fun s=> !equalLabel s.transportedIdentity first.transportedIdentity) then throw "the same reactant identity must be retained through transport"
 let firstEdge ← match transitions.head? with | some t=>pure t | none=>throw "tuple index out of range"
 let _ ← transitions.zipIdx.mapM fun (edge,i)=>do
  let entry ← match (states.drop i).head? with | some s=>pure s | none=>throw "tuple index out of range"
  let exit ← match (states.drop (i+1)).head? with | some s=>pure s | none=>throw "tuple index out of range"
  if !equalLabel edge.entryState entry.stateIdentity || !equalLabel edge.exitState exit.stateIdentity then
   throw "each transport transition must join its adjacent retained states"
  if !equalLabel edge.conditionBoundary firstEdge.conditionBoundary then throw "one transport path requires one exact held condition boundary"
  pure ()
 pure ⟨identity,states,transitions⟩
def exitState (path : CompleteFiniteTransportPath) : Except String HeldLabel :=
 match path.orderedStates.getLast? with | some s=>pure s.stateIdentity | none=>throw "tuple index out of range"
structure RetainedReactionOccurrence where
 reactionIdentity : HeldLabel
 encounterEntryState : HeldLabel
 productState : HeldLabel
 conditionBoundary : HeldLabel
 evidenceStatus : HeldLabel
def makeReaction (identity encounter product condition status : LabelInput) : Except String RetainedReactionOccurrence := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-reaction-occurrence" then pure l else throw "reaction occurrence must remain registered"
  | .other=>throw "reaction occurrence must remain registered"
 let encounter ← match encounter with
  | .held l=>if Text.equal l.family "registered-transport-reaction-state" then pure l else throw "reaction occurrence requires distinct encounter and product states"
  | .other=>throw "reaction occurrence requires distinct encounter and product states"
 let product ← match product with
  | .held l=>if Text.equal l.family "registered-transport-reaction-state" then pure l else throw "reaction occurrence requires distinct encounter and product states"
  | .other=>throw "reaction occurrence requires distinct encounter and product states"
 if equalLabel encounter product then throw "reaction occurrence requires distinct encounter and product states"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-transport-reaction-condition" then pure l else throw "reaction condition boundary must remain held"
  | .other=>throw "reaction condition boundary must remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-reaction-status" then pure l else throw "reaction evidence status must remain held"
  | .other=>throw "reaction evidence status must remain held"
 pure ⟨identity,encounter,product,condition,status⟩
inductive PathInput where
 | path (value : CompleteFiniteTransportPath)
 | other
inductive ReactionInput where
 | reaction (value : RetainedReactionOccurrence)
 | other
structure ExactDiffusionLimitedReactionBoundary where
 transportPathIdentity : HeldLabel
 transportedIdentity : HeldLabel
 completeTransportWord : List RetainedTransportTransition
 encounterState : HeldLabel
 reactionOccurrence : RetainedReactionOccurrence
 completedReactionCount : PositiveCount
 boundaryIdentity : HeldLabel
def forcedDiffusionLimitedReactionBoundary (path : PathInput) (reaction : ReactionInput) : Except String ExactDiffusionLimitedReactionBoundary := do
 let path ← match path with
  | .path p=>pure p
  | .other=>throw "diffusion-limited boundary requires complete transport and reaction objects"
 let reaction ← match reaction with
  | .reaction q=>pure q
  | .other=>throw "diffusion-limited boundary requires complete transport and reaction objects"
 let exit ← exitState path
 if !equalLabel exit reaction.encounterEntryState then throw "transport exit must be the exact reaction encounter entry"
 let last ← match path.orderedTransitions.getLast? with | some e=>pure e | none=>throw "tuple index out of range"
 if !equalLabel last.conditionBoundary reaction.conditionBoundary then throw "transport and reaction must share the exact held condition boundary"
 let first ← match path.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
 pure ⟨path.pathIdentity,first.transportedIdentity,path.orderedTransitions,exit,reaction,⟨1,by decide⟩,
  ⟨"exact-diffusion-limited-reaction-boundary","reaction-occurrence-is-admissible-only-after-complete-finite-transport-word-closes-on-encounter",rfl,rfl⟩⟩
structure RegisteredTransportReactionOccurrence where
 sourceOccurrence : PositiveCount
 transportPath : CompleteFiniteTransportPath
 reaction : RetainedReactionOccurrence
 observationParts : PositiveCount
def makeOccurrence (source : SequentialMechanism.CountInput) (path : PathInput) (reaction : ReactionInput) (parts : SequentialMechanism.CountInput) : Except String RegisteredTransportReactionOccurrence := do
 let source ← match source with
  | .count v=>pure v
  | .other=>throw "transport-reaction source occurrence must be positive"
 let _ ← forcedDiffusionLimitedReactionBoundary path reaction
 let parts ← match parts with
  | .count v=>pure v
  | .other=>throw "transport-reaction observation interval must be positive"
 let path ← match path with | .path p=>pure p | .other=>throw "diffusion-limited boundary requires complete transport and reaction objects"
 let reaction ← match reaction with | .reaction q=>pure q | .other=>throw "diffusion-limited boundary requires complete transport and reaction objects"
 pure ⟨source,path,reaction,parts⟩
inductive OccurrenceInput where
 | occurrence (value : RegisteredTransportReactionOccurrence)
 | other
structure CompleteTransportReactionFamily where
 orderedOccurrences : List RegisteredTransportReactionOccurrence
def makeFamily (occurrences : List OccurrenceInput) : Except String CompleteTransportReactionFamily := do
 if occurrences.isEmpty then throw "transport-reaction family requires at least one complete occurrence"
 let occurrences ← occurrences.mapM fun row=>match row with
  | .occurrence o=>pure o
  | .other=>throw "transport-reaction family requires at least one complete occurrence"
 if !(occurrences.zipIdx.all fun (o,i)=>o.sourceOccurrence.value==i+1) then throw "transport-reaction occurrences must be complete and gap-free"
 pure ⟨occurrences⟩
def equalTransition (a b : RetainedTransportTransition) : Bool :=
 equalLabel a.transitionIdentity b.transitionIdentity && equalLabel a.entryState b.entryState && equalLabel a.exitState b.exitState && equalLabel a.conditionBoundary b.conditionBoundary && equalLabel a.evidenceStatus b.evidenceStatus
def equalReaction (a b : RetainedReactionOccurrence) : Bool :=
 equalLabel a.reactionIdentity b.reactionIdentity && equalLabel a.encounterEntryState b.encounterEntryState && equalLabel a.productState b.productState && equalLabel a.conditionBoundary b.conditionBoundary && equalLabel a.evidenceStatus b.evidenceStatus
def equalBoundary (a b : ExactDiffusionLimitedReactionBoundary) : Bool :=
 equalLabel a.transportPathIdentity b.transportPathIdentity && equalLabel a.transportedIdentity b.transportedIdentity &&
 a.completeTransportWord.length==b.completeTransportWord.length && (a.completeTransportWord.zip b.completeTransportWord).all (fun (x,y)=>equalTransition x y) &&
 equalLabel a.encounterState b.encounterState && equalReaction a.reactionOccurrence b.reactionOccurrence &&
 a.completedReactionCount.value==b.completedReactionCount.value && equalLabel a.boundaryIdentity b.boundaryIdentity
def appendTransportReactionPreservesCompleteFamily (family : CompleteTransportReactionFamily) (successor : RegisteredTransportReactionOccurrence) : Except String Bool := do
 if successor.sourceOccurrence.value != family.orderedOccurrences.length+1 then throw "transport-reaction successor must be the next positive occurrence"
 let prior ← family.orderedOccurrences.mapM fun row=>forcedDiffusionLimitedReactionBoundary (.path row.transportPath) (.reaction row.reaction)
 let extended ← makeFamily ((family.orderedOccurrences++[successor]).map OccurrenceInput.occurrence)
 let results ← extended.orderedOccurrences.mapM fun row=>forcedDiffusionLimitedReactionBoundary (.path row.transportPath) (.reaction row.reaction)
 let n ← count extended.orderedOccurrences.length
 let parts ← count (extended.orderedOccurrences.foldl (fun n row=>n+row.observationParts.value) 0)
 let _ ← ratioFromCounts (.count n) (.count parts)
 let retained := results.take prior.length
 pure (retained.length==prior.length && (retained.zip prior).all (fun (a,b)=>equalBoundary a b) && results.length==prior.length+1)
def witnessPath (label : String) (transported : String := "reactant-a") : Except String CompleteFiniteTransportPath := do
 let states ← (List.range 4).mapM fun i=>do
  makeState (.held (← heldLabel "registered-transport-reaction-state" (Text.intercalate "" [label,"-state-",toString (i+1)])))
   (.held (← heldLabel "held-transported-reactant" transported)) (.count (← count (i+1))) (.held ⟨"held-transport-state-status","retained",rfl,rfl⟩)
 let edges ← (states.zip (states.drop 1)).zipIdx.mapM fun ((entry,exit),i)=>do
  makeTransition (.held (← heldLabel "registered-transport-transition" (Text.intercalate "" [label,"-edge-",toString (i+1)])))
   (.held entry.stateIdentity) (.held exit.stateIdentity) (.held ⟨"held-transport-reaction-condition","held-condition",rfl,rfl⟩)
   (.held ⟨"held-transport-transition-status","retained",rfl,rfl⟩)
 makePath (.held (← heldLabel "registered-finite-transport-path" label)) (states.map TransportStateInput.state) (edges.map TransportTransitionInput.transition)
def witnessReaction (path : CompleteFiniteTransportPath) (label : String := "reaction-a") : Except String RetainedReactionOccurrence := do
 let last ← match path.orderedTransitions.getLast? with | some e=>pure e | none=>throw "tuple index out of range"
 makeReaction (.held (← heldLabel "registered-reaction-occurrence" label)) (.held (← exitState path))
  (.held (← heldLabel "registered-transport-reaction-state" (Text.append label "-product"))) (.held last.conditionBoundary) (.held ⟨"held-reaction-status","retained",rfl,rfl⟩)
def base : Except String CompleteFiniteTransportPath := witnessPath "path-a"
def completePathWitness : Except String Bool := do
 let path ← base
 let result ← forcedDiffusionLimitedReactionBoundary (.path path) (.reaction (← witnessReaction path))
 pure (result.completeTransportWord.length==path.orderedStates.length-1)
def exactBoundaryWitness : Except String Bool := do
 let path ← base
 let reaction ← witnessReaction path
 let result ← forcedDiffusionLimitedReactionBoundary (.path path) (.reaction reaction)
 pure (equalLabel result.encounterState reaction.encounterEntryState)
def completionRelationWitness : Except String Bool := do
 let r ← ratioFromCounts (.count ⟨3,by decide⟩) (.count ⟨2,by decide⟩)
 pure (@decide (r.value.num=3) (Int.decEq _ _) && r.value.den==2)
def successorWitness : Except String Bool := do
 let path ← base
 let prior ← makeOccurrence (.count ⟨1,by decide⟩) (.path path) (.reaction (← witnessReaction path)) (.count ⟨7,by decide⟩)
 let family ← makeFamily [.occurrence prior]
 let next ← witnessPath "path-b" "reactant-b"
 let successor ← makeOccurrence (.count ⟨2,by decide⟩) (.path next) (.reaction (← witnessReaction next "reaction-b")) (.count ⟨5,by decide⟩)
 appendTransportReactionPreservesCompleteFamily family successor
theorem completePath : completePathWitness=.ok true := rfl
theorem exactBoundary : exactBoundaryWitness=.ok true := rfl
theorem completionRelation : completionRelationWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.DiffusionLimitedReaction
