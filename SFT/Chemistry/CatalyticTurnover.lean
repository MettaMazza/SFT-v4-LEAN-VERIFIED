import SFT.Chemistry.SequentialMechanism
namespace SFT.Chemistry.CatalyticTurnover
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
open SequentialMechanism
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure ExactPositiveRatio where
 value : Rat
inductive RatioInput where
 | fraction (value : Rat)
 | other
def makeExactPositiveRatio (input : RatioInput) : Except String ExactPositiveRatio := do
 let value ← match input with
  | .fraction r=>pure r
  | .other=>throw "cycle frequency must be an exact positive whole/fractional relation"
 if value.num ≤ 0 then throw "cycle frequency must be an exact positive whole/fractional relation"
 pure ⟨value⟩
def ratioFromCounts (cycles interval : SequentialMechanism.CountInput) : Except String ExactPositiveRatio := do
 let cycles ← match cycles with
  | .count n=>pure n
  | .other=>throw "cycle frequency requires two exact positive counts"
 let interval ← match interval with
  | .count n=>pure n
  | .other=>throw "cycle frequency requires two exact positive counts"
 makeExactPositiveRatio (.fraction (LeptonIntervals.normalize (.ofNat cycles.value) interval.value interval.positive))
structure RetainedCatalystState where
 stateIdentity : HeldLabel
 catalystIdentity : HeldLabel
 cyclePosition : PositiveCount
 observationStatus : HeldLabel
def makeState (identity catalyst : LabelInput) (position : SequentialMechanism.CountInput) (status : LabelInput) : Except String RetainedCatalystState := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-catalytic-state" then pure l else throw "catalytic state identity must remain registered"
  | .other=>throw "catalytic state identity must remain registered"
 let catalyst ← match catalyst with
  | .held l=>if Text.equal l.family "held-catalyst-identity" then pure l else throw "catalyst identity must remain held through the cycle"
  | .other=>throw "catalyst identity must remain held through the cycle"
 let position ← match position with
  | .count n=>pure n
  | .other=>throw "catalytic state position must be a positive occurrence"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-catalytic-state-status" then pure l else throw "observed, structural and unresolved state status must remain held"
  | .other=>throw "observed, structural and unresolved state status must remain held"
 pure ⟨identity,catalyst,position,status⟩
structure RetainedCatalyticTransition where
 transitionIdentity : HeldLabel
 entryState : HeldLabel
 exitState : HeldLabel
 processIdentity : HeldLabel
 conditionBoundary : HeldLabel
 evidenceStatus : HeldLabel
def makeTransition (identity entry exit process condition status : LabelInput) : Except String RetainedCatalyticTransition := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-catalytic-transition" then pure l else throw "catalytic transition identity must remain registered"
  | .other=>throw "catalytic transition identity must remain registered"
 let entry ← match entry with
  | .held l=>if Text.equal l.family "registered-catalytic-state" then pure l else throw "catalytic transition requires two distinct registered states"
  | .other=>throw "catalytic transition requires two distinct registered states"
 let exit ← match exit with
  | .held l=>if Text.equal l.family "registered-catalytic-state" then pure l else throw "catalytic transition requires two distinct registered states"
  | .other=>throw "catalytic transition requires two distinct registered states"
 if equalLabel entry exit then throw "catalytic transition requires two distinct registered states"
 let process ← match process with
  | .held l=>if Text.equal l.family "held-catalytic-process" then pure l else throw "catalytic process identity must remain held"
  | .other=>throw "catalytic process identity must remain held"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-catalytic-condition" then pure l else throw "catalytic condition boundary must remain held"
  | .other=>throw "catalytic condition boundary must remain held"
 let status ← match status with
  | .held l=>if Text.equal l.family "held-catalytic-transition-status" then pure l else throw "catalytic transition evidence status must remain held"
  | .other=>throw "catalytic transition evidence status must remain held"
 pure ⟨identity,entry,exit,process,condition,status⟩
inductive CatalystStateInput where
 | state (value : RetainedCatalystState)
 | other
inductive CatalyticTransitionInput where
 | transition (value : RetainedCatalyticTransition)
 | other
structure CompleteCatalyticCycle where
 cycleIdentity : HeldLabel
 orderedStates : List RetainedCatalystState
 orderedTransitions : List RetainedCatalyticTransition
def makeCycle (identity : LabelInput) (states : List CatalystStateInput) (transitions : List CatalyticTransitionInput) : Except String CompleteCatalyticCycle := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-catalytic-cycle" then pure l else throw "catalytic cycle identity must remain registered"
  | .other=>throw "catalytic cycle identity must remain registered"
 if states.length<2 || transitions.length != states.length then throw "a complete catalytic cycle requires every state and closing transition"
 let states ← states.mapM fun s=>match s with
  | .state s=>pure s
  | .other=>throw "catalytic cycle contains an unregistered state"
 let transitions ← transitions.mapM fun t=>match t with
  | .transition t=>pure t
  | .other=>throw "catalytic cycle contains an unregistered transition"
 if !(states.zipIdx.all fun (s,i)=>s.cyclePosition.value==i+1) then throw "catalytic cycle positions must be complete and gap-free"
 let identities := states.map RetainedCatalystState.stateIdentity
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != states.length then
  throw "catalytic state occurrences must remain distinguishable"
 let first ← match states.head? with | some s=>pure s | none=>throw "tuple index out of range"
 if states.any (fun s=> !equalLabel s.catalystIdentity first.catalystIdentity) then throw "the same exact catalyst identity must traverse every cycle state"
 let firstEdge ← match transitions.head? with | some t=>pure t | none=>throw "tuple index out of range"
 let _ ← transitions.zipIdx.mapM fun (edge,i)=>do
  let entry ← match (states.drop i).head? with | some s=>pure s | none=>throw "tuple index out of range"
  let exit ← match (states.drop ((i+1)%states.length)).head? with | some s=>pure s | none=>throw "tuple index out of range"
  if !equalLabel edge.entryState entry.stateIdentity || !equalLabel edge.exitState exit.stateIdentity then
   throw "every catalytic transition must join the next exact state and close on entry"
  if !equalLabel edge.conditionBoundary firstEdge.conditionBoundary then throw "one complete cycle requires one exact held condition boundary"
  pure ()
 pure ⟨identity,states,transitions⟩
def catalystIdentity (cycle : CompleteCatalyticCycle) : Except String HeldLabel :=
 match cycle.orderedStates.head? with | some s=>pure s.catalystIdentity | none=>throw "tuple index out of range"
structure ExactCatalyticTurnover where
 cycleIdentity : HeldLabel
 catalystIdentity : HeldLabel
 orderedTransitionWord : List RetainedCatalyticTransition
 completedCycleCount : PositiveCount
 exactReturnState : HeldLabel
 turnoverIdentity : HeldLabel
inductive CycleInput where
 | cycle (value : CompleteCatalyticCycle)
 | other
def forcedCatalyticTurnover (input : CycleInput) : Except String ExactCatalyticTurnover := do
 let cycle ← match input with
  | .cycle c=>pure c
  | .other=>throw "turnover requires one complete catalyst-return cycle"
 let catalyst ← catalystIdentity cycle
 let first ← match cycle.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
 pure ⟨cycle.cycleIdentity,catalyst,cycle.orderedTransitions,⟨1,by decide⟩,first.stateIdentity,
  ⟨"exact-catalytic-turnover","one-complete-transition-word-returns-the-held-catalyst-to-its-entry-state",rfl,rfl⟩⟩
structure ExactCatalyticCycleFrequency where
 completedCycleCount : PositiveCount
 exactIntervalParts : PositiveCount
 cycleFrequency : ExactPositiveRatio
 frequencyIdentity : HeldLabel
def forcedCycleFrequency (cycles interval : SequentialMechanism.CountInput) : Except String ExactCatalyticCycleFrequency := do
 let frequency ← ratioFromCounts cycles interval
 let cycles ← match cycles with | .count n=>pure n | .other=>throw "cycle frequency requires two exact positive counts"
 let interval ← match interval with | .count n=>pure n | .other=>throw "cycle frequency requires two exact positive counts"
 pure ⟨cycles,interval,frequency,⟨"exact-catalytic-cycle-frequency","completed-catalyst-return-words-per-exact-held-observation-partition",rfl,rfl⟩⟩
structure RegisteredCatalyticCycleOccurrence where
 sourceOccurrence : PositiveCount
 cycle : CompleteCatalyticCycle
 exactIntervalParts : PositiveCount
def makeOccurrence (source : SequentialMechanism.CountInput) (cycle : CycleInput) (interval : SequentialMechanism.CountInput) : Except String RegisteredCatalyticCycleOccurrence := do
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "catalytic source occurrence must be positive"
 let cycle ← match cycle with
  | .cycle c=>pure c
  | .other=>throw "catalytic family requires complete cycles"
 let interval ← match interval with
  | .count n=>pure n
  | .other=>throw "catalytic observation interval must be exact and positive"
 pure ⟨source,cycle,interval⟩
inductive OccurrenceInput where
 | occurrence (value : RegisteredCatalyticCycleOccurrence)
 | other
structure CompleteCatalyticCycleFamily where
 orderedOccurrences : List RegisteredCatalyticCycleOccurrence
def makeFamily (occurrences : List OccurrenceInput) : Except String CompleteCatalyticCycleFamily := do
 if occurrences.isEmpty then throw "catalytic family requires at least one complete cycle occurrence"
 let occurrences ← occurrences.mapM fun row=>match row with
  | .occurrence o=>pure o
  | .other=>throw "catalytic family requires at least one complete cycle occurrence"
 if !(occurrences.zipIdx.all fun (o,i)=>o.sourceOccurrence.value==i+1) then throw "catalytic cycle occurrences must be complete and gap-free"
 pure ⟨occurrences⟩
def equalTransition (a b : RetainedCatalyticTransition) : Bool :=
 equalLabel a.transitionIdentity b.transitionIdentity && equalLabel a.entryState b.entryState && equalLabel a.exitState b.exitState &&
 equalLabel a.processIdentity b.processIdentity && equalLabel a.conditionBoundary b.conditionBoundary && equalLabel a.evidenceStatus b.evidenceStatus
def equalTurnover (a b : ExactCatalyticTurnover) : Bool :=
 equalLabel a.cycleIdentity b.cycleIdentity && equalLabel a.catalystIdentity b.catalystIdentity &&
 a.orderedTransitionWord.length==b.orderedTransitionWord.length && (a.orderedTransitionWord.zip b.orderedTransitionWord).all (fun (x,y)=>equalTransition x y) &&
 a.completedCycleCount.value==b.completedCycleCount.value && equalLabel a.exactReturnState b.exactReturnState && equalLabel a.turnoverIdentity b.turnoverIdentity
def familyFrequency (family : CompleteCatalyticCycleFamily) : Except String ExactCatalyticCycleFrequency := do
 let n ← count family.orderedOccurrences.length
 let interval ← count (family.orderedOccurrences.foldl (fun n row=>n+row.exactIntervalParts.value) 0)
 forcedCycleFrequency (.count n) (.count interval)
def appendCompleteCyclePreservesTurnoverFamily (family : CompleteCatalyticCycleFamily) (successor : RegisteredCatalyticCycleOccurrence) : Except String Bool := do
 if successor.sourceOccurrence.value != family.orderedOccurrences.length+1 then throw "catalytic successor must be the next positive source occurrence"
 let prior ← family.orderedOccurrences.mapM fun row=>forcedCatalyticTurnover (.cycle row.cycle)
 let priorFrequency ← familyFrequency family
 let extended ← makeFamily ((family.orderedOccurrences++[successor]).map OccurrenceInput.occurrence)
 let after ← extended.orderedOccurrences.mapM fun row=>forcedCatalyticTurnover (.cycle row.cycle)
 let afterFrequency ← familyFrequency extended
 let retained := after.take prior.length
 pure (retained.length==prior.length && (retained.zip prior).all (fun (a,b)=>equalTurnover a b) && after.length==prior.length+1 && priorFrequency.completedCycleCount.value+1==afterFrequency.completedCycleCount.value)
def witnessState (position : Nat) (label : String) (catalyst : String := "catalyst-a") (status : String := "retained") : Except String RetainedCatalystState := do
 makeState (.held (← heldLabel "registered-catalytic-state" label)) (.held (← heldLabel "held-catalyst-identity" catalyst))
  (.count (← count position)) (.held (← heldLabel "held-catalytic-state-status" status))
def witnessTransition (entry exit process : String) (condition : String := "held-condition") : Except String RetainedCatalyticTransition := do
 makeTransition (.held (← heldLabel "registered-catalytic-transition" (Text.intercalate "-to-" [entry,exit])))
  (.held (← heldLabel "registered-catalytic-state" entry)) (.held (← heldLabel "registered-catalytic-state" exit))
  (.held (← heldLabel "held-catalytic-process" process)) (.held (← heldLabel "held-catalytic-condition" condition))
  (.held ⟨"held-catalytic-transition-status","retained",rfl,rfl⟩)
def witnessCycle (label : String) (catalyst : String := "catalyst-a") : Except String CompleteCatalyticCycle := do
 let states ← (List.range 5).mapM fun i=>witnessState (i+1) (Text.intercalate "" [label,"-state-",toString (i+1)]) catalyst
 let processes := ["entry-process","second-process","third-process","fourth-process","return-process"]
 let edges ← processes.zipIdx.mapM fun (process,i)=>do
  let entry ← match (states.drop i).head? with | some s=>pure s | none=>throw "tuple index out of range"
  let exit ← match (states.drop ((i+1)%states.length)).head? with | some s=>pure s | none=>throw "tuple index out of range"
  witnessTransition entry.stateIdentity.label exit.stateIdentity.label process
 makeCycle (.held (← heldLabel "registered-catalytic-cycle" label)) (states.map CatalystStateInput.state) (edges.map CatalyticTransitionInput.transition)
def base : Except String CompleteCatalyticCycle := witnessCycle "cycle-a"
def identityReturnWitness : Except String Bool := do
 let cycle ← base
 let result ← forcedCatalyticTurnover (.cycle cycle)
 let last ← match cycle.orderedStates.getLast? with | some s=>pure s | none=>throw "tuple index out of range"
 let first ← match cycle.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
 pure (equalLabel result.catalystIdentity last.catalystIdentity && equalLabel result.exactReturnState first.stateIdentity)
def completeWordWitness : Except String Bool := do
 let cycle ← base
 let result ← forcedCatalyticTurnover (.cycle cycle)
 let last ← match result.orderedTransitionWord.getLast? with | some t=>pure t | none=>throw "tuple index out of range"
 let first ← match cycle.orderedStates.head? with | some s=>pure s | none=>throw "tuple index out of range"
 pure (result.orderedTransitionWord.length==cycle.orderedStates.length && equalLabel last.exitState first.stateIdentity)
def frequencyWitness : Except String Bool := do
 let result ← forcedCycleFrequency (.count ⟨3,by decide⟩) (.count ⟨2,by decide⟩)
 pure (@decide (result.cycleFrequency.value.num=3) (Int.decEq _ _) && result.cycleFrequency.value.den==2)
def successorWitness : Except String Bool := do
 let prior ← makeOccurrence (.count ⟨1,by decide⟩) (.cycle (← base)) (.count ⟨7,by decide⟩)
 let family ← makeFamily [.occurrence prior]
 let successor ← makeOccurrence (.count ⟨2,by decide⟩) (.cycle (← witnessCycle "cycle-b" "catalyst-b")) (.count ⟨5,by decide⟩)
 appendCompleteCyclePreservesTurnoverFamily family successor
theorem identityReturn : identityReturnWitness=.ok true := rfl
theorem completeWord : completeWordWitness=.ok true := rfl
theorem frequency : frequencyWitness=.ok true := rfl
theorem completeSuccessorFamily : successorWitness=.ok true := rfl
end SFT.Chemistry.CatalyticTurnover
