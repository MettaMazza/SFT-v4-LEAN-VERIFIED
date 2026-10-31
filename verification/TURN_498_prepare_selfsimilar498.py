from pathlib import Path
s=Path('work/prepare_limitcontinuum400.py').read_text().replace('work/pinned-constants/mathematics_lineage_laws.py','work/mathematics_lineage_laws497.py').replace('LIMIT_CONTINUUM','SELF_SIMILAR_CONVERGENCE').replace('LimitContinuum','SelfSimilar').replace('SFT-MATH-LIMIT-CONTINUUM-002','SFT-MATH-SELF-SIMILAR-CONVERGENCE-002').replace('limitcontinuum_census400','selfsimilar_census498').replace('LimitComputations','SelfSimilarConvergence')
s=s.replace("['finiteRungs','quadraticWitness','cubicWitness','closureWitness']","['originalLocalWitness','originalSupportWitness','originalExponentWitness','originalGapWitness','originalBracketWitness']").replace("['finiteRungsPassed','quadraticPassed','cubicPassed','closurePassed']","['originalLocalWitnessPassed','originalSupportWitnessPassed','originalExponentWitnessPassed','originalGapWitnessPassed','originalBracketWitnessPassed']").replace('with object :=','with scale :=')
Path('work/prepare_selfsimilar498_adapter.py').write_text(s)
exec(compile(s,'selfsimilar_adapter','exec'),{})
import json
mods=json.load(open('work/selfsimilar_census498_config.json'))[0]['modules'];mods=['SelfSimilarConvergence','SelfSimilarWitnesses']+[m for m in mods if m!='SelfSimilarWitnesses'];Path('work/selfsimilar498_modules.json').write_text(json.dumps(mods,indent=2))
s=Path('work/build_sector498.py').read_text().replace('sector498','selfsimilar498').replace('SFT/Physics','SFT/Mathematics').replace('complete_candidates=4096,full_census_blocks=64,all_cases_per_block=64','complete_candidates=256,full_census_blocks=16,all_cases_per_block=16').replace(' if i < 2: continue\n','')
Path('work/build_selfsimilar498.py').write_text(s)
