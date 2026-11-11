import SFT.Physics.AtomicBoundary
namespace SFT.Chemistry.PeriodicEndpoint
open SFT.Physics
-- gblock_predictions.py::ENDPOINT_SPEC binds the existing Physics derivation.
def endpoint := AtomicBoundary.atomicEndpoint

theorem exactEndpoint : endpoint = .ok 137 := AtomicBoundary.endpoint137

theorem admittedCoordinate : 137*3676744786≤503846395469 := AtomicBoundary.exactLower

theorem excludedSuccessor : 503846395469<138*3676744786 := AtomicBoundary.exactUpper

theorem everyLaterExcluded (k : Nat) (later : 137<k) :
 503846395469<k*3676744786 := AtomicBoundary.allLaterCoordinatesExcluded k later
end SFT.Chemistry.PeriodicEndpoint
