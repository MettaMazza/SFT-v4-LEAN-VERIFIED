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
namespace SFT.Physics.NuclearBindingScoreClosure4
open NuclearBindingPeak NuclearBindingScoreComposition NuclearBindingGatherClosure
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def scores63 := NuclearBindingScoresBatch63.scores4
theorem complete63 : scoreCandidates 4 candidates63 = .ok scores63 := NuclearBindingScoresBatch63.evaluated4
def scores62 := NuclearBindingScoresBatch62.scores4 ++ scores63
theorem complete62 : scoreCandidates 4 candidates62 = .ok scores62 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch62.evaluated4 complete63
def scores61 := NuclearBindingScoresBatch61.scores4 ++ scores62
theorem complete61 : scoreCandidates 4 candidates61 = .ok scores61 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch61.evaluated4 complete62
def scores60 := NuclearBindingScoresBatch60.scores4 ++ scores61
theorem complete60 : scoreCandidates 4 candidates60 = .ok scores60 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch60.evaluated4 complete61
def scores59 := NuclearBindingScoresBatch59.scores4 ++ scores60
theorem complete59 : scoreCandidates 4 candidates59 = .ok scores59 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch59.evaluated4 complete60
def scores58 := NuclearBindingScoresBatch58.scores4 ++ scores59
theorem complete58 : scoreCandidates 4 candidates58 = .ok scores58 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch58.evaluated4 complete59
def scores57 := NuclearBindingScoresBatch57.scores4 ++ scores58
theorem complete57 : scoreCandidates 4 candidates57 = .ok scores57 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch57.evaluated4 complete58
def scores56 := NuclearBindingScoresBatch56.scores4 ++ scores57
theorem complete56 : scoreCandidates 4 candidates56 = .ok scores56 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch56.evaluated4 complete57
def scores55 := NuclearBindingScoresBatch55.scores4 ++ scores56
theorem complete55 : scoreCandidates 4 candidates55 = .ok scores55 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch55.evaluated4 complete56
def scores54 := NuclearBindingScoresBatch54.scores4 ++ scores55
theorem complete54 : scoreCandidates 4 candidates54 = .ok scores54 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch54.evaluated4 complete55
def scores53 := NuclearBindingScoresBatch53.scores4 ++ scores54
theorem complete53 : scoreCandidates 4 candidates53 = .ok scores53 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch53.evaluated4 complete54
def scores52 := NuclearBindingScoresBatch52.scores4 ++ scores53
theorem complete52 : scoreCandidates 4 candidates52 = .ok scores52 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch52.evaluated4 complete53
def scores51 := NuclearBindingScoresBatch51.scores4 ++ scores52
theorem complete51 : scoreCandidates 4 candidates51 = .ok scores51 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch51.evaluated4 complete52
def scores50 := NuclearBindingScoresBatch50.scores4 ++ scores51
theorem complete50 : scoreCandidates 4 candidates50 = .ok scores50 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch50.evaluated4 complete51
def scores49 := NuclearBindingScoresBatch49.scores4 ++ scores50
theorem complete49 : scoreCandidates 4 candidates49 = .ok scores49 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch49.evaluated4 complete50
def scores48 := NuclearBindingScoresBatch48.scores4 ++ scores49
theorem complete48 : scoreCandidates 4 candidates48 = .ok scores48 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch48.evaluated4 complete49
def scores47 := NuclearBindingScoresBatch47.scores4 ++ scores48
theorem complete47 : scoreCandidates 4 candidates47 = .ok scores47 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch47.evaluated4 complete48
def scores46 := NuclearBindingScoresBatch46.scores4 ++ scores47
theorem complete46 : scoreCandidates 4 candidates46 = .ok scores46 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch46.evaluated4 complete47
def scores45 := NuclearBindingScoresBatch45.scores4 ++ scores46
theorem complete45 : scoreCandidates 4 candidates45 = .ok scores45 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch45.evaluated4 complete46
def scores44 := NuclearBindingScoresBatch44.scores4 ++ scores45
theorem complete44 : scoreCandidates 4 candidates44 = .ok scores44 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch44.evaluated4 complete45
def scores43 := NuclearBindingScoresBatch43.scores4 ++ scores44
theorem complete43 : scoreCandidates 4 candidates43 = .ok scores43 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch43.evaluated4 complete44
def scores42 := NuclearBindingScoresBatch42.scores4 ++ scores43
theorem complete42 : scoreCandidates 4 candidates42 = .ok scores42 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch42.evaluated4 complete43
def scores41 := NuclearBindingScoresBatch41.scores4 ++ scores42
theorem complete41 : scoreCandidates 4 candidates41 = .ok scores41 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch41.evaluated4 complete42
def scores40 := NuclearBindingScoresBatch40.scores4 ++ scores41
theorem complete40 : scoreCandidates 4 candidates40 = .ok scores40 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch40.evaluated4 complete41
def scores39 := NuclearBindingScoresBatch39.scores4 ++ scores40
theorem complete39 : scoreCandidates 4 candidates39 = .ok scores39 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch39.evaluated4 complete40
def scores38 := NuclearBindingScoresBatch38.scores4 ++ scores39
theorem complete38 : scoreCandidates 4 candidates38 = .ok scores38 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch38.evaluated4 complete39
def scores37 := NuclearBindingScoresBatch37.scores4 ++ scores38
theorem complete37 : scoreCandidates 4 candidates37 = .ok scores37 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch37.evaluated4 complete38
def scores36 := NuclearBindingScoresBatch36.scores4 ++ scores37
theorem complete36 : scoreCandidates 4 candidates36 = .ok scores36 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch36.evaluated4 complete37
def scores35 := NuclearBindingScoresBatch35.scores4 ++ scores36
theorem complete35 : scoreCandidates 4 candidates35 = .ok scores35 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch35.evaluated4 complete36
def scores34 := NuclearBindingScoresBatch34.scores4 ++ scores35
theorem complete34 : scoreCandidates 4 candidates34 = .ok scores34 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch34.evaluated4 complete35
def scores33 := NuclearBindingScoresBatch33.scores4 ++ scores34
theorem complete33 : scoreCandidates 4 candidates33 = .ok scores33 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch33.evaluated4 complete34
def scores32 := NuclearBindingScoresBatch32.scores4 ++ scores33
theorem complete32 : scoreCandidates 4 candidates32 = .ok scores32 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch32.evaluated4 complete33
def scores31 := NuclearBindingScoresBatch31.scores4 ++ scores32
theorem complete31 : scoreCandidates 4 candidates31 = .ok scores31 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch31.evaluated4 complete32
def scores30 := NuclearBindingScoresBatch30.scores4 ++ scores31
theorem complete30 : scoreCandidates 4 candidates30 = .ok scores30 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch30.evaluated4 complete31
def scores29 := NuclearBindingScoresBatch29.scores4 ++ scores30
theorem complete29 : scoreCandidates 4 candidates29 = .ok scores29 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch29.evaluated4 complete30
def scores28 := NuclearBindingScoresBatch28.scores4 ++ scores29
theorem complete28 : scoreCandidates 4 candidates28 = .ok scores28 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch28.evaluated4 complete29
def scores27 := NuclearBindingScoresBatch27.scores4 ++ scores28
theorem complete27 : scoreCandidates 4 candidates27 = .ok scores27 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch27.evaluated4 complete28
def scores26 := NuclearBindingScoresBatch26.scores4 ++ scores27
theorem complete26 : scoreCandidates 4 candidates26 = .ok scores26 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch26.evaluated4 complete27
def scores25 := NuclearBindingScoresBatch25.scores4 ++ scores26
theorem complete25 : scoreCandidates 4 candidates25 = .ok scores25 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch25.evaluated4 complete26
def scores24 := NuclearBindingScoresBatch24.scores4 ++ scores25
theorem complete24 : scoreCandidates 4 candidates24 = .ok scores24 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch24.evaluated4 complete25
def scores23 := NuclearBindingScoresBatch23.scores4 ++ scores24
theorem complete23 : scoreCandidates 4 candidates23 = .ok scores23 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch23.evaluated4 complete24
def scores22 := NuclearBindingScoresBatch22.scores4 ++ scores23
theorem complete22 : scoreCandidates 4 candidates22 = .ok scores22 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch22.evaluated4 complete23
def scores21 := NuclearBindingScoresBatch21.scores4 ++ scores22
theorem complete21 : scoreCandidates 4 candidates21 = .ok scores21 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch21.evaluated4 complete22
def scores20 := NuclearBindingScoresBatch20.scores4 ++ scores21
theorem complete20 : scoreCandidates 4 candidates20 = .ok scores20 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch20.evaluated4 complete21
def scores19 := NuclearBindingScoresBatch19.scores4 ++ scores20
theorem complete19 : scoreCandidates 4 candidates19 = .ok scores19 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch19.evaluated4 complete20
def scores18 := NuclearBindingScoresBatch18.scores4 ++ scores19
theorem complete18 : scoreCandidates 4 candidates18 = .ok scores18 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch18.evaluated4 complete19
def scores17 := NuclearBindingScoresBatch17.scores4 ++ scores18
theorem complete17 : scoreCandidates 4 candidates17 = .ok scores17 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch17.evaluated4 complete18
def scores16 := NuclearBindingScoresBatch16.scores4 ++ scores17
theorem complete16 : scoreCandidates 4 candidates16 = .ok scores16 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch16.evaluated4 complete17
def scores15 := NuclearBindingScoresBatch15.scores4 ++ scores16
theorem complete15 : scoreCandidates 4 candidates15 = .ok scores15 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch15.evaluated4 complete16
def scores14 := NuclearBindingScoresBatch14.scores4 ++ scores15
theorem complete14 : scoreCandidates 4 candidates14 = .ok scores14 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch14.evaluated4 complete15
def scores13 := NuclearBindingScoresBatch13.scores4 ++ scores14
theorem complete13 : scoreCandidates 4 candidates13 = .ok scores13 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch13.evaluated4 complete14
def scores12 := NuclearBindingScoresBatch12.scores4 ++ scores13
theorem complete12 : scoreCandidates 4 candidates12 = .ok scores12 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch12.evaluated4 complete13
def scores11 := NuclearBindingScoresBatch11.scores4 ++ scores12
theorem complete11 : scoreCandidates 4 candidates11 = .ok scores11 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch11.evaluated4 complete12
def scores10 := NuclearBindingScoresBatch10.scores4 ++ scores11
theorem complete10 : scoreCandidates 4 candidates10 = .ok scores10 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch10.evaluated4 complete11
def scores9 := NuclearBindingScoresBatch09.scores4 ++ scores10
theorem complete9 : scoreCandidates 4 candidates9 = .ok scores9 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch09.evaluated4 complete10
def scores8 := NuclearBindingScoresBatch08.scores4 ++ scores9
theorem complete8 : scoreCandidates 4 candidates8 = .ok scores8 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch08.evaluated4 complete9
def scores7 := NuclearBindingScoresBatch07.scores4 ++ scores8
theorem complete7 : scoreCandidates 4 candidates7 = .ok scores7 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch07.evaluated4 complete8
def scores6 := NuclearBindingScoresBatch06.scores4 ++ scores7
theorem complete6 : scoreCandidates 4 candidates6 = .ok scores6 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch06.evaluated4 complete7
def scores5 := NuclearBindingScoresBatch05.scores4 ++ scores6
theorem complete5 : scoreCandidates 4 candidates5 = .ok scores5 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch05.evaluated4 complete6
def scores4 := NuclearBindingScoresBatch04.scores4 ++ scores5
theorem complete4 : scoreCandidates 4 candidates4 = .ok scores4 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch04.evaluated4 complete5
def scores3 := NuclearBindingScoresBatch03.scores4 ++ scores4
theorem complete3 : scoreCandidates 4 candidates3 = .ok scores3 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch03.evaluated4 complete4
def scores2 := NuclearBindingScoresBatch02.scores4 ++ scores3
theorem complete2 : scoreCandidates 4 candidates2 = .ok scores2 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch02.evaluated4 complete3
def scores1 := NuclearBindingScoresBatch01.scores4 ++ scores2
theorem complete1 : scoreCandidates 4 candidates1 = .ok scores1 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch01.evaluated4 complete2
def scores0 := NuclearBindingScoresBatch00.scores4 ++ scores1
theorem complete0 : scoreCandidates 4 candidates0 = .ok scores0 := scoreAppend 4 _ _ _ _ NuclearBindingScoresBatch00.evaluated4 complete1
end SFT.Physics.NuclearBindingScoreClosure4
