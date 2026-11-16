import SFT.Physics.CollectiveRadiation
namespace SFT.Physics.CollectiveRadiationCertificate
open CollectiveRadiation LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 occupationCount : Nat
 energyExact : Bool
 uvClosed : Bool
 scaleCovariant : Bool
 fourthPower : Bool
 acoustic : Bool
 laser : Bool
 plasma : Bool
 alfven : Bool

def certificate : Except String Certificate := do
 let costs := [1,2,3,5,8].map (fun n => GeneratorOperations.CountInput.integer (.ofNat n))
 let total := GeneratorOperations.CountInput.integer (.ofNat 7)
 let words ← finiteBosonOccupations costs total
 let uv ← ultravioletClosed costs total
 let scales ← [1,2,3,4,5,6].mapM (fun n => occupationScaleCovariant costs total (.integer (.ofNat n)))
 let double ← radiationPowerRatio (wholeRatio 2)
 let tripleHalf ← radiationPowerRatio (natRatio 3 2 (by decide))
 let modes ← acousticLadder (natRatio 1 6 (by decide)) (.integer (.ofNat 4))
 let laser ← laserLedger (.integer (.ofNat 3)) (.integer (.ofNat 2)) (natRatio 4 3 (by decide)) (natRatio 5 4 (by decide)) (.integer (.ofNat 7))
 let plasma ← plasmaSquaredCarriers (wholeRatio 3) (wholeRatio 2) (wholeRatio 5) (wholeRatio 7) (wholeRatio 11)
 let alfven ← alfvenSquaredCarrier (wholeRatio 3) (wholeRatio 5) (wholeRatio 7)
 pure ⟨words.length, words.all (fun w => wordEnergy [1,2,3,5,8] w == 7),uv,scales.all id,
  VelocityComposition.ratEqual double (wholeRatio 16) && VelocityComposition.ratEqual tripleHalf (natRatio 81 16 (by decide)),
  modes == [natRatio 1 6 (by decide),natRatio 1 3 (by decide),natRatio 1 2 (by decide),natRatio 2 3 (by decide)],
  laser.populationInverted && laser.aboveThreshold && VelocityComposition.ratEqual laser.linewidthTimeProduct (wholeRatio 1),
  VelocityComposition.ratEqual plasma.frequencySquared (natRatio 12 35 (by decide)) && VelocityComposition.ratEqual plasma.debyeLengthSquared (natRatio 77 12 (by decide)),
  VelocityComposition.ratEqual alfven (natRatio 9 35 (by decide))⟩

theorem originalCount : certificate.toOption.map Certificate.occupationCount = some 10 := by decide +kernel
theorem originalFlags : certificate.toOption.map (fun c => c.energyExact && c.uvClosed && c.scaleCovariant && c.fourthPower && c.acoustic && c.laser && c.plasma && c.alfven) = some true := by decide +kernel
end SFT.Physics.CollectiveRadiationCertificate
