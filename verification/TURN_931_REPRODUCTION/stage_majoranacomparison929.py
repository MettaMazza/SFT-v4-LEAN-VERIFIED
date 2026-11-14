from pathlib import Path
import json,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
s='''import SFT.Physics.NeutrinoMeasurementRoots
import SFT.Physics.MatterAuthoritativeWitnesses
namespace SFT.Physics.MajoranaComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def majoranaLabel : String := '+json.dumps(src.MAJORANA_LABEL)+'\n'
s+='''def predictionBounds (anchor : Rat) : Except String (Rat × Rat) := do
 let masses ← NeutrinoLadder.neutrinoMassSquares
 let pmns ← PMNSPhysical.pmnsCPStructure
 let brackets ← [masses.lightest,masses.middle,masses.heavy].mapM fun m =>
  NeutrinoMeasurementRoots.sqrtRefined (multiply anchor m)
 let b0 ← LeptonRatios.atIndex brackets 0
 let b1 ← LeptonRatios.atIndex brackets 1
 let b2 ← LeptonRatios.atIndex brackets 2
 let weights := pmns.electronWeights
 let lower := [multiply weights.1 b0.1,multiply weights.2.1 b1.1,multiply weights.2.2 b2.1]
 let upper := [multiply weights.1 b0.2,multiply weights.2.1 b1.2,multiply weights.2.2 b2.2]
 let middle ← LeptonRatios.atIndex lower 1
 let first ← LeptonRatios.atIndex upper 0
 let last ← LeptonRatios.atIndex upper 2
 pure (subtract (subtract middle first) last,upper.foldl add zero)

def majoranaClassificationRows (rows : Value) : Except String String := do
 if !Text.equal (← text (← field rows "zero_nu_observation_status")) "not observed" then
  throw "zero-nu observation status changed"
 let anchor ← decimalField (← field rows "solar_delta_mass_squared_eV2") "value"
 let bounds ← predictionBounds anchor
 let limit ← decimalField rows "zero_nu_effective_mass_upper_eV_90pct_lower_nme"
 if !zero.blt bounds.1 || !bounds.2.blt limit then
  throw "zero-nu predicted range/current limit relation changed"
 pure majoranaLabel

def majoranaClassificationFromRecord (record : Value) : Except String String := do
 majoranaClassificationRows (← sourceRowsFromRecord record "PDG-2025-NEUTRINO-MIXING")
def majoranaClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 majoranaClassificationRows (← sourceRows bytes files payload "PDG-2025-NEUTRINO-MIXING")

theorem originalClassification : majoranaClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord = .ok majoranaLabel := rfl

def majoranaCheck : Bool := match majoranaClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord with
 | .ok label => Text.equal label majoranaLabel
 | .error _ => false
theorem majoranaCheckPassed : majoranaCheck = true := rfl
end SFT.Physics.MajoranaComparisonMeasurement
'''
for root in [r,c]:(root/'SFT/Physics/MajoranaComparisonMeasurement.lean').write_text(s)
