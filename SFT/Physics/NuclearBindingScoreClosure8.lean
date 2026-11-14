import SFT.Physics.NuclearBindingScoresBatch00
import SFT.Physics.NuclearBindingScoresBatch01
import SFT.Physics.NuclearBindingScoresBatch02
import SFT.Physics.NuclearBindingScoresBatch03
import SFT.Physics.NuclearBindingScoresBatch04
import SFT.Physics.NuclearBindingScoresBatch05
import SFT.Physics.NuclearBindingScoresBatch06
import SFT.Physics.NuclearBindingScoresBatch07
import SFT.Physics.NuclearBindingScoresBatch08
import SFT.Physics.NuclearBindingScoresBatch09
import SFT.Physics.NuclearBindingScoresBatch10
import SFT.Physics.NuclearBindingScoresBatch11
import SFT.Physics.NuclearBindingScoresBatch12
import SFT.Physics.NuclearBindingScoresBatch13
import SFT.Physics.NuclearBindingScoresBatch14
import SFT.Physics.NuclearBindingScoresBatch15
import SFT.Physics.NuclearBindingScoresBatch16
import SFT.Physics.NuclearBindingScoresBatch17
import SFT.Physics.NuclearBindingScoresBatch18
import SFT.Physics.NuclearBindingScoresBatch19
import SFT.Physics.NuclearBindingScoresBatch20
import SFT.Physics.NuclearBindingScoresBatch21
import SFT.Physics.NuclearBindingScoresBatch22
import SFT.Physics.NuclearBindingScoresBatch23
import SFT.Physics.NuclearBindingScoresBatch24
import SFT.Physics.NuclearBindingScoresBatch25
import SFT.Physics.NuclearBindingScoresBatch26
import SFT.Physics.NuclearBindingScoresBatch27
import SFT.Physics.NuclearBindingScoresBatch28
import SFT.Physics.NuclearBindingScoresBatch29
import SFT.Physics.NuclearBindingScoresBatch30
import SFT.Physics.NuclearBindingScoresBatch31
import SFT.Physics.NuclearBindingScoresBatch32
import SFT.Physics.NuclearBindingScoresBatch33
import SFT.Physics.NuclearBindingScoresBatch34
import SFT.Physics.NuclearBindingScoresBatch35
import SFT.Physics.NuclearBindingScoresBatch36
import SFT.Physics.NuclearBindingScoresBatch37
import SFT.Physics.NuclearBindingScoresBatch38
import SFT.Physics.NuclearBindingScoresBatch39
import SFT.Physics.NuclearBindingScoresBatch40
import SFT.Physics.NuclearBindingScoresBatch41
import SFT.Physics.NuclearBindingScoresBatch42
import SFT.Physics.NuclearBindingScoresBatch43
import SFT.Physics.NuclearBindingScoresBatch44
import SFT.Physics.NuclearBindingScoresBatch45
import SFT.Physics.NuclearBindingScoresBatch46
import SFT.Physics.NuclearBindingScoresBatch47
import SFT.Physics.NuclearBindingScoresBatch48
import SFT.Physics.NuclearBindingScoresBatch49
import SFT.Physics.NuclearBindingScoresBatch50
import SFT.Physics.NuclearBindingScoresBatch51
import SFT.Physics.NuclearBindingScoresBatch52
import SFT.Physics.NuclearBindingScoresBatch53
import SFT.Physics.NuclearBindingScoresBatch54
import SFT.Physics.NuclearBindingScoresBatch55
import SFT.Physics.NuclearBindingScoresBatch56
import SFT.Physics.NuclearBindingScoresBatch57
import SFT.Physics.NuclearBindingScoresBatch58
import SFT.Physics.NuclearBindingScoresBatch59
import SFT.Physics.NuclearBindingScoresBatch60
import SFT.Physics.NuclearBindingScoresBatch61
import SFT.Physics.NuclearBindingScoresBatch62
import SFT.Physics.NuclearBindingScoresBatch63
import SFT.Physics.NuclearBindingGatherClosure
import SFT.Physics.NuclearBindingScoreComposition
namespace SFT.Physics.NuclearBindingScoreClosure8
open NuclearBindingPeak NuclearBindingScoreComposition NuclearBindingGatherClosure
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def scores63 := NuclearBindingScoresBatch63.scores8
theorem complete63 : scoreCandidates 8 candidates63 = .ok scores63 := NuclearBindingScoresBatch63.evaluated8
def scores62 := NuclearBindingScoresBatch62.scores8 ++ scores63
theorem complete62 : scoreCandidates 8 candidates62 = .ok scores62 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch62.evaluated8 complete63
def scores61 := NuclearBindingScoresBatch61.scores8 ++ scores62
theorem complete61 : scoreCandidates 8 candidates61 = .ok scores61 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch61.evaluated8 complete62
def scores60 := NuclearBindingScoresBatch60.scores8 ++ scores61
theorem complete60 : scoreCandidates 8 candidates60 = .ok scores60 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch60.evaluated8 complete61
def scores59 := NuclearBindingScoresBatch59.scores8 ++ scores60
theorem complete59 : scoreCandidates 8 candidates59 = .ok scores59 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch59.evaluated8 complete60
def scores58 := NuclearBindingScoresBatch58.scores8 ++ scores59
theorem complete58 : scoreCandidates 8 candidates58 = .ok scores58 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch58.evaluated8 complete59
def scores57 := NuclearBindingScoresBatch57.scores8 ++ scores58
theorem complete57 : scoreCandidates 8 candidates57 = .ok scores57 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch57.evaluated8 complete58
def scores56 := NuclearBindingScoresBatch56.scores8 ++ scores57
theorem complete56 : scoreCandidates 8 candidates56 = .ok scores56 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch56.evaluated8 complete57
def scores55 := NuclearBindingScoresBatch55.scores8 ++ scores56
theorem complete55 : scoreCandidates 8 candidates55 = .ok scores55 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch55.evaluated8 complete56
def scores54 := NuclearBindingScoresBatch54.scores8 ++ scores55
theorem complete54 : scoreCandidates 8 candidates54 = .ok scores54 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch54.evaluated8 complete55
def scores53 := NuclearBindingScoresBatch53.scores8 ++ scores54
theorem complete53 : scoreCandidates 8 candidates53 = .ok scores53 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch53.evaluated8 complete54
def scores52 := NuclearBindingScoresBatch52.scores8 ++ scores53
theorem complete52 : scoreCandidates 8 candidates52 = .ok scores52 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch52.evaluated8 complete53
def scores51 := NuclearBindingScoresBatch51.scores8 ++ scores52
theorem complete51 : scoreCandidates 8 candidates51 = .ok scores51 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch51.evaluated8 complete52
def scores50 := NuclearBindingScoresBatch50.scores8 ++ scores51
theorem complete50 : scoreCandidates 8 candidates50 = .ok scores50 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch50.evaluated8 complete51
def scores49 := NuclearBindingScoresBatch49.scores8 ++ scores50
theorem complete49 : scoreCandidates 8 candidates49 = .ok scores49 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch49.evaluated8 complete50
def scores48 := NuclearBindingScoresBatch48.scores8 ++ scores49
theorem complete48 : scoreCandidates 8 candidates48 = .ok scores48 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch48.evaluated8 complete49
def scores47 := NuclearBindingScoresBatch47.scores8 ++ scores48
theorem complete47 : scoreCandidates 8 candidates47 = .ok scores47 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch47.evaluated8 complete48
def scores46 := NuclearBindingScoresBatch46.scores8 ++ scores47
theorem complete46 : scoreCandidates 8 candidates46 = .ok scores46 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch46.evaluated8 complete47
def scores45 := NuclearBindingScoresBatch45.scores8 ++ scores46
theorem complete45 : scoreCandidates 8 candidates45 = .ok scores45 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch45.evaluated8 complete46
def scores44 := NuclearBindingScoresBatch44.scores8 ++ scores45
theorem complete44 : scoreCandidates 8 candidates44 = .ok scores44 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch44.evaluated8 complete45
def scores43 := NuclearBindingScoresBatch43.scores8 ++ scores44
theorem complete43 : scoreCandidates 8 candidates43 = .ok scores43 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch43.evaluated8 complete44
def scores42 := NuclearBindingScoresBatch42.scores8 ++ scores43
theorem complete42 : scoreCandidates 8 candidates42 = .ok scores42 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch42.evaluated8 complete43
def scores41 := NuclearBindingScoresBatch41.scores8 ++ scores42
theorem complete41 : scoreCandidates 8 candidates41 = .ok scores41 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch41.evaluated8 complete42
def scores40 := NuclearBindingScoresBatch40.scores8 ++ scores41
theorem complete40 : scoreCandidates 8 candidates40 = .ok scores40 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch40.evaluated8 complete41
def scores39 := NuclearBindingScoresBatch39.scores8 ++ scores40
theorem complete39 : scoreCandidates 8 candidates39 = .ok scores39 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch39.evaluated8 complete40
def scores38 := NuclearBindingScoresBatch38.scores8 ++ scores39
theorem complete38 : scoreCandidates 8 candidates38 = .ok scores38 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch38.evaluated8 complete39
def scores37 := NuclearBindingScoresBatch37.scores8 ++ scores38
theorem complete37 : scoreCandidates 8 candidates37 = .ok scores37 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch37.evaluated8 complete38
def scores36 := NuclearBindingScoresBatch36.scores8 ++ scores37
theorem complete36 : scoreCandidates 8 candidates36 = .ok scores36 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch36.evaluated8 complete37
def scores35 := NuclearBindingScoresBatch35.scores8 ++ scores36
theorem complete35 : scoreCandidates 8 candidates35 = .ok scores35 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch35.evaluated8 complete36
def scores34 := NuclearBindingScoresBatch34.scores8 ++ scores35
theorem complete34 : scoreCandidates 8 candidates34 = .ok scores34 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch34.evaluated8 complete35
def scores33 := NuclearBindingScoresBatch33.scores8 ++ scores34
theorem complete33 : scoreCandidates 8 candidates33 = .ok scores33 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch33.evaluated8 complete34
def scores32 := NuclearBindingScoresBatch32.scores8 ++ scores33
theorem complete32 : scoreCandidates 8 candidates32 = .ok scores32 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch32.evaluated8 complete33
def scores31 := NuclearBindingScoresBatch31.scores8 ++ scores32
theorem complete31 : scoreCandidates 8 candidates31 = .ok scores31 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch31.evaluated8 complete32
def scores30 := NuclearBindingScoresBatch30.scores8 ++ scores31
theorem complete30 : scoreCandidates 8 candidates30 = .ok scores30 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch30.evaluated8 complete31
def scores29 := NuclearBindingScoresBatch29.scores8 ++ scores30
theorem complete29 : scoreCandidates 8 candidates29 = .ok scores29 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch29.evaluated8 complete30
def scores28 := NuclearBindingScoresBatch28.scores8 ++ scores29
theorem complete28 : scoreCandidates 8 candidates28 = .ok scores28 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch28.evaluated8 complete29
def scores27 := NuclearBindingScoresBatch27.scores8 ++ scores28
theorem complete27 : scoreCandidates 8 candidates27 = .ok scores27 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch27.evaluated8 complete28
def scores26 := NuclearBindingScoresBatch26.scores8 ++ scores27
theorem complete26 : scoreCandidates 8 candidates26 = .ok scores26 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch26.evaluated8 complete27
def scores25 := NuclearBindingScoresBatch25.scores8 ++ scores26
theorem complete25 : scoreCandidates 8 candidates25 = .ok scores25 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch25.evaluated8 complete26
def scores24 := NuclearBindingScoresBatch24.scores8 ++ scores25
theorem complete24 : scoreCandidates 8 candidates24 = .ok scores24 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch24.evaluated8 complete25
def scores23 := NuclearBindingScoresBatch23.scores8 ++ scores24
theorem complete23 : scoreCandidates 8 candidates23 = .ok scores23 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch23.evaluated8 complete24
def scores22 := NuclearBindingScoresBatch22.scores8 ++ scores23
theorem complete22 : scoreCandidates 8 candidates22 = .ok scores22 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch22.evaluated8 complete23
def scores21 := NuclearBindingScoresBatch21.scores8 ++ scores22
theorem complete21 : scoreCandidates 8 candidates21 = .ok scores21 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch21.evaluated8 complete22
def scores20 := NuclearBindingScoresBatch20.scores8 ++ scores21
theorem complete20 : scoreCandidates 8 candidates20 = .ok scores20 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch20.evaluated8 complete21
def scores19 := NuclearBindingScoresBatch19.scores8 ++ scores20
theorem complete19 : scoreCandidates 8 candidates19 = .ok scores19 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch19.evaluated8 complete20
def scores18 := NuclearBindingScoresBatch18.scores8 ++ scores19
theorem complete18 : scoreCandidates 8 candidates18 = .ok scores18 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch18.evaluated8 complete19
def scores17 := NuclearBindingScoresBatch17.scores8 ++ scores18
theorem complete17 : scoreCandidates 8 candidates17 = .ok scores17 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch17.evaluated8 complete18
def scores16 := NuclearBindingScoresBatch16.scores8 ++ scores17
theorem complete16 : scoreCandidates 8 candidates16 = .ok scores16 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch16.evaluated8 complete17
def scores15 := NuclearBindingScoresBatch15.scores8 ++ scores16
theorem complete15 : scoreCandidates 8 candidates15 = .ok scores15 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch15.evaluated8 complete16
def scores14 := NuclearBindingScoresBatch14.scores8 ++ scores15
theorem complete14 : scoreCandidates 8 candidates14 = .ok scores14 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch14.evaluated8 complete15
def scores13 := NuclearBindingScoresBatch13.scores8 ++ scores14
theorem complete13 : scoreCandidates 8 candidates13 = .ok scores13 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch13.evaluated8 complete14
def scores12 := NuclearBindingScoresBatch12.scores8 ++ scores13
theorem complete12 : scoreCandidates 8 candidates12 = .ok scores12 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch12.evaluated8 complete13
def scores11 := NuclearBindingScoresBatch11.scores8 ++ scores12
theorem complete11 : scoreCandidates 8 candidates11 = .ok scores11 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch11.evaluated8 complete12
def scores10 := NuclearBindingScoresBatch10.scores8 ++ scores11
theorem complete10 : scoreCandidates 8 candidates10 = .ok scores10 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch10.evaluated8 complete11
def scores9 := NuclearBindingScoresBatch09.scores8 ++ scores10
theorem complete9 : scoreCandidates 8 candidates9 = .ok scores9 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch09.evaluated8 complete10
def scores8 := NuclearBindingScoresBatch08.scores8 ++ scores9
theorem complete8 : scoreCandidates 8 candidates8 = .ok scores8 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch08.evaluated8 complete9
def scores7 := NuclearBindingScoresBatch07.scores8 ++ scores8
theorem complete7 : scoreCandidates 8 candidates7 = .ok scores7 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch07.evaluated8 complete8
def scores6 := NuclearBindingScoresBatch06.scores8 ++ scores7
theorem complete6 : scoreCandidates 8 candidates6 = .ok scores6 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch06.evaluated8 complete7
def scores5 := NuclearBindingScoresBatch05.scores8 ++ scores6
theorem complete5 : scoreCandidates 8 candidates5 = .ok scores5 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch05.evaluated8 complete6
def scores4 := NuclearBindingScoresBatch04.scores8 ++ scores5
theorem complete4 : scoreCandidates 8 candidates4 = .ok scores4 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch04.evaluated8 complete5
def scores3 := NuclearBindingScoresBatch03.scores8 ++ scores4
theorem complete3 : scoreCandidates 8 candidates3 = .ok scores3 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch03.evaluated8 complete4
def scores2 := NuclearBindingScoresBatch02.scores8 ++ scores3
theorem complete2 : scoreCandidates 8 candidates2 = .ok scores2 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch02.evaluated8 complete3
def scores1 := NuclearBindingScoresBatch01.scores8 ++ scores2
theorem complete1 : scoreCandidates 8 candidates1 = .ok scores1 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch01.evaluated8 complete2
def scores0 := NuclearBindingScoresBatch00.scores8 ++ scores1
theorem complete0 : scoreCandidates 8 candidates0 = .ok scores0 := scoreAppend 8 _ _ _ _ NuclearBindingScoresBatch00.evaluated8 complete1
end SFT.Physics.NuclearBindingScoreClosure8
