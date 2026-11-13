import SFT.Physics.CollectiveCoarseGrain
import SFT.Materials.MaterialCarrier
namespace SFT.Materials.BulkCorrespondence
open SFT.Physics
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[65]: a scale reading includes the entire generated
-- network and computed observation fibres, not a fitted bulk coefficient.
structure Reading where
 network : CollectiveCoarseGrain.NetworkObservation
 response : SFT.Host.Canonical.Value
 fluctuations : SFT.Host.Canonical.Value
 interfaces : SFT.Host.Canonical.Value
 method : SFT.Host.Canonical.Value

structure Record where
 first : Reading
 rest : List Reading
 preparationFirst : MechanicalEvents.Event CollectiveCoarseGrain.NetworkObservation
 preparationLast : MechanicalEvents.Event CollectiveCoarseGrain.NetworkObservation
 history : MechanicalEvents.Path preparationFirst preparationLast
 preparedNetwork : preparationLast.carrier.graph = first.network.graph
 completeNetworks : ∀ r ∈ rest, r.network.graph = first.network.graph
 representativeBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def readings (r : Record) := r.first::r.rest

def admitted (r : Record) : Prop := ∀ s ∈ readings r, s.response = r.first.response

theorem completeNetwork (r : Reading) : r.network.graph = ⟨r.network.nodes,r.network.edges⟩ :=
 CollectiveCoarseGrain.completeNetworkRetained r.network

theorem everyConstituentObserved (r : Reading) (cell : String) (held : cell ∈ r.network.graph.nodes) :
 ∃ label members, (label,members) ∈ r.network.classes ∧ cell ∈ members ∧
 ∀ other others, (other,others) ∈ r.network.classes → cell ∈ others → other = label ∧ others = members :=
 CollectiveCoarseGrain.everyCellHasUniqueClass r.network cell held

theorem eachClassComplete (r : Reading) (label : String) (members : List String)
 (held : (label,members) ∈ r.network.classes) :
 members = CollectiveCoarseGrain.region r.network label :=
 CollectiveCoarseGrain.everyClassIsCompleteFibre r.network label members held

theorem admittedScaleAgreement (r : Record) (ok : admitted r) (a b : Reading)
 (ha : a ∈ readings r) (hb : b ∈ readings r) : a.response = b.response :=
 (ok a ha).trans (ok b hb).symm

theorem scaleDisagreementRejects (r : Record) (a b : Reading)
 (ha : a ∈ readings r) (hb : b ∈ readings r) (different : a.response ≠ b.response) : ¬ admitted r :=
 fun ok => different (admittedScaleAgreement r ok a b ha hb)

def append (r : Record) (s : Reading) (sameNetwork : s.network.graph = r.first.network.graph) : Record :=
 {r with
  rest := r.rest++[s]
  completeNetworks := by
   intro a held
   cases memAppendCases a r.rest [s] held with
   | inl old => exact r.completeNetworks a old
   | inr added => cases added with
     | head => exact sameNetwork
     | tail _ impossible => cases impossible }

theorem appendedReadings (r : Record) (s : Reading) (sameNetwork : s.network.graph = r.first.network.graph) :
 readings (append r s sameNetwork) = readings r++[s] := rfl

theorem successorAdmissionExactly (r : Record) (s : Reading)
 (sameNetwork : s.network.graph = r.first.network.graph) :
 admitted (append r s sameNetwork) ↔ admitted r ∧ s.response = r.first.response := by
 constructor
 · intro ok
   exact ⟨fun a held => ok a (memAppendLeft _ _ _ held),ok s (memAppendRight s (readings r) [s] (.head []))⟩
 · intro ⟨prior,added⟩ a held
   cases memAppendCases a (readings r) [s] held with
   | inl old => exact prior a old
   | inr new => cases new with
     | head => exact added
     | tail _ impossible => cases impossible

theorem allHistoryEvents (r : Record) :
 (MechanicalEvents.events r.history).length = MechanicalEvents.count r.history+1 :=
 MechanicalEvents.completeEventCount r.history

theorem allPreparationActions (r : Record) :
 (MechanicalEvents.changes r.history).map (fun row => (row.sourceIdentity,row.actionRecord)) =
 MechanicalEvents.sourceRecords r.history := MechanicalEvents.allSourceRecordsRetained r.history

def observation (r : Reading) := (r,r.network.classes)

theorem fluctuationAndInterfaceRetained (r : Reading) :
 (observation r).1.fluctuations = r.fluctuations ∧ (observation r).1.interfaces = r.interfaces := ⟨rfl,rfl⟩

def record (r : Record) := (r,(readings r).map observation,MechanicalEvents.events r.history,MechanicalEvents.changes r.history)

theorem wholeInputRetained (r : Record) : (record r).1 = r := rfl

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) : records (rs++[r]) = records rs++[record r] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.BulkCorrespondence
