import SFT.Chemistry.ValenceMaximum
import SFT.Physics.FieldElectricDistinction
namespace SFT.Chemistry.IonTransfer
open SFT.Physics
abbrev Held := MechanicalLocation.Held
inductive Carrier where
 | atomic (atom : ElementIdentity.Atom)
 | molecular (first : ElementIdentity.Atom) (rest : List ElementIdentity.Atom) (identity : EntityIdentity.Record)
inductive Side where
 | particle | boundary
inductive Direction where
 | incoming | outgoing
structure Transfer where
 held : Held
 direction : Direction
 sourceIdentity : String
 sourceTrace : SFT.Host.Canonical.Value

def edge (t : Transfer) : MechanicalConservation.Transfer Side Held :=
 match t.direction with
 | .incoming => ⟨.boundary,.particle,t.held,t.sourceIdentity,t.sourceTrace⟩
 | .outgoing => ⟨.particle,.boundary,t.held,t.sourceIdentity,t.sourceTrace⟩

def contribution (t : Transfer) : Held :=
 match t.direction with
 | .incoming => t.held
 | .outgoing => MechanicalLocation.opposite t.held

structure Counts where
 first : Nat
 second : Nat

def add (counts : Counts) (held : Held) : Counts :=
 match held with
 | .first => ⟨counts.first+1,counts.second⟩
 | .second => ⟨counts.first,counts.second+1⟩

def account : Counts → List Transfer → Counts
 | counts, [] => counts
 | counts, t :: rest => account (add counts (contribution t)) rest

inductive Net where
 | neutral
 | charged (held : Held) (count : Nat) (positive : 0 < count)

def net (counts : Counts) : Net :=
 if h : counts.second < counts.first then
  .charged .first (counts.first-counts.second) (SFT.Foundation.ExactCast.subtractPositive _ _ h)
 else if h : counts.first < counts.second then
  .charged .second (counts.second-counts.first) (SFT.Foundation.ExactCast.subtractPositive _ _ h)
 else .neutral

structure State where
 carrier : Carrier
 initial : Counts
 transfers : List Transfer

def charge (state : State) := net (account state.initial state.transfers)
def isIon (state : State) : Prop := charge state ≠ .neutral

def append (state : State) (transfer : Transfer) : State :=
 {state with transfers := state.transfers ++ [transfer]}

theorem accountAppend (counts : Counts) (history : List Transfer) (transfer : Transfer) :
 account counts (history ++ [transfer]) = add (account counts history) (contribution transfer) := by
 induction history generalizing counts with
 | nil => rfl
 | cons t rest ih => exact ih (add counts (contribution t))

theorem chargeSuccessor (state : State) (transfer : Transfer) :
 charge (append state transfer) = net (add (account state.initial state.transfers) (contribution transfer)) :=
 congrArg net (accountAppend _ _ _)

theorem carrierRetained (state : State) (transfer : Transfer) : (append state transfer).carrier = state.carrier := rfl

theorem priorTransfersRetained (state : State) (transfer prior : Transfer) (held : prior ∈ state.transfers) :
 prior ∈ (append state transfer).transfers := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem closedTransferConservation (history : List Transfer) :
 MechanicalConservation.outgoingSupport (history.map edge) = MechanicalConservation.incomingSupport (history.map edge) :=
 MechanicalConservation.completeConservation _

theorem transferredHeldRetained (transfer : Transfer) : (edge transfer).carrier = transfer.held := by
 cases transfer with
 | mk held direction source trace => cases direction <;> rfl

theorem incomingCount (counts : Counts) (transfer : Transfer) (direction : transfer.direction = .incoming) :
 add counts (contribution transfer) = add counts transfer.held := by
 unfold contribution
 rw [direction]

theorem outgoingCount (counts : Counts) (transfer : Transfer) (direction : transfer.direction = .outgoing) :
 add counts (contribution transfer) = add counts (MechanicalLocation.opposite transfer.held) := by
 unfold contribution
 rw [direction]

theorem neutralExactly (counts : Counts) : net counts = .neutral ↔ counts.first = counts.second := by
 unfold net
 split
 · rename_i h
   constructor
   · intro impossible; cases impossible
   · intro same; exact False.elim (Nat.ne_of_lt h same.symm)
 · rename_i first
   split
   · rename_i second
     constructor
     · intro impossible; cases impossible
     · intro same; exact False.elim (Nat.ne_of_lt second same)
   · rename_i second
     exact ⟨fun _ => Nat.le_antisymm (Nat.le_of_not_gt first) (Nat.le_of_not_gt second),fun _ => rfl⟩

theorem ionExactly (state : State) : isIon state ↔
 (account state.initial state.transfers).first ≠ (account state.initial state.transfers).second :=
 ⟨fun charged same => charged ((neutralExactly _).mpr same),
 fun different neutral => different ((neutralExactly _).mp neutral)⟩

theorem firstBase (carrier : Carrier) : isIon ⟨carrier,⟨1,0⟩,[]⟩ := by
 apply (ionExactly _).mpr
 intro impossible
 cases impossible

theorem secondBase (carrier : Carrier) : isIon ⟨carrier,⟨0,1⟩,[]⟩ := by
 apply (ionExactly _).mpr
 intro impossible
 cases impossible

theorem nuclearIdentityRetained (atom : ElementIdentity.Atom) (electrons : List String) :
 ElementIdentity.identity (ElementIdentity.changeElectrons atom electrons) = ElementIdentity.identity atom :=
 (ElementIdentity.electronIdentity _ _).symm

theorem positiveCharge (held : Held) (count : Nat) (positive : 0 < count) :
 (Net.charged held count positive) ≠ .neutral := by intro h; cases h
end SFT.Chemistry.IonTransfer
