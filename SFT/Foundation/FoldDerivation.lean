import SFT.Foundation.PartSelection
/-! fold.py minimal_count and generality: the first extension is the earliest
nonidentity stage of the already-derived Count trace. -/
namespace SFT.Foundation.FoldDerivation
open Count.TraceDerivation

inductive ExtensionClass where
  | identity | first | later

def extensionClass : Trace → ExtensionClass
  | .base => .identity
  | .extend .base => .first
  | .extend (.extend _) => .later

def firstExtension : Trace := .extend .base

inductive StagePrefix : Trace → Trace → Prop where
  | same (t : Trace) : StagePrefix t t
  | next {a b : Trace} : StagePrefix a b → StagePrefix a (.extend b)

def Nonidentity (t : Trace) : Prop := t ≠ .base

def MinimalNonidentity (t : Trace) : Prop :=
  Nonidentity t ∧ ∀ u, StagePrefix u t → Nonidentity u → u = t

theorem identityClassExact (t : Trace) : extensionClass t = .identity ↔ t = .base := by
  cases t with
  | base => exact ⟨fun _ => rfl,fun _ => rfl⟩
  | extend t =>
    cases t <;> constructor <;> intro h <;> cases h

theorem firstClassExact (t : Trace) : extensionClass t = .first ↔ t = firstExtension := by
  cases t with
  | base => constructor <;> intro h <;> cases h
  | extend t =>
    cases t with
    | base => exact ⟨fun _ => rfl,fun _ => rfl⟩
    | extend t => constructor <;> intro h <;> cases h

theorem laterClassExact (t : Trace) :
    extensionClass t = .later ↔ ∃ u, t = .extend (.extend u) := by
  cases t with
  | base =>
    constructor
    · intro h; cases h
    · intro ⟨u,h⟩; cases h
  | extend t =>
    cases t with
    | base =>
      constructor
      · intro h; cases h
      · intro ⟨u,h⟩; cases h
    | extend t => exact ⟨fun _ => ⟨t,rfl⟩,fun _ => rfl⟩

theorem prefixOfBase (t : Trace) (h : StagePrefix t .base) : t = .base := by
  cases h with
  | same => rfl

theorem prefixOfFirst (t : Trace) (h : StagePrefix t firstExtension) :
    t = .base ∨ t = firstExtension := by
  cases h with
  | same => exact Or.inr rfl
  | next h => exact Or.inl (prefixOfBase t h)

theorem firstIsNonidentity : Nonidentity firstExtension := by
  intro h; cases h

theorem everyNonidentityContainsFirst (t : Trace) (h : Nonidentity t) :
    StagePrefix firstExtension t := by
  induction t with
  | base => exact False.elim (h rfl)
  | extend t ih =>
    cases t with
    | base => exact StagePrefix.same _
    | extend t =>
      apply StagePrefix.next
      apply ih
      intro eq; cases eq

theorem firstIsMinimal : MinimalNonidentity firstExtension := by
  constructor
  · exact firstIsNonidentity
  · intro u hp hn
    cases prefixOfFirst u hp with
    | inl trivial => exact False.elim (hn trivial)
    | inr first => exact first

theorem minimalNonidentityUnique (t : Trace) (h : MinimalNonidentity t) :
    t = firstExtension :=
  (h.2 firstExtension (everyNonidentityContainsFirst t h.1) firstIsNonidentity).symm

theorem laterNotMinimal (t : Trace) : ¬ MinimalNonidentity (.extend (.extend t)) := by
  intro h
  have eq := minimalNonidentityUnique _ h
  cases eq

theorem identityNotMinimal : ¬ MinimalNonidentity .base := by
  intro h; exact h.1 rfl

theorem firstHasTwoRetainedPositions : (complete firstExtension).length = 2 := rfl

def firstPosition : Position firstExtension := .prior .base

def appendedPosition : Position firstExtension := .terminal

theorem firstPositionsDistinct : firstPosition ≠ appendedPosition := by
  intro h; cases h

theorem firstPositionDomainExhausted (p : Position firstExtension) :
    p = firstPosition ∨ p = appendedPosition := by
  cases p with
  | prior p => cases p; exact Or.inl rfl
  | terminal => exact Or.inr rfl

theorem firstCompleteRecord : complete firstExtension = [firstPosition,appendedPosition] := rfl

theorem firstPositionsRetainedOnce : (complete firstExtension).Nodup :=
  everyGeneratedPositionRetainedOnce firstExtension

end SFT.Foundation.FoldDerivation
