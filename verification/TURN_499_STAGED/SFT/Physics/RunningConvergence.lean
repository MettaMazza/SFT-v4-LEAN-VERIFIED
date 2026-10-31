import SFT.Physics.SectorInventory
namespace SFT.Physics.RunningConvergence
open GeneratorOperations AlphaCovers

-- coupling_running_convergence_terminal_law_v1.py: One-based depth,
-- with the original positive-count guard and repeated binary succession.
def scaleLoop : Nat → Nat → Nat
 | 0,support => support
 | steps+1,support => scaleLoop steps (support*2)

theorem scaleLoopExact (steps support : Nat) : scaleLoop steps support = support*2^steps := by
 induction steps generalizing support with
 | zero => exact (Nat.mul_one _).symm
 | succ steps ih =>
   change scaleLoop steps (support*2) = support*(2^steps*2)
   rw [ih,SFT.Foundation.FractionReduction.mulAssoc,Nat.mul_comm 2 (2^steps)]

def generatedScaleSupport : CountInput → Except String Nat
 | .boolean _ => .error "scale level must be a generated positive whole count"
 | .integer (.negSucc _) => .error "scale level must be a generated positive whole count"
 | .integer (.ofNat 0) => .error "scale level must be a generated positive whole count"
 | .integer (.ofNat (k+1)) => .ok (scaleLoop k 1)

theorem everyPositiveLevel (k : Nat) : generatedScaleSupport (.integer (.ofNat (k+1))) = .ok (2^k) := by
 change Except.ok (scaleLoop k 1) = Except.ok (2^k)
 rw [scaleLoopExact,Nat.one_mul]

theorem supportSuccessor (k : Nat) : 2^(k+1)=2^k*2 := rfl

def generatorIndexedCoupling (sector level : CountInput) : Except String Rat := do
 let support ← generatedScaleSupport level
 SectorInventory.runningCoupling sector (.integer (.ofNat support))

def commonScaleVector (level : CountInput) : Except String (List (Nat × Rat)) := do
 let support ← generatedScaleSupport level
 let sectors ← PrimeSectorLadder.primeSectorLadder
 sectors.mapM fun sector => do
   let value ← SectorInventory.runningCoupling (.integer (.ofNat sector)) (.integer (.ofNat support))
   pure (sector,value)

-- Start the existing proved binary-cover loop at support One, depth offset zero.
def reachingDepth (required : Nat) : Nat :=
 (coverBounded required required 0 1 (by decide) (Nat.le_add_left required 1)).val

def reachingPair (required : Nat) : Nat × Nat := (reachingDepth required+1,2^reachingDepth required)

theorem reachingSourceRun (required : Nat) : CoverRun required 0 1 (reachingDepth required) :=
 (coverBounded required required 0 1 (by decide) (Nat.le_add_left required 1)).property

theorem reachingCovers (required : Nat) : required ≤ (reachingPair required).2 :=
 runCovered required 0 1 _ (reachingSourceRun required) rfl

theorem reachingSupportPositive (required : Nat) : 0 < (reachingPair required).2 := Nat.pow_pos (by decide)

def levelReachingSupport : CountInput → Except String (Nat × Nat)
 | .boolean _ => .error "required support must be a positive whole count"
 | .integer (.negSucc _) => .error "required support must be a positive whole count"
 | .integer (.ofNat 0) => .error "required support must be a positive whole count"
 | .integer (.ofNat (n+1)) => .ok (reachingPair (n+1))

theorem pairDenominatorExceedsSupport (p q support : Nat) (hp : 0<p) (hq : 0<q) :
 support < (p+support)*(q+support) := by
 have first : support < p+support := Nat.lt_add_of_pos_left hp
 have factor : 0 < q+support := Nat.add_pos_left hq _
 exact Nat.lt_of_lt_of_le first (Nat.le_mul_of_pos_right _ factor)

theorem everyPositiveToleranceWitness (p q denominator : Nat) (hp : 0<p) (hq : 0<q) :
 (q-p)*denominator <
 (p+(reachingPair ((q-p)*denominator)).2)*(q+(reachingPair ((q-p)*denominator)).2) :=
 Nat.lt_of_le_of_lt (reachingCovers _) (pairDenominatorExceedsSupport p q _ hp hq)

theorem doubledGapDenominatorIncreases (p q support : Nat) (positive : 0<support) :
 (p+support)*(q+support) < (p+support*2)*(q+support*2) := by
 have grows : support < support*2 := by
  rw [Nat.mul_succ,Nat.mul_one]
  exact Nat.lt_add_of_pos_right positive
 have left := Nat.add_lt_add_left grows p
 have right := Nat.add_lt_add_left grows q
 exact Nat.lt_trans
   (Nat.mul_lt_mul_of_pos_right left (Nat.add_pos_right _ positive))
   (Nat.mul_lt_mul_of_pos_left right (Nat.add_pos_right _ (Nat.mul_pos positive (by decide))))

theorem sourceInitialSupports : ([1,2,3,4,5,6] : List Nat).mapM
 (fun level => generatedScaleSupport (.integer (.ofNat level))) = .ok [1,2,4,8,16,32] := rfl

theorem unitCover : reachingPair 1=(1,1) := rfl
theorem exampleCover : reachingPair 55=(7,64) := rfl

theorem addSubtractLeft (a b : Nat) : (a+b)-a=b := by
 induction a with
 | zero => rw [Nat.zero_add]; rfl
 | succ a ih => rw [Nat.succ_add,Nat.succ_sub_succ_eq_sub]; exact ih

theorem orderedDifferencePositive (p q : Nat) (ordered : p<q) : 0<q-p := by
 induction p generalizing q with
 | zero => exact ordered
 | succ p ih =>
   cases q with
   | zero => exact False.elim (Nat.not_lt_zero _ ordered)
   | succ q => rw [Nat.succ_sub_succ_eq_sub]; exact ih q (Nat.le_of_succ_le_succ ordered)

theorem successorHoldingNumerator (predecessor support : Nat) :
 (predecessor+2*support)*(predecessor+support+1) -
 (predecessor+support)*(predecessor+2*support+1) = support := by
 rw [SectorInventory.gapCommonNumerator]
 rw [Nat.two_mul,← Nat.add_assoc,addSubtractLeft]

theorem finitePositiveShortfall (predecessor support : Nat) :
 (predecessor+support+1) - (predecessor+support) = 1 := by
 exact addSubtractLeft _ _

theorem pairGapStrictlyShrinks (p q support : Nat) (ordered : p<q) (positive : 0<support) :
 (q-p)*((p+support)*(q+support)) < (q-p)*((p+support*2)*(q+support*2)) :=
 Nat.mul_lt_mul_of_pos_left (doubledGapDenominatorIncreases p q support positive)
   (orderedDifferencePositive p q ordered)

-- Exact positive_take operation and error order inherited from prior_value_laws.py.
def positiveTake (whole part : Rat) : Except String Rat :=
 if part.blt whole && LeptonIntervals.zero.blt part then
   .ok (LeptonIntervals.subtract whole part)
 else .error "positive take requires a smaller positive part"

def couplingShortfall (sector level : CountInput) : Except String Rat := do
 let current ← generatorIndexedCoupling sector level
 positiveTake (LeptonIntervals.normalize 1 1 (by decide)) current

def couplingSuccessorTake (sector level : CountInput) : Except String Rat := do
 let current ← generatorIndexedCoupling sector level
 let successor ← generatorIndexedCoupling sector (.integer (SectorInventory.countValue level+1))
 positiveTake successor current

def generatorPairGap (lower upper level : CountInput) : Except String Rat := do
 let support ← generatedScaleSupport level
 SectorInventory.runningGap lower upper (.integer (.ofNat support))

def pairGapSuccessorTake (lower upper level : CountInput) : Except String Rat := do
 let current ← generatorPairGap lower upper level
 let successor ← generatorPairGap lower upper (.integer (SectorInventory.countValue level+1))
 positiveTake current successor

structure ConvergenceWitness where
 lowerSector : Int
 upperSector : Int
 tolerance : Rat
 level : Nat
 support : Nat
 gap : Rat
 gapBelowTolerance : Bool
 binarySupportReachesRequiredBound : Bool

def convergenceWitness (lower upper denominator : CountInput) : Except String ConvergenceWitness := do
 let p := SectorInventory.countValue lower
 let q := SectorInventory.countValue upper
 if !(@decide (p < q) (Int.decLt p q)) then throw "convergence requires strictly ordered sectors"
 let d ← match denominator with
   | .integer (.ofNat (d+1)) => pure (d+1)
   | .boolean _ => throw "tolerance denominator must be a positive whole count"
   | .integer (.negSucc _) => throw "tolerance denominator must be a positive whole count"
   | .integer (.ofNat 0) => throw "tolerance denominator must be a positive whole count"
 if !(@decide (0 < p) (Int.decLt 0 p)) then throw "positive take requires a smaller positive part"
 let separation := (q-p).toNat
 let (level,support) := reachingPair (separation*d)
 let gap ← generatorPairGap lower upper (.integer (.ofNat level))
 if h : 0 < d then
   let tolerance := LeptonIntervals.normalize 1 d h
   pure ⟨p,q,tolerance,level,support,gap,gap.blt tolerance,@decide (separation*d ≤ support) (Nat.decLe (separation*d) support)⟩
 else throw "tolerance denominator must be a positive whole count"

structure CarrierTranslation where
 generatedCoordinate : String
 largerSupportCorrespondsTo : String
 formalHoldingDirection : String

def selfSourcedColour : CarrierTranslation :=
 ⟨"retained-self-source-support-over-range", "greater-range-and-lower-transfer-scale",
 "increases-with-generated-support"⟩

def screenedElectromagnetic : CarrierTranslation :=
 ⟨"exposed-support-after-screening-removal", "closer-probe-and-higher-transfer-scale",
 "increases-with-generated-support"⟩

structure CarrierTranslationRecord where
 selfSourcedColour : CarrierTranslation
 screenedElectromagnetic : CarrierTranslation
 singleCommonFoldAxis : Bool
 universalImportedEnergySignRequired : Bool
 measurementSelectsOrientation : Bool

def carrierTranslationRecord : CarrierTranslationRecord :=
 ⟨selfSourcedColour,screenedElectromagnetic,true,false,false⟩

theorem carrierSpecificOrientation :
 carrierTranslationRecord.singleCommonFoldAxis = true ∧
 carrierTranslationRecord.universalImportedEnergySignRequired = false ∧
 carrierTranslationRecord.measurementSelectsOrientation = false := ⟨rfl,rfl,rfl⟩

theorem couplingExample : SectorInventory.pairFields (generatorIndexedCoupling (.integer 2) (.integer 3)) = .ok (5,6) := by
 unfold generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
 rw [PrimeSectorLadder.completeLadder]
 rfl

theorem shortfallExample : SectorInventory.pairFields (couplingShortfall (.integer 2) (.integer 3)) = .ok (1,6) := by
 unfold couplingShortfall generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
 rw [PrimeSectorLadder.completeLadder]
 rfl

theorem successorExample : SectorInventory.pairFields (couplingSuccessorTake (.integer 2) (.integer 3)) = .ok (1,15) := by
 unfold couplingSuccessorTake generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount
 rw [PrimeSectorLadder.completeLadder]
 rfl

theorem pairGapExample : SectorInventory.pairFields (generatorPairGap (.integer 2) (.integer 3) (.integer 3)) = .ok (1,42) := by
 unfold generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
 rw [PrimeSectorLadder.completeLadder]
 rfl


def sourceLevels : List Nat := [1,2,3,4,5,6]
def sourceToleranceDenominators : List Nat := [1,2,3,5,7,11]

def orderedSectorPairs : Except String (List (Nat × Nat)) := do
 let sectors ← PrimeSectorLadder.primeSectorLadder
 pure (sectors.flatMap fun lower => (sectors.filter (fun upper => decide (lower < upper))).map (fun upper => (lower,upper)))

structure FormalCertificate where
 sectors : List Nat
 levels : List Nat
 supports : List Nat
 commonScaleVectors : List (List (Nat × Rat))
 shortfallVectors : List (List Rat)
 successorTakeVectors : List (List Rat)
 pairGapVectors : List (List Rat)
 pairGapSuccessorTakes : List (List Rat)
 convergenceWitnesses : List ConvergenceWitness
 carrierTranslation : CarrierTranslationRecord

def formalCertificate : Except String FormalCertificate := do
 let sectors ← PrimeSectorLadder.primeSectorLadder
 let pairs ← orderedSectorPairs
 let supports ← sourceLevels.mapM (fun n => generatedScaleSupport (.integer (.ofNat n)))
 let vectors ← sourceLevels.mapM (fun n => commonScaleVector (.integer (.ofNat n)))
 let shortfalls ← sourceLevels.mapM (fun n => sectors.mapM (fun p => couplingShortfall (.integer (.ofNat p)) (.integer (.ofNat n))))
 let successors ← (sourceLevels.take 5).mapM (fun n => sectors.mapM (fun p => couplingSuccessorTake (.integer (.ofNat p)) (.integer (.ofNat n))))
 let gaps ← sourceLevels.mapM (fun n => pairs.mapM (fun (p,q) => generatorPairGap (.integer (.ofNat p)) (.integer (.ofNat q)) (.integer (.ofNat n))))
 let gapTakes ← (sourceLevels.take 5).mapM (fun n => pairs.mapM (fun (p,q) => pairGapSuccessorTake (.integer (.ofNat p)) (.integer (.ofNat q)) (.integer (.ofNat n))))
 let witnesses ← pairs.flatMapM (fun (p,q) => sourceToleranceDenominators.mapM (fun d => convergenceWitness (.integer (.ofNat p)) (.integer (.ofNat q)) (.integer (.ofNat d))))
 pure ⟨sectors,sourceLevels,supports,vectors,shortfalls,successors,gaps,gapTakes,witnesses,carrierTranslationRecord⟩

theorem everySourceOrderedPair : orderedSectorPairs = .ok [(2,3),(2,5),(2,7),(3,5),(3,7),(5,7)] := by
 unfold orderedSectorPairs
 rw [PrimeSectorLadder.completeLadder]
 rfl

def sourceConvergenceChecks : Except String (List Bool) := do
 let pairs ← orderedSectorPairs
 pairs.flatMapM fun (p,q) => sourceToleranceDenominators.mapM fun d => do
   let witness ← convergenceWitness (.integer (.ofNat p)) (.integer (.ofNat q)) (.integer (.ofNat d))
   pure (witness.gapBelowTolerance && witness.binarySupportReachesRequiredBound)

set_option maxRecDepth 10000 in
set_option maxHeartbeats 4000000 in
theorem allOriginalToleranceWitnesses : sourceConvergenceChecks = .ok (List.replicate 36 true) := by
 unfold sourceConvergenceChecks
 rw [everySourceOrderedPair]
 unfold convergenceWitness generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount
 rw [PrimeSectorLadder.completeLadder]
 rfl

end SFT.Physics.RunningConvergence
