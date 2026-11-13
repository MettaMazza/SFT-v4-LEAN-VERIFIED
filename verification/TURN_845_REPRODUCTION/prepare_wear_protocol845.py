from pathlib import Path
ns={};exec(Path('work/wear_source845.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.WearMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.WearMaterialSource\n';(r/'WearMaterialSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/wear_source845.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.WearMaterialExperiment').replace('MaterialEvidence','WearMaterialEvidence').replace('Materials/MaterialExperiment.lean','Materials/WearMaterialExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.WearMaterialSource\nimport SFT.Materials.WearMaterialEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','WearMaterialExperiment').replace('MaterialValidation','WearMaterialValidation').replace('MaterialSource.extractTarget','WearMaterialSource.extractTarget');(r/'WearMaterialValidation.lean').write_text(s)
