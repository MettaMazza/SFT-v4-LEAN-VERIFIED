from pathlib import Path
import json,sys
w=Path('work');r=w/'constants-recovery';c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import matter_flavour_validation_v1 as src
s='''import SFT.Physics.NeutrinoMeasurementRoots
import SFT.Physics.MatterAuthoritativeWitnesses
namespace SFT.Physics.NeutrinoComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def neutrinoLabel : String := '+json.dumps(src.NEUTRINO_LABEL)+'\n'
s+='''def neutrinoClassificationUsing (readSource : String → Except String Value) : Except String String := do
 let rows ← readSource "PDG-2025-NEUTRINO-MIXING"
 let pmns ← PMNSPhysical.pmnsCPStructure
 let _ ← [("normal_ordering_sin2_theta12",pmns.solar),("normal_ordering_sin2_theta23",pmns.atmospheric),("normal_ordering_sin2_theta13",pmns.reactor)].mapM fun (key,prediction) => do
  let row ← field rows key
  let lower ← decimalField row "three_sigma_lower"
  let upper ← decimalField row "three_sigma_upper"
  if prediction.blt lower || upper.blt prediction then throw "PMNS prediction left registered three-sigma support"
  pure ()
 let cp ← field rows "normal_ordering_delta_cp_degrees"
 let lower ← decimalField cp "three_sigma_lower"
 let upper ← decimalField cp "three_sigma_upper"
 let phase := multiply (normalize 360 1 (by decide)) pmns.cpPhase
 if phase.blt lower || upper.blt phase then throw "CP phase left registered support"
 let solar ← field rows "solar_delta_mass_squared_eV2"
 let atmospheric ← field rows "atmospheric_delta_mass_squared_eV2"
 let solarValue ← decimalField solar "value"
 let atmosphericValue ← decimalField atmospheric "value"
 let ratio ← LeptonRatios.divide solarValue atmosphericValue
 if !((normalize 29 1000 (by decide)).blt ratio && ratio.blt (normalize 32 1000 (by decide))) then
  throw "neutrino splitting comparison changed"
 let masses ← NeutrinoLadder.neutrinoMassSquares
 let intervals ← [masses.lightest,masses.middle,masses.heavy].mapM fun m =>
  NeutrinoMeasurementRoots.sqrtRefined (multiply solarValue m)
 let sum := intervals.foldl (fun acc row => (add acc.1 row.1,add acc.2 row.2)) (zero,zero)
 let planck ← readSource "PLANCK-2018-NEUTRINO-MASS-BOUND"
 let bound ← decimalField planck "sum_neutrino_masses_upper_eV_base_LCDM_BAO"
 if !sum.2.blt bound then throw "positive neutrino sum exceeds registered cosmological bound"
 let heavy ← LeptonRatios.atIndex intervals 2
 let direct ← decimalField rows "direct_effective_electron_neutrino_mass_upper_eV"
 if !heavy.2.blt direct then throw "positive neutrino mass exceeds direct bound"
 pure neutrinoLabel

def neutrinoClassificationFromRecord (record : Value) : Except String String :=
 neutrinoClassificationUsing (sourceRowsFromRecord record)

def neutrinoClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String :=
 neutrinoClassificationUsing (sourceRows bytes files payload)

theorem originalClassification : neutrinoClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord = .ok neutrinoLabel := rfl

def neutrinoCheck : Bool := match neutrinoClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord with
 | .ok label => Text.equal label neutrinoLabel
 | .error _ => false

theorem neutrinoCheckPassed : neutrinoCheck = true := rfl
end SFT.Physics.NeutrinoComparisonMeasurement
'''
for root in [r,c]:(root/'SFT/Physics/NeutrinoComparisonMeasurement.lean').write_text(s)
