import SFT.Physics.NuclearBindingCensus
namespace SFT.Physics.NuclearBindingCensusBatch00
open NuclearBindingCensus GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
theorem evaluated2 : candidatesWithin (.integer 2) 7 1 = .ok (some [1]) := rfl
theorem source2 : CandidateRun (.integer 2) 1 [1] := candidatesCorrespond _ _ _ _ evaluated2
theorem evaluated3 : candidatesWithin (.integer 3) 7 1 = .ok (some [1,2]) := rfl
theorem source3 : CandidateRun (.integer 3) 1 [1,2] := candidatesCorrespond _ _ _ _ evaluated3
theorem evaluated4 : candidatesWithin (.integer 4) 7 1 = .ok (some [1,2,3]) := rfl
theorem source4 : CandidateRun (.integer 4) 1 [1,2,3] := candidatesCorrespond _ _ _ _ evaluated4
theorem evaluated5 : candidatesWithin (.integer 5) 7 1 = .ok (some [1,2,3,4]) := rfl
theorem source5 : CandidateRun (.integer 5) 1 [1,2,3,4] := candidatesCorrespond _ _ _ _ evaluated5
theorem evaluated6 : candidatesWithin (.integer 6) 7 1 = .ok (some [1,2,3,4,5]) := rfl
theorem source6 : CandidateRun (.integer 6) 1 [1,2,3,4,5] := candidatesCorrespond _ _ _ _ evaluated6
theorem evaluated7 : candidatesWithin (.integer 7) 7 1 = .ok (some [1,2,3,4,5,6]) := rfl
theorem source7 : CandidateRun (.integer 7) 1 [1,2,3,4,5,6] := candidatesCorrespond _ _ _ _ evaluated7
theorem evaluated8 : candidatesWithin (.integer 8) 7 1 = .ok (some [1,2,3,4,5,6]) := rfl
theorem source8 : CandidateRun (.integer 8) 1 [1,2,3,4,5,6] := candidatesCorrespond _ _ _ _ evaluated8
theorem evaluated9 : candidatesWithin (.integer 9) 7 1 = .ok (some [2,3,4,5,6,7]) := rfl
theorem source9 : CandidateRun (.integer 9) 1 [2,3,4,5,6,7] := candidatesCorrespond _ _ _ _ evaluated9
theorem evaluated10 : candidatesWithin (.integer 10) 7 1 = .ok (some [2,3,4,5,6,7]) := rfl
theorem source10 : CandidateRun (.integer 10) 1 [2,3,4,5,6,7] := candidatesCorrespond _ _ _ _ evaluated10
theorem evaluated11 : candidatesWithin (.integer 11) 7 1 = .ok (some [3,4,5,6,7,8]) := rfl
theorem source11 : CandidateRun (.integer 11) 1 [3,4,5,6,7,8] := candidatesCorrespond _ _ _ _ evaluated11
theorem evaluated12 : candidatesWithin (.integer 12) 7 1 = .ok (some [3,4,5,6,7,8]) := rfl
theorem source12 : CandidateRun (.integer 12) 1 [3,4,5,6,7,8] := candidatesCorrespond _ _ _ _ evaluated12
theorem evaluated13 : candidatesWithin (.integer 13) 7 1 = .ok (some [4,5,6,7,8,9]) := rfl
theorem source13 : CandidateRun (.integer 13) 1 [4,5,6,7,8,9] := candidatesCorrespond _ _ _ _ evaluated13
theorem evaluated14 : candidatesWithin (.integer 14) 7 1 = .ok (some [4,5,6,7,8,9]) := rfl
theorem source14 : CandidateRun (.integer 14) 1 [4,5,6,7,8,9] := candidatesCorrespond _ _ _ _ evaluated14
theorem evaluated15 : candidatesWithin (.integer 15) 7 1 = .ok (some [5,6,7,8,9,10]) := rfl
theorem source15 : CandidateRun (.integer 15) 1 [5,6,7,8,9,10] := candidatesCorrespond _ _ _ _ evaluated15
theorem evaluated16 : candidatesWithin (.integer 16) 7 1 = .ok (some [5,6,7,8,9,10]) := rfl
theorem source16 : CandidateRun (.integer 16) 1 [5,6,7,8,9,10] := candidatesCorrespond _ _ _ _ evaluated16
theorem evaluated17 : candidatesWithin (.integer 17) 7 1 = .ok (some [6,7,8,9,10,11]) := rfl
theorem source17 : CandidateRun (.integer 17) 1 [6,7,8,9,10,11] := candidatesCorrespond _ _ _ _ evaluated17
theorem evaluated18 : candidatesWithin (.integer 18) 7 1 = .ok (some [6,7,8,9,10,11]) := rfl
theorem source18 : CandidateRun (.integer 18) 1 [6,7,8,9,10,11] := candidatesCorrespond _ _ _ _ evaluated18
theorem evaluated19 : candidatesWithin (.integer 19) 7 1 = .ok (some [7,8,9,10,11,12]) := rfl
theorem source19 : CandidateRun (.integer 19) 1 [7,8,9,10,11,12] := candidatesCorrespond _ _ _ _ evaluated19
theorem evaluated20 : candidatesWithin (.integer 20) 7 1 = .ok (some [7,8,9,10,11,12]) := rfl
theorem source20 : CandidateRun (.integer 20) 1 [7,8,9,10,11,12] := candidatesCorrespond _ _ _ _ evaluated20
theorem evaluated21 : candidatesWithin (.integer 21) 7 1 = .ok (some [7,8,9,10,11,12,13]) := rfl
theorem source21 : CandidateRun (.integer 21) 1 [7,8,9,10,11,12,13] := candidatesCorrespond _ _ _ _ evaluated21
theorem evaluated22 : candidatesWithin (.integer 22) 7 1 = .ok (some [8,9,10,11,12,13]) := rfl
theorem source22 : CandidateRun (.integer 22) 1 [8,9,10,11,12,13] := candidatesCorrespond _ _ _ _ evaluated22
theorem evaluated23 : candidatesWithin (.integer 23) 7 1 = .ok (some [8,9,10,11,12,13]) := rfl
theorem source23 : CandidateRun (.integer 23) 1 [8,9,10,11,12,13] := candidatesCorrespond _ _ _ _ evaluated23
theorem evaluated24 : candidatesWithin (.integer 24) 7 1 = .ok (some [9,10,11,12,13,14]) := rfl
theorem source24 : CandidateRun (.integer 24) 1 [9,10,11,12,13,14] := candidatesCorrespond _ _ _ _ evaluated24
theorem evaluated25 : candidatesWithin (.integer 25) 7 1 = .ok (some [9,10,11,12,13,14]) := rfl
theorem source25 : CandidateRun (.integer 25) 1 [9,10,11,12,13,14] := candidatesCorrespond _ _ _ _ evaluated25
theorem evaluated26 : candidatesWithin (.integer 26) 7 1 = .ok (some [10,11,12,13,14,15]) := rfl
theorem source26 : CandidateRun (.integer 26) 1 [10,11,12,13,14,15] := candidatesCorrespond _ _ _ _ evaluated26
theorem evaluated27 : candidatesWithin (.integer 27) 7 1 = .ok (some [10,11,12,13,14,15]) := rfl
theorem source27 : CandidateRun (.integer 27) 1 [10,11,12,13,14,15] := candidatesCorrespond _ _ _ _ evaluated27
theorem evaluated28 : candidatesWithin (.integer 28) 7 1 = .ok (some [11,12,13,14,15,16]) := rfl
theorem source28 : CandidateRun (.integer 28) 1 [11,12,13,14,15,16] := candidatesCorrespond _ _ _ _ evaluated28
theorem evaluated29 : candidatesWithin (.integer 29) 7 1 = .ok (some [11,12,13,14,15,16]) := rfl
theorem source29 : CandidateRun (.integer 29) 1 [11,12,13,14,15,16] := candidatesCorrespond _ _ _ _ evaluated29
theorem evaluated30 : candidatesWithin (.integer 30) 7 1 = .ok (some [12,13,14,15,16,17]) := rfl
theorem source30 : CandidateRun (.integer 30) 1 [12,13,14,15,16,17] := candidatesCorrespond _ _ _ _ evaluated30
theorem evaluated31 : candidatesWithin (.integer 31) 7 1 = .ok (some [12,13,14,15,16,17]) := rfl
theorem source31 : CandidateRun (.integer 31) 1 [12,13,14,15,16,17] := candidatesCorrespond _ _ _ _ evaluated31
theorem evaluated32 : candidatesWithin (.integer 32) 7 1 = .ok (some [12,13,14,15,16,17,18]) := rfl
theorem source32 : CandidateRun (.integer 32) 1 [12,13,14,15,16,17,18] := candidatesCorrespond _ _ _ _ evaluated32
theorem evaluated33 : candidatesWithin (.integer 33) 7 1 = .ok (some [13,14,15,16,17,18]) := rfl
theorem source33 : CandidateRun (.integer 33) 1 [13,14,15,16,17,18] := candidatesCorrespond _ _ _ _ evaluated33
theorem evaluated34 : candidatesWithin (.integer 34) 7 1 = .ok (some [13,14,15,16,17,18]) := rfl
theorem source34 : CandidateRun (.integer 34) 1 [13,14,15,16,17,18] := candidatesCorrespond _ _ _ _ evaluated34
theorem evaluated35 : candidatesWithin (.integer 35) 7 1 = .ok (some [14,15,16,17,18,19]) := rfl
theorem source35 : CandidateRun (.integer 35) 1 [14,15,16,17,18,19] := candidatesCorrespond _ _ _ _ evaluated35
theorem evaluated36 : candidatesWithin (.integer 36) 7 1 = .ok (some [14,15,16,17,18,19]) := rfl
theorem source36 : CandidateRun (.integer 36) 1 [14,15,16,17,18,19] := candidatesCorrespond _ _ _ _ evaluated36
theorem evaluated37 : candidatesWithin (.integer 37) 7 1 = .ok (some [15,16,17,18,19,20]) := rfl
theorem source37 : CandidateRun (.integer 37) 1 [15,16,17,18,19,20] := candidatesCorrespond _ _ _ _ evaluated37
theorem evaluated38 : candidatesWithin (.integer 38) 7 1 = .ok (some [15,16,17,18,19,20]) := rfl
theorem source38 : CandidateRun (.integer 38) 1 [15,16,17,18,19,20] := candidatesCorrespond _ _ _ _ evaluated38
theorem evaluated39 : candidatesWithin (.integer 39) 7 1 = .ok (some [15,16,17,18,19,20,21]) := rfl
theorem source39 : CandidateRun (.integer 39) 1 [15,16,17,18,19,20,21] := candidatesCorrespond _ _ _ _ evaluated39
theorem evaluated40 : candidatesWithin (.integer 40) 7 1 = .ok (some [16,17,18,19,20,21]) := rfl
theorem source40 : CandidateRun (.integer 40) 1 [16,17,18,19,20,21] := candidatesCorrespond _ _ _ _ evaluated40
theorem evaluated41 : candidatesWithin (.integer 41) 7 1 = .ok (some [16,17,18,19,20,21]) := rfl
theorem source41 : CandidateRun (.integer 41) 1 [16,17,18,19,20,21] := candidatesCorrespond _ _ _ _ evaluated41
theorem evaluated42 : candidatesWithin (.integer 42) 7 1 = .ok (some [17,18,19,20,21,22]) := rfl
theorem source42 : CandidateRun (.integer 42) 1 [17,18,19,20,21,22] := candidatesCorrespond _ _ _ _ evaluated42
theorem evaluated43 : candidatesWithin (.integer 43) 7 1 = .ok (some [17,18,19,20,21,22]) := rfl
theorem source43 : CandidateRun (.integer 43) 1 [17,18,19,20,21,22] := candidatesCorrespond _ _ _ _ evaluated43
theorem evaluated44 : candidatesWithin (.integer 44) 7 1 = .ok (some [18,19,20,21,22,23]) := rfl
theorem source44 : CandidateRun (.integer 44) 1 [18,19,20,21,22,23] := candidatesCorrespond _ _ _ _ evaluated44
theorem evaluated45 : candidatesWithin (.integer 45) 7 1 = .ok (some [18,19,20,21,22,23]) := rfl
theorem source45 : CandidateRun (.integer 45) 1 [18,19,20,21,22,23] := candidatesCorrespond _ _ _ _ evaluated45
theorem evaluated46 : candidatesWithin (.integer 46) 7 1 = .ok (some [19,20,21,22,23,24]) := rfl
theorem source46 : CandidateRun (.integer 46) 1 [19,20,21,22,23,24] := candidatesCorrespond _ _ _ _ evaluated46
theorem evaluated47 : candidatesWithin (.integer 47) 7 1 = .ok (some [19,20,21,22,23,24]) := rfl
theorem source47 : CandidateRun (.integer 47) 1 [19,20,21,22,23,24] := candidatesCorrespond _ _ _ _ evaluated47
theorem evaluated48 : candidatesWithin (.integer 48) 7 1 = .ok (some [19,20,21,22,23,24,25]) := rfl
theorem source48 : CandidateRun (.integer 48) 1 [19,20,21,22,23,24,25] := candidatesCorrespond _ _ _ _ evaluated48
theorem evaluated49 : candidatesWithin (.integer 49) 7 1 = .ok (some [20,21,22,23,24,25]) := rfl
theorem source49 : CandidateRun (.integer 49) 1 [20,21,22,23,24,25] := candidatesCorrespond _ _ _ _ evaluated49
theorem evaluated50 : candidatesWithin (.integer 50) 7 1 = .ok (some [20,21,22,23,24,25]) := rfl
theorem source50 : CandidateRun (.integer 50) 1 [20,21,22,23,24,25] := candidatesCorrespond _ _ _ _ evaluated50
theorem evaluated51 : candidatesWithin (.integer 51) 7 1 = .ok (some [21,22,23,24,25,26]) := rfl
theorem source51 : CandidateRun (.integer 51) 1 [21,22,23,24,25,26] := candidatesCorrespond _ _ _ _ evaluated51
theorem evaluated52 : candidatesWithin (.integer 52) 7 1 = .ok (some [21,22,23,24,25,26]) := rfl
theorem source52 : CandidateRun (.integer 52) 1 [21,22,23,24,25,26] := candidatesCorrespond _ _ _ _ evaluated52
theorem evaluated53 : candidatesWithin (.integer 53) 7 1 = .ok (some [22,23,24,25,26,27]) := rfl
theorem source53 : CandidateRun (.integer 53) 1 [22,23,24,25,26,27] := candidatesCorrespond _ _ _ _ evaluated53
theorem evaluated54 : candidatesWithin (.integer 54) 7 1 = .ok (some [22,23,24,25,26,27]) := rfl
theorem source54 : CandidateRun (.integer 54) 1 [22,23,24,25,26,27] := candidatesCorrespond _ _ _ _ evaluated54
theorem evaluated55 : candidatesWithin (.integer 55) 7 1 = .ok (some [22,23,24,25,26,27,28]) := rfl
theorem source55 : CandidateRun (.integer 55) 1 [22,23,24,25,26,27,28] := candidatesCorrespond _ _ _ _ evaluated55
theorem evaluated56 : candidatesWithin (.integer 56) 7 1 = .ok (some [23,24,25,26,27,28]) := rfl
theorem source56 : CandidateRun (.integer 56) 1 [23,24,25,26,27,28] := candidatesCorrespond _ _ _ _ evaluated56
theorem evaluated57 : candidatesWithin (.integer 57) 7 1 = .ok (some [23,24,25,26,27,28]) := rfl
theorem source57 : CandidateRun (.integer 57) 1 [23,24,25,26,27,28] := candidatesCorrespond _ _ _ _ evaluated57
theorem evaluated58 : candidatesWithin (.integer 58) 7 1 = .ok (some [24,25,26,27,28,29]) := rfl
theorem source58 : CandidateRun (.integer 58) 1 [24,25,26,27,28,29] := candidatesCorrespond _ _ _ _ evaluated58
theorem evaluated59 : candidatesWithin (.integer 59) 7 1 = .ok (some [24,25,26,27,28,29]) := rfl
theorem source59 : CandidateRun (.integer 59) 1 [24,25,26,27,28,29] := candidatesCorrespond _ _ _ _ evaluated59
theorem evaluated60 : candidatesWithin (.integer 60) 7 1 = .ok (some [24,25,26,27,28,29,30]) := rfl
theorem source60 : CandidateRun (.integer 60) 1 [24,25,26,27,28,29,30] := candidatesCorrespond _ _ _ _ evaluated60
theorem evaluated61 : candidatesWithin (.integer 61) 7 1 = .ok (some [25,26,27,28,29,30]) := rfl
theorem source61 : CandidateRun (.integer 61) 1 [25,26,27,28,29,30] := candidatesCorrespond _ _ _ _ evaluated61
theorem evaluated62 : candidatesWithin (.integer 62) 7 1 = .ok (some [25,26,27,28,29,30]) := rfl
theorem source62 : CandidateRun (.integer 62) 1 [25,26,27,28,29,30] := candidatesCorrespond _ _ _ _ evaluated62
theorem evaluated63 : candidatesWithin (.integer 63) 7 1 = .ok (some [26,27,28,29,30,31]) := rfl
theorem source63 : CandidateRun (.integer 63) 1 [26,27,28,29,30,31] := candidatesCorrespond _ _ _ _ evaluated63
theorem evaluated64 : candidatesWithin (.integer 64) 7 1 = .ok (some [26,27,28,29,30,31]) := rfl
theorem source64 : CandidateRun (.integer 64) 1 [26,27,28,29,30,31] := candidatesCorrespond _ _ _ _ evaluated64
theorem evaluated65 : candidatesWithin (.integer 65) 7 1 = .ok (some [27,28,29,30,31,32]) := rfl
theorem source65 : CandidateRun (.integer 65) 1 [27,28,29,30,31,32] := candidatesCorrespond _ _ _ _ evaluated65
end SFT.Physics.NuclearBindingCensusBatch00
