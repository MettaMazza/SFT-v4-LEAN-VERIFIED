import SFT.Physics.VacuumDensity
namespace SFT.Physics.VacuumDensityWitnesses
open VacuumDensity
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def numeratorIs (r : Rat) (n : Nat) : Bool :=
 match r.num with | .ofNat k => k == n | .negSucc _ => false
def check0 : Bool := match leastBinaryCoverDepth (.integer 27) with | .error _ => false | .ok d => generationVolume == 27 && d == 5
def check1 : Bool := match localFloorCandidates with | .error _ => false | .ok cs => cs.length == 4 && (cs.filter FloorCandidate.survives).length == 1
def check2 : Bool := match boundaryRecordDepth,localVacuumAmplitudeFloor,localVacuumEnergyFloor with | .ok d,.ok a,.ok e => d == 10 && numeratorIs a 1 && a.den == 1024 && numeratorIs e 1 && e.den == 1048576 | .error _,_,_ => false | .ok _,.error _,_ => false | .ok _,.ok _,.error _ => false
def check3 : Bool := radiativeLedgersClose
def check4 : Bool := numeratorIs normalizedCosmologicalConstant 33 && normalizedCosmologicalConstant.den == 16
def check5 : Bool := match localVacuumEnergyFloor with | .error _ => false | .ok e => !(e == terminalVacuumShare)
def check6 : Bool := scaleCovariance
def witnesses : List Witness := [⟨"cover","Twenty-seven is first covered at binary depth five.",check0⟩,⟨"complete-floor-census","The two-by-two support/composition subgrammar has one complete energy survivor.",check1⟩,⟨"floor","Complete boundary amplitude depth ten self-composes to exact energy depth twenty.",check2⟩,⟨"radiative-ledger","Every generated finite complete mode ledger has total support/2 and mean half-One.",check3⟩,⟨"cosmic-magnitude","Three-space transport of the terminal vacuum share is exactly 33/16.",check4⟩,⟨"typed-separation","The local floor and global cosmic fraction remain distinct exact quantities.",check5⟩,⟨"scale-covariance","Common exact rescaling of held rate and speed leaves Lambda invariant.",check6⟩]
theorem check0Passed : check0 = true := rfl
theorem check1Passed : check1 = true := rfl
theorem check2Passed : check2 = true := rfl
theorem check3Passed : check3 = true := rfl
theorem check4Passed : check4 = true := rfl
theorem check5Passed : check5 = true := rfl
theorem check6Passed : check6 = true := rfl
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (check0 && check1 && check2 && check3 && check4 && check5 && check6 && true) = true
 rw [check0Passed,check1Passed,check2Passed,check3Passed,check4Passed,check5Passed,check6Passed]
 rfl
end SFT.Physics.VacuumDensityWitnesses
