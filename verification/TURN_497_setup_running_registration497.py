from pathlib import Path
import json
scopes={
'StrongRunning':'Exact original self_sourced_level_count loop with one retained source and binary_count from Fold/generator at every successor; loop equivalence and universal 1+2k formula, exact binary successor, strict growth, positivity, complete ordered colour and neutral prefixes and original integer/Boolean guards. Full original eight-axis256 product, program methods, closure/controls and independent validator. Structural count direction only, preserving the original measured-beta exclusion.',
'VacuumPolarization':'Original vacuum_polarization_support calls the completed full binary vacuum-floor selection and exact Fold, retains the strict increase and exposed-One guards, proves unique returned endpoints and strict increase for every returned pair. Full original eight-axis256 product, program methods, closure/controls and independent validator. Original empirical scale and measured-beta exclusions unchanged.'}
for stem,spec,source,axes,cid in json.load(open('work/running497_entries.json')):
 low=stem.lower();s=Path('work/register_colour496.py').read_text().replace('496','497').replace('495','496').replace('ColourCouplingDerivation',stem).replace('ColourCoupling',stem).replace('colour497',low+'497').replace('Colour497',stem+'497').replace('COLOUR_COUPLING',spec.removesuffix('_SPEC')).replace('SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001',cid).replace('sft/physics/atomic_constants.py','sft/physics/'+source+'.py').replace('seven-axis128','eight-axis256').replace('complete128','complete256').replace('full128','full256').replace('=128','=256').replace('+128','+256')
 a=s.index('scopes=');b=s.index('\nfor rel in modules:',a);s=s[:a]+'scopes='+repr(scopes)+s[b:]
 # Native runner uses stem497 file names; existing registrar aliases use lower_program497.
 Path('work/register_'+low+'497.py').write_text(s)
 Path('work/'+low+'_program497.py').write_text(Path('work/check_'+low+'497.py').read_text())
 Path('work/'+low+'_independent497.py').write_text(Path('work/'+low+'497_independent.py').read_text())
Path('work/running497_scopes.json').write_text(json.dumps(scopes,indent=2))
