import SFT.Mathematics.ExactTraceArithmetic
import SFT.Mathematics.PrimePairDerivation
import SFT.Mathematics.CollatzBlock0
import SFT.Mathematics.CollatzBlock1
import SFT.Mathematics.CollatzBlock2
import SFT.Mathematics.CollatzBlock3
import SFT.Mathematics.CollatzBlock4
import SFT.Mathematics.CollatzBlock5
import SFT.Mathematics.CollatzBlock6
import SFT.Mathematics.CollatzBlock7
import SFT.Mathematics.CollatzBlock8
import SFT.Mathematics.CollatzBlock9
import SFT.Mathematics.CollatzBlock10
import SFT.Mathematics.CollatzBlock11
import SFT.Mathematics.CollatzBlock12
import SFT.Mathematics.CollatzBlock13
import SFT.Mathematics.CollatzBlock14
import SFT.Mathematics.CollatzBlock15
import SFT.Mathematics.CollatzBlock16
import SFT.Mathematics.CollatzBlock17
import SFT.Mathematics.CollatzBlock18
import SFT.Mathematics.CollatzBlock19
import SFT.Mathematics.CollatzBlock20
import SFT.Mathematics.CollatzBlock21
import SFT.Mathematics.CollatzBlock22
import SFT.Mathematics.CollatzBlock23
import SFT.Mathematics.CollatzBlock24
import SFT.Mathematics.CollatzBlock25
import SFT.Mathematics.CollatzBlock26
import SFT.Mathematics.CollatzBlock27
import SFT.Mathematics.CollatzBlock28
import SFT.Mathematics.CollatzBlock29
import SFT.Mathematics.CollatzBlock30
import SFT.Mathematics.CollatzBlock31
import SFT.Mathematics.CollatzBlock32
import SFT.Mathematics.CollatzBlock33
import SFT.Mathematics.CollatzBlock34
import SFT.Mathematics.CollatzBlock35
import SFT.Mathematics.CollatzBlock36
import SFT.Mathematics.CollatzBlock37
import SFT.Mathematics.CollatzBlock38
import SFT.Mathematics.CollatzBlock39
import SFT.Mathematics.CollatzBlock40
import SFT.Mathematics.CollatzBlock41
import SFT.Mathematics.CollatzBlock42
import SFT.Mathematics.CollatzBlock43
import SFT.Mathematics.CollatzBlock44
import SFT.Mathematics.CollatzBlock45
import SFT.Mathematics.CollatzBlock46
import SFT.Mathematics.CollatzBlock47
import SFT.Mathematics.CollatzBlock48
import SFT.Mathematics.CollatzBlock49
import SFT.Mathematics.CollatzBlock50
import SFT.Mathematics.CollatzBlock51
import SFT.Mathematics.CollatzBlock52
import SFT.Mathematics.CollatzBlock53
import SFT.Mathematics.CollatzBlock54
import SFT.Mathematics.CollatzBlock55
import SFT.Mathematics.CollatzBlock56
import SFT.Mathematics.CollatzBlock57
import SFT.Mathematics.CollatzBlock58
import SFT.Mathematics.CollatzBlock59
import SFT.Mathematics.CollatzBlock60
import SFT.Mathematics.CollatzBlock61
import SFT.Mathematics.CollatzBlock62
import SFT.Mathematics.CollatzBlock63
import SFT.Mathematics.CollatzBlock64
import SFT.Mathematics.CollatzBlock65
import SFT.Mathematics.CollatzBlock66
import SFT.Mathematics.CollatzBlock67
import SFT.Mathematics.CollatzBlock68
import SFT.Mathematics.CollatzBlock69
import SFT.Mathematics.CollatzBlock70
import SFT.Mathematics.CollatzBlock71
import SFT.Mathematics.CollatzBlock72
import SFT.Mathematics.CollatzBlock73
import SFT.Mathematics.CollatzBlock74
import SFT.Mathematics.CollatzBlock75
import SFT.Mathematics.CollatzBlock76
import SFT.Mathematics.CollatzBlock77
import SFT.Mathematics.CollatzBlock78
import SFT.Mathematics.CollatzBlock79
import SFT.Mathematics.CollatzBlock80
import SFT.Mathematics.CollatzBlock81
import SFT.Mathematics.CollatzBlock82
import SFT.Mathematics.CollatzBlock83
import SFT.Mathematics.CollatzBlock84
import SFT.Mathematics.CollatzBlock85
import SFT.Mathematics.CollatzBlock86
import SFT.Mathematics.CollatzBlock87
import SFT.Mathematics.CollatzBlock88
import SFT.Mathematics.CollatzBlock89
import SFT.Mathematics.CollatzBlock90
import SFT.Mathematics.CollatzBlock91
import SFT.Mathematics.CollatzBlock92
import SFT.Mathematics.CollatzBlock93
import SFT.Mathematics.CollatzBlock94
import SFT.Mathematics.CollatzBlock95
import SFT.Mathematics.CollatzBlock96
import SFT.Mathematics.CollatzBlock97
import SFT.Mathematics.CollatzBlock98
import SFT.Mathematics.CollatzBlock99
namespace SFT.Mathematics.CollatzCensus
set_option maxRecDepth 500000
set_option maxHeartbeats 100000000
def completeCensus := censusBlock0 ++ censusBlock1 ++ censusBlock2 ++ censusBlock3 ++ censusBlock4 ++ censusBlock5 ++ censusBlock6 ++ censusBlock7 ++ censusBlock8 ++ censusBlock9 ++ censusBlock10 ++ censusBlock11 ++ censusBlock12 ++ censusBlock13 ++ censusBlock14 ++ censusBlock15 ++ censusBlock16 ++ censusBlock17 ++ censusBlock18 ++ censusBlock19 ++ censusBlock20 ++ censusBlock21 ++ censusBlock22 ++ censusBlock23 ++ censusBlock24 ++ censusBlock25 ++ censusBlock26 ++ censusBlock27 ++ censusBlock28 ++ censusBlock29 ++ censusBlock30 ++ censusBlock31 ++ censusBlock32 ++ censusBlock33 ++ censusBlock34 ++ censusBlock35 ++ censusBlock36 ++ censusBlock37 ++ censusBlock38 ++ censusBlock39 ++ censusBlock40 ++ censusBlock41 ++ censusBlock42 ++ censusBlock43 ++ censusBlock44 ++ censusBlock45 ++ censusBlock46 ++ censusBlock47 ++ censusBlock48 ++ censusBlock49 ++ censusBlock50 ++ censusBlock51 ++ censusBlock52 ++ censusBlock53 ++ censusBlock54 ++ censusBlock55 ++ censusBlock56 ++ censusBlock57 ++ censusBlock58 ++ censusBlock59 ++ censusBlock60 ++ censusBlock61 ++ censusBlock62 ++ censusBlock63 ++ censusBlock64 ++ censusBlock65 ++ censusBlock66 ++ censusBlock67 ++ censusBlock68 ++ censusBlock69 ++ censusBlock70 ++ censusBlock71 ++ censusBlock72 ++ censusBlock73 ++ censusBlock74 ++ censusBlock75 ++ censusBlock76 ++ censusBlock77 ++ censusBlock78 ++ censusBlock79 ++ censusBlock80 ++ censusBlock81 ++ censusBlock82 ++ censusBlock83 ++ censusBlock84 ++ censusBlock85 ++ censusBlock86 ++ censusBlock87 ++ censusBlock88 ++ censusBlock89 ++ censusBlock90 ++ censusBlock91 ++ censusBlock92 ++ censusBlock93 ++ censusBlock94 ++ censusBlock95 ++ censusBlock96 ++ censusBlock97 ++ censusBlock98 ++ censusBlock99
theorem completeCensusPassed : completeCensus.all (fun row => row.2.isSome)=true := by
 unfold completeCensus
 rw [PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend,PrimePairDerivation.allAppend]
 rw [block0,block1,block2,block3,block4,block5,block6,block7,block8,block9,block10,block11,block12,block13,block14,block15,block16,block17,block18,block19,block20,block21,block22,block23,block24,block25,block26,block27,block28,block29,block30,block31,block32,block33,block34,block35,block36,block37,block38,block39,block40,block41,block42,block43,block44,block45,block46,block47,block48,block49,block50,block51,block52,block53,block54,block55,block56,block57,block58,block59,block60,block61,block62,block63,block64,block65,block66,block67,block68,block69,block70,block71,block72,block73,block74,block75,block76,block77,block78,block79,block80,block81,block82,block83,block84,block85,block86,block87,block88,block89,block90,block91,block92,block93,block94,block95,block96,block97,block98,block99]
 rfl
theorem inputProjection (offset : Nat) (xs : List Nat) :
 (xs.map (fun j => (offset+j+1,stepsWithin (offset+j+1) 350))).map Prod.fst = xs.map (fun j => offset+j+1) := by
 induction xs with
 | nil => rfl
 | cons x xs ih => exact congrArg (List.cons (offset+x+1)) ih

theorem rangeJoin (start count rest : Nat) :
 List.range' start (count+rest) = List.range' start count ++ List.range' (start+count) rest := by
 induction count generalizing start with
 | zero => rw [Nat.zero_add]; rfl
 | succ n ih =>
   rw [Nat.succ_add]
   change start :: List.range' (start+1) (n+rest) = start :: (List.range' (start+1) n ++ List.range' (start+(n+1)) rest)
   rw [ih]
   have eq : start+1+n=start+(n+1) := by rw [Nat.add_assoc,Nat.add_comm 1 n]
   rw [eq]

theorem rangeMap (start count : Nat) :
 (List.range' start count).map (fun i => i+1)=List.range' (start+1) count := by
 induction count generalizing start with
 | zero => rfl
 | succ n ih => exact congrArg (List.cons (start+1)) (ih (start+1))

theorem rangeLength (start count : Nat) : (List.range' start count).length=count := by
 induction count generalizing start with
 | zero => rfl
 | succ n ih => exact congrArg Nat.succ (ih (start+1))
theorem blockInputs0 : censusBlock0.map Prod.fst=List.range' 1 1000 := by
 unfold censusBlock0
 rw [inputProjection]
 decide
theorem blockInputs1 : censusBlock1.map Prod.fst=List.range' 1001 1000 := by
 unfold censusBlock1
 rw [inputProjection]
 decide
theorem blockInputs2 : censusBlock2.map Prod.fst=List.range' 2001 1000 := by
 unfold censusBlock2
 rw [inputProjection]
 decide
theorem blockInputs3 : censusBlock3.map Prod.fst=List.range' 3001 1000 := by
 unfold censusBlock3
 rw [inputProjection]
 decide
theorem blockInputs4 : censusBlock4.map Prod.fst=List.range' 4001 1000 := by
 unfold censusBlock4
 rw [inputProjection]
 decide
theorem blockInputs5 : censusBlock5.map Prod.fst=List.range' 5001 1000 := by
 unfold censusBlock5
 rw [inputProjection]
 decide
theorem blockInputs6 : censusBlock6.map Prod.fst=List.range' 6001 1000 := by
 unfold censusBlock6
 rw [inputProjection]
 decide
theorem blockInputs7 : censusBlock7.map Prod.fst=List.range' 7001 1000 := by
 unfold censusBlock7
 rw [inputProjection]
 decide
theorem blockInputs8 : censusBlock8.map Prod.fst=List.range' 8001 1000 := by
 unfold censusBlock8
 rw [inputProjection]
 decide
theorem blockInputs9 : censusBlock9.map Prod.fst=List.range' 9001 1000 := by
 unfold censusBlock9
 rw [inputProjection]
 decide
theorem blockInputs10 : censusBlock10.map Prod.fst=List.range' 10001 1000 := by
 unfold censusBlock10
 rw [inputProjection]
 decide
theorem blockInputs11 : censusBlock11.map Prod.fst=List.range' 11001 1000 := by
 unfold censusBlock11
 rw [inputProjection]
 decide
theorem blockInputs12 : censusBlock12.map Prod.fst=List.range' 12001 1000 := by
 unfold censusBlock12
 rw [inputProjection]
 decide
theorem blockInputs13 : censusBlock13.map Prod.fst=List.range' 13001 1000 := by
 unfold censusBlock13
 rw [inputProjection]
 decide
theorem blockInputs14 : censusBlock14.map Prod.fst=List.range' 14001 1000 := by
 unfold censusBlock14
 rw [inputProjection]
 decide
theorem blockInputs15 : censusBlock15.map Prod.fst=List.range' 15001 1000 := by
 unfold censusBlock15
 rw [inputProjection]
 decide
theorem blockInputs16 : censusBlock16.map Prod.fst=List.range' 16001 1000 := by
 unfold censusBlock16
 rw [inputProjection]
 decide
theorem blockInputs17 : censusBlock17.map Prod.fst=List.range' 17001 1000 := by
 unfold censusBlock17
 rw [inputProjection]
 decide
theorem blockInputs18 : censusBlock18.map Prod.fst=List.range' 18001 1000 := by
 unfold censusBlock18
 rw [inputProjection]
 decide
theorem blockInputs19 : censusBlock19.map Prod.fst=List.range' 19001 1000 := by
 unfold censusBlock19
 rw [inputProjection]
 decide
theorem blockInputs20 : censusBlock20.map Prod.fst=List.range' 20001 1000 := by
 unfold censusBlock20
 rw [inputProjection]
 decide
theorem blockInputs21 : censusBlock21.map Prod.fst=List.range' 21001 1000 := by
 unfold censusBlock21
 rw [inputProjection]
 decide
theorem blockInputs22 : censusBlock22.map Prod.fst=List.range' 22001 1000 := by
 unfold censusBlock22
 rw [inputProjection]
 decide
theorem blockInputs23 : censusBlock23.map Prod.fst=List.range' 23001 1000 := by
 unfold censusBlock23
 rw [inputProjection]
 decide
theorem blockInputs24 : censusBlock24.map Prod.fst=List.range' 24001 1000 := by
 unfold censusBlock24
 rw [inputProjection]
 decide
theorem blockInputs25 : censusBlock25.map Prod.fst=List.range' 25001 1000 := by
 unfold censusBlock25
 rw [inputProjection]
 decide
theorem blockInputs26 : censusBlock26.map Prod.fst=List.range' 26001 1000 := by
 unfold censusBlock26
 rw [inputProjection]
 decide
theorem blockInputs27 : censusBlock27.map Prod.fst=List.range' 27001 1000 := by
 unfold censusBlock27
 rw [inputProjection]
 decide
theorem blockInputs28 : censusBlock28.map Prod.fst=List.range' 28001 1000 := by
 unfold censusBlock28
 rw [inputProjection]
 decide
theorem blockInputs29 : censusBlock29.map Prod.fst=List.range' 29001 1000 := by
 unfold censusBlock29
 rw [inputProjection]
 decide
theorem blockInputs30 : censusBlock30.map Prod.fst=List.range' 30001 1000 := by
 unfold censusBlock30
 rw [inputProjection]
 decide
theorem blockInputs31 : censusBlock31.map Prod.fst=List.range' 31001 1000 := by
 unfold censusBlock31
 rw [inputProjection]
 decide
theorem blockInputs32 : censusBlock32.map Prod.fst=List.range' 32001 1000 := by
 unfold censusBlock32
 rw [inputProjection]
 decide
theorem blockInputs33 : censusBlock33.map Prod.fst=List.range' 33001 1000 := by
 unfold censusBlock33
 rw [inputProjection]
 decide
theorem blockInputs34 : censusBlock34.map Prod.fst=List.range' 34001 1000 := by
 unfold censusBlock34
 rw [inputProjection]
 decide
theorem blockInputs35 : censusBlock35.map Prod.fst=List.range' 35001 1000 := by
 unfold censusBlock35
 rw [inputProjection]
 decide
theorem blockInputs36 : censusBlock36.map Prod.fst=List.range' 36001 1000 := by
 unfold censusBlock36
 rw [inputProjection]
 decide
theorem blockInputs37 : censusBlock37.map Prod.fst=List.range' 37001 1000 := by
 unfold censusBlock37
 rw [inputProjection]
 decide
theorem blockInputs38 : censusBlock38.map Prod.fst=List.range' 38001 1000 := by
 unfold censusBlock38
 rw [inputProjection]
 decide
theorem blockInputs39 : censusBlock39.map Prod.fst=List.range' 39001 1000 := by
 unfold censusBlock39
 rw [inputProjection]
 decide
theorem blockInputs40 : censusBlock40.map Prod.fst=List.range' 40001 1000 := by
 unfold censusBlock40
 rw [inputProjection]
 decide
theorem blockInputs41 : censusBlock41.map Prod.fst=List.range' 41001 1000 := by
 unfold censusBlock41
 rw [inputProjection]
 decide
theorem blockInputs42 : censusBlock42.map Prod.fst=List.range' 42001 1000 := by
 unfold censusBlock42
 rw [inputProjection]
 decide
theorem blockInputs43 : censusBlock43.map Prod.fst=List.range' 43001 1000 := by
 unfold censusBlock43
 rw [inputProjection]
 decide
theorem blockInputs44 : censusBlock44.map Prod.fst=List.range' 44001 1000 := by
 unfold censusBlock44
 rw [inputProjection]
 decide
theorem blockInputs45 : censusBlock45.map Prod.fst=List.range' 45001 1000 := by
 unfold censusBlock45
 rw [inputProjection]
 decide
theorem blockInputs46 : censusBlock46.map Prod.fst=List.range' 46001 1000 := by
 unfold censusBlock46
 rw [inputProjection]
 decide
theorem blockInputs47 : censusBlock47.map Prod.fst=List.range' 47001 1000 := by
 unfold censusBlock47
 rw [inputProjection]
 decide
theorem blockInputs48 : censusBlock48.map Prod.fst=List.range' 48001 1000 := by
 unfold censusBlock48
 rw [inputProjection]
 decide
theorem blockInputs49 : censusBlock49.map Prod.fst=List.range' 49001 1000 := by
 unfold censusBlock49
 rw [inputProjection]
 decide
theorem blockInputs50 : censusBlock50.map Prod.fst=List.range' 50001 1000 := by
 unfold censusBlock50
 rw [inputProjection]
 decide
theorem blockInputs51 : censusBlock51.map Prod.fst=List.range' 51001 1000 := by
 unfold censusBlock51
 rw [inputProjection]
 decide
theorem blockInputs52 : censusBlock52.map Prod.fst=List.range' 52001 1000 := by
 unfold censusBlock52
 rw [inputProjection]
 decide
theorem blockInputs53 : censusBlock53.map Prod.fst=List.range' 53001 1000 := by
 unfold censusBlock53
 rw [inputProjection]
 decide
theorem blockInputs54 : censusBlock54.map Prod.fst=List.range' 54001 1000 := by
 unfold censusBlock54
 rw [inputProjection]
 decide
theorem blockInputs55 : censusBlock55.map Prod.fst=List.range' 55001 1000 := by
 unfold censusBlock55
 rw [inputProjection]
 decide
theorem blockInputs56 : censusBlock56.map Prod.fst=List.range' 56001 1000 := by
 unfold censusBlock56
 rw [inputProjection]
 decide
theorem blockInputs57 : censusBlock57.map Prod.fst=List.range' 57001 1000 := by
 unfold censusBlock57
 rw [inputProjection]
 decide
theorem blockInputs58 : censusBlock58.map Prod.fst=List.range' 58001 1000 := by
 unfold censusBlock58
 rw [inputProjection]
 decide
theorem blockInputs59 : censusBlock59.map Prod.fst=List.range' 59001 1000 := by
 unfold censusBlock59
 rw [inputProjection]
 decide
theorem blockInputs60 : censusBlock60.map Prod.fst=List.range' 60001 1000 := by
 unfold censusBlock60
 rw [inputProjection]
 decide
theorem blockInputs61 : censusBlock61.map Prod.fst=List.range' 61001 1000 := by
 unfold censusBlock61
 rw [inputProjection]
 decide
theorem blockInputs62 : censusBlock62.map Prod.fst=List.range' 62001 1000 := by
 unfold censusBlock62
 rw [inputProjection]
 decide
theorem blockInputs63 : censusBlock63.map Prod.fst=List.range' 63001 1000 := by
 unfold censusBlock63
 rw [inputProjection]
 decide
theorem blockInputs64 : censusBlock64.map Prod.fst=List.range' 64001 1000 := by
 unfold censusBlock64
 rw [inputProjection]
 decide
theorem blockInputs65 : censusBlock65.map Prod.fst=List.range' 65001 1000 := by
 unfold censusBlock65
 rw [inputProjection]
 decide
theorem blockInputs66 : censusBlock66.map Prod.fst=List.range' 66001 1000 := by
 unfold censusBlock66
 rw [inputProjection]
 decide
theorem blockInputs67 : censusBlock67.map Prod.fst=List.range' 67001 1000 := by
 unfold censusBlock67
 rw [inputProjection]
 decide
theorem blockInputs68 : censusBlock68.map Prod.fst=List.range' 68001 1000 := by
 unfold censusBlock68
 rw [inputProjection]
 decide
theorem blockInputs69 : censusBlock69.map Prod.fst=List.range' 69001 1000 := by
 unfold censusBlock69
 rw [inputProjection]
 decide
theorem blockInputs70 : censusBlock70.map Prod.fst=List.range' 70001 1000 := by
 unfold censusBlock70
 rw [inputProjection]
 decide
theorem blockInputs71 : censusBlock71.map Prod.fst=List.range' 71001 1000 := by
 unfold censusBlock71
 rw [inputProjection]
 decide
theorem blockInputs72 : censusBlock72.map Prod.fst=List.range' 72001 1000 := by
 unfold censusBlock72
 rw [inputProjection]
 decide
theorem blockInputs73 : censusBlock73.map Prod.fst=List.range' 73001 1000 := by
 unfold censusBlock73
 rw [inputProjection]
 decide
theorem blockInputs74 : censusBlock74.map Prod.fst=List.range' 74001 1000 := by
 unfold censusBlock74
 rw [inputProjection]
 decide
theorem blockInputs75 : censusBlock75.map Prod.fst=List.range' 75001 1000 := by
 unfold censusBlock75
 rw [inputProjection]
 decide
theorem blockInputs76 : censusBlock76.map Prod.fst=List.range' 76001 1000 := by
 unfold censusBlock76
 rw [inputProjection]
 decide
theorem blockInputs77 : censusBlock77.map Prod.fst=List.range' 77001 1000 := by
 unfold censusBlock77
 rw [inputProjection]
 decide
theorem blockInputs78 : censusBlock78.map Prod.fst=List.range' 78001 1000 := by
 unfold censusBlock78
 rw [inputProjection]
 decide
theorem blockInputs79 : censusBlock79.map Prod.fst=List.range' 79001 1000 := by
 unfold censusBlock79
 rw [inputProjection]
 decide
theorem blockInputs80 : censusBlock80.map Prod.fst=List.range' 80001 1000 := by
 unfold censusBlock80
 rw [inputProjection]
 decide
theorem blockInputs81 : censusBlock81.map Prod.fst=List.range' 81001 1000 := by
 unfold censusBlock81
 rw [inputProjection]
 decide
theorem blockInputs82 : censusBlock82.map Prod.fst=List.range' 82001 1000 := by
 unfold censusBlock82
 rw [inputProjection]
 decide
theorem blockInputs83 : censusBlock83.map Prod.fst=List.range' 83001 1000 := by
 unfold censusBlock83
 rw [inputProjection]
 decide
theorem blockInputs84 : censusBlock84.map Prod.fst=List.range' 84001 1000 := by
 unfold censusBlock84
 rw [inputProjection]
 decide
theorem blockInputs85 : censusBlock85.map Prod.fst=List.range' 85001 1000 := by
 unfold censusBlock85
 rw [inputProjection]
 decide
theorem blockInputs86 : censusBlock86.map Prod.fst=List.range' 86001 1000 := by
 unfold censusBlock86
 rw [inputProjection]
 decide
theorem blockInputs87 : censusBlock87.map Prod.fst=List.range' 87001 1000 := by
 unfold censusBlock87
 rw [inputProjection]
 decide
theorem blockInputs88 : censusBlock88.map Prod.fst=List.range' 88001 1000 := by
 unfold censusBlock88
 rw [inputProjection]
 decide
theorem blockInputs89 : censusBlock89.map Prod.fst=List.range' 89001 1000 := by
 unfold censusBlock89
 rw [inputProjection]
 decide
theorem blockInputs90 : censusBlock90.map Prod.fst=List.range' 90001 1000 := by
 unfold censusBlock90
 rw [inputProjection]
 decide
theorem blockInputs91 : censusBlock91.map Prod.fst=List.range' 91001 1000 := by
 unfold censusBlock91
 rw [inputProjection]
 decide
theorem blockInputs92 : censusBlock92.map Prod.fst=List.range' 92001 1000 := by
 unfold censusBlock92
 rw [inputProjection]
 decide
theorem blockInputs93 : censusBlock93.map Prod.fst=List.range' 93001 1000 := by
 unfold censusBlock93
 rw [inputProjection]
 decide
theorem blockInputs94 : censusBlock94.map Prod.fst=List.range' 94001 1000 := by
 unfold censusBlock94
 rw [inputProjection]
 decide
theorem blockInputs95 : censusBlock95.map Prod.fst=List.range' 95001 1000 := by
 unfold censusBlock95
 rw [inputProjection]
 decide
theorem blockInputs96 : censusBlock96.map Prod.fst=List.range' 96001 1000 := by
 unfold censusBlock96
 rw [inputProjection]
 decide
theorem blockInputs97 : censusBlock97.map Prod.fst=List.range' 97001 1000 := by
 unfold censusBlock97
 rw [inputProjection]
 decide
theorem blockInputs98 : censusBlock98.map Prod.fst=List.range' 98001 1000 := by
 unfold censusBlock98
 rw [inputProjection]
 decide
theorem blockInputs99 : censusBlock99.map Prod.fst=List.range' 99001 1000 := by
 unfold censusBlock99
 rw [inputProjection]
 decide
theorem completeCensusInputs : completeCensus.map Prod.fst=(List.range 100000).map (fun i => i+1) := by
 rw [List.range_eq_range',rangeMap]
 unfold completeCensus
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rw [blockInputs0,blockInputs1,blockInputs2,blockInputs3,blockInputs4,blockInputs5,blockInputs6,blockInputs7,blockInputs8,blockInputs9,blockInputs10,blockInputs11,blockInputs12,blockInputs13,blockInputs14,blockInputs15,blockInputs16,blockInputs17,blockInputs18,blockInputs19,blockInputs20,blockInputs21,blockInputs22,blockInputs23,blockInputs24,blockInputs25,blockInputs26,blockInputs27,blockInputs28,blockInputs29,blockInputs30,blockInputs31,blockInputs32,blockInputs33,blockInputs34,blockInputs35,blockInputs36,blockInputs37,blockInputs38,blockInputs39,blockInputs40,blockInputs41,blockInputs42,blockInputs43,blockInputs44,blockInputs45,blockInputs46,blockInputs47,blockInputs48,blockInputs49,blockInputs50,blockInputs51,blockInputs52,blockInputs53,blockInputs54,blockInputs55,blockInputs56,blockInputs57,blockInputs58,blockInputs59,blockInputs60,blockInputs61,blockInputs62,blockInputs63,blockInputs64,blockInputs65,blockInputs66,blockInputs67,blockInputs68,blockInputs69,blockInputs70,blockInputs71,blockInputs72,blockInputs73,blockInputs74,blockInputs75,blockInputs76,blockInputs77,blockInputs78,blockInputs79,blockInputs80,blockInputs81,blockInputs82,blockInputs83,blockInputs84,blockInputs85,blockInputs86,blockInputs87,blockInputs88,blockInputs89,blockInputs90,blockInputs91,blockInputs92,blockInputs93,blockInputs94,blockInputs95,blockInputs96,blockInputs97,blockInputs98,blockInputs99]
 rw [← rangeJoin 1 1000 1000]
 rw [← rangeJoin 1 2000 1000]
 rw [← rangeJoin 1 3000 1000]
 rw [← rangeJoin 1 4000 1000]
 rw [← rangeJoin 1 5000 1000]
 rw [← rangeJoin 1 6000 1000]
 rw [← rangeJoin 1 7000 1000]
 rw [← rangeJoin 1 8000 1000]
 rw [← rangeJoin 1 9000 1000]
 rw [← rangeJoin 1 10000 1000]
 rw [← rangeJoin 1 11000 1000]
 rw [← rangeJoin 1 12000 1000]
 rw [← rangeJoin 1 13000 1000]
 rw [← rangeJoin 1 14000 1000]
 rw [← rangeJoin 1 15000 1000]
 rw [← rangeJoin 1 16000 1000]
 rw [← rangeJoin 1 17000 1000]
 rw [← rangeJoin 1 18000 1000]
 rw [← rangeJoin 1 19000 1000]
 rw [← rangeJoin 1 20000 1000]
 rw [← rangeJoin 1 21000 1000]
 rw [← rangeJoin 1 22000 1000]
 rw [← rangeJoin 1 23000 1000]
 rw [← rangeJoin 1 24000 1000]
 rw [← rangeJoin 1 25000 1000]
 rw [← rangeJoin 1 26000 1000]
 rw [← rangeJoin 1 27000 1000]
 rw [← rangeJoin 1 28000 1000]
 rw [← rangeJoin 1 29000 1000]
 rw [← rangeJoin 1 30000 1000]
 rw [← rangeJoin 1 31000 1000]
 rw [← rangeJoin 1 32000 1000]
 rw [← rangeJoin 1 33000 1000]
 rw [← rangeJoin 1 34000 1000]
 rw [← rangeJoin 1 35000 1000]
 rw [← rangeJoin 1 36000 1000]
 rw [← rangeJoin 1 37000 1000]
 rw [← rangeJoin 1 38000 1000]
 rw [← rangeJoin 1 39000 1000]
 rw [← rangeJoin 1 40000 1000]
 rw [← rangeJoin 1 41000 1000]
 rw [← rangeJoin 1 42000 1000]
 rw [← rangeJoin 1 43000 1000]
 rw [← rangeJoin 1 44000 1000]
 rw [← rangeJoin 1 45000 1000]
 rw [← rangeJoin 1 46000 1000]
 rw [← rangeJoin 1 47000 1000]
 rw [← rangeJoin 1 48000 1000]
 rw [← rangeJoin 1 49000 1000]
 rw [← rangeJoin 1 50000 1000]
 rw [← rangeJoin 1 51000 1000]
 rw [← rangeJoin 1 52000 1000]
 rw [← rangeJoin 1 53000 1000]
 rw [← rangeJoin 1 54000 1000]
 rw [← rangeJoin 1 55000 1000]
 rw [← rangeJoin 1 56000 1000]
 rw [← rangeJoin 1 57000 1000]
 rw [← rangeJoin 1 58000 1000]
 rw [← rangeJoin 1 59000 1000]
 rw [← rangeJoin 1 60000 1000]
 rw [← rangeJoin 1 61000 1000]
 rw [← rangeJoin 1 62000 1000]
 rw [← rangeJoin 1 63000 1000]
 rw [← rangeJoin 1 64000 1000]
 rw [← rangeJoin 1 65000 1000]
 rw [← rangeJoin 1 66000 1000]
 rw [← rangeJoin 1 67000 1000]
 rw [← rangeJoin 1 68000 1000]
 rw [← rangeJoin 1 69000 1000]
 rw [← rangeJoin 1 70000 1000]
 rw [← rangeJoin 1 71000 1000]
 rw [← rangeJoin 1 72000 1000]
 rw [← rangeJoin 1 73000 1000]
 rw [← rangeJoin 1 74000 1000]
 rw [← rangeJoin 1 75000 1000]
 rw [← rangeJoin 1 76000 1000]
 rw [← rangeJoin 1 77000 1000]
 rw [← rangeJoin 1 78000 1000]
 rw [← rangeJoin 1 79000 1000]
 rw [← rangeJoin 1 80000 1000]
 rw [← rangeJoin 1 81000 1000]
 rw [← rangeJoin 1 82000 1000]
 rw [← rangeJoin 1 83000 1000]
 rw [← rangeJoin 1 84000 1000]
 rw [← rangeJoin 1 85000 1000]
 rw [← rangeJoin 1 86000 1000]
 rw [← rangeJoin 1 87000 1000]
 rw [← rangeJoin 1 88000 1000]
 rw [← rangeJoin 1 89000 1000]
 rw [← rangeJoin 1 90000 1000]
 rw [← rangeJoin 1 91000 1000]
 rw [← rangeJoin 1 92000 1000]
 rw [← rangeJoin 1 93000 1000]
 rw [← rangeJoin 1 94000 1000]
 rw [← rangeJoin 1 95000 1000]
 rw [← rangeJoin 1 96000 1000]
 rw [← rangeJoin 1 97000 1000]
 rw [← rangeJoin 1 98000 1000]
 rw [← rangeJoin 1 99000 1000]
theorem completeCensusCount : completeCensus.length=100000 := by
 have h := congrArg List.length completeCensusInputs
 rw [SFT.Foundation.CommonRefinement.mapLength,SFT.Foundation.CommonRefinement.mapLength,List.range_eq_range',rangeLength] at h
 exact h
end SFT.Mathematics.CollatzCensus
