import SFT.Physics.NuclearBindingScoresBatch03
import SFT.Physics.NuclearBindingFoldComposition
namespace SFT.Physics.NuclearBindingFoldsBatch03
open NuclearBindingPeak NuclearBindingFoldComposition LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def winner1 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedBest1 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def afterBest1 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedUpper1 : Rat := normalize 18213513786935371 19508932432559680 (by decide)
def afterUpper1 : Rat := normalize 18213513786935371 19508932432559680 (by decide)
theorem best1 : NuclearBindingScoresBatch03.scores1.foldl bestStep seedBest1 = afterBest1 := rfl
theorem upper1 : (NuclearBindingScoresBatch03.scores1.filter (fun row => !sameCoordinate row winner1)).foldl upperStep seedUpper1 = afterUpper1 := rfl
def winner2 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedBest2 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def afterBest2 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedUpper2 : Rat := normalize 6068986873815283 6529849285278240 (by decide)
def afterUpper2 : Rat := normalize 6068986873815283 6529849285278240 (by decide)
theorem best2 : NuclearBindingScoresBatch03.scores2.foldl bestStep seedBest2 = afterBest2 := rfl
theorem upper2 : (NuclearBindingScoresBatch03.scores2.filter (fun row => !sameCoordinate row winner2)).foldl upperStep seedUpper2 = afterUpper2 := rfl
def winner4 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedBest4 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def afterBest4 : Scored := ⟨64,28,normalize 2387558790464861 2579693544801280 (by decide),normalize 2387558790464861 2579693544801280 (by decide)⟩
def seedUpper4 : Rat := normalize 71771198351782703 77471421767313440 (by decide)
def afterUpper4 : Rat := normalize 71771198351782703 77471421767313440 (by decide)
theorem best4 : NuclearBindingScoresBatch03.scores4.foldl bestStep seedBest4 = afterBest4 := rfl
theorem upper4 : (NuclearBindingScoresBatch03.scores4.filter (fun row => !sameCoordinate row winner4)).foldl upperStep seedUpper4 = afterUpper4 := rfl
def winner8 : Scored := ⟨62,28,normalize 9080439588063887159 9809818781286064340 (by decide),normalize 1515016807116167539 1636583784834496420 (by decide)⟩
def seedBest8 : Scored := ⟨62,28,normalize 9080439588063887159 9809818781286064340 (by decide),normalize 1515016807116167539 1636583784834496420 (by decide)⟩
def afterBest8 : Scored := ⟨62,28,normalize 9080439588063887159 9809818781286064340 (by decide),normalize 1515016807116167539 1636583784834496420 (by decide)⟩
def seedUpper8 : Rat := normalize 7773977012907656069 8398424104442482780 (by decide)
def afterUpper8 : Rat := normalize 7773977012907656069 8398424104442482780 (by decide)
theorem best8 : NuclearBindingScoresBatch03.scores8.foldl bestStep seedBest8 = afterBest8 := rfl
theorem upper8 : (NuclearBindingScoresBatch03.scores8.filter (fun row => !sameCoordinate row winner8)).foldl upperStep seedUpper8 = afterUpper8 := rfl
end SFT.Physics.NuclearBindingFoldsBatch03
