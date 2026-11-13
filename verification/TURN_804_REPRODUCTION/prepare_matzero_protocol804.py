from pathlib import Path
ns={};exec(Path('work/matzero_source804.py').read_text().split('registration=')[0],ns);spec=ns['spec'];namespace=ns['namespace'];binding=namespace['BINDING_BY_CLAIM'][spec.claim_id];q=ns['q'];r=Path('work/constants-recovery/SFT/Materials')
s='''import SFT.Materials.MaterialSource
namespace SFT.Materials.ZeroResistanceSource
open SFT.Host SFT.Host.Canonical MaterialSource
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
'''
s+='def requirements : List MaterialSource.Requirement := ['+','.join('⟨'+q(x.source_id)+','+q(x.fragment)+'⟩' for x in binding.requirements)+']\n'
s+='def expectedLabel : String := '+q(spec.expected_observation_label)+'\n'
old=(r/'MaterialSource.lean').read_text();a=old.index('def extractRequirements');b=old.index('theorem originalSourceIdentity',a);s+=old[a:b]+'end SFT.Materials.ZeroResistanceSource\n';(r/'ZeroResistanceSource.lean').write_text(s)
gen=Path('work/prepare_material_validator652.py').read_text().replace("exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0])","exec(open('work/prepare_material_source652.py').read().split(\"s='''\")[0].replace('work/material_source651.py','work/matzero_source804.py'))")
gen=gen.replace('SFT.Materials.MaterialExperiment','SFT.Materials.ZeroResistanceExperiment').replace('MaterialEvidence','ZeroResistanceEvidence').replace('Materials/MaterialExperiment.lean','Materials/ZeroResistanceExperiment.lean')
gen=gen.replace('import SFT.Materials.MaterialSource','import SFT.Materials.ZeroResistanceSource\nimport SFT.Materials.ZeroResistanceEvidence');exec(gen,{})
r=Path('work/constants-recovery/SFT/Materials')
s=(r/'MaterialValidation.lean').read_text().replace('MaterialExperiment','ZeroResistanceExperiment').replace('MaterialValidation','ZeroResistanceValidation').replace('MaterialSource.extractTarget','ZeroResistanceSource.extractTarget');(r/'ZeroResistanceValidation.lean').write_text(s)
