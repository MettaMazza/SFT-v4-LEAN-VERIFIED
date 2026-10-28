import SFT.Mathematics.OptimizationSelection
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Mathematics.CategoryPaths

-- Raw fields are exposed for comparison; admission is exactly makeArrow's guard.
structure Arrow where
  name : String
  source : String
  target : String
  trace : List String
  deriving DecidableEq, Repr

def invalid (a : Arrow) : Bool :=
  a.name.isEmpty || a.source.isEmpty || a.target.isEmpty || a.trace.isEmpty

def makeArrow (a : Arrow) : Except String Arrow :=
  if invalid a then .error "an arrow retains name, interface and a nonempty proof trace" else .ok a

def identity (object : String) : Except String Arrow :=
  makeArrow ⟨SFT.Host.Text.append "id:" object,object,object,[SFT.Host.Text.append "empty-One-return:" object]⟩

def joined (first second : Arrow) : Arrow :=
  ⟨SFT.Host.Text.join [second.name,"∘",first.name],first.source,second.target,first.trace ++ second.trace⟩

def compose (first second : Arrow) : Except String Arrow :=
  if first.target = second.source then makeArrow (joined first second)
  else .error "composition requires exact interface identity"

def canonicalTrace (trace : List String) : List String :=
  trace.filter (fun item => !(SFT.Host.Text.isPrefix "empty-One-return".toUTF8.data.toList item.toUTF8.data.toList))

def canonicalPath (arrow : Arrow) : List String := canonicalTrace arrow.trace

theorem constructorAccepted (a : Arrow) (h : invalid a = false) : makeArrow a = .ok a := by
  unfold makeArrow; rw [h]; rfl

theorem constructorRejected (a : Arrow) (h : invalid a = true) :
    makeArrow a = .error "an arrow retains name, interface and a nonempty proof trace" := by
  unfold makeArrow; rw [h]; rfl

theorem constructorResult (a result : Arrow) (h : makeArrow a = .ok result) :
    a = result ∧ invalid a = false := by
  unfold makeArrow at h
  cases hi : invalid a with
  | false => rw [hi] at h; cases h; exact ⟨rfl,rfl⟩
  | true => rw [hi] at h; cases h

theorem composeRejected (first second : Arrow) (h : first.target ≠ second.source) :
    compose first second = .error "composition requires exact interface identity" := by
  unfold compose; rw [ite_eq_right h]

theorem composeAccepted (first second : Arrow) (h : first.target = second.source)
    (admitted : invalid (joined first second) = false) :
    compose first second = .ok (joined first second) := by
  unfold compose; rw [ite_eq_left h]; exact constructorAccepted _ admitted

theorem composeResult (first second result : Arrow) (h : compose first second = .ok result) :
    first.target = second.source ∧ result = joined first second := by
  unfold compose at h
  split at h
  next interfaces => exact ⟨interfaces,((constructorResult _ _ h).1).symm⟩
  next _ => cases h

theorem composeRetains (first second result : Arrow) (h : compose first second = .ok result) :
    result.source = first.source ∧ result.target = second.target ∧ result.trace = first.trace ++ second.trace := by
  have hr := (composeResult _ _ _ h).2
  rw [hr]; exact ⟨rfl,rfl,rfl⟩

theorem filterAppend {α : Type} (predicate : α → Bool) (left right : List α) :
    (left ++ right).filter predicate = left.filter predicate ++ right.filter predicate := by
  induction left with
  | nil => rfl
  | cons a rest ih =>
    cases hp : predicate a with
    | false => rw [List.cons_append,List.filter_cons_of_neg (by rw [hp]; intro h; cases h),List.filter_cons_of_neg (by rw [hp]; intro h; cases h),ih]
    | true => rw [List.cons_append,List.filter_cons_of_pos hp,List.filter_cons_of_pos hp,ih]; rfl

theorem canonicalAppend (left right : List String) :
    canonicalTrace (left ++ right) = canonicalTrace left ++ canonicalTrace right :=
  filterAppend _ _ _

theorem composeCanonical (first second result : Arrow) (h : compose first second = .ok result) :
    canonicalPath result = canonicalPath first ++ canonicalPath second := by
  change canonicalTrace result.trace = _
  rw [(composeRetains _ _ _ h).2.2]; exact canonicalAppend _ _

theorem association (a b c ab bc left right : Arrow)
    (hab : compose a b = .ok ab) (hbc : compose b c = .ok bc)
    (hl : compose ab c = .ok left) (hr : compose a bc = .ok right) :
    left.source = right.source ∧ left.target = right.target ∧ canonicalPath left = canonicalPath right := by
  have abFields := composeRetains _ _ _ hab
  have bcFields := composeRetains _ _ _ hbc
  have lFields := composeRetains _ _ _ hl
  have rFields := composeRetains _ _ _ hr
  refine ⟨?_,?_,?_⟩
  · rw [lFields.1,abFields.1,rFields.1]
  · rw [lFields.2.1,rFields.2.1,bcFields.2.1]
  · rw [composeCanonical _ _ _ hl,composeCanonical _ _ _ hr,
      composeCanonical _ _ _ hab,composeCanonical _ _ _ hbc]
    exact ExactTraceArithmetic.appendAssociative _ _ _

theorem identityFields (object : String) (result : Arrow) (h : identity object = .ok result) :
    result.source = object ∧ result.target = object ∧ result.trace = [SFT.Host.Text.append "empty-One-return:" object] := by
  have hr := (constructorResult _ _ h).1
  cases hr
  exact ⟨rfl,rfl,rfl⟩

end SFT.Mathematics.CategoryPaths
