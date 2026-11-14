import SFT.Physics.NuclearBindingPeakAssembly
import SFT.Physics.NuclearBindingFoldsBatch00
import SFT.Physics.NuclearBindingFoldsBatch01
import SFT.Physics.NuclearBindingFoldsBatch02
import SFT.Physics.NuclearBindingFoldsBatch03
import SFT.Physics.NuclearBindingFoldsBatch04
import SFT.Physics.NuclearBindingFoldsBatch05
import SFT.Physics.NuclearBindingFoldsBatch06
import SFT.Physics.NuclearBindingFoldsBatch07
import SFT.Physics.NuclearBindingFoldsBatch08
import SFT.Physics.NuclearBindingFoldsBatch09
import SFT.Physics.NuclearBindingFoldsBatch10
import SFT.Physics.NuclearBindingFoldsBatch11
import SFT.Physics.NuclearBindingFoldsBatch12
import SFT.Physics.NuclearBindingFoldsBatch13
import SFT.Physics.NuclearBindingFoldsBatch14
import SFT.Physics.NuclearBindingFoldsBatch15
import SFT.Physics.NuclearBindingFoldsBatch16
import SFT.Physics.NuclearBindingFoldsBatch17
import SFT.Physics.NuclearBindingFoldsBatch18
import SFT.Physics.NuclearBindingFoldsBatch19
import SFT.Physics.NuclearBindingFoldsBatch20
import SFT.Physics.NuclearBindingFoldsBatch21
import SFT.Physics.NuclearBindingFoldsBatch22
import SFT.Physics.NuclearBindingFoldsBatch23
import SFT.Physics.NuclearBindingFoldsBatch24
import SFT.Physics.NuclearBindingFoldsBatch25
import SFT.Physics.NuclearBindingFoldsBatch26
import SFT.Physics.NuclearBindingFoldsBatch27
import SFT.Physics.NuclearBindingFoldsBatch28
import SFT.Physics.NuclearBindingFoldsBatch29
import SFT.Physics.NuclearBindingFoldsBatch30
import SFT.Physics.NuclearBindingFoldsBatch31
import SFT.Physics.NuclearBindingFoldsBatch32
import SFT.Physics.NuclearBindingFoldsBatch33
import SFT.Physics.NuclearBindingFoldsBatch34
import SFT.Physics.NuclearBindingFoldsBatch35
import SFT.Physics.NuclearBindingFoldsBatch36
import SFT.Physics.NuclearBindingFoldsBatch37
import SFT.Physics.NuclearBindingFoldsBatch38
import SFT.Physics.NuclearBindingFoldsBatch39
import SFT.Physics.NuclearBindingFoldsBatch40
import SFT.Physics.NuclearBindingFoldsBatch41
import SFT.Physics.NuclearBindingFoldsBatch42
import SFT.Physics.NuclearBindingFoldsBatch43
import SFT.Physics.NuclearBindingFoldsBatch44
import SFT.Physics.NuclearBindingFoldsBatch45
import SFT.Physics.NuclearBindingFoldsBatch46
import SFT.Physics.NuclearBindingFoldsBatch47
import SFT.Physics.NuclearBindingFoldsBatch48
import SFT.Physics.NuclearBindingFoldsBatch49
import SFT.Physics.NuclearBindingFoldsBatch50
import SFT.Physics.NuclearBindingFoldsBatch51
import SFT.Physics.NuclearBindingFoldsBatch52
import SFT.Physics.NuclearBindingFoldsBatch53
import SFT.Physics.NuclearBindingFoldsBatch54
import SFT.Physics.NuclearBindingFoldsBatch55
import SFT.Physics.NuclearBindingFoldsBatch56
import SFT.Physics.NuclearBindingFoldsBatch57
import SFT.Physics.NuclearBindingFoldsBatch58
import SFT.Physics.NuclearBindingFoldsBatch59
import SFT.Physics.NuclearBindingFoldsBatch60
import SFT.Physics.NuclearBindingFoldsBatch61
import SFT.Physics.NuclearBindingFoldsBatch62
import SFT.Physics.NuclearBindingFoldsBatch63
import SFT.Physics.NuclearBindingScoreClosure1
namespace SFT.Physics.NuclearBindingSeparation1
open NuclearBindingPeak NuclearBindingFoldComposition
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def winner := NuclearBindingFoldsBatch00.winner1
def first := NuclearBindingFoldsBatch00.seedBest1
def upper := NuclearBindingFoldsBatch63.afterUpper1
theorem bestSuffix63 : NuclearBindingScoreClosure1.scores63.foldl bestStep NuclearBindingFoldsBatch63.seedBest1 = winner := NuclearBindingFoldsBatch63.best1
theorem upperSuffix63 : (NuclearBindingScoreClosure1.scores63.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch63.seedUpper1 = upper := NuclearBindingFoldsBatch63.upper1
theorem bestSuffix62 : NuclearBindingScoreClosure1.scores62.foldl bestStep NuclearBindingFoldsBatch62.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores62,bestAppend,NuclearBindingFoldsBatch62.best1]
 exact bestSuffix63
theorem upperSuffix62 : (NuclearBindingScoreClosure1.scores62.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch62.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper1 = NuclearBindingFoldsBatch62.afterUpper1 := NuclearBindingFoldsBatch62.upper1
 rw [NuclearBindingScoreClosure1.scores62,rivalsAppend,block]
 exact upperSuffix63
theorem bestSuffix61 : NuclearBindingScoreClosure1.scores61.foldl bestStep NuclearBindingFoldsBatch61.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores61,bestAppend,NuclearBindingFoldsBatch61.best1]
 exact bestSuffix62
theorem upperSuffix61 : (NuclearBindingScoreClosure1.scores61.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch61.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper1 = NuclearBindingFoldsBatch61.afterUpper1 := NuclearBindingFoldsBatch61.upper1
 rw [NuclearBindingScoreClosure1.scores61,rivalsAppend,block]
 exact upperSuffix62
theorem bestSuffix60 : NuclearBindingScoreClosure1.scores60.foldl bestStep NuclearBindingFoldsBatch60.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores60,bestAppend,NuclearBindingFoldsBatch60.best1]
 exact bestSuffix61
theorem upperSuffix60 : (NuclearBindingScoreClosure1.scores60.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch60.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper1 = NuclearBindingFoldsBatch60.afterUpper1 := NuclearBindingFoldsBatch60.upper1
 rw [NuclearBindingScoreClosure1.scores60,rivalsAppend,block]
 exact upperSuffix61
theorem bestSuffix59 : NuclearBindingScoreClosure1.scores59.foldl bestStep NuclearBindingFoldsBatch59.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores59,bestAppend,NuclearBindingFoldsBatch59.best1]
 exact bestSuffix60
theorem upperSuffix59 : (NuclearBindingScoreClosure1.scores59.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch59.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper1 = NuclearBindingFoldsBatch59.afterUpper1 := NuclearBindingFoldsBatch59.upper1
 rw [NuclearBindingScoreClosure1.scores59,rivalsAppend,block]
 exact upperSuffix60
theorem bestSuffix58 : NuclearBindingScoreClosure1.scores58.foldl bestStep NuclearBindingFoldsBatch58.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores58,bestAppend,NuclearBindingFoldsBatch58.best1]
 exact bestSuffix59
theorem upperSuffix58 : (NuclearBindingScoreClosure1.scores58.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch58.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper1 = NuclearBindingFoldsBatch58.afterUpper1 := NuclearBindingFoldsBatch58.upper1
 rw [NuclearBindingScoreClosure1.scores58,rivalsAppend,block]
 exact upperSuffix59
theorem bestSuffix57 : NuclearBindingScoreClosure1.scores57.foldl bestStep NuclearBindingFoldsBatch57.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores57,bestAppend,NuclearBindingFoldsBatch57.best1]
 exact bestSuffix58
theorem upperSuffix57 : (NuclearBindingScoreClosure1.scores57.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch57.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper1 = NuclearBindingFoldsBatch57.afterUpper1 := NuclearBindingFoldsBatch57.upper1
 rw [NuclearBindingScoreClosure1.scores57,rivalsAppend,block]
 exact upperSuffix58
theorem bestSuffix56 : NuclearBindingScoreClosure1.scores56.foldl bestStep NuclearBindingFoldsBatch56.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores56,bestAppend,NuclearBindingFoldsBatch56.best1]
 exact bestSuffix57
theorem upperSuffix56 : (NuclearBindingScoreClosure1.scores56.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch56.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper1 = NuclearBindingFoldsBatch56.afterUpper1 := NuclearBindingFoldsBatch56.upper1
 rw [NuclearBindingScoreClosure1.scores56,rivalsAppend,block]
 exact upperSuffix57
theorem bestSuffix55 : NuclearBindingScoreClosure1.scores55.foldl bestStep NuclearBindingFoldsBatch55.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores55,bestAppend,NuclearBindingFoldsBatch55.best1]
 exact bestSuffix56
theorem upperSuffix55 : (NuclearBindingScoreClosure1.scores55.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch55.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper1 = NuclearBindingFoldsBatch55.afterUpper1 := NuclearBindingFoldsBatch55.upper1
 rw [NuclearBindingScoreClosure1.scores55,rivalsAppend,block]
 exact upperSuffix56
theorem bestSuffix54 : NuclearBindingScoreClosure1.scores54.foldl bestStep NuclearBindingFoldsBatch54.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores54,bestAppend,NuclearBindingFoldsBatch54.best1]
 exact bestSuffix55
theorem upperSuffix54 : (NuclearBindingScoreClosure1.scores54.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch54.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper1 = NuclearBindingFoldsBatch54.afterUpper1 := NuclearBindingFoldsBatch54.upper1
 rw [NuclearBindingScoreClosure1.scores54,rivalsAppend,block]
 exact upperSuffix55
theorem bestSuffix53 : NuclearBindingScoreClosure1.scores53.foldl bestStep NuclearBindingFoldsBatch53.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores53,bestAppend,NuclearBindingFoldsBatch53.best1]
 exact bestSuffix54
theorem upperSuffix53 : (NuclearBindingScoreClosure1.scores53.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch53.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper1 = NuclearBindingFoldsBatch53.afterUpper1 := NuclearBindingFoldsBatch53.upper1
 rw [NuclearBindingScoreClosure1.scores53,rivalsAppend,block]
 exact upperSuffix54
theorem bestSuffix52 : NuclearBindingScoreClosure1.scores52.foldl bestStep NuclearBindingFoldsBatch52.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores52,bestAppend,NuclearBindingFoldsBatch52.best1]
 exact bestSuffix53
theorem upperSuffix52 : (NuclearBindingScoreClosure1.scores52.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch52.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper1 = NuclearBindingFoldsBatch52.afterUpper1 := NuclearBindingFoldsBatch52.upper1
 rw [NuclearBindingScoreClosure1.scores52,rivalsAppend,block]
 exact upperSuffix53
theorem bestSuffix51 : NuclearBindingScoreClosure1.scores51.foldl bestStep NuclearBindingFoldsBatch51.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores51,bestAppend,NuclearBindingFoldsBatch51.best1]
 exact bestSuffix52
theorem upperSuffix51 : (NuclearBindingScoreClosure1.scores51.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch51.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper1 = NuclearBindingFoldsBatch51.afterUpper1 := NuclearBindingFoldsBatch51.upper1
 rw [NuclearBindingScoreClosure1.scores51,rivalsAppend,block]
 exact upperSuffix52
theorem bestSuffix50 : NuclearBindingScoreClosure1.scores50.foldl bestStep NuclearBindingFoldsBatch50.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores50,bestAppend,NuclearBindingFoldsBatch50.best1]
 exact bestSuffix51
theorem upperSuffix50 : (NuclearBindingScoreClosure1.scores50.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch50.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper1 = NuclearBindingFoldsBatch50.afterUpper1 := NuclearBindingFoldsBatch50.upper1
 rw [NuclearBindingScoreClosure1.scores50,rivalsAppend,block]
 exact upperSuffix51
theorem bestSuffix49 : NuclearBindingScoreClosure1.scores49.foldl bestStep NuclearBindingFoldsBatch49.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores49,bestAppend,NuclearBindingFoldsBatch49.best1]
 exact bestSuffix50
theorem upperSuffix49 : (NuclearBindingScoreClosure1.scores49.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch49.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper1 = NuclearBindingFoldsBatch49.afterUpper1 := NuclearBindingFoldsBatch49.upper1
 rw [NuclearBindingScoreClosure1.scores49,rivalsAppend,block]
 exact upperSuffix50
theorem bestSuffix48 : NuclearBindingScoreClosure1.scores48.foldl bestStep NuclearBindingFoldsBatch48.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores48,bestAppend,NuclearBindingFoldsBatch48.best1]
 exact bestSuffix49
theorem upperSuffix48 : (NuclearBindingScoreClosure1.scores48.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch48.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper1 = NuclearBindingFoldsBatch48.afterUpper1 := NuclearBindingFoldsBatch48.upper1
 rw [NuclearBindingScoreClosure1.scores48,rivalsAppend,block]
 exact upperSuffix49
theorem bestSuffix47 : NuclearBindingScoreClosure1.scores47.foldl bestStep NuclearBindingFoldsBatch47.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores47,bestAppend,NuclearBindingFoldsBatch47.best1]
 exact bestSuffix48
theorem upperSuffix47 : (NuclearBindingScoreClosure1.scores47.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch47.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper1 = NuclearBindingFoldsBatch47.afterUpper1 := NuclearBindingFoldsBatch47.upper1
 rw [NuclearBindingScoreClosure1.scores47,rivalsAppend,block]
 exact upperSuffix48
theorem bestSuffix46 : NuclearBindingScoreClosure1.scores46.foldl bestStep NuclearBindingFoldsBatch46.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores46,bestAppend,NuclearBindingFoldsBatch46.best1]
 exact bestSuffix47
theorem upperSuffix46 : (NuclearBindingScoreClosure1.scores46.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch46.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper1 = NuclearBindingFoldsBatch46.afterUpper1 := NuclearBindingFoldsBatch46.upper1
 rw [NuclearBindingScoreClosure1.scores46,rivalsAppend,block]
 exact upperSuffix47
theorem bestSuffix45 : NuclearBindingScoreClosure1.scores45.foldl bestStep NuclearBindingFoldsBatch45.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores45,bestAppend,NuclearBindingFoldsBatch45.best1]
 exact bestSuffix46
theorem upperSuffix45 : (NuclearBindingScoreClosure1.scores45.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch45.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper1 = NuclearBindingFoldsBatch45.afterUpper1 := NuclearBindingFoldsBatch45.upper1
 rw [NuclearBindingScoreClosure1.scores45,rivalsAppend,block]
 exact upperSuffix46
theorem bestSuffix44 : NuclearBindingScoreClosure1.scores44.foldl bestStep NuclearBindingFoldsBatch44.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores44,bestAppend,NuclearBindingFoldsBatch44.best1]
 exact bestSuffix45
theorem upperSuffix44 : (NuclearBindingScoreClosure1.scores44.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch44.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper1 = NuclearBindingFoldsBatch44.afterUpper1 := NuclearBindingFoldsBatch44.upper1
 rw [NuclearBindingScoreClosure1.scores44,rivalsAppend,block]
 exact upperSuffix45
theorem bestSuffix43 : NuclearBindingScoreClosure1.scores43.foldl bestStep NuclearBindingFoldsBatch43.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores43,bestAppend,NuclearBindingFoldsBatch43.best1]
 exact bestSuffix44
theorem upperSuffix43 : (NuclearBindingScoreClosure1.scores43.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch43.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper1 = NuclearBindingFoldsBatch43.afterUpper1 := NuclearBindingFoldsBatch43.upper1
 rw [NuclearBindingScoreClosure1.scores43,rivalsAppend,block]
 exact upperSuffix44
theorem bestSuffix42 : NuclearBindingScoreClosure1.scores42.foldl bestStep NuclearBindingFoldsBatch42.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores42,bestAppend,NuclearBindingFoldsBatch42.best1]
 exact bestSuffix43
theorem upperSuffix42 : (NuclearBindingScoreClosure1.scores42.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch42.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper1 = NuclearBindingFoldsBatch42.afterUpper1 := NuclearBindingFoldsBatch42.upper1
 rw [NuclearBindingScoreClosure1.scores42,rivalsAppend,block]
 exact upperSuffix43
theorem bestSuffix41 : NuclearBindingScoreClosure1.scores41.foldl bestStep NuclearBindingFoldsBatch41.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores41,bestAppend,NuclearBindingFoldsBatch41.best1]
 exact bestSuffix42
theorem upperSuffix41 : (NuclearBindingScoreClosure1.scores41.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch41.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper1 = NuclearBindingFoldsBatch41.afterUpper1 := NuclearBindingFoldsBatch41.upper1
 rw [NuclearBindingScoreClosure1.scores41,rivalsAppend,block]
 exact upperSuffix42
theorem bestSuffix40 : NuclearBindingScoreClosure1.scores40.foldl bestStep NuclearBindingFoldsBatch40.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores40,bestAppend,NuclearBindingFoldsBatch40.best1]
 exact bestSuffix41
theorem upperSuffix40 : (NuclearBindingScoreClosure1.scores40.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch40.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper1 = NuclearBindingFoldsBatch40.afterUpper1 := NuclearBindingFoldsBatch40.upper1
 rw [NuclearBindingScoreClosure1.scores40,rivalsAppend,block]
 exact upperSuffix41
theorem bestSuffix39 : NuclearBindingScoreClosure1.scores39.foldl bestStep NuclearBindingFoldsBatch39.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores39,bestAppend,NuclearBindingFoldsBatch39.best1]
 exact bestSuffix40
theorem upperSuffix39 : (NuclearBindingScoreClosure1.scores39.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch39.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper1 = NuclearBindingFoldsBatch39.afterUpper1 := NuclearBindingFoldsBatch39.upper1
 rw [NuclearBindingScoreClosure1.scores39,rivalsAppend,block]
 exact upperSuffix40
theorem bestSuffix38 : NuclearBindingScoreClosure1.scores38.foldl bestStep NuclearBindingFoldsBatch38.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores38,bestAppend,NuclearBindingFoldsBatch38.best1]
 exact bestSuffix39
theorem upperSuffix38 : (NuclearBindingScoreClosure1.scores38.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch38.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper1 = NuclearBindingFoldsBatch38.afterUpper1 := NuclearBindingFoldsBatch38.upper1
 rw [NuclearBindingScoreClosure1.scores38,rivalsAppend,block]
 exact upperSuffix39
theorem bestSuffix37 : NuclearBindingScoreClosure1.scores37.foldl bestStep NuclearBindingFoldsBatch37.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores37,bestAppend,NuclearBindingFoldsBatch37.best1]
 exact bestSuffix38
theorem upperSuffix37 : (NuclearBindingScoreClosure1.scores37.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch37.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper1 = NuclearBindingFoldsBatch37.afterUpper1 := NuclearBindingFoldsBatch37.upper1
 rw [NuclearBindingScoreClosure1.scores37,rivalsAppend,block]
 exact upperSuffix38
theorem bestSuffix36 : NuclearBindingScoreClosure1.scores36.foldl bestStep NuclearBindingFoldsBatch36.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores36,bestAppend,NuclearBindingFoldsBatch36.best1]
 exact bestSuffix37
theorem upperSuffix36 : (NuclearBindingScoreClosure1.scores36.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch36.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper1 = NuclearBindingFoldsBatch36.afterUpper1 := NuclearBindingFoldsBatch36.upper1
 rw [NuclearBindingScoreClosure1.scores36,rivalsAppend,block]
 exact upperSuffix37
theorem bestSuffix35 : NuclearBindingScoreClosure1.scores35.foldl bestStep NuclearBindingFoldsBatch35.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores35,bestAppend,NuclearBindingFoldsBatch35.best1]
 exact bestSuffix36
theorem upperSuffix35 : (NuclearBindingScoreClosure1.scores35.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch35.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper1 = NuclearBindingFoldsBatch35.afterUpper1 := NuclearBindingFoldsBatch35.upper1
 rw [NuclearBindingScoreClosure1.scores35,rivalsAppend,block]
 exact upperSuffix36
theorem bestSuffix34 : NuclearBindingScoreClosure1.scores34.foldl bestStep NuclearBindingFoldsBatch34.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores34,bestAppend,NuclearBindingFoldsBatch34.best1]
 exact bestSuffix35
theorem upperSuffix34 : (NuclearBindingScoreClosure1.scores34.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch34.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper1 = NuclearBindingFoldsBatch34.afterUpper1 := NuclearBindingFoldsBatch34.upper1
 rw [NuclearBindingScoreClosure1.scores34,rivalsAppend,block]
 exact upperSuffix35
theorem bestSuffix33 : NuclearBindingScoreClosure1.scores33.foldl bestStep NuclearBindingFoldsBatch33.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores33,bestAppend,NuclearBindingFoldsBatch33.best1]
 exact bestSuffix34
theorem upperSuffix33 : (NuclearBindingScoreClosure1.scores33.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch33.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper1 = NuclearBindingFoldsBatch33.afterUpper1 := NuclearBindingFoldsBatch33.upper1
 rw [NuclearBindingScoreClosure1.scores33,rivalsAppend,block]
 exact upperSuffix34
theorem bestSuffix32 : NuclearBindingScoreClosure1.scores32.foldl bestStep NuclearBindingFoldsBatch32.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores32,bestAppend,NuclearBindingFoldsBatch32.best1]
 exact bestSuffix33
theorem upperSuffix32 : (NuclearBindingScoreClosure1.scores32.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch32.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper1 = NuclearBindingFoldsBatch32.afterUpper1 := NuclearBindingFoldsBatch32.upper1
 rw [NuclearBindingScoreClosure1.scores32,rivalsAppend,block]
 exact upperSuffix33
theorem bestSuffix31 : NuclearBindingScoreClosure1.scores31.foldl bestStep NuclearBindingFoldsBatch31.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores31,bestAppend,NuclearBindingFoldsBatch31.best1]
 exact bestSuffix32
theorem upperSuffix31 : (NuclearBindingScoreClosure1.scores31.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch31.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper1 = NuclearBindingFoldsBatch31.afterUpper1 := NuclearBindingFoldsBatch31.upper1
 rw [NuclearBindingScoreClosure1.scores31,rivalsAppend,block]
 exact upperSuffix32
theorem bestSuffix30 : NuclearBindingScoreClosure1.scores30.foldl bestStep NuclearBindingFoldsBatch30.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores30,bestAppend,NuclearBindingFoldsBatch30.best1]
 exact bestSuffix31
theorem upperSuffix30 : (NuclearBindingScoreClosure1.scores30.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch30.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper1 = NuclearBindingFoldsBatch30.afterUpper1 := NuclearBindingFoldsBatch30.upper1
 rw [NuclearBindingScoreClosure1.scores30,rivalsAppend,block]
 exact upperSuffix31
theorem bestSuffix29 : NuclearBindingScoreClosure1.scores29.foldl bestStep NuclearBindingFoldsBatch29.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores29,bestAppend,NuclearBindingFoldsBatch29.best1]
 exact bestSuffix30
theorem upperSuffix29 : (NuclearBindingScoreClosure1.scores29.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch29.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper1 = NuclearBindingFoldsBatch29.afterUpper1 := NuclearBindingFoldsBatch29.upper1
 rw [NuclearBindingScoreClosure1.scores29,rivalsAppend,block]
 exact upperSuffix30
theorem bestSuffix28 : NuclearBindingScoreClosure1.scores28.foldl bestStep NuclearBindingFoldsBatch28.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores28,bestAppend,NuclearBindingFoldsBatch28.best1]
 exact bestSuffix29
theorem upperSuffix28 : (NuclearBindingScoreClosure1.scores28.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch28.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper1 = NuclearBindingFoldsBatch28.afterUpper1 := NuclearBindingFoldsBatch28.upper1
 rw [NuclearBindingScoreClosure1.scores28,rivalsAppend,block]
 exact upperSuffix29
theorem bestSuffix27 : NuclearBindingScoreClosure1.scores27.foldl bestStep NuclearBindingFoldsBatch27.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores27,bestAppend,NuclearBindingFoldsBatch27.best1]
 exact bestSuffix28
theorem upperSuffix27 : (NuclearBindingScoreClosure1.scores27.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch27.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper1 = NuclearBindingFoldsBatch27.afterUpper1 := NuclearBindingFoldsBatch27.upper1
 rw [NuclearBindingScoreClosure1.scores27,rivalsAppend,block]
 exact upperSuffix28
theorem bestSuffix26 : NuclearBindingScoreClosure1.scores26.foldl bestStep NuclearBindingFoldsBatch26.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores26,bestAppend,NuclearBindingFoldsBatch26.best1]
 exact bestSuffix27
theorem upperSuffix26 : (NuclearBindingScoreClosure1.scores26.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch26.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper1 = NuclearBindingFoldsBatch26.afterUpper1 := NuclearBindingFoldsBatch26.upper1
 rw [NuclearBindingScoreClosure1.scores26,rivalsAppend,block]
 exact upperSuffix27
theorem bestSuffix25 : NuclearBindingScoreClosure1.scores25.foldl bestStep NuclearBindingFoldsBatch25.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores25,bestAppend,NuclearBindingFoldsBatch25.best1]
 exact bestSuffix26
theorem upperSuffix25 : (NuclearBindingScoreClosure1.scores25.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch25.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper1 = NuclearBindingFoldsBatch25.afterUpper1 := NuclearBindingFoldsBatch25.upper1
 rw [NuclearBindingScoreClosure1.scores25,rivalsAppend,block]
 exact upperSuffix26
theorem bestSuffix24 : NuclearBindingScoreClosure1.scores24.foldl bestStep NuclearBindingFoldsBatch24.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores24,bestAppend,NuclearBindingFoldsBatch24.best1]
 exact bestSuffix25
theorem upperSuffix24 : (NuclearBindingScoreClosure1.scores24.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch24.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper1 = NuclearBindingFoldsBatch24.afterUpper1 := NuclearBindingFoldsBatch24.upper1
 rw [NuclearBindingScoreClosure1.scores24,rivalsAppend,block]
 exact upperSuffix25
theorem bestSuffix23 : NuclearBindingScoreClosure1.scores23.foldl bestStep NuclearBindingFoldsBatch23.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores23,bestAppend,NuclearBindingFoldsBatch23.best1]
 exact bestSuffix24
theorem upperSuffix23 : (NuclearBindingScoreClosure1.scores23.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch23.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper1 = NuclearBindingFoldsBatch23.afterUpper1 := NuclearBindingFoldsBatch23.upper1
 rw [NuclearBindingScoreClosure1.scores23,rivalsAppend,block]
 exact upperSuffix24
theorem bestSuffix22 : NuclearBindingScoreClosure1.scores22.foldl bestStep NuclearBindingFoldsBatch22.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores22,bestAppend,NuclearBindingFoldsBatch22.best1]
 exact bestSuffix23
theorem upperSuffix22 : (NuclearBindingScoreClosure1.scores22.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch22.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper1 = NuclearBindingFoldsBatch22.afterUpper1 := NuclearBindingFoldsBatch22.upper1
 rw [NuclearBindingScoreClosure1.scores22,rivalsAppend,block]
 exact upperSuffix23
theorem bestSuffix21 : NuclearBindingScoreClosure1.scores21.foldl bestStep NuclearBindingFoldsBatch21.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores21,bestAppend,NuclearBindingFoldsBatch21.best1]
 exact bestSuffix22
theorem upperSuffix21 : (NuclearBindingScoreClosure1.scores21.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch21.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper1 = NuclearBindingFoldsBatch21.afterUpper1 := NuclearBindingFoldsBatch21.upper1
 rw [NuclearBindingScoreClosure1.scores21,rivalsAppend,block]
 exact upperSuffix22
theorem bestSuffix20 : NuclearBindingScoreClosure1.scores20.foldl bestStep NuclearBindingFoldsBatch20.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores20,bestAppend,NuclearBindingFoldsBatch20.best1]
 exact bestSuffix21
theorem upperSuffix20 : (NuclearBindingScoreClosure1.scores20.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch20.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper1 = NuclearBindingFoldsBatch20.afterUpper1 := NuclearBindingFoldsBatch20.upper1
 rw [NuclearBindingScoreClosure1.scores20,rivalsAppend,block]
 exact upperSuffix21
theorem bestSuffix19 : NuclearBindingScoreClosure1.scores19.foldl bestStep NuclearBindingFoldsBatch19.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores19,bestAppend,NuclearBindingFoldsBatch19.best1]
 exact bestSuffix20
theorem upperSuffix19 : (NuclearBindingScoreClosure1.scores19.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch19.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper1 = NuclearBindingFoldsBatch19.afterUpper1 := NuclearBindingFoldsBatch19.upper1
 rw [NuclearBindingScoreClosure1.scores19,rivalsAppend,block]
 exact upperSuffix20
theorem bestSuffix18 : NuclearBindingScoreClosure1.scores18.foldl bestStep NuclearBindingFoldsBatch18.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores18,bestAppend,NuclearBindingFoldsBatch18.best1]
 exact bestSuffix19
theorem upperSuffix18 : (NuclearBindingScoreClosure1.scores18.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch18.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper1 = NuclearBindingFoldsBatch18.afterUpper1 := NuclearBindingFoldsBatch18.upper1
 rw [NuclearBindingScoreClosure1.scores18,rivalsAppend,block]
 exact upperSuffix19
theorem bestSuffix17 : NuclearBindingScoreClosure1.scores17.foldl bestStep NuclearBindingFoldsBatch17.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores17,bestAppend,NuclearBindingFoldsBatch17.best1]
 exact bestSuffix18
theorem upperSuffix17 : (NuclearBindingScoreClosure1.scores17.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch17.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper1 = NuclearBindingFoldsBatch17.afterUpper1 := NuclearBindingFoldsBatch17.upper1
 rw [NuclearBindingScoreClosure1.scores17,rivalsAppend,block]
 exact upperSuffix18
theorem bestSuffix16 : NuclearBindingScoreClosure1.scores16.foldl bestStep NuclearBindingFoldsBatch16.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores16,bestAppend,NuclearBindingFoldsBatch16.best1]
 exact bestSuffix17
theorem upperSuffix16 : (NuclearBindingScoreClosure1.scores16.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch16.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper1 = NuclearBindingFoldsBatch16.afterUpper1 := NuclearBindingFoldsBatch16.upper1
 rw [NuclearBindingScoreClosure1.scores16,rivalsAppend,block]
 exact upperSuffix17
theorem bestSuffix15 : NuclearBindingScoreClosure1.scores15.foldl bestStep NuclearBindingFoldsBatch15.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores15,bestAppend,NuclearBindingFoldsBatch15.best1]
 exact bestSuffix16
theorem upperSuffix15 : (NuclearBindingScoreClosure1.scores15.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch15.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper1 = NuclearBindingFoldsBatch15.afterUpper1 := NuclearBindingFoldsBatch15.upper1
 rw [NuclearBindingScoreClosure1.scores15,rivalsAppend,block]
 exact upperSuffix16
theorem bestSuffix14 : NuclearBindingScoreClosure1.scores14.foldl bestStep NuclearBindingFoldsBatch14.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores14,bestAppend,NuclearBindingFoldsBatch14.best1]
 exact bestSuffix15
theorem upperSuffix14 : (NuclearBindingScoreClosure1.scores14.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch14.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper1 = NuclearBindingFoldsBatch14.afterUpper1 := NuclearBindingFoldsBatch14.upper1
 rw [NuclearBindingScoreClosure1.scores14,rivalsAppend,block]
 exact upperSuffix15
theorem bestSuffix13 : NuclearBindingScoreClosure1.scores13.foldl bestStep NuclearBindingFoldsBatch13.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores13,bestAppend,NuclearBindingFoldsBatch13.best1]
 exact bestSuffix14
theorem upperSuffix13 : (NuclearBindingScoreClosure1.scores13.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch13.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper1 = NuclearBindingFoldsBatch13.afterUpper1 := NuclearBindingFoldsBatch13.upper1
 rw [NuclearBindingScoreClosure1.scores13,rivalsAppend,block]
 exact upperSuffix14
theorem bestSuffix12 : NuclearBindingScoreClosure1.scores12.foldl bestStep NuclearBindingFoldsBatch12.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores12,bestAppend,NuclearBindingFoldsBatch12.best1]
 exact bestSuffix13
theorem upperSuffix12 : (NuclearBindingScoreClosure1.scores12.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch12.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper1 = NuclearBindingFoldsBatch12.afterUpper1 := NuclearBindingFoldsBatch12.upper1
 rw [NuclearBindingScoreClosure1.scores12,rivalsAppend,block]
 exact upperSuffix13
theorem bestSuffix11 : NuclearBindingScoreClosure1.scores11.foldl bestStep NuclearBindingFoldsBatch11.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores11,bestAppend,NuclearBindingFoldsBatch11.best1]
 exact bestSuffix12
theorem upperSuffix11 : (NuclearBindingScoreClosure1.scores11.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch11.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper1 = NuclearBindingFoldsBatch11.afterUpper1 := NuclearBindingFoldsBatch11.upper1
 rw [NuclearBindingScoreClosure1.scores11,rivalsAppend,block]
 exact upperSuffix12
theorem bestSuffix10 : NuclearBindingScoreClosure1.scores10.foldl bestStep NuclearBindingFoldsBatch10.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores10,bestAppend,NuclearBindingFoldsBatch10.best1]
 exact bestSuffix11
theorem upperSuffix10 : (NuclearBindingScoreClosure1.scores10.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch10.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper1 = NuclearBindingFoldsBatch10.afterUpper1 := NuclearBindingFoldsBatch10.upper1
 rw [NuclearBindingScoreClosure1.scores10,rivalsAppend,block]
 exact upperSuffix11
theorem bestSuffix9 : NuclearBindingScoreClosure1.scores9.foldl bestStep NuclearBindingFoldsBatch09.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores9,bestAppend,NuclearBindingFoldsBatch09.best1]
 exact bestSuffix10
theorem upperSuffix9 : (NuclearBindingScoreClosure1.scores9.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch09.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper1 = NuclearBindingFoldsBatch09.afterUpper1 := NuclearBindingFoldsBatch09.upper1
 rw [NuclearBindingScoreClosure1.scores9,rivalsAppend,block]
 exact upperSuffix10
theorem bestSuffix8 : NuclearBindingScoreClosure1.scores8.foldl bestStep NuclearBindingFoldsBatch08.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores8,bestAppend,NuclearBindingFoldsBatch08.best1]
 exact bestSuffix9
theorem upperSuffix8 : (NuclearBindingScoreClosure1.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch08.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper1 = NuclearBindingFoldsBatch08.afterUpper1 := NuclearBindingFoldsBatch08.upper1
 rw [NuclearBindingScoreClosure1.scores8,rivalsAppend,block]
 exact upperSuffix9
theorem bestSuffix7 : NuclearBindingScoreClosure1.scores7.foldl bestStep NuclearBindingFoldsBatch07.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores7,bestAppend,NuclearBindingFoldsBatch07.best1]
 exact bestSuffix8
theorem upperSuffix7 : (NuclearBindingScoreClosure1.scores7.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch07.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper1 = NuclearBindingFoldsBatch07.afterUpper1 := NuclearBindingFoldsBatch07.upper1
 rw [NuclearBindingScoreClosure1.scores7,rivalsAppend,block]
 exact upperSuffix8
theorem bestSuffix6 : NuclearBindingScoreClosure1.scores6.foldl bestStep NuclearBindingFoldsBatch06.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores6,bestAppend,NuclearBindingFoldsBatch06.best1]
 exact bestSuffix7
theorem upperSuffix6 : (NuclearBindingScoreClosure1.scores6.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch06.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper1 = NuclearBindingFoldsBatch06.afterUpper1 := NuclearBindingFoldsBatch06.upper1
 rw [NuclearBindingScoreClosure1.scores6,rivalsAppend,block]
 exact upperSuffix7
theorem bestSuffix5 : NuclearBindingScoreClosure1.scores5.foldl bestStep NuclearBindingFoldsBatch05.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores5,bestAppend,NuclearBindingFoldsBatch05.best1]
 exact bestSuffix6
theorem upperSuffix5 : (NuclearBindingScoreClosure1.scores5.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch05.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper1 = NuclearBindingFoldsBatch05.afterUpper1 := NuclearBindingFoldsBatch05.upper1
 rw [NuclearBindingScoreClosure1.scores5,rivalsAppend,block]
 exact upperSuffix6
theorem bestSuffix4 : NuclearBindingScoreClosure1.scores4.foldl bestStep NuclearBindingFoldsBatch04.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores4,bestAppend,NuclearBindingFoldsBatch04.best1]
 exact bestSuffix5
theorem upperSuffix4 : (NuclearBindingScoreClosure1.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch04.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper1 = NuclearBindingFoldsBatch04.afterUpper1 := NuclearBindingFoldsBatch04.upper1
 rw [NuclearBindingScoreClosure1.scores4,rivalsAppend,block]
 exact upperSuffix5
theorem bestSuffix3 : NuclearBindingScoreClosure1.scores3.foldl bestStep NuclearBindingFoldsBatch03.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores3,bestAppend,NuclearBindingFoldsBatch03.best1]
 exact bestSuffix4
theorem upperSuffix3 : (NuclearBindingScoreClosure1.scores3.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch03.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper1 = NuclearBindingFoldsBatch03.afterUpper1 := NuclearBindingFoldsBatch03.upper1
 rw [NuclearBindingScoreClosure1.scores3,rivalsAppend,block]
 exact upperSuffix4
theorem bestSuffix2 : NuclearBindingScoreClosure1.scores2.foldl bestStep NuclearBindingFoldsBatch02.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores2,bestAppend,NuclearBindingFoldsBatch02.best1]
 exact bestSuffix3
theorem upperSuffix2 : (NuclearBindingScoreClosure1.scores2.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch02.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper1 = NuclearBindingFoldsBatch02.afterUpper1 := NuclearBindingFoldsBatch02.upper1
 rw [NuclearBindingScoreClosure1.scores2,rivalsAppend,block]
 exact upperSuffix3
theorem bestSuffix1 : NuclearBindingScoreClosure1.scores1.foldl bestStep NuclearBindingFoldsBatch01.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores1,bestAppend,NuclearBindingFoldsBatch01.best1]
 exact bestSuffix2
theorem upperSuffix1 : (NuclearBindingScoreClosure1.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch01.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper1 = NuclearBindingFoldsBatch01.afterUpper1 := NuclearBindingFoldsBatch01.upper1
 rw [NuclearBindingScoreClosure1.scores1,rivalsAppend,block]
 exact upperSuffix2
theorem bestSuffix0 : NuclearBindingScoreClosure1.scores0.foldl bestStep NuclearBindingFoldsBatch00.seedBest1 = winner := by
 rw [NuclearBindingScoreClosure1.scores0,bestAppend,NuclearBindingFoldsBatch00.best1]
 exact bestSuffix1
theorem upperSuffix0 : (NuclearBindingScoreClosure1.scores0.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper1 = upper := by
 have block : (NuclearBindingScoresBatch00.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper1 = NuclearBindingFoldsBatch00.afterUpper1 := NuclearBindingFoldsBatch00.upper1
 rw [NuclearBindingScoreClosure1.scores0,rivalsAppend,block]
 exact upperSuffix1
def restScores := NuclearBindingScoresBatch00.scores1.tail ++ NuclearBindingScoreClosure1.scores1
def restRivals := restScores.filter (fun row => !sameCoordinate row winner)
theorem fullScoresCons : NuclearBindingScoreClosure1.scores0 = first::restScores := rfl
theorem fullRivalsCons : (NuclearBindingScoreClosure1.scores0.filter (fun row => !sameCoordinate row winner)) = first::restRivals :=
 (congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons).trans
 (NuclearBindingPeakAssembly.filterHead _ first restScores (by rfl))
theorem bestValue : bestLower first restScores = winner :=
 NuclearBindingPeakAssembly.bestOfFull first winner restScores (by rfl)
 ((congrArg (fun rows => rows.foldl bestStep first) fullScoresCons).symm.trans bestSuffix0)
theorem upperValue : largestUpper first restRivals = upper :=
 NuclearBindingPeakAssembly.upperOfFull first restRivals upper (by rfl)
 ((congrArg (fun rows => rows.foldl upperStep first.upper) fullRivalsCons).symm.trans upperSuffix0)
theorem stepEvaluation : separationStep NuclearBindingGatherClosure.candidates0 1 =
 (if upper.blt winner.lower then .ok (some ⟨winner,upper,1⟩) else .ok none) :=
 NuclearBindingPeakAssembly.separationFromEvaluations _ _ first restScores winner restRivals upper
 (NuclearBindingScoreClosure1.complete0.trans (congrArg Except.ok fullScoresCons))
 bestValue
 ((congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons.symm).trans fullRivalsCons)
 upperValue
theorem separated : separationStep NuclearBindingGatherClosure.candidates0 1 = .ok none := stepEvaluation.trans (by rfl)
end SFT.Physics.NuclearBindingSeparation1
