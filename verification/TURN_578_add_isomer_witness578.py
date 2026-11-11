from pathlib import Path
import itertools,json
p=Path('work/constants-recovery/SFT/Chemistry/MolecularIsomer.lean');s=p.read_text();s=s.replace('end SFT.Chemistry.MolecularIsomer','');q=lambda x:json.dumps(x,separators=(',',':'));labels=['w','x','y','z'];names={}
for size in range(1,5):
 for subset in itertools.combinations(labels,size):
  name='branchOrders'+''.join(subset);names[subset]=name;perms=[list(x) for x in itertools.permutations(subset)]
  s+='\ntheorem '+name+' : arrangementsCore '+q(list(subset))+'='+q(perms)+' := by\n'
  if size==1:s+=' exact arrangementsSingle _\n'
  else:
   s+=' rw [arrangementsStepByValues]\n change '+ ' ++ '.join('(arrangementsCore '+q([y for y in subset if y!=x])+').map (List.cons '+q(x)+')' for x in subset)+' ++ [] = '+q(perms)+'\n'
   s+=' rw ['+','.join(names[tuple(y for y in subset if y!=x)] for x in subset)+']\n rfl\n'
s+='''
def originalChain : Raw := ⟨["a","b","c","d"],["E","E","E","E"],[("a","b"),("b","c"),("c","d")],[]⟩
def originalBranch : Raw := ⟨["w","x","y","z"],["E","E","E","E"],[("w","x"),("w","y"),("w","z")],[]⟩
theorem originalSameComposition : MolecularCarrier.compositionSignature originalChain=MolecularCarrier.compositionSignature originalBranch := rfl

theorem originalChainBranchDistinct : structurallyEquivalent originalChain originalBranch=false := by
 unfold structurallyEquivalent
 rw [ite_eq_left originalSameComposition]
 change (arrangementsCore ["w","x","y","z"]).any (candidateMatches originalChain originalBranch)=false
 rw [branchOrderswxyz]
 rfl

theorem originalIsomerPair : molecularIsomers originalChain originalBranch=true := by
 unfold molecularIsomers
 rw [originalChainBranchDistinct]
 rfl

theorem originalSelfEquivalent : structurallyEquivalent originalChain originalChain=true := by
 apply (completeRelabellingSearch _ _ (by intro h; cases h) (by decide)).mpr
 exact ⟨rfl,originalChain.occurrences,List.Perm.refl _,by decide⟩
end SFT.Chemistry.MolecularIsomer
''';p.write_text(s)
