import SFT.Physics.VacuumAuthoritativeRecords
namespace SFT.Physics.VacuumAuthoritativeWitnesses
open SFT.Host.Canonical VacuumAuthoritativeRecords
set_option maxRecDepth 20000
def registeredSources : Value := .object [("NIST-ZERO-POINT-FLUCTUATIONS-2015",.object [("source_id",.text "NIST-ZERO-POINT-FLUCTUATIONS-2015"),("body",.text "National Institute of Standards and Technology Quantum Devices Group"),("uri",.text "https://www.nist.gov/news-events/news/2015/06/vacuum-fluctuations-measuring-unreal"),("snapshot",.text "nist-zero-point-fluctuations-2015.html"),("snapshot_sha256",.text "e829ac861cca9f84f43f752465b4ee8801fb07fac76e41f0df4de98ff5f54832"),("rows",.array [.object [("quantity",.text "ground-state residual fluctuation support"),("reported_result",.text "exactly one quantum of zero-point fluctuations after calibrated gain reconstruction"),("comparison_class",.text "nonempty-ground-support-confirmed")],.object [("quantity",.text "removable ground-state energy"),("reported_result",.text "ground-state swap cannot remove energy; no real energy can be transferred from vacuum fluctuations"),("comparison_class",.text "free-standing-vacuum-work-not-observed")],.object [("quantity",.text "physical amplification boundary"),("reported_result",.text "coherent microwave pumping is required to amplify the residual fluctuation into detectable photons and phonons"),("comparison_class",.text "external-pump-energy-retained")]])]),("NIST-CASIMIR-VACUUM-FORCES-2013",.object [("source_id",.text "NIST-CASIMIR-VACUUM-FORCES-2013"),("body",.text "National Institute of Standards and Technology Center for Nanoscale Science and Technology"),("uri",.text "https://www.nist.gov/news-events/news/2013/02/calculating-quantum-vacuum-forces-nanostructures"),("snapshot",.text "nist-casimir-vacuum-forces-2013.html"),("snapshot_sha256",.text "906e3d92d1e664daa5070bcf8cdafa4bf20fc8bb003346946870fa9b64ee7b1f"),("rows",.array [.object [("quantity",.text "Casimir interaction"),("reported_result",.text "accurately measured and calculated for simple flat conductors"),("comparison_class",.text "boundary-dependent-vacuum-force-confirmed")]])]),("PDG-ELECTROMAGNETIC-RUNNING-2025",.object [("source_id",.text "PDG-ELECTROMAGNETIC-RUNNING-2025"),("body",.text "Particle Data Group, Lawrence Berkeley National Laboratory"),("uri",.text "https://pdg.lbl.gov/2025/reviews/rpp2025-rev-standard-model.pdf"),("snapshot",.text "pdg-2025-electroweak-model.pdf"),("snapshot_sha256",.text "8642888a3408d8c57fc673b379325b07f02948135491f64a2e42320e8929320a"),("rows",.array [.object [("quantity",.text "inverse electromagnetic coupling at the Thomson limit"),("central",.text "137.035999084"),("standard_uncertainty",.text "0.000000021")],.object [("quantity",.text "inverse running electromagnetic coupling at the Z scale in the five-flavour MS scheme"),("central",.text "127.930"),("standard_uncertainty",.text "0.008")],.object [("quantity",.text "direct running observation"),("reported_result",.text "L3 and OPAL observed electromagnetic running directly in small- and large-angle Bhabha scattering"),("comparison_class",.text "closer-probe-effective-coupling-increase-confirmed")]])]),("CNES-MICROSCOPE-FINAL-2022",.object [("source_id",.text "CNES-MICROSCOPE-FINAL-2022"),("body",.text "Centre national d'etudes spatiales with ONERA, CNRS, ESA, ZARM and PTB"),("uri",.text "https://cnes.fr/en/projects/microscope"),("snapshot",.text "cnes-microscope-final.html"),("snapshot_sha256",.text "65a86753705aaa80f819e833d1ca4e13f0491e56b58a218c4cddb492c9887f12"),("rows",.array [.object [("quantity",.text "equivalence of gravitational and inertial response"),("reported_precision",.text "1e-15"),("reported_result",.text "final equivalence-principle measurement completed; no composition-dependent differential response reported"),("comparison_class",.text "unity-response-anchor-confirmed")]])])]
def floorCheck : Bool := match floorFromSources registeredSources with
 | .ok label => SFT.Host.Text.equal label floorLabel
 | .error _ => false
def polarizationCheck : Bool := match polarizationFromSources registeredSources with
 | .ok result => SFT.Host.Text.equal result.1 polarizationLabel
 | .error _ => false
def nonoverlapCheck : Bool := match polarizationFromSources registeredSources with
 | .ok result => match result.2.find? (fun p => SFT.Host.Text.equal p.1 "low_inverse_lower") with
   | none => false
   | some lower => match result.2.find? (fun p => SFT.Host.Text.equal p.1 "high_inverse_upper") with
     | none => false
     | some upper => upper.2.blt lower.2
 | .error _ => false
def inertiaCheck : Bool := match inertiaFromSources registeredSources with
 | .ok label => SFT.Host.Text.equal label inertiaLabel
 | .error _ => false
def extractionCheck : Bool := match extractionFromSources registeredSources with
 | .ok label => SFT.Host.Text.equal label extractionLabel
 | .error _ => false
theorem floorCheckPassed : floorCheck=true := rfl
theorem polarizationCheckPassed : polarizationCheck=true := rfl
theorem nonoverlapCheckPassed : nonoverlapCheck=true := rfl
theorem inertiaCheckPassed : inertiaCheck=true := rfl
theorem extractionCheckPassed : extractionCheck=true := rfl
end SFT.Physics.VacuumAuthoritativeWitnesses
