from pathlib import Path
ns={};exec(Path('work/matplasticity_source814.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.PlasticitySource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.PlasticitySource\n';(r/'PlasticitySource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/matplasticity_source814.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.PlasticityExperiment').replace('MaterialEvidence','PlasticityEvidence').replace('Materials/MaterialExperiment.lean','Materials/PlasticityExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.PlasticitySource\nimport SFT.Materials.PlasticityEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','PlasticityExperiment').replace('MaterialValidation','PlasticityValidation').replace('MaterialSource.extractTarget','PlasticitySource.extractTarget');(r/'PlasticityValidation.lean').write_text(s)
