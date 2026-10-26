import SFT.Foundation.FormCanonicalRaw
namespace SFT.Foundation.FormEquivalenceRaw
open FormConstruction FormCanonicalRaw FormIdentity

/-! Constructive equality for the finite tuple/string representation used by
canonical_trace; recurse over both the value and its nested list constructors. -/
mutual
  def valueDecEq (left right : TupleValue) : Decidable (left = right) :=
    match left, right with
    | .text s, .text t => match (inferInstance : Decidable (s = t)) with
      | isTrue h => isTrue (congrArg TupleValue.text h)
      | isFalse h => isFalse (fun eq => h (TupleValue.text.inj eq))
    | .text _, .tuple _ => isFalse (by intro h; cases h)
    | .tuple _, .text _ => isFalse (by intro h; cases h)
    | .tuple vs, .tuple ws => match listDecEq vs ws with
      | isTrue h => isTrue (congrArg TupleValue.tuple h)
      | isFalse h => isFalse (fun eq => h (TupleValue.tuple.inj eq))
  termination_by structural left

  def listDecEq (left right : List TupleValue) : Decidable (left = right) :=
    match left, right with
    | [], [] => isTrue rfl
    | [], _::_ => isFalse (by intro h; cases h)
    | _::_, [] => isFalse (by intro h; cases h)
    | a::as, b::bs => match valueDecEq a b with
      | isFalse h => isFalse (fun eq => h (List.cons.inj eq).1)
      | isTrue hab => match listDecEq as bs with
        | isFalse h => isFalse (fun eq => h (List.cons.inj eq).2)
        | isTrue hs => isTrue ((congrArg (fun x => x::as) hab).trans (congrArg (fun x => b::x) hs))
  termination_by structural left
end

def valueEqual (left right : TupleValue) : Bool := @decide (left = right) (valueDecEq left right)

theorem valueEqualIff (left right : TupleValue) : valueEqual left right = true ↔ left = right := by
  unfold valueEqual
  cases valueDecEq left right with
  | isTrue h => exact ⟨fun _ => h, fun _ => rfl⟩
  | isFalse h =>
    constructor
    · intro eq; cases eq
    · intro eq; exact False.elim (h eq)

def equivalent (left right : TupleValue) : Except String Bool :=
  match canonical left with
  | .error e => .error e
  | .ok l => match canonical right with
    | .error e => .error e
    | .ok r => .ok (valueEqual l r)

theorem leftErrorFirst (left right : TupleValue) (e : String) (h : canonical left = .error e) :
    equivalent left right = .error e := by
  unfold equivalent
  rw [h]

theorem rightErrorAfterLeft (left right l : TupleValue) (e : String)
    (hl : canonical left = .ok l) (hr : canonical right = .error e) : equivalent left right = .error e := by
  unfold equivalent
  rw [hl,hr]

theorem generatedEquivalence (left right : Form) : equivalent (encode left) (encode right) = .ok true ↔ left = right := by
  unfold equivalent
  rw [generatedTrace,generatedTrace]
  constructor
  · intro h
    exact traceInjective left right ((valueEqualIff _ _).mp (Except.ok.inj h))
  · intro h
    exact congrArg Except.ok ((valueEqualIff _ _).mpr (congrArg canonicalTrace h))

theorem canonicalOutputsDetermineEquivalence (left right l r : TupleValue)
    (hl : canonical left = .ok l) (hr : canonical right = .ok r) :
    equivalent left right = .ok true ↔ l = r := by
  unfold equivalent
  rw [hl,hr]
  exact ⟨fun h => (valueEqualIff _ _).mp (Except.ok.inj h),fun h => congrArg Except.ok ((valueEqualIff _ _).mpr h)⟩

end SFT.Foundation.FormEquivalenceRaw
