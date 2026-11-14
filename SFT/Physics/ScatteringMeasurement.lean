import SFT.Physics.DeuteronMeasurement
import SFT.Physics.ScatteringRutherfordComptonEvidence
namespace SFT.Physics.ScatteringMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
open ScatteringRutherfordComptonEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "IAEA-NIST-RUTHERFORD-COMPTON-2026"
def sourcePath : String := "experiments/external_sources/physics/snapshots/scattering-rutherford-compton-source-record.json"
def sourceHash : String := "sha256:048ec96abfbd4835adf37e46f9f172a6310443aff1b3f3701bf3fe50bc402ef1"
def codataPath : String := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def sourceIds : List String := ["IAEA-STI-PUB-1196-RADIATION-PHYSICS", "NIST-CODATA-2022"]
def quantities : List (String × String) := [("Planck constant","J Hz^-1"),("speed of light in vacuum","m s^-1"),("electron mass","kg"),("Compton wavelength","m"),("electron mass energy equivalent in MeV","MeV"),("classical electron radius","m"),("Thomson cross section","m^2")]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/scattering-rutherford-compton-source-record.json","sha256:048ec96abfbd4835adf37e46f9f172a6310443aff1b3f3701bf3fe50bc402ef1"),("experiments/external_sources/physics/snapshots/iaea-rutherford-compton-handbook.pdf","sha256:da4e3b5af19ed9506a812fea6704ff15cf55991902684a17759dbc7cbba05da0"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67")]
def registeredRecord : Value := .object [("custody",.object [("complete_reported_rows_retained",.boolean true),("development_targets_already_known",.boolean true),("empirical_prediction_protocol",.boolean true),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("target_inaccessible_during_prediction_execution",.boolean true)]),("measurement_scope",.object [("iaea_handbook",.object [("compton",.object [("assumptions_retained",.array [.text "The electron is essentially free and stationary.",.text "The incident photon energy is much larger than the electron binding energy.",.text "Energy and momentum are conserved across photon and recoil-electron carriers."]),("compton_carrier_definition",.text "lambda_C = h/(m_e c)"),("compton_carrier_rounded_angstrom",.text "0.024"),("pdf_page_index_one_based",.integer (68)),("printed_page",.integer (30)),("wavelength_shift_relation",.text "delta_lambda = lambda_C * (1 - cos(theta))")]),("publication",.object [("identifier",.text "STI/PUB/1196"),("publisher",.text "International Atomic Energy Agency"),("title",.text "Radiation Oncology Physics: A Handbook for Teachers and Students")]),("rutherford",.object [("coulomb_force_radial_order",.text "inverse-square"),("differential_cross_section_relation",.text "d_sigma/d_omega = (D/4)^2 / sin(theta/2)^4"),("distance_of_closest_approach_relation",.text "D = z_alpha * Z_N * e^2 / (4*pi*epsilon_0*E_K)"),("historical_large_angle_observation",.object [("angle_class",.text "theta greater than 90 degrees"),("geiger_marsden_observed_probability",.text "approximately 1/10^4"),("obsolete_diffuse_model_prediction_order",.text "10^-3500")]),("historical_pdf_page_index_one_based",.integer (47)),("historical_printed_page",.integer (9)),("relation_pdf_page_index_one_based",.integer (48)),("relation_printed_page",.integer (10)),("scope_boundary",.text "Repulsive Coulomb scattering of a positively charged alpha particle by a more massive positively charged nucleus under the handbook's stated nonrelativistic point-boundary conditions.")])]),("nist_codata2022",.object [("required_rows",.array [.object [("quantity",.text "Planck constant"),("unit",.text "J Hz^-1")],.object [("quantity",.text "speed of light in vacuum"),("unit",.text "m s^-1")],.object [("quantity",.text "electron mass"),("unit",.text "kg")],.object [("quantity",.text "Compton wavelength"),("unit",.text "m")],.object [("quantity",.text "electron mass energy equivalent in MeV"),("unit",.text "MeV")],.object [("quantity",.text "classical electron radius"),("unit",.text "m")],.object [("quantity",.text "Thomson cross section"),("unit",.text "m^2")]]),("relation_boundary",.text "Planck action divided by electron inertial support and limiting-speed support predicts the electron Compton carrier. Electron mass-energy fixes the 90-degree and backscatter high-energy Compton ceilings after the structural relation is sealed.")])]),("retrieval_date",.text "2026-07-25"),("schema",.text "sft-v3-scattering-rutherford-compton-source-record/1"),("source_id",.text "IAEA-NIST-RUTHERFORD-COMPTON-2026"),("sources",.array [.object [("measurement_body",.text "International Atomic Energy Agency"),("snapshot_hash",.text "sha256:da4e3b5af19ed9506a812fea6704ff15cf55991902684a17759dbc7cbba05da0"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/iaea-rutherford-compton-handbook.pdf"),("source_id",.text "IAEA-STI-PUB-1196-RADIATION-PHYSICS"),("source_uri",.text "https://www-pub.iaea.org/mtcd/publications/pdf/pub1196_web.pdf")],.object [("measurement_body",.text "National Institute of Standards and Technology"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("source_id",.text "NIST-CODATA-2022"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/index.html")]])]
def payloadBoundary (payload : Value) : Except String Value := do
 let sources := (array ((field payload "sources").toOption.getD (.array []))).toOption.getD []
 if !sameValue ((field payload "source_id").toOption.getD .null) (.text sourceId) || sources.length != 2 then throw "scattering source-set identity changed"
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "complete_reported_rows_retained").toOption.getD .null) (.boolean true) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "scattering custody boundary changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "scattering custody boundary changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "scattering custody boundary changed"
 let scope := (field payload "measurement_scope").toOption.getD (.object [])
 let iaea := (field scope "iaea_handbook").toOption.getD (.object [])
 let rutherford := (field iaea "rutherford").toOption.getD (.object [])
 let compton := (field iaea "compton").toOption.getD (.object [])
 let nist := (field scope "nist_codata2022").toOption.getD (.object [])
 if !sameValue ((field rutherford "historical_pdf_page_index_one_based").toOption.getD .null) (.integer 47) || !sameValue ((field rutherford "relation_pdf_page_index_one_based").toOption.getD .null) (.integer 48) || !sameValue ((field compton "pdf_page_index_one_based").toOption.getD .null) (.integer 68) || ((array ((field nist "required_rows").toOption.getD (.array []))).toOption.getD []).length != 7 then throw "scattering registered page or row scope changed"
 pure payload
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← match files.find? (fun p => Text.equal p.1 relative) with
   | none => .error (Text.append "FileNotFoundError: " relative)
   | some pair => .ok pair.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "scattering source identity changed: " relative)
  pure ())
 payloadBoundary payload
def codataRows (files : List (String × ByteArray)) : Except String (List String) := do
 let lines ← DeuteronMeasurement.rawLines files codataPath
 let selected := quantities.flatMap (fun (quantity,_) => lines.filter (fun line => (Text.chars line).length ≥ 110 && Text.equal (DeuteronMeasurement.textSegment line 0 60) quantity))
 if selected.length != quantities.length then throw "complete CODATA scattering vector changed"
 if !(selected.map (fun row => (DeuteronMeasurement.textSegment row 0 60).toUTF8.data.toList.map UInt8.toNat) == quantities.map (fun row => row.1.toUTF8.data.toList.map UInt8.toNat)) then throw "CODATA scattering vector order changed"
 pure selected
structure CodataRow where
 quantity : String
 unit : String
 central : Rat
 lower : Rat
 upper : Rat
 uncertaintyRecord : String
def parseCodataRow (line : String) : Except String CodataRow := do
 let quantity := DeuteronMeasurement.textSegment line 0 60
 let valueRecord := DeuteronMeasurement.textSegment line 60 85
 let uncertaintyRecord := DeuteronMeasurement.textSegment line 85 110
 let unit := String.ofList (LeptonDecimal.strip ((Text.chars line).drop 110))
 if !(quantities.any (fun (name,u) => Text.equal name quantity && Text.equal u unit)) then throw "CODATA scattering row identity changed"
 let central ← LeptonDecimal.exactDecimal valueRecord
 let (lower,upper) ← if Text.equal uncertaintyRecord "(exact)" then pure (central,central) else do
  let uncertainty ← LeptonDecimal.exactDecimal uncertaintyRecord
  if !uncertainty.blt central then throw "CODATA scattering uncertainty lost a positive lower endpoint"
  pure (subtract central uncertainty,add central uncertainty)
 pure ⟨quantity,unit,central,lower,upper,uncertaintyRecord⟩
def intervalValue (lo hi : Rat) : Value := .array [fractionValue lo,fractionValue hi]
def codataAnalysis (rows : List String) : Except String Value := do
 let parsed ← rows.mapM parseCodataRow
 let get := fun name => match parsed.reverse.find? (fun row => Text.equal row.quantity name) with
  | some row => Except.ok row | none => .error "KeyError"
 let action ← get "Planck constant"
 let speed ← get "speed of light in vacuum"
 let mass ← get "electron mass"
 let observed ← get "Compton wavelength"
 let rest ← get "electron mass energy equivalent in MeV"
 let radius ← get "classical electron radius"
 let thomson ← get "Thomson cross section"
 let predictedLo ← LeptonRatios.divide action.lower (multiply mass.upper speed.upper)
 let predictedHi ← LeptonRatios.divide action.upper (multiply mass.lower speed.lower)
 let roundedLo ← LeptonRatios.divide (normalize 235 10000 (by decide)) (VacuumLedgerProofs.wholeRatio (10^10))
 let roundedHi ← LeptonRatios.divide (normalize 245 10000 (by decide)) (VacuumLedgerProofs.wholeRatio (10^10))
 -- Dictionary lookup above retains the last record, exactly as Python assignment.
 let lastRows ← parsed.mapM (fun row => get row.quantity)
 pure (.object [("row_count",.integer (.ofNat rows.length)),("all_rows_exact_positive",.boolean (lastRows.all (fun row => decide (1 ≤ row.lower.num)))),("planck_exact",.boolean (Text.equal action.uncertaintyRecord "(exact)")),("speed_exact",.boolean (Text.equal speed.uncertaintyRecord "(exact)")),("derived_compton_wavelength_interval_m",intervalValue predictedLo predictedHi),("reported_compton_wavelength_interval_m",intervalValue observed.lower observed.upper),("derived_reported_intervals_overlap",.boolean (!observed.upper.blt predictedLo && !predictedHi.blt observed.lower)),("iaea_rounded_compton_carrier_contains_nist",.boolean (!observed.lower.blt roundedLo && !roundedHi.blt observed.upper)),("electron_rest_energy_interval_MeV",intervalValue rest.lower rest.upper),("right_angle_high_energy_ceiling_interval_MeV",intervalValue rest.lower rest.upper),("backscatter_high_energy_ceiling_interval_MeV",intervalValue (← LeptonRatios.divide rest.lower (VacuumLedgerProofs.wholeRatio 2)) (← LeptonRatios.divide rest.upper (VacuumLedgerProofs.wholeRatio 2))),("classical_electron_radius_interval_m",intervalValue radius.lower radius.upper),("thomson_cross_section_interval_m2",intervalValue thomson.lower thomson.upper)])
def iaeaAnalysis (record : Value) : Except String Value := do
 let iaea ← field (← field record "measurement_scope") "iaea_handbook"
 let r ← field iaea "rutherford"
 let c ← field iaea "compton"
 let history ← field r "historical_large_angle_observation"
 let assumptions ← array (← field c "assumptions_retained")
 let eq := fun obj key expected => sameValue ((field obj key).toOption.getD .null) (.text expected)
 pure (.object [
 ("inverse_square_coulomb_recorded",.boolean (eq r "coulomb_force_radial_order" "inverse-square")),
 ("rutherford_relation_complete",.boolean (eq r "differential_cross_section_relation" "d_sigma/d_omega = (D/4)^2 / sin(theta/2)^4" && eq r "distance_of_closest_approach_relation" "D = z_alpha * Z_N * e^2 / (4*pi*epsilon_0*E_K)")),
 ("large_angle_observed_support",.boolean (eq history "angle_class" "theta greater than 90 degrees" && eq history "geiger_marsden_observed_probability" "approximately 1/10^4" && eq history "obsolete_diffuse_model_prediction_order" "10^-3500")),
 ("compton_relation_complete",.boolean (eq c "wavelength_shift_relation" "delta_lambda = lambda_C * (1 - cos(theta))" && eq c "compton_carrier_definition" "lambda_C = h/(m_e c)")),
 ("compton_assumptions_complete",.boolean (sameValue (.array assumptions) (.array [.text "The electron is essentially free and stationary.",.text "The incident photon energy is much larger than the electron binding energy.",.text "Energy and momentum are conserved across photon and recoil-electron carriers."]))),
 ("rutherford_scope_retained",.boolean (Text.contains (← text (← field r "scope_boundary")) "nonrelativistic point-boundary conditions")),
 ("iaea_rutherford_angular_vector",.array ([VacuumLedgerProofs.wholeRatio 16,VacuumLedgerProofs.wholeRatio 4,normalize 16 9 (by decide),VacuumLedgerProofs.wholeRatio 1].map fractionValue)),
 ("iaea_compton_shift_vector",.array ([normalize 1 2 (by decide),VacuumLedgerProofs.wholeRatio 1,normalize 3 2 (by decide),VacuumLedgerProofs.wholeRatio 2].map fractionValue))])
def exactMeasurementAnalysis (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let record ← authoritativeRecord files payload
 let codata ← codataAnalysis (← codataRows files)
 let iaea ← iaeaAnalysis record
 let cert ← ScatteringRutherfordCompton.formalCertificate
 pure (.object [("codata",codata),("iaea",iaea),("all_sources_retained",.boolean ((← array (← field record "sources")).length==2)),("rutherford_exact_vector_matches",.boolean (sameValue (← field iaea "iaea_rutherford_angular_vector") (.array ((cert.angularDensity.map Prod.snd).map fractionValue)))),("compton_exact_vector_matches",.boolean (sameValue (← field iaea "iaea_compton_shift_vector") (.array ((cert.photonShifts.map Prod.snd).map fractionValue))))])
end SFT.Physics.ScatteringMeasurement
