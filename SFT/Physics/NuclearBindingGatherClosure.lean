import SFT.Physics.NuclearBindingRangeComposition
import SFT.Physics.NuclearBindingGatherBatch00
import SFT.Physics.NuclearBindingGatherBatch01
import SFT.Physics.NuclearBindingGatherBatch02
import SFT.Physics.NuclearBindingGatherBatch03
import SFT.Physics.NuclearBindingGatherBatch04
import SFT.Physics.NuclearBindingGatherBatch05
import SFT.Physics.NuclearBindingGatherBatch06
import SFT.Physics.NuclearBindingGatherBatch07
import SFT.Physics.NuclearBindingGatherBatch08
import SFT.Physics.NuclearBindingGatherBatch09
import SFT.Physics.NuclearBindingGatherBatch10
import SFT.Physics.NuclearBindingGatherBatch11
import SFT.Physics.NuclearBindingGatherBatch12
import SFT.Physics.NuclearBindingGatherBatch13
import SFT.Physics.NuclearBindingGatherBatch14
import SFT.Physics.NuclearBindingGatherBatch15
import SFT.Physics.NuclearBindingGatherBatch16
import SFT.Physics.NuclearBindingGatherBatch17
import SFT.Physics.NuclearBindingGatherBatch18
import SFT.Physics.NuclearBindingGatherBatch19
import SFT.Physics.NuclearBindingGatherBatch20
import SFT.Physics.NuclearBindingGatherBatch21
import SFT.Physics.NuclearBindingGatherBatch22
import SFT.Physics.NuclearBindingGatherBatch23
import SFT.Physics.NuclearBindingGatherBatch24
import SFT.Physics.NuclearBindingGatherBatch25
import SFT.Physics.NuclearBindingGatherBatch26
import SFT.Physics.NuclearBindingGatherBatch27
import SFT.Physics.NuclearBindingGatherBatch28
import SFT.Physics.NuclearBindingGatherBatch29
import SFT.Physics.NuclearBindingGatherBatch30
import SFT.Physics.NuclearBindingGatherBatch31
import SFT.Physics.NuclearBindingGatherBatch32
import SFT.Physics.NuclearBindingGatherBatch33
import SFT.Physics.NuclearBindingGatherBatch34
import SFT.Physics.NuclearBindingGatherBatch35
import SFT.Physics.NuclearBindingGatherBatch36
import SFT.Physics.NuclearBindingGatherBatch37
import SFT.Physics.NuclearBindingGatherBatch38
import SFT.Physics.NuclearBindingGatherBatch39
import SFT.Physics.NuclearBindingGatherBatch40
import SFT.Physics.NuclearBindingGatherBatch41
import SFT.Physics.NuclearBindingGatherBatch42
import SFT.Physics.NuclearBindingGatherBatch43
import SFT.Physics.NuclearBindingGatherBatch44
import SFT.Physics.NuclearBindingGatherBatch45
import SFT.Physics.NuclearBindingGatherBatch46
import SFT.Physics.NuclearBindingGatherBatch47
import SFT.Physics.NuclearBindingGatherBatch48
import SFT.Physics.NuclearBindingGatherBatch49
import SFT.Physics.NuclearBindingGatherBatch50
import SFT.Physics.NuclearBindingGatherBatch51
import SFT.Physics.NuclearBindingGatherBatch52
import SFT.Physics.NuclearBindingGatherBatch53
import SFT.Physics.NuclearBindingGatherBatch54
import SFT.Physics.NuclearBindingGatherBatch55
import SFT.Physics.NuclearBindingGatherBatch56
import SFT.Physics.NuclearBindingGatherBatch57
import SFT.Physics.NuclearBindingGatherBatch58
import SFT.Physics.NuclearBindingGatherBatch59
import SFT.Physics.NuclearBindingGatherBatch60
import SFT.Physics.NuclearBindingGatherBatch61
import SFT.Physics.NuclearBindingGatherBatch62
import SFT.Physics.NuclearBindingGatherBatch63
namespace SFT.Physics.NuclearBindingGatherClosure
open NuclearBindingCensus NuclearBindingGatherProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def masses63 := NuclearBindingGatherBatch63.masses
def candidates63 := NuclearBindingGatherBatch63.candidates
theorem complete63 : gather 7 masses63 = .ok (some candidates63) := NuclearBindingGatherBatch63.complete
def masses62 := NuclearBindingGatherBatch62.masses ++ masses63
def candidates62 := NuclearBindingGatherBatch62.candidates ++ candidates63
theorem complete62 : gather 7 masses62 = .ok (some candidates62) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch62.complete complete63
def masses61 := NuclearBindingGatherBatch61.masses ++ masses62
def candidates61 := NuclearBindingGatherBatch61.candidates ++ candidates62
theorem complete61 : gather 7 masses61 = .ok (some candidates61) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch61.complete complete62
def masses60 := NuclearBindingGatherBatch60.masses ++ masses61
def candidates60 := NuclearBindingGatherBatch60.candidates ++ candidates61
theorem complete60 : gather 7 masses60 = .ok (some candidates60) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch60.complete complete61
def masses59 := NuclearBindingGatherBatch59.masses ++ masses60
def candidates59 := NuclearBindingGatherBatch59.candidates ++ candidates60
theorem complete59 : gather 7 masses59 = .ok (some candidates59) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch59.complete complete60
def masses58 := NuclearBindingGatherBatch58.masses ++ masses59
def candidates58 := NuclearBindingGatherBatch58.candidates ++ candidates59
theorem complete58 : gather 7 masses58 = .ok (some candidates58) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch58.complete complete59
def masses57 := NuclearBindingGatherBatch57.masses ++ masses58
def candidates57 := NuclearBindingGatherBatch57.candidates ++ candidates58
theorem complete57 : gather 7 masses57 = .ok (some candidates57) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch57.complete complete58
def masses56 := NuclearBindingGatherBatch56.masses ++ masses57
def candidates56 := NuclearBindingGatherBatch56.candidates ++ candidates57
theorem complete56 : gather 7 masses56 = .ok (some candidates56) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch56.complete complete57
def masses55 := NuclearBindingGatherBatch55.masses ++ masses56
def candidates55 := NuclearBindingGatherBatch55.candidates ++ candidates56
theorem complete55 : gather 7 masses55 = .ok (some candidates55) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch55.complete complete56
def masses54 := NuclearBindingGatherBatch54.masses ++ masses55
def candidates54 := NuclearBindingGatherBatch54.candidates ++ candidates55
theorem complete54 : gather 7 masses54 = .ok (some candidates54) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch54.complete complete55
def masses53 := NuclearBindingGatherBatch53.masses ++ masses54
def candidates53 := NuclearBindingGatherBatch53.candidates ++ candidates54
theorem complete53 : gather 7 masses53 = .ok (some candidates53) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch53.complete complete54
def masses52 := NuclearBindingGatherBatch52.masses ++ masses53
def candidates52 := NuclearBindingGatherBatch52.candidates ++ candidates53
theorem complete52 : gather 7 masses52 = .ok (some candidates52) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch52.complete complete53
def masses51 := NuclearBindingGatherBatch51.masses ++ masses52
def candidates51 := NuclearBindingGatherBatch51.candidates ++ candidates52
theorem complete51 : gather 7 masses51 = .ok (some candidates51) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch51.complete complete52
def masses50 := NuclearBindingGatherBatch50.masses ++ masses51
def candidates50 := NuclearBindingGatherBatch50.candidates ++ candidates51
theorem complete50 : gather 7 masses50 = .ok (some candidates50) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch50.complete complete51
def masses49 := NuclearBindingGatherBatch49.masses ++ masses50
def candidates49 := NuclearBindingGatherBatch49.candidates ++ candidates50
theorem complete49 : gather 7 masses49 = .ok (some candidates49) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch49.complete complete50
def masses48 := NuclearBindingGatherBatch48.masses ++ masses49
def candidates48 := NuclearBindingGatherBatch48.candidates ++ candidates49
theorem complete48 : gather 7 masses48 = .ok (some candidates48) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch48.complete complete49
def masses47 := NuclearBindingGatherBatch47.masses ++ masses48
def candidates47 := NuclearBindingGatherBatch47.candidates ++ candidates48
theorem complete47 : gather 7 masses47 = .ok (some candidates47) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch47.complete complete48
def masses46 := NuclearBindingGatherBatch46.masses ++ masses47
def candidates46 := NuclearBindingGatherBatch46.candidates ++ candidates47
theorem complete46 : gather 7 masses46 = .ok (some candidates46) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch46.complete complete47
def masses45 := NuclearBindingGatherBatch45.masses ++ masses46
def candidates45 := NuclearBindingGatherBatch45.candidates ++ candidates46
theorem complete45 : gather 7 masses45 = .ok (some candidates45) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch45.complete complete46
def masses44 := NuclearBindingGatherBatch44.masses ++ masses45
def candidates44 := NuclearBindingGatherBatch44.candidates ++ candidates45
theorem complete44 : gather 7 masses44 = .ok (some candidates44) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch44.complete complete45
def masses43 := NuclearBindingGatherBatch43.masses ++ masses44
def candidates43 := NuclearBindingGatherBatch43.candidates ++ candidates44
theorem complete43 : gather 7 masses43 = .ok (some candidates43) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch43.complete complete44
def masses42 := NuclearBindingGatherBatch42.masses ++ masses43
def candidates42 := NuclearBindingGatherBatch42.candidates ++ candidates43
theorem complete42 : gather 7 masses42 = .ok (some candidates42) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch42.complete complete43
def masses41 := NuclearBindingGatherBatch41.masses ++ masses42
def candidates41 := NuclearBindingGatherBatch41.candidates ++ candidates42
theorem complete41 : gather 7 masses41 = .ok (some candidates41) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch41.complete complete42
def masses40 := NuclearBindingGatherBatch40.masses ++ masses41
def candidates40 := NuclearBindingGatherBatch40.candidates ++ candidates41
theorem complete40 : gather 7 masses40 = .ok (some candidates40) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch40.complete complete41
def masses39 := NuclearBindingGatherBatch39.masses ++ masses40
def candidates39 := NuclearBindingGatherBatch39.candidates ++ candidates40
theorem complete39 : gather 7 masses39 = .ok (some candidates39) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch39.complete complete40
def masses38 := NuclearBindingGatherBatch38.masses ++ masses39
def candidates38 := NuclearBindingGatherBatch38.candidates ++ candidates39
theorem complete38 : gather 7 masses38 = .ok (some candidates38) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch38.complete complete39
def masses37 := NuclearBindingGatherBatch37.masses ++ masses38
def candidates37 := NuclearBindingGatherBatch37.candidates ++ candidates38
theorem complete37 : gather 7 masses37 = .ok (some candidates37) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch37.complete complete38
def masses36 := NuclearBindingGatherBatch36.masses ++ masses37
def candidates36 := NuclearBindingGatherBatch36.candidates ++ candidates37
theorem complete36 : gather 7 masses36 = .ok (some candidates36) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch36.complete complete37
def masses35 := NuclearBindingGatherBatch35.masses ++ masses36
def candidates35 := NuclearBindingGatherBatch35.candidates ++ candidates36
theorem complete35 : gather 7 masses35 = .ok (some candidates35) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch35.complete complete36
def masses34 := NuclearBindingGatherBatch34.masses ++ masses35
def candidates34 := NuclearBindingGatherBatch34.candidates ++ candidates35
theorem complete34 : gather 7 masses34 = .ok (some candidates34) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch34.complete complete35
def masses33 := NuclearBindingGatherBatch33.masses ++ masses34
def candidates33 := NuclearBindingGatherBatch33.candidates ++ candidates34
theorem complete33 : gather 7 masses33 = .ok (some candidates33) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch33.complete complete34
def masses32 := NuclearBindingGatherBatch32.masses ++ masses33
def candidates32 := NuclearBindingGatherBatch32.candidates ++ candidates33
theorem complete32 : gather 7 masses32 = .ok (some candidates32) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch32.complete complete33
def masses31 := NuclearBindingGatherBatch31.masses ++ masses32
def candidates31 := NuclearBindingGatherBatch31.candidates ++ candidates32
theorem complete31 : gather 7 masses31 = .ok (some candidates31) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch31.complete complete32
def masses30 := NuclearBindingGatherBatch30.masses ++ masses31
def candidates30 := NuclearBindingGatherBatch30.candidates ++ candidates31
theorem complete30 : gather 7 masses30 = .ok (some candidates30) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch30.complete complete31
def masses29 := NuclearBindingGatherBatch29.masses ++ masses30
def candidates29 := NuclearBindingGatherBatch29.candidates ++ candidates30
theorem complete29 : gather 7 masses29 = .ok (some candidates29) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch29.complete complete30
def masses28 := NuclearBindingGatherBatch28.masses ++ masses29
def candidates28 := NuclearBindingGatherBatch28.candidates ++ candidates29
theorem complete28 : gather 7 masses28 = .ok (some candidates28) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch28.complete complete29
def masses27 := NuclearBindingGatherBatch27.masses ++ masses28
def candidates27 := NuclearBindingGatherBatch27.candidates ++ candidates28
theorem complete27 : gather 7 masses27 = .ok (some candidates27) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch27.complete complete28
def masses26 := NuclearBindingGatherBatch26.masses ++ masses27
def candidates26 := NuclearBindingGatherBatch26.candidates ++ candidates27
theorem complete26 : gather 7 masses26 = .ok (some candidates26) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch26.complete complete27
def masses25 := NuclearBindingGatherBatch25.masses ++ masses26
def candidates25 := NuclearBindingGatherBatch25.candidates ++ candidates26
theorem complete25 : gather 7 masses25 = .ok (some candidates25) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch25.complete complete26
def masses24 := NuclearBindingGatherBatch24.masses ++ masses25
def candidates24 := NuclearBindingGatherBatch24.candidates ++ candidates25
theorem complete24 : gather 7 masses24 = .ok (some candidates24) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch24.complete complete25
def masses23 := NuclearBindingGatherBatch23.masses ++ masses24
def candidates23 := NuclearBindingGatherBatch23.candidates ++ candidates24
theorem complete23 : gather 7 masses23 = .ok (some candidates23) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch23.complete complete24
def masses22 := NuclearBindingGatherBatch22.masses ++ masses23
def candidates22 := NuclearBindingGatherBatch22.candidates ++ candidates23
theorem complete22 : gather 7 masses22 = .ok (some candidates22) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch22.complete complete23
def masses21 := NuclearBindingGatherBatch21.masses ++ masses22
def candidates21 := NuclearBindingGatherBatch21.candidates ++ candidates22
theorem complete21 : gather 7 masses21 = .ok (some candidates21) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch21.complete complete22
def masses20 := NuclearBindingGatherBatch20.masses ++ masses21
def candidates20 := NuclearBindingGatherBatch20.candidates ++ candidates21
theorem complete20 : gather 7 masses20 = .ok (some candidates20) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch20.complete complete21
def masses19 := NuclearBindingGatherBatch19.masses ++ masses20
def candidates19 := NuclearBindingGatherBatch19.candidates ++ candidates20
theorem complete19 : gather 7 masses19 = .ok (some candidates19) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch19.complete complete20
def masses18 := NuclearBindingGatherBatch18.masses ++ masses19
def candidates18 := NuclearBindingGatherBatch18.candidates ++ candidates19
theorem complete18 : gather 7 masses18 = .ok (some candidates18) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch18.complete complete19
def masses17 := NuclearBindingGatherBatch17.masses ++ masses18
def candidates17 := NuclearBindingGatherBatch17.candidates ++ candidates18
theorem complete17 : gather 7 masses17 = .ok (some candidates17) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch17.complete complete18
def masses16 := NuclearBindingGatherBatch16.masses ++ masses17
def candidates16 := NuclearBindingGatherBatch16.candidates ++ candidates17
theorem complete16 : gather 7 masses16 = .ok (some candidates16) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch16.complete complete17
def masses15 := NuclearBindingGatherBatch15.masses ++ masses16
def candidates15 := NuclearBindingGatherBatch15.candidates ++ candidates16
theorem complete15 : gather 7 masses15 = .ok (some candidates15) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch15.complete complete16
def masses14 := NuclearBindingGatherBatch14.masses ++ masses15
def candidates14 := NuclearBindingGatherBatch14.candidates ++ candidates15
theorem complete14 : gather 7 masses14 = .ok (some candidates14) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch14.complete complete15
def masses13 := NuclearBindingGatherBatch13.masses ++ masses14
def candidates13 := NuclearBindingGatherBatch13.candidates ++ candidates14
theorem complete13 : gather 7 masses13 = .ok (some candidates13) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch13.complete complete14
def masses12 := NuclearBindingGatherBatch12.masses ++ masses13
def candidates12 := NuclearBindingGatherBatch12.candidates ++ candidates13
theorem complete12 : gather 7 masses12 = .ok (some candidates12) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch12.complete complete13
def masses11 := NuclearBindingGatherBatch11.masses ++ masses12
def candidates11 := NuclearBindingGatherBatch11.candidates ++ candidates12
theorem complete11 : gather 7 masses11 = .ok (some candidates11) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch11.complete complete12
def masses10 := NuclearBindingGatherBatch10.masses ++ masses11
def candidates10 := NuclearBindingGatherBatch10.candidates ++ candidates11
theorem complete10 : gather 7 masses10 = .ok (some candidates10) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch10.complete complete11
def masses9 := NuclearBindingGatherBatch09.masses ++ masses10
def candidates9 := NuclearBindingGatherBatch09.candidates ++ candidates10
theorem complete9 : gather 7 masses9 = .ok (some candidates9) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch09.complete complete10
def masses8 := NuclearBindingGatherBatch08.masses ++ masses9
def candidates8 := NuclearBindingGatherBatch08.candidates ++ candidates9
theorem complete8 : gather 7 masses8 = .ok (some candidates8) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch08.complete complete9
def masses7 := NuclearBindingGatherBatch07.masses ++ masses8
def candidates7 := NuclearBindingGatherBatch07.candidates ++ candidates8
theorem complete7 : gather 7 masses7 = .ok (some candidates7) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch07.complete complete8
def masses6 := NuclearBindingGatherBatch06.masses ++ masses7
def candidates6 := NuclearBindingGatherBatch06.candidates ++ candidates7
theorem complete6 : gather 7 masses6 = .ok (some candidates6) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch06.complete complete7
def masses5 := NuclearBindingGatherBatch05.masses ++ masses6
def candidates5 := NuclearBindingGatherBatch05.candidates ++ candidates6
theorem complete5 : gather 7 masses5 = .ok (some candidates5) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch05.complete complete6
def masses4 := NuclearBindingGatherBatch04.masses ++ masses5
def candidates4 := NuclearBindingGatherBatch04.candidates ++ candidates5
theorem complete4 : gather 7 masses4 = .ok (some candidates4) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch04.complete complete5
def masses3 := NuclearBindingGatherBatch03.masses ++ masses4
def candidates3 := NuclearBindingGatherBatch03.candidates ++ candidates4
theorem complete3 : gather 7 masses3 = .ok (some candidates3) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch03.complete complete4
def masses2 := NuclearBindingGatherBatch02.masses ++ masses3
def candidates2 := NuclearBindingGatherBatch02.candidates ++ candidates3
theorem complete2 : gather 7 masses2 = .ok (some candidates2) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch02.complete complete3
def masses1 := NuclearBindingGatherBatch01.masses ++ masses2
def candidates1 := NuclearBindingGatherBatch01.candidates ++ candidates2
theorem complete1 : gather 7 masses1 = .ok (some candidates1) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch01.complete complete2
def masses0 := NuclearBindingGatherBatch00.masses ++ masses1
def candidates0 := NuclearBindingGatherBatch00.candidates ++ candidates1
theorem complete0 : gather 7 masses0 = .ok (some candidates0) := appendGather 7 _ _ _ _ NuclearBindingGatherBatch00.complete complete1
theorem rangeBlock63 : List.range' 4034 62 = NuclearBindingGatherBatch63.masses := rfl
theorem rangeSuffix63 : List.range' 4034 62 = masses63 := rangeBlock63
theorem rangeBlock62 : List.range' 3970 64 = NuclearBindingGatherBatch62.masses := rfl
theorem rangeSuffix62 : List.range' 3970 126 = masses62 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3970 64 62
 rw [rangeBlock62,rangeSuffix63] at h
 exact h.symm
theorem rangeBlock61 : List.range' 3906 64 = NuclearBindingGatherBatch61.masses := rfl
theorem rangeSuffix61 : List.range' 3906 190 = masses61 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3906 64 126
 rw [rangeBlock61,rangeSuffix62] at h
 exact h.symm
theorem rangeBlock60 : List.range' 3842 64 = NuclearBindingGatherBatch60.masses := rfl
theorem rangeSuffix60 : List.range' 3842 254 = masses60 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3842 64 190
 rw [rangeBlock60,rangeSuffix61] at h
 exact h.symm
theorem rangeBlock59 : List.range' 3778 64 = NuclearBindingGatherBatch59.masses := rfl
theorem rangeSuffix59 : List.range' 3778 318 = masses59 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3778 64 254
 rw [rangeBlock59,rangeSuffix60] at h
 exact h.symm
theorem rangeBlock58 : List.range' 3714 64 = NuclearBindingGatherBatch58.masses := rfl
theorem rangeSuffix58 : List.range' 3714 382 = masses58 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3714 64 318
 rw [rangeBlock58,rangeSuffix59] at h
 exact h.symm
theorem rangeBlock57 : List.range' 3650 64 = NuclearBindingGatherBatch57.masses := rfl
theorem rangeSuffix57 : List.range' 3650 446 = masses57 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3650 64 382
 rw [rangeBlock57,rangeSuffix58] at h
 exact h.symm
theorem rangeBlock56 : List.range' 3586 64 = NuclearBindingGatherBatch56.masses := rfl
theorem rangeSuffix56 : List.range' 3586 510 = masses56 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3586 64 446
 rw [rangeBlock56,rangeSuffix57] at h
 exact h.symm
theorem rangeBlock55 : List.range' 3522 64 = NuclearBindingGatherBatch55.masses := rfl
theorem rangeSuffix55 : List.range' 3522 574 = masses55 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3522 64 510
 rw [rangeBlock55,rangeSuffix56] at h
 exact h.symm
theorem rangeBlock54 : List.range' 3458 64 = NuclearBindingGatherBatch54.masses := rfl
theorem rangeSuffix54 : List.range' 3458 638 = masses54 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3458 64 574
 rw [rangeBlock54,rangeSuffix55] at h
 exact h.symm
theorem rangeBlock53 : List.range' 3394 64 = NuclearBindingGatherBatch53.masses := rfl
theorem rangeSuffix53 : List.range' 3394 702 = masses53 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3394 64 638
 rw [rangeBlock53,rangeSuffix54] at h
 exact h.symm
theorem rangeBlock52 : List.range' 3330 64 = NuclearBindingGatherBatch52.masses := rfl
theorem rangeSuffix52 : List.range' 3330 766 = masses52 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3330 64 702
 rw [rangeBlock52,rangeSuffix53] at h
 exact h.symm
theorem rangeBlock51 : List.range' 3266 64 = NuclearBindingGatherBatch51.masses := rfl
theorem rangeSuffix51 : List.range' 3266 830 = masses51 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3266 64 766
 rw [rangeBlock51,rangeSuffix52] at h
 exact h.symm
theorem rangeBlock50 : List.range' 3202 64 = NuclearBindingGatherBatch50.masses := rfl
theorem rangeSuffix50 : List.range' 3202 894 = masses50 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3202 64 830
 rw [rangeBlock50,rangeSuffix51] at h
 exact h.symm
theorem rangeBlock49 : List.range' 3138 64 = NuclearBindingGatherBatch49.masses := rfl
theorem rangeSuffix49 : List.range' 3138 958 = masses49 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3138 64 894
 rw [rangeBlock49,rangeSuffix50] at h
 exact h.symm
theorem rangeBlock48 : List.range' 3074 64 = NuclearBindingGatherBatch48.masses := rfl
theorem rangeSuffix48 : List.range' 3074 1022 = masses48 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3074 64 958
 rw [rangeBlock48,rangeSuffix49] at h
 exact h.symm
theorem rangeBlock47 : List.range' 3010 64 = NuclearBindingGatherBatch47.masses := rfl
theorem rangeSuffix47 : List.range' 3010 1086 = masses47 := by
 have h := NuclearBindingRangeComposition.rangeAppend 3010 64 1022
 rw [rangeBlock47,rangeSuffix48] at h
 exact h.symm
theorem rangeBlock46 : List.range' 2946 64 = NuclearBindingGatherBatch46.masses := rfl
theorem rangeSuffix46 : List.range' 2946 1150 = masses46 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2946 64 1086
 rw [rangeBlock46,rangeSuffix47] at h
 exact h.symm
theorem rangeBlock45 : List.range' 2882 64 = NuclearBindingGatherBatch45.masses := rfl
theorem rangeSuffix45 : List.range' 2882 1214 = masses45 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2882 64 1150
 rw [rangeBlock45,rangeSuffix46] at h
 exact h.symm
theorem rangeBlock44 : List.range' 2818 64 = NuclearBindingGatherBatch44.masses := rfl
theorem rangeSuffix44 : List.range' 2818 1278 = masses44 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2818 64 1214
 rw [rangeBlock44,rangeSuffix45] at h
 exact h.symm
theorem rangeBlock43 : List.range' 2754 64 = NuclearBindingGatherBatch43.masses := rfl
theorem rangeSuffix43 : List.range' 2754 1342 = masses43 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2754 64 1278
 rw [rangeBlock43,rangeSuffix44] at h
 exact h.symm
theorem rangeBlock42 : List.range' 2690 64 = NuclearBindingGatherBatch42.masses := rfl
theorem rangeSuffix42 : List.range' 2690 1406 = masses42 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2690 64 1342
 rw [rangeBlock42,rangeSuffix43] at h
 exact h.symm
theorem rangeBlock41 : List.range' 2626 64 = NuclearBindingGatherBatch41.masses := rfl
theorem rangeSuffix41 : List.range' 2626 1470 = masses41 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2626 64 1406
 rw [rangeBlock41,rangeSuffix42] at h
 exact h.symm
theorem rangeBlock40 : List.range' 2562 64 = NuclearBindingGatherBatch40.masses := rfl
theorem rangeSuffix40 : List.range' 2562 1534 = masses40 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2562 64 1470
 rw [rangeBlock40,rangeSuffix41] at h
 exact h.symm
theorem rangeBlock39 : List.range' 2498 64 = NuclearBindingGatherBatch39.masses := rfl
theorem rangeSuffix39 : List.range' 2498 1598 = masses39 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2498 64 1534
 rw [rangeBlock39,rangeSuffix40] at h
 exact h.symm
theorem rangeBlock38 : List.range' 2434 64 = NuclearBindingGatherBatch38.masses := rfl
theorem rangeSuffix38 : List.range' 2434 1662 = masses38 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2434 64 1598
 rw [rangeBlock38,rangeSuffix39] at h
 exact h.symm
theorem rangeBlock37 : List.range' 2370 64 = NuclearBindingGatherBatch37.masses := rfl
theorem rangeSuffix37 : List.range' 2370 1726 = masses37 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2370 64 1662
 rw [rangeBlock37,rangeSuffix38] at h
 exact h.symm
theorem rangeBlock36 : List.range' 2306 64 = NuclearBindingGatherBatch36.masses := rfl
theorem rangeSuffix36 : List.range' 2306 1790 = masses36 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2306 64 1726
 rw [rangeBlock36,rangeSuffix37] at h
 exact h.symm
theorem rangeBlock35 : List.range' 2242 64 = NuclearBindingGatherBatch35.masses := rfl
theorem rangeSuffix35 : List.range' 2242 1854 = masses35 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2242 64 1790
 rw [rangeBlock35,rangeSuffix36] at h
 exact h.symm
theorem rangeBlock34 : List.range' 2178 64 = NuclearBindingGatherBatch34.masses := rfl
theorem rangeSuffix34 : List.range' 2178 1918 = masses34 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2178 64 1854
 rw [rangeBlock34,rangeSuffix35] at h
 exact h.symm
theorem rangeBlock33 : List.range' 2114 64 = NuclearBindingGatherBatch33.masses := rfl
theorem rangeSuffix33 : List.range' 2114 1982 = masses33 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2114 64 1918
 rw [rangeBlock33,rangeSuffix34] at h
 exact h.symm
theorem rangeBlock32 : List.range' 2050 64 = NuclearBindingGatherBatch32.masses := rfl
theorem rangeSuffix32 : List.range' 2050 2046 = masses32 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2050 64 1982
 rw [rangeBlock32,rangeSuffix33] at h
 exact h.symm
theorem rangeBlock31 : List.range' 1986 64 = NuclearBindingGatherBatch31.masses := rfl
theorem rangeSuffix31 : List.range' 1986 2110 = masses31 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1986 64 2046
 rw [rangeBlock31,rangeSuffix32] at h
 exact h.symm
theorem rangeBlock30 : List.range' 1922 64 = NuclearBindingGatherBatch30.masses := rfl
theorem rangeSuffix30 : List.range' 1922 2174 = masses30 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1922 64 2110
 rw [rangeBlock30,rangeSuffix31] at h
 exact h.symm
theorem rangeBlock29 : List.range' 1858 64 = NuclearBindingGatherBatch29.masses := rfl
theorem rangeSuffix29 : List.range' 1858 2238 = masses29 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1858 64 2174
 rw [rangeBlock29,rangeSuffix30] at h
 exact h.symm
theorem rangeBlock28 : List.range' 1794 64 = NuclearBindingGatherBatch28.masses := rfl
theorem rangeSuffix28 : List.range' 1794 2302 = masses28 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1794 64 2238
 rw [rangeBlock28,rangeSuffix29] at h
 exact h.symm
theorem rangeBlock27 : List.range' 1730 64 = NuclearBindingGatherBatch27.masses := rfl
theorem rangeSuffix27 : List.range' 1730 2366 = masses27 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1730 64 2302
 rw [rangeBlock27,rangeSuffix28] at h
 exact h.symm
theorem rangeBlock26 : List.range' 1666 64 = NuclearBindingGatherBatch26.masses := rfl
theorem rangeSuffix26 : List.range' 1666 2430 = masses26 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1666 64 2366
 rw [rangeBlock26,rangeSuffix27] at h
 exact h.symm
theorem rangeBlock25 : List.range' 1602 64 = NuclearBindingGatherBatch25.masses := rfl
theorem rangeSuffix25 : List.range' 1602 2494 = masses25 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1602 64 2430
 rw [rangeBlock25,rangeSuffix26] at h
 exact h.symm
theorem rangeBlock24 : List.range' 1538 64 = NuclearBindingGatherBatch24.masses := rfl
theorem rangeSuffix24 : List.range' 1538 2558 = masses24 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1538 64 2494
 rw [rangeBlock24,rangeSuffix25] at h
 exact h.symm
theorem rangeBlock23 : List.range' 1474 64 = NuclearBindingGatherBatch23.masses := rfl
theorem rangeSuffix23 : List.range' 1474 2622 = masses23 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1474 64 2558
 rw [rangeBlock23,rangeSuffix24] at h
 exact h.symm
theorem rangeBlock22 : List.range' 1410 64 = NuclearBindingGatherBatch22.masses := rfl
theorem rangeSuffix22 : List.range' 1410 2686 = masses22 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1410 64 2622
 rw [rangeBlock22,rangeSuffix23] at h
 exact h.symm
theorem rangeBlock21 : List.range' 1346 64 = NuclearBindingGatherBatch21.masses := rfl
theorem rangeSuffix21 : List.range' 1346 2750 = masses21 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1346 64 2686
 rw [rangeBlock21,rangeSuffix22] at h
 exact h.symm
theorem rangeBlock20 : List.range' 1282 64 = NuclearBindingGatherBatch20.masses := rfl
theorem rangeSuffix20 : List.range' 1282 2814 = masses20 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1282 64 2750
 rw [rangeBlock20,rangeSuffix21] at h
 exact h.symm
theorem rangeBlock19 : List.range' 1218 64 = NuclearBindingGatherBatch19.masses := rfl
theorem rangeSuffix19 : List.range' 1218 2878 = masses19 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1218 64 2814
 rw [rangeBlock19,rangeSuffix20] at h
 exact h.symm
theorem rangeBlock18 : List.range' 1154 64 = NuclearBindingGatherBatch18.masses := rfl
theorem rangeSuffix18 : List.range' 1154 2942 = masses18 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1154 64 2878
 rw [rangeBlock18,rangeSuffix19] at h
 exact h.symm
theorem rangeBlock17 : List.range' 1090 64 = NuclearBindingGatherBatch17.masses := rfl
theorem rangeSuffix17 : List.range' 1090 3006 = masses17 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1090 64 2942
 rw [rangeBlock17,rangeSuffix18] at h
 exact h.symm
theorem rangeBlock16 : List.range' 1026 64 = NuclearBindingGatherBatch16.masses := rfl
theorem rangeSuffix16 : List.range' 1026 3070 = masses16 := by
 have h := NuclearBindingRangeComposition.rangeAppend 1026 64 3006
 rw [rangeBlock16,rangeSuffix17] at h
 exact h.symm
theorem rangeBlock15 : List.range' 962 64 = NuclearBindingGatherBatch15.masses := rfl
theorem rangeSuffix15 : List.range' 962 3134 = masses15 := by
 have h := NuclearBindingRangeComposition.rangeAppend 962 64 3070
 rw [rangeBlock15,rangeSuffix16] at h
 exact h.symm
theorem rangeBlock14 : List.range' 898 64 = NuclearBindingGatherBatch14.masses := rfl
theorem rangeSuffix14 : List.range' 898 3198 = masses14 := by
 have h := NuclearBindingRangeComposition.rangeAppend 898 64 3134
 rw [rangeBlock14,rangeSuffix15] at h
 exact h.symm
theorem rangeBlock13 : List.range' 834 64 = NuclearBindingGatherBatch13.masses := rfl
theorem rangeSuffix13 : List.range' 834 3262 = masses13 := by
 have h := NuclearBindingRangeComposition.rangeAppend 834 64 3198
 rw [rangeBlock13,rangeSuffix14] at h
 exact h.symm
theorem rangeBlock12 : List.range' 770 64 = NuclearBindingGatherBatch12.masses := rfl
theorem rangeSuffix12 : List.range' 770 3326 = masses12 := by
 have h := NuclearBindingRangeComposition.rangeAppend 770 64 3262
 rw [rangeBlock12,rangeSuffix13] at h
 exact h.symm
theorem rangeBlock11 : List.range' 706 64 = NuclearBindingGatherBatch11.masses := rfl
theorem rangeSuffix11 : List.range' 706 3390 = masses11 := by
 have h := NuclearBindingRangeComposition.rangeAppend 706 64 3326
 rw [rangeBlock11,rangeSuffix12] at h
 exact h.symm
theorem rangeBlock10 : List.range' 642 64 = NuclearBindingGatherBatch10.masses := rfl
theorem rangeSuffix10 : List.range' 642 3454 = masses10 := by
 have h := NuclearBindingRangeComposition.rangeAppend 642 64 3390
 rw [rangeBlock10,rangeSuffix11] at h
 exact h.symm
theorem rangeBlock9 : List.range' 578 64 = NuclearBindingGatherBatch09.masses := rfl
theorem rangeSuffix9 : List.range' 578 3518 = masses9 := by
 have h := NuclearBindingRangeComposition.rangeAppend 578 64 3454
 rw [rangeBlock9,rangeSuffix10] at h
 exact h.symm
theorem rangeBlock8 : List.range' 514 64 = NuclearBindingGatherBatch08.masses := rfl
theorem rangeSuffix8 : List.range' 514 3582 = masses8 := by
 have h := NuclearBindingRangeComposition.rangeAppend 514 64 3518
 rw [rangeBlock8,rangeSuffix9] at h
 exact h.symm
theorem rangeBlock7 : List.range' 450 64 = NuclearBindingGatherBatch07.masses := rfl
theorem rangeSuffix7 : List.range' 450 3646 = masses7 := by
 have h := NuclearBindingRangeComposition.rangeAppend 450 64 3582
 rw [rangeBlock7,rangeSuffix8] at h
 exact h.symm
theorem rangeBlock6 : List.range' 386 64 = NuclearBindingGatherBatch06.masses := rfl
theorem rangeSuffix6 : List.range' 386 3710 = masses6 := by
 have h := NuclearBindingRangeComposition.rangeAppend 386 64 3646
 rw [rangeBlock6,rangeSuffix7] at h
 exact h.symm
theorem rangeBlock5 : List.range' 322 64 = NuclearBindingGatherBatch05.masses := rfl
theorem rangeSuffix5 : List.range' 322 3774 = masses5 := by
 have h := NuclearBindingRangeComposition.rangeAppend 322 64 3710
 rw [rangeBlock5,rangeSuffix6] at h
 exact h.symm
theorem rangeBlock4 : List.range' 258 64 = NuclearBindingGatherBatch04.masses := rfl
theorem rangeSuffix4 : List.range' 258 3838 = masses4 := by
 have h := NuclearBindingRangeComposition.rangeAppend 258 64 3774
 rw [rangeBlock4,rangeSuffix5] at h
 exact h.symm
theorem rangeBlock3 : List.range' 194 64 = NuclearBindingGatherBatch03.masses := rfl
theorem rangeSuffix3 : List.range' 194 3902 = masses3 := by
 have h := NuclearBindingRangeComposition.rangeAppend 194 64 3838
 rw [rangeBlock3,rangeSuffix4] at h
 exact h.symm
theorem rangeBlock2 : List.range' 130 64 = NuclearBindingGatherBatch02.masses := rfl
theorem rangeSuffix2 : List.range' 130 3966 = masses2 := by
 have h := NuclearBindingRangeComposition.rangeAppend 130 64 3902
 rw [rangeBlock2,rangeSuffix3] at h
 exact h.symm
theorem rangeBlock1 : List.range' 66 64 = NuclearBindingGatherBatch01.masses := rfl
theorem rangeSuffix1 : List.range' 66 4030 = masses1 := by
 have h := NuclearBindingRangeComposition.rangeAppend 66 64 3966
 rw [rangeBlock1,rangeSuffix2] at h
 exact h.symm
theorem rangeBlock0 : List.range' 2 64 = NuclearBindingGatherBatch00.masses := rfl
theorem rangeSuffix0 : List.range' 2 4094 = masses0 := by
 have h := NuclearBindingRangeComposition.rangeAppend 2 64 4030
 rw [rangeBlock0,rangeSuffix1] at h
 exact h.symm
theorem originalMassRange : (List.range 4094).map (fun n => 2+n) = masses0 := by
 rw [List.range_eq_range',NuclearBindingRangeComposition.mapAdd]
 exact rangeSuffix0
theorem cutoffValue : NuclearBindingTail.tailCutoffMass = .ok 4096 := rfl
theorem fixedBounds (fuel binary cutoff : Nat)
 (hb : AlphaCovers.binaryCount = .ok binary)
 (hc : NuclearBindingTail.tailCutoffMass = .ok cutoff) :
 finitePeakCandidatesWithin fuel = gather fuel ((List.range (cutoff-binary)).map (fun n => binary+n)) := by
 unfold finitePeakCandidatesWithin
 rw [hb]
 dsimp only [Except.bind,Bind.bind]
 rw [hc]
theorem completeCensus : finitePeakCandidatesWithin 7 = .ok (some candidates0) :=
 (fixedBounds 7 2 4096 AlphaCovers.binaryCountTwo cutoffValue).trans
 ((congrArg (gather 7) originalMassRange).trans complete0)
end SFT.Physics.NuclearBindingGatherClosure
