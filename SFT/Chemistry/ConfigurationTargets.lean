import SFT.Chemistry.ConfigurationObservation
namespace SFT.Chemistry.ConfigurationTargets
open SFT.Host SFT.Host.Canonical ConfigurationObservation
open JointCorrelationTargets (field text)
def sourceId := "NIST-CCCBDB-SRD101-ETHANOL-EXPERIMENTAL-ROTATIONAL-BARRIER"
def authorities : List (String × String) := [("experiments/external_sources/chemistry/configuration_order_target_identities_v1.json","sha256:3f2e325508d2d014ebcc4dd63fa7124b23b279093bef9ef11aaa88bf06b17ea0"),("experiments/external_sources/chemistry/configuration_order_withheld_targets_v1.json","sha256:4f9360594f4f5c002da9ecd02693c86a26d278cc4edf93705f77461eb06f4a67"),("experiments/external_sources/chemistry/snapshots/configuration-order-v1/nist-cccbdb-ethanol-experimental-rotational-barrier.html","sha256:afd9991078eac697439f353271666c9020d40f906bff78838c6cbe3696b14209")]
def rows (actualHashes : List (String × String)) (document : Value)
 (events : List ElectronSpinHtml.Event) : Except String (List Value) := do
 let _ ← authorities.mapM fun (path,expected) => do
  match actualHashes.find? (fun p => Text.equal p.1 path) with
  | none => throw (Text.append "ELEC-011 source changed: " path)
  | some (_,actual) => if !Text.equal actual expected then throw (Text.append "ELEC-011 source changed: " path)
 let registered ← match ← field document "rows" with
  | .array xs => pure xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => throw "rows are not a list"
 reconstruct events registered
end SFT.Chemistry.ConfigurationTargets
