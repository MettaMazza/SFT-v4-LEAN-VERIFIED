import SFT.Chemistry.BondClosure
import SFT.Chemistry.ExactComposition
namespace SFT.Chemistry.BondOrderDegree
open SFT.Physics.CosmoSpatialFlatness SFT.Foundation.ExactOperations

structure Channel where
 source : BondClosure.Channel
 share : SFT.Foundation.ExactPartCarrier.Part

def positiveShare (channel : Channel) : PositivePart := ExactComposition.positivePart channel.share

structure Record where
 bond : BondClosure.Record
 first : Channel
 rest : List Channel
 completeChannels : (first::rest).map Channel.source=bond.support.raw.channels
 partition : SFT.Host.Canonical.Value
 referenceTrace : SFT.Host.Canonical.Value

def channels (record : Record) := record.first::record.rest

def rawSupport (record : Record) :=
 naturalTotal (record.rest.map positiveShare) record.first.share.numerator record.first.share.denominator

theorem accumulationPositive (parts : List PositivePart) (n d : Nat) (hn : 0<n) (hd : 0<d) :
 0 < (naturalTotal parts n d).1 ∧ 0 < (naturalTotal parts n d).2 := by
 induction parts generalizing n d with
 | nil => exact ⟨hn,hd⟩
 | cons first rest ih =>
   exact ih _ _ (Nat.add_pos_left (Nat.mul_pos hn (Nat.pos_of_ne_zero first.denominatorNonzero)) _)
    (Nat.mul_pos hd (Nat.pos_of_ne_zero first.denominatorNonzero))

theorem supportPositive (record : Record) : 0<(rawSupport record).1 ∧ 0<(rawSupport record).2 :=
 accumulationPositive _ _ _ record.first.share.positive (Nat.pos_of_ne_zero record.first.share.denominatorNonzero)

def degree (record : Record) : PositiveFraction :=
 normalizePositive (rawSupport record).1 (rawSupport record).2 (supportPositive record).1 (supportPositive record).2

theorem exactDegree (record : Record) :
 (rawSupport record).1 * (degree record).denominator =
 (degree record).numerator * (rawSupport record).2 := normalizedValuePreserved _ _ _ _

theorem positiveDegree (record : Record) : 0<(degree record).numerator := (degree record).positive

def localizedUnit : PositivePart := ⟨1,1,by decide,by decide,by decide⟩

theorem localizedReferenceIsOne : localizedUnit.numerator=1 ∧ localizedUnit.denominator=1 := ⟨rfl,rfl⟩

theorem oneReferenceDegree :
 (normalizePositive localizedUnit.numerator localizedUnit.denominator localizedUnit.positive
  (Nat.pos_of_ne_zero localizedUnit.denominatorNonzero)).numerator = 1 ∧
 (normalizePositive localizedUnit.numerator localizedUnit.denominator localizedUnit.positive
  (Nat.pos_of_ne_zero localizedUnit.denominatorNonzero)).denominator = 1 :=
 (normalizationOneIff _ _ _ _).mpr rfl

theorem completeCount (record : Record) : (channels record).length=BondClosure.joiningMultiplicity record.bond.support := by
 have equal := congrArg List.length record.completeChannels
 rw [SFT.Foundation.CommonRefinement.mapLength] at equal
 exact equal

theorem appendSupport (record : Record) (next : Channel) :
 naturalTotal ((record.rest++[next]).map positiveShare) record.first.share.numerator record.first.share.denominator =
 ((rawSupport record).1*next.share.denominator+next.share.numerator*(rawSupport record).2,
  (rawSupport record).2*next.share.denominator) := by
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,totalAppend]
 rfl

theorem splitSupportScaled (before tail : List PositivePart) (parent left right : PositivePart)
 (split : (left.numerator*right.denominator+right.numerator*left.denominator)*parent.denominator =
 parent.numerator*(left.denominator*right.denominator)) :
 ((naturalTotal (before++left::right::tail)).1*parent.denominator,
  (naturalTotal (before++left::right::tail)).2*parent.denominator) =
 ((naturalTotal (before++parent::tail)).1*(left.denominator*right.denominator),
  (naturalTotal (before++parent::tail)).2*(left.denominator*right.denominator)) := by
 rw [totalAppend,totalAppend]
 have step := congrArg (fun pair : Nat × Nat => naturalTotal tail pair.1 pair.2)
  (splitScaled parent left right (naturalTotal before).1 (naturalTotal before).2 split)
 rw [naturalTotalScaled,naturalTotalScaled] at step
 exact step

theorem localizedUnitsCount (count initial : Nat) :
 naturalTotal (List.replicate count localizedUnit) initial 1 = (initial+count,1) := by
 induction count generalizing initial with
 | zero => rw [Nat.add_zero]; rfl
 | succ count ih =>
   change naturalTotal (List.replicate count localizedUnit) (initial*1+1*1) (1*1) = (initial+(count+1),1)
   rw [Nat.mul_one]
   change naturalTotal (List.replicate count localizedUnit) (initial+1) 1 = (initial+(count+1),1)
   rw [ih,Nat.add_right_comm initial 1 count,Nat.add_assoc]

-- The enlarged physical record is supplied by the original closed-bond
-- construction; channel and identity bindings prevent a detached index.
def append (record : Record) (next : Channel) (bond : BondClosure.Record)
 (support : bond.support.raw.channels=record.bond.support.raw.channels++[next.source])
 (_sameIdentity : bond.entity=record.bond.entity) : Record where
 bond := bond
 first := record.first
 rest := record.rest++[next]
 completeChannels := by
  change ((record.first::record.rest)++[next]).map Channel.source = bond.support.raw.channels
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,record.completeChannels,support]
  rfl
 partition := record.partition
 referenceTrace := record.referenceTrace

theorem appendRetainsPartition (record : Record) (next : Channel) (bond : BondClosure.Record)
 (support : bond.support.raw.channels=record.bond.support.raw.channels++[next.source])
 (sameIdentity : bond.entity=record.bond.entity) :
 (append record next bond support sameIdentity).partition=record.partition ∧
 (append record next bond support sameIdentity).referenceTrace=record.referenceTrace ∧
 (append record next bond support sameIdentity).bond.entity=record.bond.entity := ⟨rfl,rfl,sameIdentity⟩

theorem appendRetainsEveryChannel (record : Record) (next prior : Channel) (bond : BondClosure.Record)
 (support : bond.support.raw.channels=record.bond.support.raw.channels++[next.source])
 (sameIdentity : bond.entity=record.bond.entity) (held : prior ∈ channels record) :
 prior ∈ channels (append record next bond support sameIdentity) :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

structure Sharing (record : Record) where
 parent : Channel
 retained : parent ∈ channels record
 left : SFT.Foundation.ExactPartCarrier.Part
 right : SFT.Foundation.ExactPartCarrier.Part
 exactSplit : (left.numerator*right.denominator+right.numerator*left.denominator)*parent.share.denominator =
 parent.share.numerator*(left.denominator*right.denominator)

def sharingTrace {record : Record} (sharing : Sharing record) :=
 (record.bond.entity,record.partition,sharing.parent,sharing.left,sharing.right)

theorem sharingRetainsSourceAndPartition {record : Record} (sharing : Sharing record) :
 (sharingTrace sharing).1=record.bond.entity ∧
 (sharingTrace sharing).2.1=record.partition ∧
 (sharingTrace sharing).2.2.1=sharing.parent := ⟨rfl,rfl,rfl⟩

theorem sharingPreservesExactSupport {record : Record} (sharing : Sharing record)
 (before tail : List PositivePart) :
 ((naturalTotal (before++ExactComposition.positivePart sharing.left::ExactComposition.positivePart sharing.right::tail)).1*sharing.parent.share.denominator,
  (naturalTotal (before++ExactComposition.positivePart sharing.left::ExactComposition.positivePart sharing.right::tail)).2*sharing.parent.share.denominator) =
 ((naturalTotal (before++positiveShare sharing.parent::tail)).1*(sharing.left.denominator*sharing.right.denominator),
  (naturalTotal (before++positiveShare sharing.parent::tail)).2*(sharing.left.denominator*sharing.right.denominator)) :=
 splitSupportScaled before tail (positiveShare sharing.parent) (ExactComposition.positivePart sharing.left)
 (ExactComposition.positivePart sharing.right) sharing.exactSplit

end SFT.Chemistry.BondOrderDegree


