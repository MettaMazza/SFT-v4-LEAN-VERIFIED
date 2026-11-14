import SFT.Physics.YieldThresholdMeasurement
namespace SFT.Physics.DeuteronMeasurement
open SFT.Host SFT.Host.Canonical LeptonIntervals RunningConvergenceMeasurement NuclearBindingMeasuredRows
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourceId : String := "AMDC-NIST-IAEA-DEUTERON-DINUCLEON-2026"
def sourcePath : String := "experiments/external_sources/physics/snapshots/deuteron-dinucleon-terminal-source-record.json"
def sourceHash : String := "sha256:b54be2810599c91e9e4ab7839d8cb4ac84eae6caf5f5aea1b2cb3c3562d5ba7d"
def sourceIds : List String := ["AMDC-AME2020-MASS-1-2021", "AMDC-NUBASE2020-2021", "NIST-CODATA-2022", "IAEA-NDS-JENDL1-INDC-JAP-45", "IAEA-THEORY-NUCLEAR-STRUCTURE-STI-PUB-249"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20","sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("experiments/external_sources/physics/snapshots/deuteron-dinucleon-terminal-source-record.json","sha256:b54be2810599c91e9e4ab7839d8cb4ac84eae6caf5f5aea1b2cb3c3562d5ba7d"),("experiments/external_sources/physics/snapshots/iaea-jendl-np-data.pdf","sha256:f504aca94fab528cc9ddcdfbdad79b7390fd2ba955642ed755c9b774f341ad76"),("experiments/external_sources/physics/snapshots/iaea-nuclear-theory.pdf","sha256:74f7d06bc8b3c6ba719f5b6afb2e0a39fe9bf521f3b7a11bcafb666f1fe1761c"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/nubase2020-nubase_4.mas20","sha256:1585a5eea86c5e17e90307c7e6e786d060049c4039e392a261ff6db977df9859")]
def registeredRecord : Value := .object [("custody",.object [("complete_reported_rows_retained",.boolean true),("development_targets_already_known",.boolean true),("empirical_prediction_protocol",.boolean true),("engine_prediction_sealed_before_target_release_within_run",.boolean true),("formal_relations_contain_measurement",.boolean false),("measurements_select_formal_survivors",.boolean false),("protocol_classification",.text "observational-data-informed_target-inaccessible_sealed-prediction"),("target_inaccessible_during_prediction_execution",.boolean true)]),("measurement_scope",.object [("amdc_ame2020",.object [("a2_coordinate_count",.integer 1),("a2_coordinates",.array [.object [("binding_energy_per_nucleon_keV",.text "1112.2831"),("binding_energy_per_nucleon_standard_uncertainty_keV",.text "0.0002"),("charge_count",.integer 1),("mass_number",.integer 2),("neutron_count",.integer 1),("nuclide",.text "2H")]]),("complete_numeric_coordinate_row_count",.integer 3558),("interpretation_boundary",.text "The complete evaluated mass table contains one A=2 coordinate. Absence of other A=2 coordinates is an external census result, not a formal derivation input.")]),("amdc_nubase2020",.object [("a2_state_count",.integer 1),("a2_states",.array [.object [("atomic_number",.integer 1),("direct_measurement_marker",.text "*"),("half_life_inscription",.text "stbl"),("mass_number",.integer 2),("nuclide",.text "2H"),("spin_parity",.text "1+")]]),("complete_state_row_count",.integer 5843),("format_note",.text "NUBASE2020 columns 89:102 mark directly measured spin/parity with an asterisk."),("interpretation_boundary",.text "The complete evaluated state table contains one A=2 state. It supplies the external bound-nuclide census and directly measured deuteron spin/parity after the formal seal.")]),("iaea_jendl1",.object [("deuteron_binding_energy_MeV",.text "2.225"),("pdf_page_index",.integer 25),("printed_page",.integer 19),("reported_parameter_sets",.array [.object [("effective_range_singlet_fm",.text "2.76"),("effective_range_singlet_standard_uncertainty_fm",.text "0.05"),("effective_range_triplet_fm",.text "1.750"),("effective_range_triplet_standard_uncertainty_fm",.text "0.005"),("scattering_length_singlet_fm",.text "-23.719"),("scattering_length_singlet_standard_uncertainty_fm",.text "0.013"),("scattering_length_triplet_fm",.text "5.414"),("scattering_length_triplet_standard_uncertainty_fm",.text "0.005"),("source",.text "Lomon and Wilson")],.object [("effective_range_singlet_fm",.text "2.81"),("effective_range_singlet_standard_uncertainty_fm",.text "0.05"),("effective_range_triplet_fm",.text "1.760"),("effective_range_triplet_standard_uncertainty_fm",.text "0.005"),("scattering_length_singlet_fm",.text "-23.749"),("scattering_length_singlet_standard_uncertainty_fm",.text "0.009"),("scattering_length_triplet_fm",.text "5.423"),("scattering_length_triplet_standard_uncertainty_fm",.text "0.004"),("source",.text "Dilg")]]),("retained_scope",.text "The complete printed singlet/triplet scattering-length and effective-range table is retained. Signed dimensional inscriptions remain external records and never enter the positive formal proof domain.")]),("iaea_nuclear_theory",.object [("pdf_page_index",.integer 35),("printed_page",.integer 25),("registered_observations",.array [.text "Nuclear forces are spin-dependent.",.text "The neutron-proton system has a bound state, the deuteron.",.text "The neutron and proton spins in the deuteron are correlated and parallel.",.text "Only the triplet cross section is related to deuteron properties.",.text "Experimentally determined singlet and triplet zero-energy cross sections differ by almost one order of magnitude."]),("reported_cross_section_context",.object [("deuteron-only_parameter_range_upper_mb",.text "9.32"),("deuteron-only_parameter_range_lower_mb",.text "2.33"),("experimental_zero_energy_np_cross_section_mb",.text "20.36"),("experimental_zero_energy_np_cross_section_standard_uncertainty_mb",.text "0.10"),("singlet_weight",.text "1/4"),("triplet_weight",.text "3/4")])]),("nist_codata2022",.object [("reported_mass_energy_equivalents_MeV",.array [.object [("quantity",.text "proton mass energy equivalent in MeV"),("standard_uncertainty_MeV",.text "0.00000029"),("value_MeV",.text "938.27208943")],.object [("quantity",.text "neutron mass energy equivalent in MeV"),("standard_uncertainty_MeV",.text "0.00000048"),("value_MeV",.text "939.56542194")],.object [("quantity",.text "deuteron mass energy equivalent in MeV"),("standard_uncertainty_MeV",.text "0.00000058"),("value_MeV",.text "1875.61294500")]]),("relation_boundary",.text "The sealed mass-energy conservation relation is evaluated after release as proton plus neutron mass-energy support taking the bound deuteron support.")])]),("retrieval_date",.text "2026-07-25"),("schema",.text "sft-v3-deuteron-dinucleon-source-record/1"),("source_id",.text "AMDC-NIST-IAEA-DEUTERON-DINUCLEON-2026"),("sources",.array [.object [("measurement_body",.text "Atomic Mass Data Center"),("snapshot_hash",.text "sha256:e8599c6d7f724fac91934e59f1b9de8fb8f63e820f4b39456b790665ed2a3307"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/ame2020-mass_1.mas20"),("source_id",.text "AMDC-AME2020-MASS-1-2021"),("source_uri",.text "https://amdc.impcas.ac.cn/masstables/Ame2020/filel.html")],.object [("measurement_body",.text "Atomic Mass Data Center"),("snapshot_hash",.text "sha256:1585a5eea86c5e17e90307c7e6e786d060049c4039e392a261ff6db977df9859"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nubase2020-nubase_4.mas20"),("source_id",.text "AMDC-NUBASE2020-2021"),("source_uri",.text "https://amdc.impcas.ac.cn/web/nubase_en.html")],.object [("measurement_body",.text "National Institute of Standards and Technology"),("snapshot_hash",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"),("source_id",.text "NIST-CODATA-2022"),("source_uri",.text "https://physics.nist.gov/cuu/Constants/index.html")],.object [("measurement_body",.text "International Atomic Energy Agency Nuclear Data Section"),("snapshot_hash",.text "sha256:f504aca94fab528cc9ddcdfbdad79b7390fd2ba955642ed755c9b774f341ad76"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/iaea-jendl-np-data.pdf"),("source_id",.text "IAEA-NDS-JENDL1-INDC-JAP-45"),("source_uri",.text "https://nds.iaea.org/records/c44qg-nyz17")],.object [("measurement_body",.text "International Atomic Energy Agency"),("snapshot_hash",.text "sha256:74f7d06bc8b3c6ba719f5b6afb2e0a39fe9bf521f3b7a11bcafb666f1fe1761c"),("snapshot_path",.text "experiments/external_sources/physics/snapshots/iaea-nuclear-theory.pdf"),("source_id",.text "IAEA-THEORY-NUCLEAR-STRUCTURE-STI-PUB-249"),("source_uri",.text "https://nds.iaea.org/records/qj1ka-8rt63")]])]
def payloadBoundary (payload : Value) : Except String Value := do
 if !sameValue ((field payload "source_id").toOption.getD .null) (.text sourceId) then throw "deuteron source-set identifier changed"
 let custody := (field payload "custody").toOption.getD (.object [])
 if !sameValue ((field custody "complete_reported_rows_retained").toOption.getD .null) (.boolean true) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "development_targets_already_known").toOption.getD .null) (.boolean true) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "empirical_prediction_protocol").toOption.getD .null) (.boolean true) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "engine_prediction_sealed_before_target_release_within_run").toOption.getD .null) (.boolean true) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "formal_relations_contain_measurement").toOption.getD .null) (.boolean false) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "measurements_select_formal_survivors").toOption.getD .null) (.boolean false) then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "protocol_classification").toOption.getD .null) (.text "observational-data-informed_target-inaccessible_sealed-prediction") then throw "deuteron target custody disclosure changed"
 if !sameValue ((field custody "target_inaccessible_during_prediction_execution").toOption.getD .null) (.boolean true) then throw "deuteron target custody disclosure changed"
 let sources ← match array ((field payload "sources").toOption.getD .null) with
  | .ok xs => .ok xs
  | .error _ => .error "deuteron authoritative source vector changed"
 if !sameValue (.array (sources.map (fun row => (field row "source_id").toOption.getD .null))) (.array (sourceIds.map Value.text)) then throw "deuteron authoritative source vector changed"
 let scope := (field payload "measurement_scope").toOption.getD (.object [])
 let ame := (field scope "amdc_ame2020").toOption.getD (.object [])
 let nubase := (field scope "amdc_nubase2020").toOption.getD (.object [])
 let jendl := (field scope "iaea_jendl1").toOption.getD (.object [])
 let theory := (field scope "iaea_nuclear_theory").toOption.getD (.object [])
 if !sameValue ((field ame "complete_numeric_coordinate_row_count").toOption.getD .null) (.integer 3558) then throw "AME2020 complete coordinate declaration changed"
 if !sameValue ((field nubase "complete_state_row_count").toOption.getD .null) (.integer 5843) then throw "NUBASE2020 complete state declaration changed"
 if !sameValue ((field jendl "pdf_page_index").toOption.getD .null) (.integer 25) then throw "IAEA JENDL page registration changed"
 if !sameValue ((field theory "pdf_page_index").toOption.getD .null) (.integer 35) then throw "IAEA spin-dependence page registration changed"
 pure payload
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← match files.find? (fun p => Text.equal p.1 relative) with
   | none => .error (Text.append "FileNotFoundError: " relative)
   | some pair => .ok pair.2
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "deuteron source identity changed: " relative)
  pure ())
 payloadBoundary payload
def fraction (value : String) : Except String Rat := do
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
 pure (if negative then normalize (-parsed.num) parsed.den (Nat.pos_of_ne_zero parsed.den_nz) else parsed)
def rawLines (files : List (String × ByteArray)) (path : String) : Except String (List String) := do
 let bytes ← match files.find? (fun p => Text.equal p.1 path) with
  | none => .error (Text.append "FileNotFoundError: " path)
  | some p => .ok p.2
 pure ((LeptonDecimal.split '\n' (Text.decode bytes.size bytes.data.toList)).map String.ofList)
def integerSegment (line : String) (start stop : Nat) : Except String Int :=
 match LeptonDecimal.exponent (segment (Text.chars line) start stop) with
 | some n => .ok n | none => .error "invalid literal for int"
def textSegment (line : String) (start stop : Nat) : String := String.ofList (segment (Text.chars line) start stop)
def ameNumericCoordinateRows (files : List (String × ByteArray)) (record : Value) : Except String (List String) := do
 let _ ← authoritativeRecord files record
 let lines ← rawLines files NuclearBindingRecords.rawPath
 let rows := lines.filter (fun line => (Text.chars line).length≥79 && (integerSegment line 4 9).isOk && (integerSegment line 9 14).isOk && (integerSegment line 14 19).isOk)
 if rows.length != 3558 then throw "complete AME2020 coordinate census changed"
 pure rows
def nubaseStateRows (files : List (String × ByteArray)) (record : Value) : Except String (List String) := do
 let _ ← authoritativeRecord files record
 let lines ← rawLines files "experiments/external_sources/physics/snapshots/nubase2020-nubase_4.mas20"
 let rows := lines.filter (fun line => !line.isEmpty && (Text.chars line).head? != some '#')
 if rows.length != 5843 then throw "complete NUBASE2020 state census changed"
 pure rows
def codataMassEnergyRows (files : List (String × ByteArray)) : Except String (List String) := do
 let lines ← rawLines files "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
 let prefixes := ["proton mass energy equivalent in MeV","neutron mass energy equivalent in MeV","deuteron mass energy equivalent in MeV"]
 let rows ← prefixes.mapM (fun labelStart => match lines.find? (fun line => (Text.chars line).take (Text.chars labelStart).length == Text.chars labelStart) with
  | some row => .ok row | none => .error "StopIteration")
 if rows.length != 3 || (rows.map (fun row => row.toUTF8.data.toList.map UInt8.toNat)).eraseDups.length != 3 then throw "NIST CODATA mass-energy vector changed"
 pure rows
structure CodataRow where
 name : String
 value : Rat
 uncertainty : Rat
 unit : String
def parseCodataRow (line : String) : Except String CodataRow := do
 let value ← fraction (String.ofList ((segment (Text.chars line) 60 85).filter (fun c => c != ' ')))
 let uncertainty ← fraction (String.ofList ((segment (Text.chars line) 85 110).filter (fun c => c != ' ')))
 let unit := String.ofList (LeptonDecimal.strip ((Text.chars line).drop 110))
 if !uncertainty.blt value || !zero.blt uncertainty || !Text.equal unit "MeV" then throw "CODATA row left its exact positive interval"
 pure ⟨textSegment line 0 60,value,uncertainty,unit⟩
structure CodataAnalysis where
 proton : Rat × Rat
 neutron : Rat × Rat
 deuteron : Rat × Rat
 binding : Rat × Rat
 central : Rat
def codataBindingInterval (rows : List String) : Except String CodataAnalysis := do
 let parsed ← rows.mapM parseCodataRow
 -- Python mapping assignment retains the last matching row.
 let get := fun name => match parsed.reverse.find? (fun row => Text.equal row.name name) with
  | some row => Except.ok row | none => .error "KeyError"
 let p ← get "proton mass energy equivalent in MeV"
 let n ← get "neutron mass energy equivalent in MeV"
 let d ← get "deuteron mass energy equivalent in MeV"
 let pi := (← RunningConvergence.positiveTake p.value p.uncertainty,add p.value p.uncertainty)
 let ni := (← RunningConvergence.positiveTake n.value n.uncertainty,add n.value n.uncertainty)
 let di := (← RunningConvergence.positiveTake d.value d.uncertainty,add d.value d.uncertainty)
 let lower ← RunningConvergence.positiveTake (add pi.1 ni.1) di.2
 let upper ← RunningConvergence.positiveTake (add pi.2 ni.2) di.1
 if !lower.blt upper then throw "CODATA deuteron binding enclosure failed"
 pure ⟨pi,ni,di,(lower,upper),subtract (add p.value n.value) d.value⟩
structure AmeAnalysis where
 coordinateCount : Nat
 a2Count : Nat
 charge : Int
 neutron : Int
 bindingPer : Rat
 uncertaintyPer : Rat
 central : Rat
 uncertainty : Rat
 interval : Rat × Rat
def ameA2Analysis (rows : List String) : Except String AmeAnalysis := do
 let parsed ← rows.mapM (fun row => do pure (row,← integerSegment row 14 19))
 let a2 := (parsed.filter (fun p => @decide (p.2=2) (Int.decEq _ _))).map Prod.fst
 let line ← match a2 with
  | [line] => .ok line | [] | _::_::_ => .error "AME2020 A=2 coordinate census changed"
 let charge ← integerSegment line 9 14
 let neutron ← integerSegment line 4 9
 let binding ← fraction (textSegment line 54 67)
 let uncertainty ← fraction (textSegment line 68 78)
 let _ ← RunningConvergence.positiveTake binding uncertainty
 let total := multiply (VacuumLedgerProofs.wholeRatio 2) binding
 let totalUncertainty := multiply (VacuumLedgerProofs.wholeRatio 2) uncertainty
 let lower ← RunningConvergence.positiveTake total totalUncertainty
 let upper := add total totalUncertainty
 let scale := normalize 1 1000 (by decide)
 pure ⟨rows.length,a2.length,charge,neutron,binding,uncertainty,total,totalUncertainty,(multiply lower scale,multiply upper scale)⟩
structure NubaseAnalysis where
 stateCount : Nat
 a2Count : Nat
 atomicNumber : Int
 nuclide : String
 halfLife : String
 spinParity : String
 measuredSpin : Bool
 stable : Bool
def nubaseA2Analysis (rows : List String) : Except String NubaseAnalysis := do
 let parsed ← rows.mapM (fun row => do pure (row,← integerSegment row 0 3))
 let a2 := (parsed.filter (fun p => @decide (p.2=2) (Int.decEq _ _))).map Prod.fst
 let line ← match a2 with
  | [line] => .ok line | [] | _::_::_ => .error "NUBASE2020 A=2 state census changed"
 let spin := textSegment line 88 102
 let life := textSegment line 69 80
 pure ⟨rows.length,a2.length,← integerSegment line 4 7,textSegment line 11 16,life,spin,Text.equal spin "1+*",Text.equal life "stbl"⟩
structure IaeaAnalysis where
 parameterCount : Nat
 bindingEnergy : Rat
 signsSeparated : Bool
 uncertaintiesPositive : Bool
 observationsComplete : Bool
 parallelBound : Bool
 weights : Rat × Rat
 crossSectionInterval : Rat × Rat
 deuteronRange : Rat × Rat
 crossSectionAbove : Bool
def iaeaAnalysis (record : Value) : Except String IaeaAnalysis := do
 let scope ← field record "measurement_scope"
 let jendl ← field scope "iaea_jendl1"
 let theory ← field scope "iaea_nuclear_theory"
 let parameters ← array (← field jendl "reported_parameter_sets")
 if parameters.length != 2 then throw "complete IAEA parameter table changed"
 let signs ← parameters.mapM (fun row => do
  let singlet ← fraction (← text (← field row "scattering_length_singlet_fm"))
  let triplet ← fraction (← text (← field row "scattering_length_triplet_fm"))
  pure (singlet.blt zero && zero.blt triplet))
 let observations ← array (← field theory "registered_observations")
 let expected : List String := ["Nuclear forces are spin-dependent.", "The neutron-proton system has a bound state, the deuteron.", "The neutron and proton spins in the deuteron are correlated and parallel.", "Only the triplet cross section is related to deuteron properties.", "Experimentally determined singlet and triplet zero-energy cross sections differ by almost one order of magnitude."]
 let context ← field theory "reported_cross_section_context"
 let experimental ← fraction (← text (← field context "experimental_zero_energy_np_cross_section_mb"))
 let uncertainty ← fraction (← text (← field context "experimental_zero_energy_np_cross_section_standard_uncertainty_mb"))
 let lower ← RunningConvergence.positiveTake experimental uncertainty
 let binding ← fraction (← text (← field jendl "deuteron_binding_energy_MeV"))
 let uncertainties ← parameters.mapM (fun row => do
  let s ← fraction (← text (← field row "effective_range_singlet_standard_uncertainty_fm"))
  let t ← fraction (← text (← field row "effective_range_triplet_standard_uncertainty_fm"))
  pure (zero.blt s && zero.blt t))
 let sw ← fraction (← text (← field context "singlet_weight"))
 let tw ← fraction (← text (← field context "triplet_weight"))
 let dl ← fraction (← text (← field context "deuteron-only_parameter_range_lower_mb"))
 let du ← fraction (← text (← field context "deuteron-only_parameter_range_upper_mb"))
 let parallel := observations.any (fun v => sameValue v (.text "The neutron-proton system has a bound state, the deuteron.")) && observations.any (fun v => sameValue v (.text "The neutron and proton spins in the deuteron are correlated and parallel."))
 pure ⟨parameters.length,binding,signs.all id,uncertainties.all id,sameValue (.array observations) (.array (expected.map Value.text)),parallel,(sw,tw),(lower,add experimental uncertainty),(dl,du),du.blt lower⟩
def codataValue (x : CodataAnalysis) : Value := .object [("proton_interval_MeV",FusionFissionTerminalEvidence.gainValue x.proton),("neutron_interval_MeV",FusionFissionTerminalEvidence.gainValue x.neutron),("deuteron_interval_MeV",FusionFissionTerminalEvidence.gainValue x.deuteron),("binding_interval_MeV",FusionFissionTerminalEvidence.gainValue x.binding),("binding_central_MeV",FusionFissionTerminalEvidence.fractionValue x.central)]
def ameValue (x : AmeAnalysis) : Value := .object [("complete_coordinate_count",.integer (.ofNat x.coordinateCount)),("a2_coordinate_count",.integer (.ofNat x.a2Count)),("a2_charge_count",.integer x.charge),("a2_neutron_count",.integer x.neutron),("binding_per_nucleon_keV",FusionFissionTerminalEvidence.fractionValue x.bindingPer),("binding_per_nucleon_standard_uncertainty_keV",FusionFissionTerminalEvidence.fractionValue x.uncertaintyPer),("total_binding_central_keV",FusionFissionTerminalEvidence.fractionValue x.central),("total_binding_standard_uncertainty_keV",FusionFissionTerminalEvidence.fractionValue x.uncertainty),("total_binding_interval_MeV",FusionFissionTerminalEvidence.gainValue x.interval)]
def nubaseValue (x : NubaseAnalysis) : Value := .object [("complete_state_count",.integer (.ofNat x.stateCount)),("a2_state_count",.integer (.ofNat x.a2Count)),("a2_atomic_number",.integer x.atomicNumber),("a2_nuclide",.text x.nuclide),("a2_half_life",.text x.halfLife),("a2_spin_parity_inscription",.text x.spinParity),("directly_measured_spin_one_positive_parity",.boolean x.measuredSpin),("stable_inscription_retained",.boolean x.stable)]
def iaeaValue (x : IaeaAnalysis) : Value := .object [("jendl_parameter_set_count",.integer (.ofNat x.parameterCount)),("jendl_binding_energy_MeV",FusionFissionTerminalEvidence.fractionValue x.bindingEnergy),("all_singlet_triplet_rows_sign_separated",.boolean x.signsSeparated),("all_effective_range_uncertainties_positive",.boolean x.uncertaintiesPositive),("spin_dependence_observations_complete",.boolean x.observationsComplete),("parallel_bound_deuteron_recorded",.boolean x.parallelBound),("singlet_triplet_weights",FusionFissionTerminalEvidence.gainValue x.weights),("experimental_cross_section_interval_mb",FusionFissionTerminalEvidence.gainValue x.crossSectionInterval),("reported_deuteron_only_range_mb",FusionFissionTerminalEvidence.gainValue x.deuteronRange),("experimental_cross_section_above_deuteron_only_range",.boolean x.crossSectionAbove)]
def exactMeasurementAnalysis (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let record ← authoritativeRecord files payload
 let a ← ameA2Analysis (← ameNumericCoordinateRows files payload)
 let n ← nubaseA2Analysis (← nubaseStateRows files payload)
 let c ← codataBindingInterval (← codataMassEnergyRows files)
 let i ← iaeaAnalysis record
 let lower := if c.binding.1.blt a.interval.1 then a.interval.1 else c.binding.1
 let upper := if c.binding.2.blt a.interval.2 then c.binding.2 else a.interval.2
 let overlap := !upper.blt lower
 let inventory := a.a2Count==1 && @decide (a.charge=1) (Int.decEq _ _) && @decide (a.neutron=1) (Int.decEq _ _) && n.a2Count==1 && @decide (n.atomicNumber=1) (Int.decEq _ _)
 pure (.object [("ame",ameValue a),("nubase",nubaseValue n),("codata",codataValue c),("iaea",iaeaValue i),("codata_ame_binding_intervals_overlap",.boolean overlap),("complete_a2_inventory_is_deuteron_only",.boolean inventory),("reversed_identical_pair_binding_control_rejected",.boolean (n.a2Count==1 && a.a2Count==1))])
theorem originalRecord : payloadBoundary registeredRecord = .ok registeredRecord := rfl
end SFT.Physics.DeuteronMeasurement
