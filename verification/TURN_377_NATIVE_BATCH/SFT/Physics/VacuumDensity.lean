import SFT.Physics.VacuumSpectrum
import SFT.Physics.AlphaRatio
import SFT.Physics.LeptonRatios
namespace SFT.Physics.VacuumDensity
open LeptonIntervals GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

def binary : Nat := 2
def generator : Nat := 3
def spaceRank : Nat := 3
def terminalVacuumShare : Rat := normalize 11 16 (by decide)
def generationVolume : Nat := generator^spaceRank

def leastBinaryCoverDepth : CountInput → Except String Nat
 | .boolean _ => .error "cover size must be a positive whole"
 | .integer (.negSucc _) => .error "cover size must be a positive whole"
 | .integer (.ofNat 0) => .error "cover size must be a positive whole"
 | .integer (.ofNat (n+1)) => AlphaCovers.minimalBinaryCover (.integer (.ofNat (n+1)))

def boundaryRecordDepth : Except String Nat := do
 let depth ← leastBinaryCoverDepth (.integer (.ofNat generationVolume))
 .ok (binary*depth)

def localVacuumAmplitudeFloor : Except String Rat := do
 let depth ← boundaryRecordDepth
 .ok (normalize 1 (binary^depth) (Nat.pow_pos (by decide)))
def localVacuumEnergyFloor : Except String Rat := do
 let amplitude ← localVacuumAmplitudeFloor
 .ok (multiply amplitude amplitude)
def ratPair (x : Rat) := (x.num,x.den)

theorem volumeTwentySeven : generationVolume = 27 := rfl
theorem leastCoverFive : leastBinaryCoverDepth (.integer 27) = .ok 5 := rfl
theorem noEarlierCover : ∀ k, 0 < k → k < 5 → 2^k < 27 := AlphaBlocks.downMinimal.2
theorem completeBoundaryTen : boundaryRecordDepth = .ok 10 := rfl
theorem amplitudeFloorExact : localVacuumAmplitudeFloor.map ratPair = .ok (1,1024) := rfl
theorem energyFloorExact : localVacuumEnergyFloor.map ratPair = .ok (1,1048576) := rfl

structure Ledger where
 depth : Nat
 support : Nat
 modes : List Rat
 total : Rat
 mean : Rat
 closed : Bool

def finiteZeroPointLedger : CountInput → Except String Ledger
 | .boolean _ => .error "radiative depth must be a positive generated count"
 | .integer (.negSucc _) => .error "radiative depth must be a positive generated count"
 | .integer (.ofNat 0) => .error "radiative depth must be a positive generated count"
 | .integer (.ofNat (k+1)) => do
  let depth := k+1
  let support := binary^depth
  let denominator := binary^(depth+1)
  let modes := (List.range support).map fun i =>
   normalize (.ofNat (binary*(i+1)-1)) denominator (Nat.pow_pos (by decide))
  let total := modes.foldl add zero
  let mean ← LeptonRatios.divide total (normalize (.ofNat support) 1 (by decide))
  let closed := total == normalize (.ofNat support) binary (by decide) && mean == half
  .ok ⟨depth,support,modes,total,mean,closed⟩

-- Host numerator accumulation for the complete positive mode support.
def oddNumeratorSum : Nat → Nat
 | 0 => 0
 | n+1 => oddNumeratorSum n + (2*n+1)
theorem completeOddSum (n : Nat) : oddNumeratorSum n = n*n := by
 induction n with
 | zero => rfl
 | succ n ih =>
  change oddNumeratorSum n+(2*n+1) = (n+1)*(n+1)
  have expand : (n+1)*n = n*n+n := by
   rw [Nat.mul_comm (n+1) n,Nat.mul_add,Nat.mul_one]
  rw [ih,Nat.mul_add,expand,Nat.mul_one]
  rw [Nat.two_mul]
  exact (congrArg (fun t => n*n+t) (Nat.add_assoc n n 1)).trans
    (Nat.add_assoc (n*n) n (n+1)).symm

structure FloorCandidate where
 candidateId : String
 amplitudeDepth : Nat
 observableDepth : Nat
 survives : Bool

def localFloorCandidates : Except String (List FloorCandidate) := do
 let cover ← leastBinaryCoverDepth (.integer (.ofNat generationVolume))
 .ok ([false,true].flatMap fun complete => [false,true].map fun energy =>
  let amplitude := cover*(if complete then binary else 1)
  ⟨SFT.Host.Text.append (if complete then "complete-boundary" else "one-label")
    (SFT.Host.Text.append "__" (if energy then "energy-self-composition" else "amplitude-only")),
   amplitude,amplitude*(if energy then binary else 1),complete && energy⟩)

def normalizedCosmologicalConstant : Rat :=
 multiply (normalize (.ofNat spaceRank) 1 (by decide)) terminalVacuumShare

def scaleTransport (rate speed : Rat) : Except String Rat :=
 if !zero.blt rate || !zero.blt speed then .error "scale references must be exact positive carriers"
 else LeptonRatios.divide (multiply (multiply normalizedCosmologicalConstant rate) rate) (multiply speed speed)

theorem normalizedConstantExact : ratPair normalizedCosmologicalConstant = (33,16) := rfl
theorem completeLocalCandidateDepths : localFloorCandidates.map
 (fun cs => cs.map (fun c => (c.amplitudeDepth,c.observableDepth,c.survives))) =
 .ok [(5,5,false),(5,10,false),(10,10,false),(10,20,true)] := rfl
def radiativeLedgersClose : Bool := ([1,2,3,4,5,6,7,8] : List Nat).all fun k =>
 match finiteZeroPointLedger (.integer (.ofNat k)) with
 | .error _ => false
 | .ok ledger => ledger.closed

def sourceRates : List Rat := [normalize 1 3 (by decide),normalize 2 3 (by decide),normalize 1 1 (by decide)]
def sourceSpeeds : List Rat := [normalize 1 2 (by decide),normalize 3 4 (by decide),normalize 1 1 (by decide)]
def sourceScales : List Rat := [normalize 1 4 (by decide),normalize 2 1 (by decide),normalize 3 1 (by decide)]
def scaleCovariance : Bool := sourceRates.all fun rate => sourceSpeeds.all fun speed => sourceScales.all fun scale =>
 match scaleTransport (multiply rate scale) (multiply speed scale), scaleTransport rate speed with
 | .ok shifted,.ok original => shifted == original
 | .error _,.ok _ => false
 | .ok _,.error _ => false
 | .error _,.error _ => false

theorem originalRadiativeLedgersClose : radiativeLedgersClose = true := rfl
theorem originalScaleCovariance : scaleCovariance = true := rfl
end SFT.Physics.VacuumDensity
