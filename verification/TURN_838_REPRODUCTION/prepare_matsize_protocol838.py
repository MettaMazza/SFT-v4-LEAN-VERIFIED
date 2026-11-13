from pathlib import Path
ns={};exec(Path('work/matsize_source838.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.SizeMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.SizeMaterialSource\n';(r/'SizeMaterialSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/matsize_source838.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.SizeMaterialExperiment').replace('MaterialEvidence','SizeMaterialEvidence').replace('Materials/MaterialExperiment.lean','Materials/SizeMaterialExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.SizeMaterialSource\nimport SFT.Materials.SizeMaterialEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','SizeMaterialExperiment').replace('MaterialValidation','SizeMaterialValidation').replace('MaterialSource.extractTarget','SizeMaterialSource.extractTarget');(r/'SizeMaterialValidation.lean').write_text(s)
