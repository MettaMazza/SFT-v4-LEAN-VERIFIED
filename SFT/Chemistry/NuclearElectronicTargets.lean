import SFT.Chemistry.NuclearElectronicAnalysis
namespace SFT.Chemistry.NuclearElectronicTargets
open SFT.Host SFT.Host.Canonical
open JointCorrelationTargets (field text integer)
open NuclearElectronicSource (Identity Target Snapshot)
abbrev J := Value

def list : J → Except String (List J)
 | .array xs => .ok xs
 | .null | .text _ | .integer _ | .boolean _ | .object _ => .error "expected an array"
def strings (value : J) : Except String (List String) := list value >>= List.mapM text

def readIdentity (row : J) : Except String Identity := do
 return ⟨← field row "target_id" >>= text,← field row "snapshot_path" >>= text,
  ← field row "snapshot_hash" >>= text,← field row "state_row_ordinal" >>= integer,
  ← field row "nuclear_isotope_labels" >>= strings⟩

def readTarget (row : J) : Except String Target := do
 return ⟨← field row "target_id" >>= text,← field row "state_cells" >>= strings,
  ← field row "molecular_weight_inscription" >>= text,
  ← field row "nuclear_isotope_labels" >>= strings,row⟩

def readRow (row : J) : Except String NuclearElectronicAnalysis.Row := do
 return ⟨← field row "target_id" >>= text,← field row "species" >>= text,
  ← field row "state_cells" >>= strings,← field row "nuclear_isotope_labels" >>= strings,
  ← field row "molecular_weight_inscription" >>= text,row⟩

def identityPath : String := "experiments/external_sources/chemistry/nuclear_electronic_target_identities_v1.json"
def targetPath : String := "experiments/external_sources/chemistry/nuclear_electronic_withheld_targets_v1.json"
def identityHash : String := "sha256:316d3d94aa9a82a529c574e6029a9c05c5f3814683478bd184205e0b21806680"
def targetHash : String := "sha256:b8a3cb16b0fbdc53a01846492e71b38585d0a7c5336b755f3f9ea21ba48d7421"

def rows (actualIdentityHash actualTargetHash : String) (identities targets : J)
 (snapshots : List Snapshot) : Except String (List J) := do
 if !Text.equal actualIdentityHash identityHash then throw (Text.append "ELEC-012 registry changed: " identityPath)
 if !Text.equal actualTargetHash targetHash then throw (Text.append "ELEC-012 registry changed: " targetPath)
 let ids ← (← field identities "rows" >>= list).mapM readIdentity
 let ts ← (← field targets "rows" >>= list).mapM readTarget
 NuclearElectronicSource.rows ids ts snapshots
end SFT.Chemistry.NuclearElectronicTargets
