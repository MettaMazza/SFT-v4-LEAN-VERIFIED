from pathlib import Path
import json,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
s='''import SFT.Physics.ProtonComparison
import SFT.Physics.MatterAuthoritativeWitnesses
namespace SFT.Physics.ProtonComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def protonLabel : String := '+json.dumps(src.PROTON_LABEL)+'\n'
s+='''def protonClassificationRow (row : Value) : Except String String := do
 let centre ← decimalField row "value"
 let uncertainty ← decimalField row "standard_uncertainty"
 let predicted ← ProtonComparison.protonRatioInterval
 if LeptonRatios.overlap predicted (subtract centre uncertainty,add centre uncertainty) then
  throw "proton/electron adverse comparison was erased"
 pure protonLabel

def protonClassificationFromRecord (record : Value) : Except String String := do
 let rows ← sourceRowsFromRecord record "NIST-CODATA-2022-ALL-CONSTANTS"
 protonClassificationRow (← field rows "proton_electron_mass_ratio")

def protonClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 let rows ← sourceRows bytes files payload "NIST-CODATA-2022-ALL-CONSTANTS"
 protonClassificationRow (← field rows "proton_electron_mass_ratio")

theorem originalClassification : protonClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord = .ok protonLabel := rfl

def protonCheck : Bool := match protonClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord with
 | .ok label => Text.equal label protonLabel
 | .error _ => false

theorem protonCheckPassed : protonCheck = true := rfl
end SFT.Physics.ProtonComparisonMeasurement
'''
for root in [r,c]:(root/'SFT/Physics/ProtonComparisonMeasurement.lean').write_text(s)
print('Original proton comparison and retained CODATA non-overlap staged')
