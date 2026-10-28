import SFT.Mathematics.CategoryIdentity
namespace SFT.Mathematics.CategoryTransport
open CategoryPaths GeometryTopology AlgebraOperations DiscreteObjects SFT.Foundation.Count.TraceDerivation

def lookup {α : Type} (rows : List (String × α)) (key : String) : Option α :=
  match rows with
  | [] => none
  | (k,v) :: rest => match lookup rest key with
    | some result => some result
    | none => if k = key then some v else none

def preservesArrow (arrow : Arrow) (objects : List (String × String)) (images : List (String × Arrow)) : Bool :=
  match lookup images arrow.name with
  | none => false
  | some image => match lookup objects arrow.source with
    | none => false
    | some source => match lookup objects arrow.target with
      | none => false
      | some target => decide (image.source = source) && decide (image.target = target)

def functorPreserves (arrows : List Arrow) (objects : List (String × String)) (images : List (String × Arrow)) : Bool :=
  arrows.all (fun arrow => preservesArrow arrow objects images)

def foldRest (held : Arrow) : List Arrow → Except String Arrow
  | [] => .ok held
  | arrow :: rest => match compose held arrow with
    | .error e => .error e
    | .ok result => foldRest result rest

def foldPath : List Arrow → Except String Arrow
  | [] => .error "IndexError: tuple index out of range"
  | first :: rest => foldRest first rest

def sameRoute (left right : Arrow) : Bool :=
  decide (left.source = right.source) && decide (left.target = right.target) && decide (canonicalPath left = canonicalPath right)

def naturalityCommutes (left right : List Arrow) : Except String Bool :=
  match foldPath left with
  | .error e => .error e
  | .ok l => match foldPath right with
    | .error e => .error e
    | .ok r => .ok (sameRoute l r)

theorem lookupLastWins {α : Type} (rows : List (String × α)) (key : String) (value : α) :
    lookup (rows ++ [(key,value)]) key = some value := by
  induction rows with
  | nil => change (if key = key then some value else none) = some value; rw [ite_eq_left rfl]
  | cons pair rest ih =>
    cases pair with
    | mk k v =>
      change (match lookup (rest ++ [(key,value)]) key with | some result => some result | none => if k = key then some v else none) = _
      rw [ih]

theorem arrowPreservationMeaning (arrow : Arrow) (objects : List (String × String)) (images : List (String × Arrow)) :
    preservesArrow arrow objects images = true ↔ ∃ image source target,
      lookup images arrow.name = some image ∧ lookup objects arrow.source = some source ∧
      lookup objects arrow.target = some target ∧ image.source = source ∧ image.target = target := by
  unfold preservesArrow
  cases hi : lookup images arrow.name with
  | none =>
    constructor
    · intro h; cases h
    · intro ⟨image,source,target,h,_⟩; cases h
  | some image =>
    cases hs : lookup objects arrow.source with
    | none =>
      constructor
      · intro h; cases h
      · intro ⟨image,source,target,_,h,_⟩; cases h
    | some source =>
      cases ht : lookup objects arrow.target with
      | none =>
        constructor
        · intro h; cases h
        · intro ⟨image,source,target,_,_,h,_⟩; cases h
      | some target =>
        constructor
        · intro h
          have p := (andTrue _ _).mp h
          exact ⟨image,source,target,rfl,rfl,rfl,of_decide_eq_true p.1,of_decide_eq_true p.2⟩
        · intro ⟨i,s,t,ei,es,et,hsource,htarget⟩
          cases ei; cases es; cases et
          exact (andTrue _ _).mpr ⟨decide_eq_true hsource,decide_eq_true htarget⟩

theorem functorMeaning (arrows : List Arrow) (objects : List (String × String)) (images : List (String × Arrow)) :
    functorPreserves arrows objects images = true ↔ ∀ arrow, arrow ∈ arrows → preservesArrow arrow objects images = true :=
  allTrueIffMembers _ _

theorem emptyFunctor (objects : List (String × String)) (images : List (String × Arrow)) :
    functorPreserves [] objects images = true := rfl

theorem foldRestTrace (held : Arrow) (rest : List Arrow) (result : Arrow) (h : foldRest held rest = .ok result) :
    result.source = held.source ∧ result.trace = held.trace ++ rest.flatMap Arrow.trace := by
  induction rest generalizing held with
  | nil =>
    cases h
    exact ⟨rfl,(CategoryIdentity.appendNil _).symm⟩
  | cons next rest ih =>
    change (match compose held next with | .error e => (Except.error e : Except String Arrow) | .ok joined => foldRest joined rest) = .ok result at h
    cases hc : compose held next with
    | error e => rw [hc] at h; cases h
    | ok joined =>
      rw [hc] at h
      have tail := ih joined h
      have step := composeRetains _ _ _ hc
      refine ⟨tail.1.trans step.1,?_⟩
      rw [tail.2,step.2.2]
      exact ExactTraceArithmetic.appendAssociative _ _ _

theorem foldPathTrace (first : Arrow) (rest : List Arrow) (result : Arrow)
    (h : foldPath (first :: rest) = .ok result) :
    result.source = first.source ∧ result.trace = (first :: rest).flatMap Arrow.trace :=
  foldRestTrace _ _ _ h

theorem routeMeaning (left right : Arrow) : sameRoute left right = true ↔
    left.source = right.source ∧ left.target = right.target ∧ canonicalPath left = canonicalPath right := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    exact ⟨of_decide_eq_true q.1,of_decide_eq_true q.2,of_decide_eq_true p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨decide_eq_true h.1,decide_eq_true h.2.1⟩,decide_eq_true h.2.2⟩

theorem naturalityResult (left right : List Arrow) (l r : Arrow)
    (hl : foldPath left = .ok l) (hr : foldPath right = .ok r) :
    naturalityCommutes left right = .ok true ↔
    l.source = r.source ∧ l.target = r.target ∧ canonicalPath l = canonicalPath r := by
  unfold naturalityCommutes
  rw [hl,hr]
  change (Except.ok (sameRoute l r) : Except String Bool) = .ok true ↔ _
  constructor
  · intro h
    have hb : sameRoute l r = true := Except.ok.inj h
    exact (routeMeaning _ _).mp hb
  · intro h
    rw [(routeMeaning _ _).mpr h]

theorem leftPathError (left right : List Arrow) (e : String) (h : foldPath left = .error e) :
    naturalityCommutes left right = .error e := by
  unfold naturalityCommutes; rw [h]

theorem rightPathError (left right : List Arrow) (l : Arrow) (e : String)
    (hl : foldPath left = .ok l) (hr : foldPath right = .error e) :
    naturalityCommutes left right = .error e := by
  unfold naturalityCommutes; rw [hl,hr]

end SFT.Mathematics.CategoryTransport
