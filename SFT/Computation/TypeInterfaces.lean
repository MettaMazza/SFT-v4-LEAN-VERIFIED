import SFT.Mathematics.CategoryTypes
import SFT.Mathematics.CategoryTransport
namespace SFT.Computation.TypeInterfaces
open SFT.Mathematics CategoryTypes CategoryPaths CategoryTransport OptimizationSelection
open SFT.Foundation.Count.TraceDerivation

theorem retainedFilter (carrier : List String) (old fresh : Verdicts)
    (same : ∀ item, item ∈ carrier → allowed old item = allowed fresh item) :
    carrier.filter (allowed old) = carrier.filter (allowed fresh) := by
  induction carrier with
  | nil => rfl
  | cons a rest ih =>
    have head := same a (List.Mem.head _)
    have tail := ih (fun x hx => same x (List.Mem.tail _ hx))
    unfold List.filter
    rw [head,tail]

theorem typeSuccessor (carrier extra prior extended : List String) (old fresh : Verdicts)
    (before : typeMembers carrier old = .ok prior)
    (after : typeMembers (carrier ++ extra) fresh = .ok extended)
    (same : ∀ item, item ∈ carrier → allowed old item = allowed fresh item) :
    extended = prior ++ extra.filter (allowed fresh) := by
  rw [(typeResult _ _ _ after).2,filterAppend,← retainedFilter carrier old fresh same,← (typeResult _ _ _ before).2]

theorem earlierMemberRetained (carrier extra prior extended : List String) (old fresh : Verdicts)
    (before : typeMembers carrier old = .ok prior)
    (after : typeMembers (carrier ++ extra) fresh = .ok extended)
    (same : ∀ item, item ∈ carrier → allowed old item = allowed fresh item)
    (item : String) (held : item ∈ prior) : item ∈ extended := by
  rw [typeSuccessor _ _ _ _ _ _ before after same]
  exact memAppendLeft _ _ _ held

theorem productAppend (left extra right : List String) :
    productForms (left ++ extra) right = productForms left right ++ productForms extra right := by
  induction left with
  | nil => rfl
  | cons a rest ih =>
    change (right.map (fun b => (a,b)) ++ productForms (rest ++ extra) right) =
      (right.map (fun b => (a,b)) ++ productForms rest right) ++ productForms extra right
    rw [ih,ExactTraceArithmetic.appendAssociative]

theorem completeNewPairs (left right : List String) (new : String) :
    productForms (left ++ [new]) right = productForms left right ++ right.map (fun b => (new,b)) := by
  rw [productAppend]
  change _ ++ (right.map (fun b => (new,b)) ++ []) = _
  rw [CategoryIdentity.appendNil]

theorem sumRightAppend (left right extra : List String) :
    sumForms left (right ++ extra) = sumForms left right ++ extra.map (fun b => ("right-held",b)) := by
  unfold sumForms
  rw [ExactTraceArithmetic.mapAppend,ExactTraceArithmetic.appendAssociative]

-- Each original compose call is retained, including the first rejected call.
inductive InterfaceRun : Arrow → List Arrow → Except String Arrow → Prop where
 | base (held) : InterfaceRun held [] (.ok held)
 | rejected (held next rest reason) (failure : compose held next = .error reason) :
     InterfaceRun held (next::rest) (.error reason)
 | successor (held next rest joined result) (step : compose held next = .ok joined)
     (tail : InterfaceRun joined rest result) : InterfaceRun held (next::rest) result

theorem replay (held : Arrow) (rest : List Arrow) (result : Except String Arrow)
    (proof : InterfaceRun held rest result) : foldRest held rest = result := by
  induction proof with
  | base => rfl
  | rejected held next rest reason failure => unfold foldRest; rw [failure]
  | successor held next rest joined result step tail ih => unfold foldRest; rw [step]; exact ih

theorem reconstruct (held : Arrow) (rest : List Arrow) : InterfaceRun held rest (foldRest held rest) := by
  induction rest generalizing held with
  | nil => exact .base held
  | cons next rest ih =>
    unfold foldRest
    cases step : compose held next with
    | error reason => exact .rejected held next rest reason step
    | ok joined => exact .successor held next rest joined _ step (ih joined)

theorem exactRun (held : Arrow) (rest : List Arrow) (result : Except String Arrow) :
    InterfaceRun held rest result ↔ foldRest held rest = result := by
  constructor
  · exact replay held rest result
  · intro h; have proof := reconstruct held rest; rw [h] at proof; exact proof

theorem exactInterfaces (held next : Arrow) (rest : List Arrow) (result : Arrow)
    (proof : InterfaceRun held (next::rest) (.ok result)) : held.target = next.source := by
  cases proof with
  | successor held next rest joined result step tail => exact (composeResult _ _ _ step).1

theorem mismatchHalt (held next : Arrow) (rest : List Arrow) (different : held.target ≠ next.source) :
    InterfaceRun held (next::rest) (.error "composition requires exact interface identity") :=
  .rejected _ _ _ _ (composeRejected _ _ different)

theorem completeTrace (held : Arrow) (rest : List Arrow) (result : Arrow)
    (proof : InterfaceRun held rest (.ok result)) : result.trace = held.trace ++ rest.flatMap Arrow.trace :=
  (foldRestTrace held rest result (replay _ _ _ proof)).2

theorem earlierTraceRow (held : Arrow) (rest : List Arrow) (result : Arrow) (row : String)
    (proof : InterfaceRun held rest (.ok result)) (heldRow : row ∈ held.trace) : row ∈ result.trace := by
  rw [completeTrace _ _ _ proof]
  exact memAppendLeft _ _ _ heldRow

theorem componentTraceRow (held : Arrow) (rest : List Arrow) (result component : Arrow) (row : String)
    (proof : InterfaceRun held rest (.ok result)) (present : component ∈ rest)
    (heldRow : row ∈ component.trace) : row ∈ result.trace := by
  rw [completeTrace _ _ _ proof]
  exact memAppendRight _ _ _ (SFT.Foundation.CommonRefinement.memFlatMap _ _ _ _ present heldRow)

theorem serial (held : Arrow) (first second : List Arrow) (middle : Arrow) (result : Except String Arrow)
    (left : InterfaceRun held first (.ok middle)) (right : InterfaceRun middle second result) :
    InterfaceRun held (first ++ second) result := by
  induction first generalizing held with
  | nil => cases left; exact right
  | cons next rest ih =>
    cases left with
    | successor held next rest joined outcome step tail => exact .successor _ _ _ _ _ step (ih joined tail)

theorem failedPrefix (held : Arrow) (first second : List Arrow) (reason : String)
    (left : InterfaceRun held first (.error reason)) : InterfaceRun held (first ++ second) (.error reason) := by
  induction first generalizing held with
  | nil => cases left
  | cons next rest ih =>
    cases left with
    | rejected held next rest reason failure => exact .rejected _ _ _ _ failure
    | successor held next rest joined outcome step tail => exact .successor _ _ _ _ _ step (ih joined tail)

end SFT.Computation.TypeInterfaces
