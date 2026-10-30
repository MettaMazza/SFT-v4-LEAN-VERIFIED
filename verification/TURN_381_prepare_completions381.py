from pathlib import Path
import json,re
r=Path('work/constants-recovery')
orbit=['OrbitOrderIdentity','OrbitBinaryDepth','OrbitCycleSupport','OrbitNumberWitnessBase','OrbitReplayCorrespondence']+['OrbitWitness'+str(q) for q in range(3,100,2)]+['OrbitNumberWitnesses','OrbitCyclotomic','OrbitTilingCount','OrbitOrderExistence','OrbitLoopCompletion','OrbitWitnesses']+[m for m in json.loads(Path('work/orbit_census381_config.json').read_text())[0]['modules'] if m!='OrbitWitnesses']
config=json.loads(Path('work/bounded_census379_config.json').read_text())
force=['PrimeSectorLadder']+next(x['modules'] for x in config if x['name']=='ForceLadder')
planck=['PlanckHierarchy','PlanckBaseGrammar','PlanckBaseWitnesses','PlanckBaseControls','PlanckBaseEvidence']
rows=[]
for kind,cid,ns,mods,src in [('orbit','SFT-MATH-ORBIT-NUMBER-THEORY-002','Mathematics',orbit,'sft/mathematics/lineage_laws.py'),('force_ladder','SFT-PHYS-FORCE-PRIME-SECTOR-LADDER-002','Physics',force,'sft/physics/lineage_particle_laws.py'),('planck_base','SFT-PHYS-SCALE-PROTON-PLANCK-HIERARCHY-002','Physics',planck,'sft/physics/lineage_particle_laws.py')]:
 names=[];theorems=[];out=[]
 for m in mods:
  p=r/'SFT'/ns/(m+'.lean');s=p.read_text();namespace=re.search(r'^namespace ([\w.]+)',s,re.M)[1]
  names += [namespace+'.'+n for n in re.findall(r'^\s*(?:def|theorem) (\w+)',s,re.M)]
  theorems += [namespace+'.'+n for n in re.findall(r'^theorem (\w+)',s,re.M)]
  out.append('import SFT.'+ns+'.'+m)
 (r/(kind+'Completion381Audit.lean')).write_text('\n'.join(out+['#print axioms '+n for n in names])+'\n')
 rows.append(dict(kind=kind,claim_id=cid,namespace=ns,modules=mods,source=src,declarations=names,theorems=theorems))
 print(kind,len(mods),len(names),len(theorems))
Path('work/completions381_config.json').write_text(json.dumps(rows,indent=2)+'\n')
