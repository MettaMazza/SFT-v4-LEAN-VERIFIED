from pathlib import Path
ns={};exec(Path('work/functionalmagnetic_source852.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.FunctionalMagneticMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.FunctionalMagneticMaterialSource\n';(r/'FunctionalMagneticMaterialSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/functionalmagnetic_source852.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.FunctionalMagneticMaterialExperiment').replace('MaterialEvidence','FunctionalMagneticMaterialEvidence').replace('Materials/MaterialExperiment.lean','Materials/FunctionalMagneticMaterialExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.FunctionalMagneticMaterialSource\nimport SFT.Materials.FunctionalMagneticMaterialEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','FunctionalMagneticMaterialExperiment').replace('MaterialValidation','FunctionalMagneticMaterialValidation').replace('MaterialSource.extractTarget','FunctionalMagneticMaterialSource.extractTarget');(r/'FunctionalMagneticMaterialValidation.lean').write_text(s)
