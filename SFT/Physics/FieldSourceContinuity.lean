import SFT.Physics.FieldInteractionClasses
namespace SFT.Physics.FieldSourceContinuity
open MechanicalConservation

variable {Node Carrier : Type}

def departuresInside (inside : Node → Bool) : Network Node Carrier → Nat
  | [] => 0
  | t :: ts => match inside t.source with
    | false => departuresInside inside ts
    | true => departuresInside inside ts + 1

def arrivalsInside (inside : Node → Bool) : Network Node Carrier → Nat
  | [] => 0
  | t :: ts => match inside t.destination with
    | false => arrivalsInside inside ts
    | true => arrivalsInside inside ts + 1

def outward (inside : Node → Bool) : Network Node Carrier → Network Node Carrier
  | [] => []
  | t :: ts => match inside t.source,inside t.destination with
    | true,false => t :: outward inside ts
    | true,true => outward inside ts
    | false,true => outward inside ts
    | false,false => outward inside ts

def inward (inside : Node → Bool) : Network Node Carrier → Network Node Carrier
  | [] => []
  | t :: ts => match inside t.source,inside t.destination with
    | false,true => t :: inward inside ts
    | true,true => inward inside ts
    | true,false => inward inside ts
    | false,false => inward inside ts

theorem outwardMember (inside : Node → Bool) (network : Network Node Carrier)
    (t : Transfer Node Carrier) : t ∈ outward inside network ↔
      t ∈ network ∧ inside t.source = true ∧ inside t.destination = false := by
  induction network with
  | nil =>
    constructor
    · intro h; cases h
    · intro h; cases h.1
  | cons x xs ih =>
    cases hs : inside x.source <;> cases hd : inside x.destination <;>
      simp only [outward,hs,hd]
    all_goals
      constructor
      · intro h
        first
        | have old := ih.mp h; exact ⟨.tail _ old.1,old.2⟩
        | cases h with
          | head => exact ⟨.head _,hs,hd⟩
          | tail _ h => have old := ih.mp h; exact ⟨.tail _ old.1,old.2⟩
      · intro h
        cases h.1 with
        | head =>
          first
          | exact .head _
          | exact False.elim (Bool.noConfusion (hs.symm.trans h.2.1))
          | exact False.elim (Bool.noConfusion (hd.symm.trans h.2.2))
        | tail _ hmem =>
          first
          | exact ih.mpr ⟨hmem,h.2⟩
          | exact .tail _ (ih.mpr ⟨hmem,h.2⟩)


theorem inwardAsComplement (inside : Node → Bool) (network : Network Node Carrier) :
    inward inside network = outward (fun n => !(inside n)) network := by
  induction network with
  | nil => rfl
  | cons t ts ih =>
    cases hs : inside t.source <;> cases hd : inside t.destination <;>
      simp only [inward,outward,hs,hd,Bool.not_false,Bool.not_true]
    · exact ih
    · exact congrArg (List.cons t) ih
    · exact ih
    · exact ih

theorem inwardMember (inside : Node → Bool) (network : Network Node Carrier)
    (t : Transfer Node Carrier) : t ∈ inward inside network ↔
      t ∈ network ∧ inside t.source = false ∧ inside t.destination = true := by
  rw [inwardAsComplement]
  constructor
  · intro member
    have h := (outwardMember (fun n => !(inside n)) network t).mp member
    have a : inside t.source = false := by
      cases hs : inside t.source
      · rfl
      · have bad := h.2.1; rw [hs] at bad; cases bad
    have b : inside t.destination = true := by
      cases hd : inside t.destination
      · have bad := h.2.2; rw [hd] at bad; cases bad
      · rfl
    exact ⟨h.1,a,b⟩
  · intro h
    apply (outwardMember (fun n => !(inside n)) network t).mpr
    exact ⟨h.1,by rw [h.2.1]; rfl,by rw [h.2.2]; rfl⟩

theorem exactInteriorBoundaryBalance (inside : Node → Bool) (network : Network Node Carrier) :
    departuresInside inside network + (inward inside network).length =
      arrivalsInside inside network + (outward inside network).length := by
  induction network with
  | nil => rfl
  | cons t ts ih =>
    cases hs : inside t.source <;> cases hd : inside t.destination <;>
      simp only [departuresInside,arrivalsInside,outward,inward,hs,hd,List.length_cons]
    · exact ih
    · exact (Nat.add_assoc _ _ 1).symm.trans ((congrArg (fun n => n+1) ih).trans (Nat.add_right_comm _ _ 1))
    · exact (Nat.add_right_comm _ 1 _).trans ((congrArg (fun n => n+1) ih).trans (Nat.add_assoc _ _ 1))
    · exact (Nat.add_right_comm _ 1 _).trans ((congrArg (fun n => n+1) ih).trans (Nat.add_right_comm _ _ 1))

def interiorLosses (inside : Node → Bool) (network : Network Node Carrier) := departures (outward inside network)
def boundaryOutflow (inside : Node → Bool) (network : Network Node Carrier) := arrivals (outward inside network)
def interiorGains (inside : Node → Bool) (network : Network Node Carrier) := arrivals (inward inside network)
def boundaryInflow (inside : Node → Bool) (network : Network Node Carrier) := departures (inward inside network)

theorem lossExactlyOutflow (inside : Node → Bool) (network : Network Node Carrier) :
    (interiorLosses inside network).map Prod.snd = (boundaryOutflow inside network).map Prod.snd :=
  completeConservation _

theorem gainExactlyInflow (inside : Node → Bool) (network : Network Node Carrier) :
    (interiorGains inside network).map Prod.snd = (boundaryInflow inside network).map Prod.snd :=
  (completeConservation _).symm

theorem noUnrecordedOutflow (inside : Node → Bool) (network : Network Node Carrier)
    (t : Transfer Node Carrier) (h : t ∈ outward inside network) :
    t ∈ network ∧ inside t.source = true ∧ inside t.destination = false := (outwardMember inside network t).mp h

theorem noOmittedOutflow (inside : Node → Bool) (network : Network Node Carrier)
    (t : Transfer Node Carrier) (h : t ∈ network) (hs : inside t.source = true) (hd : inside t.destination = false) :
    t ∈ outward inside network := (outwardMember inside network t).mpr ⟨h,hs,hd⟩
end SFT.Physics.FieldSourceContinuity
