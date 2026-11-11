import SFT.Chemistry.SubstanceIdentity
namespace SFT.Chemistry.AmountCount

structure Member (Carrier Kind : Type) where
 carrier : Carrier
 kind : Kind

structure Amount (Carrier Kind Unit : Type) where
 reference : Kind
 members : List (Member Carrier Kind)
 unitComparison : Unit

variable {C K U : Type}
def admitted (a : Amount C K U) : Prop :=
 a.members ≠ [] ∧ ∀ member, member ∈ a.members → member.kind = a.reference

def measure (a : Amount C K U) : Nat := a.members.length

def initial (member : Member C K) (unit : U) : Amount C K U :=
 ⟨member.kind,[member],unit⟩

def append (a : Amount C K U) (member : Member C K) : Amount C K U :=
 {a with members := a.members ++ [member]}

theorem initialAdmitted (member : Member C K) (unit : U) : admitted (initial member unit) := by
 refine ⟨(fun h => nomatch h), ?_⟩
 intro row held
 cases held with
 | head => rfl
 | tail _ impossible => cases impossible

theorem initialMeasure (member : Member C K) (unit : U) : measure (initial member unit) = 1 := rfl

theorem positiveMeasure (a : Amount C K U) (valid : admitted a) : 0 < measure a := by
 cases members : a.members with
 | nil => exact False.elim (valid.1 members)
 | cons first rest =>
   change 0 < a.members.length
   rw [members]
   exact Nat.zero_lt_succ _

theorem successorMeasure (a : Amount C K U) (member : Member C K) :
 measure (append a member) = measure a + 1 :=
 SFT.Foundation.CommonRefinement.appendLength a.members [member]

theorem successorRetains (a : Amount C K U) (member prior : Member C K)
 (held : prior ∈ a.members) : prior ∈ (append a member).members :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft prior a.members [member] held

theorem successorAdmitted (a : Amount C K U) (member : Member C K)
 (valid : admitted a) (same : member.kind = a.reference) : admitted (append a member) := by
 refine ⟨?_,?_⟩
 · intro empty
   have held : member ∈ (append a member).members := List.mem_append_right _ (List.Mem.head _)
   rw [empty] at held
   cases held
 · intro prior held
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases prior a.members [member] held with
   | inl old => exact valid.2 prior old
   | inr fresh =>
     cases fresh with
     | head => exact same
     | tail _ impossible => cases impossible

theorem differentKindRejected (a : Amount C K U) (member : Member C K)
 (different : member.kind ≠ a.reference) : ¬ admitted (append a member) :=
 fun valid => different (valid.2 member (List.mem_append_right _ (List.Mem.head _)))

theorem referenceRetained (a : Amount C K U) (member : Member C K) :
 (append a member).reference = a.reference := rfl

theorem unitBoundaryRetained (a : Amount C K U) (member : Member C K) :
 (append a member).unitComparison = a.unitComparison := rfl

def rerecordUnit (a : Amount C K U) (unit : U) : Amount C K U := {a with unitComparison := unit}

theorem unitDoesNotSelectCount (a : Amount C K U) (unit : U) : measure (rerecordUnit a unit) = measure a := rfl

def reidentify {D : Type} (f : C → D) (a : Amount C K U) : Amount D K U :=
 ⟨a.reference,a.members.map (fun row => ⟨f row.carrier,row.kind⟩),a.unitComparison⟩

theorem carrierChangeDoesNotSelectCount {D : Type} (f : C → D) (a : Amount C K U) :
 measure (reidentify f a) = measure a := SFT.Foundation.CommonRefinement.mapLength _ _

inductive History : Amount C K U → Amount C K U → Prop where
 | base (a : Amount C K U) (valid : admitted a) : History a a
 | next {first prior : Amount C K U} (history : History first prior)
   (member : Member C K) (same : member.kind = prior.reference) : History first (append prior member)

theorem historyAdmitted {first last : Amount C K U} (history : History first last) : admitted last := by
 induction history with
 | base valid => exact valid
 | next prior member same ih => exact successorAdmitted _ member ih same

theorem historyReference {first last : Amount C K U} (history : History first last) : last.reference = first.reference := by
 induction history with
 | base => rfl
 | next prior member same ih => exact ih

theorem historyRetainsMembers {first last : Amount C K U} (history : History first last)
 (member : Member C K) (held : member ∈ first.members) : member ∈ last.members := by
 induction history with
 | base => exact held
 | next prior new same ih => exact successorRetains _ new member ih

inductive Generated : Amount C K U → Prop where
 | one (member : Member C K) (unit : U) : Generated (initial member unit)
 | next {prior : Amount C K U} (previous : Generated prior) (member : Member C K)
   (same : member.kind = prior.reference) : Generated (append prior member)

theorem generatedAdmitted {a : Amount C K U} (generated : Generated a) : admitted a := by
 induction generated with
 | one member unit => exact initialAdmitted member unit
 | next prior member same ih => exact successorAdmitted _ member ih same

theorem forcedCountUnique (value : Amount C K U → Nat)
 (base : ∀ member unit, value (initial member unit) = 1)
 (step : ∀ a member, Generated a → member.kind = a.reference →
   value (append a member) = value a + 1)
 {a : Amount C K U} (generated : Generated a) : value a = measure a := by
 induction generated with
 | one member unit => exact base member unit
 | @next prior generated member same ih =>
   exact (step prior member generated same).trans
     ((congrArg (fun n => n+1) ih).trans (successorMeasure prior member).symm)

theorem factorForcedToOne (factor : Nat) (member : Member C K) (unit : U)
 (same : factor * measure (initial member unit) = measure (initial member unit)) : factor = 1 := by
 change factor * 1 = 1 at same
 rw [Nat.mul_one] at same
 exact same

end SFT.Chemistry.AmountCount
