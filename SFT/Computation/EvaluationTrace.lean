import SFT.Computation.SymbolicEvaluation
namespace SFT.Computation.EvaluationTrace
open SymbolicEvaluation NumericalError SymbolicValues
open SFT.Mathematics.DiscreteObjects

abbrev Result := Except String Number
inductive Event where
 | enter (environment : Environment) (expression : Expr)
 | leave (environment : Environment) (expression : Expr) (result : Result)

def frame (env : Environment) (e : Expr) (children : List Event) (result : Result) : List Event :=
  .enter env e :: children ++ [.leave env e result]

def run (env : Environment) (e : Expr) : Result × List Event :=
  if distinct (env.map Prod.fst) then
    match e with
    | .join left right =>
      let first := run env left
      match first.1 with
      | .error reason => (.error reason, frame env e first.2 (.error reason))
      | .ok a =>
        let second := run env right
        match second.1 with
        | .error reason => (.error reason, frame env e (first.2 ++ second.2) (.error reason))
        | .ok b => (.ok (add a b), frame env e (first.2 ++ second.2) (.ok (add a b)))
    | .value x => (evaluate env (.value x), frame env (.value x) [] (evaluate env (.value x)))
    | .name x => (evaluate env (.name x), frame env (.name x) [] (evaluate env (.name x)))
    | .outside x => (evaluate env (.outside x), frame env (.outside x) [] (evaluate env (.outside x)))
  else (.error "binding identity occurs twice", frame env e [] (.error "binding identity occurs twice"))

termination_by structural e

inductive Execution (env : Environment) : Expr → Result → List Event → Prop where
 | duplicate (e) (h : distinct (env.map Prod.fst) = false) :
     Execution env e (.error "binding identity occurs twice") (frame env e [] (.error "binding identity occurs twice"))
 | value (v) (h : distinct (env.map Prod.fst) = true) :
     Execution env (.value v) (evaluate env (.value v)) (frame env (.value v) [] (evaluate env (.value v)))
 | name (n) (h : distinct (env.map Prod.fst) = true) :
     Execution env (.name n) (evaluate env (.name n)) (frame env (.name n) [] (evaluate env (.name n)))
 | outside (tag) (h : distinct (env.map Prod.fst) = true) :
     Execution env (.outside tag) (evaluate env (.outside tag)) (frame env (.outside tag) [] (evaluate env (.outside tag)))
 | leftFailure (l r reason rows) (h : distinct (env.map Prod.fst) = true)
     (left : Execution env l (.error reason) rows) :
     Execution env (.join l r) (.error reason) (frame env (.join l r) rows (.error reason))
 | rightFailure (l r a reason first second) (h : distinct (env.map Prod.fst) = true)
     (left : Execution env l (.ok a) first) (right : Execution env r (.error reason) second) :
     Execution env (.join l r) (.error reason) (frame env (.join l r) (first ++ second) (.error reason))
 | join (l r a b first second) (h : distinct (env.map Prod.fst) = true)
     (left : Execution env l (.ok a) first) (right : Execution env r (.ok b) second) :
     Execution env (.join l r) (.ok (add a b)) (frame env (.join l r) (first ++ second) (.ok (add a b)))

theorem reconstruct (env : Environment) (e : Expr) : Execution env e (run env e).1 (run env e).2 := by
  induction e with
  | value v => cases h : distinct (env.map Prod.fst) with
               | false => unfold run; rw [h]; exact .duplicate _ h
               | true => unfold run; rw [h]; exact .value _ h
  | name n => cases h : distinct (env.map Prod.fst) with
              | false => unfold run; rw [h]; exact .duplicate _ h
              | true => unfold run; rw [h]; exact .name _ h
  | outside tag => cases h : distinct (env.map Prod.fst) with
                   | false => unfold run; rw [h]; exact .duplicate _ h
                   | true => unfold run; rw [h]; exact .outside _ h
  | join l r il ir =>
    cases h : distinct (env.map Prod.fst) with
    | false => unfold run; rw [h]; exact .duplicate _ h
    | true =>
      unfold run; rw [h]; dsimp only
      cases first : (run env l).1 with
      | error reason => rw [first] at il; exact .leftFailure _ _ _ _ h il
      | ok a =>
        rw [first] at il
        cases second : (run env r).1 with
        | error reason => rw [second] at ir; exact .rightFailure _ _ _ _ _ _ h il ir
        | ok b => rw [second] at ir; exact .join _ _ _ _ _ _ h il ir

theorem replay (env : Environment) (e : Expr) (result : Result) (rows : List Event)
    (proof : Execution env e result rows) : run env e = (result,rows) := by
  induction proof with
  | duplicate e h => unfold run; rw [h]; rfl
  | value v h => unfold run; rw [h]; rfl
  | name n h => unfold run; rw [h]; rfl
  | outside tag h => unfold run; rw [h]; rfl
  | leftFailure l r reason rows h left il => unfold run; rw [h]; dsimp only; rw [il]; rfl
  | rightFailure l r a reason first second h left right il ir => unfold run; rw [h]; dsimp only; rw [il]; dsimp only; rw [ir]; rfl
  | join l r a b first second h left right il ir => unfold run; rw [h]; dsimp only; rw [il]; dsimp only; rw [ir]; rfl

theorem exactExecution (env : Environment) (e : Expr) (result : Result) (rows : List Event) :
    Execution env e result rows ↔ run env e = (result,rows) := by
  constructor
  · exact replay env e result rows
  · intro h; have p := reconstruct env e; rw [h] at p; exact p

theorem sourceResult (env : Environment) (e : Expr) (result : Result) (rows : List Event)
    (proof : Execution env e result rows) : evaluate env e = result := by
  induction proof with
  | duplicate e h => exact duplicateEnvironment _ _ h
  | value => rfl
  | name => rfl
  | outside => rfl
  | leftFailure l r reason rows h left il => unfold evaluate; rw [h]; dsimp only; rw [il]; rfl
  | rightFailure l r a reason first second h left right il ir => unfold evaluate; rw [h]; dsimp only; rw [il]; dsimp only; rw [ir]; rfl
  | join l r a b first second h left right il ir => unfold evaluate; rw [h]; dsimp only; rw [il]; dsimp only; rw [ir]; rfl

theorem resultCorrespondence (env : Environment) (e : Expr) : (run env e).1 = evaluate env e :=
  (sourceResult _ _ _ _ (reconstruct env e)).symm

theorem noOmittedRows (env : Environment) (e : Expr) (a b : Result) (xs ys : List Event)
    (first : Execution env e a xs) (second : Execution env e b ys) : a = b ∧ xs = ys := by
  have h := (replay _ _ _ _ first).symm.trans (replay _ _ _ _ second)
  cases h
  exact ⟨rfl,rfl⟩

theorem endpoints (env : Environment) (e : Expr) (result : Result) (rows : List Event)
    (proof : Execution env e result rows) : ∃ children, rows = frame env e children result := by
  cases proof with
  | duplicate => exact ⟨[],rfl⟩
  | value => exact ⟨[],rfl⟩
  | name => exact ⟨[],rfl⟩
  | outside => exact ⟨[],rfl⟩
  | leftFailure l r reason xs => exact ⟨xs,rfl⟩
  | rightFailure l r a reason xs ys => exact ⟨xs++ys,rfl⟩
  | join l r a b xs ys => exact ⟨xs++ys,rfl⟩

theorem successfulRelation (env : Environment) (e : Expr) (value : Number) (rows : List Event)
    (proof : Execution env e (.ok value) rows) :
    distinct (env.map Prod.fst) = true ∧ Evaluation env e value :=
  (sourceAdmission _ _ _).mp (sourceResult _ _ _ _ proof)

theorem relationHasCompleteTrace (env : Environment) (e : Expr) (value : Number)
    (unique : distinct (env.map Prod.fst) = true) (proof : Evaluation env e value) :
    ∃ rows, Execution env e (.ok value) rows := by
  have h := reconstruct env e
  rw [resultCorrespondence, SymbolicEvaluation.replay _ _ _ unique proof] at h
  exact ⟨_,h⟩

theorem literalBase (env : Environment) (part : SFT.Foundation.ExactOperations.PositiveFraction)
    (unique : distinct (env.map Prod.fst) = true) :
    run env (.value (some (.positive part))) =
      (.ok (.positive part),frame env (.value (some (.positive part))) [] (.ok (.positive part))) := by
  unfold run; rw [unique]; dsimp only
  unfold evaluate; rw [unique]; rfl

theorem joinSuccessor (env : Environment) (l r : Expr) (a b : Number) (first second : List Event)
    (unique : distinct (env.map Prod.fst) = true)
    (left : Execution env l (.ok a) first) (right : Execution env r (.ok b) second) :
    run env (.join l r) = (.ok (add a b),frame env (.join l r) (first ++ second) (.ok (add a b))) :=
  replay _ _ _ _ (.join _ _ _ _ _ _ unique left right)

theorem firstFailureStops (env : Environment) (l r : Expr) (reason : String) (first : List Event)
    (unique : distinct (env.map Prod.fst) = true) (left : Execution env l (.error reason) first) :
    run env (.join l r) = (.error reason,frame env (.join l r) first (.error reason)) :=
  replay _ _ _ _ (.leftFailure _ _ _ _ unique left)

theorem secondFailureRetainsFirst (env : Environment) (l r : Expr) (a : Number) (reason : String)
    (first second : List Event) (unique : distinct (env.map Prod.fst) = true)
    (left : Execution env l (.ok a) first) (right : Execution env r (.error reason) second) :
    run env (.join l r) = (.error reason,frame env (.join l r) (first ++ second) (.error reason)) :=
  replay _ _ _ _ (.rightFailure _ _ _ _ _ _ unique left right)

theorem retainsChildRow (env : Environment) (e : Expr) (children : List Event) (result : Result)
    (row : Event) (held : row ∈ children) : row ∈ frame env e children result := by
  exact List.Mem.tail _ (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held)

theorem retainsLeftRow (env : Environment) (e : Expr) (first second : List Event) (result : Result)
    (row : Event) (held : row ∈ first) : row ∈ frame env e (first ++ second) result :=
  retainsChildRow _ _ _ _ _ (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held)

theorem retainsRightRow (env : Environment) (e : Expr) (first second : List Event) (result : Result)
    (row : Event) (held : row ∈ second) : row ∈ frame env e (first ++ second) result :=
  retainsChildRow _ _ _ _ _ (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ held)

end SFT.Computation.EvaluationTrace
