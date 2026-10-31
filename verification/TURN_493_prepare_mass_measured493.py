from pathlib import Path
import re
r=Path('work/constants-recovery');p=r/'SFT/Physics/MassEnergyMeasured.lean';s=(r/'SFT/Physics/EvolutionMeasured.lean').read_text().replace('EvolutionMeasuredSource','SHARED_PARSER').replace('Evolution','MassEnergy').replace('SHARED_PARSER','EvolutionMeasuredSource')
s=s.replace('quantum-action-energy-time-quotient','electron-mass-energy-limit-speed-square').replace('The held quantum action carrier divided by energy support predicts its recurrence duration.','Electron inertial content composed with two limiting-speed carriers predicts its mass-energy equivalent.').replace('The sealed exact action/energy interval does not overlap the released CODATA atomic-time interval or the displaced control is accepted.','The sealed exact mass/speed prediction does not overlap the released CODATA mass-energy interval or the displaced control is accepted.').replace('target_duration__withheld_interval','target_energy__withheld_interval').replace('atomic unit of time','electron mass energy equivalent')
a=s.index('def program :');b=s.index('\ndef programFields',a)
s=s[:a]+'''def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-exact-measured-value",[
 ⟨.input,"mass__lower",["mass__lower"]⟩,⟨.input,"mass__upper",["mass__upper"]⟩,
 ⟨.input,"speed__lower",["speed__lower"]⟩,⟨.input,"speed__upper",["speed__upper"]⟩,
 ⟨.product,"speed_square__lower",["speed__lower","speed__lower"]⟩,
 ⟨.product,"speed_square__upper",["speed__upper","speed__upper"]⟩,
 ⟨.product,"energy__lower",["mass__lower","speed_square__lower"]⟩,
 ⟨.product,"energy__upper",["mass__upper","speed_square__upper"]⟩,
 ⟨.pair,"predicted_interval",["energy__lower","energy__upper"]⟩,
 ⟨.emit,"",["predicted_interval"]⟩]⟩
''' + s[b:]
s=s.replace('[.text "action",.text "reduced Planck constant",.text "J s"],.array [.text "energy",.text "atomic unit of energy",.text "J"]','[.text "mass",.text "electron mass",.text "kg"],.array [.text "speed",.text "speed of light in vacuum",.text "m s^-1"]')
s=s.replace('.text targetQuantity,.text "s"','.text targetQuantity,.text "J"')
a=s.index('def inputs (');b=s.index('\ndef envelope',a)
s=s[:a]+'''def inputs (mass speed : Interval) : Except String (List (String × CapabilityValues.Value)) := do
 .ok [("mass__lower",← ratioValue mass.lower),("mass__upper",← ratioValue mass.upper),
      ("speed__lower",← ratioValue speed.lower),("speed__upper",← ratioValue speed.upper)]
''' + s[b:]
s=s.replace('let action ← loadRows rows "reduced Planck constant" "J s"','let mass ← loadRows rows "electron mass" "kg"').replace('let energy ← loadRows rows "atomic unit of energy" "J"','let speed ← loadRows rows "speed of light in vacuum" "m s^-1"').replace('let target ← loadRows rows targetQuantity "s"','let target ← loadRows rows targetQuantity "J"').replace('let values ← inputs action energy','let values ← inputs mass speed')
p.write_text(s)
p=r/'MassEnergyValidationProgram493.lean';s=p.read_text().replace('SFT.Physics.MassEnergyValidation','SFT.Physics.MassEnergyMeasured').replace('MassEnergyValidation.validate','MassEnergyMeasured.validate');p.write_text(s)
print('Original MASS_ENERGY VALUE_SPECS ten-instruction product validator prepared')
