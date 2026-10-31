from pathlib import Path
import subprocess
s=Path('work/prepare_inertial500.py').read_text().replace('SpacetimeInertial','SpacetimeLimitSpeed').replace('INERTIAL_TRANSFORMATION','LIMIT_SPEED').replace('inertial500','limitspeed500')
s=s.replace("'CAUSAL_ORDER','LIMIT_SPEED'","'CAUSAL_ORDER','INERTIAL_TRANSFORMATION','LIMIT_SPEED'")
Path('work/prepare_limitspeed500_generated.py').write_text(s)
subprocess.run(['python3','work/prepare_limitspeed500_generated.py'],check=True)
r=Path('work/constants-recovery');p=r/'SFT/Physics/SpacetimeLimitSpeedMeasured.lean'
s=(r/'SFT/Physics/MassEnergyMeasured.lean').read_text().replace('MassEnergy','SpacetimeLimitSpeed')
s=s.replace('electron-mass-energy-limit-speed-square','planck-support-recurrence-limit-speed').replace('Electron inertial content composed with two limiting-speed carriers predicts its mass-energy equivalent.','Planck spatial support divided by Planck recurrence time predicts the invariant limiting-speed carrier.').replace('The sealed exact mass/speed prediction does not overlap the released CODATA mass-energy interval or the displaced control is accepted.','The sealed exact Planck-support/recurrence interval does not contain the released CODATA limiting speed or the displaced control is accepted.').replace('target_energy__withheld_interval','target_speed__withheld_interval').replace('electron mass energy equivalent','speed of light in vacuum')
a=s.index('def program :');b=s.index('\ndef programFields',a)
s=s[:a]+'''def program : CapabilityAdmission.Program := ⟨Text.append experimentId "-exact-measured-value",[
 ⟨.input,"length__lower",["length__lower"]⟩,⟨.input,"length__upper",["length__upper"]⟩,
 ⟨.input,"time__lower",["time__lower"]⟩,⟨.input,"time__upper",["time__upper"]⟩,
 ⟨.quotient,"speed__lower",["length__lower","time__upper"]⟩,
 ⟨.quotient,"speed__upper",["length__upper","time__lower"]⟩,
 ⟨.pair,"predicted_interval",["speed__lower","speed__upper"]⟩,
 ⟨.emit,"",["predicted_interval"]⟩]⟩
'''+s[b:]
s=s.replace('[.text "mass",.text "electron mass",.text "kg"],.array [.text "speed",.text "speed of light in vacuum",.text "m s^-1"]','[.text "length",.text "Planck length",.text "m"],.array [.text "time",.text "Planck time",.text "s"]')
s=s.replace('targetQuantity,.text "J"','targetQuantity,.text "m s^-1"').replace('(mass speed : Interval)','(length time : Interval)').replace('"mass__','"length__').replace('ratioValue mass.','ratioValue length.').replace('ratioValue speed.','ratioValue time.')
# Only inputs carries time names; the program speed output remains unchanged.
a=s.index('def inputs');b=s.index('\ndef envelope',a);s=s[:a]+s[a:b].replace('"speed__','"time__')+s[b:]
s=s.replace('let mass ← loadRows rows "electron mass" "kg"','let length ← loadRows rows "Planck length" "m"').replace('let speed ← loadRows rows "speed of light in vacuum" "m s^-1"','let time ← loadRows rows "Planck time" "s"').replace('loadRows rows targetQuantity "J"','loadRows rows targetQuantity "m s^-1"').replace('inputs mass speed','inputs length time')
p.write_text(s)
s=(r/'MassEnergyValidationProgram493.lean').read_text().replace('MassEnergy','SpacetimeLimitSpeed');(r/'SpacetimeLimitSpeedValidationProgram500.lean').write_text(s)
s=Path('work/massenergy_validation493.py').read_text().replace('MASS-ENERGY','LIMIT-SPEED').replace('SFT-PHYS-MATTER-','SFT-PHYS-SPACETIME-').replace('MassEnergy','SpacetimeLimitSpeed').replace('massenergy','spacetimelimitspeed').replace('493','500');Path('work/spacetimelimitspeed_validation500.py').write_text(s)
s=Path('work/build_inertial500.py').read_text().replace('inertial500','limitspeed500').replace("['Grammar','Evidence','Experiment','Validation']","['Grammar','Evidence','Experiment','Validation','Measured']")
Path('work/build_limitspeed500.py').write_text(s)
s=Path('work/run_inertial500.py').read_text().replace('inertial500','limitspeed500').replace('Auditinertial','Auditlimitspeed').replace("'SFT/Physics/SpacetimeCausalOrder']","'SFT/Physics/SpacetimeCausalOrder','SFT/Physics/SpacetimeInertial']").replace("['Grammar','Evidence','Experiment','Validation','ValidationProofs']","['Grammar','Evidence','Experiment','Validation','ValidationProofs','Measured']")
s=s.replace("if stem=='MassEnergy' else []","if stem=='SpacetimeLimitSpeed' else []").replace("+[str(Path('work/native500/MassEnergyMeasured.o').resolve())]",'')
Path('work/run_limitspeed500.py').write_text(s)
