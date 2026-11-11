import SFT.Physics.CollectiveCoarseGrain
import SFT.Chemistry.EntityIdentity
namespace SFT.Materials.Microstructure
open SFT.Physics.CollectiveCoarseGrain
open SFT.Mathematics.GraphOperations
open SFT.Mathematics.DiscreteObjects

-- MATERIALS_OBLIGATIONS[4]: retain each arrangement category and its scale.
structure Record where
 network : NetworkObservation
 phases : List (String × List String)
 grains : List (String × List String)
 interfaces : List (String × String × String)
 defects : List (String × List String)
 constituentBoundary : String
 bulkBoundary : String

inductive Extension where
 | phase (row : String × List String)
 | grain (row : String × List String)
 | interface (row : String × String × String)
 | defect (row : String × List String)

def extend (record : Record) : Extension → Record
 | .phase row => {record with phases := record.phases++[row]}
 | .grain row => {record with grains := record.grains++[row]}
 | .interface row => {record with interfaces := record.interfaces++[row]}
 | .defect row => {record with defects := record.defects++[row]}

def prior (record : Record) : Extension → Record
 | .phase _ => {record with phases := SFT.Chemistry.EntityIdentity.priorCoordinates record.phases}
 | .grain _ => {record with grains := SFT.Chemistry.EntityIdentity.priorCoordinates record.grains}
 | .interface _ => {record with interfaces := SFT.Chemistry.EntityIdentity.priorCoordinates record.interfaces}
 | .defect _ => {record with defects := SFT.Chemistry.EntityIdentity.priorCoordinates record.defects}

theorem priorExact (record : Record) (extension : Extension) : prior (extend record extension) extension=record := by
 cases record with
 | mk network phases grains interfaces defects lower upper =>
   cases extension with
   | phase row =>
     change Record.mk network (SFT.Chemistry.EntityIdentity.priorCoordinates (phases++[row])) grains interfaces defects lower upper = _
     rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]
   | grain row =>
     change Record.mk network phases (SFT.Chemistry.EntityIdentity.priorCoordinates (grains++[row])) interfaces defects lower upper = _
     rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]
   | interface row =>
     change Record.mk network phases grains (SFT.Chemistry.EntityIdentity.priorCoordinates (interfaces++[row])) defects lower upper = _
     rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]
   | defect row =>
     change Record.mk network phases grains interfaces (SFT.Chemistry.EntityIdentity.priorCoordinates (defects++[row])) lower upper = _
     rw [SFT.Chemistry.EntityIdentity.priorCoordinatesExact]

theorem extensionRetainsNetwork (record : Record) (extension : Extension) :
 (extend record extension).network=record.network := by cases extension <;> rfl

theorem extensionRetainsBoundary (record : Record) (extension : Extension) :
 (extend record extension).constituentBoundary=record.constituentBoundary ∧
 (extend record extension).bulkBoundary=record.bulkBoundary := by cases extension <;> exact ⟨rfl,rfl⟩

theorem extensionRetainsDistinctions (a b : Record) (extension : Extension) (different : a≠b) :
 extend a extension≠extend b extension := fun same =>
 different ((priorExact a extension).symm.trans ((congrArg (fun r => prior r extension) same).trans (priorExact b extension)))

def extendMany : Record → List Extension → Record
 | record, [] => record
 | record, first::rest => extendMany (extend record first) rest

def recoverHistory : List Extension → Record → Record
 | [],record => record
 | first::rest,record => prior (recoverHistory rest record) first

theorem historyRecovery (record : Record) (history : List Extension) :
 recoverHistory history (extendMany record history)=record := by
 induction history generalizing record with
 | nil => rfl
 | cons first rest ih =>
   change prior (recoverHistory rest (extendMany (extend record first) rest)) first=record
   rw [ih,priorExact]

theorem finiteNetworkRetention (record : Record) (history : List Extension) :
 (extendMany record history).network=record.network := by
 induction history generalizing record with
 | nil => rfl
 | cons first rest ih => exact (ih (extend record first)).trans (extensionRetainsNetwork record first)

theorem completeArrangement (record : Record) :
 record.network.graph=⟨record.network.nodes,record.network.edges⟩ := completeNetworkRetained record.network

theorem everyConstituentHasUniqueBulkClass (record : Record) (cell : String)
 (held : cell∈record.network.graph.nodes) :
 ∃ label members, (label,members)∈record.network.classes ∧ cell∈members ∧
 ∀ other others, (other,others)∈record.network.classes → cell∈others → other=label ∧ others=members :=
 everyCellHasUniqueClass record.network cell held

theorem noPartialObservationClass (record : Record) (label : String) (members : List String)
 (held : (label,members)∈record.network.classes) : members=region record.network label :=
 everyClassIsCompleteFibre record.network label members held

-- A generated cell extension retains the complete old arrangement path.
theorem cellExtensionRetainsPath (record : Record) (fresh : String) (edges : List Edge)
 (path : List String) (held : pathIsValid record.network.graph path=true) :
 pathIsValid ⟨record.network.graph.nodes++[fresh],record.network.graph.edges++edges⟩ path=true :=
 freshNodeRetainsPaths record.network.graph fresh edges path held
end SFT.Materials.Microstructure
