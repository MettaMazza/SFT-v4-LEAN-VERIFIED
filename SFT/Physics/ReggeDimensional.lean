import SFT.Physics.HadronReggeProofs
import SFT.Physics.TwoHandDirac
namespace SFT.Physics.ReggeDimensional
open HadronRegge LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def motionShare : Except String Rat := do
 let share := (← TwoHandDirac.twoHandDiracSquare).momentum
 if share != normalize 3 5 (by decide) then .error "admitted three-motion share changed" else .ok share
def tubeSuccessorShare : Except String Rat := do
 let hands ← AlphaCovers.binaryCount
 let share := multiply (wholeRatio hands) (← motionShare)
 if share != normalize 6 5 (by decide) then .error "paired tube successor did not close as six-fifths" else .ok share
def squaredResonanceCarrier (spinRank : CountArgument) : Except String Rat := do
 let rank ← positiveCount "spin rank must be a positive whole" spinRank
 let motion ← motionShare
 let successor ← tubeSuccessorShare
 .ok (add motion (multiply (wholeRatio (rank-1)) successor))
structure Certificate where
 motion : Rat
 tubeHands : Nat
 successor : Rat
 carriers : List Rat
 firstFive : List Rat
 allPositive : Bool
 constantSuccessor : Bool
 closedForm : Bool
def theoremCertificate (depth : CountArgument) : Except String Certificate := do
 let d ← positiveCount "certificate depth must be a positive whole above the One" depth
 if d<2 then .error "certificate depth must be a positive whole above the One" else do
 let ranks := (List.range d).map (fun i=>i+1)
 let carriers ← ranks.mapM (fun rank => squaredResonanceCarrier (.count (.integer (.ofNat rank))))
 .ok ⟨← motionShare,← AlphaCovers.binaryCount,← tubeSuccessorShare,carriers,carriers.take 5,
 carriers.all (fun x=>zero.blt x),
 (carriers.drop 1).zipWith (fun next current=>subtract next current == normalize 6 5 (by decide)) carriers |>.all id,
 (carriers.zipWith (fun value rank=> value == normalize (.ofNat (6*rank-3)) 5 (by decide)) ranks).all id⟩
theorem motionFromSource : motionShare = .ok (natRatio 3 5 (by decide)) := by
 unfold motionShare
 rw [TwoHandDirac.sourceAssembly]
 rfl
theorem successorFromSource : tubeSuccessorShare = .ok (natRatio 6 5 (by decide)) := by
 unfold tubeSuccessorShare
 rw [AlphaCovers.binaryCountTwo,motionFromSource]
 rfl
theorem everyPositiveConstruction (n : Nat) : squaredResonanceCarrier (.count (.integer (.ofNat (n+1)))) =
 .ok (add (natRatio 3 5 (by decide)) (multiply (wholeRatio n) (natRatio 6 5 (by decide)))) := by
 unfold squaredResonanceCarrier
 change (do let motion ← motionShare; let successor ← tubeSuccessorShare; pure (add motion (multiply (wholeRatio n) successor))) = _
 rw [motionFromSource,successorFromSource]
 rfl
theorem everyPositiveClosedForm (n : Nat) : squaredResonanceCarrier (.count (.integer (.ofNat (n+1)))) =
 .ok (natRatio (3+n*6) 5 (by decide)) := by
 rw [everyPositiveConstruction]
 apply congrArg Except.ok
 rw [←natRatioWhole n,multiplyNormalized]
 change add (natRatio 3 5 (by decide)) (natRatio (n*6) 5 (by decide)) = _
 rw [addNormalized]

theorem sourceClosedForm (n : Nat) : squaredResonanceCarrier (.count (.integer (.ofNat (n+1)))) =
 .ok (natRatio (6*(n+1)-3) 5 (by decide)) := by
 rw [everyPositiveClosedForm]
 have numerator : 6*(n+1)-3=3+n*6 := by
  rw [Nat.mul_add,Nat.mul_one,Nat.mul_comm 6 n]
  change n*6+(3+3)-3=3+n*6
  rw [←Nat.add_assoc,Nat.add_comm (n*6+3) 3,RunningConvergence.addSubtractLeft,Nat.add_comm]
 rw [numerator]

theorem everyPositiveSuccessor (n : Nat) : squaredResonanceCarrier (.count (.integer (.ofNat (n+2)))) =
 .ok (add (natRatio (3+n*6) 5 (by decide)) (natRatio 6 5 (by decide))) := by
 rw [everyPositiveClosedForm (n+1),addNormalized,Nat.succ_mul,Nat.add_assoc]

theorem everyCarrierPositive (n : Nat) :
 ((squaredResonanceCarrier (.count (.integer (.ofNat (n+1))))).toOption.map (fun q=>zero.blt q)) = some true := by
 rw [everyPositiveClosedForm]
 change some (zero.blt (natRatio (3+n*6) 5 (by decide))) = some true
 rw [positiveNormalized (3+n*6) 5 (Nat.lt_of_lt_of_le (by decide : 0<3) (Nat.le_add_right _ _)) (by decide)]

#print axioms sourceClosedForm
#print axioms everyPositiveSuccessor
#print axioms everyCarrierPositive
theorem originalCertificate : (theoremCertificate (.count (.integer 64))).toOption.map (fun c =>
 (c.firstFive,[c.allPositive,c.constantSuccessor,c.closedForm])) =
 some ([normalize 3 5 (by decide),normalize 9 5 (by decide),normalize 3 1 (by decide),normalize 21 5 (by decide),normalize 27 5 (by decide)],[true,true,true]) := rfl
#print axioms motionFromSource
#print axioms successorFromSource
#print axioms everyPositiveConstruction
#print axioms everyPositiveClosedForm
#print axioms originalCertificate
end SFT.Physics.ReggeDimensional
