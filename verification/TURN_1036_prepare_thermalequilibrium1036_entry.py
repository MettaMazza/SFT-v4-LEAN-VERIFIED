from pathlib import Path
import sys,json,subprocess
w=Path('work');r=Path('/Volumes/One Touch/SFT v4 Full model LEAN');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics.thermal_equilibrium_response_terminal_law_v1 import SPEC
q=lambda x:json.dumps(x,ensure_ascii=False)
s='import SFT.Physics.ThermalEquilibriumCertificateProof\nnamespace SFT.Physics.ThermalEquilibriumResponseWitnesses\nopen ThermalEquilibriumResponseCertificate ThermalEquilibriumCertificateProof\nstructure Witness where\n name : String\n statement : String\n passed : Bool\n'
for i,check in enumerate(['c.temperature','c.equilibrium','c.canonical && c.weights','c.fluctuation && c.noise']):
 s+=f'def witness{i} : Bool := match certificate with | .error _ => false | .ok c => {check}\ntheorem witness{i}Passed : witness{i}=true := by\n unfold witness{i}\n rw [originalCertificate]\n rfl\n'
s+='def witnesses : List Witness := ['+','.join('⟨'+q(x.name)+','+q(x.statement)+',witness'+str(i)+'⟩'for i,x in enumerate(SPEC.witnesses))+']\nend SFT.Physics.ThermalEquilibriumResponseWitnesses\n';(r/'SFT/Physics/ThermalEquilibriumResponseWitnesses.lean').write_text(s)
s=(w/'prepare_inflation1035_evidence.py').read_text().replace('inflation_growth_terminal_law_v1','thermal_equilibrium_response_terminal_law_v1').replace('InflationGrowth','ThermalEquilibriumResponse').replace('range(5)','range(4)').replace('with volume :=','with temperature :=');(w/'prepare_thermalequilibrium1036_evidence.py').write_text(s);exec(compile(s,'prepare_thermalequilibrium1036_evidence.py','exec'))
pin='76f1b34e9e9682989adcbb088797b4ae4ce4fcf1';v3='/Volumes/One Touch/ernos-labs-sft-platform';cid=SPEC.claim_id
for name in ['claims/'+cid+'/execution.py','sft/physics/thermal_equilibrium_response_terminal_execution_v1.py','sft/physics/thermal_equilibrium_response_terminal_law_v1.py','generated/physics/thermal_equilibrium_response_terminal_validator_v1.py']:
 data=subprocess.check_output(['git','-C',v3,'show',pin+':'+name]);p=w/'v3-runtime500'/name;p.parent.mkdir(parents=True,exist_ok=True);p.write_bytes(data)
def sub(s):return s.replace('inflation_growth_terminal','thermal_equilibrium_response_terminal').replace('SFT-PHYS-INFLATION-GROWTH-TERMINAL-039',cid).replace('InflationGrowth','ThermalEquilibriumResponse').replace('inflation1035','thermalequilibrium1036').replace('1035','1036').replace('InflationGrammar','ThermalEquilibriumGrammar')
for k in ['program','fresh','independent']:(w/f'check_thermalequilibrium1036_{k}.py').write_text(sub((w/f'check_inflation1035_{k}.py').read_text()))
(w/'run_thermalequilibrium1036_native.py').write_text(sub((w/'run_inflation1035_native.py').read_text()));(r/'ThermalEquilibriumResponseProgram1036.lean').write_text(sub((r/'InflationGrowthProgram1035.lean').read_text()));print('Prepared original four witnesses and source entry methods')
