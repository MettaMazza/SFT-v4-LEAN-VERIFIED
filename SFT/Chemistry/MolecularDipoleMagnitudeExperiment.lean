import SFT.Chemistry.MolecularDipoleMagnitudeEvidence
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.MolecularDipoleMagnitudeExperiment
open SFT.Host SFT.Host.Canonical MolecularDipoleMagnitude
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
def claimId : String := "SFT-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005"
def experimentId : String := "SFT-EXP-CHEM-MOLECULAR-DIPOLE-MAGNITUDE-005"
def frozenRelation : String := "A molecular dipole is the retained orientation of a complete molecular charge-distinction carrier. Its molecular symmetry closes forbidden components to structural EmptyOne and retains every allowed component as an exact positive magnitude on a held axis. The orientation-free squared magnitude is exactly the Junction of those component squares. The relation seals before all nine NIST values open; the H2/D2 absence rows, water-isotopologue component organization and reported total magnitudes then test the same law without a signed proof scalar or an irrational square root."
def falsification : String := "The claim fails if either registered homonuclear total is not source absence; if H2O or D2O does not retain exactly one reported component, HDO does not retain exactly two, or any post-seal exact outward component-square Junction fails to overlap its separately reported squared-total interval; if any row, identity, state, geometry, symmetry, axis, method, condition or uncertainty is erased; if a value is readable before sealing; or if a signed, irrational, fitted or continuum rule is introduced."
def identityPath : String := "experiments/external_sources/chemistry/molecular_dipole_target_identities_v1.json"
def identityHash : String := "sha256:fbeffee44a4f3231814728c4b2046811a9c90160f889077c1190ea9e0a31f023"
def targetPath : String := "experiments/external_sources/chemistry/molecular_dipole_withheld_targets_v1.json"
def targetHash : String := "sha256:c3de218ecc55ed614835ebed25ece8ea3e2d9c2155e12c03c5e91889b6c17e73"
def targetIds : List String := ["NIST-CCCBDB-H2-TOTAL","NIST-CCCBDB-D2-TOTAL","NIST-1973-H2O-B-COMPONENT","NIST-1973-H2O-TOTAL","NIST-1973-D2O-B-COMPONENT","NIST-1973-D2O-TOTAL","NIST-1973-HDO-A-COMPONENT","NIST-1973-HDO-B-COMPONENT","NIST-1973-HDO-TOTAL"]
def labels (carrier : Carrier) : List (String × String) :=
 [("molecular-species",carrier.species.label),("molecular-state",carrier.state.label),
 ("molecular-geometry",carrier.geometry.label),("charge-distinction-carrier",carrier.charge.label),
 ("molecular-symmetry",carrier.symmetry.label),("dipole-component-support",(structuralMagnitudeClass carrier).label),
 ("dipole-magnitude-definition",carrier.definition.label),("measurement-custody","all-nine-values-open-after-relation-seal")]
def carrierInstructions (carrier : Carrier) : List Value := Id.run do
 let key := Text.lowerAscii carrier.species.label
 let destination := fun n => Text.intercalate "" [key,"-label-",toString (n+1)]
 let indexed := (labels carrier).zipIdx
 let labelRows := indexed.map fun ((family,label),n) => instruction "label" (destination n) [family,label]
 let (axisRows,axisRegisters) := if carrier.axes.isEmpty then
  ([instruction "empty_one" (Text.append key "-axes-empty") ["structural-empty-One"]],[Text.append key "-axes-empty"])
 else
  let axes := carrier.axes.zipIdx
  let register := fun n => Text.intercalate "" [key,"-axis-",toString (n+1)]
  (axes.map (fun (axis,n) => instruction "label" (register n) [axis.family,axis.label]),axes.map (fun (_,n) => register n))
 let registers := ("premise" :: indexed.map (fun (_,n) => destination n)) ++ axisRegisters
 return labelRows ++ axisRows ++ [instruction "word" (Text.append key "-relation") registers]
def predictionProgramDocument : Except String Value := do
 let carriers ← registeredCarrierVector
 let rows := carriers.flatMap carrierInstructions
 let arguments := carriers.flatMap fun carrier =>
  let key := Text.lowerAscii carrier.species.label
  [Text.append key "-label-1",Text.append key "-relation"]
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-relation-prediction")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ rows ++
 [instruction "table" "molecular-dipole-vector" arguments,instruction "emit" "" ["molecular-dipole-vector"]]))])
def experimentRegistrationRecord : Except String Value := do
 let document ← predictionProgramDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_measurement_registry",.array [.text targetPath,.text targetHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_measured_values_absent_from_law_and_prediction",.boolean true),("all_nine_rows_required",.boolean true),
 ("falsification_condition",.text falsification)])
theorem completePredictionConstructed : predictionProgramDocument.isOk = true := rfl
theorem completeRegistrationConstructed : experimentRegistrationRecord.isOk = true := rfl

def expectedLabel : String := "exact-symmetry-component-and-squared-magnitude-relation-across-nine-NIST-rows"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("answer-only-dipole-scalar",false),("complete-named-molecular-charge-carrier",true)]),("symmetry",[("component-list-selected-after-values",false),("symmetry-forced-component-support",true)]),("orientation",[("signed-direction-as-proof-number",false),("held-orientation-positive-components",true)]),("composition",[("continuum-vector-premise",false),("finite-distinct-axis-Junction",true)]),("magnitude",[("irrational-square-root-or-fitted-norm",false),("exact-squared-magnitude-relation",true)]),("prediction",[("dipole-value-readable-before-seal",false),("value-free-symmetry-and-relation-seal",true)]),("record",[("favorable-species-or-component-subset",false),("complete-five-species-nine-row-vector",true)]),("extension",[("species-coefficient-charge-fit-or-correction",false),("one-structural-law-no-extra-rule",true)])]
def snapshotHashes : List String := ["sha256:6320aca1d0c0e4fd12509dedaa985d2252813011e69d090a127b49f12414b49d","sha256:6320aca1d0c0e4fd12509dedaa985d2252813011e69d090a127b49f12414b49d","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84","sha256:e3df9979865e12887c564327a3029f11c03caeb8cf6d9c90b499972a954ebb84"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if MolecularDipoleMagnitudeEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 if !([MolecularDipoleMagnitude.symmetryWitness,MolecularDipoleMagnitude.absenceWitness,MolecularDipoleMagnitude.oneAxisWitness,MolecularDipoleMagnitude.junctionWitness,MolecularDipoleMagnitude.duplicateWitness].all id) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.MolecularDipoleMagnitudeExperiment
