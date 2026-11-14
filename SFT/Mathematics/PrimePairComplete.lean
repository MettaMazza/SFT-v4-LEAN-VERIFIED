import SFT.Foundation.CommonRefinement
import SFT.Mathematics.PrimePairBlock0
import SFT.Mathematics.PrimePairBlock1
import SFT.Mathematics.PrimePairBlock2
import SFT.Mathematics.PrimePairBlock3
import SFT.Mathematics.PrimePairBlock4
import SFT.Mathematics.PrimePairBlock5
import SFT.Mathematics.PrimePairBlock6
import SFT.Mathematics.PrimePairBlock7
import SFT.Mathematics.PrimePairBlock8
import SFT.Mathematics.PrimePairBlock9
import SFT.Mathematics.PrimePairBlock10
import SFT.Mathematics.PrimePairBlock11
import SFT.Mathematics.PrimePairBlock12
import SFT.Mathematics.PrimePairBlock13
import SFT.Mathematics.PrimePairBlock14
import SFT.Mathematics.PrimePairBlock15
import SFT.Mathematics.PrimePairBlock16
import SFT.Mathematics.PrimePairBlock17
import SFT.Mathematics.PrimePairBlock18
import SFT.Mathematics.PrimePairBlock19
import SFT.Mathematics.PrimePairBlock20
import SFT.Mathematics.PrimePairBlock21
import SFT.Mathematics.PrimePairBlock22
import SFT.Mathematics.PrimePairBlock23
import SFT.Mathematics.PrimePairBlock24
import SFT.Mathematics.PrimePairBlock25
import SFT.Mathematics.PrimePairBlock26
import SFT.Mathematics.PrimePairBlock27
import SFT.Mathematics.PrimePairBlock28
import SFT.Mathematics.PrimePairBlock29
import SFT.Mathematics.PrimePairBlock30
import SFT.Mathematics.PrimePairBlock31
import SFT.Mathematics.PrimePairBlock32
import SFT.Mathematics.PrimePairBlock33
import SFT.Mathematics.PrimePairBlock34
import SFT.Mathematics.PrimePairBlock35
import SFT.Mathematics.PrimePairBlock36
import SFT.Mathematics.PrimePairBlock37
import SFT.Mathematics.PrimePairBlock38
import SFT.Mathematics.PrimePairBlock39
import SFT.Mathematics.PrimePairBlock40
import SFT.Mathematics.PrimePairBlock41
import SFT.Mathematics.PrimePairBlock42
import SFT.Mathematics.PrimePairBlock43
import SFT.Mathematics.PrimePairBlock44
import SFT.Mathematics.PrimePairBlock45
import SFT.Mathematics.PrimePairBlock46
import SFT.Mathematics.PrimePairBlock47
import SFT.Mathematics.PrimePairBlock48
import SFT.Mathematics.PrimePairBlock49
import SFT.Mathematics.PrimeTwinBlock0
import SFT.Mathematics.PrimeTwinBlock1
import SFT.Mathematics.PrimeTwinBlock2
import SFT.Mathematics.PrimeTwinBlock3
import SFT.Mathematics.PrimeTwinBlock4
import SFT.Mathematics.PrimeTwinBlock5
import SFT.Mathematics.PrimeTwinBlock6
import SFT.Mathematics.PrimeTwinBlock7
import SFT.Mathematics.PrimeTwinBlock8
import SFT.Mathematics.PrimeTwinBlock9
import SFT.Mathematics.PrimePairDerivation
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def completeCensus := censusBlock 0 100 ++ censusBlock 100 100 ++ censusBlock 200 100 ++ censusBlock 300 100 ++ censusBlock 400 100 ++ censusBlock 500 100 ++ censusBlock 600 100 ++ censusBlock 700 100 ++ censusBlock 800 100 ++ censusBlock 900 100 ++ censusBlock 1000 100 ++ censusBlock 1100 100 ++ censusBlock 1200 100 ++ censusBlock 1300 100 ++ censusBlock 1400 100 ++ censusBlock 1500 100 ++ censusBlock 1600 100 ++ censusBlock 1700 100 ++ censusBlock 1800 100 ++ censusBlock 1900 100 ++ censusBlock 2000 100 ++ censusBlock 2100 100 ++ censusBlock 2200 100 ++ censusBlock 2300 100 ++ censusBlock 2400 100 ++ censusBlock 2500 100 ++ censusBlock 2600 100 ++ censusBlock 2700 100 ++ censusBlock 2800 100 ++ censusBlock 2900 100 ++ censusBlock 3000 100 ++ censusBlock 3100 100 ++ censusBlock 3200 100 ++ censusBlock 3300 100 ++ censusBlock 3400 100 ++ censusBlock 3500 100 ++ censusBlock 3600 100 ++ censusBlock 3700 100 ++ censusBlock 3800 100 ++ censusBlock 3900 100 ++ censusBlock 4000 100 ++ censusBlock 4100 100 ++ censusBlock 4200 100 ++ censusBlock 4300 100 ++ censusBlock 4400 100 ++ censusBlock 4500 100 ++ censusBlock 4600 100 ++ censusBlock 4700 100 ++ censusBlock 4800 100 ++ censusBlock 4900 99
theorem completeCensusPassed : completeCensus.all (fun row => row.2.isSome)=true := by
 unfold completeCensus
 rw [PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend]
 change blockPassed 0 100 && blockPassed 100 100 && blockPassed 200 100 && blockPassed 300 100 && blockPassed 400 100 && blockPassed 500 100 && blockPassed 600 100 && blockPassed 700 100 && blockPassed 800 100 && blockPassed 900 100 && blockPassed 1000 100 && blockPassed 1100 100 && blockPassed 1200 100 && blockPassed 1300 100 && blockPassed 1400 100 && blockPassed 1500 100 && blockPassed 1600 100 && blockPassed 1700 100 && blockPassed 1800 100 && blockPassed 1900 100 && blockPassed 2000 100 && blockPassed 2100 100 && blockPassed 2200 100 && blockPassed 2300 100 && blockPassed 2400 100 && blockPassed 2500 100 && blockPassed 2600 100 && blockPassed 2700 100 && blockPassed 2800 100 && blockPassed 2900 100 && blockPassed 3000 100 && blockPassed 3100 100 && blockPassed 3200 100 && blockPassed 3300 100 && blockPassed 3400 100 && blockPassed 3500 100 && blockPassed 3600 100 && blockPassed 3700 100 && blockPassed 3800 100 && blockPassed 3900 100 && blockPassed 4000 100 && blockPassed 4100 100 && blockPassed 4200 100 && blockPassed 4300 100 && blockPassed 4400 100 && blockPassed 4500 100 && blockPassed 4600 100 && blockPassed 4700 100 && blockPassed 4800 100 && blockPassed 4900 99=true
 rw [block0,block1,block2,block3,block4,block5,block6,block7,block8,block9,block10,block11,block12,block13,block14,block15,block16,block17,block18,block19,block20,block21,block22,block23,block24,block25,block26,block27,block28,block29,block30,block31,block32,block33,block34,block35,block36,block37,block38,block39,block40,block41,block42,block43,block44,block45,block46,block47,block48,block49]
 rfl
theorem completeCensusInputs : completeCensus.map Prod.fst = (List.range 4999).map evenAt := by decide
theorem completeCensusCount : completeCensus.length=4999 := by decide
def completeTwins := twinBlock0 ++ twinBlock1 ++ twinBlock2 ++ twinBlock3 ++ twinBlock4 ++ twinBlock5 ++ twinBlock6 ++ twinBlock7 ++ twinBlock8 ++ twinBlock9
theorem completeTwinCount : completeTwins.length=205 := by
 unfold completeTwins
 rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.appendLength]
 rw [twinCount0,twinCount1,twinCount2,twinCount3,twinCount4,twinCount5,twinCount6,twinCount7,twinCount8,twinCount9]
end SFT.Mathematics.PrimePairCensus
