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
import SFT.Physics.NuclearBindingScoreClosure4
namespace SFT.Physics.NuclearBindingSeparation4
open NuclearBindingPeak NuclearBindingFoldComposition
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def winner := NuclearBindingFoldsBatch00.winner4
def first := NuclearBindingFoldsBatch00.seedBest4
def upper := NuclearBindingFoldsBatch63.afterUpper4
theorem bestSuffix63 : NuclearBindingScoreClosure4.scores63.foldl bestStep NuclearBindingFoldsBatch63.seedBest4 = winner := NuclearBindingFoldsBatch63.best4
theorem upperSuffix63 : (NuclearBindingScoreClosure4.scores63.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch63.seedUpper4 = upper := NuclearBindingFoldsBatch63.upper4
theorem bestSuffix62 : NuclearBindingScoreClosure4.scores62.foldl bestStep NuclearBindingFoldsBatch62.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores62,bestAppend,NuclearBindingFoldsBatch62.best4]
 exact bestSuffix63
theorem upperSuffix62 : (NuclearBindingScoreClosure4.scores62.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch62.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper4 = NuclearBindingFoldsBatch62.afterUpper4 := NuclearBindingFoldsBatch62.upper4
 rw [NuclearBindingScoreClosure4.scores62,rivalsAppend,block]
 exact upperSuffix63
theorem bestSuffix61 : NuclearBindingScoreClosure4.scores61.foldl bestStep NuclearBindingFoldsBatch61.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores61,bestAppend,NuclearBindingFoldsBatch61.best4]
 exact bestSuffix62
theorem upperSuffix61 : (NuclearBindingScoreClosure4.scores61.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch61.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper4 = NuclearBindingFoldsBatch61.afterUpper4 := NuclearBindingFoldsBatch61.upper4
 rw [NuclearBindingScoreClosure4.scores61,rivalsAppend,block]
 exact upperSuffix62
theorem bestSuffix60 : NuclearBindingScoreClosure4.scores60.foldl bestStep NuclearBindingFoldsBatch60.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores60,bestAppend,NuclearBindingFoldsBatch60.best4]
 exact bestSuffix61
theorem upperSuffix60 : (NuclearBindingScoreClosure4.scores60.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch60.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper4 = NuclearBindingFoldsBatch60.afterUpper4 := NuclearBindingFoldsBatch60.upper4
 rw [NuclearBindingScoreClosure4.scores60,rivalsAppend,block]
 exact upperSuffix61
theorem bestSuffix59 : NuclearBindingScoreClosure4.scores59.foldl bestStep NuclearBindingFoldsBatch59.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores59,bestAppend,NuclearBindingFoldsBatch59.best4]
 exact bestSuffix60
theorem upperSuffix59 : (NuclearBindingScoreClosure4.scores59.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch59.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper4 = NuclearBindingFoldsBatch59.afterUpper4 := NuclearBindingFoldsBatch59.upper4
 rw [NuclearBindingScoreClosure4.scores59,rivalsAppend,block]
 exact upperSuffix60
theorem bestSuffix58 : NuclearBindingScoreClosure4.scores58.foldl bestStep NuclearBindingFoldsBatch58.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores58,bestAppend,NuclearBindingFoldsBatch58.best4]
 exact bestSuffix59
theorem upperSuffix58 : (NuclearBindingScoreClosure4.scores58.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch58.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper4 = NuclearBindingFoldsBatch58.afterUpper4 := NuclearBindingFoldsBatch58.upper4
 rw [NuclearBindingScoreClosure4.scores58,rivalsAppend,block]
 exact upperSuffix59
theorem bestSuffix57 : NuclearBindingScoreClosure4.scores57.foldl bestStep NuclearBindingFoldsBatch57.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores57,bestAppend,NuclearBindingFoldsBatch57.best4]
 exact bestSuffix58
theorem upperSuffix57 : (NuclearBindingScoreClosure4.scores57.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch57.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper4 = NuclearBindingFoldsBatch57.afterUpper4 := NuclearBindingFoldsBatch57.upper4
 rw [NuclearBindingScoreClosure4.scores57,rivalsAppend,block]
 exact upperSuffix58
theorem bestSuffix56 : NuclearBindingScoreClosure4.scores56.foldl bestStep NuclearBindingFoldsBatch56.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores56,bestAppend,NuclearBindingFoldsBatch56.best4]
 exact bestSuffix57
theorem upperSuffix56 : (NuclearBindingScoreClosure4.scores56.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch56.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper4 = NuclearBindingFoldsBatch56.afterUpper4 := NuclearBindingFoldsBatch56.upper4
 rw [NuclearBindingScoreClosure4.scores56,rivalsAppend,block]
 exact upperSuffix57
theorem bestSuffix55 : NuclearBindingScoreClosure4.scores55.foldl bestStep NuclearBindingFoldsBatch55.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores55,bestAppend,NuclearBindingFoldsBatch55.best4]
 exact bestSuffix56
theorem upperSuffix55 : (NuclearBindingScoreClosure4.scores55.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch55.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper4 = NuclearBindingFoldsBatch55.afterUpper4 := NuclearBindingFoldsBatch55.upper4
 rw [NuclearBindingScoreClosure4.scores55,rivalsAppend,block]
 exact upperSuffix56
theorem bestSuffix54 : NuclearBindingScoreClosure4.scores54.foldl bestStep NuclearBindingFoldsBatch54.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores54,bestAppend,NuclearBindingFoldsBatch54.best4]
 exact bestSuffix55
theorem upperSuffix54 : (NuclearBindingScoreClosure4.scores54.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch54.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper4 = NuclearBindingFoldsBatch54.afterUpper4 := NuclearBindingFoldsBatch54.upper4
 rw [NuclearBindingScoreClosure4.scores54,rivalsAppend,block]
 exact upperSuffix55
theorem bestSuffix53 : NuclearBindingScoreClosure4.scores53.foldl bestStep NuclearBindingFoldsBatch53.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores53,bestAppend,NuclearBindingFoldsBatch53.best4]
 exact bestSuffix54
theorem upperSuffix53 : (NuclearBindingScoreClosure4.scores53.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch53.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper4 = NuclearBindingFoldsBatch53.afterUpper4 := NuclearBindingFoldsBatch53.upper4
 rw [NuclearBindingScoreClosure4.scores53,rivalsAppend,block]
 exact upperSuffix54
theorem bestSuffix52 : NuclearBindingScoreClosure4.scores52.foldl bestStep NuclearBindingFoldsBatch52.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores52,bestAppend,NuclearBindingFoldsBatch52.best4]
 exact bestSuffix53
theorem upperSuffix52 : (NuclearBindingScoreClosure4.scores52.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch52.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper4 = NuclearBindingFoldsBatch52.afterUpper4 := NuclearBindingFoldsBatch52.upper4
 rw [NuclearBindingScoreClosure4.scores52,rivalsAppend,block]
 exact upperSuffix53
theorem bestSuffix51 : NuclearBindingScoreClosure4.scores51.foldl bestStep NuclearBindingFoldsBatch51.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores51,bestAppend,NuclearBindingFoldsBatch51.best4]
 exact bestSuffix52
theorem upperSuffix51 : (NuclearBindingScoreClosure4.scores51.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch51.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper4 = NuclearBindingFoldsBatch51.afterUpper4 := NuclearBindingFoldsBatch51.upper4
 rw [NuclearBindingScoreClosure4.scores51,rivalsAppend,block]
 exact upperSuffix52
theorem bestSuffix50 : NuclearBindingScoreClosure4.scores50.foldl bestStep NuclearBindingFoldsBatch50.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores50,bestAppend,NuclearBindingFoldsBatch50.best4]
 exact bestSuffix51
theorem upperSuffix50 : (NuclearBindingScoreClosure4.scores50.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch50.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper4 = NuclearBindingFoldsBatch50.afterUpper4 := NuclearBindingFoldsBatch50.upper4
 rw [NuclearBindingScoreClosure4.scores50,rivalsAppend,block]
 exact upperSuffix51
theorem bestSuffix49 : NuclearBindingScoreClosure4.scores49.foldl bestStep NuclearBindingFoldsBatch49.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores49,bestAppend,NuclearBindingFoldsBatch49.best4]
 exact bestSuffix50
theorem upperSuffix49 : (NuclearBindingScoreClosure4.scores49.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch49.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper4 = NuclearBindingFoldsBatch49.afterUpper4 := NuclearBindingFoldsBatch49.upper4
 rw [NuclearBindingScoreClosure4.scores49,rivalsAppend,block]
 exact upperSuffix50
theorem bestSuffix48 : NuclearBindingScoreClosure4.scores48.foldl bestStep NuclearBindingFoldsBatch48.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores48,bestAppend,NuclearBindingFoldsBatch48.best4]
 exact bestSuffix49
theorem upperSuffix48 : (NuclearBindingScoreClosure4.scores48.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch48.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper4 = NuclearBindingFoldsBatch48.afterUpper4 := NuclearBindingFoldsBatch48.upper4
 rw [NuclearBindingScoreClosure4.scores48,rivalsAppend,block]
 exact upperSuffix49
theorem bestSuffix47 : NuclearBindingScoreClosure4.scores47.foldl bestStep NuclearBindingFoldsBatch47.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores47,bestAppend,NuclearBindingFoldsBatch47.best4]
 exact bestSuffix48
theorem upperSuffix47 : (NuclearBindingScoreClosure4.scores47.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch47.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper4 = NuclearBindingFoldsBatch47.afterUpper4 := NuclearBindingFoldsBatch47.upper4
 rw [NuclearBindingScoreClosure4.scores47,rivalsAppend,block]
 exact upperSuffix48
theorem bestSuffix46 : NuclearBindingScoreClosure4.scores46.foldl bestStep NuclearBindingFoldsBatch46.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores46,bestAppend,NuclearBindingFoldsBatch46.best4]
 exact bestSuffix47
theorem upperSuffix46 : (NuclearBindingScoreClosure4.scores46.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch46.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper4 = NuclearBindingFoldsBatch46.afterUpper4 := NuclearBindingFoldsBatch46.upper4
 rw [NuclearBindingScoreClosure4.scores46,rivalsAppend,block]
 exact upperSuffix47
theorem bestSuffix45 : NuclearBindingScoreClosure4.scores45.foldl bestStep NuclearBindingFoldsBatch45.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores45,bestAppend,NuclearBindingFoldsBatch45.best4]
 exact bestSuffix46
theorem upperSuffix45 : (NuclearBindingScoreClosure4.scores45.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch45.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper4 = NuclearBindingFoldsBatch45.afterUpper4 := NuclearBindingFoldsBatch45.upper4
 rw [NuclearBindingScoreClosure4.scores45,rivalsAppend,block]
 exact upperSuffix46
theorem bestSuffix44 : NuclearBindingScoreClosure4.scores44.foldl bestStep NuclearBindingFoldsBatch44.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores44,bestAppend,NuclearBindingFoldsBatch44.best4]
 exact bestSuffix45
theorem upperSuffix44 : (NuclearBindingScoreClosure4.scores44.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch44.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper4 = NuclearBindingFoldsBatch44.afterUpper4 := NuclearBindingFoldsBatch44.upper4
 rw [NuclearBindingScoreClosure4.scores44,rivalsAppend,block]
 exact upperSuffix45
theorem bestSuffix43 : NuclearBindingScoreClosure4.scores43.foldl bestStep NuclearBindingFoldsBatch43.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores43,bestAppend,NuclearBindingFoldsBatch43.best4]
 exact bestSuffix44
theorem upperSuffix43 : (NuclearBindingScoreClosure4.scores43.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch43.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper4 = NuclearBindingFoldsBatch43.afterUpper4 := NuclearBindingFoldsBatch43.upper4
 rw [NuclearBindingScoreClosure4.scores43,rivalsAppend,block]
 exact upperSuffix44
theorem bestSuffix42 : NuclearBindingScoreClosure4.scores42.foldl bestStep NuclearBindingFoldsBatch42.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores42,bestAppend,NuclearBindingFoldsBatch42.best4]
 exact bestSuffix43
theorem upperSuffix42 : (NuclearBindingScoreClosure4.scores42.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch42.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper4 = NuclearBindingFoldsBatch42.afterUpper4 := NuclearBindingFoldsBatch42.upper4
 rw [NuclearBindingScoreClosure4.scores42,rivalsAppend,block]
 exact upperSuffix43
theorem bestSuffix41 : NuclearBindingScoreClosure4.scores41.foldl bestStep NuclearBindingFoldsBatch41.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores41,bestAppend,NuclearBindingFoldsBatch41.best4]
 exact bestSuffix42
theorem upperSuffix41 : (NuclearBindingScoreClosure4.scores41.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch41.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper4 = NuclearBindingFoldsBatch41.afterUpper4 := NuclearBindingFoldsBatch41.upper4
 rw [NuclearBindingScoreClosure4.scores41,rivalsAppend,block]
 exact upperSuffix42
theorem bestSuffix40 : NuclearBindingScoreClosure4.scores40.foldl bestStep NuclearBindingFoldsBatch40.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores40,bestAppend,NuclearBindingFoldsBatch40.best4]
 exact bestSuffix41
theorem upperSuffix40 : (NuclearBindingScoreClosure4.scores40.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch40.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper4 = NuclearBindingFoldsBatch40.afterUpper4 := NuclearBindingFoldsBatch40.upper4
 rw [NuclearBindingScoreClosure4.scores40,rivalsAppend,block]
 exact upperSuffix41
theorem bestSuffix39 : NuclearBindingScoreClosure4.scores39.foldl bestStep NuclearBindingFoldsBatch39.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores39,bestAppend,NuclearBindingFoldsBatch39.best4]
 exact bestSuffix40
theorem upperSuffix39 : (NuclearBindingScoreClosure4.scores39.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch39.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper4 = NuclearBindingFoldsBatch39.afterUpper4 := NuclearBindingFoldsBatch39.upper4
 rw [NuclearBindingScoreClosure4.scores39,rivalsAppend,block]
 exact upperSuffix40
theorem bestSuffix38 : NuclearBindingScoreClosure4.scores38.foldl bestStep NuclearBindingFoldsBatch38.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores38,bestAppend,NuclearBindingFoldsBatch38.best4]
 exact bestSuffix39
theorem upperSuffix38 : (NuclearBindingScoreClosure4.scores38.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch38.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper4 = NuclearBindingFoldsBatch38.afterUpper4 := NuclearBindingFoldsBatch38.upper4
 rw [NuclearBindingScoreClosure4.scores38,rivalsAppend,block]
 exact upperSuffix39
theorem bestSuffix37 : NuclearBindingScoreClosure4.scores37.foldl bestStep NuclearBindingFoldsBatch37.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores37,bestAppend,NuclearBindingFoldsBatch37.best4]
 exact bestSuffix38
theorem upperSuffix37 : (NuclearBindingScoreClosure4.scores37.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch37.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper4 = NuclearBindingFoldsBatch37.afterUpper4 := NuclearBindingFoldsBatch37.upper4
 rw [NuclearBindingScoreClosure4.scores37,rivalsAppend,block]
 exact upperSuffix38
theorem bestSuffix36 : NuclearBindingScoreClosure4.scores36.foldl bestStep NuclearBindingFoldsBatch36.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores36,bestAppend,NuclearBindingFoldsBatch36.best4]
 exact bestSuffix37
theorem upperSuffix36 : (NuclearBindingScoreClosure4.scores36.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch36.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper4 = NuclearBindingFoldsBatch36.afterUpper4 := NuclearBindingFoldsBatch36.upper4
 rw [NuclearBindingScoreClosure4.scores36,rivalsAppend,block]
 exact upperSuffix37
theorem bestSuffix35 : NuclearBindingScoreClosure4.scores35.foldl bestStep NuclearBindingFoldsBatch35.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores35,bestAppend,NuclearBindingFoldsBatch35.best4]
 exact bestSuffix36
theorem upperSuffix35 : (NuclearBindingScoreClosure4.scores35.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch35.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper4 = NuclearBindingFoldsBatch35.afterUpper4 := NuclearBindingFoldsBatch35.upper4
 rw [NuclearBindingScoreClosure4.scores35,rivalsAppend,block]
 exact upperSuffix36
theorem bestSuffix34 : NuclearBindingScoreClosure4.scores34.foldl bestStep NuclearBindingFoldsBatch34.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores34,bestAppend,NuclearBindingFoldsBatch34.best4]
 exact bestSuffix35
theorem upperSuffix34 : (NuclearBindingScoreClosure4.scores34.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch34.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper4 = NuclearBindingFoldsBatch34.afterUpper4 := NuclearBindingFoldsBatch34.upper4
 rw [NuclearBindingScoreClosure4.scores34,rivalsAppend,block]
 exact upperSuffix35
theorem bestSuffix33 : NuclearBindingScoreClosure4.scores33.foldl bestStep NuclearBindingFoldsBatch33.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores33,bestAppend,NuclearBindingFoldsBatch33.best4]
 exact bestSuffix34
theorem upperSuffix33 : (NuclearBindingScoreClosure4.scores33.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch33.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper4 = NuclearBindingFoldsBatch33.afterUpper4 := NuclearBindingFoldsBatch33.upper4
 rw [NuclearBindingScoreClosure4.scores33,rivalsAppend,block]
 exact upperSuffix34
theorem bestSuffix32 : NuclearBindingScoreClosure4.scores32.foldl bestStep NuclearBindingFoldsBatch32.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores32,bestAppend,NuclearBindingFoldsBatch32.best4]
 exact bestSuffix33
theorem upperSuffix32 : (NuclearBindingScoreClosure4.scores32.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch32.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper4 = NuclearBindingFoldsBatch32.afterUpper4 := NuclearBindingFoldsBatch32.upper4
 rw [NuclearBindingScoreClosure4.scores32,rivalsAppend,block]
 exact upperSuffix33
theorem bestSuffix31 : NuclearBindingScoreClosure4.scores31.foldl bestStep NuclearBindingFoldsBatch31.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores31,bestAppend,NuclearBindingFoldsBatch31.best4]
 exact bestSuffix32
theorem upperSuffix31 : (NuclearBindingScoreClosure4.scores31.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch31.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper4 = NuclearBindingFoldsBatch31.afterUpper4 := NuclearBindingFoldsBatch31.upper4
 rw [NuclearBindingScoreClosure4.scores31,rivalsAppend,block]
 exact upperSuffix32
theorem bestSuffix30 : NuclearBindingScoreClosure4.scores30.foldl bestStep NuclearBindingFoldsBatch30.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores30,bestAppend,NuclearBindingFoldsBatch30.best4]
 exact bestSuffix31
theorem upperSuffix30 : (NuclearBindingScoreClosure4.scores30.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch30.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper4 = NuclearBindingFoldsBatch30.afterUpper4 := NuclearBindingFoldsBatch30.upper4
 rw [NuclearBindingScoreClosure4.scores30,rivalsAppend,block]
 exact upperSuffix31
theorem bestSuffix29 : NuclearBindingScoreClosure4.scores29.foldl bestStep NuclearBindingFoldsBatch29.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores29,bestAppend,NuclearBindingFoldsBatch29.best4]
 exact bestSuffix30
theorem upperSuffix29 : (NuclearBindingScoreClosure4.scores29.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch29.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper4 = NuclearBindingFoldsBatch29.afterUpper4 := NuclearBindingFoldsBatch29.upper4
 rw [NuclearBindingScoreClosure4.scores29,rivalsAppend,block]
 exact upperSuffix30
theorem bestSuffix28 : NuclearBindingScoreClosure4.scores28.foldl bestStep NuclearBindingFoldsBatch28.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores28,bestAppend,NuclearBindingFoldsBatch28.best4]
 exact bestSuffix29
theorem upperSuffix28 : (NuclearBindingScoreClosure4.scores28.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch28.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper4 = NuclearBindingFoldsBatch28.afterUpper4 := NuclearBindingFoldsBatch28.upper4
 rw [NuclearBindingScoreClosure4.scores28,rivalsAppend,block]
 exact upperSuffix29
theorem bestSuffix27 : NuclearBindingScoreClosure4.scores27.foldl bestStep NuclearBindingFoldsBatch27.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores27,bestAppend,NuclearBindingFoldsBatch27.best4]
 exact bestSuffix28
theorem upperSuffix27 : (NuclearBindingScoreClosure4.scores27.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch27.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper4 = NuclearBindingFoldsBatch27.afterUpper4 := NuclearBindingFoldsBatch27.upper4
 rw [NuclearBindingScoreClosure4.scores27,rivalsAppend,block]
 exact upperSuffix28
theorem bestSuffix26 : NuclearBindingScoreClosure4.scores26.foldl bestStep NuclearBindingFoldsBatch26.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores26,bestAppend,NuclearBindingFoldsBatch26.best4]
 exact bestSuffix27
theorem upperSuffix26 : (NuclearBindingScoreClosure4.scores26.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch26.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper4 = NuclearBindingFoldsBatch26.afterUpper4 := NuclearBindingFoldsBatch26.upper4
 rw [NuclearBindingScoreClosure4.scores26,rivalsAppend,block]
 exact upperSuffix27
theorem bestSuffix25 : NuclearBindingScoreClosure4.scores25.foldl bestStep NuclearBindingFoldsBatch25.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores25,bestAppend,NuclearBindingFoldsBatch25.best4]
 exact bestSuffix26
theorem upperSuffix25 : (NuclearBindingScoreClosure4.scores25.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch25.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper4 = NuclearBindingFoldsBatch25.afterUpper4 := NuclearBindingFoldsBatch25.upper4
 rw [NuclearBindingScoreClosure4.scores25,rivalsAppend,block]
 exact upperSuffix26
theorem bestSuffix24 : NuclearBindingScoreClosure4.scores24.foldl bestStep NuclearBindingFoldsBatch24.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores24,bestAppend,NuclearBindingFoldsBatch24.best4]
 exact bestSuffix25
theorem upperSuffix24 : (NuclearBindingScoreClosure4.scores24.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch24.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper4 = NuclearBindingFoldsBatch24.afterUpper4 := NuclearBindingFoldsBatch24.upper4
 rw [NuclearBindingScoreClosure4.scores24,rivalsAppend,block]
 exact upperSuffix25
theorem bestSuffix23 : NuclearBindingScoreClosure4.scores23.foldl bestStep NuclearBindingFoldsBatch23.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores23,bestAppend,NuclearBindingFoldsBatch23.best4]
 exact bestSuffix24
theorem upperSuffix23 : (NuclearBindingScoreClosure4.scores23.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch23.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper4 = NuclearBindingFoldsBatch23.afterUpper4 := NuclearBindingFoldsBatch23.upper4
 rw [NuclearBindingScoreClosure4.scores23,rivalsAppend,block]
 exact upperSuffix24
theorem bestSuffix22 : NuclearBindingScoreClosure4.scores22.foldl bestStep NuclearBindingFoldsBatch22.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores22,bestAppend,NuclearBindingFoldsBatch22.best4]
 exact bestSuffix23
theorem upperSuffix22 : (NuclearBindingScoreClosure4.scores22.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch22.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper4 = NuclearBindingFoldsBatch22.afterUpper4 := NuclearBindingFoldsBatch22.upper4
 rw [NuclearBindingScoreClosure4.scores22,rivalsAppend,block]
 exact upperSuffix23
theorem bestSuffix21 : NuclearBindingScoreClosure4.scores21.foldl bestStep NuclearBindingFoldsBatch21.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores21,bestAppend,NuclearBindingFoldsBatch21.best4]
 exact bestSuffix22
theorem upperSuffix21 : (NuclearBindingScoreClosure4.scores21.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch21.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper4 = NuclearBindingFoldsBatch21.afterUpper4 := NuclearBindingFoldsBatch21.upper4
 rw [NuclearBindingScoreClosure4.scores21,rivalsAppend,block]
 exact upperSuffix22
theorem bestSuffix20 : NuclearBindingScoreClosure4.scores20.foldl bestStep NuclearBindingFoldsBatch20.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores20,bestAppend,NuclearBindingFoldsBatch20.best4]
 exact bestSuffix21
theorem upperSuffix20 : (NuclearBindingScoreClosure4.scores20.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch20.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper4 = NuclearBindingFoldsBatch20.afterUpper4 := NuclearBindingFoldsBatch20.upper4
 rw [NuclearBindingScoreClosure4.scores20,rivalsAppend,block]
 exact upperSuffix21
theorem bestSuffix19 : NuclearBindingScoreClosure4.scores19.foldl bestStep NuclearBindingFoldsBatch19.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores19,bestAppend,NuclearBindingFoldsBatch19.best4]
 exact bestSuffix20
theorem upperSuffix19 : (NuclearBindingScoreClosure4.scores19.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch19.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper4 = NuclearBindingFoldsBatch19.afterUpper4 := NuclearBindingFoldsBatch19.upper4
 rw [NuclearBindingScoreClosure4.scores19,rivalsAppend,block]
 exact upperSuffix20
theorem bestSuffix18 : NuclearBindingScoreClosure4.scores18.foldl bestStep NuclearBindingFoldsBatch18.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores18,bestAppend,NuclearBindingFoldsBatch18.best4]
 exact bestSuffix19
theorem upperSuffix18 : (NuclearBindingScoreClosure4.scores18.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch18.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper4 = NuclearBindingFoldsBatch18.afterUpper4 := NuclearBindingFoldsBatch18.upper4
 rw [NuclearBindingScoreClosure4.scores18,rivalsAppend,block]
 exact upperSuffix19
theorem bestSuffix17 : NuclearBindingScoreClosure4.scores17.foldl bestStep NuclearBindingFoldsBatch17.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores17,bestAppend,NuclearBindingFoldsBatch17.best4]
 exact bestSuffix18
theorem upperSuffix17 : (NuclearBindingScoreClosure4.scores17.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch17.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper4 = NuclearBindingFoldsBatch17.afterUpper4 := NuclearBindingFoldsBatch17.upper4
 rw [NuclearBindingScoreClosure4.scores17,rivalsAppend,block]
 exact upperSuffix18
theorem bestSuffix16 : NuclearBindingScoreClosure4.scores16.foldl bestStep NuclearBindingFoldsBatch16.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores16,bestAppend,NuclearBindingFoldsBatch16.best4]
 exact bestSuffix17
theorem upperSuffix16 : (NuclearBindingScoreClosure4.scores16.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch16.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper4 = NuclearBindingFoldsBatch16.afterUpper4 := NuclearBindingFoldsBatch16.upper4
 rw [NuclearBindingScoreClosure4.scores16,rivalsAppend,block]
 exact upperSuffix17
theorem bestSuffix15 : NuclearBindingScoreClosure4.scores15.foldl bestStep NuclearBindingFoldsBatch15.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores15,bestAppend,NuclearBindingFoldsBatch15.best4]
 exact bestSuffix16
theorem upperSuffix15 : (NuclearBindingScoreClosure4.scores15.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch15.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper4 = NuclearBindingFoldsBatch15.afterUpper4 := NuclearBindingFoldsBatch15.upper4
 rw [NuclearBindingScoreClosure4.scores15,rivalsAppend,block]
 exact upperSuffix16
theorem bestSuffix14 : NuclearBindingScoreClosure4.scores14.foldl bestStep NuclearBindingFoldsBatch14.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores14,bestAppend,NuclearBindingFoldsBatch14.best4]
 exact bestSuffix15
theorem upperSuffix14 : (NuclearBindingScoreClosure4.scores14.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch14.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper4 = NuclearBindingFoldsBatch14.afterUpper4 := NuclearBindingFoldsBatch14.upper4
 rw [NuclearBindingScoreClosure4.scores14,rivalsAppend,block]
 exact upperSuffix15
theorem bestSuffix13 : NuclearBindingScoreClosure4.scores13.foldl bestStep NuclearBindingFoldsBatch13.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores13,bestAppend,NuclearBindingFoldsBatch13.best4]
 exact bestSuffix14
theorem upperSuffix13 : (NuclearBindingScoreClosure4.scores13.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch13.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper4 = NuclearBindingFoldsBatch13.afterUpper4 := NuclearBindingFoldsBatch13.upper4
 rw [NuclearBindingScoreClosure4.scores13,rivalsAppend,block]
 exact upperSuffix14
theorem bestSuffix12 : NuclearBindingScoreClosure4.scores12.foldl bestStep NuclearBindingFoldsBatch12.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores12,bestAppend,NuclearBindingFoldsBatch12.best4]
 exact bestSuffix13
theorem upperSuffix12 : (NuclearBindingScoreClosure4.scores12.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch12.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper4 = NuclearBindingFoldsBatch12.afterUpper4 := NuclearBindingFoldsBatch12.upper4
 rw [NuclearBindingScoreClosure4.scores12,rivalsAppend,block]
 exact upperSuffix13
theorem bestSuffix11 : NuclearBindingScoreClosure4.scores11.foldl bestStep NuclearBindingFoldsBatch11.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores11,bestAppend,NuclearBindingFoldsBatch11.best4]
 exact bestSuffix12
theorem upperSuffix11 : (NuclearBindingScoreClosure4.scores11.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch11.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper4 = NuclearBindingFoldsBatch11.afterUpper4 := NuclearBindingFoldsBatch11.upper4
 rw [NuclearBindingScoreClosure4.scores11,rivalsAppend,block]
 exact upperSuffix12
theorem bestSuffix10 : NuclearBindingScoreClosure4.scores10.foldl bestStep NuclearBindingFoldsBatch10.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores10,bestAppend,NuclearBindingFoldsBatch10.best4]
 exact bestSuffix11
theorem upperSuffix10 : (NuclearBindingScoreClosure4.scores10.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch10.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper4 = NuclearBindingFoldsBatch10.afterUpper4 := NuclearBindingFoldsBatch10.upper4
 rw [NuclearBindingScoreClosure4.scores10,rivalsAppend,block]
 exact upperSuffix11
theorem bestSuffix9 : NuclearBindingScoreClosure4.scores9.foldl bestStep NuclearBindingFoldsBatch09.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores9,bestAppend,NuclearBindingFoldsBatch09.best4]
 exact bestSuffix10
theorem upperSuffix9 : (NuclearBindingScoreClosure4.scores9.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch09.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper4 = NuclearBindingFoldsBatch09.afterUpper4 := NuclearBindingFoldsBatch09.upper4
 rw [NuclearBindingScoreClosure4.scores9,rivalsAppend,block]
 exact upperSuffix10
theorem bestSuffix8 : NuclearBindingScoreClosure4.scores8.foldl bestStep NuclearBindingFoldsBatch08.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores8,bestAppend,NuclearBindingFoldsBatch08.best4]
 exact bestSuffix9
theorem upperSuffix8 : (NuclearBindingScoreClosure4.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch08.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper4 = NuclearBindingFoldsBatch08.afterUpper4 := NuclearBindingFoldsBatch08.upper4
 rw [NuclearBindingScoreClosure4.scores8,rivalsAppend,block]
 exact upperSuffix9
theorem bestSuffix7 : NuclearBindingScoreClosure4.scores7.foldl bestStep NuclearBindingFoldsBatch07.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores7,bestAppend,NuclearBindingFoldsBatch07.best4]
 exact bestSuffix8
theorem upperSuffix7 : (NuclearBindingScoreClosure4.scores7.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch07.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper4 = NuclearBindingFoldsBatch07.afterUpper4 := NuclearBindingFoldsBatch07.upper4
 rw [NuclearBindingScoreClosure4.scores7,rivalsAppend,block]
 exact upperSuffix8
theorem bestSuffix6 : NuclearBindingScoreClosure4.scores6.foldl bestStep NuclearBindingFoldsBatch06.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores6,bestAppend,NuclearBindingFoldsBatch06.best4]
 exact bestSuffix7
theorem upperSuffix6 : (NuclearBindingScoreClosure4.scores6.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch06.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper4 = NuclearBindingFoldsBatch06.afterUpper4 := NuclearBindingFoldsBatch06.upper4
 rw [NuclearBindingScoreClosure4.scores6,rivalsAppend,block]
 exact upperSuffix7
theorem bestSuffix5 : NuclearBindingScoreClosure4.scores5.foldl bestStep NuclearBindingFoldsBatch05.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores5,bestAppend,NuclearBindingFoldsBatch05.best4]
 exact bestSuffix6
theorem upperSuffix5 : (NuclearBindingScoreClosure4.scores5.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch05.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper4 = NuclearBindingFoldsBatch05.afterUpper4 := NuclearBindingFoldsBatch05.upper4
 rw [NuclearBindingScoreClosure4.scores5,rivalsAppend,block]
 exact upperSuffix6
theorem bestSuffix4 : NuclearBindingScoreClosure4.scores4.foldl bestStep NuclearBindingFoldsBatch04.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores4,bestAppend,NuclearBindingFoldsBatch04.best4]
 exact bestSuffix5
theorem upperSuffix4 : (NuclearBindingScoreClosure4.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch04.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper4 = NuclearBindingFoldsBatch04.afterUpper4 := NuclearBindingFoldsBatch04.upper4
 rw [NuclearBindingScoreClosure4.scores4,rivalsAppend,block]
 exact upperSuffix5
theorem bestSuffix3 : NuclearBindingScoreClosure4.scores3.foldl bestStep NuclearBindingFoldsBatch03.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores3,bestAppend,NuclearBindingFoldsBatch03.best4]
 exact bestSuffix4
theorem upperSuffix3 : (NuclearBindingScoreClosure4.scores3.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch03.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper4 = NuclearBindingFoldsBatch03.afterUpper4 := NuclearBindingFoldsBatch03.upper4
 rw [NuclearBindingScoreClosure4.scores3,rivalsAppend,block]
 exact upperSuffix4
theorem bestSuffix2 : NuclearBindingScoreClosure4.scores2.foldl bestStep NuclearBindingFoldsBatch02.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores2,bestAppend,NuclearBindingFoldsBatch02.best4]
 exact bestSuffix3
theorem upperSuffix2 : (NuclearBindingScoreClosure4.scores2.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch02.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper4 = NuclearBindingFoldsBatch02.afterUpper4 := NuclearBindingFoldsBatch02.upper4
 rw [NuclearBindingScoreClosure4.scores2,rivalsAppend,block]
 exact upperSuffix3
theorem bestSuffix1 : NuclearBindingScoreClosure4.scores1.foldl bestStep NuclearBindingFoldsBatch01.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores1,bestAppend,NuclearBindingFoldsBatch01.best4]
 exact bestSuffix2
theorem upperSuffix1 : (NuclearBindingScoreClosure4.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch01.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper4 = NuclearBindingFoldsBatch01.afterUpper4 := NuclearBindingFoldsBatch01.upper4
 rw [NuclearBindingScoreClosure4.scores1,rivalsAppend,block]
 exact upperSuffix2
theorem bestSuffix0 : NuclearBindingScoreClosure4.scores0.foldl bestStep NuclearBindingFoldsBatch00.seedBest4 = winner := by
 rw [NuclearBindingScoreClosure4.scores0,bestAppend,NuclearBindingFoldsBatch00.best4]
 exact bestSuffix1
theorem upperSuffix0 : (NuclearBindingScoreClosure4.scores0.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper4 = upper := by
 have block : (NuclearBindingScoresBatch00.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper4 = NuclearBindingFoldsBatch00.afterUpper4 := NuclearBindingFoldsBatch00.upper4
 rw [NuclearBindingScoreClosure4.scores0,rivalsAppend,block]
 exact upperSuffix1
def restScores := NuclearBindingScoresBatch00.scores4.tail ++ NuclearBindingScoreClosure4.scores1
def restRivals := restScores.filter (fun row => !sameCoordinate row winner)
theorem fullScoresCons : NuclearBindingScoreClosure4.scores0 = first::restScores := rfl
theorem fullRivalsCons : (NuclearBindingScoreClosure4.scores0.filter (fun row => !sameCoordinate row winner)) = first::restRivals :=
 (congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons).trans
 (NuclearBindingPeakAssembly.filterHead _ first restScores (by rfl))
theorem bestValue : bestLower first restScores = winner :=
 NuclearBindingPeakAssembly.bestOfFull first winner restScores (by rfl)
 ((congrArg (fun rows => rows.foldl bestStep first) fullScoresCons).symm.trans bestSuffix0)
theorem upperValue : largestUpper first restRivals = upper :=
 NuclearBindingPeakAssembly.upperOfFull first restRivals upper (by rfl)
 ((congrArg (fun rows => rows.foldl upperStep first.upper) fullRivalsCons).symm.trans upperSuffix0)
theorem stepEvaluation : separationStep NuclearBindingGatherClosure.candidates0 4 =
 (if upper.blt winner.lower then .ok (some ⟨winner,upper,4⟩) else .ok none) :=
 NuclearBindingPeakAssembly.separationFromEvaluations _ _ first restScores winner restRivals upper
 (NuclearBindingScoreClosure4.complete0.trans (congrArg Except.ok fullScoresCons))
 bestValue
 ((congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons.symm).trans fullRivalsCons)
 upperValue
theorem separated : separationStep NuclearBindingGatherClosure.candidates0 4 = .ok none := stepEvaluation.trans (by rfl)
end SFT.Physics.NuclearBindingSeparation4
