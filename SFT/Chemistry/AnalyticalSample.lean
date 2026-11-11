import SFT.Chemistry.Functional
namespace SFT.Chemistry.AnalyticalSample
open SFT.Physics.CapabilityValues SFT.Foundation.Count.TraceDerivation
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects

structure Raw where
 sample : HeldLabel
 components : List HeldLabel
 observations : List PositiveCount

def admit (r : Raw) : Except String Raw :=
 if r.sample.family="analytical-sample" ∧ r.components≠[] ∧ r.observations≠[] then .ok r
 else .error "an analytical trace requires sample, component and observation support"

theorem admitExactly (r : Raw) : admit r=.ok r ↔
 r.sample.family="analytical-sample" ∧ r.components≠[] ∧ r.observations≠[] := by
 unfold admit
 split
 · rename_i good; exact ⟨fun _ => good,fun _ => rfl⟩
 · rename_i bad
   constructor
   · intro h; cases h
   · intro h; exact False.elim (bad h)

inductive Role where
 | analyte | matrix

structure Component where
 identity : HeldLabel
 role : Role
 sourceOrigin : HeldLabel
 responses : List PositiveCount
 sourceRecord : SFT.Host.Canonical.Value

def isAnalyte (row : Component) : Bool := match row.role with
 | .analyte => true
 | .matrix => false

def isMatrix (row : Component) : Bool := !isAnalyte row

def analytes (rows : List Component) := rows.filter isAnalyte
def matrix (rows : List Component) := rows.filter isMatrix

theorem analyteExactly (rows : List Component) (row : Component) :
 row∈analytes rows ↔ row∈rows ∧ isAnalyte row=true := filterMemberIff _ _ _

theorem matrixExactly (rows : List Component) (row : Component) :
 row∈matrix rows ↔ row∈rows ∧ isMatrix row=true := filterMemberIff _ _ _

theorem partitionComplete (rows : List Component) (row : Component) (held : row∈rows) :
 row∈analytes rows ∨ row∈matrix rows := by
 cases role : row.role with
 | analyte => exact .inl ((analyteExactly rows row).mpr ⟨held,by unfold isAnalyte; rw [role]⟩)
 | matrix => exact .inr ((matrixExactly rows row).mpr ⟨held,by unfold isMatrix isAnalyte; rw [role]; rfl⟩)

theorem partitionDisjoint (rows : List Component) (row : Component) :
 ¬(row∈analytes rows ∧ row∈matrix rows) := by
 intro both
 have yes := ((analyteExactly rows row).mp both.1).2
 have no := ((matrixExactly rows row).mp both.2).2
 change (!isAnalyte row)=true at no
 rw [yes] at no
 cases no

structure Portion where
 sample : HeldLabel
 family : sample.family="analytical-sample"
 source : HeldLabel
 rows : List Component
 analyteHeld : ∃ row∈rows, isAnalyte row=true
 sampling : SFT.Host.Canonical.Value

def sourceMap (portion : Portion) := portion.rows.map (fun row => (row.identity,row.sourceOrigin))
def responseMap (portion : Portion) := portion.rows.map (fun row => (row.identity,row.responses))

def append (portion : Portion) (row : Component) : Portion where
 sample := portion.sample
 family := portion.family
 source := portion.source
 rows := portion.rows++[row]
 analyteHeld := by
  obtain ⟨old,held,role⟩ := portion.analyteHeld
  exact ⟨old,memAppendLeft _ _ _ held,role⟩
 sampling := portion.sampling

theorem completeSourceMap (portion : Portion) (row : Component) (held : row∈portion.rows) :
 (row.identity,row.sourceOrigin)∈sourceMap portion := memMap _ _ _ held

theorem completeResponseMap (portion : Portion) (row : Component) (held : row∈portion.rows) :
 (row.identity,row.responses)∈responseMap portion := memMap _ _ _ held

theorem sourceMapNoInventedRows (portion : Portion) (pair : HeldLabel×HeldLabel) (held : pair∈sourceMap portion) :
 ∃ row∈portion.rows, (row.identity,row.sourceOrigin)=pair := memMapPreimage _ _ _ held

theorem appendRetainsRows (portion : Portion) (new old : Component) (held : old∈portion.rows) :
 old∈(append portion new).rows := memAppendLeft _ _ _ held

theorem appendRetainsAnalyte (portion : Portion) (new old : Component) (held : old∈analytes portion.rows) :
 old∈analytes (append portion new).rows := by
 have data := (analyteExactly _ _).mp held
 exact (analyteExactly _ _).mpr ⟨appendRetainsRows portion new old data.1,data.2⟩

theorem appendRetainsMatrix (portion : Portion) (new old : Component) (held : old∈matrix portion.rows) :
 old∈matrix (append portion new).rows := by
 have data := (matrixExactly _ _).mp held
 exact (matrixExactly _ _).mpr ⟨appendRetainsRows portion new old data.1,data.2⟩

theorem addedRoleRetained (portion : Portion) (new : Component) :
 new∈analytes (append portion new).rows ∨ new∈matrix (append portion new).rows :=
 partitionComplete _ _ (memAppendRight _ _ _ (.head []))

theorem samplingRetained (portion : Portion) (row : Component) :
 (append portion row).sample=portion.sample ∧ (append portion row).source=portion.source ∧
 (append portion row).sampling=portion.sampling := ⟨rfl,rfl,rfl⟩


def base (sample source : HeldLabel) (family : sample.family="analytical-sample")
 (analyte other : Component) (analyteRole : isAnalyte analyte=true)
 (matrixRole : isMatrix other=true) (sampling : SFT.Host.Canonical.Value) : Portion :=
 ⟨sample,family,source,[analyte,other],⟨analyte,.head _,analyteRole⟩,sampling⟩

theorem basePartition (sample source : HeldLabel) (family : sample.family="analytical-sample")
 (analyte other : Component) (analyteRole : isAnalyte analyte=true)
 (matrixRole : isMatrix other=true) (sampling : SFT.Host.Canonical.Value) :
 analyte∈analytes (base sample source family analyte other analyteRole matrixRole sampling).rows ∧
 other∈matrix (base sample source family analyte other analyteRole matrixRole sampling).rows :=
 ⟨(analyteExactly _ _).mpr ⟨.head _,analyteRole⟩,
  (matrixExactly _ _).mpr ⟨.tail _ (.head _),matrixRole⟩⟩

theorem partitionHasNoInventedRows (rows : List Component) (row : Component)
 (held : row∈analytes rows ∨ row∈matrix rows) : row∈rows := by
 cases held with
 | inl analyte => exact ((analyteExactly _ _).mp analyte).1
 | inr other => exact ((matrixExactly _ _).mp other).1

theorem appendSourceMap (portion : Portion) (row : Component) :
 sourceMap (append portion row)=sourceMap portion++[(row.identity,row.sourceOrigin)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (fun r : Component => (r.identity,r.sourceOrigin)) portion.rows [row]

theorem appendResponseMap (portion : Portion) (row : Component) :
 responseMap (append portion row)=responseMap portion++[(row.identity,row.responses)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend (fun r : Component => (r.identity,r.responses)) portion.rows [row]

end SFT.Chemistry.AnalyticalSample
