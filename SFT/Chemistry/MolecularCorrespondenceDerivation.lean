import SFT.Chemistry.MolecularCorrespondence
import SFT.Mathematics.DiscreteComplement
namespace SFT.Chemistry.MolecularCorrespondenceDerivation
open SFT.Chemistry.MolecularCorrespondence
open SFT.Physics.CapabilityValues
open SFT.Mathematics.DiscreteObjects
open SFT.QuantumComputation.ReversibleModel
open SFT.QuantumComputation.ReversibleApplication
open SFT.QuantumComputation.ReversibleObservation
open SFT.InformationScience.EncodingMaps
open SFT.Foundation.Count.TraceDerivation
set_option maxHeartbeats 100000000

-- Source: MolecularProcess.__post_init__. No equality of source and target
-- sets is required: only nonempty rows and distinct labels in each column.
theorem constructorRows (carrier law : HeldLabel) (rows : List (String × String))
 (process : Process) (accepted : construct carrier rows law = .ok process) :
 process = ⟨carrier,rows,law⟩ ∧ rows.isEmpty = false ∧
 distinct (rows.map Prod.fst) = true ∧ distinct (rows.map Prod.snd) = true := by
 change (if !SFT.Host.Text.equal carrier.family "molecular-carrier" then
  Except.error "molecular process lost its chemical carrier"
  else if !SFT.Host.Text.equal law.family "admitted-chemical-transition-law" then
  Except.error "molecular process lost its admitted Chemistry law"
  else if rows.isEmpty then Except.error "molecular correspondence requires generated support"
  else if !distinct (rows.map Prod.fst) || !distinct (rows.map Prod.snd) then
  Except.error "molecular transition must be a finite bijection"
  else Except.ok (Process.mk carrier rows law)) = .ok process at accepted
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 split at accepted <;> try { cases accepted }
 rename_i nonempty
 split at accepted <;> try { cases accepted }
 rename_i unique
 have sources : distinct (rows.map Prod.fst) = true := by
  cases h : distinct (rows.map Prod.fst) with
  | true => rfl
  | false => exact False.elim (unique (by rw [h]; rfl))
 have targets : distinct (rows.map Prod.snd) = true := by
  cases h : distinct (rows.map Prod.snd) with
  | true => rfl
  | false => exact False.elim (unique (by rw [h,sources]; rfl))
 exact ⟨(Except.ok.inj accepted).symm,Bool.eq_false_iff.mpr nonempty,sources,targets⟩

-- The three projections of the generated molecular objects are identical
-- singleton encodings of the original source/target columns.
theorem initialSupport (rows : List (String × String)) :
 (initialBranches rows).map Prod.fst = (rows.map Prod.fst).map (fun label => [label]) := by
 induction rows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons [row.1]) ih

theorem gateSources (rows : List (String × String)) :
 (gateRows rows).map Prod.fst = (rows.map Prod.fst).map (fun label => [label]) := by
 induction rows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons [row.1]) ih

theorem gateTargets (rows : List (String × String)) :
 (gateRows rows).map Prod.snd = (rows.map Prod.snd).map (fun label => [label]) := by
 induction rows with
 | nil => rfl
 | cons row rest ih => exact congrArg (List.cons [row.2]) ih

theorem generatedInitialAdmitted (process : Process)
 (nonempty : process.transitionRows.isEmpty = false)
 (sources : distinct (process.transitionRows.map Prod.fst) = true) :
 initialState process = .ok ⟨initialBranches process.transitionRows,phaseCycle⟩ := by
 have words : distinct ((initialBranches process.transitionRows).map Prod.fst) = true := by
  rw [initialSupport]
  exact SFT.Mathematics.DiscreteObjects.mapDistinct (fun label : String => [label])
   (fun a b h => List.cons.inj h |>.1) _ sources
 have occupied : (initialBranches process.transitionRows).isEmpty = false := by
  cases h : process.transitionRows with
  | nil => rw [h] at nonempty; cases nonempty
  | cons row rest => rfl
 have phases : (initialBranches process.transitionRows).any (fun row => !has phaseCycle row.2) = false := by
  have every : ∀ rows : List (String × String),
   (initialBranches rows).any (fun row => !has phaseCycle row.2) = false := by
   intro rows
   induction rows with
   | nil => rfl
   | cons row rest ih => exact ih
  exact every _
 unfold initialState makeState
 rw [occupied,words,phases]
 rfl

theorem generatedGateAdmitted (process : Process)
 (nonempty : process.transitionRows.isEmpty = false)
 (sources : distinct (process.transitionRows.map Prod.fst) = true)
 (targets : distinct (process.transitionRows.map Prod.snd) = true) :
 processGate process = .ok ⟨gateRows process.transitionRows,["phase-successor"]⟩ := by
 have sourceWords : distinct ((gateRows process.transitionRows).map Prod.fst) = true := by
  rw [gateSources]
  exact SFT.Mathematics.DiscreteObjects.mapDistinct (fun label : String => [label])
   (fun a b h => List.cons.inj h |>.1) _ sources
 have targetWords : distinct ((gateRows process.transitionRows).map Prod.snd) = true := by
  rw [gateTargets]
  exact SFT.Mathematics.DiscreteObjects.mapDistinct (fun label : String => [label])
   (fun a b h => List.cons.inj h |>.1) _ targets
 have occupied : (gateRows process.transitionRows).isEmpty = false := by
  cases h : process.transitionRows with
  | nil => rw [h] at nonempty; cases nonempty
  | cons row rest => rfl
 unfold processGate makeGate
 rw [occupied,sourceWords,targetWords]
 rfl

theorem generatedDomain (process : Process) :
 domainMatches ⟨initialBranches process.transitionRows,phaseCycle⟩
  ⟨gateRows process.transitionRows,["phase-successor"]⟩ = true := by
 apply (domainExactly _ _).mpr
 intro word
 change word ∈ (gateRows process.transitionRows).map Prod.fst ↔
  word ∈ (initialBranches process.transitionRows).map Prod.fst
 rw [gateSources,initialSupport]

-- This applies the retained inverse derivation to the actual objects created
-- by the original molecular operation, for every accepted transition table.
theorem constructedRoundTrip (carrier law : HeldLabel) (rows : List (String × String))
 (process : Process) (accepted : construct carrier rows law = .ok process) :
 ∃ transformed,
  initialState process = .ok ⟨initialBranches rows,phaseCycle⟩ ∧
  processGate process = .ok ⟨gateRows rows,["phase-successor"]⟩ ∧
  applyGate ⟨initialBranches rows,phaseCycle⟩ ⟨gateRows rows,["phase-successor"]⟩ false = .ok transformed ∧
  applyGate transformed (inverse ⟨gateRows rows,["phase-successor"]⟩) true =
   .ok ⟨initialBranches rows,phaseCycle⟩ ∧
  makeState transformed.branches transformed.phaseCycle = .ok transformed ∧
  transformed.branches.length = rows.length := by
 obtain ⟨same,nonempty,sources,targets⟩ := constructorRows carrier law rows process accepted
 cases same
 have initial := generatedInitialAdmitted ⟨carrier,rows,law⟩ nonempty sources
 have gate := generatedGateAdmitted ⟨carrier,rows,law⟩ nonempty sources targets
 obtain ⟨transformed,forward,back,admitted,size⟩ := admittedRoundTrip
  ⟨initialBranches rows,phaseCycle⟩ ⟨gateRows rows,["phase-successor"]⟩ initial gate
  (generatedDomain ⟨carrier,rows,law⟩)
 refine ⟨transformed,initial,gate,forward,back,admitted,?_⟩
 exact size.trans (SFT.Foundation.CommonRefinement.mapLength _ rows)

-- Exact source observation binding: every successful observe call in the
-- mapM returns a whole predecessor record. This is independent of how many
-- rows the original process supplies and does not inspect selected examples.
theorem measurementRecordCounts (state : State) (records : List (List Record))
 (executed : measurementRecords state = .ok records) :
 records.length = state.branches.length ∧
 ∀ record, record ∈ records → record.length = state.branches.length := by
 let read := fun branch : Word × String => do
  match branch.1 with
  | [] => throw "molecular execution did not retain singleton words"
  | label::rest => match rest with
    | [] => return (← observe state (observationMap (support state)) label).2
    | _::_ => throw "molecular execution did not retain singleton words"
 have readCount : ∀ branch record, read branch = .ok record → record.length = state.branches.length := by
  intro branch record accepted
  change (match branch.1 with
   | [] => Except.error "molecular execution did not retain singleton words"
   | label::rest => match rest with
     | [] => (observe state (observationMap (support state)) label).map Prod.snd
     | _::_ => Except.error "molecular execution did not retain singleton words") = .ok record at accepted
  cases word : branch.1 with
  | nil => rw [word] at accepted; cases accepted
  | cons label rest =>
   cases rest with
   | cons next tail => rw [word] at accepted; cases accepted
   | nil =>
    rw [word] at accepted
    change Except.map Prod.snd (observe state (observationMap (support state)) label) = .ok record at accepted
    cases observed : observe state (observationMap (support state)) label with
    | error message => rw [observed] at accepted; cases accepted
    | ok result =>
     rw [observed] at accepted
     cases accepted
     exact observationRetainsEveryBranch state result.1 _ label result.2 observed
 have each : ∀ (branches : List (Word × String)) (result : List (List Record)), branches.mapM' read = .ok result →
  result.length = branches.length ∧
  ∀ record, record ∈ result → record.length = state.branches.length := by
  intro branches
  induction branches with
  | nil => intro result h; cases h; exact ⟨rfl,fun record member => by cases member⟩
  | cons branch rest ih =>
   intro result h
   change (read branch >>= fun first => rest.mapM' read >>= fun tail => pure (first::tail)) = .ok result at h
   cases first : read branch with
   | error message => rw [first] at h; cases h
   | ok record =>
    rw [first] at h
    cases tail : rest.mapM' read with
    | error message => rw [tail] at h; cases h
    | ok remaining =>
     rw [tail] at h
     cases h
     have prior := ih remaining tail
     refine ⟨congrArg Nat.succ prior.1,?_⟩
     intro item member
     cases member with
     | head => exact readCount branch record first
     | tail _ held => exact prior.2 item held
 exact each state.branches records executed

-- Every transformed word is an original target singleton, by the retained
-- gate lookup theorem; the source/target carriers need not coincide.
theorem transformedSingletons (rows : List (String × String)) (transformed : State)
 (forward : applyGate ⟨initialBranches rows,phaseCycle⟩
  ⟨gateRows rows,["phase-successor"]⟩ false = .ok transformed) :
 ∀ word, word ∈ support transformed → ∃ label, word = [label] := by
 have trace := (applicationSource _ _ _ false forward).2.2
 intro word member
 obtain ⟨branch,_,found⟩ := (transformedSupport _ _ _ _ _ trace word).mp member
 have row := lookupRow _ _ _ found
 obtain ⟨original,_,same⟩ := memMapPreimage
  (fun row : String × String => ([row.1],[row.2])) (branch.1,word) rows row
 exact ⟨original.2,(congrArg Prod.snd same).symm⟩

theorem observationKeys (words : List Word)
 (singletons : ∀ word, word ∈ words → ∃ label, word = [label]) :
 (observationMap words).map Prod.fst = words := by
 induction words with
 | nil => rfl
 | cons word rest ih =>
  obtain ⟨label,same⟩ := singletons word (.head _)
  cases same
  exact congrArg (List.cons [label]) (ih (fun item held => singletons item (.tail _ held)))

theorem observationLabel (words : List Word) (label : String)
 (singletons : ∀ word, word ∈ words → ∃ name, word = [name])
 (member : [label] ∈ words) : ([label],label) ∈ observationMap words := by
 induction words with
 | nil => cases member
 | cons word rest ih =>
  obtain ⟨name,same⟩ := singletons word (.head _)
  cases same
  cases member with
  | head => exact .head _
  | tail _ held => exact .tail _ (ih (fun item h => singletons item (.tail _ h)) held)

theorem generatedMeasurementsExist (state : State)
 (admitted : makeState state.branches state.phaseCycle = .ok state)
 (singletons : ∀ word, word ∈ support state → ∃ label, word = [label]) :
 ∃ records, measurementRecords state = .ok records := by
 have keys := observationKeys (support state) singletons
 have classified : classificationValid state (observationMap (support state)) = true := by
  unfold classificationValid
  rw [keys,admittedStateSupport state admitted]
  have covered : (support state).all (has (support state)) = true :=
   (allTrueIffMembers _ _).mpr (fun word held => (hasIff _ _).mpr held)
  rw [covered]
  rfl
 let read := fun branch : Word × String => do
  match branch.1 with
  | [] => throw "molecular execution did not retain singleton words"
  | label::rest => match rest with
    | [] => return (← observe state (observationMap (support state)) label).2
    | _::_ => throw "molecular execution did not retain singleton words"
 have readable : ∀ branch, branch ∈ state.branches → ∃ record, read branch = .ok record := by
  intro branch held
  have wordHeld := memMap Prod.fst branch state.branches held
  obtain ⟨label,singleton⟩ := singletons branch.1 wordHeld
  have labelHeld : [label] ∈ support state := by rw [← singleton]; exact wordHeld
  have lookup : lookupFirst (observationMap (support state)) branch.1 = some label := by
   rw [singleton]
   apply lookupUnique
   · rw [keys]; exact admittedStateSupport state admitted
   · exact observationLabel (support state) label singletons labelHeld
  obtain ⟨record,generated,decision⟩ := observationDecision state (observationMap (support state))
   label admitted classified
  have recorded := (recordMembership _ _ _ generated branch label).mpr ⟨held,lookup⟩
  have retained := (retainedExactly record label branch).mpr recorded
  have nonempty : (retainedRows record label).isEmpty = false := by
   cases h : retainedRows record label with
   | nil => rw [h] at retained; cases retained
   | cons first rest => rfl
  rw [nonempty] at decision
  refine ⟨record,?_⟩
  change (match branch.1 with
   | [] => Except.error "molecular execution did not retain singleton words"
   | name::rest => match rest with
     | [] => (observe state (observationMap (support state)) name).map Prod.snd
     | _::_ => Except.error "molecular execution did not retain singleton words") = .ok record
  rw [singleton]
  change Except.map Prod.snd (observe state (observationMap (support state)) label) = .ok record
  rw [decision]
  rfl
 have allReadable : ∀ branches : List (Word × String),
  (∀ branch, branch ∈ branches → branch ∈ state.branches) →
  ∃ records, branches.mapM' read = .ok records := by
  intro branches
  induction branches with
  | nil => intro _; exact ⟨[],rfl⟩
  | cons branch rest ih =>
   intro included
   obtain ⟨record,first⟩ := readable branch (included branch (.head _))
   obtain ⟨records,tail⟩ := ih (fun item held => included item (.tail _ held))
   refine ⟨record::records,?_⟩
   change (read branch >>= fun first => rest.mapM' read >>= fun tail => pure (first::tail)) = .ok _
   rw [first,tail]
   rfl
 exact allReadable state.branches (fun _ held => held)

-- The original whole operation succeeds on every accepted molecular table.
-- All supplied rows, both executions, every record and the exact inverse are
-- tied together here; no extra assumption about the returned result is used.
theorem constructedExecution (carrier law : HeldLabel) (rows : List (String × String))
 (process : Process) (accepted : construct carrier rows law = .ok process) :
 ∃ execution, quantumExecution process = .ok execution ∧
  execution.decodedRows = rows ∧ execution.inverseRestores = true ∧
  execution.records.length = rows.length ∧
  ∀ record, record ∈ execution.records → record.length = rows.length := by
 obtain ⟨transformed,initial,gate,forward,back,admitted,size⟩ :=
  constructedRoundTrip carrier law rows process accepted
 obtain ⟨records,measured⟩ := generatedMeasurementsExist transformed admitted
  (transformedSingletons rows transformed forward)
 have counts := measurementRecordCounts transformed records measured
 let execution : Execution := ⟨⟨initialBranches rows,phaseCycle⟩,transformed,
  decodeRows (gateRows rows),records,true⟩
 refine ⟨execution,?_,decodedGateRows rows,rfl,counts.1.trans size,
  fun record held => (counts.2 record held).trans size⟩
 unfold quantumExecution
 rw [initial,gate]
 dsimp only [Bind.bind,Except.bind]
 rw [forward]
 dsimp only [Bind.bind,Except.bind]
 rw [measured]
 dsimp only [Bind.bind,Except.bind]
 rw [back]
 dsimp only [Bind.bind,Except.bind]
 change Except.ok (Execution.mk _ _ _ _
  (decide (initialBranches rows = initialBranches rows ∧ phaseCycle = phaseCycle))) = .ok execution
 rw [decide_eq_true (And.intro rfl rfl)]
end SFT.Chemistry.MolecularCorrespondenceDerivation
