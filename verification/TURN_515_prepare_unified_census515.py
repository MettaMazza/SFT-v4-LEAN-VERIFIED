from pathlib import Path
import ast,json,re,subprocess,itertools,math
p=Path('work/spatial268.py');t=p.read_text();t=t[:t.index('witness=')]
t=t.replace("Path('/Volumes/One Touch/SFT v4 Full model LEAN')","Path('work/constants-recovery')").replace('sft/physics/structural_constants.py','sft/physics/unified_constants_object_law_v1.py').replace("=='SPATIAL_THREE_SPEC'","=='SPEC'").replace("cid='SFT-PHYS-SPACE-DIMENSION-THREE-001'","cid=lit('claim_id')").replace('SpatialStability','UnifiedConstants').replace('SpatialThree','UnifiedConstants').replace("'i==8'","'i==11'").replace("'= 1024'","'= 4096'").replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨'+','.join(['rfl']*12)+'⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩','⟨'+','.join('h'+str(i) for i in range(12))+'⟩').replace('cases h6; cases h7; cases h8','; '.join('cases h'+str(i) for i in range(6,12)))
exec(compile(t,'original-common-axis-grammar','exec'))
assert len(fields)==12 and math.prod(len(x[2]) for x in fields)==4096
stem='UnifiedConstants';folder=r/'SFT/Physics';p=folder/(stem+'Grammar.lean');s=p.read_text();cut=s.index('set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria');tail=s.index('theorem uniqueSurvivor',cut);base=stem+'GrammarBase';(folder/(base+'.lean')).write_text(s[:cut].replace('set_option maxRecDepth 20000','set_option maxRecDepth 100000\nset_option maxHeartbeats 100000000')+'\nend SFT.Physics.'+stem+'Grammar\n')
prefixes=list(itertools.product(*[f[2] for f in fields[:7]]));mods=[];names=[f[0] for f in fields]
for i,prefix in enumerate(prefixes):
 m=stem+'Census'+str(i);mods.append(m);cand='⟨'+','.join(['.'+x for x in prefix]+names[7:])+'⟩';args=' '.join('('+f[0]+' : '+f[1]+')' for f in fields[7:]);cases=' <;> '.join('cases '+n for n in names[7:]);text='import SFT.Physics.'+base+'\nnamespace SFT.Physics.'+stem+'Grammar\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n'
 text+='theorem decisionCensus'+str(i)+' '+args+' : survives '+cand+' = criteriaDecision '+cand+' := by\n '+cases+'\n all_goals rfl\n'
 text+='theorem uniqueCensus'+str(i)+' '+args+' : criteriaDecision '+cand+' = true ↔ ('+cand+' : Candidate) = survivor := by\n '+cases+'\n all_goals constructor <;> intro h <;> first | rfl | cases h\nend SFT.Physics.'+stem+'Grammar\n';(folder/(m+'.lean')).write_text(text)
text=''.join('import SFT.Physics.'+m+'\n' for m in [base]+mods)+'namespace SFT.Physics.'+stem+'Grammar\nopen SFT.Foundation\nset_option maxRecDepth 100000\nset_option maxHeartbeats 100000000\n'
for theorem,prefix,goal in [('sourceDecisionMatchesCriteria','decision','survives c = criteriaDecision c'),('uniqueCriteriaSurvivor','unique','criteriaDecision c = true ↔ c = survivor')]:
 text+='theorem '+theorem+' (c : Candidate) : '+goal+' := by\n cases c with\n | mk '+' '.join(names)+' =>\n  '+' <;> '.join('cases '+n for n in names[:7])+'\n';text+=''.join('  · exact '+prefix+'Census'+str(i)+' '+' '.join(names[7:])+'\n' for i in range(len(prefixes)))
text+=s[tail:];p.write_text(text)
Path('work/unified515_census_modules.json').write_text(json.dumps([base]+mods+[stem+'Grammar'],indent=2)+'\n')
Path('work/unified515_source_metadata.json').write_text(json.dumps(dict(claim_id=cid,source_path='sft/physics/unified_constants_object_law_v1.py',candidate_count=4096,axis_count=12,fields=fields,witnesses=[(literal(w.args[0]),literal(w.args[1])) for w in kw['witnesses'].elts]),indent=2)+'\n')
print('Retained all12 axes and4096 alternatives in128 full32-case census shards')
