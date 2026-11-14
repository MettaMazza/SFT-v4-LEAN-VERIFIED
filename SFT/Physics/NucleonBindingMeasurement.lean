import SFT.Physics.NucleonBindingRoots
import SFT.Physics.NucleonBindingRecords
namespace SFT.Physics.NucleonBindingMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals NucleonBindingRecords VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat
def label : String := "sealed-three-colour-uud-udd-singlet-correspondence-passes-PDG__structural-one-over-128-and-PDG-uud-current-share-both-below-one-percent__nonidentity-of-those-two-objects-retained__held-residuals-above-99-percent__down-up-and-neutron-proton-ordering-pass-complete-PDG-NIST-intervals"
def exactInterval (row : Value) (centre uncertainty : String) : Except String Interval := do
 let c ← decimalField row centre
 let u ← decimalField row uncertainty
 let lower ← RunningConvergence.positiveTake c u
 pure (lower,add c u)
structure Intervals where
 up : Interval
 down : Interval
 proton : Interval
 neutron : Interval
 difference : Interval
def externalIntervals (record : Value) : Except String Intervals := do
 let sources ← field record "sources"
 let q ← field (← field sources "pdg_light_quark_masses") "reported_record"
 let n ← field (← field sources "nist_nucleon_masses") "reported_record"
 let up ← exactInterval q "up_mass_MeV" "up_total_uncertainty_MeV"
 let down ← exactInterval q "down_mass_MeV" "down_total_uncertainty_MeV"
 let proton ← exactInterval n "proton_mass_energy_MeV" "proton_standard_uncertainty_MeV"
 let neutron ← exactInterval n "neutron_mass_energy_MeV" "neutron_standard_uncertainty_MeV"
 let difference ← exactInterval n "neutron_proton_difference_MeV" "difference_standard_uncertainty_MeV"
 pure ⟨up,down,proton,neutron,difference⟩
def binaryTimes (value : Rat) : Rat := add value value
def uudCurrentMassFractionInterval (record : Value) : Except String Interval := do
 let rows ← externalIntervals record
 let lower ← LeptonRatios.divide (add (binaryTimes rows.up.1) rows.down.1) rows.proton.2
 let upper ← LeptonRatios.divide (add (binaryTimes rows.up.2) rows.down.2) rows.proton.1
 pure (lower,upper)
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let model ← field (← field sources "pdg_quark_model") "reported_record"
 if !sameValue (← field model "colour_count") (.integer 3) || !sameValue (← field model "minimal_baryon_constituent_count") (.integer 3) || !sameValue (← field model "baryon_class") (.text "qqq") then
  throw "PDG baryon composition correspondence changed"
 if !sameValue (← field model "physical_state_class") (.text "colour singlet") || !sameValue (← field model "up_charge") (.text "positive 2/3") || !sameValue (← field model "down_charge") (.text "opposed 1/3") then
  throw "PDG colour/charge correspondence changed"
 let quarks ← field (← field sources "pdg_light_quark_masses") "reported_record"
 if !sameValue (← field quarks "scheme") (.text "MSbar") || !sameValue (← field quarks "scale_GeV") (.text "2") || !sameValue (← field quarks "active_flavour_theory") (.text "NL=4") then
  throw "PDG quark scheme/scale boundary changed"
 let rows ← externalIntervals record
 if !rows.up.2.blt rows.down.1 then throw "complete PDG down/up intervals no longer order"
 let current ← uudCurrentMassFractionInterval record
 let ledger ← NucleonBinding.nucleonMassLedger
 if !current.2.blt (normalize 1 100 (by decide)) then
  throw "complete PDG uud current-mass fraction is not below one percent"
 let held ← RunningConvergence.positiveTake (wholeRatio 1) current.2
 if !(normalize 99 100 (by decide)).blt held then
  throw "complete measured residual is not above ninety-nine percent"
 if !ledger.bare.blt (normalize 1 100 (by decide)) || !(normalize 99 100 (by decide)).blt ledger.heldCycle then
  throw "sealed structural dominance class changed"
 if !ledger.bare.blt current.1 && !current.2.blt ledger.bare then
  throw "structural fraction was improperly conflated with PDG current-mass fraction"
 if !rows.proton.2.blt rows.neutron.1 then throw "complete NIST neutron/proton intervals no longer order"
 let lower ← RunningConvergence.positiveTake rows.neutron.1 rows.proton.2
 let upper ← RunningConvergence.positiveTake rows.neutron.2 rows.proton.1
 if rows.difference.1.blt lower || upper.blt rows.difference.2 then
  throw "NIST direct mass difference left the propagated mass intervals"
 let certificate ← NucleonBindingRoots.neutronProtonOrderCertificate
 if !zero.blt certificate.netNeutronSurplusLower then throw "sealed neutron/proton ordering certificate changed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match NucleonBinding.nucleonMassLedger with
 | .error _ => false
 | .ok ledger => match NucleonBindingRoots.neutronProtonOrderCertificate with
  | .error _ => false
  | .ok certificate => ledger.bare == normalize 1 128 (by decide) && ledger.heldCycle == normalize 127 128 (by decide) && (normalize 1 1000 (by decide)).blt certificate.netNeutronSurplusLower
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.NucleonBindingMeasurement
