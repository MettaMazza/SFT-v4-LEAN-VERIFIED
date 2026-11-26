import SFT.Consciousness.StructuralModel

-- Pinned V3 sft/consciousness/nonordinary_laws_v1.py:
-- the four original zero-argument records, with the existing exact Fold carrier.
namespace SFT.Consciousness.NonordinaryLaws
open SFT.Foundation SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Foundation.FoldDynamics SFT.Consciousness.StructuralModel
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000

private instance : DecidableEq Part := fun p q =>
 if hn : p.numerator = q.numerator then
  if hd : p.denominator = q.denominator then isTrue (partEquality p q hn hd)
  else isFalse (fun h => hd (congrArg Part.denominator h))
 else isFalse (fun h => hn (congrArg Part.numerator h))

structure DirectionalRecord where
 trigger : Part
 concurrent : Part
 triggerImage : Part
 concurrentImage : Part
 joint : Part
 directedRoutes : List (String × String)
 reverseRoutePresent : Bool
 stableRepeat : List (List (String × String))

def directionalSynaesthesiaRecord : DirectionalRecord :=
 let trigger := quarter
 let concurrent := threeQuarters
 let routes := [("trigger-channel", "concurrent-channel")]
 let joint := normalizePart
  (quarter.numerator*threeQuarters.denominator+threeQuarters.numerator*quarter.denominator)
  (quarter.denominator*threeQuarters.denominator) (by decide) (by decide)
 ⟨trigger,concurrent,fold trigger,fold concurrent,joint,routes,
  routes.contains ("concurrent-channel","trigger-channel"),List.replicate 3 routes⟩

structure ThreeQualityRecord where
 trace : List Part
 next : Part
 partition : Part
 distinct : Nat
 generatedSupport : List Part
 externalInformationCreated : Bool

def threeQualityOrbit : ThreeQualityRecord :=
 let start := normalizePart 1 7 (by decide) (by decide)
 let middle := fold start
 let last := fold middle
 let trace := [start,middle,last]
 let partition := normalizePart
  (start.numerator*middle.denominator*last.denominator+
   middle.numerator*start.denominator*last.denominator+
   last.numerator*start.denominator*middle.denominator)
  (start.denominator*middle.denominator*last.denominator) (by decide) (by decide)
 let support := trace.eraseDups
 ⟨trace,fold last,partition,support.length,support,false⟩

structure SleepRecord where
 deep : Part
 rem : Part
 deepImage : Part
 remImage : Part
 partition : Part
 balance : Part
 wakingCompletion : Part
 physiologicalLabelsAreCorrespondence : Bool

def sleepDreamOrbit : SleepRecord :=
 let deep := third
 let rem := twoThirds
 let numerator := third.numerator*twoThirds.denominator+twoThirds.numerator*third.denominator
 let denominator := third.denominator*twoThirds.denominator
 let partition := normalizePart numerator denominator (by decide) (by decide)
 let balance := normalizePart numerator (denominator*2) (by decide) (by decide)
 ⟨deep,rem,fold deep,fold rem,partition,balance,fold balance,true⟩

structure CessationRecord where
 occupiedLock : Part
 releasedLockLabel : String
 components : List Part
 componentsComplete : Part
 anchor : Part
 lockCompletesToAnchor : Part
 anchorImage : Part
 personalOrganizationPersists : Bool
 structuralAbsenceIsNumericZero : Bool

def cessationLockAnchor : CessationRecord :=
 let lock := HalfOneDerivation.halfOne
 let anchor := one
 let components := [quarter,threeQuarters]
 let complete := normalizePart
  (quarter.numerator*threeQuarters.denominator+threeQuarters.numerator*quarter.denominator)
  (quarter.denominator*threeQuarters.denominator) (by decide) (by decide)
 ⟨lock,"unoccupied",components,complete,anchor,fold lock,fold anchor,false,false⟩

def synaesthesiaWitnesses : List Bool :=
 let s := directionalSynaesthesiaRecord
 [decide (s.triggerImage = s.concurrentImage ∧ s.concurrentImage = HalfOneDerivation.halfOne),
  decide (s.joint = one),!s.reverseRoutePresent]
def threeQualityWitnesses : List Bool :=
 let t := threeQualityOrbit
 [decide (t.distinct = 3 ∧ t.next = normalizePart 1 7 (by decide) (by decide)),
  decide (t.partition = one),!t.externalInformationCreated]
def sleepWitnesses : List Bool :=
 let s := sleepDreamOrbit
 [decide (s.deepImage = s.rem ∧ s.remImage = s.deep),
  decide (s.partition = one ∧ s.balance = HalfOneDerivation.halfOne ∧ s.wakingCompletion = one)]
def cessationWitnesses : List Bool :=
 let c := cessationLockAnchor
 [decide (c.componentsComplete = one),
  decide (c.lockCompletesToAnchor = c.anchorImage ∧ c.anchorImage = one),
  !c.personalOrganizationPersists && !c.structuralAbsenceIsNumericZero]

theorem synaesthesiaWitnessesPassed : synaesthesiaWitnesses = [true,true,true] := by decide
theorem threeQualityWitnessesPassed : threeQualityWitnesses = [true,true,true] := by decide
theorem sleepWitnessesPassed : sleepWitnesses = [true,true] := by decide
theorem cessationWitnessesPassed : cessationWitnesses = [true,true,true] := by decide

theorem directedRouteRepeated : directionalSynaesthesiaRecord.stableRepeat =
 List.replicate 3 directionalSynaesthesiaRecord.directedRoutes := rfl

theorem quarterFibre : directionalSynaesthesiaRecord.trigger =
 (preimages HalfOneDerivation.halfOne).1 ∧ directionalSynaesthesiaRecord.concurrent =
 (preimages HalfOneDerivation.halfOne).2 := by decide

theorem threeQualityTransitions : threeQualityOrbit.trace.map fold =
 threeQualityOrbit.trace.drop 1 ++ threeQualityOrbit.trace.take 1 := by decide

theorem threeQualitySupportPreserved : threeQualityOrbit.generatedSupport =
 threeQualityOrbit.trace := by decide

theorem sleepTransitions : sleepDreamOrbit.deepImage = sleepDreamOrbit.rem ∧
 sleepDreamOrbit.remImage = sleepDreamOrbit.deep :=
 ⟨thirdFoldsToTwoThirds,twoThirdsFoldsToThird⟩

theorem fixedCessationAnchor : fold cessationLockAnchor.anchor = cessationLockAnchor.anchor :=
 oneFoldFixed
end SFT.Consciousness.NonordinaryLaws
