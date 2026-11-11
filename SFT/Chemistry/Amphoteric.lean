import SFT.Chemistry.ProtonTransfer
namespace SFT.Chemistry.Amphoteric
open SFT.Foundation.Count.TraceDerivation
structure Raw where
 species : String
 donorEvent : ProtonTransfer.Transfer
 acceptorEvent : ProtonTransfer.Transfer

def admit (raw : Raw) : Except String Raw :=
 if !SourceText.nonblank raw.species || decide (raw.donorEvent.raw.donor≠raw.species) ||
 decide (raw.acceptorEvent.raw.acceptor≠raw.species) then
 .error "an amphoteric record requires the same species in donor and acceptor roles"
 else .ok raw
structure Record where
 raw : Raw
 accepted : admit raw=.ok raw

theorem donorIsSpecies (record : Record) : record.raw.donorEvent.raw.donor=record.raw.species := by
 by_cases same : record.raw.donorEvent.raw.donor=record.raw.species
 · exact same
 · have h := record.accepted
   unfold admit at h
   rw [decide_eq_true same] at h
   cases n : SourceText.nonblank record.raw.species <;> rw [n] at h <;> cases h

theorem acceptorIsSpecies (record : Record) : record.raw.acceptorEvent.raw.acceptor=record.raw.species := by
 by_cases same : record.raw.acceptorEvent.raw.acceptor=record.raw.species
 · exact same
 · have h := record.accepted
   unfold admit at h
   rw [decide_eq_true same] at h
   cases n : SourceText.nonblank record.raw.species <;>
    cases d : decide (record.raw.donorEvent.raw.donor≠record.raw.species) <;>
    rw [n,d] at h <;> cases h

def contexts (record : Record) := [record.raw.donorEvent,record.raw.acceptorEvent]
def Dual (species : String) (events : List ProtonTransfer.Transfer) :=
 (∃ event∈events, event.raw.donor=species) ∧ (∃ event∈events, event.raw.acceptor=species)
theorem bothRolesRealized (record : Record) : Dual record.raw.species (contexts record) :=
 ⟨⟨record.raw.donorEvent,.head _,donorIsSpecies record⟩,
  ⟨record.raw.acceptorEvent,.tail _ (.head []),acceptorIsSpecies record⟩⟩

theorem eventsDistinct (record : Record) : record.raw.donorEvent≠record.raw.acceptorEvent := by
 intro same
 have donor := donorIsSpecies record
 rw [same] at donor
 exact ProtonTransfer.endpointsDistinct record.raw.acceptorEvent (donor.trans (acceptorIsSpecies record).symm)

def append (events : List ProtonTransfer.Transfer) (event : ProtonTransfer.Transfer) := events++[event]
theorem priorContextRetained (events : List ProtonTransfer.Transfer) (event prior : ProtonTransfer.Transfer)
 (held : prior∈events) : prior∈append events event := memAppendLeft _ _ _ held
theorem dualityPreserved (species : String) (events : List ProtonTransfer.Transfer)
 (event : ProtonTransfer.Transfer) (dual : Dual species events) : Dual species (append events event) := by
 obtain ⟨⟨donor,heldD,roleD⟩,⟨acceptor,heldA,roleA⟩⟩ := dual
 exact ⟨⟨donor,priorContextRetained _ _ _ heldD,roleD⟩,⟨acceptor,priorContextRetained _ _ _ heldA,roleA⟩⟩
theorem closureRequiresBothRoles (species : String) (events : List ProtonTransfer.Transfer) :
 Dual species events ↔ (∃ donor∈events, donor.raw.donor=species) ∧
 (∃ acceptor∈events, acceptor.raw.acceptor=species) := Iff.rfl

theorem contextCarrierConserved (event : ProtonTransfer.Transfer) :
 (ProtonTransfer.input event.raw).1=(ProtonTransfer.output event.raw).1 := ProtonTransfer.carrierConserved event.raw

def secondProton : ProtonTransfer.HeldLabel := ⟨"proton-carrier","context-two-proton",rfl,rfl⟩
def originalDonor : ProtonTransfer.Transfer := ⟨⟨ConjugatePair.originalProton,"dual-role-species","context-one-acceptor"⟩,rfl⟩
def originalAcceptor : ProtonTransfer.Transfer := ⟨⟨secondProton,"context-two-donor","dual-role-species"⟩,rfl⟩
def originalRaw : Raw := ⟨"dual-role-species",originalDonor,originalAcceptor⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
def original : Record := ⟨originalRaw,originalAdmitted⟩
theorem originalDual : Dual original.raw.species (contexts original) := bothRolesRealized original
theorem originalCounterpartiesDistinct : originalDonor.raw.acceptor≠originalAcceptor.raw.donor := by decide
end SFT.Chemistry.Amphoteric
