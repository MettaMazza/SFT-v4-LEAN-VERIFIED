from pathlib import Path
import re
p=Path('work/constants-recovery/SFT/Physics/CosmoBackgroundMeasured.lean')
s=Path('work/constants-recovery/SFT/Physics/MassEnergyMeasured.lean').read_text().replace('MassEnergy','CosmoBackground')
a=s.index('def sourceId');b=s.index('def program :',a)
s=s[:a]+'''def sourceId := "NASA-LAMBDA-COBE-FIRAS-2026-07-23"
def targetSourceId := "NASA-LAMBDA-COBE-FIRAS-MONOPOLE-2026-07-23"
def targetHash := "sha256:e42bcf7e3e2eccac3ac8c210d4287e2477c394ad03d76ac7f719515d29753f2a"
def falsification := CosmoBackgroundExperiment.falsification
def targetId := "firas_monopole_temperature"

def positiveRatio (value : Rat) : Except String CapabilityValues.Value :=
 if LeptonIntervals.zero.blt value then ratioValue value
 else .error "ValueError: background temperature must remain an exact positive value"

def pair (central uncertainty : Rat) : Except String CapabilityValues.Value := do
 if !(LeptonIntervals.zero.blt uncertainty) || !(uncertainty.blt central) then
  .error "ValueError: background-temperature uncertainty is outside the positive domain"
 else .ok (.pair (← positiveRatio (LeptonIntervals.subtract central uncertainty)) (← positiveRatio (LeptonIntervals.add central uncertainty)))

def readInput (text : String) : Except String CapabilityValues.Value :=
 if Text.contains text "2.725&plusmn;0.002 K" then pair (LeptonIsolation.endpoint 2725 1000 (by decide)) (LeptonIsolation.endpoint 2 1000 (by decide))
 else .error "ValueError: registered FIRAS input temperature record is absent"

def readTarget (text : String) : Except String CapabilityValues.Value :=
 if Text.contains text "2725 +/- 1 mK" then pair (LeptonIsolation.endpoint 2725 1000 (by decide)) (LeptonIsolation.endpoint 1 1000 (by decide))
 else .error "ValueError: withheld FIRAS monopole temperature record is absent"

''' + s[b:]
a=s.index('def program :');b=s.index('def programFields',a)
s=s[:a]+'''def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-background-invariance",[
 ⟨.input,"lower",["background_lower"]⟩,⟨.input,"upper",["background_upper"]⟩,
 ⟨.pair,"prediction",["lower","upper"]⟩,⟨.emit,"",["prediction"]⟩]⟩

'''+s[b:]
a=s.index('def registration :');b=s.index('def envelope',a)
s=s[:a]+'''def registration : Value := .object [
 ("claim_id",.text claimId),("experiment_id",.text experimentId),
 ("frozen_relation",.text "background thermodynamic temperature is invariant across the registered FIRAS analyses"),
 ("input_source_id",.text sourceId),("input_snapshot_hash",.text snapshotHash),
 ("withheld_target_source_id",.text targetSourceId),("target_snapshot_hash",.text targetHash),
 ("program",.object programFields),("falsification_condition",.text falsification)]
def registrationHash := identity registration

def inputs (interval : CapabilityValues.Value) : Except String (List (String × CapabilityValues.Value)) := do
 let (lower,upper) ← endpoints interval
 .ok [("background_lower",← positiveRatio lower),("background_upper",← positiveRatio upper)]

'''+s[b:]
s=s.replace('"-measured-value-executor"','"-firas-prediction-executor"').replace('[.text "sft-v3-exact-positive-interval-evaluator/1",.text relationId,.text falsification]','[.text "exact-FIRAS-interval-overlap/1",.text falsification]')
a=s.index('def measurementReceipt');b=s.index('def validate',a)
s=s[:a]+'''def measurementReceipt (derivationSeal : String) (prediction : PredictionSeal) (execution : CapabilityExecution.Execution)
    (predicted observed : Rat × Rat) (overlaps rejected : Bool) : Value := .object [
 ("derivation_seal_hash",.text derivationSeal),("prediction_seal_hash",.text prediction.sealHash),
 ("input_snapshot_hash",.text snapshotHash),("target_snapshot_hash",.text targetHash),
 ("predicted_interval_kelvin",intervalJSON predicted),("measured_interval_kelvin",intervalJSON observed),
 ("overlap",.boolean overlaps),("unfavorable_rejected",.boolean rejected),("trace_hash",.text execution.traceHash)]

def fractionRepr (x : Rat) := Text.join ["Fraction(",render (.integer x.num),", ",render (.integer (.ofNat x.den)),")"]
def intervalRepr (x : Rat × Rat) := Text.join ["(",fractionRepr x.1,", ",fractionRepr x.2,")"]
def measurement (predicted observed : Rat × Rat) (passed : Bool) := Text.join [
 "FIRAS background interval predicted ",intervalRepr predicted,"; independently released monopole interval ",intervalRepr observed,
 "; overlap ",if passed then "True" else "False"]

def targetMatches (bytes : ByteArray) := Text.equal (Text.append "sha256:" (SHA256Window.digest bytes)) targetHash

'''+s[b:]
s=s.replace('def validate (bytes : ByteArray)','def validate (bytes targetBytes : ByteArray)').replace('if !CosmoBackgroundExperiment.sourceMatches bytes then','if !CosmoBackgroundExperiment.sourceMatches bytes || !targetMatches targetBytes then').replace('ValueError: measured-value external snapshot differs from its registration','ValueError: COBE FIRAS external snapshot differs from registration')
a=s.index('  let rows :=');b=s.index('  let vault ←',a)
s=s[:a]+'''  let inputInterval ← readInput text
  let targetPair ← readTarget (String.ofList (Text.decode targetBytes.size targetBytes.data.toList))
  let parsed ← CapabilityDocuments.loadProgramFields programFields
  let values ← inputs inputInterval
'''+s[b:]
s=s.replace('"-measured-value-custodian"','"-firas-target-custodian"').replace('[.text registrationHash,.text snapshotHash,.text targetQuantity]','[.text registrationHash,.text targetHash]').replace('ValueError: measured-value prediction failed the hostile-package audit','ValueError: FIRAS prediction failed hostile-package audit').replace('("data_source_ids",.array [.text sourceId])','("data_source_ids",.array [.text sourceId,.text targetSourceId])')
a=s.index('theorem sourceMismatchRejected');b=s.index('theorem sealBindsExactInputs',a)
s=s[:a]+'''theorem sourceMismatchRejected (bytes targetBytes : ByteArray) (sealedHash host implementation : String)
 (before after : Snapshot) (changed : CosmoBackgroundExperiment.sourceMatches bytes=false) :
 validate bytes targetBytes sealedHash host implementation before after = .error "ValueError: COBE FIRAS external snapshot differs from registration" := by
 unfold validate
 rw [changed]
 rfl

'''+s[b:]
s=s.replace('def inputs (interval','def endpoints (value : CapabilityValues.Value) : Except String (Rat × Rat) :=\n match EvolutionMeasuredSource.endpoints value with\n | .ok result => .ok result\n | .error message => if Text.contains message "not ordered" then .error "ValueError: background prediction interval is unordered"\n   else .error "ValueError: background prediction is not an exact Fold interval"\n\ndef overlap (left right : CapabilityValues.Value) : Except String Bool := do\n let (ll,lu) ← endpoints left\n let (rl,ru) ← endpoints right\n .ok (!(lu.blt rl || ru.blt ll))\n\n'+'def inputs (interval')
s=s.replace('end SFT.Physics.CosmoBackgroundMeasured','theorem inputIntervalExact :\n readInput "2.725&plusmn;0.002 K" = .ok (.pair (.ratio ⟨2723,by decide⟩ ⟨1000,by decide⟩) (.ratio ⟨2727,by decide⟩ ⟨1000,by decide⟩)) := rfl\n\ntheorem targetIntervalExact :\n readTarget "2725 +/- 1 mK" = .ok (.pair (.ratio ⟨681,by decide⟩ ⟨250,by decide⟩) (.ratio ⟨1363,by decide⟩ ⟨500,by decide⟩)) := rfl\n\ntheorem independentIntervalsOverlap :\n (do let input ← readInput "2.725&plusmn;0.002 K"; let target ← readTarget "2725 +/- 1 mK"; overlap input target) = .ok true := rfl\n\ntheorem displacedIntervalRejected :\n (do let input ← readInput "2.725&plusmn;0.002 K"; overlap input (.pair (.ratio ⟨3727,by decide⟩ ⟨1000,by decide⟩) (.ratio ⟨4727,by decide⟩ ⟨1000,by decide⟩))) = .ok false := rfl\n'+'end SFT.Physics.CosmoBackgroundMeasured')
p.write_text(s)
