import SFT.Chemistry.MolecularIonizationEvidence
import SFT.Chemistry.MolecularBondAngleSource
import SFT.Chemistry.BondDissociationEnergyExperiment
namespace SFT.Chemistry.MolecularIonizationExperiment
open SFT.Host SFT.Host.Canonical SFT.Physics
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
abbrev instruction := BondDissociationEnergyExperiment.instruction
abbrev field := MolecularBondAngleSource.field
abbrev get := MolecularBondAngleSource.get
abbrev text := MolecularBondAngleSource.text
abbrev sameValue := MolecularBondAngleSource.sameValue
abbrev bytesMatch := MolecularBondAngleSource.bytesMatch
def claimId : String := "SFT-CHEM-MOLECULAR-IONIZATION-ENERGY-007"
def experimentId : String := "SFT-EXP-CHEM-MOLECULAR-IONIZATION-ENERGY-007"
def frozenRelation : String := "complete-neutral-to-ionic-carrier__held-removal-and-positive-terminal-separation__ordered-positive-final-from-initial-Take__least-adiabatic-and-held-geometry-vertical-paths__vertical-not-below-adiabatic__value-free-carrier-and-operation-seal__complete-nine-diatomic-NIST-vector__one-ionization-law-no-extra-rule"
def falsification : String := "The claim fails if a registered separated ion-plus-electron state does not lie at an exact positive Take from its retained neutral state; if a held-geometry vertical terminal lies below the least complete-support adiabatic terminal; if any of the nine post-seal NIST records is absent, duplicated, displaced, non-positive or detached from its initial and resulting states, method, condition, units and uncertainty class; if a target value is readable before sealing; or if a signed, continuum, imported, fitted or species-specific correction rule is introduced."
def identityPath : String := "experiments/external_sources/chemistry/molecular_ionization_target_identities_v1.json"
def identityHash : String := "sha256:c14f627c7e247f01fc02243fce3d9cf6e06be5df92f1edf855787c0703f79c9c"
def targetPath : String := "experiments/external_sources/chemistry/molecular_ionization_withheld_targets_v1.json"
def targetHash : String := "sha256:f2e1f1fbfda163d5e13e5256ab74d2d519adcfc2ee04b21e4bf5b8906ca198f8"
def guidePath : String := "experiments/external_sources/chemistry/snapshots/prop-007-molecular-ionization-v1/nist-webbook-gas-phase-ion-thermochemistry.html"
def guideHash : String := "sha256:3037004952cc27531f9ff87ed9f403e7dc2fd3c7293881a3ab3b7bfb9a5523d6"
def primaryPath : String := "experiments/external_sources/chemistry/snapshots/prop-007-molecular-ionization-v1/molecular-ionization-primary-records-v1.json"
def primaryHash : String := "sha256:060293fa3a611e46a26fc0ac004a9933542c6b61ecc48c3a9e84bd320b755212"
def targetIds : List String := ["NIST-CCCBDB-PROP-007-D2-ADIABATIC-IE","NIST-CCCBDB-PROP-007-HD-ADIABATIC-IE","NIST-CCCBDB-PROP-007-H2-ADIABATIC-IE","NIST-CCCBDB-PROP-007-N2-ADIABATIC-IE","NIST-CCCBDB-PROP-007-CO-ADIABATIC-IE","NIST-CCCBDB-PROP-007-NO-ADIABATIC-IE","NIST-CCCBDB-PROP-007-O2-ADIABATIC-IE","NIST-CCCBDB-PROP-007-HF-ADIABATIC-IE","NIST-CCCBDB-PROP-007-F2-ADIABATIC-IE"]
def identities (bytes : ByteArray) (document : Value) : Except String (List Value) := do
 if !bytesMatch bytes identityHash then throw "PROP-007 identity registry changed"
 let rows ← RunningConvergenceMeasurement.array (get document "rows")
 if !sameValue (get document "schema") (.text "sft-v3-molecular-ionization-identities/1") ||
    !sameValue (get document "all_ionization_values_absent") (.boolean true) ||
    !sameValue (get document "complete_row_count") (.integer 9) || rows.length != 9 ||
    !(rows.all fun row => sameValue (get row "target_value_absent") (.boolean true)) then
  throw "PROP-007 value-free identity boundary changed"
 pure rows
def identityFields : List (String × String) :=
 [("formula","molecular-formula"),("name","molecular-name"),("casno","source-species-identity"),
 ("initial_molecular_state","initial-molecular-state"),("initial_conformation","initial-molecular-conformation"),
 ("resulting_ionic_state","resulting-ionic-state"),("removed_carrier","removed-carrier"),
 ("ionization_path","ionization-path"),("method","measurement-method"),("condition","measurement-condition"),
 ("units","measurement-unit"),("uncertainty_kind","uncertainty-class")]
def rowInstructions (row : Value) (ordinal : Nat) : Except String (List Value × List String) := do
 let rowPrefix := Text.append "ionization-row-" (toString ordinal)
 let target ← field row "target_id" >>= text
 let labeled ← identityFields.zipIdx.mapM fun ((key,family),index) => do
  let value ← field row key >>= text
  let destination := Text.intercalate "" [rowPrefix,"-identity-",toString (index+1)]
  pure (instruction "label" destination [family,value],destination)
 let laws := [("held-removal-orientation","neutral-carrier-to-separated-ion-and-electron"),
 ("ionization-law","ordered-positive-terminal-from-initial-Take"),
 ("adiabatic-law","least-complete-generated-terminal-Take"),
 ("vertical-law","held-geometry-terminal-not-below-adiabatic")]
 let lawRows := laws.zipIdx.map fun ((family,label),index) =>
  let destination := Text.intercalate "" [rowPrefix,"-law-",toString (13+index)]
  (instruction "label" destination [family,label],destination)
 let registers := ["premise"] ++ labeled.map Prod.snd ++ lawRows.map Prod.snd
 pure ([instruction "label" (Text.append rowPrefix "-target") ["target-id",target]] ++ labeled.map Prod.fst ++
  lawRows.map Prod.fst ++ [instruction "word" (Text.append rowPrefix "-word") registers],
  [Text.append rowPrefix "-target",Text.append rowPrefix "-word"])
def predictionProgramDocument (identityBytes : ByteArray) (document : Value) : Except String Value := do
 let rows ← identities identityBytes document
 let parts ← rows.zipIdx.mapM fun (row,index) => rowInstructions row (index+1)
 pure (.object [("schema",.text "sft-v3-fold-program/1"),
 ("program_id",.text (Text.append experimentId "-value-free-complete-vector")),
 ("instructions",.array ([instruction "input" "premise" ["registered-premise"]] ++ parts.flatMap Prod.fst ++
 [instruction "table" "molecular-ionization-vector" (parts.flatMap Prod.snd),instruction "emit" "" ["molecular-ionization-vector"]]))])
def experimentRegistrationRecord (identityBytes : ByteArray) (identitiesDocument : Value) : Except String Value := do
 let document ← predictionProgramDocument identityBytes identitiesDocument
 pure (.object [("experiment_id",.text experimentId),("claim_id",.text claimId),
 ("provenance",.text "observational_derivation"),("frozen_relation",.text frozenRelation),
 ("identity_registry",.array [.text identityPath,.text identityHash]),
 ("withheld_measurement_registry",.array [.text targetPath,.text targetHash]),
 ("definition_source",.array [.text guidePath,.text guideHash]),
 ("normalized_primary_records",.array [.text primaryPath,.text primaryHash]),
 ("prediction_program",document),("target_ids",.array (targetIds.map Value.text)),
 ("all_nine_energy_values_absent_from_prediction",.boolean true),("falsification_condition",.text falsification)])
def expectedLabel : String := "exact-positive-terminal-from-initial-ionization-Take-with-complete-state-custody"
def dimensions : List (String × List (String × Bool)) := [("carrier",[("ionization-answer-with-erased-states",false),("complete-neutral-to-ionic-carrier",true)]),("transformation",[("signed-electron-subtraction",false),("held-removal-and-positive-terminal-separation",true)]),("magnitude",[("imported-orbital-energy-equality",false),("ordered-positive-final-from-initial-Take",true)]),("path",[("adiabatic-vertical-state-conflation",false),("least-adiabatic-and-held-geometry-vertical-paths",true)]),("order",[("unconstrained-vertical-reordering",false),("vertical-not-below-adiabatic",true)]),("prediction",[("ionization-value-readable-before-seal",false),("value-free-carrier-and-operation-seal",true)]),("record",[("selected-isotopologue-or-favorable-row",false),("complete-nine-diatomic-NIST-vector",true)]),("extension",[("species-fit-or-residual-correction",false),("one-ionization-law-no-extra-rule",true)])]
def snapshotHashes : List String := ["sha256:6e158490ac330904aaa885f12b87ee08618e61e434e77905b4293d8838b26c83","sha256:3845b8695e8c8c3dd5b2da3c25c67da12c09ef95bbbcd2b31a9df96a2e0c7273","sha256:21b6af5838ec15146e039bbafa8533fd85706373ea92392fc3f987e3e473175d","sha256:b2437001b4ba18daeb60074f657a41a8d8f23bfa111706f1193e6cf219e268f7","sha256:61a1d4bcc49e4d4b6b55c3b1be38a6334aa301142ebb3fbb256ccf251ecf144c","sha256:22aed522f6bff84e8988b92c28c74540c043bbd45b59697712c6846d179b530d","sha256:9c321d34da2f21cc44cdf2be1563cd7ca8088e6e2d85fff86b584f25d4c68a46","sha256:d16286bce0a122dc8ff940d84f18fb94df524f1b3d88388f53e145fe6460bece","sha256:fb201300ab3940108d52dbf5005cba059747a889c5c5a5b3a3f0e987db164e7b"]
def distinct (xs : List String) : Bool := (xs.foldl (fun acc x => if acc.any (Text.equal x) then acc else x::acc) []).length == xs.length
def validateSpec : Except String Unit := do
 if !(Text.chars "SFT-CHEM-").isPrefixOf (Text.chars claimId) then throw "empirical Chemistry claim identity is invalid"
 if !(Text.chars "SFT-EXP-CHEM-").isPrefixOf (Text.chars experimentId) then throw "empirical Chemistry experiment identity is invalid"
 if MolecularIonizationEvidence.dependencies.isEmpty || dimensions.length != 8 || targetIds.isEmpty then
  throw "empirical Chemistry law lacks dependencies, eight dimensions or targets"
 if !distinct (dimensions.map Prod.fst) then throw "empirical Chemistry law contains duplicate dimensions"
 let _ ← dimensions.mapM fun d => do
  if d.2.length != 2 then throw "each Chemistry dimension must exhaust two registered forms"
  if (d.2.filter Prod.snd).length != 1 then throw "dimension requires one preserving form"
 if !SFT.Physics.CapabilityValues.nonblank expectedLabel || !SFT.Physics.CapabilityValues.nonblank falsification then
  throw "Chemistry prediction or falsification condition is missing"
 if !distinct targetIds then throw "Chemistry target identities are duplicated"
 if !(snapshotHashes.all fun h => (Text.chars "sha256:").isPrefixOf (Text.chars h)) then throw "Chemistry target snapshot identity is invalid"
 let witnesses ← RunningConvergenceMeasurement.array MolecularIonizationEvidence.witnesses
 if !(witnesses.all fun row => match row with
  | .array values => sameValue ((values.drop 2).headD .null) (.boolean true)
  | .null | .boolean _ | .integer _ | .text _ | .object _ => false) then throw "Chemistry operational witness failed"
 return ()
theorem registeredSpecValid : validateSpec = .ok () := rfl
end SFT.Chemistry.MolecularIonizationExperiment
