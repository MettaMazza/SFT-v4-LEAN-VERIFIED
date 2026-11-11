import SFT.Chemistry.PeriodicRelease
import SFT.Chemistry.SourceText
import SFT.Physics.CosmoSpatialFlatnessProofs
namespace SFT.Chemistry.ExactComposition
open SFT.Foundation SFT.Physics.CosmoSpatialFlatness
structure Component where
 identity : String
 part : ExactPartCarrier.Part
 nonblank : SourceText.nonblank identity = true

def makeComponent (identity : String) (part : ExactPartCarrier.Part) : Except String Component :=
 if h : SourceText.nonblank identity = true then .ok ⟨identity,part,h⟩
 else .error "composition identity must be a held distinction"

def positivePart (part : ExactPartCarrier.Part) : PositivePart :=
 ⟨part.numerator,part.denominator,part.denominatorNonzero,part.reduced,part.positive⟩

def parts (components : List Component) := components.map (fun c => positivePart c.part)

def distinct : List Component → Bool
 | [] => true
 | first :: rest => rest.all (fun c => !SFT.Host.Text.equal first.identity c.identity) && distinct rest

def total (components : List Component) := naturalTotal (parts components)
def closed (components : List Component) : Prop := (total components).1 = (total components).2

def exactComposition (components : List Component) : Except String (List Component) :=
 if components.isEmpty || !distinct components then .error "composition requires distinct retained components"
 else if (total components).1 = (total components).2 then .ok components
 else .error "composition parts must close exactly to the One"

theorem partValueRetained (part : ExactPartCarrier.Part) : asRat (positivePart part) = ExactPartCarrier.asFraction part := rfl

theorem positiveComponents (component : Component) : 0 < component.part.numerator := component.part.positive

theorem emptyRejected : exactComposition [] = .error "composition requires distinct retained components" := rfl

theorem exactClosure (components : List Component) (nonempty : components.isEmpty = false)
 (unique : distinct components = true) : exactComposition components = .ok components ↔ closed components := by
 unfold exactComposition
 rw [nonempty,unique]
 change (if (total components).1 = (total components).2 then Except.ok components else Except.error _) = Except.ok components ↔ _
 constructor
 · intro accepted
   split at accepted
   · assumption
   · cases accepted
 · intro h; unfold closed at h; rw [ite_eq_left h]

theorem duplicateRejected (components : List Component) (duplicate : distinct components = false) :
 exactComposition components = .error "composition requires distinct retained components" := by
 unfold exactComposition
 rw [duplicate]
 cases components <;> rfl

theorem unclosedRejected (components : List Component) (nonempty : components.isEmpty = false)
 (unique : distinct components = true) (notClosed : ¬ closed components) :
 exactComposition components = .error "composition parts must close exactly to the One" := by
 unfold exactComposition
 rw [nonempty,unique]
 change (if (total components).1 = (total components).2 then _ else _) = _
 unfold closed at notClosed
 rw [ite_eq_right notClosed]

theorem retainedWithoutNormalization (components output : List Component)
 (accepted : exactComposition components = .ok output) : output = components := by
 unfold exactComposition at accepted
 split at accepted
 · cases accepted
 · split at accepted
   · exact (Except.ok.inj accepted).symm
   · cases accepted

theorem equalPartsDoNotEraseIdentity (a b : Component) (_equal : a.part = b.part)
 (different : a.identity ≠ b.identity) : a ≠ b := fun same => different (congrArg Component.identity same)

theorem partsAppend (a b : List Component) : parts (a++b) = parts a ++ parts b :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem refinementCloses (before tail : List Component) (parent first second : Component)
 (split : (first.part.numerator*second.part.denominator+second.part.numerator*first.part.denominator)*parent.part.denominator =
 parent.part.numerator*(first.part.denominator*second.part.denominator))
 (prior : closed (before++parent::tail)) : closed (before++first::second::tail) := by
 unfold closed total at prior ⊢
 rw [partsAppend] at prior ⊢
 exact everyPositiveSplitPreservesClosure (parts before) (parts tail) (positivePart parent.part)
   (positivePart first.part) (positivePart second.part) split prior

theorem refinedCompositionAdmitted (before tail : List Component) (parent first second : Component)
 (split : (first.part.numerator*second.part.denominator+second.part.numerator*first.part.denominator)*parent.part.denominator =
 parent.part.numerator*(first.part.denominator*second.part.denominator))
 (prior : closed (before++parent::tail)) (unique : distinct (before++first::second::tail)=true) :
 exactComposition (before++first::second::tail) = .ok (before++first::second::tail) :=
 (exactClosure _ (by cases before <;> rfl) unique).mpr (refinementCloses _ _ _ _ _ split prior)

structure Record where
 components : List Component
 sourceBoundary : SFT.Host.Canonical.Value
 sourceHistory : List (List Component)

def refineRecord (record : Record) (new : List Component) : Record :=
 ⟨new,record.sourceBoundary,record.sourceHistory ++ [record.components]⟩

theorem sourceBoundaryRetained (record : Record) (new : List Component) :
 (refineRecord record new).sourceBoundary = record.sourceBoundary := rfl

theorem parentIdentitiesRetained (record : Record) (new : List Component) :
 record.components ∈ (refineRecord record new).sourceHistory :=
 SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _)
theorem singletonOne (component : Component) (one : component.part.numerator = component.part.denominator) :
 exactComposition [component] = .ok [component] := by
 apply (exactClosure _ rfl rfl).mpr
 change 0*component.part.denominator+component.part.numerator*1 = 1*component.part.denominator
 rw [Nat.zero_mul,Nat.zero_add,Nat.mul_one,Nat.one_mul,one]

inductive Refinement : List Component → List Component → Prop where
 | split (before tail : List Component) (parent first second : Component)
   (equal : (first.part.numerator*second.part.denominator+second.part.numerator*first.part.denominator)*parent.part.denominator =
    parent.part.numerator*(first.part.denominator*second.part.denominator)) :
   Refinement (before++parent::tail) (before++first::second::tail)

inductive History (start : List Component) : List Component → Prop where
 | base : History start start
 | next {prior finish : List Component} (history : History start prior) (refinement : Refinement prior finish) : History start finish

theorem allFiniteRefinementsClose {start finish : List Component} (history : History start finish)
 (initial : closed start) : closed finish := by
 induction history with
 | base => exact initial
 | next history refinement ih =>
   cases refinement with
   | split before tail parent first second equal => exact refinementCloses _ _ _ _ _ equal ih

end SFT.Chemistry.ExactComposition
