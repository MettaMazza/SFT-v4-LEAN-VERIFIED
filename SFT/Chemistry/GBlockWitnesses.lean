import SFT.Chemistry.GBlockFirstOccupation
namespace SFT.Chemistry.GBlockWitnesses
open GBlockOperations SFT.Physics
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

theorem firstFiveWidths :
 [AtomicOrbitCapacity.orbitCapacity (.integer 1),AtomicOrbitCapacity.orbitCapacity (.integer 2),
 AtomicOrbitCapacity.orbitCapacity (.integer 3),AtomicOrbitCapacity.orbitCapacity (.integer 4),
 AtomicOrbitCapacity.orbitCapacity (.integer 5)] = [.ok 2,.ok 6,.ok 10,.ok 14,.ok 18] := rfl

theorem noblePrefix : nobleClosures (.integer 7) = .ok [2,10,18,36,54,86,118] := rfl

theorem firstEightS : firstOccupiedCoordinate (.integer 8) (.integer 1) = .ok 119 := rfl

theorem firstFiveG : firstOccupiedCoordinate (.integer 5) (.integer 5) = .ok 121 := rfl

theorem eightSFirst : subshellOccupation (.integer 119) (.integer 8) (.integer 1) = .ok [1] := rfl

theorem eightSFull : subshellOccupation (.integer 120) (.integer 8) (.integer 1) = .ok [2] := rfl

theorem fiveGFirst : subshellOccupation (.integer 121) (.integer 5) (.integer 5) = .ok [1] := rfl
end SFT.Chemistry.GBlockWitnesses
