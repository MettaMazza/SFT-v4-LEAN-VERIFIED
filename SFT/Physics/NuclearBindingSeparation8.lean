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
import SFT.Physics.NuclearBindingScoreClosure8
namespace SFT.Physics.NuclearBindingSeparation8
open NuclearBindingPeak NuclearBindingFoldComposition
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def winner := NuclearBindingFoldsBatch00.winner8
def first := NuclearBindingFoldsBatch00.seedBest8
def upper := NuclearBindingFoldsBatch63.afterUpper8
theorem bestSuffix63 : NuclearBindingScoreClosure8.scores63.foldl bestStep NuclearBindingFoldsBatch63.seedBest8 = winner := NuclearBindingFoldsBatch63.best8
theorem upperSuffix63 : (NuclearBindingScoreClosure8.scores63.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch63.seedUpper8 = upper := NuclearBindingFoldsBatch63.upper8
theorem bestSuffix62 : NuclearBindingScoreClosure8.scores62.foldl bestStep NuclearBindingFoldsBatch62.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores62,bestAppend,NuclearBindingFoldsBatch62.best8]
 exact bestSuffix63
theorem upperSuffix62 : (NuclearBindingScoreClosure8.scores62.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch62.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch62.seedUpper8 = NuclearBindingFoldsBatch62.afterUpper8 := NuclearBindingFoldsBatch62.upper8
 rw [NuclearBindingScoreClosure8.scores62,rivalsAppend,block]
 exact upperSuffix63
theorem bestSuffix61 : NuclearBindingScoreClosure8.scores61.foldl bestStep NuclearBindingFoldsBatch61.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores61,bestAppend,NuclearBindingFoldsBatch61.best8]
 exact bestSuffix62
theorem upperSuffix61 : (NuclearBindingScoreClosure8.scores61.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch61.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch61.seedUpper8 = NuclearBindingFoldsBatch61.afterUpper8 := NuclearBindingFoldsBatch61.upper8
 rw [NuclearBindingScoreClosure8.scores61,rivalsAppend,block]
 exact upperSuffix62
theorem bestSuffix60 : NuclearBindingScoreClosure8.scores60.foldl bestStep NuclearBindingFoldsBatch60.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores60,bestAppend,NuclearBindingFoldsBatch60.best8]
 exact bestSuffix61
theorem upperSuffix60 : (NuclearBindingScoreClosure8.scores60.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch60.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch60.seedUpper8 = NuclearBindingFoldsBatch60.afterUpper8 := NuclearBindingFoldsBatch60.upper8
 rw [NuclearBindingScoreClosure8.scores60,rivalsAppend,block]
 exact upperSuffix61
theorem bestSuffix59 : NuclearBindingScoreClosure8.scores59.foldl bestStep NuclearBindingFoldsBatch59.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores59,bestAppend,NuclearBindingFoldsBatch59.best8]
 exact bestSuffix60
theorem upperSuffix59 : (NuclearBindingScoreClosure8.scores59.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch59.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch59.seedUpper8 = NuclearBindingFoldsBatch59.afterUpper8 := NuclearBindingFoldsBatch59.upper8
 rw [NuclearBindingScoreClosure8.scores59,rivalsAppend,block]
 exact upperSuffix60
theorem bestSuffix58 : NuclearBindingScoreClosure8.scores58.foldl bestStep NuclearBindingFoldsBatch58.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores58,bestAppend,NuclearBindingFoldsBatch58.best8]
 exact bestSuffix59
theorem upperSuffix58 : (NuclearBindingScoreClosure8.scores58.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch58.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch58.seedUpper8 = NuclearBindingFoldsBatch58.afterUpper8 := NuclearBindingFoldsBatch58.upper8
 rw [NuclearBindingScoreClosure8.scores58,rivalsAppend,block]
 exact upperSuffix59
theorem bestSuffix57 : NuclearBindingScoreClosure8.scores57.foldl bestStep NuclearBindingFoldsBatch57.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores57,bestAppend,NuclearBindingFoldsBatch57.best8]
 exact bestSuffix58
theorem upperSuffix57 : (NuclearBindingScoreClosure8.scores57.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch57.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch57.seedUpper8 = NuclearBindingFoldsBatch57.afterUpper8 := NuclearBindingFoldsBatch57.upper8
 rw [NuclearBindingScoreClosure8.scores57,rivalsAppend,block]
 exact upperSuffix58
theorem bestSuffix56 : NuclearBindingScoreClosure8.scores56.foldl bestStep NuclearBindingFoldsBatch56.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores56,bestAppend,NuclearBindingFoldsBatch56.best8]
 exact bestSuffix57
theorem upperSuffix56 : (NuclearBindingScoreClosure8.scores56.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch56.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch56.seedUpper8 = NuclearBindingFoldsBatch56.afterUpper8 := NuclearBindingFoldsBatch56.upper8
 rw [NuclearBindingScoreClosure8.scores56,rivalsAppend,block]
 exact upperSuffix57
theorem bestSuffix55 : NuclearBindingScoreClosure8.scores55.foldl bestStep NuclearBindingFoldsBatch55.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores55,bestAppend,NuclearBindingFoldsBatch55.best8]
 exact bestSuffix56
theorem upperSuffix55 : (NuclearBindingScoreClosure8.scores55.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch55.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch55.seedUpper8 = NuclearBindingFoldsBatch55.afterUpper8 := NuclearBindingFoldsBatch55.upper8
 rw [NuclearBindingScoreClosure8.scores55,rivalsAppend,block]
 exact upperSuffix56
theorem bestSuffix54 : NuclearBindingScoreClosure8.scores54.foldl bestStep NuclearBindingFoldsBatch54.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores54,bestAppend,NuclearBindingFoldsBatch54.best8]
 exact bestSuffix55
theorem upperSuffix54 : (NuclearBindingScoreClosure8.scores54.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch54.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch54.seedUpper8 = NuclearBindingFoldsBatch54.afterUpper8 := NuclearBindingFoldsBatch54.upper8
 rw [NuclearBindingScoreClosure8.scores54,rivalsAppend,block]
 exact upperSuffix55
theorem bestSuffix53 : NuclearBindingScoreClosure8.scores53.foldl bestStep NuclearBindingFoldsBatch53.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores53,bestAppend,NuclearBindingFoldsBatch53.best8]
 exact bestSuffix54
theorem upperSuffix53 : (NuclearBindingScoreClosure8.scores53.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch53.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch53.seedUpper8 = NuclearBindingFoldsBatch53.afterUpper8 := NuclearBindingFoldsBatch53.upper8
 rw [NuclearBindingScoreClosure8.scores53,rivalsAppend,block]
 exact upperSuffix54
theorem bestSuffix52 : NuclearBindingScoreClosure8.scores52.foldl bestStep NuclearBindingFoldsBatch52.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores52,bestAppend,NuclearBindingFoldsBatch52.best8]
 exact bestSuffix53
theorem upperSuffix52 : (NuclearBindingScoreClosure8.scores52.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch52.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch52.seedUpper8 = NuclearBindingFoldsBatch52.afterUpper8 := NuclearBindingFoldsBatch52.upper8
 rw [NuclearBindingScoreClosure8.scores52,rivalsAppend,block]
 exact upperSuffix53
theorem bestSuffix51 : NuclearBindingScoreClosure8.scores51.foldl bestStep NuclearBindingFoldsBatch51.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores51,bestAppend,NuclearBindingFoldsBatch51.best8]
 exact bestSuffix52
theorem upperSuffix51 : (NuclearBindingScoreClosure8.scores51.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch51.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch51.seedUpper8 = NuclearBindingFoldsBatch51.afterUpper8 := NuclearBindingFoldsBatch51.upper8
 rw [NuclearBindingScoreClosure8.scores51,rivalsAppend,block]
 exact upperSuffix52
theorem bestSuffix50 : NuclearBindingScoreClosure8.scores50.foldl bestStep NuclearBindingFoldsBatch50.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores50,bestAppend,NuclearBindingFoldsBatch50.best8]
 exact bestSuffix51
theorem upperSuffix50 : (NuclearBindingScoreClosure8.scores50.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch50.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch50.seedUpper8 = NuclearBindingFoldsBatch50.afterUpper8 := NuclearBindingFoldsBatch50.upper8
 rw [NuclearBindingScoreClosure8.scores50,rivalsAppend,block]
 exact upperSuffix51
theorem bestSuffix49 : NuclearBindingScoreClosure8.scores49.foldl bestStep NuclearBindingFoldsBatch49.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores49,bestAppend,NuclearBindingFoldsBatch49.best8]
 exact bestSuffix50
theorem upperSuffix49 : (NuclearBindingScoreClosure8.scores49.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch49.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch49.seedUpper8 = NuclearBindingFoldsBatch49.afterUpper8 := NuclearBindingFoldsBatch49.upper8
 rw [NuclearBindingScoreClosure8.scores49,rivalsAppend,block]
 exact upperSuffix50
theorem bestSuffix48 : NuclearBindingScoreClosure8.scores48.foldl bestStep NuclearBindingFoldsBatch48.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores48,bestAppend,NuclearBindingFoldsBatch48.best8]
 exact bestSuffix49
theorem upperSuffix48 : (NuclearBindingScoreClosure8.scores48.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch48.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch48.seedUpper8 = NuclearBindingFoldsBatch48.afterUpper8 := NuclearBindingFoldsBatch48.upper8
 rw [NuclearBindingScoreClosure8.scores48,rivalsAppend,block]
 exact upperSuffix49
theorem bestSuffix47 : NuclearBindingScoreClosure8.scores47.foldl bestStep NuclearBindingFoldsBatch47.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores47,bestAppend,NuclearBindingFoldsBatch47.best8]
 exact bestSuffix48
theorem upperSuffix47 : (NuclearBindingScoreClosure8.scores47.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch47.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch47.seedUpper8 = NuclearBindingFoldsBatch47.afterUpper8 := NuclearBindingFoldsBatch47.upper8
 rw [NuclearBindingScoreClosure8.scores47,rivalsAppend,block]
 exact upperSuffix48
theorem bestSuffix46 : NuclearBindingScoreClosure8.scores46.foldl bestStep NuclearBindingFoldsBatch46.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores46,bestAppend,NuclearBindingFoldsBatch46.best8]
 exact bestSuffix47
theorem upperSuffix46 : (NuclearBindingScoreClosure8.scores46.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch46.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch46.seedUpper8 = NuclearBindingFoldsBatch46.afterUpper8 := NuclearBindingFoldsBatch46.upper8
 rw [NuclearBindingScoreClosure8.scores46,rivalsAppend,block]
 exact upperSuffix47
theorem bestSuffix45 : NuclearBindingScoreClosure8.scores45.foldl bestStep NuclearBindingFoldsBatch45.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores45,bestAppend,NuclearBindingFoldsBatch45.best8]
 exact bestSuffix46
theorem upperSuffix45 : (NuclearBindingScoreClosure8.scores45.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch45.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch45.seedUpper8 = NuclearBindingFoldsBatch45.afterUpper8 := NuclearBindingFoldsBatch45.upper8
 rw [NuclearBindingScoreClosure8.scores45,rivalsAppend,block]
 exact upperSuffix46
theorem bestSuffix44 : NuclearBindingScoreClosure8.scores44.foldl bestStep NuclearBindingFoldsBatch44.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores44,bestAppend,NuclearBindingFoldsBatch44.best8]
 exact bestSuffix45
theorem upperSuffix44 : (NuclearBindingScoreClosure8.scores44.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch44.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch44.seedUpper8 = NuclearBindingFoldsBatch44.afterUpper8 := NuclearBindingFoldsBatch44.upper8
 rw [NuclearBindingScoreClosure8.scores44,rivalsAppend,block]
 exact upperSuffix45
theorem bestSuffix43 : NuclearBindingScoreClosure8.scores43.foldl bestStep NuclearBindingFoldsBatch43.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores43,bestAppend,NuclearBindingFoldsBatch43.best8]
 exact bestSuffix44
theorem upperSuffix43 : (NuclearBindingScoreClosure8.scores43.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch43.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch43.seedUpper8 = NuclearBindingFoldsBatch43.afterUpper8 := NuclearBindingFoldsBatch43.upper8
 rw [NuclearBindingScoreClosure8.scores43,rivalsAppend,block]
 exact upperSuffix44
theorem bestSuffix42 : NuclearBindingScoreClosure8.scores42.foldl bestStep NuclearBindingFoldsBatch42.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores42,bestAppend,NuclearBindingFoldsBatch42.best8]
 exact bestSuffix43
theorem upperSuffix42 : (NuclearBindingScoreClosure8.scores42.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch42.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch42.seedUpper8 = NuclearBindingFoldsBatch42.afterUpper8 := NuclearBindingFoldsBatch42.upper8
 rw [NuclearBindingScoreClosure8.scores42,rivalsAppend,block]
 exact upperSuffix43
theorem bestSuffix41 : NuclearBindingScoreClosure8.scores41.foldl bestStep NuclearBindingFoldsBatch41.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores41,bestAppend,NuclearBindingFoldsBatch41.best8]
 exact bestSuffix42
theorem upperSuffix41 : (NuclearBindingScoreClosure8.scores41.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch41.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch41.seedUpper8 = NuclearBindingFoldsBatch41.afterUpper8 := NuclearBindingFoldsBatch41.upper8
 rw [NuclearBindingScoreClosure8.scores41,rivalsAppend,block]
 exact upperSuffix42
theorem bestSuffix40 : NuclearBindingScoreClosure8.scores40.foldl bestStep NuclearBindingFoldsBatch40.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores40,bestAppend,NuclearBindingFoldsBatch40.best8]
 exact bestSuffix41
theorem upperSuffix40 : (NuclearBindingScoreClosure8.scores40.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch40.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch40.seedUpper8 = NuclearBindingFoldsBatch40.afterUpper8 := NuclearBindingFoldsBatch40.upper8
 rw [NuclearBindingScoreClosure8.scores40,rivalsAppend,block]
 exact upperSuffix41
theorem bestSuffix39 : NuclearBindingScoreClosure8.scores39.foldl bestStep NuclearBindingFoldsBatch39.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores39,bestAppend,NuclearBindingFoldsBatch39.best8]
 exact bestSuffix40
theorem upperSuffix39 : (NuclearBindingScoreClosure8.scores39.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch39.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch39.seedUpper8 = NuclearBindingFoldsBatch39.afterUpper8 := NuclearBindingFoldsBatch39.upper8
 rw [NuclearBindingScoreClosure8.scores39,rivalsAppend,block]
 exact upperSuffix40
theorem bestSuffix38 : NuclearBindingScoreClosure8.scores38.foldl bestStep NuclearBindingFoldsBatch38.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores38,bestAppend,NuclearBindingFoldsBatch38.best8]
 exact bestSuffix39
theorem upperSuffix38 : (NuclearBindingScoreClosure8.scores38.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch38.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch38.seedUpper8 = NuclearBindingFoldsBatch38.afterUpper8 := NuclearBindingFoldsBatch38.upper8
 rw [NuclearBindingScoreClosure8.scores38,rivalsAppend,block]
 exact upperSuffix39
theorem bestSuffix37 : NuclearBindingScoreClosure8.scores37.foldl bestStep NuclearBindingFoldsBatch37.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores37,bestAppend,NuclearBindingFoldsBatch37.best8]
 exact bestSuffix38
theorem upperSuffix37 : (NuclearBindingScoreClosure8.scores37.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch37.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch37.seedUpper8 = NuclearBindingFoldsBatch37.afterUpper8 := NuclearBindingFoldsBatch37.upper8
 rw [NuclearBindingScoreClosure8.scores37,rivalsAppend,block]
 exact upperSuffix38
theorem bestSuffix36 : NuclearBindingScoreClosure8.scores36.foldl bestStep NuclearBindingFoldsBatch36.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores36,bestAppend,NuclearBindingFoldsBatch36.best8]
 exact bestSuffix37
theorem upperSuffix36 : (NuclearBindingScoreClosure8.scores36.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch36.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch36.seedUpper8 = NuclearBindingFoldsBatch36.afterUpper8 := NuclearBindingFoldsBatch36.upper8
 rw [NuclearBindingScoreClosure8.scores36,rivalsAppend,block]
 exact upperSuffix37
theorem bestSuffix35 : NuclearBindingScoreClosure8.scores35.foldl bestStep NuclearBindingFoldsBatch35.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores35,bestAppend,NuclearBindingFoldsBatch35.best8]
 exact bestSuffix36
theorem upperSuffix35 : (NuclearBindingScoreClosure8.scores35.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch35.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch35.seedUpper8 = NuclearBindingFoldsBatch35.afterUpper8 := NuclearBindingFoldsBatch35.upper8
 rw [NuclearBindingScoreClosure8.scores35,rivalsAppend,block]
 exact upperSuffix36
theorem bestSuffix34 : NuclearBindingScoreClosure8.scores34.foldl bestStep NuclearBindingFoldsBatch34.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores34,bestAppend,NuclearBindingFoldsBatch34.best8]
 exact bestSuffix35
theorem upperSuffix34 : (NuclearBindingScoreClosure8.scores34.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch34.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch34.seedUpper8 = NuclearBindingFoldsBatch34.afterUpper8 := NuclearBindingFoldsBatch34.upper8
 rw [NuclearBindingScoreClosure8.scores34,rivalsAppend,block]
 exact upperSuffix35
theorem bestSuffix33 : NuclearBindingScoreClosure8.scores33.foldl bestStep NuclearBindingFoldsBatch33.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores33,bestAppend,NuclearBindingFoldsBatch33.best8]
 exact bestSuffix34
theorem upperSuffix33 : (NuclearBindingScoreClosure8.scores33.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch33.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch33.seedUpper8 = NuclearBindingFoldsBatch33.afterUpper8 := NuclearBindingFoldsBatch33.upper8
 rw [NuclearBindingScoreClosure8.scores33,rivalsAppend,block]
 exact upperSuffix34
theorem bestSuffix32 : NuclearBindingScoreClosure8.scores32.foldl bestStep NuclearBindingFoldsBatch32.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores32,bestAppend,NuclearBindingFoldsBatch32.best8]
 exact bestSuffix33
theorem upperSuffix32 : (NuclearBindingScoreClosure8.scores32.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch32.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch32.seedUpper8 = NuclearBindingFoldsBatch32.afterUpper8 := NuclearBindingFoldsBatch32.upper8
 rw [NuclearBindingScoreClosure8.scores32,rivalsAppend,block]
 exact upperSuffix33
theorem bestSuffix31 : NuclearBindingScoreClosure8.scores31.foldl bestStep NuclearBindingFoldsBatch31.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores31,bestAppend,NuclearBindingFoldsBatch31.best8]
 exact bestSuffix32
theorem upperSuffix31 : (NuclearBindingScoreClosure8.scores31.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch31.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch31.seedUpper8 = NuclearBindingFoldsBatch31.afterUpper8 := NuclearBindingFoldsBatch31.upper8
 rw [NuclearBindingScoreClosure8.scores31,rivalsAppend,block]
 exact upperSuffix32
theorem bestSuffix30 : NuclearBindingScoreClosure8.scores30.foldl bestStep NuclearBindingFoldsBatch30.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores30,bestAppend,NuclearBindingFoldsBatch30.best8]
 exact bestSuffix31
theorem upperSuffix30 : (NuclearBindingScoreClosure8.scores30.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch30.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch30.seedUpper8 = NuclearBindingFoldsBatch30.afterUpper8 := NuclearBindingFoldsBatch30.upper8
 rw [NuclearBindingScoreClosure8.scores30,rivalsAppend,block]
 exact upperSuffix31
theorem bestSuffix29 : NuclearBindingScoreClosure8.scores29.foldl bestStep NuclearBindingFoldsBatch29.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores29,bestAppend,NuclearBindingFoldsBatch29.best8]
 exact bestSuffix30
theorem upperSuffix29 : (NuclearBindingScoreClosure8.scores29.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch29.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch29.seedUpper8 = NuclearBindingFoldsBatch29.afterUpper8 := NuclearBindingFoldsBatch29.upper8
 rw [NuclearBindingScoreClosure8.scores29,rivalsAppend,block]
 exact upperSuffix30
theorem bestSuffix28 : NuclearBindingScoreClosure8.scores28.foldl bestStep NuclearBindingFoldsBatch28.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores28,bestAppend,NuclearBindingFoldsBatch28.best8]
 exact bestSuffix29
theorem upperSuffix28 : (NuclearBindingScoreClosure8.scores28.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch28.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch28.seedUpper8 = NuclearBindingFoldsBatch28.afterUpper8 := NuclearBindingFoldsBatch28.upper8
 rw [NuclearBindingScoreClosure8.scores28,rivalsAppend,block]
 exact upperSuffix29
theorem bestSuffix27 : NuclearBindingScoreClosure8.scores27.foldl bestStep NuclearBindingFoldsBatch27.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores27,bestAppend,NuclearBindingFoldsBatch27.best8]
 exact bestSuffix28
theorem upperSuffix27 : (NuclearBindingScoreClosure8.scores27.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch27.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch27.seedUpper8 = NuclearBindingFoldsBatch27.afterUpper8 := NuclearBindingFoldsBatch27.upper8
 rw [NuclearBindingScoreClosure8.scores27,rivalsAppend,block]
 exact upperSuffix28
theorem bestSuffix26 : NuclearBindingScoreClosure8.scores26.foldl bestStep NuclearBindingFoldsBatch26.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores26,bestAppend,NuclearBindingFoldsBatch26.best8]
 exact bestSuffix27
theorem upperSuffix26 : (NuclearBindingScoreClosure8.scores26.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch26.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch26.seedUpper8 = NuclearBindingFoldsBatch26.afterUpper8 := NuclearBindingFoldsBatch26.upper8
 rw [NuclearBindingScoreClosure8.scores26,rivalsAppend,block]
 exact upperSuffix27
theorem bestSuffix25 : NuclearBindingScoreClosure8.scores25.foldl bestStep NuclearBindingFoldsBatch25.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores25,bestAppend,NuclearBindingFoldsBatch25.best8]
 exact bestSuffix26
theorem upperSuffix25 : (NuclearBindingScoreClosure8.scores25.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch25.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch25.seedUpper8 = NuclearBindingFoldsBatch25.afterUpper8 := NuclearBindingFoldsBatch25.upper8
 rw [NuclearBindingScoreClosure8.scores25,rivalsAppend,block]
 exact upperSuffix26
theorem bestSuffix24 : NuclearBindingScoreClosure8.scores24.foldl bestStep NuclearBindingFoldsBatch24.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores24,bestAppend,NuclearBindingFoldsBatch24.best8]
 exact bestSuffix25
theorem upperSuffix24 : (NuclearBindingScoreClosure8.scores24.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch24.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch24.seedUpper8 = NuclearBindingFoldsBatch24.afterUpper8 := NuclearBindingFoldsBatch24.upper8
 rw [NuclearBindingScoreClosure8.scores24,rivalsAppend,block]
 exact upperSuffix25
theorem bestSuffix23 : NuclearBindingScoreClosure8.scores23.foldl bestStep NuclearBindingFoldsBatch23.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores23,bestAppend,NuclearBindingFoldsBatch23.best8]
 exact bestSuffix24
theorem upperSuffix23 : (NuclearBindingScoreClosure8.scores23.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch23.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch23.seedUpper8 = NuclearBindingFoldsBatch23.afterUpper8 := NuclearBindingFoldsBatch23.upper8
 rw [NuclearBindingScoreClosure8.scores23,rivalsAppend,block]
 exact upperSuffix24
theorem bestSuffix22 : NuclearBindingScoreClosure8.scores22.foldl bestStep NuclearBindingFoldsBatch22.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores22,bestAppend,NuclearBindingFoldsBatch22.best8]
 exact bestSuffix23
theorem upperSuffix22 : (NuclearBindingScoreClosure8.scores22.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch22.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch22.seedUpper8 = NuclearBindingFoldsBatch22.afterUpper8 := NuclearBindingFoldsBatch22.upper8
 rw [NuclearBindingScoreClosure8.scores22,rivalsAppend,block]
 exact upperSuffix23
theorem bestSuffix21 : NuclearBindingScoreClosure8.scores21.foldl bestStep NuclearBindingFoldsBatch21.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores21,bestAppend,NuclearBindingFoldsBatch21.best8]
 exact bestSuffix22
theorem upperSuffix21 : (NuclearBindingScoreClosure8.scores21.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch21.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch21.seedUpper8 = NuclearBindingFoldsBatch21.afterUpper8 := NuclearBindingFoldsBatch21.upper8
 rw [NuclearBindingScoreClosure8.scores21,rivalsAppend,block]
 exact upperSuffix22
theorem bestSuffix20 : NuclearBindingScoreClosure8.scores20.foldl bestStep NuclearBindingFoldsBatch20.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores20,bestAppend,NuclearBindingFoldsBatch20.best8]
 exact bestSuffix21
theorem upperSuffix20 : (NuclearBindingScoreClosure8.scores20.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch20.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch20.seedUpper8 = NuclearBindingFoldsBatch20.afterUpper8 := NuclearBindingFoldsBatch20.upper8
 rw [NuclearBindingScoreClosure8.scores20,rivalsAppend,block]
 exact upperSuffix21
theorem bestSuffix19 : NuclearBindingScoreClosure8.scores19.foldl bestStep NuclearBindingFoldsBatch19.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores19,bestAppend,NuclearBindingFoldsBatch19.best8]
 exact bestSuffix20
theorem upperSuffix19 : (NuclearBindingScoreClosure8.scores19.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch19.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch19.seedUpper8 = NuclearBindingFoldsBatch19.afterUpper8 := NuclearBindingFoldsBatch19.upper8
 rw [NuclearBindingScoreClosure8.scores19,rivalsAppend,block]
 exact upperSuffix20
theorem bestSuffix18 : NuclearBindingScoreClosure8.scores18.foldl bestStep NuclearBindingFoldsBatch18.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores18,bestAppend,NuclearBindingFoldsBatch18.best8]
 exact bestSuffix19
theorem upperSuffix18 : (NuclearBindingScoreClosure8.scores18.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch18.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch18.seedUpper8 = NuclearBindingFoldsBatch18.afterUpper8 := NuclearBindingFoldsBatch18.upper8
 rw [NuclearBindingScoreClosure8.scores18,rivalsAppend,block]
 exact upperSuffix19
theorem bestSuffix17 : NuclearBindingScoreClosure8.scores17.foldl bestStep NuclearBindingFoldsBatch17.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores17,bestAppend,NuclearBindingFoldsBatch17.best8]
 exact bestSuffix18
theorem upperSuffix17 : (NuclearBindingScoreClosure8.scores17.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch17.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch17.seedUpper8 = NuclearBindingFoldsBatch17.afterUpper8 := NuclearBindingFoldsBatch17.upper8
 rw [NuclearBindingScoreClosure8.scores17,rivalsAppend,block]
 exact upperSuffix18
theorem bestSuffix16 : NuclearBindingScoreClosure8.scores16.foldl bestStep NuclearBindingFoldsBatch16.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores16,bestAppend,NuclearBindingFoldsBatch16.best8]
 exact bestSuffix17
theorem upperSuffix16 : (NuclearBindingScoreClosure8.scores16.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch16.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch16.seedUpper8 = NuclearBindingFoldsBatch16.afterUpper8 := NuclearBindingFoldsBatch16.upper8
 rw [NuclearBindingScoreClosure8.scores16,rivalsAppend,block]
 exact upperSuffix17
theorem bestSuffix15 : NuclearBindingScoreClosure8.scores15.foldl bestStep NuclearBindingFoldsBatch15.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores15,bestAppend,NuclearBindingFoldsBatch15.best8]
 exact bestSuffix16
theorem upperSuffix15 : (NuclearBindingScoreClosure8.scores15.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch15.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch15.seedUpper8 = NuclearBindingFoldsBatch15.afterUpper8 := NuclearBindingFoldsBatch15.upper8
 rw [NuclearBindingScoreClosure8.scores15,rivalsAppend,block]
 exact upperSuffix16
theorem bestSuffix14 : NuclearBindingScoreClosure8.scores14.foldl bestStep NuclearBindingFoldsBatch14.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores14,bestAppend,NuclearBindingFoldsBatch14.best8]
 exact bestSuffix15
theorem upperSuffix14 : (NuclearBindingScoreClosure8.scores14.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch14.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch14.seedUpper8 = NuclearBindingFoldsBatch14.afterUpper8 := NuclearBindingFoldsBatch14.upper8
 rw [NuclearBindingScoreClosure8.scores14,rivalsAppend,block]
 exact upperSuffix15
theorem bestSuffix13 : NuclearBindingScoreClosure8.scores13.foldl bestStep NuclearBindingFoldsBatch13.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores13,bestAppend,NuclearBindingFoldsBatch13.best8]
 exact bestSuffix14
theorem upperSuffix13 : (NuclearBindingScoreClosure8.scores13.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch13.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch13.seedUpper8 = NuclearBindingFoldsBatch13.afterUpper8 := NuclearBindingFoldsBatch13.upper8
 rw [NuclearBindingScoreClosure8.scores13,rivalsAppend,block]
 exact upperSuffix14
theorem bestSuffix12 : NuclearBindingScoreClosure8.scores12.foldl bestStep NuclearBindingFoldsBatch12.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores12,bestAppend,NuclearBindingFoldsBatch12.best8]
 exact bestSuffix13
theorem upperSuffix12 : (NuclearBindingScoreClosure8.scores12.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch12.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch12.seedUpper8 = NuclearBindingFoldsBatch12.afterUpper8 := NuclearBindingFoldsBatch12.upper8
 rw [NuclearBindingScoreClosure8.scores12,rivalsAppend,block]
 exact upperSuffix13
theorem bestSuffix11 : NuclearBindingScoreClosure8.scores11.foldl bestStep NuclearBindingFoldsBatch11.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores11,bestAppend,NuclearBindingFoldsBatch11.best8]
 exact bestSuffix12
theorem upperSuffix11 : (NuclearBindingScoreClosure8.scores11.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch11.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch11.seedUpper8 = NuclearBindingFoldsBatch11.afterUpper8 := NuclearBindingFoldsBatch11.upper8
 rw [NuclearBindingScoreClosure8.scores11,rivalsAppend,block]
 exact upperSuffix12
theorem bestSuffix10 : NuclearBindingScoreClosure8.scores10.foldl bestStep NuclearBindingFoldsBatch10.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores10,bestAppend,NuclearBindingFoldsBatch10.best8]
 exact bestSuffix11
theorem upperSuffix10 : (NuclearBindingScoreClosure8.scores10.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch10.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch10.seedUpper8 = NuclearBindingFoldsBatch10.afterUpper8 := NuclearBindingFoldsBatch10.upper8
 rw [NuclearBindingScoreClosure8.scores10,rivalsAppend,block]
 exact upperSuffix11
theorem bestSuffix9 : NuclearBindingScoreClosure8.scores9.foldl bestStep NuclearBindingFoldsBatch09.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores9,bestAppend,NuclearBindingFoldsBatch09.best8]
 exact bestSuffix10
theorem upperSuffix9 : (NuclearBindingScoreClosure8.scores9.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch09.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch09.seedUpper8 = NuclearBindingFoldsBatch09.afterUpper8 := NuclearBindingFoldsBatch09.upper8
 rw [NuclearBindingScoreClosure8.scores9,rivalsAppend,block]
 exact upperSuffix10
theorem bestSuffix8 : NuclearBindingScoreClosure8.scores8.foldl bestStep NuclearBindingFoldsBatch08.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores8,bestAppend,NuclearBindingFoldsBatch08.best8]
 exact bestSuffix9
theorem upperSuffix8 : (NuclearBindingScoreClosure8.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch08.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch08.seedUpper8 = NuclearBindingFoldsBatch08.afterUpper8 := NuclearBindingFoldsBatch08.upper8
 rw [NuclearBindingScoreClosure8.scores8,rivalsAppend,block]
 exact upperSuffix9
theorem bestSuffix7 : NuclearBindingScoreClosure8.scores7.foldl bestStep NuclearBindingFoldsBatch07.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores7,bestAppend,NuclearBindingFoldsBatch07.best8]
 exact bestSuffix8
theorem upperSuffix7 : (NuclearBindingScoreClosure8.scores7.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch07.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch07.seedUpper8 = NuclearBindingFoldsBatch07.afterUpper8 := NuclearBindingFoldsBatch07.upper8
 rw [NuclearBindingScoreClosure8.scores7,rivalsAppend,block]
 exact upperSuffix8
theorem bestSuffix6 : NuclearBindingScoreClosure8.scores6.foldl bestStep NuclearBindingFoldsBatch06.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores6,bestAppend,NuclearBindingFoldsBatch06.best8]
 exact bestSuffix7
theorem upperSuffix6 : (NuclearBindingScoreClosure8.scores6.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch06.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch06.seedUpper8 = NuclearBindingFoldsBatch06.afterUpper8 := NuclearBindingFoldsBatch06.upper8
 rw [NuclearBindingScoreClosure8.scores6,rivalsAppend,block]
 exact upperSuffix7
theorem bestSuffix5 : NuclearBindingScoreClosure8.scores5.foldl bestStep NuclearBindingFoldsBatch05.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores5,bestAppend,NuclearBindingFoldsBatch05.best8]
 exact bestSuffix6
theorem upperSuffix5 : (NuclearBindingScoreClosure8.scores5.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch05.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch05.seedUpper8 = NuclearBindingFoldsBatch05.afterUpper8 := NuclearBindingFoldsBatch05.upper8
 rw [NuclearBindingScoreClosure8.scores5,rivalsAppend,block]
 exact upperSuffix6
theorem bestSuffix4 : NuclearBindingScoreClosure8.scores4.foldl bestStep NuclearBindingFoldsBatch04.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores4,bestAppend,NuclearBindingFoldsBatch04.best8]
 exact bestSuffix5
theorem upperSuffix4 : (NuclearBindingScoreClosure8.scores4.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch04.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch04.seedUpper8 = NuclearBindingFoldsBatch04.afterUpper8 := NuclearBindingFoldsBatch04.upper8
 rw [NuclearBindingScoreClosure8.scores4,rivalsAppend,block]
 exact upperSuffix5
theorem bestSuffix3 : NuclearBindingScoreClosure8.scores3.foldl bestStep NuclearBindingFoldsBatch03.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores3,bestAppend,NuclearBindingFoldsBatch03.best8]
 exact bestSuffix4
theorem upperSuffix3 : (NuclearBindingScoreClosure8.scores3.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch03.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch03.seedUpper8 = NuclearBindingFoldsBatch03.afterUpper8 := NuclearBindingFoldsBatch03.upper8
 rw [NuclearBindingScoreClosure8.scores3,rivalsAppend,block]
 exact upperSuffix4
theorem bestSuffix2 : NuclearBindingScoreClosure8.scores2.foldl bestStep NuclearBindingFoldsBatch02.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores2,bestAppend,NuclearBindingFoldsBatch02.best8]
 exact bestSuffix3
theorem upperSuffix2 : (NuclearBindingScoreClosure8.scores2.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch02.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch02.seedUpper8 = NuclearBindingFoldsBatch02.afterUpper8 := NuclearBindingFoldsBatch02.upper8
 rw [NuclearBindingScoreClosure8.scores2,rivalsAppend,block]
 exact upperSuffix3
theorem bestSuffix1 : NuclearBindingScoreClosure8.scores1.foldl bestStep NuclearBindingFoldsBatch01.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores1,bestAppend,NuclearBindingFoldsBatch01.best8]
 exact bestSuffix2
theorem upperSuffix1 : (NuclearBindingScoreClosure8.scores1.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch01.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch01.seedUpper8 = NuclearBindingFoldsBatch01.afterUpper8 := NuclearBindingFoldsBatch01.upper8
 rw [NuclearBindingScoreClosure8.scores1,rivalsAppend,block]
 exact upperSuffix2
theorem bestSuffix0 : NuclearBindingScoreClosure8.scores0.foldl bestStep NuclearBindingFoldsBatch00.seedBest8 = winner := by
 rw [NuclearBindingScoreClosure8.scores0,bestAppend,NuclearBindingFoldsBatch00.best8]
 exact bestSuffix1
theorem upperSuffix0 : (NuclearBindingScoreClosure8.scores0.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper8 = upper := by
 have block : (NuclearBindingScoresBatch00.scores8.filter (fun row => !sameCoordinate row winner)).foldl upperStep NuclearBindingFoldsBatch00.seedUpper8 = NuclearBindingFoldsBatch00.afterUpper8 := NuclearBindingFoldsBatch00.upper8
 rw [NuclearBindingScoreClosure8.scores0,rivalsAppend,block]
 exact upperSuffix1
def restScores := NuclearBindingScoresBatch00.scores8.tail ++ NuclearBindingScoreClosure8.scores1
def restRivals := restScores.filter (fun row => !sameCoordinate row winner)
theorem fullScoresCons : NuclearBindingScoreClosure8.scores0 = first::restScores := rfl
theorem fullRivalsCons : (NuclearBindingScoreClosure8.scores0.filter (fun row => !sameCoordinate row winner)) = first::restRivals :=
 (congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons).trans
 (NuclearBindingPeakAssembly.filterHead _ first restScores (by rfl))
theorem bestValue : bestLower first restScores = winner :=
 NuclearBindingPeakAssembly.bestOfFull first winner restScores (by rfl)
 ((congrArg (fun rows => rows.foldl bestStep first) fullScoresCons).symm.trans bestSuffix0)
theorem upperValue : largestUpper first restRivals = upper :=
 NuclearBindingPeakAssembly.upperOfFull first restRivals upper (by rfl)
 ((congrArg (fun rows => rows.foldl upperStep first.upper) fullRivalsCons).symm.trans upperSuffix0)
theorem stepEvaluation : separationStep NuclearBindingGatherClosure.candidates0 8 =
 (if upper.blt winner.lower then .ok (some ⟨winner,upper,8⟩) else .ok none) :=
 NuclearBindingPeakAssembly.separationFromEvaluations _ _ first restScores winner restRivals upper
 (NuclearBindingScoreClosure8.complete0.trans (congrArg Except.ok fullScoresCons))
 bestValue
 ((congrArg (List.filter (fun row => !sameCoordinate row winner)) fullScoresCons.symm).trans fullRivalsCons)
 upperValue
theorem separated : separationStep NuclearBindingGatherClosure.candidates0 8 = .ok (some ⟨winner,upper,8⟩) := stepEvaluation.trans (by rfl)
end SFT.Physics.NuclearBindingSeparation8
