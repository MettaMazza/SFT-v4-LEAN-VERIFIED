import SFT.Physics.LeptonComparison
import SFT.Physics.QuarkComparisonMeasurement
import SFT.Physics.NeutrinoComparisonMeasurement
import SFT.Physics.TerminalCKMMeasurement
import SFT.Physics.PostNewtonianRecords
namespace SFT.Physics.ParticleModeObservationExternal
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def matterPath := "experiments/external_sources/physics/snapshots/matter-flavour-source-record.json"
def terminalPath := "experiments/external_sources/physics/snapshots/matter-flavour-terminal-source-record.json"
def leptonPath := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def hasPrefix (value start : String) : Bool := Text.isPrefix start.toUTF8.data.toList value.toUTF8.data.toList
def recompute (files : List (String × ByteArray)) (matter terminal : Value) : Except String Bool := do
 let leptonBytes ← PostNewtonianRecords.fileBytes files leptonPath
 let rows := LeptonSource.lines (Text.decode leptonBytes.size leptonBytes.data.toList)
 let lepton ← LeptonComparison.comparisonRowsWithin rows 27 15
 let leptonPassed ← match lepton with
  | some result => .ok result.allRowsPassed
  | none => .error "registered lepton source computation did not terminate within its proved original bound"
 let matterBytes ← PostNewtonianRecords.fileBytes files matterPath
 let terminalBytes ← PostNewtonianRecords.fileBytes files terminalPath
 let quark ← QuarkComparisonMeasurement.quarkClassification matterBytes files matter
 let ckm ← TerminalCKMMeasurement.classification terminalBytes files terminal
 let neutrino ← NeutrinoComparisonMeasurement.neutrinoClassification matterBytes files matter
 .ok (leptonPassed && hasPrefix quark "dressed-sd-and-bs-inside" && hasPrefix ckm "terminal-CKM-s12-s23-s13-and-J-all-overlap" && hasPrefix neutrino "positive-normal-neutrino-mass-structure")
#print axioms recompute
end SFT.Physics.ParticleModeObservationExternal
