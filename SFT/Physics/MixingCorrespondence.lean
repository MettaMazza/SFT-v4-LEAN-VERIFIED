import SFT.Physics.CKMFibres
namespace SFT.Physics.MixingCorrespondence
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

def channelBasis : Except String (List Rat) := do
 let colour ← FoldFirstReturn.generatorPeriod
 (List.range colour).mapM fun i => LeptonRatios.divide (wholeRatio (i+1)) (wholeRatio colour)
def leptonMassBasis : Except String (List Rat) := do
 let colour ← FoldFirstReturn.generatorPeriod
 let binary ← AlphaCovers.binaryCount
 (List.range colour).mapM fun i => LeptonRatios.divide (wholeRatio (binary*(i+1)-1)) (wholeRatio (binary*colour))
def alignmentMatrix (mass : List Rat) : Except String (List (List Rat)) := do
 let channels ← channelBasis
 pure (mass.map fun m => channels.map fun ch =>
  subtract (wholeRatio 1) (if m.blt ch then subtract ch m else subtract m ch))

/-- Source repeated-One subtraction on the exact common-denominator carrier. -/
def trimWithin (denominator : Nat) : Nat → Nat → Nat
 | 0,n => n
 | fuel+1,n => if denominator<n then trimWithin denominator fuel (n-denominator) else n
inductive TrimRun (denominator : Nat) : Nat → Nat → Prop where
 | stop (n : Nat) (closed : ¬denominator<n) : TrimRun denominator n n
 | next (n result : Nat) (above : denominator<n)
   (tail : TrimRun denominator (n-denominator) result) : TrimRun denominator n result

theorem trimCorrespondence (d : Nat) (positive : 0<d) (fuel n : Nat) (bound : n<fuel) :
 TrimRun d n (trimWithin d fuel n) := by
 induction fuel generalizing n with
 | zero => exact False.elim (Nat.not_lt_zero n bound)
 | succ fuel ih =>
   by_cases h : d<n
   · rw [trimWithin,if_pos h]
     apply TrimRun.next _ _ h
     exact ih (n-d) (Nat.lt_of_lt_of_le (Nat.sub_lt (Nat.lt_trans positive h) positive) (Nat.le_of_lt_succ bound))
   · rw [trimWithin,if_neg h]
     exact .stop n h

def triplingFold (value : Rat) : Except String Rat := do
 let colour ← FoldFirstReturn.generatorPeriod
 let tripled := multiply (wholeRatio colour) value
 match tripled.num with
 | .negSucc _ => pure tripled
 | .ofNat n => pure (normalize (.ofNat (trimWithin tripled.den (n+1) n)) tripled.den (Nat.pos_of_ne_zero tripled.den_nz))

structure Result where
 quarkLock : Rat
 leptonLock : Rat
 quarkMatrix : List (List Rat)
 leptonMatrix : List (List Rat)
 quarkClass : String
 leptonClass : String

def mixingCorrespondence : Except String Result := do
 let quark ← CKMFibres.ckmFibres
 let basis ← leptonMassBasis
 let lepton ← alignmentMatrix basis
 let waypoints ← basis.mapM triplingFold
 if waypoints.any (fun v => !(v == normalize 1 2 (by decide))) then
  throw "lepton mass fibre did not return to the half-One lock"
 pure ⟨normalize 2 3 (by decide),normalize 1 2 (by decide),quark.matrix,lepton,
  "generator-orbit-lock","self-antipodal-balance-lock"⟩

def originalLeptonBasis : List Rat := [normalize 1 6 (by decide),normalize 1 2 (by decide),normalize 5 6 (by decide)]
def originalLeptonMatrix : List (List Rat) :=
 [[normalize 5 6 (by decide),normalize 1 2 (by decide),normalize 1 6 (by decide)],
  [normalize 5 6 (by decide),normalize 5 6 (by decide),normalize 1 2 (by decide)],
  [normalize 1 2 (by decide),normalize 5 6 (by decide),normalize 5 6 (by decide)]]
def originalRecord : Result :=
 ⟨normalize 2 3 (by decide),normalize 1 2 (by decide),CKMFibres.originalRecord.matrix,originalLeptonMatrix,
  "generator-orbit-lock","self-antipodal-balance-lock"⟩
theorem completeLeptonBasis : leptonMassBasis = .ok originalLeptonBasis := rfl
theorem completeLeptonAlignment : alignmentMatrix originalLeptonBasis = .ok originalLeptonMatrix := rfl
theorem everyLeptonReturnsToLock : originalLeptonBasis.mapM triplingFold = .ok [normalize 1 2 (by decide),normalize 1 2 (by decide),normalize 1 2 (by decide)] := rfl
theorem completeSourceRecord : mixingCorrespondence = .ok originalRecord := rfl
theorem completeNineLeptonCells : originalLeptonMatrix.map List.length = [3,3,3] := rfl
end SFT.Physics.MixingCorrespondence
