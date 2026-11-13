import SFT.Chemistry.PolymerChain
import SFT.Materials.MaterialCarrier
namespace SFT.Materials.PolymerOrganization
open SFT.Chemistry
open SFT.Foundation.Count.TraceDerivation

-- MATERIALS_OBLIGATIONS[61]: each observed population member retains its
-- repeat identity, actual ordered covalent carrier and organization record.
-- No measured mass or constitutive response is required by this entry.
structure Member (Word Cell : Type) where
 unit : Functional.Group
 chain : PolymerChain.Chain unit Word Cell
 branching : SFT.Host.Canonical.Value

structure Record (Word Cell : Type) where
 first : Member Word Cell
 rest : List (Member Word Cell)
 interchainOrganization : SFT.Host.Canonical.Value
 distributionBoundary : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

variable {Word Cell : Type}

def population (r : Record Word Cell) := r.first::r.rest

def sequence (m : Member Word Cell) := PolymerChain.names (PolymerChain.copies m.chain.incidence)

def length (m : Member Word Cell) := PolymerChain.extent m.chain.incidence

def census (r : Record Word Cell) :=
 (population r).map (fun m => (m.chain.repeatIdentity,sequence m,length m,m.branching))

theorem positivePopulation (r : Record Word Cell) : 0 < (population r).length := Nat.zero_lt_succ _

theorem actualLength (m : Member Word Cell) : length m = (sequence m).length := by
 unfold length sequence PolymerChain.extent PolymerChain.names
 exact (SFT.Foundation.CommonRefinement.mapLength _ _).symm

theorem positiveLength (m : Member Word Cell) : 0 < length m := PolymerChain.positiveExtent m.chain.incidence

theorem repeatIdentityRetained (m : Member Word Cell) :
 (PolymerChain.sourceRecord m.chain).repeatIdentity = m.chain.repeatIdentity := rfl

theorem sourceChainAdmitted (m : Member Word Cell) :
 PolymerChain.admit (PolymerChain.sourceRecord m.chain) = .ok (PolymerChain.sourceRecord m.chain) :=
 PolymerChain.sourceRecordAdmitted m.chain

theorem completeCovalentSequence (m : Member Word Cell) :
 SFT.Mathematics.GraphOperations.pathIsValid (PolymerChain.graph m.chain.incidence) (sequence m) = true :=
 PolymerChain.completeOrderedPath m.chain.incidence

theorem eachNeighborCovalent (m : Member Word Cell) (edge : SFT.Mathematics.GraphOperations.Edge)
 (held : edge ∈ SFT.Mathematics.GraphOperations.adjacentPairs (sequence m)) :
 ∃ bond ∈ m.chain.incidence.connections, PolymerChain.connectionEdge bond = edge :=
 PolymerChain.everyNeighborIsCovalent m.chain.incidence edge held

theorem actualCovalentRecurrence (m : Member Word Cell)
 (bond : PolymerChain.Connection m.unit Word Cell) :
 SFT.QuantumComputation.ReversibleModel.phaseAction bond.covalent.bond.recurrence.prepared.state
 (bond.covalent.bond.interactionTrace.flatMap Prod.snd) = .ok bond.covalent.bond.recurrence.prepared.state :=
 PolymerChain.covalentRecurrenceRetained bond

theorem everyCensusRow (r : Record Word Cell) (m : Member Word Cell) (held : m ∈ population r) :
 (m.chain.repeatIdentity,sequence m,length m,m.branching) ∈ census r := memMap _ _ _ held

theorem noInventedCensusRow (r : Record Word Cell) (row)
 (held : row ∈ census r) :
 ∃ m ∈ population r, (m.chain.repeatIdentity,sequence m,length m,m.branching) = row :=
 memMapPreimage _ _ _ held

def append (r : Record Word Cell) (m : Member Word Cell) : Record Word Cell :=
 {r with rest := r.rest++[m]}

theorem successorPopulation (r : Record Word Cell) (m : Member Word Cell) :
 population (append r m) = population r++[m] := rfl

theorem successorCensus (r : Record Word Cell) (m : Member Word Cell) :
 census (append r m) = census r++[(m.chain.repeatIdentity,sequence m,length m,m.branching)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (fun n : Member Word Cell => (n.chain.repeatIdentity,sequence n,length n,n.branching)) (population r) [m]

theorem priorMemberRetained (r : Record Word Cell) (m old : Member Word Cell)
 (held : old ∈ population r) : old ∈ population (append r m) := memAppendLeft _ _ _ held

theorem boundaryRetained (r : Record Word Cell) (m : Member Word Cell) :
 (append r m).distributionBoundary = r.distributionBoundary ∧
 (append r m).interchainOrganization = r.interchainOrganization ∧
 (append r m).provenance = r.provenance := ⟨rfl,rfl,rfl⟩

def record (r : Record Word Cell) := (r,census r)

theorem wholeInputRetained (r : Record Word Cell) : (record r).1 = r := rfl

def records (rs : List (Record Word Cell)) := rs.map record

theorem base (r : Record Word Cell) : records [r] = [record r] := rfl

theorem successor (rs : List (Record Word Cell)) (r : Record Word Cell) :
 records (rs++[r]) = records rs++[record r] := SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Materials.PolymerOrganization
