from pathlib import Path
import ast,json,itertools
src=Path('work/sector_inventory_law_v1497.py').read_text();tree=ast.parse(src);spec=next(n.value for n in tree.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='SPEC');fn=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='axes')
for k in spec.keywords:
 if k.arg=='axes':k.value=next(n.value for n in fn.body if isinstance(n,ast.Return))
# Preserve the source import value as an explicit AST literal for the existing generator.
lineage=ast.parse(Path('work/lineage_particle_laws497.py').read_text());tree.body.insert(0,next(n for n in lineage.body if isinstance(n,ast.Assign) and getattr(n.targets[0],'id','')=='COMMON_EXCLUSIONS'))
Path('work/SectorInventory498_expanded.py').write_text(ast.unparse(tree))
s=Path('work/prepare_colour496.py').read_text().replace('ColourCouplingDerivation','SectorInventory').replace('ColourCoupling','SectorInventory').replace('COLOUR_COUPLING_SPEC','SPEC').replace('SFT-PHYS-NUCLEAR-COLOUR-COUPLING-001','SFT-PHYS-FORCE-COMPLETE-SECTOR-INVENTORY-003').replace("src=subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show',pin+':sft/physics/atomic_constants.py'],text=True)","src=Path('work/SectorInventory498_expanded.py').read_text()")
s=s.replace("if isinstance(n,(ast.Tuple,ast.List)):","if isinstance(n,ast.BinOp) and isinstance(n.op,ast.Add):return literal(n.left)+literal(n.right)\n if isinstance(n,(ast.Tuple,ast.List)):")
s=s.replace("'= 128'","'= 4096'").replace('work/colour_witness496.txt','work/sector_witness498.txt').replace("['exactCheck','reducedCheck','independentCheck']","['check0','check1','check2','check3','check4']").replace('with carrier :=','with sector :=')
s=s.replace("template=template.replace('namespace", "template=template.replace('i==6','i==11').replace('⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩','⟨'+','.join(['rfl']*12)+'⟩').replace('⟨h0,h1,h2,h3,h4,h5,h6⟩','⟨'+','.join('h'+str(i) for i in range(12))+'⟩').replace('cases h5; cases h6','cases h5; cases h6; cases h7; cases h8; cases h9; cases h10; cases h11');template=template.replace('namespace")
Path('work/prepare_sector498_adapter.py').write_text(s)
exec(compile(s,'sector_adapter','exec'),{})
r=Path('work/constants-recovery/SFT/Physics');p=r/'SectorInventoryGrammar.lean';old=p.read_text();cut=old.index('set_option maxHeartbeats 20000000 in\ntheorem sourceDecisionMatchesCriteria');(r/'SectorInventoryGrammarBase.lean').write_text(old[:cut]+'end SFT.Physics.SectorInventoryGrammar\n')
fields=['sector','charge','mediator','coupling','running','singlet','mixing','mass','inventory','measurement','record','extension'];types=[x.capitalize() for x in fields];mods=['SectorInventory','SectorInventoryGrammarBase']
for i,bits in enumerate(itertools.product([0,1],repeat=6)):
 m='SectorInventoryCensus'+str(i);mods.append(m);cand='⟨'+','.join(['.admitted' if b else '.rejected' for b in bits]+fields[6:])+'⟩';args=' '.join('('+f+' : '+t+')' for f,t in zip(fields[6:],types[6:]));cases=' <;> '.join('cases '+f for f in fields[6:]);out='import SFT.Physics.SectorInventoryGrammarBase\nnamespace SFT.Physics.SectorInventoryGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 20000000\n'
 out+='theorem decisionCensus'+str(i)+' '+args+' : survives '+cand+' = criteriaDecision '+cand+' := by\n '+cases+'\n all_goals rfl\n'
 out+='theorem uniqueCensus'+str(i)+' '+args+' : criteriaDecision '+cand+' = true ↔ ('+cand+' : Candidate) = survivor := by\n '+cases+'\n all_goals constructor <;> intro h <;> first | rfl | cases h\nend SFT.Physics.SectorInventoryGrammar\n';(r/(m+'.lean')).write_text(out)
out='\n'.join('import SFT.Physics.'+m for m in mods[2:])+'\nnamespace SFT.Physics.SectorInventoryGrammar\nopen SFT.Foundation\nset_option maxRecDepth 20000\n'
for name,ty,prefix in [('sourceDecisionMatchesCriteria','survives c = criteriaDecision c','decision'),('uniqueCriteriaSurvivor','criteriaDecision c = true ↔ c = survivor','unique')]:
 out+='theorem '+name+' (c : Candidate) : '+ty+' := by\n cases c with\n | mk '+' '.join(fields)+' =>\n  '+' <;> '.join('cases '+f for f in fields[:6])+'\n'+''.join('  · exact '+prefix+'Census'+str(i)+' '+' '.join(fields[6:])+'\n' for i in range(64))
out+=old[old.index('\ntheorem uniqueSurvivor'):];p.write_text(out);mods+=['SectorInventoryGrammar','SectorInventoryWitnesses','SectorInventoryControls','SectorInventoryEvidence'];Path('work/sector498_modules.json').write_text(json.dumps(mods,indent=2))
