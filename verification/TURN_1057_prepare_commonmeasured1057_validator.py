from pathlib import Path
import ast,json
r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');w=Path('work');tag='CommonMeasured';q=json.dumps
s='''import SFT.Physics.CommonMeasuredAnalysis
import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CommonMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement CommonMeasuredAnalysis
-- Decoding the immutable source record and its original declared controls.
-- General converted-Fraction calculations are retained by exactAnalysis.
def originalRows (values : List Value) (key : String) : Except String (List Row) :=
 values.mapM (fun row => do
  .ok ⟨← text (← field row key),← decimalField row "center",← decimalField row "standard_uncertainty"⟩)

def originalRecordTarget (v : Value) : Except String Target := do
 let schemes ← originalRows (← array (← field v "scheme_rows")) "scheme"
 let low ← originalRows (← array (← field v "low_transfer_rows")) "row_id"
 let classes ← (← array (← field v "displayed_measurement_classes")).mapM text
 let yes := fun key => ThermometryMeasurement.literalBoolean (PostNewtonianRecords.getDefault v key) true
 .ok ⟨schemes,low,classes,yes "below_W_effective_theory_and_beta_sign_change_retained",
 yes "threshold_matching_discontinuities_retained",yes "complete_strong_and_electromagnetic_vector_receipt_retained",
 yes "NuTeV_extraction_retained_unchanged",yes "NuTeV_extraction_is_not_a_required_mismatch_or_SFT_result",
 yes "all_source_rows_retained_unchanged"⟩

def pair (v : Rat × Rat) : Value := .array [RunningConvergenceCertificate.rat v.1,RunningConvergenceCertificate.rat v.2]
def intervals (v : Intervals) : Value := .object (v.map (fun (k,b)=>(k,pair b)))
def analysisValue (a : Analysis) : Value := .object [
 ("scheme_intervals",intervals a.schemeIntervals),
 ("low_transfer_intervals",intervals a.lowTransferIntervals),
 ("terminal_inside_on_shell_interval",.boolean a.terminalInsideOnShell),
 ("support_eight_inside_APV_interval",.boolean a.supportEightInsideAPV),
 ("E158_interval_above_MS_Z",.boolean a.e158AboveMSZ),
 ("APV_interval_above_MS_Z",.boolean a.apvAboveMSZ),
 ("eDIS_interval_overlaps_MS_Z",.boolean a.edisOverlapsMSZ),
 ("complete_scheme_rows",.boolean a.completeSchemes),
 ("complete_low_transfer_rows",.boolean a.completeLowTransfer),
 ("complete_displayed_classes",.boolean a.completeDisplayedClasses),
 ("threshold_boundary_retained",.boolean a.thresholdBoundary),
 ("strong_EM_receipt_retained",.boolean a.strongEMReceipt),
 ("NuTeV_extraction_retained",.boolean a.nuTeVRetained),
 ("NuTeV_not_rewarded_as_mismatch",.boolean a.nuTeVNotMismatch),
 ("all_source_rows_retained",.boolean a.allRowsRetained)]
def exactCommonScaleAnalysis (v : Value) : Except String Value := do
 .ok (analysisValue (← exactAnalysis (← originalRecordTarget v)))
end SFT.Physics.CommonMeasuredMeasurement
''';(r/f'SFT/Physics/{tag}Measurement.lean').write_text(s)
s=(w/f'constants-recovery/SFT/Physics/{tag}Experiment.lean').read_text();s=s[:s.index('def sourceMatches')];s=s.replace('import SFT.Physics.'+tag+'Evidence','import SFT.Physics.'+tag+'Evidence\nimport SFT.Physics.'+tag+'Records');tail=(r/'SFT/Physics/ElectroweakMeasuredExperiment.lean').read_text();tail=tail[tail.index('def targetIds'):].replace('ElectroweakMeasured',tag).replace('PDG-ELECTROWEAK-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD','PDG-COMMON-SCALE-WITHHELD-COMPLETE-MEASURED-VALUE-RECORD').replace('targetRows.length=2','targetRows.length=3');(r/f'SFT/Physics/{tag}Experiment.lean').write_text(s+tail)
s=(r/'SFT/Physics/ElectroweakMeasuredValidation.lean').read_text().replace('ElectroweakMeasured',tag).replace('ELECTROWEAK-MEASURED-VALUE-053','COMMON-SCALE-MEASURED-VALUE-054').replace('electroweak successor','common-scale successor').replace('exact-electroweak-measured-value-successor/1','exact-common-scale-measured-value-successor/1').replace('exactElectroweakAnalysis','exactCommonScaleAnalysis')
a=s.index('structure Validation where');s=s[:a]+'''-- Exact indexed replacement used by the source's two adverse controls.
def replaceAt : List Value → Nat → Value → Except String (List Value)
 | [],_,_ => .error "list assignment index out of range"
 | _::xs,0,v => .ok (v::xs)
 | x::xs,n+1,v => do .ok (x::(← replaceAt xs n v))
def tamperedTerminal (target : Value) : Except String Value := do
 let rows ← RunningConvergenceMeasurement.array (← field target "scheme_rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 0
 let rows ← replaceAt rows 0 (replaceField row "center" (.text "0.22000"))
 .ok (replaceField target "scheme_rows" (.array rows))
def tamperedAPV (target : Value) : Except String Value := do
 let rows ← RunningConvergenceMeasurement.array (← field target "low_transfer_rows")
 let row ← RunningConvergenceMeasurement.rowAt rows 3
 let changed := replaceField (replaceField row "center" (.text "0.2300")) "standard_uncertainty" (.text "0.0001")
 let rows ← replaceAt rows 3 changed
 .ok (replaceField target "low_transfer_rows" (.array rows))
'''+s[a:]
a=s.index(' let empirical :=');b=s.index(' let targetIdentity',a)
keys=['terminal_inside_on_shell_interval','support_eight_inside_APV_interval','E158_interval_above_MS_Z','APV_interval_above_MS_Z','eDIS_interval_overlaps_MS_Z','complete_scheme_rows','complete_low_transfer_rows','complete_displayed_classes','threshold_boundary_retained','strong_EM_receipt_retained','NuTeV_extraction_retained','NuTeV_not_rewarded_as_mismatch','all_source_rows_retained']
s=s[:a]+' let empirical := '+' && '.join('yes '+q(k)for k in keys)+'\n'+''' let terminalAnalysis ← CommonMeasuredMeasurement.exactCommonScaleAnalysis (← tamperedTerminal target)
 let terminalRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault terminalAnalysis "terminal_inside_on_shell_interval")
 let apvAnalysis ← CommonMeasuredMeasurement.exactCommonScaleAnalysis (← tamperedAPV target)
 let apvRejected := !SymmetricRecords.truthy (PostNewtonianRecords.getDefault apvAnalysis "support_eight_inside_APV_interval")
 let passed := formal && empirical && terminalRejected && apvRejected
'''+s[b:]
s=s.replace('("tampered_direct_rejected",.boolean directRejected),("tampered_w_rejected",.boolean wRejected)','("tampered_terminal_rejected",.boolean terminalRejected),("tampered_APV_rejected",.boolean apvRejected)')
vt=ast.parse((w/'commonmeasured1056_validation.py').read_text());n=next(n for n in ast.walk(vt)if isinstance(n,ast.Assign)and any(isinstance(t,ast.Name)and t.id=='measurements'for t in n.targets));a=s.index(' let measurements :=');b=s.index(' pure ⟨',a);s=s[:a]+' let measurements := '+q(ast.literal_eval(n.value))+'\n'+s[b:];(r/f'SFT/Physics/{tag}Validation.lean').write_text(s)
