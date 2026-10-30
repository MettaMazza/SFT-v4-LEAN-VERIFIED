import SFT.Physics.CapabilityLiterals
set_option maxRecDepth 1000000
set_option maxHeartbeats 10000000
open SFT.Physics.CapabilityLiterals SFT.Physics.CapabilityValues
def literalResult : Except String PositiveCount → String | .ok n => String.ofList (Nat.toDigits 10 n.value) | .error e => e
example : decimalDigit (Char.ofNat 0) = none := by decide
example : decimalDigit (Char.ofNat 1) = none := by decide
example : decimalDigit (Char.ofNat 2) = none := by decide
example : decimalDigit (Char.ofNat 3) = none := by decide
example : decimalDigit (Char.ofNat 4) = none := by decide
example : decimalDigit (Char.ofNat 5) = none := by decide
example : decimalDigit (Char.ofNat 6) = none := by decide
example : decimalDigit (Char.ofNat 7) = none := by decide
example : decimalDigit (Char.ofNat 8) = none := by decide
example : decimalDigit (Char.ofNat 9) = none := by decide
example : decimalDigit (Char.ofNat 10) = none := by decide
example : decimalDigit (Char.ofNat 11) = none := by decide
example : decimalDigit (Char.ofNat 12) = none := by decide
example : decimalDigit (Char.ofNat 13) = none := by decide
example : decimalDigit (Char.ofNat 14) = none := by decide
example : decimalDigit (Char.ofNat 15) = none := by decide
example : decimalDigit (Char.ofNat 16) = none := by decide
example : decimalDigit (Char.ofNat 17) = none := by decide
example : decimalDigit (Char.ofNat 18) = none := by decide
example : decimalDigit (Char.ofNat 19) = none := by decide
example : decimalDigit (Char.ofNat 20) = none := by decide
example : decimalDigit (Char.ofNat 21) = none := by decide
example : decimalDigit (Char.ofNat 22) = none := by decide
example : decimalDigit (Char.ofNat 23) = none := by decide
example : decimalDigit (Char.ofNat 24) = none := by decide
example : decimalDigit (Char.ofNat 25) = none := by decide
example : decimalDigit (Char.ofNat 26) = none := by decide
example : decimalDigit (Char.ofNat 27) = none := by decide
example : decimalDigit (Char.ofNat 28) = none := by decide
example : decimalDigit (Char.ofNat 29) = none := by decide
example : decimalDigit (Char.ofNat 30) = none := by decide
example : decimalDigit (Char.ofNat 31) = none := by decide
example : decimalDigit (Char.ofNat 32) = none := by decide
example : decimalDigit (Char.ofNat 33) = none := by decide
example : decimalDigit (Char.ofNat 34) = none := by decide
example : decimalDigit (Char.ofNat 35) = none := by decide
example : decimalDigit (Char.ofNat 36) = none := by decide
example : decimalDigit (Char.ofNat 37) = none := by decide
example : decimalDigit (Char.ofNat 38) = none := by decide
example : decimalDigit (Char.ofNat 39) = none := by decide
example : decimalDigit (Char.ofNat 40) = none := by decide
example : decimalDigit (Char.ofNat 41) = none := by decide
example : decimalDigit (Char.ofNat 42) = none := by decide
example : decimalDigit (Char.ofNat 43) = none := by decide
example : decimalDigit (Char.ofNat 44) = none := by decide
example : decimalDigit (Char.ofNat 45) = none := by decide
example : decimalDigit (Char.ofNat 46) = none := by decide
example : decimalDigit (Char.ofNat 47) = none := by decide
example : decimalDigit (Char.ofNat 48) = some 0 := by decide
example : decimalDigit (Char.ofNat 49) = some 1 := by decide
example : decimalDigit (Char.ofNat 50) = some 2 := by decide
example : decimalDigit (Char.ofNat 51) = some 3 := by decide
example : decimalDigit (Char.ofNat 52) = some 4 := by decide
example : decimalDigit (Char.ofNat 53) = some 5 := by decide
example : decimalDigit (Char.ofNat 54) = some 6 := by decide
example : decimalDigit (Char.ofNat 55) = some 7 := by decide
example : decimalDigit (Char.ofNat 56) = some 8 := by decide
example : decimalDigit (Char.ofNat 57) = some 9 := by decide
example : decimalDigit (Char.ofNat 58) = none := by decide
example : decimalDigit (Char.ofNat 59) = none := by decide
example : decimalDigit (Char.ofNat 60) = none := by decide
example : decimalDigit (Char.ofNat 61) = none := by decide
example : decimalDigit (Char.ofNat 62) = none := by decide
example : decimalDigit (Char.ofNat 63) = none := by decide
example : decimalDigit (Char.ofNat 64) = none := by decide
example : decimalDigit (Char.ofNat 65) = none := by decide
example : decimalDigit (Char.ofNat 66) = none := by decide
example : decimalDigit (Char.ofNat 67) = none := by decide
example : decimalDigit (Char.ofNat 68) = none := by decide
example : decimalDigit (Char.ofNat 69) = none := by decide
example : decimalDigit (Char.ofNat 70) = none := by decide
example : decimalDigit (Char.ofNat 71) = none := by decide
example : decimalDigit (Char.ofNat 72) = none := by decide
example : decimalDigit (Char.ofNat 73) = none := by decide
example : decimalDigit (Char.ofNat 74) = none := by decide
example : decimalDigit (Char.ofNat 75) = none := by decide
example : decimalDigit (Char.ofNat 76) = none := by decide
example : decimalDigit (Char.ofNat 77) = none := by decide
example : decimalDigit (Char.ofNat 78) = none := by decide
example : decimalDigit (Char.ofNat 79) = none := by decide
example : decimalDigit (Char.ofNat 80) = none := by decide
example : decimalDigit (Char.ofNat 81) = none := by decide
example : decimalDigit (Char.ofNat 82) = none := by decide
example : decimalDigit (Char.ofNat 83) = none := by decide
example : decimalDigit (Char.ofNat 84) = none := by decide
example : decimalDigit (Char.ofNat 85) = none := by decide
example : decimalDigit (Char.ofNat 86) = none := by decide
example : decimalDigit (Char.ofNat 87) = none := by decide
example : decimalDigit (Char.ofNat 88) = none := by decide
example : decimalDigit (Char.ofNat 89) = none := by decide
example : decimalDigit (Char.ofNat 90) = none := by decide
example : decimalDigit (Char.ofNat 91) = none := by decide
example : decimalDigit (Char.ofNat 92) = none := by decide
example : decimalDigit (Char.ofNat 93) = none := by decide
example : decimalDigit (Char.ofNat 94) = none := by decide
example : decimalDigit (Char.ofNat 95) = none := by decide
example : decimalDigit (Char.ofNat 96) = none := by decide
example : decimalDigit (Char.ofNat 97) = none := by decide
example : decimalDigit (Char.ofNat 98) = none := by decide
example : decimalDigit (Char.ofNat 99) = none := by decide
example : decimalDigit (Char.ofNat 100) = none := by decide
example : decimalDigit (Char.ofNat 101) = none := by decide
example : decimalDigit (Char.ofNat 102) = none := by decide
example : decimalDigit (Char.ofNat 103) = none := by decide
example : decimalDigit (Char.ofNat 104) = none := by decide
example : decimalDigit (Char.ofNat 105) = none := by decide
example : decimalDigit (Char.ofNat 106) = none := by decide
example : decimalDigit (Char.ofNat 107) = none := by decide
example : decimalDigit (Char.ofNat 108) = none := by decide
example : decimalDigit (Char.ofNat 109) = none := by decide
example : decimalDigit (Char.ofNat 110) = none := by decide
example : decimalDigit (Char.ofNat 111) = none := by decide
example : decimalDigit (Char.ofNat 112) = none := by decide
example : decimalDigit (Char.ofNat 113) = none := by decide
example : decimalDigit (Char.ofNat 114) = none := by decide
example : decimalDigit (Char.ofNat 115) = none := by decide
example : decimalDigit (Char.ofNat 116) = none := by decide
example : decimalDigit (Char.ofNat 117) = none := by decide
example : decimalDigit (Char.ofNat 118) = none := by decide
example : decimalDigit (Char.ofNat 119) = none := by decide
example : decimalDigit (Char.ofNat 120) = none := by decide
example : decimalDigit (Char.ofNat 121) = none := by decide
example : decimalDigit (Char.ofNat 122) = none := by decide
example : decimalDigit (Char.ofNat 123) = none := by decide
example : decimalDigit (Char.ofNat 124) = none := by decide
example : decimalDigit (Char.ofNat 125) = none := by decide
example : decimalDigit (Char.ofNat 126) = none := by decide
example : decimalDigit (Char.ofNat 127) = none := by decide
example : decimalDigit (Char.ofNat 1631) = none := by decide
example : decimalDigit (Char.ofNat 1632) = some 0 := by decide
example : decimalDigit (Char.ofNat 1633) = some 1 := by decide
example : decimalDigit (Char.ofNat 1634) = some 2 := by decide
example : decimalDigit (Char.ofNat 1635) = some 3 := by decide
example : decimalDigit (Char.ofNat 1636) = some 4 := by decide
example : decimalDigit (Char.ofNat 1637) = some 5 := by decide
example : decimalDigit (Char.ofNat 1638) = some 6 := by decide
example : decimalDigit (Char.ofNat 1639) = some 7 := by decide
example : decimalDigit (Char.ofNat 1640) = some 8 := by decide
example : decimalDigit (Char.ofNat 1641) = some 9 := by decide
example : decimalDigit (Char.ofNat 1642) = none := by decide
example : decimalDigit (Char.ofNat 1775) = none := by decide
example : decimalDigit (Char.ofNat 1776) = some 0 := by decide
example : decimalDigit (Char.ofNat 1777) = some 1 := by decide
example : decimalDigit (Char.ofNat 1778) = some 2 := by decide
example : decimalDigit (Char.ofNat 1779) = some 3 := by decide
example : decimalDigit (Char.ofNat 1780) = some 4 := by decide
example : decimalDigit (Char.ofNat 1781) = some 5 := by decide
example : decimalDigit (Char.ofNat 1782) = some 6 := by decide
example : decimalDigit (Char.ofNat 1783) = some 7 := by decide
example : decimalDigit (Char.ofNat 1784) = some 8 := by decide
example : decimalDigit (Char.ofNat 1785) = some 9 := by decide
example : decimalDigit (Char.ofNat 1786) = none := by decide
example : decimalDigit (Char.ofNat 1983) = none := by decide
example : decimalDigit (Char.ofNat 1984) = some 0 := by decide
example : decimalDigit (Char.ofNat 1985) = some 1 := by decide
example : decimalDigit (Char.ofNat 1986) = some 2 := by decide
example : decimalDigit (Char.ofNat 1987) = some 3 := by decide
example : decimalDigit (Char.ofNat 1988) = some 4 := by decide
example : decimalDigit (Char.ofNat 1989) = some 5 := by decide
example : decimalDigit (Char.ofNat 1990) = some 6 := by decide
example : decimalDigit (Char.ofNat 1991) = some 7 := by decide
example : decimalDigit (Char.ofNat 1992) = some 8 := by decide
example : decimalDigit (Char.ofNat 1993) = some 9 := by decide
example : decimalDigit (Char.ofNat 1994) = none := by decide
example : decimalDigit (Char.ofNat 2405) = none := by decide
example : decimalDigit (Char.ofNat 2406) = some 0 := by decide
example : decimalDigit (Char.ofNat 2407) = some 1 := by decide
example : decimalDigit (Char.ofNat 2408) = some 2 := by decide
example : decimalDigit (Char.ofNat 2409) = some 3 := by decide
example : decimalDigit (Char.ofNat 2410) = some 4 := by decide
example : decimalDigit (Char.ofNat 2411) = some 5 := by decide
example : decimalDigit (Char.ofNat 2412) = some 6 := by decide
example : decimalDigit (Char.ofNat 2413) = some 7 := by decide
example : decimalDigit (Char.ofNat 2414) = some 8 := by decide
example : decimalDigit (Char.ofNat 2415) = some 9 := by decide
example : decimalDigit (Char.ofNat 2416) = none := by decide
example : decimalDigit (Char.ofNat 2533) = none := by decide
example : decimalDigit (Char.ofNat 2534) = some 0 := by decide
example : decimalDigit (Char.ofNat 2535) = some 1 := by decide
example : decimalDigit (Char.ofNat 2536) = some 2 := by decide
example : decimalDigit (Char.ofNat 2537) = some 3 := by decide
example : decimalDigit (Char.ofNat 2538) = some 4 := by decide
example : decimalDigit (Char.ofNat 2539) = some 5 := by decide
example : decimalDigit (Char.ofNat 2540) = some 6 := by decide
example : decimalDigit (Char.ofNat 2541) = some 7 := by decide
example : decimalDigit (Char.ofNat 2542) = some 8 := by decide
example : decimalDigit (Char.ofNat 2543) = some 9 := by decide
example : decimalDigit (Char.ofNat 2544) = none := by decide
example : decimalDigit (Char.ofNat 2661) = none := by decide
example : decimalDigit (Char.ofNat 2662) = some 0 := by decide
example : decimalDigit (Char.ofNat 2663) = some 1 := by decide
example : decimalDigit (Char.ofNat 2664) = some 2 := by decide
example : decimalDigit (Char.ofNat 2665) = some 3 := by decide
example : decimalDigit (Char.ofNat 2666) = some 4 := by decide
example : decimalDigit (Char.ofNat 2667) = some 5 := by decide
example : decimalDigit (Char.ofNat 2668) = some 6 := by decide
example : decimalDigit (Char.ofNat 2669) = some 7 := by decide
example : decimalDigit (Char.ofNat 2670) = some 8 := by decide
example : decimalDigit (Char.ofNat 2671) = some 9 := by decide
example : decimalDigit (Char.ofNat 2672) = none := by decide
example : decimalDigit (Char.ofNat 2789) = none := by decide
example : decimalDigit (Char.ofNat 2790) = some 0 := by decide
example : decimalDigit (Char.ofNat 2791) = some 1 := by decide
example : decimalDigit (Char.ofNat 2792) = some 2 := by decide
example : decimalDigit (Char.ofNat 2793) = some 3 := by decide
example : decimalDigit (Char.ofNat 2794) = some 4 := by decide
example : decimalDigit (Char.ofNat 2795) = some 5 := by decide
example : decimalDigit (Char.ofNat 2796) = some 6 := by decide
example : decimalDigit (Char.ofNat 2797) = some 7 := by decide
example : decimalDigit (Char.ofNat 2798) = some 8 := by decide
example : decimalDigit (Char.ofNat 2799) = some 9 := by decide
example : decimalDigit (Char.ofNat 2800) = none := by decide
example : decimalDigit (Char.ofNat 2917) = none := by decide
example : decimalDigit (Char.ofNat 2918) = some 0 := by decide
example : decimalDigit (Char.ofNat 2919) = some 1 := by decide
example : decimalDigit (Char.ofNat 2920) = some 2 := by decide
example : decimalDigit (Char.ofNat 2921) = some 3 := by decide
example : decimalDigit (Char.ofNat 2922) = some 4 := by decide
example : decimalDigit (Char.ofNat 2923) = some 5 := by decide
example : decimalDigit (Char.ofNat 2924) = some 6 := by decide
example : decimalDigit (Char.ofNat 2925) = some 7 := by decide
example : decimalDigit (Char.ofNat 2926) = some 8 := by decide
example : decimalDigit (Char.ofNat 2927) = some 9 := by decide
example : decimalDigit (Char.ofNat 2928) = none := by decide
example : decimalDigit (Char.ofNat 3045) = none := by decide
example : decimalDigit (Char.ofNat 3046) = some 0 := by decide
example : decimalDigit (Char.ofNat 3047) = some 1 := by decide
example : decimalDigit (Char.ofNat 3048) = some 2 := by decide
example : decimalDigit (Char.ofNat 3049) = some 3 := by decide
example : decimalDigit (Char.ofNat 3050) = some 4 := by decide
example : decimalDigit (Char.ofNat 3051) = some 5 := by decide
example : decimalDigit (Char.ofNat 3052) = some 6 := by decide
example : decimalDigit (Char.ofNat 3053) = some 7 := by decide
example : decimalDigit (Char.ofNat 3054) = some 8 := by decide
example : decimalDigit (Char.ofNat 3055) = some 9 := by decide
example : decimalDigit (Char.ofNat 3056) = none := by decide
example : decimalDigit (Char.ofNat 3173) = none := by decide
example : decimalDigit (Char.ofNat 3174) = some 0 := by decide
example : decimalDigit (Char.ofNat 3175) = some 1 := by decide
example : decimalDigit (Char.ofNat 3176) = some 2 := by decide
example : decimalDigit (Char.ofNat 3177) = some 3 := by decide
example : decimalDigit (Char.ofNat 3178) = some 4 := by decide
example : decimalDigit (Char.ofNat 3179) = some 5 := by decide
example : decimalDigit (Char.ofNat 3180) = some 6 := by decide
example : decimalDigit (Char.ofNat 3181) = some 7 := by decide
example : decimalDigit (Char.ofNat 3182) = some 8 := by decide
example : decimalDigit (Char.ofNat 3183) = some 9 := by decide
example : decimalDigit (Char.ofNat 3184) = none := by decide
example : decimalDigit (Char.ofNat 3301) = none := by decide
example : decimalDigit (Char.ofNat 3302) = some 0 := by decide
example : decimalDigit (Char.ofNat 3303) = some 1 := by decide
example : decimalDigit (Char.ofNat 3304) = some 2 := by decide
example : decimalDigit (Char.ofNat 3305) = some 3 := by decide
example : decimalDigit (Char.ofNat 3306) = some 4 := by decide
example : decimalDigit (Char.ofNat 3307) = some 5 := by decide
example : decimalDigit (Char.ofNat 3308) = some 6 := by decide
example : decimalDigit (Char.ofNat 3309) = some 7 := by decide
example : decimalDigit (Char.ofNat 3310) = some 8 := by decide
example : decimalDigit (Char.ofNat 3311) = some 9 := by decide
example : decimalDigit (Char.ofNat 3312) = none := by decide
example : decimalDigit (Char.ofNat 3429) = none := by decide
example : decimalDigit (Char.ofNat 3430) = some 0 := by decide
example : decimalDigit (Char.ofNat 3431) = some 1 := by decide
example : decimalDigit (Char.ofNat 3432) = some 2 := by decide
example : decimalDigit (Char.ofNat 3433) = some 3 := by decide
example : decimalDigit (Char.ofNat 3434) = some 4 := by decide
example : decimalDigit (Char.ofNat 3435) = some 5 := by decide
example : decimalDigit (Char.ofNat 3436) = some 6 := by decide
example : decimalDigit (Char.ofNat 3437) = some 7 := by decide
example : decimalDigit (Char.ofNat 3438) = some 8 := by decide
example : decimalDigit (Char.ofNat 3439) = some 9 := by decide
example : decimalDigit (Char.ofNat 3440) = none := by decide
example : decimalDigit (Char.ofNat 3557) = none := by decide
example : decimalDigit (Char.ofNat 3558) = some 0 := by decide
example : decimalDigit (Char.ofNat 3559) = some 1 := by decide
example : decimalDigit (Char.ofNat 3560) = some 2 := by decide
example : decimalDigit (Char.ofNat 3561) = some 3 := by decide
example : decimalDigit (Char.ofNat 3562) = some 4 := by decide
example : decimalDigit (Char.ofNat 3563) = some 5 := by decide
example : decimalDigit (Char.ofNat 3564) = some 6 := by decide
example : decimalDigit (Char.ofNat 3565) = some 7 := by decide
example : decimalDigit (Char.ofNat 3566) = some 8 := by decide
example : decimalDigit (Char.ofNat 3567) = some 9 := by decide
example : decimalDigit (Char.ofNat 3568) = none := by decide
example : decimalDigit (Char.ofNat 3663) = none := by decide
example : decimalDigit (Char.ofNat 3664) = some 0 := by decide
example : decimalDigit (Char.ofNat 3665) = some 1 := by decide
example : decimalDigit (Char.ofNat 3666) = some 2 := by decide
example : decimalDigit (Char.ofNat 3667) = some 3 := by decide
example : decimalDigit (Char.ofNat 3668) = some 4 := by decide
example : decimalDigit (Char.ofNat 3669) = some 5 := by decide
example : decimalDigit (Char.ofNat 3670) = some 6 := by decide
example : decimalDigit (Char.ofNat 3671) = some 7 := by decide
example : decimalDigit (Char.ofNat 3672) = some 8 := by decide
example : decimalDigit (Char.ofNat 3673) = some 9 := by decide
example : decimalDigit (Char.ofNat 3674) = none := by decide
example : decimalDigit (Char.ofNat 3791) = none := by decide
example : decimalDigit (Char.ofNat 3792) = some 0 := by decide
example : decimalDigit (Char.ofNat 3793) = some 1 := by decide
example : decimalDigit (Char.ofNat 3794) = some 2 := by decide
example : decimalDigit (Char.ofNat 3795) = some 3 := by decide
example : decimalDigit (Char.ofNat 3796) = some 4 := by decide
example : decimalDigit (Char.ofNat 3797) = some 5 := by decide
example : decimalDigit (Char.ofNat 3798) = some 6 := by decide
example : decimalDigit (Char.ofNat 3799) = some 7 := by decide
example : decimalDigit (Char.ofNat 3800) = some 8 := by decide
example : decimalDigit (Char.ofNat 3801) = some 9 := by decide
example : decimalDigit (Char.ofNat 3802) = none := by decide
example : decimalDigit (Char.ofNat 3871) = none := by decide
example : decimalDigit (Char.ofNat 3872) = some 0 := by decide
example : decimalDigit (Char.ofNat 3873) = some 1 := by decide
example : decimalDigit (Char.ofNat 3874) = some 2 := by decide
example : decimalDigit (Char.ofNat 3875) = some 3 := by decide
example : decimalDigit (Char.ofNat 3876) = some 4 := by decide
example : decimalDigit (Char.ofNat 3877) = some 5 := by decide
example : decimalDigit (Char.ofNat 3878) = some 6 := by decide
example : decimalDigit (Char.ofNat 3879) = some 7 := by decide
example : decimalDigit (Char.ofNat 3880) = some 8 := by decide
example : decimalDigit (Char.ofNat 3881) = some 9 := by decide
example : decimalDigit (Char.ofNat 3882) = none := by decide
example : decimalDigit (Char.ofNat 4159) = none := by decide
example : decimalDigit (Char.ofNat 4160) = some 0 := by decide
example : decimalDigit (Char.ofNat 4161) = some 1 := by decide
example : decimalDigit (Char.ofNat 4162) = some 2 := by decide
example : decimalDigit (Char.ofNat 4163) = some 3 := by decide
example : decimalDigit (Char.ofNat 4164) = some 4 := by decide
example : decimalDigit (Char.ofNat 4165) = some 5 := by decide
example : decimalDigit (Char.ofNat 4166) = some 6 := by decide
example : decimalDigit (Char.ofNat 4167) = some 7 := by decide
example : decimalDigit (Char.ofNat 4168) = some 8 := by decide
example : decimalDigit (Char.ofNat 4169) = some 9 := by decide
example : decimalDigit (Char.ofNat 4170) = none := by decide
example : decimalDigit (Char.ofNat 4239) = none := by decide
example : decimalDigit (Char.ofNat 4240) = some 0 := by decide
example : decimalDigit (Char.ofNat 4241) = some 1 := by decide
example : decimalDigit (Char.ofNat 4242) = some 2 := by decide
example : decimalDigit (Char.ofNat 4243) = some 3 := by decide
example : decimalDigit (Char.ofNat 4244) = some 4 := by decide
example : decimalDigit (Char.ofNat 4245) = some 5 := by decide
example : decimalDigit (Char.ofNat 4246) = some 6 := by decide
example : decimalDigit (Char.ofNat 4247) = some 7 := by decide
example : decimalDigit (Char.ofNat 4248) = some 8 := by decide
example : decimalDigit (Char.ofNat 4249) = some 9 := by decide
example : decimalDigit (Char.ofNat 4250) = none := by decide
example : decimalDigit (Char.ofNat 6111) = none := by decide
example : decimalDigit (Char.ofNat 6112) = some 0 := by decide
example : decimalDigit (Char.ofNat 6113) = some 1 := by decide
example : decimalDigit (Char.ofNat 6114) = some 2 := by decide
example : decimalDigit (Char.ofNat 6115) = some 3 := by decide
example : decimalDigit (Char.ofNat 6116) = some 4 := by decide
example : decimalDigit (Char.ofNat 6117) = some 5 := by decide
example : decimalDigit (Char.ofNat 6118) = some 6 := by decide
example : decimalDigit (Char.ofNat 6119) = some 7 := by decide
example : decimalDigit (Char.ofNat 6120) = some 8 := by decide
example : decimalDigit (Char.ofNat 6121) = some 9 := by decide
example : decimalDigit (Char.ofNat 6122) = none := by decide
example : decimalDigit (Char.ofNat 6159) = none := by decide
example : decimalDigit (Char.ofNat 6160) = some 0 := by decide
example : decimalDigit (Char.ofNat 6161) = some 1 := by decide
example : decimalDigit (Char.ofNat 6162) = some 2 := by decide
example : decimalDigit (Char.ofNat 6163) = some 3 := by decide
example : decimalDigit (Char.ofNat 6164) = some 4 := by decide
example : decimalDigit (Char.ofNat 6165) = some 5 := by decide
example : decimalDigit (Char.ofNat 6166) = some 6 := by decide
example : decimalDigit (Char.ofNat 6167) = some 7 := by decide
example : decimalDigit (Char.ofNat 6168) = some 8 := by decide
example : decimalDigit (Char.ofNat 6169) = some 9 := by decide
example : decimalDigit (Char.ofNat 6170) = none := by decide
example : decimalDigit (Char.ofNat 6469) = none := by decide
example : decimalDigit (Char.ofNat 6470) = some 0 := by decide
example : decimalDigit (Char.ofNat 6471) = some 1 := by decide
example : decimalDigit (Char.ofNat 6472) = some 2 := by decide
example : decimalDigit (Char.ofNat 6473) = some 3 := by decide
example : decimalDigit (Char.ofNat 6474) = some 4 := by decide
example : decimalDigit (Char.ofNat 6475) = some 5 := by decide
example : decimalDigit (Char.ofNat 6476) = some 6 := by decide
example : decimalDigit (Char.ofNat 6477) = some 7 := by decide
example : decimalDigit (Char.ofNat 6478) = some 8 := by decide
example : decimalDigit (Char.ofNat 6479) = some 9 := by decide
example : decimalDigit (Char.ofNat 6480) = none := by decide
example : decimalDigit (Char.ofNat 6607) = none := by decide
example : decimalDigit (Char.ofNat 6608) = some 0 := by decide
example : decimalDigit (Char.ofNat 6609) = some 1 := by decide
example : decimalDigit (Char.ofNat 6610) = some 2 := by decide
example : decimalDigit (Char.ofNat 6611) = some 3 := by decide
example : decimalDigit (Char.ofNat 6612) = some 4 := by decide
example : decimalDigit (Char.ofNat 6613) = some 5 := by decide
example : decimalDigit (Char.ofNat 6614) = some 6 := by decide
example : decimalDigit (Char.ofNat 6615) = some 7 := by decide
example : decimalDigit (Char.ofNat 6616) = some 8 := by decide
example : decimalDigit (Char.ofNat 6617) = some 9 := by decide
example : decimalDigit (Char.ofNat 6618) = none := by decide
example : decimalDigit (Char.ofNat 6783) = none := by decide
example : decimalDigit (Char.ofNat 6784) = some 0 := by decide
example : decimalDigit (Char.ofNat 6785) = some 1 := by decide
example : decimalDigit (Char.ofNat 6786) = some 2 := by decide
example : decimalDigit (Char.ofNat 6787) = some 3 := by decide
example : decimalDigit (Char.ofNat 6788) = some 4 := by decide
example : decimalDigit (Char.ofNat 6789) = some 5 := by decide
example : decimalDigit (Char.ofNat 6790) = some 6 := by decide
example : decimalDigit (Char.ofNat 6791) = some 7 := by decide
example : decimalDigit (Char.ofNat 6792) = some 8 := by decide
example : decimalDigit (Char.ofNat 6793) = some 9 := by decide
example : decimalDigit (Char.ofNat 6794) = none := by decide
example : decimalDigit (Char.ofNat 6799) = none := by decide
example : decimalDigit (Char.ofNat 6800) = some 0 := by decide
example : decimalDigit (Char.ofNat 6801) = some 1 := by decide
example : decimalDigit (Char.ofNat 6802) = some 2 := by decide
example : decimalDigit (Char.ofNat 6803) = some 3 := by decide
example : decimalDigit (Char.ofNat 6804) = some 4 := by decide
example : decimalDigit (Char.ofNat 6805) = some 5 := by decide
example : decimalDigit (Char.ofNat 6806) = some 6 := by decide
example : decimalDigit (Char.ofNat 6807) = some 7 := by decide
example : decimalDigit (Char.ofNat 6808) = some 8 := by decide
example : decimalDigit (Char.ofNat 6809) = some 9 := by decide
example : decimalDigit (Char.ofNat 6810) = none := by decide
example : decimalDigit (Char.ofNat 6991) = none := by decide
example : decimalDigit (Char.ofNat 6992) = some 0 := by decide
example : decimalDigit (Char.ofNat 6993) = some 1 := by decide
example : decimalDigit (Char.ofNat 6994) = some 2 := by decide
example : decimalDigit (Char.ofNat 6995) = some 3 := by decide
example : decimalDigit (Char.ofNat 6996) = some 4 := by decide
example : decimalDigit (Char.ofNat 6997) = some 5 := by decide
example : decimalDigit (Char.ofNat 6998) = some 6 := by decide
example : decimalDigit (Char.ofNat 6999) = some 7 := by decide
example : decimalDigit (Char.ofNat 7000) = some 8 := by decide
example : decimalDigit (Char.ofNat 7001) = some 9 := by decide
example : decimalDigit (Char.ofNat 7002) = none := by decide
example : decimalDigit (Char.ofNat 7087) = none := by decide
example : decimalDigit (Char.ofNat 7088) = some 0 := by decide
example : decimalDigit (Char.ofNat 7089) = some 1 := by decide
example : decimalDigit (Char.ofNat 7090) = some 2 := by decide
example : decimalDigit (Char.ofNat 7091) = some 3 := by decide
example : decimalDigit (Char.ofNat 7092) = some 4 := by decide
example : decimalDigit (Char.ofNat 7093) = some 5 := by decide
example : decimalDigit (Char.ofNat 7094) = some 6 := by decide
example : decimalDigit (Char.ofNat 7095) = some 7 := by decide
example : decimalDigit (Char.ofNat 7096) = some 8 := by decide
example : decimalDigit (Char.ofNat 7097) = some 9 := by decide
example : decimalDigit (Char.ofNat 7098) = none := by decide
example : decimalDigit (Char.ofNat 7231) = none := by decide
example : decimalDigit (Char.ofNat 7232) = some 0 := by decide
example : decimalDigit (Char.ofNat 7233) = some 1 := by decide
example : decimalDigit (Char.ofNat 7234) = some 2 := by decide
example : decimalDigit (Char.ofNat 7235) = some 3 := by decide
example : decimalDigit (Char.ofNat 7236) = some 4 := by decide
example : decimalDigit (Char.ofNat 7237) = some 5 := by decide
example : decimalDigit (Char.ofNat 7238) = some 6 := by decide
example : decimalDigit (Char.ofNat 7239) = some 7 := by decide
example : decimalDigit (Char.ofNat 7240) = some 8 := by decide
example : decimalDigit (Char.ofNat 7241) = some 9 := by decide
example : decimalDigit (Char.ofNat 7242) = none := by decide
example : decimalDigit (Char.ofNat 7247) = none := by decide
example : decimalDigit (Char.ofNat 7248) = some 0 := by decide
example : decimalDigit (Char.ofNat 7249) = some 1 := by decide
example : decimalDigit (Char.ofNat 7250) = some 2 := by decide
example : decimalDigit (Char.ofNat 7251) = some 3 := by decide
example : decimalDigit (Char.ofNat 7252) = some 4 := by decide
example : decimalDigit (Char.ofNat 7253) = some 5 := by decide
example : decimalDigit (Char.ofNat 7254) = some 6 := by decide
example : decimalDigit (Char.ofNat 7255) = some 7 := by decide
example : decimalDigit (Char.ofNat 7256) = some 8 := by decide
example : decimalDigit (Char.ofNat 7257) = some 9 := by decide
example : decimalDigit (Char.ofNat 7258) = none := by decide
example : decimalDigit (Char.ofNat 42527) = none := by decide
example : decimalDigit (Char.ofNat 42528) = some 0 := by decide
example : decimalDigit (Char.ofNat 42529) = some 1 := by decide
example : decimalDigit (Char.ofNat 42530) = some 2 := by decide
example : decimalDigit (Char.ofNat 42531) = some 3 := by decide
example : decimalDigit (Char.ofNat 42532) = some 4 := by decide
example : decimalDigit (Char.ofNat 42533) = some 5 := by decide
example : decimalDigit (Char.ofNat 42534) = some 6 := by decide
example : decimalDigit (Char.ofNat 42535) = some 7 := by decide
example : decimalDigit (Char.ofNat 42536) = some 8 := by decide
example : decimalDigit (Char.ofNat 42537) = some 9 := by decide
example : decimalDigit (Char.ofNat 42538) = none := by decide
example : decimalDigit (Char.ofNat 43215) = none := by decide
example : decimalDigit (Char.ofNat 43216) = some 0 := by decide
example : decimalDigit (Char.ofNat 43217) = some 1 := by decide
example : decimalDigit (Char.ofNat 43218) = some 2 := by decide
example : decimalDigit (Char.ofNat 43219) = some 3 := by decide
example : decimalDigit (Char.ofNat 43220) = some 4 := by decide
example : decimalDigit (Char.ofNat 43221) = some 5 := by decide
example : decimalDigit (Char.ofNat 43222) = some 6 := by decide
example : decimalDigit (Char.ofNat 43223) = some 7 := by decide
example : decimalDigit (Char.ofNat 43224) = some 8 := by decide
example : decimalDigit (Char.ofNat 43225) = some 9 := by decide
example : decimalDigit (Char.ofNat 43226) = none := by decide
example : decimalDigit (Char.ofNat 43263) = none := by decide
example : decimalDigit (Char.ofNat 43264) = some 0 := by decide
example : decimalDigit (Char.ofNat 43265) = some 1 := by decide
example : decimalDigit (Char.ofNat 43266) = some 2 := by decide
example : decimalDigit (Char.ofNat 43267) = some 3 := by decide
example : decimalDigit (Char.ofNat 43268) = some 4 := by decide
example : decimalDigit (Char.ofNat 43269) = some 5 := by decide
example : decimalDigit (Char.ofNat 43270) = some 6 := by decide
example : decimalDigit (Char.ofNat 43271) = some 7 := by decide
example : decimalDigit (Char.ofNat 43272) = some 8 := by decide
example : decimalDigit (Char.ofNat 43273) = some 9 := by decide
example : decimalDigit (Char.ofNat 43274) = none := by decide
example : decimalDigit (Char.ofNat 43471) = none := by decide
example : decimalDigit (Char.ofNat 43472) = some 0 := by decide
example : decimalDigit (Char.ofNat 43473) = some 1 := by decide
example : decimalDigit (Char.ofNat 43474) = some 2 := by decide
example : decimalDigit (Char.ofNat 43475) = some 3 := by decide
example : decimalDigit (Char.ofNat 43476) = some 4 := by decide
example : decimalDigit (Char.ofNat 43477) = some 5 := by decide
example : decimalDigit (Char.ofNat 43478) = some 6 := by decide
example : decimalDigit (Char.ofNat 43479) = some 7 := by decide
example : decimalDigit (Char.ofNat 43480) = some 8 := by decide
example : decimalDigit (Char.ofNat 43481) = some 9 := by decide
example : decimalDigit (Char.ofNat 43482) = none := by decide
example : decimalDigit (Char.ofNat 43503) = none := by decide
example : decimalDigit (Char.ofNat 43504) = some 0 := by decide
example : decimalDigit (Char.ofNat 43505) = some 1 := by decide
example : decimalDigit (Char.ofNat 43506) = some 2 := by decide
example : decimalDigit (Char.ofNat 43507) = some 3 := by decide
example : decimalDigit (Char.ofNat 43508) = some 4 := by decide
example : decimalDigit (Char.ofNat 43509) = some 5 := by decide
example : decimalDigit (Char.ofNat 43510) = some 6 := by decide
example : decimalDigit (Char.ofNat 43511) = some 7 := by decide
example : decimalDigit (Char.ofNat 43512) = some 8 := by decide
example : decimalDigit (Char.ofNat 43513) = some 9 := by decide
example : decimalDigit (Char.ofNat 43514) = none := by decide
example : decimalDigit (Char.ofNat 43599) = none := by decide
example : decimalDigit (Char.ofNat 43600) = some 0 := by decide
example : decimalDigit (Char.ofNat 43601) = some 1 := by decide
example : decimalDigit (Char.ofNat 43602) = some 2 := by decide
example : decimalDigit (Char.ofNat 43603) = some 3 := by decide
example : decimalDigit (Char.ofNat 43604) = some 4 := by decide
example : decimalDigit (Char.ofNat 43605) = some 5 := by decide
example : decimalDigit (Char.ofNat 43606) = some 6 := by decide
example : decimalDigit (Char.ofNat 43607) = some 7 := by decide
example : decimalDigit (Char.ofNat 43608) = some 8 := by decide
example : decimalDigit (Char.ofNat 43609) = some 9 := by decide
example : decimalDigit (Char.ofNat 43610) = none := by decide
example : decimalDigit (Char.ofNat 44015) = none := by decide
example : decimalDigit (Char.ofNat 44016) = some 0 := by decide
example : decimalDigit (Char.ofNat 44017) = some 1 := by decide
example : decimalDigit (Char.ofNat 44018) = some 2 := by decide
example : decimalDigit (Char.ofNat 44019) = some 3 := by decide
example : decimalDigit (Char.ofNat 44020) = some 4 := by decide
example : decimalDigit (Char.ofNat 44021) = some 5 := by decide
example : decimalDigit (Char.ofNat 44022) = some 6 := by decide
example : decimalDigit (Char.ofNat 44023) = some 7 := by decide
example : decimalDigit (Char.ofNat 44024) = some 8 := by decide
example : decimalDigit (Char.ofNat 44025) = some 9 := by decide
example : decimalDigit (Char.ofNat 44026) = none := by decide
example : decimalDigit (Char.ofNat 65295) = none := by decide
example : decimalDigit (Char.ofNat 65296) = some 0 := by decide
example : decimalDigit (Char.ofNat 65297) = some 1 := by decide
example : decimalDigit (Char.ofNat 65298) = some 2 := by decide
example : decimalDigit (Char.ofNat 65299) = some 3 := by decide
example : decimalDigit (Char.ofNat 65300) = some 4 := by decide
example : decimalDigit (Char.ofNat 65301) = some 5 := by decide
example : decimalDigit (Char.ofNat 65302) = some 6 := by decide
example : decimalDigit (Char.ofNat 65303) = some 7 := by decide
example : decimalDigit (Char.ofNat 65304) = some 8 := by decide
example : decimalDigit (Char.ofNat 65305) = some 9 := by decide
example : decimalDigit (Char.ofNat 65306) = none := by decide
example : decimalDigit (Char.ofNat 66719) = none := by decide
example : decimalDigit (Char.ofNat 66720) = some 0 := by decide
example : decimalDigit (Char.ofNat 66721) = some 1 := by decide
example : decimalDigit (Char.ofNat 66722) = some 2 := by decide
example : decimalDigit (Char.ofNat 66723) = some 3 := by decide
example : decimalDigit (Char.ofNat 66724) = some 4 := by decide
example : decimalDigit (Char.ofNat 66725) = some 5 := by decide
example : decimalDigit (Char.ofNat 66726) = some 6 := by decide
example : decimalDigit (Char.ofNat 66727) = some 7 := by decide
example : decimalDigit (Char.ofNat 66728) = some 8 := by decide
example : decimalDigit (Char.ofNat 66729) = some 9 := by decide
example : decimalDigit (Char.ofNat 66730) = none := by decide
example : decimalDigit (Char.ofNat 68911) = none := by decide
example : decimalDigit (Char.ofNat 68912) = some 0 := by decide
example : decimalDigit (Char.ofNat 68913) = some 1 := by decide
example : decimalDigit (Char.ofNat 68914) = some 2 := by decide
example : decimalDigit (Char.ofNat 68915) = some 3 := by decide
example : decimalDigit (Char.ofNat 68916) = some 4 := by decide
example : decimalDigit (Char.ofNat 68917) = some 5 := by decide
example : decimalDigit (Char.ofNat 68918) = some 6 := by decide
example : decimalDigit (Char.ofNat 68919) = some 7 := by decide
example : decimalDigit (Char.ofNat 68920) = some 8 := by decide
example : decimalDigit (Char.ofNat 68921) = some 9 := by decide
example : decimalDigit (Char.ofNat 68922) = none := by decide
example : decimalDigit (Char.ofNat 69733) = none := by decide
example : decimalDigit (Char.ofNat 69734) = some 0 := by decide
example : decimalDigit (Char.ofNat 69735) = some 1 := by decide
example : decimalDigit (Char.ofNat 69736) = some 2 := by decide
example : decimalDigit (Char.ofNat 69737) = some 3 := by decide
example : decimalDigit (Char.ofNat 69738) = some 4 := by decide
example : decimalDigit (Char.ofNat 69739) = some 5 := by decide
example : decimalDigit (Char.ofNat 69740) = some 6 := by decide
example : decimalDigit (Char.ofNat 69741) = some 7 := by decide
example : decimalDigit (Char.ofNat 69742) = some 8 := by decide
example : decimalDigit (Char.ofNat 69743) = some 9 := by decide
example : decimalDigit (Char.ofNat 69744) = none := by decide
example : decimalDigit (Char.ofNat 69871) = none := by decide
example : decimalDigit (Char.ofNat 69872) = some 0 := by decide
example : decimalDigit (Char.ofNat 69873) = some 1 := by decide
example : decimalDigit (Char.ofNat 69874) = some 2 := by decide
example : decimalDigit (Char.ofNat 69875) = some 3 := by decide
example : decimalDigit (Char.ofNat 69876) = some 4 := by decide
example : decimalDigit (Char.ofNat 69877) = some 5 := by decide
example : decimalDigit (Char.ofNat 69878) = some 6 := by decide
example : decimalDigit (Char.ofNat 69879) = some 7 := by decide
example : decimalDigit (Char.ofNat 69880) = some 8 := by decide
example : decimalDigit (Char.ofNat 69881) = some 9 := by decide
example : decimalDigit (Char.ofNat 69882) = none := by decide
example : decimalDigit (Char.ofNat 69941) = none := by decide
example : decimalDigit (Char.ofNat 69942) = some 0 := by decide
example : decimalDigit (Char.ofNat 69943) = some 1 := by decide
example : decimalDigit (Char.ofNat 69944) = some 2 := by decide
example : decimalDigit (Char.ofNat 69945) = some 3 := by decide
example : decimalDigit (Char.ofNat 69946) = some 4 := by decide
example : decimalDigit (Char.ofNat 69947) = some 5 := by decide
example : decimalDigit (Char.ofNat 69948) = some 6 := by decide
example : decimalDigit (Char.ofNat 69949) = some 7 := by decide
example : decimalDigit (Char.ofNat 69950) = some 8 := by decide
example : decimalDigit (Char.ofNat 69951) = some 9 := by decide
example : decimalDigit (Char.ofNat 69952) = none := by decide
example : decimalDigit (Char.ofNat 70095) = none := by decide
example : decimalDigit (Char.ofNat 70096) = some 0 := by decide
example : decimalDigit (Char.ofNat 70097) = some 1 := by decide
example : decimalDigit (Char.ofNat 70098) = some 2 := by decide
example : decimalDigit (Char.ofNat 70099) = some 3 := by decide
example : decimalDigit (Char.ofNat 70100) = some 4 := by decide
example : decimalDigit (Char.ofNat 70101) = some 5 := by decide
example : decimalDigit (Char.ofNat 70102) = some 6 := by decide
example : decimalDigit (Char.ofNat 70103) = some 7 := by decide
example : decimalDigit (Char.ofNat 70104) = some 8 := by decide
example : decimalDigit (Char.ofNat 70105) = some 9 := by decide
example : decimalDigit (Char.ofNat 70106) = none := by decide
example : decimalDigit (Char.ofNat 70383) = none := by decide
example : decimalDigit (Char.ofNat 70384) = some 0 := by decide
example : decimalDigit (Char.ofNat 70385) = some 1 := by decide
example : decimalDigit (Char.ofNat 70386) = some 2 := by decide
example : decimalDigit (Char.ofNat 70387) = some 3 := by decide
example : decimalDigit (Char.ofNat 70388) = some 4 := by decide
example : decimalDigit (Char.ofNat 70389) = some 5 := by decide
example : decimalDigit (Char.ofNat 70390) = some 6 := by decide
example : decimalDigit (Char.ofNat 70391) = some 7 := by decide
example : decimalDigit (Char.ofNat 70392) = some 8 := by decide
example : decimalDigit (Char.ofNat 70393) = some 9 := by decide
example : decimalDigit (Char.ofNat 70394) = none := by decide
example : decimalDigit (Char.ofNat 70735) = none := by decide
example : decimalDigit (Char.ofNat 70736) = some 0 := by decide
example : decimalDigit (Char.ofNat 70737) = some 1 := by decide
example : decimalDigit (Char.ofNat 70738) = some 2 := by decide
example : decimalDigit (Char.ofNat 70739) = some 3 := by decide
example : decimalDigit (Char.ofNat 70740) = some 4 := by decide
example : decimalDigit (Char.ofNat 70741) = some 5 := by decide
example : decimalDigit (Char.ofNat 70742) = some 6 := by decide
example : decimalDigit (Char.ofNat 70743) = some 7 := by decide
example : decimalDigit (Char.ofNat 70744) = some 8 := by decide
example : decimalDigit (Char.ofNat 70745) = some 9 := by decide
example : decimalDigit (Char.ofNat 70746) = none := by decide
example : decimalDigit (Char.ofNat 70863) = none := by decide
example : decimalDigit (Char.ofNat 70864) = some 0 := by decide
example : decimalDigit (Char.ofNat 70865) = some 1 := by decide
example : decimalDigit (Char.ofNat 70866) = some 2 := by decide
example : decimalDigit (Char.ofNat 70867) = some 3 := by decide
example : decimalDigit (Char.ofNat 70868) = some 4 := by decide
example : decimalDigit (Char.ofNat 70869) = some 5 := by decide
example : decimalDigit (Char.ofNat 70870) = some 6 := by decide
example : decimalDigit (Char.ofNat 70871) = some 7 := by decide
example : decimalDigit (Char.ofNat 70872) = some 8 := by decide
example : decimalDigit (Char.ofNat 70873) = some 9 := by decide
example : decimalDigit (Char.ofNat 70874) = none := by decide
example : decimalDigit (Char.ofNat 71247) = none := by decide
example : decimalDigit (Char.ofNat 71248) = some 0 := by decide
example : decimalDigit (Char.ofNat 71249) = some 1 := by decide
example : decimalDigit (Char.ofNat 71250) = some 2 := by decide
example : decimalDigit (Char.ofNat 71251) = some 3 := by decide
example : decimalDigit (Char.ofNat 71252) = some 4 := by decide
example : decimalDigit (Char.ofNat 71253) = some 5 := by decide
example : decimalDigit (Char.ofNat 71254) = some 6 := by decide
example : decimalDigit (Char.ofNat 71255) = some 7 := by decide
example : decimalDigit (Char.ofNat 71256) = some 8 := by decide
example : decimalDigit (Char.ofNat 71257) = some 9 := by decide
example : decimalDigit (Char.ofNat 71258) = none := by decide
example : decimalDigit (Char.ofNat 71359) = none := by decide
example : decimalDigit (Char.ofNat 71360) = some 0 := by decide
example : decimalDigit (Char.ofNat 71361) = some 1 := by decide
example : decimalDigit (Char.ofNat 71362) = some 2 := by decide
example : decimalDigit (Char.ofNat 71363) = some 3 := by decide
example : decimalDigit (Char.ofNat 71364) = some 4 := by decide
example : decimalDigit (Char.ofNat 71365) = some 5 := by decide
example : decimalDigit (Char.ofNat 71366) = some 6 := by decide
example : decimalDigit (Char.ofNat 71367) = some 7 := by decide
example : decimalDigit (Char.ofNat 71368) = some 8 := by decide
example : decimalDigit (Char.ofNat 71369) = some 9 := by decide
example : decimalDigit (Char.ofNat 71370) = none := by decide
example : decimalDigit (Char.ofNat 71471) = none := by decide
example : decimalDigit (Char.ofNat 71472) = some 0 := by decide
example : decimalDigit (Char.ofNat 71473) = some 1 := by decide
example : decimalDigit (Char.ofNat 71474) = some 2 := by decide
example : decimalDigit (Char.ofNat 71475) = some 3 := by decide
example : decimalDigit (Char.ofNat 71476) = some 4 := by decide
example : decimalDigit (Char.ofNat 71477) = some 5 := by decide
example : decimalDigit (Char.ofNat 71478) = some 6 := by decide
example : decimalDigit (Char.ofNat 71479) = some 7 := by decide
example : decimalDigit (Char.ofNat 71480) = some 8 := by decide
example : decimalDigit (Char.ofNat 71481) = some 9 := by decide
example : decimalDigit (Char.ofNat 71482) = none := by decide
example : decimalDigit (Char.ofNat 71903) = none := by decide
example : decimalDigit (Char.ofNat 71904) = some 0 := by decide
example : decimalDigit (Char.ofNat 71905) = some 1 := by decide
example : decimalDigit (Char.ofNat 71906) = some 2 := by decide
example : decimalDigit (Char.ofNat 71907) = some 3 := by decide
example : decimalDigit (Char.ofNat 71908) = some 4 := by decide
example : decimalDigit (Char.ofNat 71909) = some 5 := by decide
example : decimalDigit (Char.ofNat 71910) = some 6 := by decide
example : decimalDigit (Char.ofNat 71911) = some 7 := by decide
example : decimalDigit (Char.ofNat 71912) = some 8 := by decide
example : decimalDigit (Char.ofNat 71913) = some 9 := by decide
example : decimalDigit (Char.ofNat 71914) = none := by decide
example : decimalDigit (Char.ofNat 72015) = none := by decide
example : decimalDigit (Char.ofNat 72016) = some 0 := by decide
example : decimalDigit (Char.ofNat 72017) = some 1 := by decide
example : decimalDigit (Char.ofNat 72018) = some 2 := by decide
example : decimalDigit (Char.ofNat 72019) = some 3 := by decide
example : decimalDigit (Char.ofNat 72020) = some 4 := by decide
example : decimalDigit (Char.ofNat 72021) = some 5 := by decide
example : decimalDigit (Char.ofNat 72022) = some 6 := by decide
example : decimalDigit (Char.ofNat 72023) = some 7 := by decide
example : decimalDigit (Char.ofNat 72024) = some 8 := by decide
example : decimalDigit (Char.ofNat 72025) = some 9 := by decide
example : decimalDigit (Char.ofNat 72026) = none := by decide
example : decimalDigit (Char.ofNat 72783) = none := by decide
example : decimalDigit (Char.ofNat 72784) = some 0 := by decide
example : decimalDigit (Char.ofNat 72785) = some 1 := by decide
example : decimalDigit (Char.ofNat 72786) = some 2 := by decide
example : decimalDigit (Char.ofNat 72787) = some 3 := by decide
example : decimalDigit (Char.ofNat 72788) = some 4 := by decide
example : decimalDigit (Char.ofNat 72789) = some 5 := by decide
example : decimalDigit (Char.ofNat 72790) = some 6 := by decide
example : decimalDigit (Char.ofNat 72791) = some 7 := by decide
example : decimalDigit (Char.ofNat 72792) = some 8 := by decide
example : decimalDigit (Char.ofNat 72793) = some 9 := by decide
example : decimalDigit (Char.ofNat 72794) = none := by decide
example : decimalDigit (Char.ofNat 73039) = none := by decide
example : decimalDigit (Char.ofNat 73040) = some 0 := by decide
example : decimalDigit (Char.ofNat 73041) = some 1 := by decide
example : decimalDigit (Char.ofNat 73042) = some 2 := by decide
example : decimalDigit (Char.ofNat 73043) = some 3 := by decide
example : decimalDigit (Char.ofNat 73044) = some 4 := by decide
example : decimalDigit (Char.ofNat 73045) = some 5 := by decide
example : decimalDigit (Char.ofNat 73046) = some 6 := by decide
example : decimalDigit (Char.ofNat 73047) = some 7 := by decide
example : decimalDigit (Char.ofNat 73048) = some 8 := by decide
example : decimalDigit (Char.ofNat 73049) = some 9 := by decide
example : decimalDigit (Char.ofNat 73050) = none := by decide
example : decimalDigit (Char.ofNat 73119) = none := by decide
example : decimalDigit (Char.ofNat 73120) = some 0 := by decide
example : decimalDigit (Char.ofNat 73121) = some 1 := by decide
example : decimalDigit (Char.ofNat 73122) = some 2 := by decide
example : decimalDigit (Char.ofNat 73123) = some 3 := by decide
example : decimalDigit (Char.ofNat 73124) = some 4 := by decide
example : decimalDigit (Char.ofNat 73125) = some 5 := by decide
example : decimalDigit (Char.ofNat 73126) = some 6 := by decide
example : decimalDigit (Char.ofNat 73127) = some 7 := by decide
example : decimalDigit (Char.ofNat 73128) = some 8 := by decide
example : decimalDigit (Char.ofNat 73129) = some 9 := by decide
example : decimalDigit (Char.ofNat 73130) = none := by decide
example : decimalDigit (Char.ofNat 92767) = none := by decide
example : decimalDigit (Char.ofNat 92768) = some 0 := by decide
example : decimalDigit (Char.ofNat 92769) = some 1 := by decide
example : decimalDigit (Char.ofNat 92770) = some 2 := by decide
example : decimalDigit (Char.ofNat 92771) = some 3 := by decide
example : decimalDigit (Char.ofNat 92772) = some 4 := by decide
example : decimalDigit (Char.ofNat 92773) = some 5 := by decide
example : decimalDigit (Char.ofNat 92774) = some 6 := by decide
example : decimalDigit (Char.ofNat 92775) = some 7 := by decide
example : decimalDigit (Char.ofNat 92776) = some 8 := by decide
example : decimalDigit (Char.ofNat 92777) = some 9 := by decide
example : decimalDigit (Char.ofNat 92778) = none := by decide
example : decimalDigit (Char.ofNat 93007) = none := by decide
example : decimalDigit (Char.ofNat 93008) = some 0 := by decide
example : decimalDigit (Char.ofNat 93009) = some 1 := by decide
example : decimalDigit (Char.ofNat 93010) = some 2 := by decide
example : decimalDigit (Char.ofNat 93011) = some 3 := by decide
example : decimalDigit (Char.ofNat 93012) = some 4 := by decide
example : decimalDigit (Char.ofNat 93013) = some 5 := by decide
example : decimalDigit (Char.ofNat 93014) = some 6 := by decide
example : decimalDigit (Char.ofNat 93015) = some 7 := by decide
example : decimalDigit (Char.ofNat 93016) = some 8 := by decide
example : decimalDigit (Char.ofNat 93017) = some 9 := by decide
example : decimalDigit (Char.ofNat 93018) = none := by decide
example : decimalDigit (Char.ofNat 120781) = none := by decide
example : decimalDigit (Char.ofNat 120782) = some 0 := by decide
example : decimalDigit (Char.ofNat 120783) = some 1 := by decide
example : decimalDigit (Char.ofNat 120784) = some 2 := by decide
example : decimalDigit (Char.ofNat 120785) = some 3 := by decide
example : decimalDigit (Char.ofNat 120786) = some 4 := by decide
example : decimalDigit (Char.ofNat 120787) = some 5 := by decide
example : decimalDigit (Char.ofNat 120788) = some 6 := by decide
example : decimalDigit (Char.ofNat 120789) = some 7 := by decide
example : decimalDigit (Char.ofNat 120790) = some 8 := by decide
example : decimalDigit (Char.ofNat 120791) = some 9 := by decide
example : decimalDigit (Char.ofNat 120792) = some 0 := by decide
example : decimalDigit (Char.ofNat 120793) = some 1 := by decide
example : decimalDigit (Char.ofNat 120794) = some 2 := by decide
example : decimalDigit (Char.ofNat 120795) = some 3 := by decide
example : decimalDigit (Char.ofNat 120796) = some 4 := by decide
example : decimalDigit (Char.ofNat 120797) = some 5 := by decide
example : decimalDigit (Char.ofNat 120798) = some 6 := by decide
example : decimalDigit (Char.ofNat 120799) = some 7 := by decide
example : decimalDigit (Char.ofNat 120800) = some 8 := by decide
example : decimalDigit (Char.ofNat 120801) = some 9 := by decide
example : decimalDigit (Char.ofNat 120802) = some 0 := by decide
example : decimalDigit (Char.ofNat 120803) = some 1 := by decide
example : decimalDigit (Char.ofNat 120804) = some 2 := by decide
example : decimalDigit (Char.ofNat 120805) = some 3 := by decide
example : decimalDigit (Char.ofNat 120806) = some 4 := by decide
example : decimalDigit (Char.ofNat 120807) = some 5 := by decide
example : decimalDigit (Char.ofNat 120808) = some 6 := by decide
example : decimalDigit (Char.ofNat 120809) = some 7 := by decide
example : decimalDigit (Char.ofNat 120810) = some 8 := by decide
example : decimalDigit (Char.ofNat 120811) = some 9 := by decide
example : decimalDigit (Char.ofNat 120812) = some 0 := by decide
example : decimalDigit (Char.ofNat 120813) = some 1 := by decide
example : decimalDigit (Char.ofNat 120814) = some 2 := by decide
example : decimalDigit (Char.ofNat 120815) = some 3 := by decide
example : decimalDigit (Char.ofNat 120816) = some 4 := by decide
example : decimalDigit (Char.ofNat 120817) = some 5 := by decide
example : decimalDigit (Char.ofNat 120818) = some 6 := by decide
example : decimalDigit (Char.ofNat 120819) = some 7 := by decide
example : decimalDigit (Char.ofNat 120820) = some 8 := by decide
example : decimalDigit (Char.ofNat 120821) = some 9 := by decide
example : decimalDigit (Char.ofNat 120822) = some 0 := by decide
example : decimalDigit (Char.ofNat 120823) = some 1 := by decide
example : decimalDigit (Char.ofNat 120824) = some 2 := by decide
example : decimalDigit (Char.ofNat 120825) = some 3 := by decide
example : decimalDigit (Char.ofNat 120826) = some 4 := by decide
example : decimalDigit (Char.ofNat 120827) = some 5 := by decide
example : decimalDigit (Char.ofNat 120828) = some 6 := by decide
example : decimalDigit (Char.ofNat 120829) = some 7 := by decide
example : decimalDigit (Char.ofNat 120830) = some 8 := by decide
example : decimalDigit (Char.ofNat 120831) = some 9 := by decide
example : decimalDigit (Char.ofNat 120832) = none := by decide
example : decimalDigit (Char.ofNat 123199) = none := by decide
example : decimalDigit (Char.ofNat 123200) = some 0 := by decide
example : decimalDigit (Char.ofNat 123201) = some 1 := by decide
example : decimalDigit (Char.ofNat 123202) = some 2 := by decide
example : decimalDigit (Char.ofNat 123203) = some 3 := by decide
example : decimalDigit (Char.ofNat 123204) = some 4 := by decide
example : decimalDigit (Char.ofNat 123205) = some 5 := by decide
example : decimalDigit (Char.ofNat 123206) = some 6 := by decide
example : decimalDigit (Char.ofNat 123207) = some 7 := by decide
example : decimalDigit (Char.ofNat 123208) = some 8 := by decide
example : decimalDigit (Char.ofNat 123209) = some 9 := by decide
example : decimalDigit (Char.ofNat 123210) = none := by decide
example : decimalDigit (Char.ofNat 123631) = none := by decide
example : decimalDigit (Char.ofNat 123632) = some 0 := by decide
example : decimalDigit (Char.ofNat 123633) = some 1 := by decide
example : decimalDigit (Char.ofNat 123634) = some 2 := by decide
example : decimalDigit (Char.ofNat 123635) = some 3 := by decide
example : decimalDigit (Char.ofNat 123636) = some 4 := by decide
example : decimalDigit (Char.ofNat 123637) = some 5 := by decide
example : decimalDigit (Char.ofNat 123638) = some 6 := by decide
example : decimalDigit (Char.ofNat 123639) = some 7 := by decide
example : decimalDigit (Char.ofNat 123640) = some 8 := by decide
example : decimalDigit (Char.ofNat 123641) = some 9 := by decide
example : decimalDigit (Char.ofNat 123642) = none := by decide
example : decimalDigit (Char.ofNat 125263) = none := by decide
example : decimalDigit (Char.ofNat 125264) = some 0 := by decide
example : decimalDigit (Char.ofNat 125265) = some 1 := by decide
example : decimalDigit (Char.ofNat 125266) = some 2 := by decide
example : decimalDigit (Char.ofNat 125267) = some 3 := by decide
example : decimalDigit (Char.ofNat 125268) = some 4 := by decide
example : decimalDigit (Char.ofNat 125269) = some 5 := by decide
example : decimalDigit (Char.ofNat 125270) = some 6 := by decide
example : decimalDigit (Char.ofNat 125271) = some 7 := by decide
example : decimalDigit (Char.ofNat 125272) = some 8 := by decide
example : decimalDigit (Char.ofNat 125273) = some 9 := by decide
example : decimalDigit (Char.ofNat 125274) = none := by decide
example : decimalDigit (Char.ofNat 130031) = none := by decide
example : decimalDigit (Char.ofNat 130032) = some 0 := by decide
example : decimalDigit (Char.ofNat 130033) = some 1 := by decide
example : decimalDigit (Char.ofNat 130034) = some 2 := by decide
example : decimalDigit (Char.ofNat 130035) = some 3 := by decide
example : decimalDigit (Char.ofNat 130036) = some 4 := by decide
example : decimalDigit (Char.ofNat 130037) = some 5 := by decide
example : decimalDigit (Char.ofNat 130038) = some 6 := by decide
example : decimalDigit (Char.ofNat 130039) = some 7 := by decide
example : decimalDigit (Char.ofNat 130040) = some 8 := by decide
example : decimalDigit (Char.ofNat 130041) = some 9 := by decide
example : decimalDigit (Char.ofNat 130042) = none := by decide
example : literalResult (positiveLiteral "") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "0") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "00") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "01") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "1") = "1" := by decide
example : literalResult (positiveLiteral "10") = "10" := by decide
example : literalResult (positiveLiteral "100") = "100" := by decide
example : literalResult (positiveLiteral "-1") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "+1") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "1.0") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral " 1") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "1 ") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "1_0") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "٠") = "count literal must be positive" := by decide
example : literalResult (positiveLiteral "٠1") = "1" := by decide
example : literalResult (positiveLiteral "١٢") = "12" := by decide
example : literalResult (positiveLiteral "𝟘1") = "1" := by decide
example : literalResult (positiveLiteral "𝟙𝟚") = "12" := by decide
example : literalResult (positiveLiteral "²") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "½") = "count literal must be a canonical positive generated count" := by decide
example : literalResult (positiveLiteral "１") = "1" := by decide
example : literalResult (positiveLiteral "０１") = "1" := by decide
example : literalResult (positiveLiteral "１２") = "12" := by decide
example : literalResult (positiveLiteral "1١２") = "112" := by decide
