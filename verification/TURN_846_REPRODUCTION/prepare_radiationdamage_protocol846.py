from pathlib import Path
ns={};exec(Path('work/radiationdamage_source846.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.RadiationDamageMaterialSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.RadiationDamageMaterialSource\n';(r/'RadiationDamageMaterialSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/radiationdamage_source846.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.RadiationDamageMaterialExperiment').replace('MaterialEvidence','RadiationDamageMaterialEvidence').replace('Materials/MaterialExperiment.lean','Materials/RadiationDamageMaterialExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.RadiationDamageMaterialSource\nimport SFT.Materials.RadiationDamageMaterialEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','RadiationDamageMaterialExperiment').replace('MaterialValidation','RadiationDamageMaterialValidation').replace('MaterialSource.extractTarget','RadiationDamageMaterialSource.extractTarget');(r/'RadiationDamageMaterialValidation.lean').write_text(s)
