import SFT.Physics.SpacetimeCausalOrder
import SFT.Physics.SpacetimeInterval
namespace SFT.Physics.SpacetimeInertial

-- INERTIAL_TRANSFORMATION: a reference names each complete generated record
-- once, and reading the name recovers that same record. No coordinate metric
-- or extra transformation coefficient is introduced.
structure Frame (Record Label : Type) where
 name : Record → Label
 read : Label → Record
 readName : ∀ r, read (name r) = r
 nameRead : ∀ l, name (read l) = l

variable {Record A B C : Type}

def correspondence (a : Frame Record A) (b : Frame Record B) (label : A) : B :=
 b.name (a.read label)

theorem completeRecordPreserved (a : Frame Record A) (b : Frame Record B) (label : A) :
 b.read (correspondence a b label) = a.read label := b.readName _

theorem inverseCorrespondence (a : Frame Record A) (b : Frame Record B) (label : A) :
 correspondence b a (correspondence a b label) = label := by
 unfold correspondence
 rw [b.readName,a.nameRead]

theorem correspondenceInjective (a : Frame Record A) (b : Frame Record B) (x y : A)
 (same : correspondence a b x = correspondence a b y) : x=y := by
 have h := congrArg (correspondence b a) same
 rw [inverseCorrespondence,inverseCorrespondence] at h
 exact h

theorem correspondenceSurjective (a : Frame Record A) (b : Frame Record B) (target : B) :
 ∃ source, correspondence a b source = target :=
 ⟨correspondence b a target,inverseCorrespondence b a target⟩

theorem uniqueRecordPreservingRelabeling (a : Frame Record A) (b : Frame Record B) (f : A → B)
 (preserves : ∀ x, b.read (f x) = a.read x) (x : A) : f x = correspondence a b x := by
 have h := congrArg b.name (preserves x)
 rw [b.nameRead] at h
 exact h

theorem identityCorrespondence (a : Frame Record A) (x : A) : correspondence a a x=x := a.nameRead x

theorem correspondenceComposition (a : Frame Record A) (b : Frame Record B) (c : Frame Record C) (x : A) :
 correspondence b c (correspondence a b x) = correspondence a c x := by
 unfold correspondence
 rw [b.readName]

theorem eventCoincidencePreserved (a : Frame Record A) (b : Frame Record B) (x y : A) :
 b.read (correspondence a b x) = b.read (correspondence a b y) ↔ a.read x = a.read y := by
 rw [completeRecordPreserved,completeRecordPreserved]

theorem intervalClassPreserved {Causal : Type} (a : Frame Record A) (b : Frame Record B)
 (interval : Record → Record → SpacetimeInterval.Separation Causal) (x y : A) :
 interval (b.read (correspondence a b x)) (b.read (correspondence a b y)) = interval (a.read x) (a.read y) := by
 rw [completeRecordPreserved,completeRecordPreserved]

theorem limitingPathsPreserved (a : Frame Record A) (b : Frame Record B)
 (path : Record → Record → Prop) (x y : A) :
 path (b.read (correspondence a b x)) (b.read (correspondence a b y)) ↔ path (a.read x) (a.read y) := by
 rw [completeRecordPreserved,completeRecordPreserved]

def recordedSuccessor (frame : Frame Record A) (step : Record → Record) (label : A) : A :=
 frame.name (step (frame.read label))

theorem uniformSuccessorCorresponds (a : Frame Record A) (b : Frame Record B)
 (step : Record → Record) (x : A) :
 correspondence a b (recordedSuccessor a step x) = recordedSuccessor b step (correspondence a b x) := by
 unfold correspondence recordedSuccessor
 rw [a.readName,b.readName]

def iterate {α : Type} (step : α → α) : Nat → α → α
 | 0,x => x
 | n+1,x => iterate step n (step x)

theorem everyFiniteUniformRecordCorresponds (a : Frame Record A) (b : Frame Record B)
 (step : Record → Record) (n : Nat) (x : A) :
 correspondence a b (iterate (recordedSuccessor a step) n x) =
 iterate (recordedSuccessor b step) n (correspondence a b x) := by
 induction n generalizing x with
 | zero => rfl
 | succ n ih =>
   change correspondence a b (iterate (recordedSuccessor a step) n (recordedSuccessor a step x)) =
     iterate (recordedSuccessor b step) n (recordedSuccessor b step (correspondence a b x))
   rw [ih,uniformSuccessorCorresponds]

theorem coordinateDistortionExcluded (a : Frame Record A) (b : Frame Record B) (f : A → B) (x : A)
 (different : f x ≠ correspondence a b x) : ¬ (∀ y, b.read (f y) = a.read y) :=
 fun preserves => different (uniqueRecordPreservingRelabeling a b f preserves x)

-- The complete invariant record has exactly the three source components.
structure InvariantRecord (Event Causal Paths : Type) where
 coincidence : Event
 interval : SpacetimeInterval.Separation Causal
 limitingPaths : Paths

theorem threeInvariantsDetermineRecord {Event Causal Paths : Type}
 (x y : InvariantRecord Event Causal Paths)
 (coincidence : x.coincidence=y.coincidence)
 (interval : x.interval=y.interval)
 (paths : x.limitingPaths=y.limitingPaths) : x=y := by
 cases x with
 | mk cx ix px => cases y with
   | mk cy iy py => cases coincidence; cases interval; cases paths; rfl

theorem threeInvariantsForceUniqueCorrespondence {Event Causal Paths : Type}
 (a : Frame (InvariantRecord Event Causal Paths) A)
 (b : Frame (InvariantRecord Event Causal Paths) B) (f : A → B)
 (coincidence : ∀ x, (b.read (f x)).coincidence=(a.read x).coincidence)
 (interval : ∀ x, (b.read (f x)).interval=(a.read x).interval)
 (paths : ∀ x, (b.read (f x)).limitingPaths=(a.read x).limitingPaths) (x : A) :
 f x=correspondence a b x :=
 uniqueRecordPreservingRelabeling a b f
   (fun y => threeInvariantsDetermineRecord _ _ (coincidence y) (interval y) (paths y)) x

end SFT.Physics.SpacetimeInertial
