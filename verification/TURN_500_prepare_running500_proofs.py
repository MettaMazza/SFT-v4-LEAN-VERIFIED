from pathlib import Path
import json,itertools
r=Path('work/constants-recovery/SFT/Physics');a=json.load(open('work/running500_axes.json'));fields=a['fields'];types=a['types'];choices=a['choices']
s='import SFT.Physics.RunningConvergenceGrammarBase\nnamespace SFT.Physics.RunningConvergenceGrammar\nopen RunningConvergence\nset_option maxRecDepth 20000\nset_option maxHeartbeats 4000000\n'
for f,t,ch in zip(fields,types,choices):
 s+='\ntheorem '+f+'Computed (x : '+t+') : '+f+'IsForced x = (match x with '+ ' '.join('| .c'+str(i)+' => '+('true' if i==0 else 'false') for i in range(len(ch)))+') := by\n cases x\n'
 for i in range(len(ch)):
  s+=' · unfold '+f+'IsForced\n'
  if f=='sectorDomain':s+='   rw [PrimeSectorLadder.completeLadder]\n'
  elif f=='couplingForm':s+='   unfold couplingObservation generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount\n   rw [PrimeSectorLadder.completeLadder]\n'
  elif f=='successorLaw' and i==0:s+='   unfold successorObservation\n   rw [PrimeSectorLadder.completeLadder]\n   unfold couplingSuccessorTake generatorIndexedCoupling SectorInventory.runningCoupling SectorInventory.chargeKindCount\n   rw [PrimeSectorLadder.completeLadder]\n'
  elif f=='pairGapLaw':s+='   unfold gapObservation generatorPairGap SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount\n   rw [PrimeSectorLadder.completeLadder]\n'
  elif f=='convergenceLaw' and i==0:
   s+='   unfold convergenceObservation formalCertificate orderedSectorPairs\n   rw [PrimeSectorLadder.completeLadder]\n   unfold commonScaleVector couplingShortfall couplingSuccessorTake pairGapSuccessorTake convergenceWitness generatorPairGap generatorIndexedCoupling SectorInventory.runningGap SectorInventory.runningCoupling SectorInventory.chargeKindCount\n   rw [PrimeSectorLadder.completeLadder]\n'
  s+='   rfl\n'
s+='\nend SFT.Physics.RunningConvergenceGrammar\n';(r/'RunningConvergencePredicates.lean').write_text(s)
# Exhaust every original form, partitioned by the first three axes. No alternatives removed.
mods=['RunningConvergence','RunningConvergenceGrammarBase','RunningConvergencePredicates']
for i,fixed in enumerate(itertools.product(range(3),repeat=3)):
 name='RunningConvergenceCensus'+str(i);mods.append(name)
 s='import SFT.Physics.RunningConvergencePredicates\nnamespace SFT.Physics.RunningConvergenceGrammar\nset_option maxRecDepth 20000\nset_option maxHeartbeats 12000000\n'
 args=' '.join('('+f+' : '+t+')' for f,t in zip(fields[3:],types[3:]))
 cand='⟨'+','.join(['.c'+str(n) for n in fixed]+fields[3:])+'⟩'
 s+='theorem uniqueCensus'+str(i)+' '+args+' : survives '+cand+' = true ↔ ('+cand+' : Candidate) = survivor := by\n'
 s+=' unfold survives candidateFacts\n simp only ['+','.join(f+'Computed' for f in fields)+']\n'
 s+=' '+' <;> '.join('cases '+f for f in fields[3:])+'\n all_goals constructor <;> intro h <;> first | rfl | cases h\n'
 s+='end SFT.Physics.RunningConvergenceGrammar\n';(r/(name+'.lean')).write_text(s)
s='\n'.join('import SFT.Physics.'+m for m in mods[3:])+'\nnamespace SFT.Physics.RunningConvergenceGrammar\n'
s+='theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by\n cases c with\n | mk '+' '.join(fields)+' =>\n  '+' <;> '.join('cases '+f for f in fields[:3])+'\n'
s+=''.join('  · exact uniqueCensus'+str(i)+' '+' '.join(fields[3:])+'\n' for i in range(27))
s+='theorem survivorPasses : survives survivor = true := (uniqueSurvivor survivor).mpr rfl\nend SFT.Physics.RunningConvergenceGrammar\n';(r/'RunningConvergenceGrammar.lean').write_text(s);mods+=['RunningConvergenceGrammar'];Path('work/running500_modules.json').write_text(json.dumps(mods,indent=2))
