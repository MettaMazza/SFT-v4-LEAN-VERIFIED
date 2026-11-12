import SFT.Physics.CollectiveBand
namespace SFT.Materials.BandGapSupport
open SFT.Physics SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.QuantumComputation.ReversibleModel

abbrev Boundary := CollectiveBand.Boundary
abbrev completeSupport := CollectiveBand.support

-- The declared observation interval classifies the retained reading labels.
-- All generated paths are checked; the observation does not select a survivor.
def intervalSupport (boundary : Boundary) (inside : String → Bool) :=
 (completeSupport boundary).filter (fun trace => inside (boundary.observedClass trace))

theorem intervalExactly (boundary : Boundary) (inside : String → Bool) (trace : List String) :
 trace ∈ intervalSupport boundary inside ↔
 trace ∈ CollectiveBand.generated boundary ∧ pathIsValid boundary.lattice.cells.graph trace=true ∧
 phaseAction boundary.preparation.state trace=.ok boundary.preparation.state ∧ inside (boundary.observedClass trace)=true := by
 constructor
 · intro member
   have selected := (filterMemberIff _ _ _).mp member
   have compatible := (CollectiveBand.bandExactly boundary trace).mp selected.1
   exact ⟨compatible.1,compatible.2.1,compatible.2.2,selected.2⟩
 · intro h
   exact (filterMemberIff _ _ _).mpr ⟨(CollectiveBand.bandExactly boundary trace).mpr ⟨h.1,h.2.1,h.2.2.1⟩,h.2.2.2⟩

theorem gapExactly (boundary : Boundary) (inside : String → Bool) :
 intervalSupport boundary inside=[] ↔
 ∀ trace, trace∈CollectiveBand.generated boundary → pathIsValid boundary.lattice.cells.graph trace=true →
 phaseAction boundary.preparation.state trace=.ok boundary.preparation.state → inside (boundary.observedClass trace)≠true := by
 constructor
 · intro empty trace generated path phase reading
   have held := (intervalExactly boundary inside trace).mpr ⟨generated,path,phase,reading⟩
   rw [empty] at held
   cases held
 · intro excluded
   cases rows : intervalSupport boundary inside with
   | nil => rfl
   | cons first rest =>
     have held : first∈intervalSupport boundary inside := rows ▸ List.Mem.head _
     have h := (intervalExactly boundary inside first).mp held
     exact False.elim (excluded first h.1 h.2.1 h.2.2.1 h.2.2.2)

theorem everyCompatibleIntervalPath (boundary : Boundary) (inside : String → Bool) (trace : List String)
 (length : 0<trace.length ∧ trace.length≤boundary.depth)
 (cells : ∀ site, site∈trace → site∈boundary.lattice.cells.graph.nodes)
 (path : pathIsValid boundary.lattice.cells.graph trace=true)
 (phase : phaseAction boundary.preparation.state trace=.ok boundary.preparation.state)
 (reading : inside (boundary.observedClass trace)=true) : trace∈intervalSupport boundary inside :=
 (intervalExactly boundary inside trace).mpr
 ⟨(CollectiveBand.generatedExactly boundary trace).mpr ⟨length.1,length.2,cells⟩,path,phase,reading⟩

theorem completeDeclaredDepth (boundary : Boundary) (inside : String → Bool) (trace : List String)
 (held : trace∈intervalSupport boundary inside) : trace.length≤boundary.depth :=
 ((CollectiveBand.generatedExactly boundary trace).mp ((intervalExactly boundary inside trace).mp held).1).2.1

abbrev completePhaseClasses := CollectiveBand.classExactly
abbrev everyLatticeConstituentPrepared := CollectiveBand.everyLatticeConstituentPrepared
abbrev noForeignConstituent := CollectiveBand.noForeignPreparedConstituent
end SFT.Materials.BandGapSupport
