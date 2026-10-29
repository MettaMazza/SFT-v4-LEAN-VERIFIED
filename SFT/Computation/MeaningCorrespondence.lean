import SFT.Computation.EvaluationTrace
import SFT.Computation.SymbolicContext
namespace SFT.Computation.MeaningCorrespondence
open SymbolicEvaluation EvaluationTrace NumericalError SymbolicValues SymbolicContext
open SFT.Mathematics.DiscreteObjects

-- Constructor-indexed meaning records retain the exact source clauses.
inductive Meaning (env : Environment) : Expr → Result → Prop where
 | duplicate (e) (h : distinct (env.map Prod.fst) = false) : Meaning env e (.error "binding identity occurs twice")
 | value (v) (h : distinct (env.map Prod.fst) = true) : Meaning env (.value v) (evaluate env (.value v))
 | name (n) (h : distinct (env.map Prod.fst) = true) : Meaning env (.name n) (evaluate env (.name n))
 | outside (tag) (h : distinct (env.map Prod.fst) = true) : Meaning env (.outside tag) (evaluate env (.outside tag))
 | leftFailure (l r reason) (h : distinct (env.map Prod.fst) = true)
     (left : Meaning env l (.error reason)) : Meaning env (.join l r) (.error reason)
 | rightFailure (l r a reason) (h : distinct (env.map Prod.fst) = true)
     (left : Meaning env l (.ok a)) (right : Meaning env r (.error reason)) : Meaning env (.join l r) (.error reason)
 | join (l r a b) (h : distinct (env.map Prod.fst) = true)
     (left : Meaning env l (.ok a)) (right : Meaning env r (.ok b)) : Meaning env (.join l r) (.ok (add a b))

theorem soundness (env : Environment) (e : Expr) (result : Result) (rows : List Event)
    (execution : Execution env e result rows) : Meaning env e result := by
  induction execution with
  | duplicate e h => exact .duplicate e h
  | value v h => exact .value v h
  | name n h => exact .name n h
  | outside tag h => exact .outside tag h
  | leftFailure l r reason rows h left ih => exact .leftFailure l r reason h ih
  | rightFailure l r a reason first second h left right il ir => exact .rightFailure l r a reason h il ir
  | join l r a b first second h left right il ir => exact .join l r a b h il ir

theorem adequacy (env : Environment) (e : Expr) (result : Result)
    (meaning : Meaning env e result) : ∃ rows, Execution env e result rows := by
  induction meaning with
  | duplicate e h => exact ⟨_,.duplicate e h⟩
  | value v h => exact ⟨_,.value v h⟩
  | name n h => exact ⟨_,.name n h⟩
  | outside tag h => exact ⟨_,.outside tag h⟩
  | leftFailure l r reason h left ih =>
    obtain ⟨rows,proof⟩ := ih
    exact ⟨_,.leftFailure l r reason rows h proof⟩
  | rightFailure l r a reason h left right il ir =>
    obtain ⟨first,pl⟩ := il; obtain ⟨second,pr⟩ := ir
    exact ⟨_,.rightFailure l r a reason first second h pl pr⟩
  | join l r a b h left right il ir =>
    obtain ⟨first,pl⟩ := il; obtain ⟨second,pr⟩ := ir
    exact ⟨_,.join l r a b first second h pl pr⟩

theorem correspondence (env : Environment) (e : Expr) (result : Result) :
    Meaning env e result ↔ ∃ rows, Execution env e result rows := by
  constructor
  · exact adequacy env e result
  · intro ⟨rows,proof⟩; exact soundness _ _ _ _ proof

theorem resultMap (env : Environment) (e : Expr) (result : Result)
    (meaning : Meaning env e result) : evaluate env e = result := by
  obtain ⟨rows,proof⟩ := adequacy _ _ _ meaning
  exact sourceResult _ _ _ _ proof

theorem reconstructMeaning (env : Environment) (e : Expr) (result : Result)
    (resultRow : evaluate env e = result) : Meaning env e result := by
  have h := soundness _ _ _ _ (EvaluationTrace.reconstruct env e)
  rw [resultCorrespondence,resultRow] at h
  exact h

theorem exactMeaning (env : Environment) (e : Expr) (result : Result) :
    Meaning env e result ↔ evaluate env e = result :=
  ⟨resultMap env e result,reconstructMeaning env e result⟩

theorem uniqueMeaning (env : Environment) (e : Expr) (a b : Result)
    (first : Meaning env e a) (second : Meaning env e b) : a = b :=
  (resultMap _ _ _ first).symm.trans (resultMap _ _ _ second)

theorem noCounterexample (env : Environment) (e : Expr) (a b : Result) (rows : List Event)
    (execution : Execution env e a rows) (meaning : Meaning env e b) : a = b :=
  uniqueMeaning _ _ _ _ (soundness _ _ _ _ execution) meaning

theorem exactTrace (env : Environment) (e : Expr) (result : Result)
    (meaning : Meaning env e result) : Execution env e result (run env e).2 := by
  have h := EvaluationTrace.reconstruct env e
  rw [resultCorrespondence,resultMap _ _ _ meaning] at h
  exact h

theorem positiveBase (env : Environment) (part : SFT.Foundation.ExactOperations.PositiveFraction)
    (unique : distinct (env.map Prod.fst) = true) : Meaning env (.value (some (.positive part))) (.ok (.positive part)) := by
  apply reconstructMeaning
  unfold evaluate; rw [unique]; rfl

theorem joinAssembly (env : Environment) (l r : Expr) (a b : Number)
    (unique : distinct (env.map Prod.fst) = true)
    (left : Meaning env l (.ok a)) (right : Meaning env r (.ok b)) :
    Meaning env (.join l r) (.ok (add a b)) ∧
    Execution env (.join l r) (.ok (add a b))
      (frame env (.join l r) ((run env l).2 ++ (run env r).2) (.ok (add a b))) :=
  ⟨.join l r a b unique left right,
   .join l r a b _ _ unique (exactTrace _ _ _ left) (exactTrace _ _ _ right)⟩

def SameMeaning (env : Environment) (left right : Expr) : Prop :=
  ∀ result, Meaning env left result ↔ Meaning env right result

theorem observationIdentity (env : Environment) (e : Expr) : SameMeaning env e e :=
  fun _ => ⟨fun h => h,fun h => h⟩

theorem observationComposition (env : Environment) (a b c : Expr)
    (first : SameMeaning env a b) (second : SameMeaning env b c) : SameMeaning env a c :=
  fun result => ⟨fun h => (second result).mp ((first result).mp h),
                 fun h => (first result).mpr ((second result).mpr h)⟩

theorem sameResults (env : Environment) (left right : Expr)
    (same : SameMeaning env left right) : evaluate env left = evaluate env right :=
  (resultMap _ _ _ ((same _).mp (reconstructMeaning env left _ rfl))).symm

theorem equalResults (env : Environment) (left right : Expr)
    (same : evaluate env left = evaluate env right) : SameMeaning env left right := by
  intro result
  constructor
  · intro h; exact reconstructMeaning _ _ _ (same.symm.trans (resultMap _ _ _ h))
  · intro h; exact reconstructMeaning _ _ _ (same.trans (resultMap _ _ _ h))

theorem joinMeaning (env : Environment) (a b c d : Expr)
    (left : SameMeaning env a b) (right : SameMeaning env c d) :
    SameMeaning env (.join a c) (.join b d) := by
  apply equalResults
  have il := sameResults _ _ _ left
  have ir := sameResults _ _ _ right
  unfold evaluate
  dsimp only
  rw [il,ir]

theorem contextualMeaning (env : Environment) (context : Context) (left right : Expr)
    (same : SameMeaning env left right) : SameMeaning env (plug context left) (plug context right) := by
  induction context with
  | hole => exact same
  | left context sibling ih => exact joinMeaning _ _ _ _ _ ih (observationIdentity _ _)
  | right sibling context ih => exact joinMeaning _ _ _ _ _ (observationIdentity _ _) ih

theorem preservesSuccessfulObservation (env : Environment) (left right : Expr)
    (same : SameMeaning env left right) : SameValue env left right := by
  intro value
  constructor
  · intro h; exact resultMap _ _ _ ((same _).mp (reconstructMeaning _ _ _ h))
  · intro h; exact resultMap _ _ _ ((same _).mpr (reconstructMeaning _ _ _ h))

end SFT.Computation.MeaningCorrespondence
