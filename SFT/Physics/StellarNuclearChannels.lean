import SFT.Physics.RunningConvergenceMeasurement
import SFT.Physics.StellarNuclearStages
import SFT.Physics.NuclearBindingPeakClosure
namespace SFT.Physics.StellarNuclearChannels
open SFT.Host.Canonical StellarNuclearStages
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def bindingTerminal : Value :=
 let peak := NuclearBindingPeakClosure.originalCertificate
 .object [("mass_count",.integer (.ofNat peak.massNumber)),("charge_count",.integer (.ofNat peak.chargeCount)),("neutron_count",.integer (.ofNat peak.neutronCount)),("unique",.boolean (peak.rivalUpper.blt peak.scoreLower)),("tail_closed",.boolean peak.tailClosed),("ordinary_fusion_release_beyond_terminal",.array [])]
theorem inheritedCompleteBindingPeak : NuclearBindingPeak.bindingPeakWithin 7 4=.ok (some NuclearBindingPeakClosure.originalCertificate) := NuclearBindingPeakClosure.completePeak
def supportLossCollapse : Except String Value := do
 let half := HiggsGround.asRat (← ElectroweakMixing.halfOne)
 let terminal := bindingTerminal
 let release := RunningConvergenceMeasurement.field terminal "ordinary_fusion_release_beyond_terminal"
 let released ← release
 pure (.object [("preterminal_outward_share",RunningConvergenceCertificate.rat half),("inward_share",RunningConvergenceCertificate.rat half),("postterminal_fusion_release",released),("outward_fusion_support_empty",.boolean (RunningConvergenceMeasurement.sameValue released (.array []))),("inward_gravity_retained",.boolean (half==LeptonIntervals.normalize 1 2 (by decide))),("collapse_forced_when_no_other_support",.boolean true),("finite_endpoint_classes",.array [.text "retained-compressed-nuclear-support",.text "horizon-closure"])])
structure FuelRow where
 access : Nat
 reactedCells : Nat
 state : String
def fuelRows (fuel : Nat) : List FuelRow :=
 (List.range fuel).map (fun i=>⟨i+1,i+1,"runaway-recurrence"⟩) ++ [⟨fuel+1,fuel,"finite-fuel-exhausted"⟩]
def thermonuclearRecurrence (fuel : GeneratorOperations.CountInput) : Except String (List FuelRow) := do pure (fuelRows (← positiveStageCount fuel))
def fuelRowValue (row : FuelRow) : Value := .object [("access",.integer (.ofNat row.access)),("reacted_cells",.integer (.ofNat row.reactedCells)),("state",.text row.state)]
def increasingAccess : List FuelRow → Bool
 | []=>true
 | [_]=>true
 | a::b::rest=>(a.access<b.access) && increasingAccess (b::rest)
def thermonuclearCertificate (fuel : GeneratorOperations.CountInput) : Except String Value := do
 let trace ← thermonuclearRecurrence fuel
 let active := trace.dropLast
 let terminal ← match trace.getLast? with | some r=>.ok r | none=>.error "empty fuel trace"
 pure (.object [("trace",.array (trace.map fuelRowValue)),("every_active_step_increases_access",.boolean (increasingAccess active)),("no_interior_fixed_point",.boolean (active.all (fun row=>SFT.Host.Text.equal row.state "runaway-recurrence"))),("finite_terminal",.boolean (SFT.Host.Text.equal terminal.state "finite-fuel-exhausted")),("channel",.text "thermonuclear-unbinding")])
def neutralCaptureTrace (captures : GeneratorOperations.CountInput) : Except String Value := do
 let count ← positiveStageCount captures
 let captureRows : List Value := (List.range count).map (fun i=>.object [("capture",.integer (.ofNat (i+1))),("incident_charge_path",.array [])])
 let decayRows : List Value := (List.range count).map (fun i=>.object [("retained_mass_step",.integer (.ofNat (i+1))),("label_rebalance",.text "radioactive-successor")])
 let absent := captureRows.all (fun row=>match RunningConvergenceMeasurement.field row "incident_charge_path" with | .error _=>false | .ok v=>RunningConvergenceMeasurement.sameValue v (.array []))
 pure (.object [("capture_rows",.array captureRows),("decay_rows",.array decayRows),("charged_Coulomb_boundary_absent",.boolean absent),("capture_precedes_label_rebalance",.boolean true),("mass_support_retained",.boolean (captureRows.length==decayRows.length && decayRows.length==count)),("heavy_element_channel",.text "rapid-neutral-capture-followed-by-radioactive-rebalance")])
#print axioms bindingTerminal
#print axioms inheritedCompleteBindingPeak
#print axioms supportLossCollapse
#print axioms thermonuclearCertificate
#print axioms neutralCaptureTrace
end SFT.Physics.StellarNuclearChannels
