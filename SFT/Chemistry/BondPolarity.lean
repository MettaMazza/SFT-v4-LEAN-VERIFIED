import SFT.Chemistry.AffinityTraceBinding
import SFT.Chemistry.CovalentSharing
namespace SFT.Chemistry.BondPolarity
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
-- Exact redox_derivation.py PolarBondRecord constructor; its trace boundary
-- is represented separately rather than strengthening the Python guard.
structure Raw where
 bondIdentity : String
 affinity : AffinityComparison.Comparison
 orientedPartition : HeldLabel

def admit (raw : Raw) : Except String Raw :=
 if !SourceText.nonblank raw.bondIdentity ||
 !(SFT.Host.Text.equal raw.orientedPartition.family "bond-polarity") then
 .error "polar bond requires a named bond and held partition orientation"
 else .ok raw

structure Record where
 raw : Raw
 accepted : admit raw = .ok raw

def originalRaw : Raw :=
 ⟨"bond-a-b",AffinityComparison.original,⟨"bond-polarity","toward-atom-b",rfl,rfl⟩⟩
theorem originalAdmitted : admit originalRaw = .ok originalRaw := rfl
def original : Record := ⟨originalRaw,originalAdmitted⟩
theorem originalBondHeld : original.raw.bondIdentity = "bond-a-b" := rfl
theorem originalOrientationHeld : original.raw.orientedPartition.family = "bond-polarity" := rfl

-- This binds the original finite covalent support to both complete traces.
structure Bond where
 record : Record
 comparison : AffinityTraceBinding.BoundComparison
 affinityBinding : comparison.comparison = record.raw.affinity
 shared : CovalentSharing.Shared HeldLabel
 supportBinding : shared.carrier = record.raw.affinity.raw.sharedSupport
 firstBinding : shared.leftNucleus = record.raw.affinity.raw.firstAtom
 secondBinding : shared.rightNucleus = record.raw.affinity.raw.secondAtom

inductive PartialOrientation where
 | toward | away
 deriving DecidableEq

def opposite : PartialOrientation → PartialOrientation
 | .toward => .away
 | .away => .toward

def firstOrientation (b : Bond) : PartialOrientation :=
 if b.record.raw.affinity.raw.preferredEndpoint = b.record.raw.affinity.raw.firstAtom
 then .toward else .away

structure Partition where
 bond : Bond
 first : PartialOrientation
 second : PartialOrientation

def orient (b : Bond) : Partition := ⟨b,firstOrientation b,opposite (firstOrientation b)⟩

def unequal (b : Bond) : Prop :=
 ¬AffinityTraceBinding.sameTrace b.comparison.first b.comparison.second
instance (b : Bond) : Decidable (unequal b) := inferInstanceAs (Decidable (¬AffinityTraceBinding.sameTrace b.comparison.first b.comparison.second))

-- Original successor: retain every bond, adding an orientation exactly for
-- unequal complete comparisons. Equal traces do not choose an endpoint.
def partition (b : Bond) : Option Partition := if unequal b then some (orient b) else none

theorem orientationExactlyWhenUnequal (b : Bond) :
 partition b = some (orient b) ↔ unequal b := by
 unfold partition
 by_cases h : unequal b
 · rw [ite_eq_left h]; exact ⟨fun _ => h,fun _ => rfl⟩
 · rw [ite_eq_right h]; exact ⟨(fun e => nomatch e),fun e => False.elim (h e)⟩

theorem equalTracesUnoriented (b : Bond)
 (same : AffinityTraceBinding.sameTrace b.comparison.first b.comparison.second) : partition b = none :=
 ite_eq_right (fun different => different same)

theorem oppositeDistinct (o : PartialOrientation) : o ≠ opposite o := by
 cases o <;> intro h <;> cases h

theorem opposedResponses (b : Bond) : (orient b).second = opposite (orient b).first := rfl
theorem distinctResponses (b : Bond) : (orient b).first ≠ (orient b).second := oppositeDistinct _
theorem bondWholeRetained (b : Bond) : (orient b).bond.record = b.record := rfl
theorem completeComparisonRetained (b : Bond) : (orient b).bond.comparison = b.comparison := rfl

theorem sameSharedSupport (b : Bond) :
 b.comparison.first.support = b.comparison.second.support :=
 AffinityTraceBinding.identicalSharedSupport b.comparison

theorem bothEndpointsRetainCarrier (b : Bond) :
 CovalentSharing.access (orient b).bond.shared .left = b.record.raw.affinity.raw.sharedSupport ∧
 CovalentSharing.access (orient b).bond.shared .right = b.record.raw.affinity.raw.sharedSupport :=
 ⟨b.supportBinding,b.supportBinding⟩

theorem preferredFirstOrientsToward (b : Bond)
 (first : b.record.raw.affinity.raw.preferredEndpoint=b.record.raw.affinity.raw.firstAtom) :
 (orient b).first=.toward ∧ (orient b).second=.away := by
 change (if _ then _ else _) = _ ∧ opposite (if _ then _ else _) = _
 rw [ite_eq_left first]; exact ⟨rfl,rfl⟩

theorem preferredSecondOrientsToward (b : Bond)
 (second : b.record.raw.affinity.raw.preferredEndpoint=b.record.raw.affinity.raw.secondAtom) :
 (orient b).first=.away ∧ (orient b).second=.toward := by
 have distinct : b.record.raw.affinity.raw.firstAtom ≠ b.record.raw.affinity.raw.secondAtom := by
  rw [← b.firstBinding,← b.secondBinding]; exact b.shared.distinctNuclei
 have notFirst : b.record.raw.affinity.raw.preferredEndpoint ≠ b.record.raw.affinity.raw.firstAtom :=
  fun first => distinct (first.symm.trans second)
 change (if _ then _ else _) = _ ∧ opposite (if _ then _ else _) = _
 rw [ite_eq_right notFirst]; exact ⟨rfl,rfl⟩

def history (bonds : List Bond) : List (Bond × Option Partition) :=
 bonds.map fun b => (b,partition b)

theorem completeBondHistory (bonds : List Bond) : (history bonds).map Prod.fst = bonds := by
 induction bonds with
 | nil => rfl
 | cons b rest ih => exact congrArg (List.cons b) ih

theorem successor (prior : List Bond) (next : Bond) :
 history (prior++[next]) = history prior ++ [(next,partition next)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem earlierRecordsRetained (prior : List Bond) (next : Bond)
 (row : Bond × Option Partition) (held : row ∈ history prior) :
 row ∈ history (prior++[next]) := by
 rw [successor]; exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem base (b : Bond) (different : unequal b) :
 history [b] = [(b,some (orient b))] := by
 change [(b,partition b)] = _
 rw [(orientationExactlyWhenUnequal b).mpr different]
-- No second orientation is permitted for the same retained comparison.
def FollowsPreference (b : Bond) (first second : PartialOrientation) : Prop :=
 (b.record.raw.affinity.raw.preferredEndpoint=b.record.raw.affinity.raw.firstAtom → first=.toward) ∧
 (b.record.raw.affinity.raw.preferredEndpoint≠b.record.raw.affinity.raw.firstAtom → first=.away) ∧
 second=opposite first

theorem forcedOrientation (b : Bond) (first second : PartialOrientation)
 (law : FollowsPreference b first second) : first=(orient b).first ∧ second=(orient b).second := by
 have h : first=firstOrientation b := by
  unfold firstOrientation
  by_cases preferred : b.record.raw.affinity.raw.preferredEndpoint=b.record.raw.affinity.raw.firstAtom
  · rw [ite_eq_left preferred]; exact law.1 preferred
  · rw [ite_eq_right preferred]; exact law.2.1 preferred
 exact ⟨h,law.2.2.trans (congrArg opposite h)⟩

theorem orientationSatisfiesPreference (b : Bond) : FollowsPreference b (orient b).first (orient b).second := by
 refine ⟨?_,?_,rfl⟩
 · intro h; exact (preferredFirstOrientsToward b h).1
 · intro h; change (if _ then _ else _)=_; rw [ite_eq_right h]
end SFT.Chemistry.BondPolarity
