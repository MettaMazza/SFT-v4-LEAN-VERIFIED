from pathlib import Path
import sys,subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
exec((w/"particlemode1056_spec_loader.py").read_text())
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform';cid=SPEC.claim_id
for name in ['claims/'+cid+'/execution.py','sft/physics/particle_mode_generation_terminal_execution_v1.py','sft/physics/particle_mode_generation_terminal_law_v1.py','generated/physics/particle_mode_generation_terminal_validator_v1.py']:
 data=subprocess.check_output(['git','-C',v3,'show',pin+':'+name]);p=w/'v3-runtime500'/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
def sub(s):return s.replace('inflation_growth_terminal','particle_mode_generation_terminal').replace('SFT-PHYS-INFLATION-GROWTH-TERMINAL-039',cid).replace('InflationGrowth','ParticleMode').replace('inflation1035','particlemode1056').replace('1035','1056').replace('InflationGrammar','ThermalEquilibriumGrammar')
for k in ['program','fresh','independent']:(w/f'check_particlemode1056_{k}.py').write_text(sub((w/f'check_inflation1035_{k}.py').read_text()))
(w/'run_particlemode1056_native.py').write_text(sub((w/'run_inflation1035_native.py').read_text()));(r/'ParticleModeProgram1056.lean').write_text(sub((r/'InflationGrowthProgram1035.lean').read_text()));print('Prepared original four witnesses and source entry methods')
