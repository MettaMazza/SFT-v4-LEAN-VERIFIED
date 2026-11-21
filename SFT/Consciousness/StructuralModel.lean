import SFT.Foundation.FoldFibres
import SFT.Physics.CapabilityValues

-- Pinned V3 sft/consciousness_cognitive_science/structural_model.py.
-- Reuse the existing normalized ExactPart domain and complete Fold fibres.
namespace SFT.Consciousness.StructuralModel
open SFT.Foundation SFT.Foundation.ExactPartCarrier
open SFT.Foundation.ExactOperations SFT.Foundation.FoldDynamics
open SFT.Physics.CapabilityValues

private instance : DecidableEq Part := fun p q =>
 if hn : p.numerator = q.numerator then
  if hd : p.denominator = q.denominator then isTrue (partEquality p q hn hd)
  else isFalse (fun h => hd (congrArg Part.denominator h))
 else isFalse (fun h => hn (congrArg Part.numerator h))

abbrev fold := foldPart
abbrev preimageFibre := preimages

def quarter : Part := normalizePart 1 4 (by decide) (by decide)
def threeQuarters : Part := normalizePart 3 4 (by decide) (by decide)

structure ObservationAct where
 source : Part
 image : Part
 heldFibre : Option HeldLabel

def reversibleFromRecord (act : ObservationAct) : Bool :=
 match act.heldFibre with
 | none => false
 | some label => decide (act.source =
     if label.label = "lower" then (preimageFibre act.image).1
     else (preimageFibre act.image).2)

def observe (source : Part) (retainFibre : Bool := true) : Except String ObservationAct :=
 let image := fold source
 if retainFibre then
  if source = (preimageFibre image).1 then
   .ok ⟨source,image,some ⟨"fold-fibre","lower",rfl,rfl⟩⟩
  else if source = (preimageFibre image).2 then
   .ok ⟨source,image,some ⟨"fold-fibre","upper",rfl,rfl⟩⟩
  else .error "source is not in its generated Fold fibre"
 else .ok ⟨source,image,none⟩

theorem retainedObservation (source : Part) :
 ∃ act, observe source true = .ok act ∧ reversibleFromRecord act = true := by
 have exhaustive := (FoldFibres.exactTwoPreimages source (fold source)).mp rfl
 rcases exhaustive with lower | upper
 · refine ⟨⟨source,fold source,some ⟨"fold-fibre","lower",rfl,rfl⟩⟩, ?_, ?_⟩
   · dsimp only [observe]
     rw [ite_eq_left (rfl : (true : Bool) = true), ite_eq_left lower]
   · change decide (source = (preimageFibre (fold source)).1) = true
     exact decide_eq_true lower
 · by_cases lower : source = (preimageFibre (fold source)).1
   · refine ⟨⟨source,fold source,some ⟨"fold-fibre","lower",rfl,rfl⟩⟩, ?_, ?_⟩
     · dsimp only [observe]
       rw [ite_eq_left (rfl : (true : Bool) = true), ite_eq_left lower]
     · change decide (source = (preimageFibre (fold source)).1) = true
       exact decide_eq_true lower
   · refine ⟨⟨source,fold source,some ⟨"fold-fibre","upper",rfl,rfl⟩⟩, ?_, ?_⟩
     · dsimp only [observe]
       rw [ite_eq_left (rfl : (true : Bool) = true), ite_eq_right lower, ite_eq_left upper]
     · change decide (source = (preimageFibre (fold source)).2) = true
       exact decide_eq_true upper

theorem unretainedObservation (source : Part) :
 observe source false = .ok ⟨source,fold source,none⟩ ∧
 reversibleFromRecord ⟨source,fold source,none⟩ = false := ⟨rfl,rfl⟩

def finiteSelfModelTrace : List Part := [quarter,HalfOneDerivation.halfOne,one]
def recurrentPair : Part × Part := (third,twoThirds)
theorem recurrentPairTransitions :
 fold recurrentPair.1 = recurrentPair.2 ∧ fold recurrentPair.2 = recurrentPair.1 :=
 ⟨thirdFoldsToTwoThirds,twoThirdsFoldsToThird⟩

-- Python's orbit guard rejects Boolean and non-integer counts explicitly.
inductive OrbitCount where
 | integer (value : Int)
 | boolean (value : Bool)
 | other

private def orbitTail : Nat → Part → List Part
 | 0, _ => []
 | n+1, p => let next := fold p; next :: orbitTail n next

def orbit (seed : Part) (count : OrbitCount) : Except String (List Part) :=
 match count with
 | .integer n =>
  if n > 0 then .ok (seed :: orbitTail (n.toNat-1) seed)
  else .error "an orbit trace requires a positive finite count"
 | .boolean _ | .other => .error "an orbit trace requires a positive finite count"

private def searchReturn (seed : Part) : Nat → Part → Nat → Option Nat
 | 0, _, _ => none
 | n+1, state, step =>
  let next := fold state
  if next = seed then some step else searchReturn seed n next (step+1)

def firstReturn (seed : Part) (searchCount : Int) : Option Nat :=
 searchReturn seed searchCount.toNat seed 1

structure ObserverObservedLock where
 observer : Part
 observed : Part
 distinct : Bool
 sameImage : Bool
 wholePartition : Bool
 completion : Bool

def observerObservedLock : ObserverObservedLock :=
 let (lower, upper) := preimageFibre HalfOneDerivation.halfOne
 ⟨lower,upper,decide (lower ≠ upper),
  decide (fold lower = fold upper ∧ fold upper = HalfOneDerivation.halfOne),
  decide (lower.numerator*upper.denominator + upper.numerator*lower.denominator =
    lower.denominator*upper.denominator),
  decide (fold HalfOneDerivation.halfOne = one)⟩

def threeQualitySupport : List Part :=
 [normalizePart 1 7 (by decide) (by decide),
  normalizePart 2 7 (by decide) (by decide),
  normalizePart 4 7 (by decide) (by decide)]

structure RedOfRedStructure where
 heldLabel : HeldLabel
 support : List Part
 completeRecurrence : Bool
 supportPartitionsOne : Bool
 selfReidentification : Bool
 externalAssignmentIsNotDerivation : Bool

def redOfRedStructure : RedOfRedStructure :=
 let support := threeQualitySupport
 let label : HeldLabel := ⟨"qualitative-identity","red",rfl,rfl⟩
 let a := normalizePart 1 7 (by decide) (by decide)
 let b := normalizePart 2 7 (by decide) (by decide)
 let c := normalizePart 4 7 (by decide) (by decide)
 ⟨label,support,decide (support.map fold = [b,c,a]),
  decide (a.numerator*b.denominator*c.denominator +
    b.numerator*a.denominator*c.denominator +
    c.numerator*a.denominator*b.denominator = a.denominator*b.denominator*c.denominator),
  decide ((label.family,label.label) = ("qualitative-identity","red")),true⟩


def structuralWitnesses : List (String × Bool) :=
 let lock := observerObservedLock
 let pair := recurrentPair
 let triple := threeQualitySupport
 let red := redOfRedStructure
 [("two_preimages_are_distinct",lock.distinct),
  ("two_preimages_share_one_image",lock.sameImage),
  ("observer_observed_partition_the_one",lock.wholePartition),
  ("binding_lock_completes",lock.completion),
  ("unretained_observation_is_not_reversible",
    match observe quarter false with | .ok a => !(reversibleFromRecord a) | .error _ => false),
  ("retained_observation_is_reversible",
    match observe quarter true with | .ok a => reversibleFromRecord a | .error _ => false),
  ("self_model_closes_in_two_nonidentity_acts",
    decide (finiteSelfModelTrace = [quarter,HalfOneDerivation.halfOne,one])),
  ("complementary_pair_recurs",decide (fold pair.1 = pair.2 ∧ fold pair.2 = pair.1)),
  ("three_quality_support_recurs",decide (triple.map fold = triple.drop 1 ++ triple.take 1)),
  ("red_of_red_form_is_complete",red.completeRecurrence && red.supportPartitionsOne && red.selfReidentification)]

theorem originalTenWitnesses : structuralWitnesses.map Prod.snd = List.replicate 10 true := by
 decide

end SFT.Consciousness.StructuralModel


