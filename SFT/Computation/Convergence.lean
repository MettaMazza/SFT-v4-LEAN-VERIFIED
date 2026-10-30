import SFT.Computation.ExactApproximate
namespace SFT.Computation.Convergence
open SFT.Computation.NumericalError SFT.Computation.ExactApproximate
open SFT.Mathematics.DiscreteObjects

def errorClasses (report : Report) : List String :=
  (report.errorLedger.filter fun row => decide (row.2.2 ≠ "equal")).map Prod.fst

def nested (previous next : Report) : Bool :=
  (errorClasses next).all fun cell => has (errorClasses previous) cell

def strictClassDescent (previous next : Report) : Bool :=
  nested previous next && decide ((errorClasses next).length < (errorClasses previous).length)

structure State (reference : List Number) where
  output : List Number
  report : Report
  admitted : compare reference output = .ok report

theorem referenceRetained (reference : List Number) (state : State reference) :
    state.report.reference = reference := (reportReconstruction _ _ _ state.admitted).1

theorem errorClassSource (report : Report) (cell : String) (held : cell ∈ errorClasses report) :
    ∃ row, row ∈ report.errorLedger ∧ row.1 = cell ∧ row.2.2 ≠ "equal" := by
  obtain ⟨row,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held
  have p := (filterMemberIff _ _ _).mp member
  exact ⟨row,p.1,same,of_decide_eq_true p.2⟩

theorem nestedMeaning (previous next : Report) : nested previous next = true ↔
    ∀ cell, cell ∈ errorClasses next → cell ∈ errorClasses previous := by
  constructor
  · intro h cell member
    exact (hasIff _ _).mp ((allTrueIffMembers _ _).mp h cell member)
  · intro h
    exact (allTrueIffMembers _ _).mpr (fun cell member => (hasIff _ _).mpr (h cell member))

theorem nestedComposition (first middle last : Report)
    (a : nested first middle = true) (b : nested middle last = true) : nested first last = true :=
  (nestedMeaning _ _).mpr (fun cell member => (nestedMeaning _ _).mp a cell ((nestedMeaning _ _).mp b cell member))

theorem strictClassDescentMeaning (previous next : Report) : strictClassDescent previous next = true ↔
    (∀ cell, cell ∈ errorClasses next → cell ∈ errorClasses previous) ∧
      (errorClasses next).length < (errorClasses previous).length := by
  constructor
  · intro h
    have parts := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
    exact ⟨(nestedMeaning _ _).mp parts.1,of_decide_eq_true parts.2⟩
  · intro h
    exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
      ⟨(nestedMeaning _ _).mpr h.1,decide_eq_true h.2⟩

inductive NestedTrace : Report → List Report → Report → Prop where
  | base (report : Report) : NestedTrace report [] report
  | step (first next last : Report) (rest : List Report)
      (checked : nested first next = true) (tail : NestedTrace next rest last) :
      NestedTrace first (next::rest) last

theorem traceNested (first last : Report) (trace : List Report)
    (certificate : NestedTrace first trace last) : nested first last = true := by
  induction certificate with
  | base report => exact (nestedMeaning _ _).mpr (fun cell member => member)
  | step first next last rest checked tail ih => exact nestedComposition _ _ _ checked ih

theorem closedErrorCannotReturn (first last : Report) (trace : List Report)
    (certificate : NestedTrace first trace last) (cell : String)
    (absent : cell ∉ errorClasses first) : cell ∉ errorClasses last := by
  intro member
  exact absent ((nestedMeaning _ _).mp (traceNested _ _ _ certificate) cell member)

open SFT.InformationScience.EncodingMaps

structure Model where
  reference : List Number
  outputs : List (String × List Number)
  refinements : List (String × String)
  comparisons : List (String × String)
  targets : List String

def reportAt (model : Model) (name : String) : Option Report :=
  match lookupFirst model.outputs name with
  | none => none
  | some output => match compare model.reference output with
    | .error _ => none
    | .ok report => some report

def step (model : Model) (first next : String) : Option (Report × Report) :=
  if has model.refinements (first,next) && has model.comparisons (first,next) then
    match reportAt model first with
    | none => none
    | some before => match reportAt model next with
      | none => none
      | some after => if nested before after then some (before,after) else none
  else none

def targetReached (model : Model) (name : String) : Bool :=
  has model.targets name && (reportAt model name).isSome

theorem reportSource (model : Model) (name : String) (report : Report)
    (accepted : reportAt model name = some report) :
    ∃ output, lookupFirst model.outputs name = some output ∧
      compare model.reference output = .ok report := by
  unfold reportAt at accepted
  cases h : lookupFirst model.outputs name with
  | none => rw [h] at accepted; cases accepted
  | some output =>
    rw [h] at accepted
    dsimp only at accepted
    cases c : compare model.reference output with
    | error e => rw [c] at accepted; cases accepted
    | ok value =>
      rw [c] at accepted
      cases accepted
      exact ⟨output,rfl,c⟩

theorem stepSource (model : Model) (first next : String) (before after : Report)
    (accepted : step model first next = some (before,after)) :
    (first,next) ∈ model.refinements ∧ (first,next) ∈ model.comparisons ∧
      reportAt model first = some before ∧ reportAt model next = some after ∧
      nested before after = true := by
  unfold step at accepted
  split at accepted
  · rename_i registered
    have registeredParts := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp registered
    cases a : reportAt model first with
    | none => rw [a] at accepted; cases accepted
    | some left =>
      rw [a] at accepted
      dsimp only at accepted
      cases b : reportAt model next with
      | none => rw [b] at accepted; cases accepted
      | some right =>
        rw [b] at accepted
        dsimp only at accepted
        split at accepted
        · rename_i included
          cases accepted
          exact ⟨(hasIff _ _).mp registeredParts.1,(hasIff _ _).mp registeredParts.2,rfl,rfl,included⟩
        · cases accepted
  · cases accepted

def runSteps (model : Model) (first : String) : List String → Option (List (Report × Report))
  | [] => some []
  | next::rest => match step model first next with
    | none => none
    | some pair => match runSteps model next rest with
      | none => none
      | some tail => some (pair::tail)

inductive Steps (model : Model) : String → List String → List (Report × Report) → Prop where
  | base (first : String) : Steps model first [] []
  | successor (first next : String) (rest : List String) (pair : Report × Report) (tail : List (Report × Report))
      (accepted : step model first next = some pair) (certificate : Steps model next rest tail) :
      Steps model first (next::rest) (pair::tail)

theorem stepsReplay (model : Model) (first : String) (names : List String) (pairs : List (Report × Report))
    (certificate : Steps model first names pairs) : runSteps model first names = some pairs := by
  induction certificate with
  | base => rfl
  | successor first next rest pair tail accepted certificate ih =>
    unfold runSteps
    rw [accepted,ih]

theorem stepsReconstruct (model : Model) (first : String) (names : List String) (pairs : List (Report × Report))
    (accepted : runSteps model first names = some pairs) : Steps model first names pairs := by
  induction names generalizing first pairs with
  | nil => cases accepted; exact .base _
  | cons next rest ih =>
    unfold runSteps at accepted
    cases a : step model first next with
    | none => rw [a] at accepted; cases accepted
    | some pair =>
      rw [a] at accepted
      cases b : runSteps model next rest with
      | none => rw [b] at accepted; cases accepted
      | some tail =>
        rw [b] at accepted
        cases accepted
        exact .successor _ _ _ _ _ a (ih _ _ b)

theorem stepsCount (model : Model) (first : String) (names : List String) (pairs : List (Report × Report))
    (certificate : Steps model first names pairs) : pairs.length = names.length := by
  induction certificate with
  | base => rfl
  | successor first next rest pair tail accepted certificate ih => exact congrArg Nat.succ ih

inductive StrictTrace : Report → List Report → Report → Prop where
  | base (report : Report) : StrictTrace report [] report
  | successor (first next last : Report) (rest : List Report)
      (checked : strictClassDescent first next = true) (tail : StrictTrace next rest last) :
      StrictTrace first (next::rest) last

theorem strictTraceBound (first last : Report) (trace : List Report)
    (certificate : StrictTrace first trace last) :
    trace.length+(errorClasses last).length ≤ (errorClasses first).length := by
  induction certificate with
  | base report =>
    change 0+(errorClasses report).length ≤ _
    rw [Nat.zero_add]
    exact Nat.le_refl _
  | successor first next last rest checked tail ih =>
    have less := (strictClassDescentMeaning _ _).mp checked
    change (rest.length+1)+(errorClasses last).length ≤ _
    rw [Nat.add_succ,Nat.succ_add]
    exact Nat.le_trans (Nat.succ_le_succ ih) less.2

def terminalName (first : String) : List String → String
  | [] => first
  | next::rest => terminalName next rest

def run (model : Model) (first : String) (names : List String) : Option (Report × List (Report × Report)) :=
  match reportAt model first with
  | none => none
  | some initial => match runSteps model first names with
    | none => none
    | some pairs => some (initial,pairs)

def reachesTarget (model : Model) (first : String) (names : List String) : Bool :=
  (run model first names).isSome && targetReached model (terminalName first names)

theorem targetBoundary (model : Model) (name : String) (accepted : targetReached model name = true) :
    name ∈ model.targets ∧ (reportAt model name).isSome = true := by
  have p := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp accepted
  exact ⟨(hasIff _ _).mp p.1,p.2⟩

theorem stepsNested (model : Model) (first : String) (names : List String) (pairs : List (Report × Report))
    (certificate : Steps model first names pairs) (initial : Report)
    (admitted : reportAt model first = some initial) :
    ∃ last, NestedTrace initial (pairs.map Prod.snd) last ∧
      reportAt model (terminalName first names) = some last := by
  induction certificate generalizing initial with
  | base first => exact ⟨initial,.base _,admitted⟩
  | successor first next rest pair tail accepted certificate ih =>
    cases pair with
    | mk before after =>
      have source := stepSource _ _ _ _ _ accepted
      have same : initial = before := Option.some.inj (admitted.symm.trans source.2.2.1)
      cases same
      obtain ⟨last,trace,terminal⟩ := ih after source.2.2.2.1
      exact ⟨last,.step _ _ _ _ source.2.2.2.2 trace,terminal⟩

def certifiedDescent (pairs : List (Report × Report)) : Bool :=
  pairs.all fun pair => strictClassDescent pair.1 pair.2

theorem stepsStrict (model : Model) (first : String) (names : List String) (pairs : List (Report × Report))
    (certificate : Steps model first names pairs) (initial : Report)
    (admitted : reportAt model first = some initial) (checked : certifiedDescent pairs = true) :
    ∃ last, StrictTrace initial (pairs.map Prod.snd) last ∧
      reportAt model (terminalName first names) = some last := by
  induction certificate generalizing initial with
  | base first => exact ⟨initial,.base _,admitted⟩
  | successor first next rest pair tail accepted certificate ih =>
    cases pair with
    | mk before after =>
      have source := stepSource _ _ _ _ _ accepted
      have same : initial = before := Option.some.inj (admitted.symm.trans source.2.2.1)
      cases same
      have headCheck := (allTrueIffMembers _ _).mp checked (initial,after) (.head _)
      have tailCheck : certifiedDescent tail = true :=
        (allTrueIffMembers _ _).mpr (fun pair member => (allTrueIffMembers _ _).mp checked pair (.tail _ member))
      obtain ⟨last,trace,terminal⟩ := ih after source.2.2.2.1 tailCheck
      exact ⟨last,.successor _ _ _ _ headCheck trace,terminal⟩

theorem runSource (model : Model) (first : String) (names : List String)
    (initial : Report) (pairs : List (Report × Report))
    (accepted : run model first names = some (initial,pairs)) :
    reportAt model first = some initial ∧ Steps model first names pairs := by
  unfold run at accepted
  cases h : reportAt model first with
  | none => rw [h] at accepted; cases accepted
  | some value =>
    rw [h] at accepted
    dsimp only at accepted
    cases p : runSteps model first names with
    | none => rw [p] at accepted; cases accepted
    | some values =>
      rw [p] at accepted
      cases accepted
      exact ⟨rfl,stepsReconstruct _ _ _ _ p⟩

end SFT.Computation.Convergence
