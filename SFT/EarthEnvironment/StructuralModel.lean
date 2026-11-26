import SFT.Foundation.FoldFibres
import SFT.Physics.CapabilityValues
namespace SFT.EarthEnvironment.StructuralModel
open SFT.Foundation SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Physics.CapabilityValues
private instance : DecidableEq Part := fun p q =>
 if hn : p.numerator = q.numerator then
  if hd : p.denominator = q.denominator then isTrue (partEquality p q hn hd)
  else isFalse (fun h => hd (congrArg Part.denominator h))
 else isFalse (fun h => hn (congrArg Part.numerator h))
abbrev fold := foldPart
def half : Part := normalizePart 1 2 (by decide) (by decide)
def quarter : Part := normalizePart 1 4 (by decide) (by decide)
def threeQuarters : Part := normalizePart 3 4 (by decide) (by decide)
inductive CountInput where
 | integer (value : Int)
 | boolean (value : Bool)
 | other
-- Raw numerator/denominator pairs are the source's host Fraction accumulator.
-- No new scientific magnitude or domain is introduced.
def sumPairs (xs : List Part) : Nat × Nat :=
 xs.foldl (fun (a,b) p => (a*p.denominator+p.numerator*b,b*p.denominator)) (0,1)
def closesOne (xs : List Part) : Bool :=
 let p := sumPairs xs
 p.1 == p.2
private theorem powPositive (n : Nat) : 0 < 2^n := by
 induction n with
 | zero => decide
 | succ n ih => exact Nat.mul_pos ih (by decide : 0<2)
def reciprocalPower (n : Nat) : Part :=
 normalizePart 1 (2^n) (by decide) (powPositive n)
def equalReservoirPartition (depth : CountInput) : Except String (List Part) :=
 match depth with
 | .integer n =>
  if n >= 1 then
   let result := List.replicate (2^n.toNat) (reciprocalPower n.toNat)
   if closesOne result then .ok result
   else .error "reservoir stocks do not close to the One"
  else .error "a reservoir partition requires positive finite depth"
 | .boolean _ | .other => .error "a reservoir partition requires positive finite depth"
structure Transfer where
 carrier : HeldLabel
 source : HeldLabel
 destination : HeldLabel
 amount : Part
def boundaryTransfer : Transfer :=
 ⟨⟨"earth-carrier","registered-material",rfl,rfl⟩,
  ⟨"earth-reservoir","source",rfl,rfl⟩,
  ⟨"earth-reservoir","destination",rfl,rfl⟩,quarter⟩
def transferIsTwoSided (t : Transfer) : Bool :=
 (!(t.source.family == t.destination.family && t.source.label == t.destination.label)) &&
 decide (0<t.amount.numerator) && decide (t.amount.numerator<=t.amount.denominator) &&
 (t.carrier.family == "earth-carrier")
def layerOrder (depth : CountInput) : Except String (List Part) :=
 match depth with
 | .integer n =>
  if n>=1 then .ok ((List.range n.toNat).map (fun i => reciprocalPower (i+1)))
  else .error "a layer order requires positive finite depth"
 | .boolean _ | .other => .error "a layer order requires positive finite depth"
def complementaryCycle : Except String (Part × Part) :=
 let lower := normalizePart 1 3 (by decide) (by decide)
 let upper := normalizePart 2 3 (by decide) (by decide)
 if fold lower = upper ∧ fold upper = lower then .ok (lower,upper)
 else .error "the complementary Earth-system cycle failed"
def coupledThreeReservoirCycle : Except String (List Part) :=
 let a := normalizePart 1 7 (by decide) (by decide)
 let b := normalizePart 2 7 (by decide) (by decide)
 let c := normalizePart 4 7 (by decide) (by decide)
 let states := [a,b,c]
 if states.map fold = [b,c,a] then
  if closesOne states then .ok states
  else .error "the coupled reservoirs do not partition the One"
 else .error "the coupled three-reservoir cycle failed"
structure TippingFibre where
 lowerBasin : Part
 upperBasin : Part
 sharedImage : Part
 basinsDistinct : Bool
 sameFoldImage : Bool
 physicalThresholdAssigned : Bool
def tippingFibre : TippingFibre :=
 ⟨quarter,threeQuarters,half,decide (quarter≠threeQuarters),
 decide (fold quarter=fold threeQuarters ∧ fold threeQuarters=half),false⟩
structure MagnitudeRow where
 scale : Nat
 size : Part
 count : Nat
 countTimesSize : PositiveFraction
def magnitudeRow (scale : Nat) : MagnitudeRow :=
 let size := reciprocalPower scale
 let count := 2^scale
 ⟨scale,size,count,normalizePositive (count*size.numerator) size.denominator
  (Nat.mul_pos (powPositive scale) size.positive) (denominatorPositive size)⟩
def magnitudeFrequencyCensus (depth : CountInput := .integer 8) : Except String (List MagnitudeRow) :=
 match depth with
 | .integer n =>
  if n>=2 then
   let rows := (List.range n.toNat).map (fun i => magnitudeRow (i+1))
   if rows.all (fun row => row.countTimesSize.numerator == row.countTimesSize.denominator) then .ok rows
   else .error "unit size-count recurrence failed"
  else .error "a magnitude-frequency census requires at least two scales"
 | .boolean _ | .other => .error "a magnitude-frequency census requires at least two scales"
def uniquePositiveExponent (depth : CountInput := .integer 8) : Except String Nat := do
 let rows ← magnitudeFrequencyCensus depth
 let survivors := [1,2,3].filter (fun e => rows.all (fun row =>
   row.count * row.size.numerator^e == row.size.denominator^e))
 if survivors == [1] then pure 1
 else .error "the generated exponent census is not unique"
def boundedCavityModes (count : CountInput := .integer 5) : Except String (List HeldLabel) :=
 match count with
 | .integer n =>
  if n>=1 then (List.range n.toNat).mapM (fun i => heldLabel "bounded-cavity-mode" (toString (i+1)))
  else .error "a cavity requires a positive finite mode count"
 | .boolean _ | .other => .error "a cavity requires a positive finite mode count"
def observationStatuses : List HeldLabel :=
 [⟨"earth-observation-status","observed-present",rfl,rfl⟩,
  ⟨"earth-observation-status","observed-absent",rfl,rfl⟩,
  ⟨"earth-observation-status","non-detected",rfl,rfl⟩,
  ⟨"earth-observation-status","censored",rfl,rfl⟩,
  ⟨"earth-observation-status","missing",rfl,rfl⟩,
  ⟨"earth-observation-status","outside-scope",rfl,rfl⟩]
def labelsDistinct (xs : List HeldLabel) : Bool :=
 let keys := xs.map (fun x => (x.family,x.label))
 decide (keys.Pairwise (· ≠ ·))
def structuralWitnesses : Except String (List (String × Bool)) := do
 let partition ← equalReservoirPartition (.integer 3)
 let cycle ← complementaryCycle
 let coupled ← coupledThreeReservoirCycle
 let layers ← layerOrder (.integer 5)
 let exponent ← uniquePositiveExponent
 let modes ← boundedCavityModes
 let tipping := tippingFibre
 pure [("reservoir_partition_closes",closesOne partition),
  ("boundary_transfer_is_two_sided",transferIsTwoSided boundaryTransfer),
  ("layers_are_positive_and_ordered",decide (layers=(List.range 5).map (fun i => reciprocalPower (i+1)))),
  ("complementary_cycle_recurs",decide (fold cycle.1=cycle.2 ∧ fold cycle.2=cycle.1)),
  ("coupled_cycle_recurs_and_closes",decide (coupled.map fold = coupled.drop 1 ++ coupled.take 1) && closesOne coupled),
  ("tipping_basins_share_image_without_physical_assignment",tipping.basinsDistinct && tipping.sameFoldImage && !tipping.physicalThresholdAssigned),
  ("unit_exponent_is_uniquely_enumerated",exponent==1),
  ("bounded_cavity_has_distinct_modes",labelsDistinct modes),
  ("observation_statuses_remain_distinct",labelsDistinct observationStatuses)]
theorem originalNineWitnesses :
 (structuralWitnesses.map (List.map Prod.snd)) = .ok (List.replicate 9 true) := by rfl
theorem complementaryRecurrence :
 fold FoldDynamics.third = FoldDynamics.twoThirds ∧ fold FoldDynamics.twoThirds = FoldDynamics.third :=
 ⟨FoldDynamics.thirdFoldsToTwoThirds,FoldDynamics.twoThirdsFoldsToThird⟩
theorem statusSeparation : labelsDistinct observationStatuses = true := by decide
theorem transferWitness : transferIsTwoSided boundaryTransfer = true := by decide
end SFT.EarthEnvironment.StructuralModel
