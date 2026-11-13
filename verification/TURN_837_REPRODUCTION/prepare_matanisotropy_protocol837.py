from pathlib import Path
ns={};exec(Path('work/matanisotropy_source837.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.AnisotropyMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.AnisotropyMaterialSource\n';(r/'AnisotropyMaterialSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/matanisotropy_source837.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.AnisotropyMaterialExperiment').replace('MaterialEvidence','AnisotropyMaterialEvidence').replace('Materials/MaterialExperiment.lean','Materials/AnisotropyMaterialExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.AnisotropyMaterialSource\nimport SFT.Materials.AnisotropyMaterialEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','AnisotropyMaterialExperiment').replace('MaterialValidation','AnisotropyMaterialValidation').replace('MaterialSource.extractTarget','AnisotropyMaterialSource.extractTarget');(r/'AnisotropyMaterialValidation.lean').write_text(s)
