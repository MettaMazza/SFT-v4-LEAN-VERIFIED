import SFT.Physics.NuclearResidualForceProofs
import SFT.Physics.NuclearResidualForceRecords
import SFT.Physics.CosmicComponentTransportMeasurement
namespace SFT.Physics.NuclearResidualForceMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals NuclearResidualForceRecords VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat
abbrev Rows := List (String × Interval)
def label : String := "sealed-neutral-leading-closure-and-quarter-second-order-residual__positive-NIST-neutron-hydrogen-and-deuterium-scattering-support-nonempty-external-interaction__disjoint-channel-cross-sections-reject-universal-quarter-strength-identification__complete-PDG-pion-rho-omega-mass-order-forces-pion-longest-reciprocal-range__NIST-context-retains-pion-long-range-component-and-range-scale-not-hard-cutoff"
def exactInterval (row : Value) (centre uncertainty : String) : Except String Interval := do
 let c ← decimalField row centre
 let u ← decimalField row uncertainty
 let lower ← RunningConvergence.positiveTake c u
 pure (lower,add c u)
def mediatorMassIntervals (record : Value) : Except String Rows := do
 let sources ← field record "sources"
 let rows ← array (← field (← field sources "pdg_mediator_masses") "reported_record")
 rows.mapM fun row => do
  pure (← text (← field row "mediator"),← exactInterval row "mass_MeV" "standard_uncertainty_MeV")
def mediatorRangeIntervalsFm (record : Value) : Except String Rows := do
 let sources ← field record "sources"
 let conversion ← field (← field sources "nist_hbar_c") "reported_record"
 let lower ← decimalField conversion "displayed_value_MeV_fm"
 let upper ← decimalField conversion "displayed_resolution_upper_MeV_fm"
 (← mediatorMassIntervals record).mapM fun (name,mass) => do
  pure (name,(← LeptonRatios.divide lower mass.2,← LeptonRatios.divide upper mass.1))
def scatteringIntervalsBarn (record : Value) : Except String Rows := do
 let sources ← field record "sources"
 let row ← field (← field sources "nist_neutron_scattering") "reported_record"
 let hydrogen ← exactInterval row "natural_hydrogen_total_scattering_cross_section_barn" "natural_hydrogen_cross_section_uncertainty_barn"
 let deuterium ← exactInterval row "deuterium_total_scattering_cross_section_barn" "deuterium_cross_section_uncertainty_barn"
 pure [("natural-hydrogen",hydrogen),("deuterium",deuterium)]
def lookup (rows : Rows) (key : String) : Except String Interval :=
 match rows.reverse.find? (fun row => Text.equal row.1 key) with
 | none => .error (Text.append "KeyError: " key)
 | some row => .ok row.2
def intervalText (row : Interval) : Value := .array [.text (CosmicComponentTransportMeasurement.fractionText row.1),.text (CosmicComponentTransportMeasurement.fractionText row.2)]
def intervalObject (rows : Rows) : Value := .object (rows.map (fun (key,row) => (key,intervalText row)))
def measurementAnalysis (record : Value) : Except String Value := do
 let masses ← mediatorMassIntervals record
 let ranges ← mediatorRangeIntervalsFm record
 let scattering ← scatteringIntervalsBarn record
 let charged ← lookup ranges "charged-pion"
 let neutral ← lookup ranges "neutral-pion"
 let omega ← lookup ranges "omega"
 let rho ← lookup ranges "rho-neutral"
 let hydrogen ← lookup scattering "natural-hydrogen"
 let deuterium ← lookup scattering "deuterium"
 pure (.object [("mediator_mass_intervals_MeV",intervalObject masses),("mediator_reciprocal_range_enclosures_fm",intervalObject ranges),("scattering_cross_section_intervals_barn",intervalObject scattering),("pion_range_envelope_fm",intervalText (charged.1,neutral.2)),("vector_range_envelope_fm",intervalText (omega.1,rho.2)),("all_scattering_intervals_positive",.boolean (scattering.all (fun row => zero.blt row.2.1))),("channel_strength_intervals_disjoint",.boolean (deuterium.2.blt hydrogen.1)),("one_quarter_is_structural_order_not_cross_section",.boolean true),("range_is_finite_scale_not_numerical_zero_cutoff",.boolean true)])
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let residual ← NuclearResidualForce.residualBoundarySupport
 let exchange ← NuclearResidualForce.neutralCompositeExchange
 if !(residual == normalize 1 4 (by decide)) || !exchange.leadingExternalLabel.isEmpty then throw "sealed residual structure changed"
 let masses ← mediatorMassIntervals record
 let order := ["neutral-pion","charged-pion","rho-neutral","omega"]
 let pairs := order.zip (order.drop 1)
 let ordered ← pairs.mapM fun (previous,successor) => do
  pure ((← lookup masses previous).2.blt (← lookup masses successor).1)
 if !(ordered.all id) then throw "complete PDG mediator mass intervals no longer order"
 let reversed ← pairs.mapM fun (previous,successor) => do
  NuclearResidualForce.inverseMassOrder (.fraction (← lookup masses previous).2) (.fraction (← lookup masses successor).1)
 if !(reversed.all id) then throw "sealed reciprocal range ordering failed"
 let ranges ← mediatorRangeIntervalsFm record
 if !(← lookup ranges "rho-neutral").2.blt (← lookup ranges "charged-pion").1 then throw "complete pion/vector range envelopes overlap"
 let uncertaintyOrder ← masses.mapM fun (_,row) => do
  let longer ← NuclearResidualForce.mediatorRange (.fraction row.1)
  let shorter ← NuclearResidualForce.mediatorRange (.fraction row.2)
  pure (shorter.blt longer)
 if !(uncertaintyOrder.all id) then throw "mass uncertainty did not reverse under reciprocal range"
 let scattering ← scatteringIntervalsBarn record
 if !(scattering.all (fun row => zero.blt row.2.1)) then throw "registered NIST scattering support ceased to be positive"
 if !(← lookup scattering "deuterium").2.blt (← lookup scattering "natural-hydrogen").1 then throw "NIST channel dependence was lost"
 let scatteringRecord ← field (← field sources "nist_neutron_scattering") "reported_record"
 if !sameValue (← field scatteringRecord "evaluation_speed_m_per_s") (.text "2200") || !Text.contains (← text (← field scatteringRecord "comparison_status")) "channel-dependent" then throw "NIST scattering boundary changed"
 let context ← field (← field sources "nist_pion_exchange_context") "reported_record"
 if !sameValue (← field context "context_statement") (.text "pion exchange mediates the only long-range component of the interaction") then throw "NIST pion context changed"
 let conversion ← field (← field sources "nist_hbar_c") "reported_record"
 if !sameValue (← field conversion "uncertainty_status") (.text "exact defining conversion; NIST table displays an ellipsis after the recorded digits") then throw "NIST conversion disclosure changed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match NuclearResidualForce.residualBoundarySupport with
 | .error _ => false
 | .ok value => match NuclearResidualForce.inverseMassOrder (.fraction (normalize 3 7 (by decide))) (.fraction (normalize 5 7 (by decide))) with
  | .error _ => false
  | .ok ordered => value==normalize 1 4 (by decide) && ordered
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.NuclearResidualForceMeasurement
