import SFT.Physics.DeuteronMeasurement
import SFT.Physics.DecayWidthBranchingLifetimeEvidence
namespace SFT.Physics.DecayWidthMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
open DecayWidthBranchingLifetimeEvidence
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "PDG-NIST-DECAY-WIDTH-BRANCHING-LIFETIME-2026"
def sourcePath : String := "experiments/external_sources/physics/snapshots/decay-width-branching-lifetime-source-record.json"
def sourceHash : String := "sha256:331b5b194d2282f2a9e9dde4d92c9635844f0e3cac08fd0389083287d81890fc"
def codataPath : String := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def sourceIds : List String := ["PDG-2026-W-BOSON-LISTING", "NIST-CODATA-2022"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/decay-width-branching-lifetime-source-record.json","sha256:331b5b194d2282f2a9e9dde4d92c9635844f0e3cac08fd0389083287d81890fc"),("experiments/external_sources/physics/snapshots/pdg-2026-w-boson-listing.pdf","sha256:f1905e46980fb732a525de5a1eaa58cb6a87ff97a9dc135e3d7935912ba1d2a1"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67")]
def registeredRecord : Value := .object [("record_id",.text "PDG-NIST-DECAY-WIDTH-BRANCHING-LIFETIME-2026"),("retrieved_utc",.text "2026-07-25T00:00:00Z"),("source_id",.text "PDG-NIST-DECAY-WIDTH-BRANCHING-LIFETIME-2026"),("custody",.object [("complete_reported_rows_retained",.boolean true),("development_targets_already_known",.boolean true),("empirical_prediction_protocol",.boolean true),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("target_inaccessible_during_prediction_execution",.boolean true)]),("sources",.array [.object [("source_id",.text "PDG-2026-W-BOSON-LISTING"),("authority",.text "Particle Data Group"),("citation",.text "F. Takahashi et al. (Particle Data Group), International Journal of Modern Physics A 41, 2630011 (2026)"),("url",.text "https://pdg.lbl.gov/2026/listings/rpp2026-list-w-boson.pdf"),("snapshot",.text "pdg-2026-w-boson-listing.pdf"),("snapshot_sha256",.text "f1905e46980fb732a525de5a1eaa58cb6a87ff97a9dc135e3d7935912ba1d2a1"),("document_created",.text "2026-06-01 16:25"),("width_scope",.object [("printed_page",.integer (5)),("definition",.text "The listed W width is the width parameter in a Breit-Wigner distribution with mass-dependent width."),("unit",.text "GeV"),("complete_table_rows",.array [.object [("row",.text "OUR AVERAGE"),("central",.text "2.14"),("uncertainties",.array [.text "0.05"]),("used_in_average",.boolean true),("note",.text "error includes scale factor 1.7")],.object [("row",.text "AAD 24CJ ATLAS"),("central",.text "2.202"),("uncertainties",.array [.text "0.032",.text "0.034"]),("used_in_average",.boolean true)],.object [("row",.text "SCHAEL 13A LEP"),("central",.text "2.195"),("uncertainties",.array [.text "0.083"]),("used_in_average",.boolean true)],.object [("row",.text "TEVEWWG 10 TEVATRON"),("central",.text "2.046"),("uncertainties",.array [.text "0.049"]),("used_in_average",.boolean true)],.object [("row",.text "ABAZOV 09AK D0"),("central",.text "2.028"),("uncertainties",.array [.text "0.072"]),("used_in_average",.boolean false)],.object [("row",.text "AALTONEN 08B CDF"),("central",.text "2.032"),("uncertainties",.array [.text "0.045",.text "0.057"]),("used_in_average",.boolean false)],.object [("row",.text "ABDALLAH 08A DELPHI"),("central",.text "2.404"),("uncertainties",.array [.text "0.140",.text "0.101"]),("used_in_average",.boolean false)],.object [("row",.text "ABBIENDI 06 OPAL"),("central",.text "1.996"),("uncertainties",.array [.text "0.096",.text "0.102"]),("used_in_average",.boolean false)],.object [("row",.text "ACHARD 06 L3"),("central",.text "2.18"),("uncertainties",.array [.text "0.11",.text "0.09"]),("used_in_average",.boolean false)],.object [("row",.text "SCHAEL 06 ALEPH"),("central",.text "2.14"),("uncertainties",.array [.text "0.09",.text "0.06"]),("used_in_average",.boolean false)],.object [("row",.text "ABAZOV 02E D0"),("central",.text "2.23"),("uncertainties",.array [.text "+0.15",.text "-0.14",.text "0.10"]),("used_in_average",.boolean false)],.object [("row",.text "ABBOTT 00B D0"),("central",.text "2.152"),("uncertainties",.array [.text "0.066"]),("used_in_average",.boolean false),("note",.text "extracted value")],.object [("row",.text "AFFOLDER 00M CDF"),("central",.text "2.05"),("uncertainties",.array [.text "0.10",.text "0.08"]),("used_in_average",.boolean false)],.object [("row",.text "ABE 95W CDF"),("central",.text "2.064"),("uncertainties",.array [.text "0.060",.text "0.059"]),("used_in_average",.boolean false),("note",.text "extracted value")],.object [("row",.text "ALITTI 92 UA2"),("central",.text "2.10"),("uncertainties",.array [.text "+0.14",.text "-0.13",.text "0.09"]),("used_in_average",.boolean false)],.object [("row",.text "ALBAJAR 91 UA1"),("central",.text "2.18"),("uncertainties",.array [.text "+0.26",.text "-0.24",.text "0.04"]),("used_in_average",.boolean false)]])]),("decay_mode_scope",.object [("printed_page",.integer (7)),("charge_conjugation_note",.text "W-minus modes are charge conjugates of the listed W-plus modes."),("complete_primary_mode_rows",.array [.object [("gamma_id",.text "Gamma1"),("mode",.text "ell+ nu"),("central_percent",.text "10.86"),("uncertainty_percent",.text "0.09"),("classification",.text "average per lepton species, not a sum")],.object [("gamma_id",.text "Gamma2"),("mode",.text "e+ nu"),("central_percent",.text "10.71"),("uncertainty_percent",.text "0.16"),("classification",.text "exclusive primary leptonic channel")],.object [("gamma_id",.text "Gamma3"),("mode",.text "mu+ nu"),("central_percent",.text "10.63"),("uncertainty_percent",.text "0.15"),("classification",.text "exclusive primary leptonic channel")],.object [("gamma_id",.text "Gamma4"),("mode",.text "tau+ nu"),("central_percent",.text "11.38"),("uncertainty_percent",.text "0.21"),("classification",.text "exclusive primary leptonic channel")],.object [("gamma_id",.text "Gamma5"),("mode",.text "hadrons"),("central_percent",.text "67.41"),("uncertainty_percent",.text "0.27"),("classification",.text "exclusive primary hadronic complement")],.object [("gamma_id",.text "Gamma6"),("mode",.text "pi+ gamma"),("upper_limit_fraction",.text "1.9e-6"),("confidence_percent",.text "95"),("classification",.text "exclusive hadronic subset limit")],.object [("gamma_id",.text "Gamma7"),("mode",.text "rho+ gamma"),("upper_limit_fraction",.text "5.2e-6"),("confidence_percent",.text "95"),("classification",.text "exclusive hadronic subset limit")],.object [("gamma_id",.text "Gamma8"),("mode",.text "K+ gamma"),("upper_limit_fraction",.text "1.7e-6"),("confidence_percent",.text "95"),("classification",.text "exclusive hadronic subset limit")],.object [("gamma_id",.text "Gamma9"),("mode",.text "Ds+ gamma"),("upper_limit_fraction",.text "6e-4"),("confidence_percent",.text "95"),("classification",.text "exclusive hadronic subset limit")],.object [("gamma_id",.text "Gamma10"),("mode",.text "c X"),("central_percent",.text "33.0"),("uncertainty_percent",.text "1.2"),("classification",.text "inclusive hadronic subset")],.object [("gamma_id",.text "Gamma11"),("mode",.text "c sbar"),("central_percent",.text "31"),("upper_uncertainty_percent",.text "13"),("lower_uncertainty_percent",.text "11"),("classification",.text "hadronic subset")],.object [("gamma_id",.text "Gamma12"),("mode",.text "invisible"),("central_percent",.text "1.4"),("uncertainty_percent",.text "2.8"),("classification",.text "search class, not an additional established exclusive primary branch")],.object [("gamma_id",.text "Gamma13"),("mode",.text "pi+ pi+ pi-"),("upper_limit_fraction",.text "1.01e-6"),("confidence_percent",.text "95"),("classification",.text "exclusive hadronic subset limit")]])]),("branching_scope",.object [("printed_pages",.array [.integer (8),.integer (9),.integer (10),.integer (11),.integer (12)]),("lepton_universality_fit",.object [("leptonic_each_central_percent",.text "10.86"),("leptonic_each_uncertainty_percent",.text "0.09"),("hadronic_central_percent",.text "67.41"),("hadronic_uncertainty_percent",.text "0.27"),("published_closure_relation",.text "B(W to hadrons) = 1 - 3 B(W to ell nu)"),("fit_chi_squared",.text "15.4"),("degrees_of_freedom",.text "11")]),("individual_exclusive_fit",.array [.object [("mode",.text "e+ nu"),("central_percent",.text "10.71"),("uncertainty_percent",.text "0.16")],.object [("mode",.text "mu+ nu"),("central_percent",.text "10.63"),("uncertainty_percent",.text "0.15")],.object [("mode",.text "tau+ nu"),("central_percent",.text "11.38"),("uncertainty_percent",.text "0.21")],.object [("mode",.text "hadrons"),("central_percent",.text "67.41"),("uncertainty_percent",.text "0.27")]]),("scope_note",.text "Inclusive and exclusive hadronic subsets and upper-limit searches are retained but are not added again to the four-channel exclusive partition.")])],.object [("source_id",.text "NIST-CODATA-2022"),("authority",.text "National Institute of Standards and Technology"),("url",.text "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"),("snapshot",.text "nist-codata-2022-allascii.txt"),("snapshot_sha256",.text "77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("required_rows",.array [.object [("quantity",.text "reduced Planck constant in eV s"),("value_record",.text "6.582 119 569... e-16"),("uncertainty_record",.text "(exact)"),("unit",.text "eV s"),("comparison_policy",.text "The displayed prefix is enclosed by adjacent exact rational decimal endpoints; the ellipsis is not promoted to a rational proof value.")]])]]),("measurement_scope",.object [("primary_width_vector",.text "PDG 2026 complete W-width table, including every used and not-used row"),("primary_branching_vector",.text "PDG 2026 complete thirteen-row W-plus decay-mode table plus both exclusive fit organizations"),("lifetime_transport",.text "NIST CODATA reduced-action inscription combined after seal with the PDG total-width interval"),("partition_boundary",.text "Only mutually exclusive primary e, mu, tau and hadronic channels form the complete partition; aggregate, inclusive-subset, exclusive-subset and upper-limit rows are retained without double counting.")]),("transcription_protocol",.text "The 2026 PDG PDF was downloaded from the official PDG endpoint, hashed, text-extracted and visually checked on printed pages 5, 7, 8 and 12. Exact printed decimal strings, asymmetric uncertainties, use-status, subset classification and the PDG closure formula were retained. The NIST row is read from the already frozen official CODATA snapshot. No printed target value enters the formal candidate predicates.")]
def payloadBoundary (payload : Value) : Except String Value := do
 let sources := (array ((field payload "sources").toOption.getD (.array []))).toOption.getD []
 if !sameValue ((field payload "source_id").toOption.getD .null) (.text sourceId) || sources.length  !=  2 then throw "decay-width source-set identity changed"
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "complete_reported_rows_retained").toOption.getD .null) (.boolean true) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "decay-width custody boundary changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "decay-width custody boundary changed"
 let pdg ← match sources with | a::_ => .ok a | [] => .error "IndexError"
 let nist ← match sources with | _::b::_ => .ok b | [] => .error "IndexError" | [_] => .error "IndexError"
 let width ← field pdg "width_scope"
 let modes ← field pdg "decay_mode_scope"
 let branching ← field pdg "branching_scope"
 let widths ← array (← field width "complete_table_rows")
 let rows ← array (← field modes "complete_primary_mode_rows")
 let individual ← array (← field branching "individual_exclusive_fit")
 let eq := fun obj key expected => sameValue ((field obj key).toOption.getD .null) expected
 if !eq pdg "source_id" (.text "PDG-2026-W-BOSON-LISTING") || !eq pdg "snapshot_sha256" (.text "f1905e46980fb732a525de5a1eaa58cb6a87ff97a9dc135e3d7935912ba1d2a1") || !eq width "printed_page" (.integer 5) || !eq modes "printed_page" (.integer 7) || !eq branching "printed_pages" (.array ([8,9,10,11,12].map (fun n => .integer n))) || widths.length != 16 || rows.length != 13 || individual.length != 4 || !eq nist "source_id" (.text "NIST-CODATA-2022") || ((array ((field nist "required_rows").toOption.getD (.array []))).toOption.getD []).length != 1 then throw "decay-width registered page or row scope changed"
 let ids ← rows.mapM (fun row => field row "gamma_id")
 if !sameValue (.array ids) (.array ((List.range 13).map (fun n => .text (Text.append "Gamma" (toString (n+1)))))) then throw "PDG complete mode-row identity changed"
 pure payload
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← match files.find? (fun p => Text.equal p.1 relative) with
   | none => .error (Text.append "FileNotFoundError: " relative)
   | some pair => .ok pair.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "decay-width source identity changed: " relative)
  pure ())
 payloadBoundary payload
def codataActionRow (files : List (String × ByteArray)) : Except String String := do
 let lines ← DeuteronMeasurement.rawLines files codataPath
 let rows := lines.filter (fun line => (Text.chars line).length ≥ 110 && Text.equal (DeuteronMeasurement.textSegment line 0 60) "reduced Planck constant in eV s")
 let row ← match rows with | [r] => .ok r | [] => .error "NIST reduced-action row changed" | _::_::_ => .error "NIST reduced-action row changed"
 if !Text.equal (DeuteronMeasurement.textSegment row 60 85) "6.582 119 569... e-16" || !Text.equal (DeuteronMeasurement.textSegment row 85 110) "(exact)" || !Text.equal (String.ofList (LeptonDecimal.strip ((Text.chars row).drop 110))) "eV s" then throw "NIST reduced-action inscription changed"
 pure row
def exactTotal (values : List Rat) : Except String Rat := do
 if values.isEmpty || values.any (fun x => x.num<1) then throw "measurement total requires a nonempty positive family"
 match values with | [] => throw "measurement total requires a nonempty positive family" | a::xs => pure (xs.foldl add a)
def percentPart (value : String) : Except String Rat := do
 LeptonRatios.divide (← LeptonDecimal.exactDecimal value) (VacuumLedgerProofs.wholeRatio 100)
def symmetricInterval (central uncertainty : Rat) : Except String (Rat × Rat) := do
 if !uncertainty.blt central then throw "measurement interval lost a positive lower endpoint"
 pure (← RunningConvergence.positiveTake central uncertainty,add central uncertainty)
def intervalContains (interval : Rat × Rat) (value : Rat) : Bool := !value.blt interval.1 && !interval.2.blt value
def intervalProduct (left right : Rat × Rat) : Rat × Rat := (multiply left.1 right.1,multiply left.2 right.2)
def intervalValue (p : Rat × Rat) : Value := .array [fractionValue p.1,fractionValue p.2]
def pdgAnalysis (record : Value) : Except String Value := do
 let sources ← array (← field record "sources")
 let pdg ← match sources with | a::_ => .ok a | [] => .error "IndexError"
 let widths ← array (← field (← field pdg "width_scope") "complete_table_rows")
 let modes ← array (← field (← field pdg "decay_mode_scope") "complete_primary_mode_rows")
 let branching ← field pdg "branching_scope"
 let universal ← field branching "lepton_universality_fit"
 let individual ← array (← field branching "individual_exclusive_fit")
 let first ← match widths with | a::_ => .ok a | [] => .error "IndexError"
 let widthCentral ← LeptonDecimal.exactDecimal (← text (← field first "central"))
 let us ← array (← field first "uncertainties")
 let u ← match us with | a::_ => .ok a | [] => .error "IndexError"
 let widthInterval ← symmetricInterval widthCentral (← LeptonDecimal.exactDecimal (← text u))
 let lepton ← percentPart (← text (← field universal "leptonic_each_central_percent"))
 let leptonU ← percentPart (← text (← field universal "leptonic_each_uncertainty_percent"))
 let hadron ← percentPart (← text (← field universal "hadronic_central_percent"))
 let hadronU ← percentPart (← text (← field universal "hadronic_uncertainty_percent"))
 let li ← symmetricInterval lepton leptonU
 let hi ← symmetricInterval hadron hadronU
 let universalIntervals := [li,li,li,hi]
 let universalCentral := [lepton,lepton,lepton,hadron]
 let sumIntervals := fun xs : List (Rat × Rat) => do pure (← exactTotal (xs.map Prod.fst),← exactTotal (xs.map Prod.snd))
 let universalSum ← sumIntervals universalIntervals
 let one := VacuumLedgerProofs.wholeRatio 1
 let forcedUniversal ← RunningConvergence.positiveTake one (multiply lepton (VacuumLedgerProofs.wholeRatio 3))
 let individualCentral ← individual.mapM (fun row => do percentPart (← text (← field row "central_percent")))
 let individualIntervals ← individual.mapM (fun row => do symmetricInterval (← percentPart (← text (← field row "central_percent"))) (← percentPart (← text (← field row "uncertainty_percent"))))
 let individualSum ← sumIntervals individualIntervals
 let forcedIndividual ← RunningConvergence.positiveTake one (← exactTotal (individualCentral.take 3))
 let fourth ← match individualIntervals.drop 3 with | a::_ => .ok a | [] => .error "IndexError"
 let universalRounding ← RunningConvergence.positiveTake one (← exactTotal universalCentral)
 let individualRounding ← RunningConvergence.positiveTake (← exactTotal individualCentral) one
 let partialIntervals := individualIntervals.map (intervalProduct widthInterval)
 let partialSum ← sumIntervals partialIntervals
 let classifications ← modes.mapM (fun row => do text (← field row "classification"))
 let used ← widths.drop 1 |>.mapM (fun row => field row "used_in_average")
 let ids ← modes.mapM (fun row => do text (← field row "gamma_id"))
 pure (.object [
 ("width_row_count",.integer (.ofNat widths.length)),("used_width_component_count",.integer (.ofNat (used.filter (fun x => sameValue x (.boolean true))).length)),("mode_row_count",.integer (.ofNat modes.length)),("individual_exclusive_row_count",.integer (.ofNat individual.length)),
 ("width_central_GeV",fractionValue widthCentral),("width_interval_GeV",intervalValue widthInterval),
 ("universal_central_branch_vector",ratList universalCentral),("universal_interval_sum",intervalValue universalSum),("universal_interval_contains_one",.boolean (intervalContains universalSum one)),
 ("forced_universal_hadron",fractionValue forcedUniversal),("forced_universal_hadron_inside_reported_interval",.boolean (intervalContains hi forcedUniversal)),("universal_printed_rounding_take",fractionValue universalRounding),
 ("individual_central_branch_vector",ratList individualCentral),("individual_interval_sum",intervalValue individualSum),("individual_interval_contains_one",.boolean (intervalContains individualSum one)),
 ("forced_individual_hadron",fractionValue forcedIndividual),("forced_individual_hadron_inside_reported_interval",.boolean (intervalContains fourth forcedIndividual)),("individual_printed_rounding_take",fractionValue individualRounding),
 ("partial_width_intervals_GeV",.array (partialIntervals.map intervalValue)),("partial_width_sum_interval_GeV",intervalValue partialSum),("partial_width_sum_encloses_total_width_interval",.boolean (!widthInterval.1.blt partialSum.1 && !partialSum.2.blt widthInterval.2)),
 ("published_gamma_fraction_notation",.boolean (ids.all (fun id => Text.equal (String.ofList ((Text.chars id).take 5)) "Gamma"))),
 ("published_exact_complement_relation",.boolean (sameValue (← field universal "published_closure_relation") (.text "B(W to hadrons) = 1 - 3 B(W to ell nu)"))),
 ("subsets_retained_without_double_counting",.boolean (classifications.length==13 && (classifications.filter (fun x => Text.equal x "exclusive primary leptonic channel")).length==3 && (classifications.filter (fun x => Text.equal x "exclusive primary hadronic complement")).length==1 && (classifications.drop 5).all (fun x => Text.contains x "subset" || Text.contains x "search class")))])
def nistActionAnalysis (row : String) (widthInterval : Rat × Rat) : Except String Value := do
 if !Text.equal (DeuteronMeasurement.textSegment row 0 60) "reduced Planck constant in eV s" then throw "wrong NIST action row released"
 let lo := normalize 6582119569 (10^25) (by decide)
 let hi := normalize 6582119570 (10^25) (by decide)
 let loG ← LeptonRatios.divide lo (VacuumLedgerProofs.wholeRatio (10^9))
 let hiG ← LeptonRatios.divide hi (VacuumLedgerProofs.wholeRatio (10^9))
 let life := (← LeptonRatios.divide loG widthInterval.2,← LeptonRatios.divide hiG widthInterval.1)
 let atlas ← LeptonDecimal.exactDecimal "2.202"
 let tevatron ← LeptonDecimal.exactDecimal "2.046"
 let atlasLife ← LeptonRatios.divide loG atlas
 let tevatronLife ← LeptonRatios.divide loG tevatron
 pure (.object [("displayed_prefix_interval_eV_s",intervalValue (lo,hi)),("displayed_prefix_interval_GeV_s",intervalValue (loG,hiG)),("pdg_width_interval_GeV",intervalValue widthInterval),("derived_lifetime_interval_s",intervalValue life),("finite_positive_lifetime_interval",.boolean (life.1.num>=1 && life.1.blt life.2)),("greater_width_shorter_lifetime",.boolean (tevatron.blt atlas && atlasLife.blt tevatronLife)),("ellipsis_not_promoted_to_exact_rational",.boolean true)])
end SFT.Physics.DecayWidthMeasurement
