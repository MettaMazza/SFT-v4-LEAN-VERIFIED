import SFT.Chemistry.HalfReactionOrientationAnalysis
import SFT.Chemistry.ComponentExchangeAnalysis
namespace SFT.Chemistry.EchemPotentialAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics
open NuclideCarrierAnalysis hiding claimId targetIds authorities validateAuthorities verifySurfaces
abbrev normalizedPage := HalfReactionOrientationAnalysis.normalizedPage
abbrev textHash := HalfReactionOrientationAnalysis.textHash
abbrev documentHash := HalfReactionOrientationAnalysis.documentHash
abbrev truthy := ComponentExchangeAnalysis.truthy
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
inductive Entry where | electrode | cell | concentration
def claimId : Entry → String
 | .electrode=>"SFT-CHEM-ELECTRODE-POTENTIAL-CHEMICAL-RELATION-002"
 | .cell=>"SFT-CHEM-CELL-POTENTIAL-COMPOSITION-003"
 | .concentration=>"SFT-CHEM-CONCENTRATION-DEPENDENT-POTENTIAL-004"
def targetIds : Entry → List String
 | .electrode=>["SFT-CHEM-ECHEM-002-STANDARD-ROWS", "SFT-CHEM-ECHEM-002-REFERENCE-CONDITION", "SFT-CHEM-ECHEM-002-DIRECTION-VECTOR", "SFT-CHEM-ECHEM-002-UNCERTAINTY-VECTOR", "SFT-CHEM-ECHEM-002-ADVERSE-DIFFERENCE", "SFT-CHEM-ECHEM-002-MODEL-PROVENANCE", "SFT-CHEM-ECHEM-002-COMPLETE-PDF"]
 | .cell=>["SFT-CHEM-ECHEM-003-CELL-CARRIERS", "SFT-CHEM-ECHEM-003-NO-LIQUID-JUNCTION", "SFT-CHEM-ECHEM-003-EMF-ROWS", "SFT-CHEM-ECHEM-003-MOLALITY-DIRECTION", "SFT-CHEM-ECHEM-003-CORRECTIONS", "SFT-CHEM-ECHEM-003-REVERSAL-CONVENTION", "SFT-CHEM-ECHEM-003-COMPLETE-PDF"]
 | .concentration=>["SFT-CHEM-ECHEM-004-MOLALITY-TEMPERATURE-SUPPORT", "SFT-CHEM-ECHEM-004-EMF-ROWS", "SFT-CHEM-ECHEM-004-ACTIVITY-ROWS", "SFT-CHEM-ECHEM-004-POTENTIAL-DIRECTION", "SFT-CHEM-ECHEM-004-ACTIVITY-DIRECTION", "SFT-CHEM-ECHEM-004-MODEL-PROVENANCE", "SFT-CHEM-ECHEM-004-ADVERSE-BEHAVIOR", "SFT-CHEM-ECHEM-004-COMPLETE-PDF"]
def authorities : List (String×String) := [("audits/CHEMISTRY_ECHEM_001_013_FAMILY_BOUNDARY_2026-07-28.json","sha256:66f3152d791eafc5f677467ef7affd72f6559150be4adf586873a79c6ad473df"),("experiments/external_sources/chemistry/echem_001_013_family_source_identity_registry_v1.json","sha256:64ec429f537c2b0274cba689a32a65a6f36aebb3ecdc96678efcc49272c63106"),("sft/chemistry/electrode_potential_law_v1.py","sha256:ca3b67badbb313e135e9231fb4a0db6a17bd3558775407d8aa0efc6285935896"),("sft/chemistry/cell_potential_composition_law_v1.py","sha256:04cd27e4a5b4e2f1e9f9fdb4927cbc458ef3194c096486fcca16190a55aff886"),("sft/chemistry/concentration_potential_law_v1.py","sha256:2a4bc0d26396b7153cae23014bfc98c3708b0206aedea9a66e0157a5d2fa4bfc"),("experiments/external_sources/chemistry/echem_002_target_identities_v1.json","sha256:a2b0c83ce705aeff8bb20371446f27acc5b59e52d8e727698f4a37cbee325fb9"),("experiments/external_sources/chemistry/echem_003_target_identities_v1.json","sha256:94bfdfcfa5920a285c555c541aecd1e678b92848c06e11305f9bd3a894131e45"),("experiments/external_sources/chemistry/echem_004_target_identities_v1.json","sha256:30b9bd6af83114eca87e914f888c412d1d540bca731b97dc335daccd7c75c174"),("experiments/sealed_predictions/chemistry_echem_002_electrode_potential_pre_source_v1.json","sha256:57199514491854ce54165ae100ba7008c0bbd03ac304259aa50e7dccbc3b949f"),("experiments/sealed_predictions/chemistry_echem_003_cell_potential_pre_source_v1.json","sha256:b87a3450fd9a9596f5f410747fdb223ec8e88005ed1173f965aeee422a3d1a83"),("experiments/sealed_predictions/chemistry_echem_004_concentration_potential_pre_source_v1.json","sha256:87df635946459c70aa7c7defec2c2af105096838179d846524c8320f861bad39"),("experiments/external_sources/chemistry/snapshots/echem-002-004-agcl-v1/source-inventory-v1.json","sha256:47e583b3cd375da8f3f8a18b900f581b2189dedd0869a8b96dac5984dba32c7d"),("experiments/external_sources/chemistry/snapshots/echem-002-004-agcl-v1/nist-agcl-standard-potential-1954.pdf","sha256:e1ebb99701a17746d9eb417938e435084c05d0cdaa50642279f54b706d2275ab"),("experiments/external_sources/chemistry/snapshots/echem-002-004-agcl-v1/complete-postseal-analysis-v2.json","sha256:a6f1c117cfa3fe3f454dd5e86989d2105bc93586ca88370f0e4e541847088216"),("tools/capture_chemistry_echem_002_004_sources_v1.py","sha256:f0563c786993d92cd429980a75165806ed65539f1069bce221a81e36d6f00790"),("tools/build_chemistry_echem_002_004_external_v1.py","sha256:8052197458365fb57a6b502b88a9fe1f1d3c6e565c7bf2c4ae7c747600c5633b")]
def entryFromId (cid : String) : Except String Entry :=
 if Text.equal cid (claimId .electrode) then .ok .electrode
 else if Text.equal cid (claimId .cell) then .ok .cell
 else if Text.equal cid (claimId .concentration) then .ok .concentration
 else .error "unknown ECHEM-002-004 claim"
def pageRecord (ordinal : Nat) (raw : String) : Value :=
 let text := normalizedPage raw
 .object [("page",.integer ordinal),("complete_extracted_text",.text text),
 ("text_sha256",.text (textHash text)),("character_count",.integer (Text.chars text).length)]
def sourcePrefix (analysis : Value) (files : List Snapshot) (rawPages : List String) : Except String String := do
 let _ ← authorities.mapM fun (path,hash)=>do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) hash then throw (Text.append "ECHEM-002-004 authority changed: " path)
  pure ()
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := .object (fs.filter fun (k,_)=> !Text.equal k "complete_result_vector_sha256")
 if !Text.equal recorded (documentHash vector) then throw "ECHEM-002-004 result vector changed"
 let pages := rawPages.zipIdx.map fun (p,i)=>pageRecord (i+1) p
 let retained ← field analysis "complete_pages_in_order"
 if !Text.equal (Canonical.render (.array pages)) (Canonical.render retained) || pages.length != 8 ||
  (rawPages.foldl (fun n p=>n+(Text.chars (normalizedPage p)).length) 0) != 37013 then throw "complete NIST PDF reconstruction changed"
 pure recorded
def sourceLength : Value → Except String Nat
 | .array xs=>.ok xs.length
 | .object fs=>.ok fs.length
 | .text s=>.ok (Text.chars s).length
 | .integer _=>.error "object of type 'int' has no len()"
 | .boolean _=>.error "object of type 'bool' has no len()"
 | .null=>.error "object of type 'NoneType' has no len()"
def equalNatural (v : Value) (n : Nat) : Bool :=
 match v with
 | .integer m=>@decide (m = Int.ofNat n) (Int.decEq m (Int.ofNat n))
 | .boolean b=>if b then n==1 else n==0
 | .array _ | .object _ | .text _ | .null=>false
def eqField (row : Value) (key : String) (n : Nat) : Except String Bool := do pure (equalNatural (← field row key) n)
def lengthField (row : Value) (key : String) (n : Nat) : Except String Bool := do pure ((← field row key >>= sourceLength)==n)
def boolField (row : Value) (key : String) : Except String Bool := do pure (truthy (← field row key))
def entryChecks (entry : Entry) (analysis : Value) : Except String (List Bool) := do
 let pdf ← eqField analysis "complete_pdf_page_count" 8
 match entry with
 | .electrode=>
  let row ← field analysis "echem_002"
  let count ← eqField row "complete_standard_potential_row_count" 17
  let rows ← lengthField row "complete_standard_potential_rows" 17
  pure [count && rows,← boolField row "reference_and_condition_retained",
   ← boolField row "all_observed_potentials_strictly_descend_with_temperature",
   ← lengthField row "standard_deviation_vector_source_inscriptions" 17,
   ← boolField row "adverse_cross_study_difference_and_unexplained_result_retained",
   ← boolField row "least_squares_and_adjustable_parameter_provenance_retained",pdf]
 | .cell=>
  let row ← field analysis "echem_003"
  let other ← field analysis "echem_002"
  let count ← eqField row "complete_smoothed_emf_row_count" 88
  let rows ← lengthField row "complete_smoothed_emf_rows" 8
  pure [← boolField row "two_hydrogen_and_two_silver_chloride_electrodes_retained",
   ← boolField row "cell_without_liquid_junction_retained",count && rows,
   ← boolField row "every_fixed_temperature_emf_column_strictly_descends_with_molality",
   ← boolField row "measurement_corrections_and_unapplied_corrections_retained",
   ← boolField other "convention_reversal_retained",pdf]
 | .concentration=>
  let row ← field analysis "echem_004"
  let molality ← eqField row "complete_molality_count" 8
  let temperatures ← eqField row "complete_temperature_count" 11
  pure [molality && temperatures,← eqField row "complete_emf_measurement_count" 88,
   ← eqField row "complete_activity_coefficient_measurement_count" 88,
   ← boolField row "every_fixed_temperature_emf_column_strictly_descends_with_molality",
   ← boolField row "every_fixed_temperature_activity_column_strictly_descends_with_molality",
   ← boolField row "source_logarithm_Debye_Huckel_least_squares_and_smoothing_models_retained_only_as_external_provenance",
   ← boolField row "source_explicitly_reports_anomalous_or_unexplained_behavior",pdf]
def summary : Entry → List (String×Value)
 | .electrode=>[("complete_standard_potential_rows",.integer 17),("temperature_range_celsius_source_inscriptions",.array [.text "0",.text "95"]),
  ("complete_pdf_pages",.integer 8),("complete_pdf_characters",.integer 37013),("adverse_cross_study_difference_retained",.boolean true)]
 | .cell=>[("complete_cell_emf_measurements",.integer 88),("complete_molality_rows",.integer 8),("complete_temperature_columns",.integer 11),
  ("complete_pdf_pages",.integer 8),("complete_pdf_characters",.integer 37013),("unapplied_corrections_retained",.boolean true)]
 | .concentration=>[("complete_emf_measurements",.integer 88),("complete_activity_measurements",.integer 88),("complete_molality_rows",.integer 8),
  ("complete_temperature_columns",.integer 11),("complete_pdf_pages",.integer 8),("complete_pdf_characters",.integer 37013),("adverse_anomaly_retained",.boolean true)]
def resolvedAnalysis (cid recorded : String) (analysis : Value) (omitLast : Bool := false) : Except String (Value×List (String×Bool)) := do
 let entry ← entryFromId cid
 let tests ← entryChecks entry analysis
 let checks := (targetIds entry).zip tests
 let checks := if omitLast then checks.take (checks.length-1) else checks
 if checks.length != (targetIds entry).length || !(checks.all Prod.snd) then throw (Text.append cid " comparison changed")
 pure (.object (summary entry ++ [("complete_result_vector_sha256",.text recorded),
  ("all_conventional_signed_zero_decimal_continuum_fitted_and_smoothed_inscriptions_retained_as_external_provenance_only",.boolean true)]),checks)
def exactAnalysis (cid : String) (analysis : Value) (files : List Snapshot) (rawPages : List String) (omitLast : Bool := false) : Except String (Value×List (String×Bool)) := do
 let recorded ← sourcePrefix analysis files rawPages
 resolvedAnalysis cid recorded analysis omitLast
end SFT.Chemistry.EchemPotentialAnalysis
