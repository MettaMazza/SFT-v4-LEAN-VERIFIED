import SFT.Physics.GrandLockObservationExtract0
import SFT.Physics.GrandLockObservationExtract1
import SFT.Physics.GrandLockObservationExtract2
import SFT.Physics.GrandLockObservationExtract3
import SFT.Physics.GrandLockObservationExtract4
import SFT.Physics.GrandLockObservationExtract5
import SFT.Physics.GrandLockObservationExtract6
import SFT.Physics.GrandLockObservationExtract7
import SFT.Physics.GrandLockObservationExtract8
import SFT.Physics.GrandLockObservationExtract9
import SFT.Physics.GrandLockObservationExtract10
import SFT.Physics.GrandLockObservationExtract11
import SFT.Physics.GrandLockObservationExtract12
import SFT.Physics.GrandLockObservationExtract13
import SFT.Physics.GrandLockObservationExtract14
import SFT.Physics.GrandLockObservationExtract15
import SFT.Physics.GrandLockObservationExtract16
import SFT.Physics.GrandLockObservationExtract17
namespace SFT.Physics.GrandLockObservationAnalysisProofs
open SFT.Host.Canonical SFT.Physics SFT.Physics.GrandLockObservationAnalysis SFT.Physics.GrandLockDependency RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
theorem originalExtraction : recordCertificate originalTarget = .ok (certificateFields original_ids original_legacy original_adverse original_physics original_sources original_hashes original_measurements original_legacyRows original_empiricalCount original_sourceCount original_boundary original_requiredTrue original_formalReceipt) := by
 unfold recordCertificate
 have h0 := field_rows
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h0
 rewrite [h0]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h1 := parse_ids
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h1
 rewrite [h1]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h2 := field_legacy
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h2
 rewrite [h2]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h3 := parse_legacy
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h3
 rewrite [h3]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h4 := field_adverse
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h4
 rewrite [h4]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h5 := parse_adverse
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h5
 rewrite [h5]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h6 := field_physics
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h6
 rewrite [h6]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h7 := parse_physics
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h7
 rewrite [h7]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h8 := field_sources
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h8
 rewrite [h8]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h9 := parse_sources
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h9
 rewrite [h9]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array]
 have h10 := field_boundary
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h10
 rewrite [h10]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h11 := parse_hashes
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h11
 rewrite [h11]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h12 := parse_measurements
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h12
 rewrite [h12]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h13 := parse_legacyRows
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h13
 rewrite [h13]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h14 := field_empiricalCount
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h14
 rewrite [h14]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h15 := field_sourceCount
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h15
 rewrite [h15]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h16 := field_formal
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h16
 rewrite [h16]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 have h17 := parse_formal
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array] at h17
 rewrite [h17]
 try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure, array, original_boundary]
 rfl
#print axioms originalExtraction
end SFT.Physics.GrandLockObservationAnalysisProofs
