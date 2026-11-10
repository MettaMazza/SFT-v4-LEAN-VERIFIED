import SFT.Physics.CollectiveLattice
import SFT.Physics.QuantumPhysicalSpectra
import SFT.InformationScience.CompressionSupport
namespace SFT.Physics.CollectiveBand
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.InformationScience.QuantitySupport SFT.InformationScience.CompressionSupport
open SFT.QuantumComputation.ReversibleModel

structure Boundary where
 lattice : CollectiveLattice.Translation
 preparation : QuantumPhysicalState.Prepared
 depth : Nat
 observedClass : List String → String
 constituentSupport : ∀ word, word ∈ SFT.QuantumComputation.ReversibleModel.support preparation.state ↔
   ∃ cell, cell ∈ lattice.cells.graph.nodes ∧ word = lattice.word cell

theorem everyLatticeConstituentPrepared (b : Boundary) (cell : String)
 (held : cell ∈ b.lattice.cells.graph.nodes) :
 b.lattice.word cell ∈ SFT.QuantumComputation.ReversibleModel.support b.preparation.state :=
 (b.constituentSupport _).mpr ⟨cell,held,rfl⟩

theorem noForeignPreparedConstituent (b : Boundary) (word : List String)
 (held : word ∈ SFT.QuantumComputation.ReversibleModel.support b.preparation.state) :
 ∃ cell, cell ∈ b.lattice.cells.graph.nodes ∧ word = b.lattice.word cell :=
 (b.constituentSupport word).mp held


def generated (b : Boundary) := shortThrough b.lattice.cells.graph.nodes b.depth

def compatible (b : Boundary) (trace : List String) : Bool :=
 pathIsValid b.lattice.cells.graph trace && QuantumPhysicalSpectra.closes b.preparation trace

def support (b : Boundary) := (generated b).filter (compatible b)

theorem generatedExactly (b : Boundary) (trace : List String) : trace ∈ generated b ↔
 0 < trace.length ∧ trace.length ≤ b.depth ∧ ∀ x, x ∈ trace → x ∈ b.lattice.cells.graph.nodes := by
 constructor
 · intro h
   obtain ⟨n,positive,bound,held⟩ := (shortMembership _ _ _).mp h
   have p := (wordCharacterization _ _ _).mp held
   rw [p.1]
   exact ⟨positive,bound,p.2⟩
 · intro ⟨positive,bound,held⟩
   exact (shortMembership _ _ _).mpr ⟨trace.length,positive,bound,(wordCharacterization _ _ _).mpr ⟨rfl,held⟩⟩

theorem bandExactly (b : Boundary) (trace : List String) : trace ∈ support b ↔
 trace ∈ generated b ∧ pathIsValid b.lattice.cells.graph trace = true ∧
 phaseAction b.preparation.state trace = .ok b.preparation.state := by
 constructor
 · intro h
   have p := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp h
   have checks := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp p.2
   exact ⟨p.1,checks.1,(QuantumPhysicalSpectra.closureExactly _ _).mp checks.2⟩
 · intro ⟨held,path,phase⟩
   apply (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr
   exact ⟨held,(SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
     ⟨path,(QuantumPhysicalSpectra.closureExactly _ _).mpr phase⟩⟩

def classRows (b : Boundary) (label : String) := (support b).filter (fun trace => decide (b.observedClass trace = label))

theorem classExactly (b : Boundary) (label : String) (trace : List String) :
 trace ∈ classRows b label ↔ trace ∈ support b ∧ b.observedClass trace = label := by
 constructor
 · intro h
   have p := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp h
   exact ⟨p.1,of_decide_eq_true p.2⟩
 · intro h
   exact (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem gapExactly (b : Boundary) (label : String) : classRows b label = [] ↔
 ∀ trace, trace ∈ generated b → pathIsValid b.lattice.cells.graph trace = true →
 phaseAction b.preparation.state trace = .ok b.preparation.state → b.observedClass trace ≠ label := by
 constructor
 · intro empty trace held path phase same
   have h := (classExactly b label trace).mpr ⟨(bandExactly b trace).mpr ⟨held,path,phase⟩,same⟩
   rw [empty] at h
   cases h
 · intro absent
   cases rows : classRows b label with
   | nil => rfl
   | cons first rest =>
     have member : first ∈ classRows b label := by rw [rows]; exact List.Mem.head _
     have p := (classExactly b label first).mp member
     have q := (bandExactly b first).mp p.1
     exact False.elim (absent first q.1 q.2.1 q.2.2 p.2)

theorem everyCompatiblePathIncluded (b : Boundary) (trace : List String)
 (length : 0 < trace.length ∧ trace.length ≤ b.depth)
 (cells : ∀ x, x ∈ trace → x ∈ b.lattice.cells.graph.nodes)
 (path : pathIsValid b.lattice.cells.graph trace = true)
 (phase : phaseAction b.preparation.state trace = .ok b.preparation.state) : trace ∈ support b :=
 (bandExactly b trace).mpr ⟨(generatedExactly b trace).mpr ⟨length.1,length.2,cells⟩,path,phase⟩

theorem noOutsideBoundary (b : Boundary) (trace : List String) (held : trace ∈ support b) :
 trace.length ≤ b.depth := ((generatedExactly b trace).mp ((bandExactly b trace).mp held).1).2.1

theorem fullPhaseCycleIncluded (b : Boundary) (trace : List String)
 (held : trace ∈ generated b) (path : pathIsValid b.lattice.cells.graph trace = true)
 (period : trace.length = b.preparation.state.phaseCycle.length) : trace ∈ support b :=
 (bandExactly b trace).mpr ⟨held,path,QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ period⟩
end SFT.Physics.CollectiveBand
