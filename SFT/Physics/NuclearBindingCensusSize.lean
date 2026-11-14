import SFT.Physics.NuclearBindingGatherClosure
namespace SFT.Physics.NuclearBindingCensusSize
open NuclearBindingGatherClosure
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
private theorem lengthAppend {α : Type} (xs ys : List α) : (xs++ys).length = xs.length+ys.length := by
 induction xs with
 | nil => exact (Nat.zero_add _).symm
 | cons a xs ih => exact (congrArg Nat.succ ih).trans (Nat.succ_add _ _).symm
theorem block63 : NuclearBindingGatherBatch63.candidates.length = 386 := rfl
theorem suffix63 : candidates63.length = 386 := block63
theorem block62 : NuclearBindingGatherBatch62.candidates.length = 401 := rfl
theorem suffix62 : candidates62.length = 787 :=
 (lengthAppend NuclearBindingGatherBatch62.candidates candidates63).trans
 ((congrArg (fun n => n + candidates63.length) block62).trans
 (congrArg (fun n => 401+n) suffix63))
theorem block61 : NuclearBindingGatherBatch61.candidates.length = 399 := rfl
theorem suffix61 : candidates61.length = 1186 :=
 (lengthAppend NuclearBindingGatherBatch61.candidates candidates62).trans
 ((congrArg (fun n => n + candidates62.length) block61).trans
 (congrArg (fun n => 399+n) suffix62))
theorem block60 : NuclearBindingGatherBatch60.candidates.length = 397 := rfl
theorem suffix60 : candidates60.length = 1583 :=
 (lengthAppend NuclearBindingGatherBatch60.candidates candidates61).trans
 ((congrArg (fun n => n + candidates61.length) block60).trans
 (congrArg (fun n => 397+n) suffix61))
theorem block59 : NuclearBindingGatherBatch59.candidates.length = 399 := rfl
theorem suffix59 : candidates59.length = 1982 :=
 (lengthAppend NuclearBindingGatherBatch59.candidates candidates60).trans
 ((congrArg (fun n => n + candidates60.length) block59).trans
 (congrArg (fun n => 399+n) suffix60))
theorem block58 : NuclearBindingGatherBatch58.candidates.length = 398 := rfl
theorem suffix58 : candidates58.length = 2380 :=
 (lengthAppend NuclearBindingGatherBatch58.candidates candidates59).trans
 ((congrArg (fun n => n + candidates59.length) block58).trans
 (congrArg (fun n => 398+n) suffix59))
theorem block57 : NuclearBindingGatherBatch57.candidates.length = 397 := rfl
theorem suffix57 : candidates57.length = 2777 :=
 (lengthAppend NuclearBindingGatherBatch57.candidates candidates58).trans
 ((congrArg (fun n => n + candidates58.length) block57).trans
 (congrArg (fun n => 397+n) suffix58))
theorem block56 : NuclearBindingGatherBatch56.candidates.length = 397 := rfl
theorem suffix56 : candidates56.length = 3174 :=
 (lengthAppend NuclearBindingGatherBatch56.candidates candidates57).trans
 ((congrArg (fun n => n + candidates57.length) block56).trans
 (congrArg (fun n => 397+n) suffix57))
theorem block55 : NuclearBindingGatherBatch55.candidates.length = 397 := rfl
theorem suffix55 : candidates55.length = 3571 :=
 (lengthAppend NuclearBindingGatherBatch55.candidates candidates56).trans
 ((congrArg (fun n => n + candidates56.length) block55).trans
 (congrArg (fun n => 397+n) suffix56))
theorem block54 : NuclearBindingGatherBatch54.candidates.length = 399 := rfl
theorem suffix54 : candidates54.length = 3970 :=
 (lengthAppend NuclearBindingGatherBatch54.candidates candidates55).trans
 ((congrArg (fun n => n + candidates55.length) block54).trans
 (congrArg (fun n => 399+n) suffix55))
theorem block53 : NuclearBindingGatherBatch53.candidates.length = 398 := rfl
theorem suffix53 : candidates53.length = 4368 :=
 (lengthAppend NuclearBindingGatherBatch53.candidates candidates54).trans
 ((congrArg (fun n => n + candidates54.length) block53).trans
 (congrArg (fun n => 398+n) suffix54))
theorem block52 : NuclearBindingGatherBatch52.candidates.length = 397 := rfl
theorem suffix52 : candidates52.length = 4765 :=
 (lengthAppend NuclearBindingGatherBatch52.candidates candidates53).trans
 ((congrArg (fun n => n + candidates53.length) block52).trans
 (congrArg (fun n => 397+n) suffix53))
theorem block51 : NuclearBindingGatherBatch51.candidates.length = 401 := rfl
theorem suffix51 : candidates51.length = 5166 :=
 (lengthAppend NuclearBindingGatherBatch51.candidates candidates52).trans
 ((congrArg (fun n => n + candidates52.length) block51).trans
 (congrArg (fun n => 401+n) suffix52))
theorem block50 : NuclearBindingGatherBatch50.candidates.length = 398 := rfl
theorem suffix50 : candidates50.length = 5564 :=
 (lengthAppend NuclearBindingGatherBatch50.candidates candidates51).trans
 ((congrArg (fun n => n + candidates51.length) block50).trans
 (congrArg (fun n => 398+n) suffix51))
theorem block49 : NuclearBindingGatherBatch49.candidates.length = 397 := rfl
theorem suffix49 : candidates49.length = 5961 :=
 (lengthAppend NuclearBindingGatherBatch49.candidates candidates50).trans
 ((congrArg (fun n => n + candidates50.length) block49).trans
 (congrArg (fun n => 397+n) suffix50))
theorem block48 : NuclearBindingGatherBatch48.candidates.length = 399 := rfl
theorem suffix48 : candidates48.length = 6360 :=
 (lengthAppend NuclearBindingGatherBatch48.candidates candidates49).trans
 ((congrArg (fun n => n + candidates49.length) block48).trans
 (congrArg (fun n => 399+n) suffix49))
theorem block47 : NuclearBindingGatherBatch47.candidates.length = 394 := rfl
theorem suffix47 : candidates47.length = 6754 :=
 (lengthAppend NuclearBindingGatherBatch47.candidates candidates48).trans
 ((congrArg (fun n => n + candidates48.length) block47).trans
 (congrArg (fun n => 394+n) suffix48))
theorem block46 : NuclearBindingGatherBatch46.candidates.length = 399 := rfl
theorem suffix46 : candidates46.length = 7153 :=
 (lengthAppend NuclearBindingGatherBatch46.candidates candidates47).trans
 ((congrArg (fun n => n + candidates47.length) block46).trans
 (congrArg (fun n => 399+n) suffix47))
theorem block45 : NuclearBindingGatherBatch45.candidates.length = 397 := rfl
theorem suffix45 : candidates45.length = 7550 :=
 (lengthAppend NuclearBindingGatherBatch45.candidates candidates46).trans
 ((congrArg (fun n => n + candidates46.length) block45).trans
 (congrArg (fun n => 397+n) suffix46))
theorem block44 : NuclearBindingGatherBatch44.candidates.length = 397 := rfl
theorem suffix44 : candidates44.length = 7947 :=
 (lengthAppend NuclearBindingGatherBatch44.candidates candidates45).trans
 ((congrArg (fun n => n + candidates45.length) block44).trans
 (congrArg (fun n => 397+n) suffix45))
theorem block43 : NuclearBindingGatherBatch43.candidates.length = 395 := rfl
theorem suffix43 : candidates43.length = 8342 :=
 (lengthAppend NuclearBindingGatherBatch43.candidates candidates44).trans
 ((congrArg (fun n => n + candidates44.length) block43).trans
 (congrArg (fun n => 395+n) suffix44))
theorem block42 : NuclearBindingGatherBatch42.candidates.length = 395 := rfl
theorem suffix42 : candidates42.length = 8737 :=
 (lengthAppend NuclearBindingGatherBatch42.candidates candidates43).trans
 ((congrArg (fun n => n + candidates43.length) block42).trans
 (congrArg (fun n => 395+n) suffix43))
theorem block41 : NuclearBindingGatherBatch41.candidates.length = 398 := rfl
theorem suffix41 : candidates41.length = 9135 :=
 (lengthAppend NuclearBindingGatherBatch41.candidates candidates42).trans
 ((congrArg (fun n => n + candidates42.length) block41).trans
 (congrArg (fun n => 398+n) suffix42))
theorem block40 : NuclearBindingGatherBatch40.candidates.length = 395 := rfl
theorem suffix40 : candidates40.length = 9530 :=
 (lengthAppend NuclearBindingGatherBatch40.candidates candidates41).trans
 ((congrArg (fun n => n + candidates41.length) block40).trans
 (congrArg (fun n => 395+n) suffix41))
theorem block39 : NuclearBindingGatherBatch39.candidates.length = 394 := rfl
theorem suffix39 : candidates39.length = 9924 :=
 (lengthAppend NuclearBindingGatherBatch39.candidates candidates40).trans
 ((congrArg (fun n => n + candidates40.length) block39).trans
 (congrArg (fun n => 394+n) suffix40))
theorem block38 : NuclearBindingGatherBatch38.candidates.length = 396 := rfl
theorem suffix38 : candidates38.length = 10320 :=
 (lengthAppend NuclearBindingGatherBatch38.candidates candidates39).trans
 ((congrArg (fun n => n + candidates39.length) block38).trans
 (congrArg (fun n => 396+n) suffix39))
theorem block37 : NuclearBindingGatherBatch37.candidates.length = 395 := rfl
theorem suffix37 : candidates37.length = 10715 :=
 (lengthAppend NuclearBindingGatherBatch37.candidates candidates38).trans
 ((congrArg (fun n => n + candidates38.length) block37).trans
 (congrArg (fun n => 395+n) suffix38))
theorem block36 : NuclearBindingGatherBatch36.candidates.length = 398 := rfl
theorem suffix36 : candidates36.length = 11113 :=
 (lengthAppend NuclearBindingGatherBatch36.candidates candidates37).trans
 ((congrArg (fun n => n + candidates37.length) block36).trans
 (congrArg (fun n => 398+n) suffix37))
theorem block35 : NuclearBindingGatherBatch35.candidates.length = 393 := rfl
theorem suffix35 : candidates35.length = 11506 :=
 (lengthAppend NuclearBindingGatherBatch35.candidates candidates36).trans
 ((congrArg (fun n => n + candidates36.length) block35).trans
 (congrArg (fun n => 393+n) suffix36))
theorem block34 : NuclearBindingGatherBatch34.candidates.length = 396 := rfl
theorem suffix34 : candidates34.length = 11902 :=
 (lengthAppend NuclearBindingGatherBatch34.candidates candidates35).trans
 ((congrArg (fun n => n + candidates35.length) block34).trans
 (congrArg (fun n => 396+n) suffix35))
theorem block33 : NuclearBindingGatherBatch33.candidates.length = 394 := rfl
theorem suffix33 : candidates33.length = 12296 :=
 (lengthAppend NuclearBindingGatherBatch33.candidates candidates34).trans
 ((congrArg (fun n => n + candidates34.length) block33).trans
 (congrArg (fun n => 394+n) suffix34))
theorem block32 : NuclearBindingGatherBatch32.candidates.length = 394 := rfl
theorem suffix32 : candidates32.length = 12690 :=
 (lengthAppend NuclearBindingGatherBatch32.candidates candidates33).trans
 ((congrArg (fun n => n + candidates33.length) block32).trans
 (congrArg (fun n => 394+n) suffix33))
theorem block31 : NuclearBindingGatherBatch31.candidates.length = 393 := rfl
theorem suffix31 : candidates31.length = 13083 :=
 (lengthAppend NuclearBindingGatherBatch31.candidates candidates32).trans
 ((congrArg (fun n => n + candidates32.length) block31).trans
 (congrArg (fun n => 393+n) suffix32))
theorem block30 : NuclearBindingGatherBatch30.candidates.length = 393 := rfl
theorem suffix30 : candidates30.length = 13476 :=
 (lengthAppend NuclearBindingGatherBatch30.candidates candidates31).trans
 ((congrArg (fun n => n + candidates31.length) block30).trans
 (congrArg (fun n => 393+n) suffix31))
theorem block29 : NuclearBindingGatherBatch29.candidates.length = 391 := rfl
theorem suffix29 : candidates29.length = 13867 :=
 (lengthAppend NuclearBindingGatherBatch29.candidates candidates30).trans
 ((congrArg (fun n => n + candidates30.length) block29).trans
 (congrArg (fun n => 391+n) suffix30))
theorem block28 : NuclearBindingGatherBatch28.candidates.length = 393 := rfl
theorem suffix28 : candidates28.length = 14260 :=
 (lengthAppend NuclearBindingGatherBatch28.candidates candidates29).trans
 ((congrArg (fun n => n + candidates29.length) block28).trans
 (congrArg (fun n => 393+n) suffix29))
theorem block27 : NuclearBindingGatherBatch27.candidates.length = 394 := rfl
theorem suffix27 : candidates27.length = 14654 :=
 (lengthAppend NuclearBindingGatherBatch27.candidates candidates28).trans
 ((congrArg (fun n => n + candidates28.length) block27).trans
 (congrArg (fun n => 394+n) suffix28))
theorem block26 : NuclearBindingGatherBatch26.candidates.length = 391 := rfl
theorem suffix26 : candidates26.length = 15045 :=
 (lengthAppend NuclearBindingGatherBatch26.candidates candidates27).trans
 ((congrArg (fun n => n + candidates27.length) block26).trans
 (congrArg (fun n => 391+n) suffix27))
theorem block25 : NuclearBindingGatherBatch25.candidates.length = 393 := rfl
theorem suffix25 : candidates25.length = 15438 :=
 (lengthAppend NuclearBindingGatherBatch25.candidates candidates26).trans
 ((congrArg (fun n => n + candidates26.length) block25).trans
 (congrArg (fun n => 393+n) suffix26))
theorem block24 : NuclearBindingGatherBatch24.candidates.length = 391 := rfl
theorem suffix24 : candidates24.length = 15829 :=
 (lengthAppend NuclearBindingGatherBatch24.candidates candidates25).trans
 ((congrArg (fun n => n + candidates25.length) block24).trans
 (congrArg (fun n => 391+n) suffix25))
theorem block23 : NuclearBindingGatherBatch23.candidates.length = 391 := rfl
theorem suffix23 : candidates23.length = 16220 :=
 (lengthAppend NuclearBindingGatherBatch23.candidates candidates24).trans
 ((congrArg (fun n => n + candidates24.length) block23).trans
 (congrArg (fun n => 391+n) suffix24))
theorem block22 : NuclearBindingGatherBatch22.candidates.length = 402 := rfl
theorem suffix22 : candidates22.length = 16622 :=
 (lengthAppend NuclearBindingGatherBatch22.candidates candidates23).trans
 ((congrArg (fun n => n + candidates23.length) block22).trans
 (congrArg (fun n => 402+n) suffix23))
theorem block21 : NuclearBindingGatherBatch21.candidates.length = 394 := rfl
theorem suffix21 : candidates21.length = 17016 :=
 (lengthAppend NuclearBindingGatherBatch21.candidates candidates22).trans
 ((congrArg (fun n => n + candidates22.length) block21).trans
 (congrArg (fun n => 394+n) suffix22))
theorem block20 : NuclearBindingGatherBatch20.candidates.length = 402 := rfl
theorem suffix20 : candidates20.length = 17418 :=
 (lengthAppend NuclearBindingGatherBatch20.candidates candidates21).trans
 ((congrArg (fun n => n + candidates21.length) block20).trans
 (congrArg (fun n => 402+n) suffix21))
theorem block19 : NuclearBindingGatherBatch19.candidates.length = 400 := rfl
theorem suffix19 : candidates19.length = 17818 :=
 (lengthAppend NuclearBindingGatherBatch19.candidates candidates20).trans
 ((congrArg (fun n => n + candidates20.length) block19).trans
 (congrArg (fun n => 400+n) suffix20))
theorem block18 : NuclearBindingGatherBatch18.candidates.length = 388 := rfl
theorem suffix18 : candidates18.length = 18206 :=
 (lengthAppend NuclearBindingGatherBatch18.candidates candidates19).trans
 ((congrArg (fun n => n + candidates19.length) block18).trans
 (congrArg (fun n => 388+n) suffix19))
theorem block17 : NuclearBindingGatherBatch17.candidates.length = 389 := rfl
theorem suffix17 : candidates17.length = 18595 :=
 (lengthAppend NuclearBindingGatherBatch17.candidates candidates18).trans
 ((congrArg (fun n => n + candidates18.length) block17).trans
 (congrArg (fun n => 389+n) suffix18))
theorem block16 : NuclearBindingGatherBatch16.candidates.length = 387 := rfl
theorem suffix16 : candidates16.length = 18982 :=
 (lengthAppend NuclearBindingGatherBatch16.candidates candidates17).trans
 ((congrArg (fun n => n + candidates17.length) block16).trans
 (congrArg (fun n => 387+n) suffix17))
theorem block15 : NuclearBindingGatherBatch15.candidates.length = 399 := rfl
theorem suffix15 : candidates15.length = 19381 :=
 (lengthAppend NuclearBindingGatherBatch15.candidates candidates16).trans
 ((congrArg (fun n => n + candidates16.length) block15).trans
 (congrArg (fun n => 399+n) suffix16))
theorem block14 : NuclearBindingGatherBatch14.candidates.length = 397 := rfl
theorem suffix14 : candidates14.length = 19778 :=
 (lengthAppend NuclearBindingGatherBatch14.candidates candidates15).trans
 ((congrArg (fun n => n + candidates15.length) block14).trans
 (congrArg (fun n => 397+n) suffix15))
theorem block13 : NuclearBindingGatherBatch13.candidates.length = 395 := rfl
theorem suffix13 : candidates13.length = 20173 :=
 (lengthAppend NuclearBindingGatherBatch13.candidates candidates14).trans
 ((congrArg (fun n => n + candidates14.length) block13).trans
 (congrArg (fun n => 395+n) suffix14))
theorem block12 : NuclearBindingGatherBatch12.candidates.length = 396 := rfl
theorem suffix12 : candidates12.length = 20569 :=
 (lengthAppend NuclearBindingGatherBatch12.candidates candidates13).trans
 ((congrArg (fun n => n + candidates13.length) block12).trans
 (congrArg (fun n => 396+n) suffix13))
theorem block11 : NuclearBindingGatherBatch11.candidates.length = 394 := rfl
theorem suffix11 : candidates11.length = 20963 :=
 (lengthAppend NuclearBindingGatherBatch11.candidates candidates12).trans
 ((congrArg (fun n => n + candidates12.length) block11).trans
 (congrArg (fun n => 394+n) suffix12))
theorem block10 : NuclearBindingGatherBatch10.candidates.length = 391 := rfl
theorem suffix10 : candidates10.length = 21354 :=
 (lengthAppend NuclearBindingGatherBatch10.candidates candidates11).trans
 ((congrArg (fun n => n + candidates11.length) block10).trans
 (congrArg (fun n => 391+n) suffix11))
theorem block9 : NuclearBindingGatherBatch09.candidates.length = 399 := rfl
theorem suffix9 : candidates9.length = 21753 :=
 (lengthAppend NuclearBindingGatherBatch09.candidates candidates10).trans
 ((congrArg (fun n => n + candidates10.length) block9).trans
 (congrArg (fun n => 399+n) suffix10))
theorem block8 : NuclearBindingGatherBatch08.candidates.length = 399 := rfl
theorem suffix8 : candidates8.length = 22152 :=
 (lengthAppend NuclearBindingGatherBatch08.candidates candidates9).trans
 ((congrArg (fun n => n + candidates9.length) block8).trans
 (congrArg (fun n => 399+n) suffix9))
theorem block7 : NuclearBindingGatherBatch07.candidates.length = 396 := rfl
theorem suffix7 : candidates7.length = 22548 :=
 (lengthAppend NuclearBindingGatherBatch07.candidates candidates8).trans
 ((congrArg (fun n => n + candidates8.length) block7).trans
 (congrArg (fun n => 396+n) suffix8))
theorem block6 : NuclearBindingGatherBatch06.candidates.length = 396 := rfl
theorem suffix6 : candidates6.length = 22944 :=
 (lengthAppend NuclearBindingGatherBatch06.candidates candidates7).trans
 ((congrArg (fun n => n + candidates7.length) block6).trans
 (congrArg (fun n => 396+n) suffix7))
theorem block5 : NuclearBindingGatherBatch05.candidates.length = 395 := rfl
theorem suffix5 : candidates5.length = 23339 :=
 (lengthAppend NuclearBindingGatherBatch05.candidates candidates6).trans
 ((congrArg (fun n => n + candidates6.length) block5).trans
 (congrArg (fun n => 395+n) suffix6))
theorem block4 : NuclearBindingGatherBatch04.candidates.length = 398 := rfl
theorem suffix4 : candidates4.length = 23737 :=
 (lengthAppend NuclearBindingGatherBatch04.candidates candidates5).trans
 ((congrArg (fun n => n + candidates5.length) block4).trans
 (congrArg (fun n => 398+n) suffix5))
theorem block3 : NuclearBindingGatherBatch03.candidates.length = 399 := rfl
theorem suffix3 : candidates3.length = 24136 :=
 (lengthAppend NuclearBindingGatherBatch03.candidates candidates4).trans
 ((congrArg (fun n => n + candidates4.length) block3).trans
 (congrArg (fun n => 399+n) suffix4))
theorem block2 : NuclearBindingGatherBatch02.candidates.length = 396 := rfl
theorem suffix2 : candidates2.length = 24532 :=
 (lengthAppend NuclearBindingGatherBatch02.candidates candidates3).trans
 ((congrArg (fun n => n + candidates3.length) block2).trans
 (congrArg (fun n => 396+n) suffix3))
theorem block1 : NuclearBindingGatherBatch01.candidates.length = 396 := rfl
theorem suffix1 : candidates1.length = 24928 :=
 (lengthAppend NuclearBindingGatherBatch01.candidates candidates2).trans
 ((congrArg (fun n => n + candidates2.length) block1).trans
 (congrArg (fun n => 396+n) suffix2))
theorem block0 : NuclearBindingGatherBatch00.candidates.length = 375 := rfl
theorem suffix0 : candidates0.length = 25303 :=
 (lengthAppend NuclearBindingGatherBatch00.candidates candidates1).trans
 ((congrArg (fun n => n + candidates1.length) block0).trans
 (congrArg (fun n => 375+n) suffix1))
end SFT.Physics.NuclearBindingCensusSize
