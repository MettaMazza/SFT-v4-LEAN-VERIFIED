import SFT.Physics.FusionFissionExperiment
namespace SFT.Physics.YieldThresholdMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "IAEA-AMDC-FUSION-FISSION-YIELD-THRESHOLD-2026"
def sourcePath : String := "experiments/external_sources/physics/snapshots/fusion-fission-yield-threshold-source-record.json"
def sourceHash : String := "sha256:034898757fe8e5613f2291f8fdb0369a1ec6d706df03861490eb58141a774dc9"
def sourceIds : List String := ["AMDC-AME2020-MASS-1-BINDING-2021", "IAEA-WORLD-FUSION-OUTLOOK-2023", "IAEA-TECDOC-2024-NUCLEAR-COGENERATION", "IAEA-ENDF-102-DATA-FORMATS-PROCEDURES", "IAEA-NDS-LEXFOR-FISSION-2006"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/fusion-fission-yield-threshold-source-record.json","sha256:034898757fe8e5613f2291f8fdb0369a1ec6d706df03861490eb58141a774dc9"),("experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20","sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("experiments/external_sources/physics/snapshots/iaea-world-fusion-outlook-2023.pdf","sha256:6fbe70d3943dc9d7ab1e6e9f94cb4ea81eb1431467d79bee02ce1cfaac33aa64"),("experiments/external_sources/physics/snapshots/iaea-tecdoc-2024-nuclear-cogeneration.pdf","sha256:712bbd5d6ad97c16f816d0f869626ded196c0ddbeece3f7a4a3f5d00f0db059a"),("experiments/external_sources/physics/snapshots/iaea-endf-102-manual.pdf","sha256:77a0fee413c3b1d5d74a161ed9fe7f77bbcbc58a654304851b7b2b400183d022"),("experiments/external_sources/physics/snapshots/iaea-lexfor-fission-2006.pdf","sha256:d9bfc53a63fe4cf307e1ba46c952d52dcca6c95f964dd672a3acee3bb93a0297")]
def registeredRecord : Value := .object [("custody",.object [("complete_reported_rows_retained",.boolean true),("development_targets_already_known",.boolean true),("empirical_prediction_protocol",.boolean true),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("target_inaccessible_during_prediction_execution",.boolean true)]),("measurement_scope",.object [("ame2020",.object [("complete_positive_composite_row_count",.integer 2548),("purpose",.text "Exact post-seal binding-energy-per-nucleon and total-binding comparison for the registered D to He-4 and U-238 to symmetric Pd-119 representatives."),("raw_snapshot_hash",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("source_id",.text "AMDC-AME2020-MASS-1-BINDING-2021"),("source_record_hash",.text "sha256:d10a9474253b2d29fac71ee21352039659f2e5f4b7d75395416d361878a18ddc")]),("iaea_endf_threshold_protocol",.object [("charged_particle_clause",.object [("page_index",.integer 118),("printed_page",.integer 101),("registered_observation",.text "A charged-particle reaction can have a low or absent true kinematic threshold while its cross section remains extremely small below an effective threshold because of the Coulomb barrier."),("reported_cross_section_bound_barn",.text "1/10000000000")]),("fission_reaction_identifier",.object [("page_index",.integer 120),("printed_page",.integer 103),("registered_observation",.text "The incident-neutron evaluation procedure names fission as MT 18 and separately requires complete low-energy coverage for non-threshold neutron reaction types. This establishes a neutral incident class without asserting that every fission channel is non-threshold.")]),("q_value_clause",.object [("page_index",.integer 118),("printed_page",.integer 101),("registered_observation",.text "The evaluated reaction Q carrier is the incident atomic-mass content plus initial excitation content compared with all product atomic-mass and excitation content.")])]),("iaea_fission_energy",.object [("component_rows",.array [.object [("carrier",.text "fission-fragment kinetic energy"),("recoverable_energy_mev",.text "168"),("released_energy_mev",.text "168")],.object [("carrier",.text "fission-product beta rays"),("recoverable_energy_mev",.text "8"),("released_energy_mev",.text "8")],.object [("carrier",.text "fission-product gamma rays"),("recoverable_energy_mev",.text "7"),("released_energy_mev",.text "7")],.object [("carrier",.text "fission-product neutrinos"),("recoverable_energy_mev",.null),("released_energy_mev",.text "12")],.object [("carrier",.text "prompt gamma rays"),("recoverable_energy_mev",.text "7"),("released_energy_mev",.text "7")],.object [("carrier",.text "fission-neutron kinetic energy"),("recoverable_energy_mev",.text "5"),("released_energy_mev",.text "5")],.object [("carrier",.text "capture gamma rays"),("recoverable_energy_mev_interval",.array [.text "3",.text "12"]),("released_energy_mev",.null)]]),("illustrative_channel_energy_mev",.text "200.818"),("illustrative_mass_inscriptions_used_for_exact_ame_calculation",.boolean false),("page_index",.integer 120),("printed_page",.integer 110),("registered_limitation",.text "The report's rounded illustrative mass inscriptions are retained but are not substituted for AME2020 in the exact mass-table calculation."),("reported_average_release_mev",.text "200"),("reported_recoverable_total_mev_interval",.array [.text "198",.text "207"]),("reported_released_total_mev",.text "207")]),("iaea_fusion_energy",.object [("page_index",.integer 23),("reaction_rows",.array [.object [("available_release_energy_mev",.text "17.60"),("products",.text "He-4 plus neutron"),("reactants",.text "D-T")],.object [("available_release_energy_mev",.text "4.03"),("products",.text "tritium plus proton"),("reactants",.text "D-D"),("reported_branch_share",.text "1/2")],.object [("available_release_energy_mev",.text "3.27"),("products",.text "He-3 plus neutron"),("reactants",.text "D-D"),("reported_branch_share",.text "1/2")],.object [("available_release_energy_mev",.text "18.35"),("products",.text "He-4 plus proton"),("reactants",.text "D-He-3")],.object [("available_release_energy_mev",.text "11.33"),("products",.text "He-4 plus two neutrons"),("reactants",.text "T-T")],.object [("available_release_energy_mev",.text "12.86"),("products",.text "He-4 plus two protons"),("reactants",.text "He-3-He-3")],.object [("available_release_energy_mev",.text "12.10"),("products",.text "He-4 plus proton plus neutron"),("reactants",.text "He-3-T"),("reported_branch_share",.text "57/100")],.object [("available_release_energy_mev",.text "14.32"),("products",.text "He-4 plus deuterium"),("reactants",.text "He-3-T"),("reported_branch_share",.text "43/100")],.object [("available_release_energy_mev",.text "22.37"),("products",.text "two He-4"),("reactants",.text "D-Li-6")],.object [("available_release_energy_mev",.text "4.02"),("products",.text "He-4 plus He-3"),("reactants",.text "proton-Li-6")],.object [("available_release_energy_mev",.text "16.87"),("products",.text "two He-4 plus proton"),("reactants",.text "He-3-Li-6")],.object [("available_release_energy_mev",.text "8.68"),("products",.text "three He-4"),("reactants",.text "proton-B-11")]]),("registered_observation",.text "The IAEA identifies D-T as the favourable reaction attaining the highest rate at a lower temperature than the listed alternatives; the alternatives require hotter and denser plasma."),("table_number",.integer 1)]),("iaea_lexfor_fission_classes",.object [("page_index",.integer 42),("registered_observation",.text "The IAEA Nuclear Data Section reference distinguishes spontaneous fission from incident-particle capture.  Its spontaneous class deforms and traverses an internal fission barrier; its capture class absorbs an incident particle before deformation."),("registered_scope",.text "This evaluated-data classification is a post-seal external comparison.  Its conventional explanatory model does not enter the Fold derivation."),("structural_correspondence",.array [.text "spontaneous internal-boundary path",.text "captured-particle trigger path"])])]),("retrieved_date",.text "2026-07-25"),("row_retention_policy",.text "Retain all 2548 AME2020 positive-composite rows, all twelve IAEA fusion table rows, all seven IAEA fission component rows, both LEXFOR fission classes, every reported total or interval, every threshold clause and every limitation."),("source_id",.text "IAEA-AMDC-FUSION-FISSION-YIELD-THRESHOLD-2026"),("sources",.array [.object [("landing_uri",.text "https://amdc.impcas.ac.cn/web/masseval.html"),("measurement_body",.text "Atomic Mass Data Center, Institute of Modern Physics, Chinese Academy of Sciences"),("raw_snapshot_hash",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("snapshot_path",.text "ame2020-mass_1.mas20"),("source_id",.text "AMDC-AME2020-MASS-1-BINDING-2021"),("source_uri",.text "https://amdc.impcas.ac.cn/masstables/Ame2020/mass_1.mas20")],.object [("measurement_body",.text "International Atomic Energy Agency"),("raw_snapshot_hash",.text "sha256:6fbe70d3943dc9d7ab1e6e9f94cb4ea81eb1431467d79bee02ce1cfaac33aa64"),("snapshot_path",.text "iaea-world-fusion-outlook-2023.pdf"),("source_id",.text "IAEA-WORLD-FUSION-OUTLOOK-2023"),("source_uri",.text "https://www-pub.iaea.org/MTCD/Publications/PDF/FusionOutlook2023_web.pdf")],.object [("measurement_body",.text "International Atomic Energy Agency"),("raw_snapshot_hash",.text "sha256:712bbd5d6ad97c16f816d0f869626ded196c0ddbeece3f7a4a3f5d00f0db059a"),("snapshot_path",.text "iaea-tecdoc-2024-nuclear-cogeneration.pdf"),("source_id",.text "IAEA-TECDOC-2024-NUCLEAR-COGENERATION"),("source_uri",.text "https://www-pub.iaea.org/MTCD/Publications/PDF/TE-2024web.pdf")],.object [("measurement_body",.text "International Atomic Energy Agency"),("raw_snapshot_hash",.text "sha256:77a0fee413c3b1d5d74a161ed9fe7f77bbcbc58a654304851b7b2b400183d022"),("snapshot_path",.text "iaea-endf-102-manual.pdf"),("source_id",.text "IAEA-ENDF-102-DATA-FORMATS-PROCEDURES"),("source_uri",.text "https://nds.iaea.org/public/endf/endf-manual.pdf")],.object [("measurement_body",.text "International Atomic Energy Agency Nuclear Data Section"),("raw_snapshot_hash",.text "sha256:d9bfc53a63fe4cf307e1ba46c952d52dcca6c95f964dd672a3acee3bb93a0297"),("snapshot_path",.text "iaea-lexfor-fission-2006.pdf"),("source_id",.text "IAEA-NDS-LEXFOR-FISSION-2006"),("source_uri",.text "https://nds.iaea.org/nrdc/nrdc_doc/iaea-nds-0208-200601.pdf")]])]
def payloadBoundary (payload : Value) : Except String Value := do
 if !sameValue ((field payload "source_id").toOption.getD .null) (.text sourceId) then throw "fusion/fission yield source-set identifier changed"
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "complete_reported_rows_retained").toOption.getD .null) (.boolean true) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "fusion/fission yield custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "fusion/fission yield custody disclosure changed"
 let sources ← match array ((field payload "sources").toOption.getD .null) with
  | .ok xs => .ok xs
  | .error _ => .error "fusion/fission authoritative source vector changed"
 if !sameValue (.array (sources.map (fun row => (field row "source_id").toOption.getD .null))) (.array (sourceIds.map Value.text)) then throw "fusion/fission authoritative source vector changed"
 let scope := (field payload "measurement_scope").toOption.getD (.object [])
 let fusion := (field scope "iaea_fusion_energy").toOption.getD (.object [])
 let fission := (field scope "iaea_fission_energy").toOption.getD (.object [])
 let fusionRows ← match array ((field fusion "reaction_rows").toOption.getD .null) with
  | .ok xs => .ok xs | .error _ => .error "complete IAEA fusion reaction table changed"
 if fusionRows.length != 12 then throw "complete IAEA fusion reaction table changed"
 let fissionRows ← match array ((field fission "component_rows").toOption.getD .null) with
  | .ok xs => .ok xs | .error _ => .error "complete IAEA fission component ledger changed"
 if fissionRows.length != 7 then throw "complete IAEA fission component ledger changed"
 let ame := (field scope "ame2020").toOption.getD (.object [])
 if !sameValue ((field ame "complete_positive_composite_row_count").toOption.getD .null) (.integer 2548) then throw "AME2020 retained-row declaration changed"
 let lex := (field scope "iaea_lexfor_fission_classes").toOption.getD (.object [])
 if !sameValue ((field lex "page_index").toOption.getD .null) (.integer 42) then throw "IAEA spontaneous/capture fission class changed"
 pure payload
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← match files.find? (fun p => Text.equal p.1 relative) with
   | none => .error (Text.append "FileNotFoundError: " relative)
   | some pair => .ok pair.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "fusion/fission yield source identity changed: " relative)
  pure ())
 payloadBoundary payload
structure BindingAnalysis where
 anchors : List Row
 fusionPer : Rat × Rat
 fissionPer : Rat × Rat
 fusionTotal : Rat × Rat
 fissionTotal : Rat × Rat
 fusionGreater : Bool
 fissionGreater : Bool
 reversedPerRejected : Bool
 reversedTotalRejected : Bool
def exactBindingMeasurementAnalysis (rows : List Row) : Except String BindingAnalysis := do
 if rows.length != 2548 then throw "binding comparison requires the complete AME2020 census"
 let d ← rowByCoordinate rows 2 1
 let h ← rowByCoordinate rows 4 2
 let u ← rowByCoordinate rows 238 92
 let p ← rowByCoordinate rows 119 46
 let fp := (← RunningConvergence.positiveTake h.lower d.upper,← RunningConvergence.positiveTake h.upper d.lower)
 let sp := (← RunningConvergence.positiveTake p.lower u.upper,← RunningConvergence.positiveTake p.upper u.lower)
 let ft := (multiply (VacuumLedgerProofs.wholeRatio 4) fp.1,multiply (VacuumLedgerProofs.wholeRatio 4) fp.2)
 let st := (multiply (VacuumLedgerProofs.wholeRatio 238) sp.1,multiply (VacuumLedgerProofs.wholeRatio 238) sp.2)
 pure ⟨[d,h,u,p],fp,sp,ft,st,sp.2.blt fp.1,ft.2.blt st.1,!fp.2.blt sp.1,!st.2.blt ft.1⟩
def bindingValue (b : BindingAnalysis) : Value := .object [("anchors",.array (b.anchors.map FusionFissionExperiment.canonicalRow)),("fusion_per_nucleon_keV",FusionFissionTerminalEvidence.gainValue b.fusionPer),("fission_per_nucleon_keV",FusionFissionTerminalEvidence.gainValue b.fissionPer),("fusion_total_keV",FusionFissionTerminalEvidence.gainValue b.fusionTotal),("fission_total_keV",FusionFissionTerminalEvidence.gainValue b.fissionTotal),("fusion_greater_per_nucleon",.boolean b.fusionGreater),("fission_greater_total",.boolean b.fissionGreater),("reversed_per_nucleon_rejected",.boolean b.reversedPerRejected),("reversed_total_rejected",.boolean b.reversedTotalRejected)]
-- Exact original Fraction string grammar (Python3.9): outer whitespace,
-- optional sign, integer ratio or decimal with optional signed exponent.
def parseMev (value : String) : Except String Rat := do
 let chars := LeptonDecimal.strip (Text.chars value)
 let (negative,chars) := match chars with
  | [] => (false,[])
  | ch::tail => if ch=='-' then (true,tail) else if ch=='+' then (false,tail) else (false,ch::tail)
 let invalid := "Invalid literal for Fraction"
 let parsed ← match LeptonDecimal.split '/' chars with
  | [numerator,denominator] => do
    let n ← (LeptonDecimal.digits numerator).elim (.error invalid) Except.ok
    let d ← (LeptonDecimal.digits denominator).elim (.error invalid) Except.ok
    if h : 0<d then pure (normalize (.ofNat n) d h) else throw "Fraction denominator is zero"
  | [decimal] => do
    let parts := LeptonDecimal.split 'e' (decimal.map (fun ch => if ch=='E' then 'e' else ch))
    let (digits,exponent) ← match parts with
     | [ds] => .ok (ds,(0:Int))
     | [ds,es] => do
       let (neg,es) := match es with
        | [] => (false,[])
        | ch::tail => if ch=='-' then (true,tail) else if ch=='+' then (false,tail) else (false,ch::tail)
       let n ← (LeptonDecimal.digits es).elim (.error invalid) Except.ok
       pure (ds,if neg then -Int.ofNat n else Int.ofNat n)
     | [] | _::_::_::_ => .error invalid
    let (n,places) ← match LeptonDecimal.split '.' digits with
     | [whole] => do pure (← (LeptonDecimal.digits whole).elim (.error invalid) Except.ok,0)
     | [whole,frac] => do pure (← (LeptonDecimal.digits (whole++frac)).elim (.error invalid) Except.ok,frac.length)
     | [] | _::_::_::_ => .error invalid
    match exponent with
     | .ofNat k => pure (normalize (.ofNat (n*10^k)) (10^places) (Nat.pow_pos (by decide)))
     | .negSucc k => pure (normalize (.ofNat n) (10^(places+k+1)) (Nat.pow_pos (by decide)))
  | [] | _::_::_::_ => .error invalid
 if negative || !zero.blt parsed then throw "reported reaction energy must remain positive"
 pure parsed
structure IaeaAnalysis where
 dtTotal : Rat
 dtPer : Rat
 fissionAverage : Rat
 fissionReleased : Rat
 fissionPerParent : Rat
 fissionPerIncident : Rat
 fusionGreater : Bool
 fissionGreater : Bool
 allPositive : Bool
 classesComplete : Bool
 trueVsEffective : Bool
 neutralScope : Bool
def iaeaMeasurementAnalysis (fusionRows : List Value) (fission threshold : Value) : Except String IaeaAnalysis := do
 if fusionRows.length != 12 then throw "IAEA analysis requires all twelve fusion reaction rows"
 let dtRows := fusionRows.filter (fun row => sameValue ((field row "reactants").toOption.getD .null) (.text "D-T"))
 let dt ← match dtRows with
  | [r] => .ok r
  | [] | _::_::_ => .error "IAEA D-T energy row is absent or duplicated"
 let dtTotal ← parseMev (← text (← field dt "available_release_energy_mev"))
 let dtPer := multiply dtTotal (normalize 1 5 (by decide))
 let average ← parseMev (← text (← field fission "reported_average_release_mev"))
 let released ← parseMev (← text (← field fission "reported_released_total_mev"))
 let perParent := multiply average (normalize 1 235 (by decide))
 let perIncident := multiply average (normalize 1 236 (by decide))
 let energies ← fusionRows.mapM (fun row => do parseMev (← text (← field row "available_release_energy_mev")))
 let endf ← field threshold "endf"
 let lex ← field threshold "lexfor"
 let charged ← field endf "charged_particle_clause"
 let identifier ← field endf "fission_reaction_identifier"
 let qvalue ← field endf "q_value_clause"
 let correspondence ← array (← field lex "structural_correspondence")
 let classes := sameValue ((field charged "reported_cross_section_bound_barn").toOption.getD .null) (.text "1/10000000000") && sameValue ((field charged "page_index").toOption.getD .null) (.integer 118) && sameValue ((field identifier "page_index").toOption.getD .null) (.integer 120) && sameValue ((field qvalue "page_index").toOption.getD .null) (.integer 118) && sameValue ((field lex "page_index").toOption.getD .null) (.integer 42) && sameValue (.array correspondence) (.array [.text "spontaneous internal-boundary path",.text "captured-particle trigger path"])
 let observation ← text (← field charged "registered_observation")
 let neutral ← text (← field identifier "registered_observation")
 pure ⟨dtTotal,dtPer,average,released,perParent,perIncident,perParent.blt dtPer && perIncident.blt dtPer,dtTotal.blt average && dtTotal.blt released,energies.all zero.blt,classes,Text.contains observation "true kinematic threshold" && Text.contains observation "effective threshold",Text.contains neutral "neutral incident class" && Text.contains neutral "without asserting that every fission channel is non-threshold"⟩
def iaeaValue (i : IaeaAnalysis) : Value := .object [("dt_total_mev",FusionFissionTerminalEvidence.fractionValue i.dtTotal),("dt_per_incident_nucleon_mev",FusionFissionTerminalEvidence.fractionValue i.dtPer),("u235_average_total_mev",FusionFissionTerminalEvidence.fractionValue i.fissionAverage),("u235_released_total_mev",FusionFissionTerminalEvidence.fractionValue i.fissionReleased),("u235_per_parent_nucleon_mev",FusionFissionTerminalEvidence.fractionValue i.fissionPerParent),("u235_per_incident_nucleon_mev",FusionFissionTerminalEvidence.fractionValue i.fissionPerIncident),("fusion_greater_per_nucleon",.boolean i.fusionGreater),("fission_greater_total",.boolean i.fissionGreater),("all_fusion_rows_positive",.boolean i.allPositive),("threshold_classes_complete",.boolean i.classesComplete),("charged_clause_retains_true_vs_effective_threshold",.boolean i.trueVsEffective),("neutral_fission_scope_retained",.boolean i.neutralScope)]
theorem originalRecord : payloadBoundary registeredRecord = .ok registeredRecord := rfl
end SFT.Physics.YieldThresholdMeasurement
