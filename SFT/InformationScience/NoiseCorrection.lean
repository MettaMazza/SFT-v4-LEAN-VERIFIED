import SFT.InformationScience.NoiseRelation
namespace SFT.InformationScience.NoiseCorrection
open NoiseRelation
inductive CorrectionRecord where
  | uniqueSource : Word → CorrectionRecord
  | closedSourceClass : List Word → CorrectionRecord
  deriving DecidableEq

def uniquelyCorrectable (relation : ErrorRelation) (received : Word) : Except String Bool :=
  match predecessors relation received with
  | .error e => .error e
  | .ok held => .ok (decide (held.length = 1))

def record (held : List Word) : CorrectionRecord :=
  match held with
  | [] => .closedSourceClass []
  | source :: rest => match rest with
    | [] => .uniqueSource source
    | next :: tail => .closedSourceClass (source :: next :: tail)

def correctionRecord (relation : ErrorRelation) (received : Word) : Except String CorrectionRecord :=
  match predecessors relation received with
  | .error e => .error e
  | .ok held => .ok (record held)

theorem singletonLength (held : List Word) : held.length = 1 ↔ ∃ source, held = [source] := by
  cases held with
  | nil => constructor; intro h; cases h; intro ⟨source,h⟩; cases h
  | cons source rest =>
    cases rest with
    | nil => exact ⟨fun _ => ⟨source,rfl⟩,fun _ => rfl⟩
    | cons next tail =>
      constructor
      · intro h; have no := Nat.succ.inj h; cases no
      · intro ⟨value,h⟩; cases h

theorem recordUnique (held : List Word) (source : Word) :
    record held = .uniqueSource source ↔ held = [source] := by
  cases held with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest => cases rest with
    | nil => constructor
             · intro h; have e := CorrectionRecord.uniqueSource.inj h; cases e; rfl
             · intro h; cases h; rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem recordClosed (held : List Word) (h : held.length ≠ 1) :
    record held = .closedSourceClass held := by
  cases held with
  | nil => rfl
  | cons first rest => cases rest with
    | nil => exact False.elim (h rfl)
    | cons next tail => rfl

theorem correctableMeaning (relation : ErrorRelation) (received : Word) :
    uniquelyCorrectable relation received = .ok true ↔
      received ∈ relation.received ∧ ∃ source, rawPredecessors relation.relation received = [source] := by
  unfold uniquelyCorrectable
  cases hp : predecessors relation received with
  | error e =>
    constructor
    · intro h; cases h
    · intro h
      have yes := (predecessorsMeaning _ _ _).mpr ⟨h.1,rfl⟩
      rw [hp] at yes; cases yes
  | ok held =>
    have p := (predecessorsMeaning _ _ _).mp hp
    constructor
    · intro h
      have yes := of_decide_eq_true (Except.ok.inj h)
      obtain ⟨source,he⟩ := (singletonLength held).mp yes
      exact ⟨p.1,source,p.2.symm.trans he⟩
    · intro h
      have one := (singletonLength held).mpr (by rw [p.2]; exact h.2)
      exact congrArg Except.ok (decide_eq_true one)

theorem correctionMeaning (relation : ErrorRelation) (received source : Word) :
    correctionRecord relation received = .ok (.uniqueSource source) ↔
      received ∈ relation.received ∧ rawPredecessors relation.relation received = [source] := by
  unfold correctionRecord
  cases hp : predecessors relation received with
  | error e =>
    constructor
    · intro h; cases h
    · intro h
      have yes := (predecessorsMeaning _ _ _).mpr ⟨h.1,rfl⟩
      rw [hp] at yes; cases yes
  | ok held =>
    have p := (predecessorsMeaning _ _ _).mp hp
    constructor
    · intro h
      exact ⟨p.1,p.2.symm.trans ((recordUnique _ _).mp (Except.ok.inj h))⟩
    · intro h
      have eq := (recordUnique held source).mpr (p.2.trans h.2)
      exact congrArg Except.ok eq

theorem ambiguousRetainsAll (relation : ErrorRelation) (received : Word)
    (inside : received ∈ relation.received)
    (multiple : (rawPredecessors relation.relation received).length ≠ 1) :
    correctionRecord relation received = .ok (.closedSourceClass (rawPredecessors relation.relation received)) := by
  unfold correctionRecord
  rw [(predecessorsMeaning _ _ _).mpr ⟨inside,rfl⟩]
  exact congrArg Except.ok (recordClosed _ multiple)

theorem correctionRegistered (relation : ErrorRelation) (received source : Word)
    (h : correctionRecord relation received = .ok (.uniqueSource source)) :
    ∃ action, (source,received,action) ∈ relation.relation := by
  have p := (correctionMeaning _ _ _).mp h
  apply (predecessorsMembership _ _ _).mp
  rw [p.2]; exact List.Mem.head []

theorem noUnrecordedCorrection (relation : ErrorRelation) (received source other : Word)
    (h : correctionRecord relation received = .ok (.uniqueSource source))
    (action : String) (cell : (other,received,action) ∈ relation.relation) : other = source := by
  have p := (correctionMeaning _ _ _).mp h
  have hm := (predecessorsMembership _ _ _).mpr ⟨action,cell⟩
  rw [p.2] at hm
  cases hm with
  | head => rfl
  | tail _ h => cases h

end SFT.InformationScience.NoiseCorrection
