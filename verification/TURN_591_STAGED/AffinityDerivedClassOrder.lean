import SFT.Chemistry.AffinityObservationBinding
import SFT.Chemistry.AffinityRecordClosure
namespace SFT.Chemistry.AffinityDerivedClassOrder
open AffinityObservationBinding
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Foundation.Count.TraceDerivation
abbrev Observation := SFT.InformationScience.SymbolObservation.Observation

def edges {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison) :=
 tieEdges rows ++ AffinityRecordClosure.relation comparisons

def precedes {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison)
 (left right : String) : Prop :=
 ∃ a, a∈rows ∧ ∃ b, b∈rows ∧ a.label=left ∧ b.label=right ∧
 AffinityClosure.Precedes (edges rows comparisons) a.atom b.atom

def cycleCheck {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison) : Bool :=
 rows.all fun a => rows.all fun b =>
 if SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) a.atom b.atom &&
 SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) b.atom a.atom
 then decide (a.label=b.label) else true

theorem tiePath {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison)
 (a b : Endpoint o) (ha : a∈rows) (hb : b∈rows) (same : a.label=b.label) :
 AffinityClosure.Precedes (edges rows comparisons) a.atom b.atom :=
 .step .identity (memAppendLeft _ _ _ (sameClassEdge rows a b ha hb same))

theorem cyclesExactlySourceClasses {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (checked : cycleCheck rows comparisons=true)
 (a b : Endpoint o) (ha : a∈rows) (hb : b∈rows) :
 AffinityClosure.Tied (edges rows comparisons) a.atom b.atom ↔ a.label=b.label := by
 constructor
 · intro tied
   have cell := allTrueAtMember _ rows (allTrueAtMember _ rows checked a ha) b hb
   rw [(AffinityClosure.executableClosure _ _ _).mpr tied.1,
     (AffinityClosure.executableClosure _ _ _).mpr tied.2] at cell
   exact of_decide_eq_true cell
 · intro same
   exact ⟨tiePath rows comparisons a b ha hb same,tiePath rows comparisons b a hb ha same.symm⟩

theorem reflexive {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison)
 (label : String) (held : label∈rows.map Endpoint.label) : precedes rows comparisons label label := by
 obtain ⟨a,ha,same⟩ := memMapPreimage Endpoint.label label rows held
 exact ⟨a,ha,a,ha,same,same,.identity⟩

theorem transitive {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison)
 (x y z : String) (xy : precedes rows comparisons x y) (yz : precedes rows comparisons y z) :
 precedes rows comparisons x z := by
 obtain ⟨a,ha,b,hb,ax,byLabel,ab⟩ := xy
 obtain ⟨c,hc,d,hd,cy,dz,cd⟩ := yz
 have bc := tiePath rows comparisons b c hb hc (byLabel.trans cy.symm)
 exact ⟨a,ha,d,hd,ax,dz,AffinityClosure.transitive _ _ _ _ ab
   (AffinityClosure.transitive _ _ _ _ bc cd)⟩

theorem antisymmetric {o : Observation} (rows : List (Endpoint o)) (comparisons : List AffinityComparison.Comparison)
 (checked : cycleCheck rows comparisons=true) (x y : String)
 (xy : precedes rows comparisons x y) (yx : precedes rows comparisons y x) : x=y := by
 obtain ⟨a,ha,b,hb,ax,byLabel,ab⟩ := xy
 obtain ⟨c,hc,d,hd,cy,dx,cd⟩ := yx
 have bc := tiePath rows comparisons b c hb hc (byLabel.trans cy.symm)
 have da := tiePath rows comparisons d a hd ha (dx.trans ax.symm)
 have ba := AffinityClosure.transitive _ _ _ _ bc (AffinityClosure.transitive _ _ _ _ cd da)
 have same := (cyclesExactlySourceClasses rows comparisons checked a b ha hb).mp ⟨ab,ba⟩
 exact ax.symm.trans (same.trans byLabel)

theorem representativeIndependent {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (a a' b b' : Endpoint o)
 (ha : a∈rows) (ha' : a'∈rows) (hb : b∈rows) (hb' : b'∈rows)
 (left : a.label=a'.label) (right : b.label=b'.label) :
 AffinityClosure.Precedes (edges rows comparisons) a.atom b.atom ↔
 AffinityClosure.Precedes (edges rows comparisons) a'.atom b'.atom := by
 constructor
 · intro path
   exact AffinityClosure.transitive _ _ _ _ (tiePath rows comparisons a' a ha' ha left.symm)
     (AffinityClosure.transitive _ _ _ _ path (tiePath rows comparisons b b' hb hb' right))
 · intro path
   exact AffinityClosure.transitive _ _ _ _ (tiePath rows comparisons a a' ha ha' left)
     (AffinityClosure.transitive _ _ _ _ path (tiePath rows comparisons b' b hb' hb right.symm))

theorem sourceTieExactly {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (checked : cycleCheck rows comparisons=true)
 (a b : Endpoint o) (ha : a∈rows) (hb : b∈rows) :
 AffinityClosure.Tied (edges rows comparisons) a.atom b.atom ↔
 SFT.InformationScience.SymbolObservation.distinguishable o a.symbol b.symbol=.ok false :=
 ⟨fun tied => (sourceClassExactly a b).mp ((cyclesExactlySourceClasses rows comparisons checked a b ha hb).mp tied),
 fun closed => (cyclesExactlySourceClasses rows comparisons checked a b ha hb).mpr ((sourceClassExactly a b).mpr closed)⟩
theorem cycleCheckExactly {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) : cycleCheck rows comparisons=true ↔
 ∀ a∈rows, ∀ b∈rows, AffinityClosure.Tied (edges rows comparisons) a.atom b.atom → a.label=b.label := by
 constructor
 · intro checked a ha b hb tied
   exact (cyclesExactlySourceClasses rows comparisons checked a b ha hb).mp tied
 · intro admissible
   apply (allTrueIffMembers _ _).mpr
   intro a ha
   apply (allTrueIffMembers _ _).mpr
   intro b hb
   split
   · rename_i bothPaths
     have paths := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp bothPaths
     exact decide_eq_true (admissible a ha b hb ⟨(AffinityClosure.executableClosure _ _ _).mp paths.1,
       (AffinityClosure.executableClosure _ _ _).mp paths.2⟩)
   · rfl

inductive Direction where
 | tied | first | second | incomparable
 deriving DecidableEq

def direction {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (a b : Endpoint o) : Direction :=
 if a.label=b.label then .tied
 else if SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) a.atom b.atom then .second
 else if SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) b.atom a.atom then .first
 else .incomparable

theorem forwardForcesSecond {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (a b : Endpoint o)
 (different : a.label≠b.label) (forward : AffinityClosure.Precedes (edges rows comparisons) a.atom b.atom) :
 direction rows comparisons a b=.second := by
 unfold direction
 rw [ite_eq_right different,(AffinityClosure.executableClosure _ _ _).mpr forward]
 rfl

theorem backwardForcesFirst {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (checked : cycleCheck rows comparisons=true)
 (a b : Endpoint o) (ha : a∈rows) (hb : b∈rows) (different : a.label≠b.label)
 (backward : AffinityClosure.Precedes (edges rows comparisons) b.atom a.atom) :
 direction rows comparisons a b=.first := by
 have noForward : SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) a.atom b.atom=false := by
   cases h : SFT.Mathematics.DynamicsStability.perturbationReaches (edges rows comparisons) a.atom b.atom with
   | false => rfl
   | true => exact False.elim (different ((cyclesExactlySourceClasses rows comparisons checked a b ha hb).mp
       ⟨(AffinityClosure.executableClosure _ _ _).mp h,backward⟩))
 unfold direction
 rw [ite_eq_right different,noForward,(AffinityClosure.executableClosure _ _ _).mpr backward]
 rfl

theorem tiedDirectionExactly {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (a b : Endpoint o) :
 direction rows comparisons a b=.tied ↔ a.label=b.label := by
 unfold direction
 split
 · rename_i same; exact ⟨fun _ => same,fun _ => rfl⟩
 · rename_i different
   constructor
   · intro impossible
     split at impossible
     · cases impossible
     · split at impossible <;> cases impossible
   · intro same; exact False.elim (different same)

theorem recordDirection {o : Observation} (rows : List (Endpoint o))
 (comparisons : List AffinityComparison.Comparison) (checked : cycleCheck rows comparisons=true)
 (row : AffinityComparison.Comparison) (held : row∈comparisons)
 (a b : Endpoint o) (ha : a∈rows) (hb : b∈rows)
 (firstName : a.atom=row.raw.firstAtom) (secondName : b.atom=row.raw.secondAtom) :
 direction rows comparisons a b =
 (if a.label=b.label then .tied
  else if row.raw.preferredEndpoint=row.raw.firstAtom then .first else .second) := by
 split
 · rename_i same
   exact (tiedDirectionExactly rows comparisons a b).mpr same
 · rename_i different
   have present : AffinityRecordClosure.edge row∈edges rows comparisons :=
     memAppendRight _ _ _ (memMap AffinityRecordClosure.edge row comparisons held)
   split
   · rename_i first
     unfold AffinityRecordClosure.edge at present
     rw [ite_eq_left first] at present
     have path : AffinityClosure.Precedes (edges rows comparisons) b.atom a.atom := by
       rw [firstName,secondName]
       exact .step .identity present
     exact backwardForcesFirst rows comparisons checked a b ha hb different path
   · rename_i notFirst
     unfold AffinityRecordClosure.edge at present
     rw [ite_eq_right notFirst] at present
     have path : AffinityClosure.Precedes (edges rows comparisons) a.atom b.atom := by
       rw [firstName,secondName]
       exact .step .identity present
     exact forwardForcesSecond rows comparisons a b different path

end SFT.Chemistry.AffinityDerivedClassOrder
