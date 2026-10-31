import SFT.Physics.WaveInterference
import SFT.Mathematics.DiscreteComplement
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.WaveDiffraction
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

-- The aperture acts on complete incident paths. Successor generation retains
-- their origin alongside every generated response.
def retained {Path : Type} (aperture : Path → Bool) : List Path → List Path
  | [] => []
  | p :: ps => match aperture p with
    | true => p :: retained aperture ps
    | false => retained aperture ps

theorem retainedMember {Path : Type} (aperture : Path → Bool) (paths : List Path) (p : Path) :
    p ∈ retained aperture paths ↔ p ∈ paths ∧ aperture p = true := by
  induction paths with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons a rest ih =>
    cases ha : aperture a <;> rw [retained,ha]
    · constructor
      · intro h; have old := ih.mp h; exact ⟨.tail _ old.1,old.2⟩
      · intro h; cases h.1 with
        | head => exact False.elim (Bool.noConfusion (ha.symm.trans h.2))
        | tail _ hm => exact ih.mpr ⟨hm,h.2⟩
    · constructor
      · intro h; cases h with
        | head => exact ⟨.head _,ha⟩
        | tail _ hm => have old := ih.mp hm; exact ⟨.tail _ old.1,old.2⟩
      · intro h; cases h.1 with
        | head => exact .head _
        | tail _ hm => exact .tail _ (ih.mpr ⟨hm,h.2⟩)

def generated {Path Output : Type} (aperture : Path → Bool) (next : Path → List Output) (paths : List Path) :=
  (retained aperture paths).flatMap (fun p => (next p).map (fun out => (p,out)))

theorem everyGeneratedOrigin {Path Output : Type} (aperture : Path → Bool) (next : Path → List Output)
    (paths : List Path) (p : Path) (out : Output) (h : (p,out) ∈ generated aperture next paths) :
    p ∈ paths ∧ aperture p = true ∧ out ∈ next p := by
  obtain ⟨a,ha,hm⟩ := memFlatMapOrigin _ _ _ h
  obtain ⟨b,hb,eq⟩ := memMapPreimage _ _ _ hm
  have hp := congrArg Prod.fst eq
  have ho := congrArg Prod.snd eq
  cases hp; cases ho
  exact ⟨((retainedMember aperture paths p).mp ha).1,((retainedMember aperture paths p).mp ha).2,hb⟩

theorem everyReachableSuccessor {Path Output : Type} (aperture : Path → Bool) (next : Path → List Output)
    (paths : List Path) (p : Path) (out : Output)
    (hp : p ∈ paths) (openPath : aperture p = true) (ho : out ∈ next p) :
    (p,out) ∈ generated aperture next paths :=
  memFlatMap _ _ p _ ((retainedMember aperture paths p).mpr ⟨hp,openPath⟩)
    (memMap _ out _ ho)

theorem excludedPathCannotContribute {Path Output : Type} (aperture : Path → Bool) (next : Path → List Output)
    (paths : List Path) (p : Path) (out : Output) (closed : aperture p = false) :
    (p,out) ∉ generated aperture next paths := by
  intro h
  have opened := (everyGeneratedOrigin aperture next paths p out h).2.1
  exact Bool.noConfusion (closed.symm.trans opened)

-- Instantiation by actual local propagation retains causal adjacency at each output.
theorem reachableOutputIsLocal {Cell : Type}
    {adjacent : MechanicalEvents.Event Cell → MechanicalEvents.Event Cell → Prop}
    {source : MechanicalEvents.Event Cell}
    (aperture : FieldLocality.Arrival adjacent source → Bool)
    (next : FieldLocality.Arrival adjacent source → List (FieldLocality.Arrival adjacent source))
    (paths : List (FieldLocality.Arrival adjacent source))
    (p out : FieldLocality.Arrival adjacent source)
    (_ : (p,out) ∈ generated aperture next paths) :
    ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace out.propagation), adjacent row.before row.after :=
  FieldLocality.everyTransitionAdjacent _
end SFT.Physics.WaveDiffraction
