import SFT.Chemistry.Photochemistry
import SFT.Chemistry.IonTransfer
import SFT.Mathematics.DiscreteComposition
namespace SFT.Chemistry.UVVis
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
abbrev Value := SFT.Host.Canonical.Value
abbrev PositiveFraction := SFT.Foundation.ExactOperations.PositiveFraction

inductive Carrier where
 | molecular : MolecularCarrier.Carrier → Carrier
 | ionic (state : IonTransfer.State) (charged : IonTransfer.isIon state) : Carrier

structure State (carrier : Carrier) where
 identity : SFT.Physics.CapabilityValues.HeldLabel
 energy : PositiveFraction
 electronicRecord : Value
 sourceRecord : Value

def higher {c : Carrier} (before after : State c) : Bool :=
 decide (before.energy.numerator*after.energy.denominator <
  after.energy.numerator*before.energy.denominator)

theorem higherExactly {c : Carrier} (before after : State c) : higher before after=true ↔
 before.energy.numerator*after.energy.denominator < after.energy.numerator*before.energy.denominator :=
 ⟨of_decide_eq_true,decide_eq_true⟩

def pairs {c : Carrier} (states : List (State c)) :=
 states.flatMap (fun before => states.map (fun after => (before,after)))

def transitions {c : Carrier} (states : List (State c)) :=
 (pairs states).filter (fun p => higher p.1 p.2)

theorem pairsComplete {c : Carrier} (states : List (State c)) (before after : State c) :
 (before,after)∈pairs states ↔ before∈states ∧ after∈states := by
 constructor
 · intro held
   obtain ⟨a,ha,tail⟩ := memFlatMapOrigin _ _ _ held
   obtain ⟨b,hb,equal⟩ := memMapPreimage _ _ _ tail
   cases equal
   exact ⟨ha,hb⟩
 · intro h
   exact memFlatMap _ _ before _ h.1 (memMap _ _ _ h.2)

theorem transitionsComplete {c : Carrier} (states : List (State c)) (before after : State c) :
 (before,after)∈transitions states ↔ before∈states ∧ after∈states ∧ higher before after=true := by
 constructor
 · intro held
   have h := (filterMemberIff _ _ _).mp held
   have p := (pairsComplete states before after).mp h.1
   exact ⟨p.1,p.2,h.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨(pairsComplete _ _ _).mpr ⟨h.1,h.2.1⟩,h.2.2⟩

theorem noSelfTransition {c : Carrier} (state : State c) : higher state state=false :=
 decide_eq_false (Nat.lt_irrefl _)

theorem noReverseAbsorption {c : Carrier} (before after : State c) (forward : higher before after=true) :
 higher after before=false := decide_eq_false (Nat.not_lt_of_gt ((higherExactly _ _).mp forward))

-- The source supplies the registered observation for each generated ordered pair.
-- The finite construction enumerates the pairs; no fitted band selects them.
structure Response where
 wavelength : PositiveFraction
 countedResponse : SFT.Physics.CapabilityValues.PositiveCount
 incident : SFT.Physics.MechanicalDuration.Recurrence Value
 sourceRecord : Value

structure Spectrum (carrier : Carrier) where
 states : List (State carrier)
 response : State carrier → State carrier → Response
 method : SFT.Physics.CapabilityValues.HeldLabel
 conditions : Value

def pattern {c : Carrier} (spectrum : Spectrum c) :=
 (transitions spectrum.states).map (fun p => (p,spectrum.response p.1 p.2))

theorem everyOrderedResponse {c : Carrier} (spectrum : Spectrum c) (before after : State c)
 (hb : before∈spectrum.states) (ha : after∈spectrum.states) (order : higher before after=true) :
 ((before,after),spectrum.response before after)∈pattern spectrum :=
 memMap _ _ _ ((transitionsComplete _ _ _).mpr ⟨hb,ha,order⟩)

theorem noInventedResponse {c : Carrier} (spectrum : Spectrum c) (row : (State c×State c)×Response)
 (held : row∈pattern spectrum) : ∃ before∈spectrum.states, ∃ after∈spectrum.states,
 higher before after=true ∧ ((before,after),spectrum.response before after)=row := by
 obtain ⟨pair,member,equal⟩ := memMapPreimage _ _ _ held
 have h := (transitionsComplete _ _ _).mp member
 exact ⟨pair.1,h.1,pair.2,h.2.1,h.2.2,equal⟩

def append {c : Carrier} (spectrum : Spectrum c) (state : State c) : Spectrum c :=
 {spectrum with states := spectrum.states++[state]}

theorem appendedTransitionExactly {c : Carrier} (spectrum : Spectrum c) (state before after : State c) :
 (before,after)∈transitions (append spectrum state).states ↔
 (before∈spectrum.states ∨ before=state) ∧ (after∈spectrum.states ∨ after=state) ∧ higher before after=true := by
 have member (x : State c) : x∈spectrum.states++[state] ↔ x∈spectrum.states ∨ x=state := by
  constructor
  · intro h
    cases memAppendCases x spectrum.states [state] h with
    | inl old => exact .inl old
    | inr fresh => cases fresh with
      | head => exact .inr rfl
      | tail _ impossible => cases impossible
  · intro h
    cases h with
    | inl old => exact memAppendLeft _ _ _ old
    | inr same => cases same; exact memAppendRight _ _ _ (.head [])
 constructor
 · intro h
   have p := (transitionsComplete _ _ _).mp h
   exact ⟨(member before).mp p.1,(member after).mp p.2.1,p.2.2⟩
 · intro h
   exact (transitionsComplete _ _ _).mpr ⟨(member before).mpr h.1,(member after).mpr h.2.1,h.2.2⟩

theorem priorPairRetained {c : Carrier} (spectrum : Spectrum c) (state before after : State c)
 (held : (before,after)∈transitions spectrum.states) :
 ((before,after),spectrum.response before after)∈pattern (append spectrum state) := by
 have h := (transitionsComplete _ _ _).mp held
 exact everyOrderedResponse _ _ _ (memAppendLeft _ _ _ h.1) (memAppendLeft _ _ _ h.2.1) h.2.2

theorem successorResponseUnchanged {c : Carrier} (spectrum : Spectrum c) (state before after : State c) :
 (append spectrum state).response before after=spectrum.response before after := rfl

theorem successorBoundary {c : Carrier} (spectrum : Spectrum c) (state : State c) :
 (append spectrum state).method=spectrum.method ∧ (append spectrum state).conditions=spectrum.conditions := ⟨rfl,rfl⟩

theorem firstOrderedPair {c : Carrier} (before after : State c) (order : higher before after=true) :
 transitions [before,after]=[(before,after)] := by
 change ([(before,before),(before,after),(after,before),(after,after)].filter
  (fun p => higher p.1 p.2))=[(before,after)]
 rw [List.filter_cons_of_neg (by rw [noSelfTransition]; intro h; cases h)]
 rw [List.filter_cons_of_pos (p := fun p : State c × State c => higher p.1 p.2) (a := (before,after)) order]
 rw [List.filter_cons_of_neg (by rw [noReverseAbsorption _ _ order]; intro h; cases h)]
 rw [List.filter_cons_of_neg (by rw [noSelfTransition]; intro h; cases h)]
 rfl

def base {c : Carrier} (before after : State c) (responses : State c → State c → Response)
 (method : SFT.Physics.CapabilityValues.HeldLabel) (conditions : Value) : Spectrum c :=
 ⟨[before,after],responses,method,conditions⟩

theorem firstResponse {c : Carrier} (before after : State c) (responses : State c → State c → Response)
 (method : SFT.Physics.CapabilityValues.HeldLabel) (conditions : Value) (order : higher before after=true) :
 pattern (base before after responses method conditions)=[((before,after),responses before after)] := by
 unfold pattern base
 rw [firstOrderedPair before after order]
 rfl

end SFT.Chemistry.UVVis
