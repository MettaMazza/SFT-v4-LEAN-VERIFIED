from pathlib import Path
import json
r=Path('work/constants-recovery/SFT/Mathematics');s=''.join(f'import SFT.Mathematics.PrimePairBlock{i}\n' for i in range(50))+''.join(f'import SFT.Mathematics.PrimeTwinBlock{i}\n' for i in range(10))+'import SFT.Mathematics.PrimePairDerivation\nnamespace SFT.Mathematics.PrimePairCensus\nset_option maxRecDepth 200000\nset_option maxHeartbeats 100000000\n'
s+='def completeCensus := '+ ' ++ '.join(f'censusBlock {i*100} {min(100,4999-i*100)}' for i in range(50))+'\n'
s+='theorem completeCensusPassed : completeCensus.all (fun row => row.2.isSome)=true := by\n unfold completeCensus\n rw [PrimePairDerivation.allAppend' + ',PrimePairDerivation.allAppend'*48 + ']\n change '+ ' && '.join(f'blockPassed {i*100} {min(100,4999-i*100)}' for i in range(50))+'=true\n rw ['+','.join(f'block{i}' for i in range(50))+']\n rfl\n'
s+='theorem completeCensusInputs : completeCensus.map Prod.fst = (List.range 4999).map evenAt := by decide\n'
s+='theorem completeCensusCount : completeCensus.length=4999 := by decide\n'
s+='def completeTwins := '+' ++ '.join(f'twinBlock{i}' for i in range(10))+'\n'
s+='theorem completeTwinCount : completeTwins.length=205 := by\n unfold completeTwins\n rw [SFT.Foundation.CommonRefinement.appendLength'+',SFT.Foundation.CommonRefinement.appendLength'*8+']\n rw ['+','.join(f'twinCount{i}' for i in range(10))+']\n'
s+='end SFT.Mathematics.PrimePairCensus\n';s='import SFT.Foundation.CommonRefinement\n'+s;(r/'PrimePairComplete.lean').write_text(s)
