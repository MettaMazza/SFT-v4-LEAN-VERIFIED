import SFT.Computation.Secrecy
open SFT.Computation.Secrecy
def a : Row := ⟨"m0","k0","c0"⟩
def b : Row := ⟨"m1","k1","c1"⟩
def x0 : Model := ⟨[],[],[],[]⟩
example : possibleMessages x0 "v" = [] := rfl
example : possibleMessages x0 "w" = [] := rfl
example : closedLedger x0 = [] := rfl
def x3 : Model := ⟨[],[],[],[("c1","v")]⟩
example : possibleMessages x3 "v" = [] := rfl
example : possibleMessages x3 "w" = [] := rfl
example : closedLedger x3 = [] := rfl
def x6 : Model := ⟨[],[],[],[("c1","w")]⟩
example : possibleMessages x6 "v" = [] := rfl
example : possibleMessages x6 "w" = [] := rfl
example : closedLedger x6 = [] := rfl
def x9 : Model := ⟨[],[],[],[("c0","v")]⟩
example : possibleMessages x9 "v" = [] := rfl
example : possibleMessages x9 "w" = [] := rfl
example : closedLedger x9 = [] := rfl
def x12 : Model := ⟨[],[],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x12 "v" = [] := rfl
example : possibleMessages x12 "w" = [] := rfl
example : closedLedger x12 = [] := rfl
def x15 : Model := ⟨[],[],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x15 "v" = [] := rfl
example : possibleMessages x15 "w" = [] := rfl
example : closedLedger x15 = [] := rfl
def x18 : Model := ⟨[],[],[],[("c0","w")]⟩
example : possibleMessages x18 "v" = [] := rfl
example : possibleMessages x18 "w" = [] := rfl
example : closedLedger x18 = [] := rfl
def x21 : Model := ⟨[],[],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x21 "v" = [] := rfl
example : possibleMessages x21 "w" = [] := rfl
example : closedLedger x21 = [] := rfl
def x24 : Model := ⟨[],[],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x24 "v" = [] := rfl
example : possibleMessages x24 "w" = [] := rfl
example : closedLedger x24 = [] := rfl
def x27 : Model := ⟨[],[],[a],[]⟩
example : possibleMessages x27 "v" = [] := rfl
example : possibleMessages x27 "w" = [] := rfl
example : closedLedger x27 = [] := rfl
def x30 : Model := ⟨[],[],[a],[("c1","v")]⟩
example : possibleMessages x30 "v" = [] := rfl
example : possibleMessages x30 "w" = [] := rfl
example : closedLedger x30 = [] := rfl
def x33 : Model := ⟨[],[],[a],[("c1","w")]⟩
example : possibleMessages x33 "v" = [] := rfl
example : possibleMessages x33 "w" = [] := rfl
example : closedLedger x33 = [] := rfl
def x36 : Model := ⟨[],[],[a],[("c0","v")]⟩
example : possibleMessages x36 "v" = [] := rfl
example : possibleMessages x36 "w" = [] := rfl
example : closedLedger x36 = [] := rfl
def x39 : Model := ⟨[],[],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x39 "v" = [] := rfl
example : possibleMessages x39 "w" = [] := rfl
example : closedLedger x39 = [] := rfl
def x42 : Model := ⟨[],[],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x42 "v" = [] := rfl
example : possibleMessages x42 "w" = [] := rfl
example : closedLedger x42 = [] := rfl
def x45 : Model := ⟨[],[],[a],[("c0","w")]⟩
example : possibleMessages x45 "v" = [] := rfl
example : possibleMessages x45 "w" = [] := rfl
example : closedLedger x45 = [] := rfl
def x48 : Model := ⟨[],[],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x48 "v" = [] := rfl
example : possibleMessages x48 "w" = [] := rfl
example : closedLedger x48 = [] := rfl
def x51 : Model := ⟨[],[],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x51 "v" = [] := rfl
example : possibleMessages x51 "w" = [] := rfl
example : closedLedger x51 = [] := rfl
def x54 : Model := ⟨[],[],[b],[]⟩
example : possibleMessages x54 "v" = [] := rfl
example : possibleMessages x54 "w" = [] := rfl
example : closedLedger x54 = [] := rfl
def x57 : Model := ⟨[],[],[b],[("c1","v")]⟩
example : possibleMessages x57 "v" = [] := rfl
example : possibleMessages x57 "w" = [] := rfl
example : closedLedger x57 = [] := rfl
def x60 : Model := ⟨[],[],[b],[("c1","w")]⟩
example : possibleMessages x60 "v" = [] := rfl
example : possibleMessages x60 "w" = [] := rfl
example : closedLedger x60 = [] := rfl
def x63 : Model := ⟨[],[],[b],[("c0","v")]⟩
example : possibleMessages x63 "v" = [] := rfl
example : possibleMessages x63 "w" = [] := rfl
example : closedLedger x63 = [] := rfl
def x66 : Model := ⟨[],[],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x66 "v" = [] := rfl
example : possibleMessages x66 "w" = [] := rfl
example : closedLedger x66 = [] := rfl
def x69 : Model := ⟨[],[],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x69 "v" = [] := rfl
example : possibleMessages x69 "w" = [] := rfl
example : closedLedger x69 = [] := rfl
def x72 : Model := ⟨[],[],[b],[("c0","w")]⟩
example : possibleMessages x72 "v" = [] := rfl
example : possibleMessages x72 "w" = [] := rfl
example : closedLedger x72 = [] := rfl
def x75 : Model := ⟨[],[],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x75 "v" = [] := rfl
example : possibleMessages x75 "w" = [] := rfl
example : closedLedger x75 = [] := rfl
def x78 : Model := ⟨[],[],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x78 "v" = [] := rfl
example : possibleMessages x78 "w" = [] := rfl
example : closedLedger x78 = [] := rfl
def x81 : Model := ⟨[],[],[a,b],[]⟩
example : possibleMessages x81 "v" = [] := rfl
example : possibleMessages x81 "w" = [] := rfl
example : closedLedger x81 = [] := rfl
def x84 : Model := ⟨[],[],[a,b],[("c1","v")]⟩
example : possibleMessages x84 "v" = [] := rfl
example : possibleMessages x84 "w" = [] := rfl
example : closedLedger x84 = [] := rfl
def x87 : Model := ⟨[],[],[a,b],[("c1","w")]⟩
example : possibleMessages x87 "v" = [] := rfl
example : possibleMessages x87 "w" = [] := rfl
example : closedLedger x87 = [] := rfl
def x90 : Model := ⟨[],[],[a,b],[("c0","v")]⟩
example : possibleMessages x90 "v" = [] := rfl
example : possibleMessages x90 "w" = [] := rfl
example : closedLedger x90 = [] := rfl
def x93 : Model := ⟨[],[],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x93 "v" = [] := rfl
example : possibleMessages x93 "w" = [] := rfl
example : closedLedger x93 = [] := rfl
def x96 : Model := ⟨[],[],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x96 "v" = [] := rfl
example : possibleMessages x96 "w" = [] := rfl
example : closedLedger x96 = [] := rfl
def x99 : Model := ⟨[],[],[a,b],[("c0","w")]⟩
example : possibleMessages x99 "v" = [] := rfl
example : possibleMessages x99 "w" = [] := rfl
example : closedLedger x99 = [] := rfl
def x102 : Model := ⟨[],[],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x102 "v" = [] := rfl
example : possibleMessages x102 "w" = [] := rfl
example : closedLedger x102 = [] := rfl
def x105 : Model := ⟨[],[],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x105 "v" = [] := rfl
example : possibleMessages x105 "w" = [] := rfl
example : closedLedger x105 = [] := rfl
def x108 : Model := ⟨[],["k0"],[],[]⟩
example : possibleMessages x108 "v" = [] := rfl
example : possibleMessages x108 "w" = [] := rfl
example : closedLedger x108 = [] := rfl
def x111 : Model := ⟨[],["k0"],[],[("c1","v")]⟩
example : possibleMessages x111 "v" = [] := rfl
example : possibleMessages x111 "w" = [] := rfl
example : closedLedger x111 = [] := rfl
def x114 : Model := ⟨[],["k0"],[],[("c1","w")]⟩
example : possibleMessages x114 "v" = [] := rfl
example : possibleMessages x114 "w" = [] := rfl
example : closedLedger x114 = [] := rfl
def x117 : Model := ⟨[],["k0"],[],[("c0","v")]⟩
example : possibleMessages x117 "v" = [] := rfl
example : possibleMessages x117 "w" = [] := rfl
example : closedLedger x117 = [] := rfl
def x120 : Model := ⟨[],["k0"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x120 "v" = [] := rfl
example : possibleMessages x120 "w" = [] := rfl
example : closedLedger x120 = [] := rfl
def x123 : Model := ⟨[],["k0"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x123 "v" = [] := rfl
example : possibleMessages x123 "w" = [] := rfl
example : closedLedger x123 = [] := rfl
def x126 : Model := ⟨[],["k0"],[],[("c0","w")]⟩
example : possibleMessages x126 "v" = [] := rfl
example : possibleMessages x126 "w" = [] := rfl
example : closedLedger x126 = [] := rfl
def x129 : Model := ⟨[],["k0"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x129 "v" = [] := rfl
example : possibleMessages x129 "w" = [] := rfl
example : closedLedger x129 = [] := rfl
def x132 : Model := ⟨[],["k0"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x132 "v" = [] := rfl
example : possibleMessages x132 "w" = [] := rfl
example : closedLedger x132 = [] := rfl
def x135 : Model := ⟨[],["k0"],[a],[]⟩
example : possibleMessages x135 "v" = [] := rfl
example : possibleMessages x135 "w" = [] := rfl
example : closedLedger x135 = [] := rfl
def x138 : Model := ⟨[],["k0"],[a],[("c1","v")]⟩
example : possibleMessages x138 "v" = [] := rfl
example : possibleMessages x138 "w" = [] := rfl
example : closedLedger x138 = [] := rfl
def x141 : Model := ⟨[],["k0"],[a],[("c1","w")]⟩
example : possibleMessages x141 "v" = [] := rfl
example : possibleMessages x141 "w" = [] := rfl
example : closedLedger x141 = [] := rfl
def x144 : Model := ⟨[],["k0"],[a],[("c0","v")]⟩
example : possibleMessages x144 "v" = [] := rfl
example : possibleMessages x144 "w" = [] := rfl
example : closedLedger x144 = [] := rfl
def x147 : Model := ⟨[],["k0"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x147 "v" = [] := rfl
example : possibleMessages x147 "w" = [] := rfl
example : closedLedger x147 = [] := rfl
def x150 : Model := ⟨[],["k0"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x150 "v" = [] := rfl
example : possibleMessages x150 "w" = [] := rfl
example : closedLedger x150 = [] := rfl
def x153 : Model := ⟨[],["k0"],[a],[("c0","w")]⟩
example : possibleMessages x153 "v" = [] := rfl
example : possibleMessages x153 "w" = [] := rfl
example : closedLedger x153 = [] := rfl
def x156 : Model := ⟨[],["k0"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x156 "v" = [] := rfl
example : possibleMessages x156 "w" = [] := rfl
example : closedLedger x156 = [] := rfl
def x159 : Model := ⟨[],["k0"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x159 "v" = [] := rfl
example : possibleMessages x159 "w" = [] := rfl
example : closedLedger x159 = [] := rfl
def x162 : Model := ⟨[],["k0"],[b],[]⟩
example : possibleMessages x162 "v" = [] := rfl
example : possibleMessages x162 "w" = [] := rfl
example : closedLedger x162 = [] := rfl
def x165 : Model := ⟨[],["k0"],[b],[("c1","v")]⟩
example : possibleMessages x165 "v" = [] := rfl
example : possibleMessages x165 "w" = [] := rfl
example : closedLedger x165 = [] := rfl
def x168 : Model := ⟨[],["k0"],[b],[("c1","w")]⟩
example : possibleMessages x168 "v" = [] := rfl
example : possibleMessages x168 "w" = [] := rfl
example : closedLedger x168 = [] := rfl
def x171 : Model := ⟨[],["k0"],[b],[("c0","v")]⟩
example : possibleMessages x171 "v" = [] := rfl
example : possibleMessages x171 "w" = [] := rfl
example : closedLedger x171 = [] := rfl
def x174 : Model := ⟨[],["k0"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x174 "v" = [] := rfl
example : possibleMessages x174 "w" = [] := rfl
example : closedLedger x174 = [] := rfl
def x177 : Model := ⟨[],["k0"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x177 "v" = [] := rfl
example : possibleMessages x177 "w" = [] := rfl
example : closedLedger x177 = [] := rfl
def x180 : Model := ⟨[],["k0"],[b],[("c0","w")]⟩
example : possibleMessages x180 "v" = [] := rfl
example : possibleMessages x180 "w" = [] := rfl
example : closedLedger x180 = [] := rfl
def x183 : Model := ⟨[],["k0"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x183 "v" = [] := rfl
example : possibleMessages x183 "w" = [] := rfl
example : closedLedger x183 = [] := rfl
def x186 : Model := ⟨[],["k0"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x186 "v" = [] := rfl
example : possibleMessages x186 "w" = [] := rfl
example : closedLedger x186 = [] := rfl
def x189 : Model := ⟨[],["k0"],[a,b],[]⟩
example : possibleMessages x189 "v" = [] := rfl
example : possibleMessages x189 "w" = [] := rfl
example : closedLedger x189 = [] := rfl
def x192 : Model := ⟨[],["k0"],[a,b],[("c1","v")]⟩
example : possibleMessages x192 "v" = [] := rfl
example : possibleMessages x192 "w" = [] := rfl
example : closedLedger x192 = [] := rfl
def x195 : Model := ⟨[],["k0"],[a,b],[("c1","w")]⟩
example : possibleMessages x195 "v" = [] := rfl
example : possibleMessages x195 "w" = [] := rfl
example : closedLedger x195 = [] := rfl
def x198 : Model := ⟨[],["k0"],[a,b],[("c0","v")]⟩
example : possibleMessages x198 "v" = [] := rfl
example : possibleMessages x198 "w" = [] := rfl
example : closedLedger x198 = [] := rfl
def x201 : Model := ⟨[],["k0"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x201 "v" = [] := rfl
example : possibleMessages x201 "w" = [] := rfl
example : closedLedger x201 = [] := rfl
def x204 : Model := ⟨[],["k0"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x204 "v" = [] := rfl
example : possibleMessages x204 "w" = [] := rfl
example : closedLedger x204 = [] := rfl
def x207 : Model := ⟨[],["k0"],[a,b],[("c0","w")]⟩
example : possibleMessages x207 "v" = [] := rfl
example : possibleMessages x207 "w" = [] := rfl
example : closedLedger x207 = [] := rfl
def x210 : Model := ⟨[],["k0"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x210 "v" = [] := rfl
example : possibleMessages x210 "w" = [] := rfl
example : closedLedger x210 = [] := rfl
def x213 : Model := ⟨[],["k0"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x213 "v" = [] := rfl
example : possibleMessages x213 "w" = [] := rfl
example : closedLedger x213 = [] := rfl
def x216 : Model := ⟨[],["k1"],[],[]⟩
example : possibleMessages x216 "v" = [] := rfl
example : possibleMessages x216 "w" = [] := rfl
example : closedLedger x216 = [] := rfl
def x219 : Model := ⟨[],["k1"],[],[("c1","v")]⟩
example : possibleMessages x219 "v" = [] := rfl
example : possibleMessages x219 "w" = [] := rfl
example : closedLedger x219 = [] := rfl
def x222 : Model := ⟨[],["k1"],[],[("c1","w")]⟩
example : possibleMessages x222 "v" = [] := rfl
example : possibleMessages x222 "w" = [] := rfl
example : closedLedger x222 = [] := rfl
def x225 : Model := ⟨[],["k1"],[],[("c0","v")]⟩
example : possibleMessages x225 "v" = [] := rfl
example : possibleMessages x225 "w" = [] := rfl
example : closedLedger x225 = [] := rfl
def x228 : Model := ⟨[],["k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x228 "v" = [] := rfl
example : possibleMessages x228 "w" = [] := rfl
example : closedLedger x228 = [] := rfl
def x231 : Model := ⟨[],["k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x231 "v" = [] := rfl
example : possibleMessages x231 "w" = [] := rfl
example : closedLedger x231 = [] := rfl
def x234 : Model := ⟨[],["k1"],[],[("c0","w")]⟩
example : possibleMessages x234 "v" = [] := rfl
example : possibleMessages x234 "w" = [] := rfl
example : closedLedger x234 = [] := rfl
def x237 : Model := ⟨[],["k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x237 "v" = [] := rfl
example : possibleMessages x237 "w" = [] := rfl
example : closedLedger x237 = [] := rfl
def x240 : Model := ⟨[],["k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x240 "v" = [] := rfl
example : possibleMessages x240 "w" = [] := rfl
example : closedLedger x240 = [] := rfl
def x243 : Model := ⟨[],["k1"],[a],[]⟩
example : possibleMessages x243 "v" = [] := rfl
example : possibleMessages x243 "w" = [] := rfl
example : closedLedger x243 = [] := rfl
def x246 : Model := ⟨[],["k1"],[a],[("c1","v")]⟩
example : possibleMessages x246 "v" = [] := rfl
example : possibleMessages x246 "w" = [] := rfl
example : closedLedger x246 = [] := rfl
def x249 : Model := ⟨[],["k1"],[a],[("c1","w")]⟩
example : possibleMessages x249 "v" = [] := rfl
example : possibleMessages x249 "w" = [] := rfl
example : closedLedger x249 = [] := rfl
def x252 : Model := ⟨[],["k1"],[a],[("c0","v")]⟩
example : possibleMessages x252 "v" = [] := rfl
example : possibleMessages x252 "w" = [] := rfl
example : closedLedger x252 = [] := rfl
def x255 : Model := ⟨[],["k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x255 "v" = [] := rfl
example : possibleMessages x255 "w" = [] := rfl
example : closedLedger x255 = [] := rfl
def x258 : Model := ⟨[],["k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x258 "v" = [] := rfl
example : possibleMessages x258 "w" = [] := rfl
example : closedLedger x258 = [] := rfl
def x261 : Model := ⟨[],["k1"],[a],[("c0","w")]⟩
example : possibleMessages x261 "v" = [] := rfl
example : possibleMessages x261 "w" = [] := rfl
example : closedLedger x261 = [] := rfl
def x264 : Model := ⟨[],["k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x264 "v" = [] := rfl
example : possibleMessages x264 "w" = [] := rfl
example : closedLedger x264 = [] := rfl
def x267 : Model := ⟨[],["k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x267 "v" = [] := rfl
example : possibleMessages x267 "w" = [] := rfl
example : closedLedger x267 = [] := rfl
def x270 : Model := ⟨[],["k1"],[b],[]⟩
example : possibleMessages x270 "v" = [] := rfl
example : possibleMessages x270 "w" = [] := rfl
example : closedLedger x270 = [] := rfl
def x273 : Model := ⟨[],["k1"],[b],[("c1","v")]⟩
example : possibleMessages x273 "v" = [] := rfl
example : possibleMessages x273 "w" = [] := rfl
example : closedLedger x273 = [] := rfl
def x276 : Model := ⟨[],["k1"],[b],[("c1","w")]⟩
example : possibleMessages x276 "v" = [] := rfl
example : possibleMessages x276 "w" = [] := rfl
example : closedLedger x276 = [] := rfl
def x279 : Model := ⟨[],["k1"],[b],[("c0","v")]⟩
example : possibleMessages x279 "v" = [] := rfl
example : possibleMessages x279 "w" = [] := rfl
example : closedLedger x279 = [] := rfl
def x282 : Model := ⟨[],["k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x282 "v" = [] := rfl
example : possibleMessages x282 "w" = [] := rfl
example : closedLedger x282 = [] := rfl
def x285 : Model := ⟨[],["k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x285 "v" = [] := rfl
example : possibleMessages x285 "w" = [] := rfl
example : closedLedger x285 = [] := rfl
def x288 : Model := ⟨[],["k1"],[b],[("c0","w")]⟩
example : possibleMessages x288 "v" = [] := rfl
example : possibleMessages x288 "w" = [] := rfl
example : closedLedger x288 = [] := rfl
def x291 : Model := ⟨[],["k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x291 "v" = [] := rfl
example : possibleMessages x291 "w" = [] := rfl
example : closedLedger x291 = [] := rfl
def x294 : Model := ⟨[],["k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x294 "v" = [] := rfl
example : possibleMessages x294 "w" = [] := rfl
example : closedLedger x294 = [] := rfl
def x297 : Model := ⟨[],["k1"],[a,b],[]⟩
example : possibleMessages x297 "v" = [] := rfl
example : possibleMessages x297 "w" = [] := rfl
example : closedLedger x297 = [] := rfl
def x300 : Model := ⟨[],["k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x300 "v" = [] := rfl
example : possibleMessages x300 "w" = [] := rfl
example : closedLedger x300 = [] := rfl
def x303 : Model := ⟨[],["k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x303 "v" = [] := rfl
example : possibleMessages x303 "w" = [] := rfl
example : closedLedger x303 = [] := rfl
def x306 : Model := ⟨[],["k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x306 "v" = [] := rfl
example : possibleMessages x306 "w" = [] := rfl
example : closedLedger x306 = [] := rfl
def x309 : Model := ⟨[],["k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x309 "v" = [] := rfl
example : possibleMessages x309 "w" = [] := rfl
example : closedLedger x309 = [] := rfl
def x312 : Model := ⟨[],["k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x312 "v" = [] := rfl
example : possibleMessages x312 "w" = [] := rfl
example : closedLedger x312 = [] := rfl
def x315 : Model := ⟨[],["k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x315 "v" = [] := rfl
example : possibleMessages x315 "w" = [] := rfl
example : closedLedger x315 = [] := rfl
def x318 : Model := ⟨[],["k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x318 "v" = [] := rfl
example : possibleMessages x318 "w" = [] := rfl
example : closedLedger x318 = [] := rfl
def x321 : Model := ⟨[],["k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x321 "v" = [] := rfl
example : possibleMessages x321 "w" = [] := rfl
example : closedLedger x321 = [] := rfl
def x324 : Model := ⟨[],["k0","k1"],[],[]⟩
example : possibleMessages x324 "v" = [] := rfl
example : possibleMessages x324 "w" = [] := rfl
example : closedLedger x324 = [] := rfl
def x327 : Model := ⟨[],["k0","k1"],[],[("c1","v")]⟩
example : possibleMessages x327 "v" = [] := rfl
example : possibleMessages x327 "w" = [] := rfl
example : closedLedger x327 = [] := rfl
def x330 : Model := ⟨[],["k0","k1"],[],[("c1","w")]⟩
example : possibleMessages x330 "v" = [] := rfl
example : possibleMessages x330 "w" = [] := rfl
example : closedLedger x330 = [] := rfl
def x333 : Model := ⟨[],["k0","k1"],[],[("c0","v")]⟩
example : possibleMessages x333 "v" = [] := rfl
example : possibleMessages x333 "w" = [] := rfl
example : closedLedger x333 = [] := rfl
def x336 : Model := ⟨[],["k0","k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x336 "v" = [] := rfl
example : possibleMessages x336 "w" = [] := rfl
example : closedLedger x336 = [] := rfl
def x339 : Model := ⟨[],["k0","k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x339 "v" = [] := rfl
example : possibleMessages x339 "w" = [] := rfl
example : closedLedger x339 = [] := rfl
def x342 : Model := ⟨[],["k0","k1"],[],[("c0","w")]⟩
example : possibleMessages x342 "v" = [] := rfl
example : possibleMessages x342 "w" = [] := rfl
example : closedLedger x342 = [] := rfl
def x345 : Model := ⟨[],["k0","k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x345 "v" = [] := rfl
example : possibleMessages x345 "w" = [] := rfl
example : closedLedger x345 = [] := rfl
def x348 : Model := ⟨[],["k0","k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x348 "v" = [] := rfl
example : possibleMessages x348 "w" = [] := rfl
example : closedLedger x348 = [] := rfl
def x351 : Model := ⟨[],["k0","k1"],[a],[]⟩
example : possibleMessages x351 "v" = [] := rfl
example : possibleMessages x351 "w" = [] := rfl
example : closedLedger x351 = [] := rfl
def x354 : Model := ⟨[],["k0","k1"],[a],[("c1","v")]⟩
example : possibleMessages x354 "v" = [] := rfl
example : possibleMessages x354 "w" = [] := rfl
example : closedLedger x354 = [] := rfl
def x357 : Model := ⟨[],["k0","k1"],[a],[("c1","w")]⟩
example : possibleMessages x357 "v" = [] := rfl
example : possibleMessages x357 "w" = [] := rfl
example : closedLedger x357 = [] := rfl
def x360 : Model := ⟨[],["k0","k1"],[a],[("c0","v")]⟩
example : possibleMessages x360 "v" = [] := rfl
example : possibleMessages x360 "w" = [] := rfl
example : closedLedger x360 = [] := rfl
def x363 : Model := ⟨[],["k0","k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x363 "v" = [] := rfl
example : possibleMessages x363 "w" = [] := rfl
example : closedLedger x363 = [] := rfl
def x366 : Model := ⟨[],["k0","k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x366 "v" = [] := rfl
example : possibleMessages x366 "w" = [] := rfl
example : closedLedger x366 = [] := rfl
def x369 : Model := ⟨[],["k0","k1"],[a],[("c0","w")]⟩
example : possibleMessages x369 "v" = [] := rfl
example : possibleMessages x369 "w" = [] := rfl
example : closedLedger x369 = [] := rfl
def x372 : Model := ⟨[],["k0","k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x372 "v" = [] := rfl
example : possibleMessages x372 "w" = [] := rfl
example : closedLedger x372 = [] := rfl
def x375 : Model := ⟨[],["k0","k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x375 "v" = [] := rfl
example : possibleMessages x375 "w" = [] := rfl
example : closedLedger x375 = [] := rfl
def x378 : Model := ⟨[],["k0","k1"],[b],[]⟩
example : possibleMessages x378 "v" = [] := rfl
example : possibleMessages x378 "w" = [] := rfl
example : closedLedger x378 = [] := rfl
def x381 : Model := ⟨[],["k0","k1"],[b],[("c1","v")]⟩
example : possibleMessages x381 "v" = [] := rfl
example : possibleMessages x381 "w" = [] := rfl
example : closedLedger x381 = [] := rfl
def x384 : Model := ⟨[],["k0","k1"],[b],[("c1","w")]⟩
example : possibleMessages x384 "v" = [] := rfl
example : possibleMessages x384 "w" = [] := rfl
example : closedLedger x384 = [] := rfl
def x387 : Model := ⟨[],["k0","k1"],[b],[("c0","v")]⟩
example : possibleMessages x387 "v" = [] := rfl
example : possibleMessages x387 "w" = [] := rfl
example : closedLedger x387 = [] := rfl
def x390 : Model := ⟨[],["k0","k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x390 "v" = [] := rfl
example : possibleMessages x390 "w" = [] := rfl
example : closedLedger x390 = [] := rfl
def x393 : Model := ⟨[],["k0","k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x393 "v" = [] := rfl
example : possibleMessages x393 "w" = [] := rfl
example : closedLedger x393 = [] := rfl
def x396 : Model := ⟨[],["k0","k1"],[b],[("c0","w")]⟩
example : possibleMessages x396 "v" = [] := rfl
example : possibleMessages x396 "w" = [] := rfl
example : closedLedger x396 = [] := rfl
def x399 : Model := ⟨[],["k0","k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x399 "v" = [] := rfl
example : possibleMessages x399 "w" = [] := rfl
example : closedLedger x399 = [] := rfl
def x402 : Model := ⟨[],["k0","k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x402 "v" = [] := rfl
example : possibleMessages x402 "w" = [] := rfl
example : closedLedger x402 = [] := rfl
def x405 : Model := ⟨[],["k0","k1"],[a,b],[]⟩
example : possibleMessages x405 "v" = [] := rfl
example : possibleMessages x405 "w" = [] := rfl
example : closedLedger x405 = [] := rfl
def x408 : Model := ⟨[],["k0","k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x408 "v" = [] := rfl
example : possibleMessages x408 "w" = [] := rfl
example : closedLedger x408 = [] := rfl
def x411 : Model := ⟨[],["k0","k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x411 "v" = [] := rfl
example : possibleMessages x411 "w" = [] := rfl
example : closedLedger x411 = [] := rfl
def x414 : Model := ⟨[],["k0","k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x414 "v" = [] := rfl
example : possibleMessages x414 "w" = [] := rfl
example : closedLedger x414 = [] := rfl
def x417 : Model := ⟨[],["k0","k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x417 "v" = [] := rfl
example : possibleMessages x417 "w" = [] := rfl
example : closedLedger x417 = [] := rfl
def x420 : Model := ⟨[],["k0","k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x420 "v" = [] := rfl
example : possibleMessages x420 "w" = [] := rfl
example : closedLedger x420 = [] := rfl
def x423 : Model := ⟨[],["k0","k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x423 "v" = [] := rfl
example : possibleMessages x423 "w" = [] := rfl
example : closedLedger x423 = [] := rfl
def x426 : Model := ⟨[],["k0","k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x426 "v" = [] := rfl
example : possibleMessages x426 "w" = [] := rfl
example : closedLedger x426 = [] := rfl
def x429 : Model := ⟨[],["k0","k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x429 "v" = [] := rfl
example : possibleMessages x429 "w" = [] := rfl
example : closedLedger x429 = [] := rfl
def x432 : Model := ⟨["m0"],[],[],[]⟩
example : possibleMessages x432 "v" = [] := rfl
example : possibleMessages x432 "w" = [] := rfl
example : closedLedger x432 = [] := rfl
def x435 : Model := ⟨["m0"],[],[],[("c1","v")]⟩
example : possibleMessages x435 "v" = [] := rfl
example : possibleMessages x435 "w" = [] := rfl
example : closedLedger x435 = [] := rfl
def x438 : Model := ⟨["m0"],[],[],[("c1","w")]⟩
example : possibleMessages x438 "v" = [] := rfl
example : possibleMessages x438 "w" = [] := rfl
example : closedLedger x438 = [] := rfl
def x441 : Model := ⟨["m0"],[],[],[("c0","v")]⟩
example : possibleMessages x441 "v" = [] := rfl
example : possibleMessages x441 "w" = [] := rfl
example : closedLedger x441 = [] := rfl
def x444 : Model := ⟨["m0"],[],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x444 "v" = [] := rfl
example : possibleMessages x444 "w" = [] := rfl
example : closedLedger x444 = [] := rfl
def x447 : Model := ⟨["m0"],[],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x447 "v" = [] := rfl
example : possibleMessages x447 "w" = [] := rfl
example : closedLedger x447 = [] := rfl
def x450 : Model := ⟨["m0"],[],[],[("c0","w")]⟩
example : possibleMessages x450 "v" = [] := rfl
example : possibleMessages x450 "w" = [] := rfl
example : closedLedger x450 = [] := rfl
def x453 : Model := ⟨["m0"],[],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x453 "v" = [] := rfl
example : possibleMessages x453 "w" = [] := rfl
example : closedLedger x453 = [] := rfl
def x456 : Model := ⟨["m0"],[],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x456 "v" = [] := rfl
example : possibleMessages x456 "w" = [] := rfl
example : closedLedger x456 = [] := rfl
def x459 : Model := ⟨["m0"],[],[a],[]⟩
example : possibleMessages x459 "v" = [] := rfl
example : possibleMessages x459 "w" = [] := rfl
example : closedLedger x459 = [] := rfl
def x462 : Model := ⟨["m0"],[],[a],[("c1","v")]⟩
example : possibleMessages x462 "v" = [] := rfl
example : possibleMessages x462 "w" = [] := rfl
example : closedLedger x462 = [] := rfl
def x465 : Model := ⟨["m0"],[],[a],[("c1","w")]⟩
example : possibleMessages x465 "v" = [] := rfl
example : possibleMessages x465 "w" = [] := rfl
example : closedLedger x465 = [] := rfl
def x468 : Model := ⟨["m0"],[],[a],[("c0","v")]⟩
example : possibleMessages x468 "v" = [] := rfl
example : possibleMessages x468 "w" = [] := rfl
example : closedLedger x468 = [] := rfl
def x471 : Model := ⟨["m0"],[],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x471 "v" = [] := rfl
example : possibleMessages x471 "w" = [] := rfl
example : closedLedger x471 = [] := rfl
def x474 : Model := ⟨["m0"],[],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x474 "v" = [] := rfl
example : possibleMessages x474 "w" = [] := rfl
example : closedLedger x474 = [] := rfl
def x477 : Model := ⟨["m0"],[],[a],[("c0","w")]⟩
example : possibleMessages x477 "v" = [] := rfl
example : possibleMessages x477 "w" = [] := rfl
example : closedLedger x477 = [] := rfl
def x480 : Model := ⟨["m0"],[],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x480 "v" = [] := rfl
example : possibleMessages x480 "w" = [] := rfl
example : closedLedger x480 = [] := rfl
def x483 : Model := ⟨["m0"],[],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x483 "v" = [] := rfl
example : possibleMessages x483 "w" = [] := rfl
example : closedLedger x483 = [] := rfl
def x486 : Model := ⟨["m0"],[],[b],[]⟩
example : possibleMessages x486 "v" = [] := rfl
example : possibleMessages x486 "w" = [] := rfl
example : closedLedger x486 = [] := rfl
def x489 : Model := ⟨["m0"],[],[b],[("c1","v")]⟩
example : possibleMessages x489 "v" = [] := rfl
example : possibleMessages x489 "w" = [] := rfl
example : closedLedger x489 = [] := rfl
def x492 : Model := ⟨["m0"],[],[b],[("c1","w")]⟩
example : possibleMessages x492 "v" = [] := rfl
example : possibleMessages x492 "w" = [] := rfl
example : closedLedger x492 = [] := rfl
def x495 : Model := ⟨["m0"],[],[b],[("c0","v")]⟩
example : possibleMessages x495 "v" = [] := rfl
example : possibleMessages x495 "w" = [] := rfl
example : closedLedger x495 = [] := rfl
def x498 : Model := ⟨["m0"],[],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x498 "v" = [] := rfl
example : possibleMessages x498 "w" = [] := rfl
example : closedLedger x498 = [] := rfl
def x501 : Model := ⟨["m0"],[],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x501 "v" = [] := rfl
example : possibleMessages x501 "w" = [] := rfl
example : closedLedger x501 = [] := rfl
def x504 : Model := ⟨["m0"],[],[b],[("c0","w")]⟩
example : possibleMessages x504 "v" = [] := rfl
example : possibleMessages x504 "w" = [] := rfl
example : closedLedger x504 = [] := rfl
def x507 : Model := ⟨["m0"],[],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x507 "v" = [] := rfl
example : possibleMessages x507 "w" = [] := rfl
example : closedLedger x507 = [] := rfl
def x510 : Model := ⟨["m0"],[],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x510 "v" = [] := rfl
example : possibleMessages x510 "w" = [] := rfl
example : closedLedger x510 = [] := rfl
def x513 : Model := ⟨["m0"],[],[a,b],[]⟩
example : possibleMessages x513 "v" = [] := rfl
example : possibleMessages x513 "w" = [] := rfl
example : closedLedger x513 = [] := rfl
def x516 : Model := ⟨["m0"],[],[a,b],[("c1","v")]⟩
example : possibleMessages x516 "v" = [] := rfl
example : possibleMessages x516 "w" = [] := rfl
example : closedLedger x516 = [] := rfl
def x519 : Model := ⟨["m0"],[],[a,b],[("c1","w")]⟩
example : possibleMessages x519 "v" = [] := rfl
example : possibleMessages x519 "w" = [] := rfl
example : closedLedger x519 = [] := rfl
def x522 : Model := ⟨["m0"],[],[a,b],[("c0","v")]⟩
example : possibleMessages x522 "v" = [] := rfl
example : possibleMessages x522 "w" = [] := rfl
example : closedLedger x522 = [] := rfl
def x525 : Model := ⟨["m0"],[],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x525 "v" = [] := rfl
example : possibleMessages x525 "w" = [] := rfl
example : closedLedger x525 = [] := rfl
def x528 : Model := ⟨["m0"],[],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x528 "v" = [] := rfl
example : possibleMessages x528 "w" = [] := rfl
example : closedLedger x528 = [] := rfl
def x531 : Model := ⟨["m0"],[],[a,b],[("c0","w")]⟩
example : possibleMessages x531 "v" = [] := rfl
example : possibleMessages x531 "w" = [] := rfl
example : closedLedger x531 = [] := rfl
def x534 : Model := ⟨["m0"],[],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x534 "v" = [] := rfl
example : possibleMessages x534 "w" = [] := rfl
example : closedLedger x534 = [] := rfl
def x537 : Model := ⟨["m0"],[],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x537 "v" = [] := rfl
example : possibleMessages x537 "w" = [] := rfl
example : closedLedger x537 = [] := rfl
def x540 : Model := ⟨["m0"],["k0"],[],[]⟩
example : possibleMessages x540 "v" = [] := rfl
example : possibleMessages x540 "w" = [] := rfl
example : closedLedger x540 = [] := rfl
def x543 : Model := ⟨["m0"],["k0"],[],[("c1","v")]⟩
example : possibleMessages x543 "v" = [] := rfl
example : possibleMessages x543 "w" = [] := rfl
example : closedLedger x543 = [] := rfl
def x546 : Model := ⟨["m0"],["k0"],[],[("c1","w")]⟩
example : possibleMessages x546 "v" = [] := rfl
example : possibleMessages x546 "w" = [] := rfl
example : closedLedger x546 = [] := rfl
def x549 : Model := ⟨["m0"],["k0"],[],[("c0","v")]⟩
example : possibleMessages x549 "v" = [] := rfl
example : possibleMessages x549 "w" = [] := rfl
example : closedLedger x549 = [] := rfl
def x552 : Model := ⟨["m0"],["k0"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x552 "v" = [] := rfl
example : possibleMessages x552 "w" = [] := rfl
example : closedLedger x552 = [] := rfl
def x555 : Model := ⟨["m0"],["k0"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x555 "v" = [] := rfl
example : possibleMessages x555 "w" = [] := rfl
example : closedLedger x555 = [] := rfl
def x558 : Model := ⟨["m0"],["k0"],[],[("c0","w")]⟩
example : possibleMessages x558 "v" = [] := rfl
example : possibleMessages x558 "w" = [] := rfl
example : closedLedger x558 = [] := rfl
def x561 : Model := ⟨["m0"],["k0"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x561 "v" = [] := rfl
example : possibleMessages x561 "w" = [] := rfl
example : closedLedger x561 = [] := rfl
def x564 : Model := ⟨["m0"],["k0"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x564 "v" = [] := rfl
example : possibleMessages x564 "w" = [] := rfl
example : closedLedger x564 = [] := rfl
def x567 : Model := ⟨["m0"],["k0"],[a],[]⟩
example : possibleMessages x567 "v" = [] := rfl
example : possibleMessages x567 "w" = [] := rfl
example : closedLedger x567 = [] := rfl
def x570 : Model := ⟨["m0"],["k0"],[a],[("c1","v")]⟩
example : possibleMessages x570 "v" = [] := rfl
example : possibleMessages x570 "w" = [] := rfl
example : closedLedger x570 = [] := rfl
def x573 : Model := ⟨["m0"],["k0"],[a],[("c1","w")]⟩
example : possibleMessages x573 "v" = [] := rfl
example : possibleMessages x573 "w" = [] := rfl
example : closedLedger x573 = [] := rfl
def x576 : Model := ⟨["m0"],["k0"],[a],[("c0","v")]⟩
example : possibleMessages x576 "v" = ["m0"] := rfl
example : possibleMessages x576 "w" = [] := rfl
example : closedLedger x576 = [] := rfl
def x579 : Model := ⟨["m0"],["k0"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x579 "v" = ["m0"] := rfl
example : possibleMessages x579 "w" = [] := rfl
example : closedLedger x579 = [] := rfl
def x582 : Model := ⟨["m0"],["k0"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x582 "v" = ["m0"] := rfl
example : possibleMessages x582 "w" = [] := rfl
example : closedLedger x582 = [] := rfl
def x585 : Model := ⟨["m0"],["k0"],[a],[("c0","w")]⟩
example : possibleMessages x585 "v" = [] := rfl
example : possibleMessages x585 "w" = ["m0"] := rfl
example : closedLedger x585 = [] := rfl
def x588 : Model := ⟨["m0"],["k0"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x588 "v" = [] := rfl
example : possibleMessages x588 "w" = ["m0"] := rfl
example : closedLedger x588 = [] := rfl
def x591 : Model := ⟨["m0"],["k0"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x591 "v" = [] := rfl
example : possibleMessages x591 "w" = ["m0"] := rfl
example : closedLedger x591 = [] := rfl
def x594 : Model := ⟨["m0"],["k0"],[b],[]⟩
example : possibleMessages x594 "v" = [] := rfl
example : possibleMessages x594 "w" = [] := rfl
example : closedLedger x594 = [] := rfl
def x597 : Model := ⟨["m0"],["k0"],[b],[("c1","v")]⟩
example : possibleMessages x597 "v" = [] := rfl
example : possibleMessages x597 "w" = [] := rfl
example : closedLedger x597 = [] := rfl
def x600 : Model := ⟨["m0"],["k0"],[b],[("c1","w")]⟩
example : possibleMessages x600 "v" = [] := rfl
example : possibleMessages x600 "w" = [] := rfl
example : closedLedger x600 = [] := rfl
def x603 : Model := ⟨["m0"],["k0"],[b],[("c0","v")]⟩
example : possibleMessages x603 "v" = [] := rfl
example : possibleMessages x603 "w" = [] := rfl
example : closedLedger x603 = [] := rfl
def x606 : Model := ⟨["m0"],["k0"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x606 "v" = [] := rfl
example : possibleMessages x606 "w" = [] := rfl
example : closedLedger x606 = [] := rfl
def x609 : Model := ⟨["m0"],["k0"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x609 "v" = [] := rfl
example : possibleMessages x609 "w" = [] := rfl
example : closedLedger x609 = [] := rfl
def x612 : Model := ⟨["m0"],["k0"],[b],[("c0","w")]⟩
example : possibleMessages x612 "v" = [] := rfl
example : possibleMessages x612 "w" = [] := rfl
example : closedLedger x612 = [] := rfl
def x615 : Model := ⟨["m0"],["k0"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x615 "v" = [] := rfl
example : possibleMessages x615 "w" = [] := rfl
example : closedLedger x615 = [] := rfl
def x618 : Model := ⟨["m0"],["k0"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x618 "v" = [] := rfl
example : possibleMessages x618 "w" = [] := rfl
example : closedLedger x618 = [] := rfl
def x621 : Model := ⟨["m0"],["k0"],[a,b],[]⟩
example : possibleMessages x621 "v" = [] := rfl
example : possibleMessages x621 "w" = [] := rfl
example : closedLedger x621 = [] := rfl
def x624 : Model := ⟨["m0"],["k0"],[a,b],[("c1","v")]⟩
example : possibleMessages x624 "v" = [] := rfl
example : possibleMessages x624 "w" = [] := rfl
example : closedLedger x624 = [] := rfl
def x627 : Model := ⟨["m0"],["k0"],[a,b],[("c1","w")]⟩
example : possibleMessages x627 "v" = [] := rfl
example : possibleMessages x627 "w" = [] := rfl
example : closedLedger x627 = [] := rfl
def x630 : Model := ⟨["m0"],["k0"],[a,b],[("c0","v")]⟩
example : possibleMessages x630 "v" = ["m0"] := rfl
example : possibleMessages x630 "w" = [] := rfl
example : closedLedger x630 = [] := rfl
def x633 : Model := ⟨["m0"],["k0"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x633 "v" = ["m0"] := rfl
example : possibleMessages x633 "w" = [] := rfl
example : closedLedger x633 = [] := rfl
def x636 : Model := ⟨["m0"],["k0"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x636 "v" = ["m0"] := rfl
example : possibleMessages x636 "w" = [] := rfl
example : closedLedger x636 = [] := rfl
def x639 : Model := ⟨["m0"],["k0"],[a,b],[("c0","w")]⟩
example : possibleMessages x639 "v" = [] := rfl
example : possibleMessages x639 "w" = ["m0"] := rfl
example : closedLedger x639 = [] := rfl
def x642 : Model := ⟨["m0"],["k0"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x642 "v" = [] := rfl
example : possibleMessages x642 "w" = ["m0"] := rfl
example : closedLedger x642 = [] := rfl
def x645 : Model := ⟨["m0"],["k0"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x645 "v" = [] := rfl
example : possibleMessages x645 "w" = ["m0"] := rfl
example : closedLedger x645 = [] := rfl
def x648 : Model := ⟨["m0"],["k1"],[],[]⟩
example : possibleMessages x648 "v" = [] := rfl
example : possibleMessages x648 "w" = [] := rfl
example : closedLedger x648 = [] := rfl
def x651 : Model := ⟨["m0"],["k1"],[],[("c1","v")]⟩
example : possibleMessages x651 "v" = [] := rfl
example : possibleMessages x651 "w" = [] := rfl
example : closedLedger x651 = [] := rfl
def x654 : Model := ⟨["m0"],["k1"],[],[("c1","w")]⟩
example : possibleMessages x654 "v" = [] := rfl
example : possibleMessages x654 "w" = [] := rfl
example : closedLedger x654 = [] := rfl
def x657 : Model := ⟨["m0"],["k1"],[],[("c0","v")]⟩
example : possibleMessages x657 "v" = [] := rfl
example : possibleMessages x657 "w" = [] := rfl
example : closedLedger x657 = [] := rfl
def x660 : Model := ⟨["m0"],["k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x660 "v" = [] := rfl
example : possibleMessages x660 "w" = [] := rfl
example : closedLedger x660 = [] := rfl
def x663 : Model := ⟨["m0"],["k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x663 "v" = [] := rfl
example : possibleMessages x663 "w" = [] := rfl
example : closedLedger x663 = [] := rfl
def x666 : Model := ⟨["m0"],["k1"],[],[("c0","w")]⟩
example : possibleMessages x666 "v" = [] := rfl
example : possibleMessages x666 "w" = [] := rfl
example : closedLedger x666 = [] := rfl
def x669 : Model := ⟨["m0"],["k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x669 "v" = [] := rfl
example : possibleMessages x669 "w" = [] := rfl
example : closedLedger x669 = [] := rfl
def x672 : Model := ⟨["m0"],["k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x672 "v" = [] := rfl
example : possibleMessages x672 "w" = [] := rfl
example : closedLedger x672 = [] := rfl
def x675 : Model := ⟨["m0"],["k1"],[a],[]⟩
example : possibleMessages x675 "v" = [] := rfl
example : possibleMessages x675 "w" = [] := rfl
example : closedLedger x675 = [] := rfl
def x678 : Model := ⟨["m0"],["k1"],[a],[("c1","v")]⟩
example : possibleMessages x678 "v" = [] := rfl
example : possibleMessages x678 "w" = [] := rfl
example : closedLedger x678 = [] := rfl
def x681 : Model := ⟨["m0"],["k1"],[a],[("c1","w")]⟩
example : possibleMessages x681 "v" = [] := rfl
example : possibleMessages x681 "w" = [] := rfl
example : closedLedger x681 = [] := rfl
def x684 : Model := ⟨["m0"],["k1"],[a],[("c0","v")]⟩
example : possibleMessages x684 "v" = [] := rfl
example : possibleMessages x684 "w" = [] := rfl
example : closedLedger x684 = [] := rfl
def x687 : Model := ⟨["m0"],["k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x687 "v" = [] := rfl
example : possibleMessages x687 "w" = [] := rfl
example : closedLedger x687 = [] := rfl
def x690 : Model := ⟨["m0"],["k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x690 "v" = [] := rfl
example : possibleMessages x690 "w" = [] := rfl
example : closedLedger x690 = [] := rfl
def x693 : Model := ⟨["m0"],["k1"],[a],[("c0","w")]⟩
example : possibleMessages x693 "v" = [] := rfl
example : possibleMessages x693 "w" = [] := rfl
example : closedLedger x693 = [] := rfl
def x696 : Model := ⟨["m0"],["k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x696 "v" = [] := rfl
example : possibleMessages x696 "w" = [] := rfl
example : closedLedger x696 = [] := rfl
def x699 : Model := ⟨["m0"],["k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x699 "v" = [] := rfl
example : possibleMessages x699 "w" = [] := rfl
example : closedLedger x699 = [] := rfl
def x702 : Model := ⟨["m0"],["k1"],[b],[]⟩
example : possibleMessages x702 "v" = [] := rfl
example : possibleMessages x702 "w" = [] := rfl
example : closedLedger x702 = [] := rfl
def x705 : Model := ⟨["m0"],["k1"],[b],[("c1","v")]⟩
example : possibleMessages x705 "v" = [] := rfl
example : possibleMessages x705 "w" = [] := rfl
example : closedLedger x705 = [] := rfl
def x708 : Model := ⟨["m0"],["k1"],[b],[("c1","w")]⟩
example : possibleMessages x708 "v" = [] := rfl
example : possibleMessages x708 "w" = [] := rfl
example : closedLedger x708 = [] := rfl
def x711 : Model := ⟨["m0"],["k1"],[b],[("c0","v")]⟩
example : possibleMessages x711 "v" = [] := rfl
example : possibleMessages x711 "w" = [] := rfl
example : closedLedger x711 = [] := rfl
def x714 : Model := ⟨["m0"],["k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x714 "v" = [] := rfl
example : possibleMessages x714 "w" = [] := rfl
example : closedLedger x714 = [] := rfl
def x717 : Model := ⟨["m0"],["k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x717 "v" = [] := rfl
example : possibleMessages x717 "w" = [] := rfl
example : closedLedger x717 = [] := rfl
def x720 : Model := ⟨["m0"],["k1"],[b],[("c0","w")]⟩
example : possibleMessages x720 "v" = [] := rfl
example : possibleMessages x720 "w" = [] := rfl
example : closedLedger x720 = [] := rfl
def x723 : Model := ⟨["m0"],["k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x723 "v" = [] := rfl
example : possibleMessages x723 "w" = [] := rfl
example : closedLedger x723 = [] := rfl
def x726 : Model := ⟨["m0"],["k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x726 "v" = [] := rfl
example : possibleMessages x726 "w" = [] := rfl
example : closedLedger x726 = [] := rfl
def x729 : Model := ⟨["m0"],["k1"],[a,b],[]⟩
example : possibleMessages x729 "v" = [] := rfl
example : possibleMessages x729 "w" = [] := rfl
example : closedLedger x729 = [] := rfl
def x732 : Model := ⟨["m0"],["k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x732 "v" = [] := rfl
example : possibleMessages x732 "w" = [] := rfl
example : closedLedger x732 = [] := rfl
def x735 : Model := ⟨["m0"],["k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x735 "v" = [] := rfl
example : possibleMessages x735 "w" = [] := rfl
example : closedLedger x735 = [] := rfl
def x738 : Model := ⟨["m0"],["k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x738 "v" = [] := rfl
example : possibleMessages x738 "w" = [] := rfl
example : closedLedger x738 = [] := rfl
def x741 : Model := ⟨["m0"],["k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x741 "v" = [] := rfl
example : possibleMessages x741 "w" = [] := rfl
example : closedLedger x741 = [] := rfl
def x744 : Model := ⟨["m0"],["k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x744 "v" = [] := rfl
example : possibleMessages x744 "w" = [] := rfl
example : closedLedger x744 = [] := rfl
def x747 : Model := ⟨["m0"],["k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x747 "v" = [] := rfl
example : possibleMessages x747 "w" = [] := rfl
example : closedLedger x747 = [] := rfl
def x750 : Model := ⟨["m0"],["k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x750 "v" = [] := rfl
example : possibleMessages x750 "w" = [] := rfl
example : closedLedger x750 = [] := rfl
def x753 : Model := ⟨["m0"],["k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x753 "v" = [] := rfl
example : possibleMessages x753 "w" = [] := rfl
example : closedLedger x753 = [] := rfl
def x756 : Model := ⟨["m0"],["k0","k1"],[],[]⟩
example : possibleMessages x756 "v" = [] := rfl
example : possibleMessages x756 "w" = [] := rfl
example : closedLedger x756 = [] := rfl
def x759 : Model := ⟨["m0"],["k0","k1"],[],[("c1","v")]⟩
example : possibleMessages x759 "v" = [] := rfl
example : possibleMessages x759 "w" = [] := rfl
example : closedLedger x759 = [] := rfl
def x762 : Model := ⟨["m0"],["k0","k1"],[],[("c1","w")]⟩
example : possibleMessages x762 "v" = [] := rfl
example : possibleMessages x762 "w" = [] := rfl
example : closedLedger x762 = [] := rfl
def x765 : Model := ⟨["m0"],["k0","k1"],[],[("c0","v")]⟩
example : possibleMessages x765 "v" = [] := rfl
example : possibleMessages x765 "w" = [] := rfl
example : closedLedger x765 = [] := rfl
def x768 : Model := ⟨["m0"],["k0","k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x768 "v" = [] := rfl
example : possibleMessages x768 "w" = [] := rfl
example : closedLedger x768 = [] := rfl
def x771 : Model := ⟨["m0"],["k0","k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x771 "v" = [] := rfl
example : possibleMessages x771 "w" = [] := rfl
example : closedLedger x771 = [] := rfl
def x774 : Model := ⟨["m0"],["k0","k1"],[],[("c0","w")]⟩
example : possibleMessages x774 "v" = [] := rfl
example : possibleMessages x774 "w" = [] := rfl
example : closedLedger x774 = [] := rfl
def x777 : Model := ⟨["m0"],["k0","k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x777 "v" = [] := rfl
example : possibleMessages x777 "w" = [] := rfl
example : closedLedger x777 = [] := rfl
def x780 : Model := ⟨["m0"],["k0","k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x780 "v" = [] := rfl
example : possibleMessages x780 "w" = [] := rfl
example : closedLedger x780 = [] := rfl
def x783 : Model := ⟨["m0"],["k0","k1"],[a],[]⟩
example : possibleMessages x783 "v" = [] := rfl
example : possibleMessages x783 "w" = [] := rfl
example : closedLedger x783 = [] := rfl
def x786 : Model := ⟨["m0"],["k0","k1"],[a],[("c1","v")]⟩
example : possibleMessages x786 "v" = [] := rfl
example : possibleMessages x786 "w" = [] := rfl
example : closedLedger x786 = [] := rfl
def x789 : Model := ⟨["m0"],["k0","k1"],[a],[("c1","w")]⟩
example : possibleMessages x789 "v" = [] := rfl
example : possibleMessages x789 "w" = [] := rfl
example : closedLedger x789 = [] := rfl
def x792 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","v")]⟩
example : possibleMessages x792 "v" = ["m0"] := rfl
example : possibleMessages x792 "w" = [] := rfl
example : closedLedger x792 = [] := rfl
def x795 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x795 "v" = ["m0"] := rfl
example : possibleMessages x795 "w" = [] := rfl
example : closedLedger x795 = [] := rfl
def x798 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x798 "v" = ["m0"] := rfl
example : possibleMessages x798 "w" = [] := rfl
example : closedLedger x798 = [] := rfl
def x801 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","w")]⟩
example : possibleMessages x801 "v" = [] := rfl
example : possibleMessages x801 "w" = ["m0"] := rfl
example : closedLedger x801 = [] := rfl
def x804 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x804 "v" = [] := rfl
example : possibleMessages x804 "w" = ["m0"] := rfl
example : closedLedger x804 = [] := rfl
def x807 : Model := ⟨["m0"],["k0","k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x807 "v" = [] := rfl
example : possibleMessages x807 "w" = ["m0"] := rfl
example : closedLedger x807 = [] := rfl
def x810 : Model := ⟨["m0"],["k0","k1"],[b],[]⟩
example : possibleMessages x810 "v" = [] := rfl
example : possibleMessages x810 "w" = [] := rfl
example : closedLedger x810 = [] := rfl
def x813 : Model := ⟨["m0"],["k0","k1"],[b],[("c1","v")]⟩
example : possibleMessages x813 "v" = [] := rfl
example : possibleMessages x813 "w" = [] := rfl
example : closedLedger x813 = [] := rfl
def x816 : Model := ⟨["m0"],["k0","k1"],[b],[("c1","w")]⟩
example : possibleMessages x816 "v" = [] := rfl
example : possibleMessages x816 "w" = [] := rfl
example : closedLedger x816 = [] := rfl
def x819 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","v")]⟩
example : possibleMessages x819 "v" = [] := rfl
example : possibleMessages x819 "w" = [] := rfl
example : closedLedger x819 = [] := rfl
def x822 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x822 "v" = [] := rfl
example : possibleMessages x822 "w" = [] := rfl
example : closedLedger x822 = [] := rfl
def x825 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x825 "v" = [] := rfl
example : possibleMessages x825 "w" = [] := rfl
example : closedLedger x825 = [] := rfl
def x828 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","w")]⟩
example : possibleMessages x828 "v" = [] := rfl
example : possibleMessages x828 "w" = [] := rfl
example : closedLedger x828 = [] := rfl
def x831 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x831 "v" = [] := rfl
example : possibleMessages x831 "w" = [] := rfl
example : closedLedger x831 = [] := rfl
def x834 : Model := ⟨["m0"],["k0","k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x834 "v" = [] := rfl
example : possibleMessages x834 "w" = [] := rfl
example : closedLedger x834 = [] := rfl
def x837 : Model := ⟨["m0"],["k0","k1"],[a,b],[]⟩
example : possibleMessages x837 "v" = [] := rfl
example : possibleMessages x837 "w" = [] := rfl
example : closedLedger x837 = [] := rfl
def x840 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x840 "v" = [] := rfl
example : possibleMessages x840 "w" = [] := rfl
example : closedLedger x840 = [] := rfl
def x843 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x843 "v" = [] := rfl
example : possibleMessages x843 "w" = [] := rfl
example : closedLedger x843 = [] := rfl
def x846 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x846 "v" = ["m0"] := rfl
example : possibleMessages x846 "w" = [] := rfl
example : closedLedger x846 = [] := rfl
def x849 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x849 "v" = ["m0"] := rfl
example : possibleMessages x849 "w" = [] := rfl
example : closedLedger x849 = [] := rfl
def x852 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x852 "v" = ["m0"] := rfl
example : possibleMessages x852 "w" = [] := rfl
example : closedLedger x852 = [] := rfl
def x855 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x855 "v" = [] := rfl
example : possibleMessages x855 "w" = ["m0"] := rfl
example : closedLedger x855 = [] := rfl
def x858 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x858 "v" = [] := rfl
example : possibleMessages x858 "w" = ["m0"] := rfl
example : closedLedger x858 = [] := rfl
def x861 : Model := ⟨["m0"],["k0","k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x861 "v" = [] := rfl
example : possibleMessages x861 "w" = ["m0"] := rfl
example : closedLedger x861 = [] := rfl
def x864 : Model := ⟨["m1"],[],[],[]⟩
example : possibleMessages x864 "v" = [] := rfl
example : possibleMessages x864 "w" = [] := rfl
example : closedLedger x864 = [] := rfl
def x867 : Model := ⟨["m1"],[],[],[("c1","v")]⟩
example : possibleMessages x867 "v" = [] := rfl
example : possibleMessages x867 "w" = [] := rfl
example : closedLedger x867 = [] := rfl
def x870 : Model := ⟨["m1"],[],[],[("c1","w")]⟩
example : possibleMessages x870 "v" = [] := rfl
example : possibleMessages x870 "w" = [] := rfl
example : closedLedger x870 = [] := rfl
def x873 : Model := ⟨["m1"],[],[],[("c0","v")]⟩
example : possibleMessages x873 "v" = [] := rfl
example : possibleMessages x873 "w" = [] := rfl
example : closedLedger x873 = [] := rfl
def x876 : Model := ⟨["m1"],[],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x876 "v" = [] := rfl
example : possibleMessages x876 "w" = [] := rfl
example : closedLedger x876 = [] := rfl
def x879 : Model := ⟨["m1"],[],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x879 "v" = [] := rfl
example : possibleMessages x879 "w" = [] := rfl
example : closedLedger x879 = [] := rfl
def x882 : Model := ⟨["m1"],[],[],[("c0","w")]⟩
example : possibleMessages x882 "v" = [] := rfl
example : possibleMessages x882 "w" = [] := rfl
example : closedLedger x882 = [] := rfl
def x885 : Model := ⟨["m1"],[],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x885 "v" = [] := rfl
example : possibleMessages x885 "w" = [] := rfl
example : closedLedger x885 = [] := rfl
def x888 : Model := ⟨["m1"],[],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x888 "v" = [] := rfl
example : possibleMessages x888 "w" = [] := rfl
example : closedLedger x888 = [] := rfl
def x891 : Model := ⟨["m1"],[],[a],[]⟩
example : possibleMessages x891 "v" = [] := rfl
example : possibleMessages x891 "w" = [] := rfl
example : closedLedger x891 = [] := rfl
def x894 : Model := ⟨["m1"],[],[a],[("c1","v")]⟩
example : possibleMessages x894 "v" = [] := rfl
example : possibleMessages x894 "w" = [] := rfl
example : closedLedger x894 = [] := rfl
def x897 : Model := ⟨["m1"],[],[a],[("c1","w")]⟩
example : possibleMessages x897 "v" = [] := rfl
example : possibleMessages x897 "w" = [] := rfl
example : closedLedger x897 = [] := rfl
def x900 : Model := ⟨["m1"],[],[a],[("c0","v")]⟩
example : possibleMessages x900 "v" = [] := rfl
example : possibleMessages x900 "w" = [] := rfl
example : closedLedger x900 = [] := rfl
def x903 : Model := ⟨["m1"],[],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x903 "v" = [] := rfl
example : possibleMessages x903 "w" = [] := rfl
example : closedLedger x903 = [] := rfl
def x906 : Model := ⟨["m1"],[],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x906 "v" = [] := rfl
example : possibleMessages x906 "w" = [] := rfl
example : closedLedger x906 = [] := rfl
def x909 : Model := ⟨["m1"],[],[a],[("c0","w")]⟩
example : possibleMessages x909 "v" = [] := rfl
example : possibleMessages x909 "w" = [] := rfl
example : closedLedger x909 = [] := rfl
def x912 : Model := ⟨["m1"],[],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x912 "v" = [] := rfl
example : possibleMessages x912 "w" = [] := rfl
example : closedLedger x912 = [] := rfl
def x915 : Model := ⟨["m1"],[],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x915 "v" = [] := rfl
example : possibleMessages x915 "w" = [] := rfl
example : closedLedger x915 = [] := rfl
def x918 : Model := ⟨["m1"],[],[b],[]⟩
example : possibleMessages x918 "v" = [] := rfl
example : possibleMessages x918 "w" = [] := rfl
example : closedLedger x918 = [] := rfl
def x921 : Model := ⟨["m1"],[],[b],[("c1","v")]⟩
example : possibleMessages x921 "v" = [] := rfl
example : possibleMessages x921 "w" = [] := rfl
example : closedLedger x921 = [] := rfl
def x924 : Model := ⟨["m1"],[],[b],[("c1","w")]⟩
example : possibleMessages x924 "v" = [] := rfl
example : possibleMessages x924 "w" = [] := rfl
example : closedLedger x924 = [] := rfl
def x927 : Model := ⟨["m1"],[],[b],[("c0","v")]⟩
example : possibleMessages x927 "v" = [] := rfl
example : possibleMessages x927 "w" = [] := rfl
example : closedLedger x927 = [] := rfl
def x930 : Model := ⟨["m1"],[],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x930 "v" = [] := rfl
example : possibleMessages x930 "w" = [] := rfl
example : closedLedger x930 = [] := rfl
def x933 : Model := ⟨["m1"],[],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x933 "v" = [] := rfl
example : possibleMessages x933 "w" = [] := rfl
example : closedLedger x933 = [] := rfl
def x936 : Model := ⟨["m1"],[],[b],[("c0","w")]⟩
example : possibleMessages x936 "v" = [] := rfl
example : possibleMessages x936 "w" = [] := rfl
example : closedLedger x936 = [] := rfl
def x939 : Model := ⟨["m1"],[],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x939 "v" = [] := rfl
example : possibleMessages x939 "w" = [] := rfl
example : closedLedger x939 = [] := rfl
def x942 : Model := ⟨["m1"],[],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x942 "v" = [] := rfl
example : possibleMessages x942 "w" = [] := rfl
example : closedLedger x942 = [] := rfl
def x945 : Model := ⟨["m1"],[],[a,b],[]⟩
example : possibleMessages x945 "v" = [] := rfl
example : possibleMessages x945 "w" = [] := rfl
example : closedLedger x945 = [] := rfl
def x948 : Model := ⟨["m1"],[],[a,b],[("c1","v")]⟩
example : possibleMessages x948 "v" = [] := rfl
example : possibleMessages x948 "w" = [] := rfl
example : closedLedger x948 = [] := rfl
def x951 : Model := ⟨["m1"],[],[a,b],[("c1","w")]⟩
example : possibleMessages x951 "v" = [] := rfl
example : possibleMessages x951 "w" = [] := rfl
example : closedLedger x951 = [] := rfl
def x954 : Model := ⟨["m1"],[],[a,b],[("c0","v")]⟩
example : possibleMessages x954 "v" = [] := rfl
example : possibleMessages x954 "w" = [] := rfl
example : closedLedger x954 = [] := rfl
def x957 : Model := ⟨["m1"],[],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x957 "v" = [] := rfl
example : possibleMessages x957 "w" = [] := rfl
example : closedLedger x957 = [] := rfl
def x960 : Model := ⟨["m1"],[],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x960 "v" = [] := rfl
example : possibleMessages x960 "w" = [] := rfl
example : closedLedger x960 = [] := rfl
def x963 : Model := ⟨["m1"],[],[a,b],[("c0","w")]⟩
example : possibleMessages x963 "v" = [] := rfl
example : possibleMessages x963 "w" = [] := rfl
example : closedLedger x963 = [] := rfl
def x966 : Model := ⟨["m1"],[],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x966 "v" = [] := rfl
example : possibleMessages x966 "w" = [] := rfl
example : closedLedger x966 = [] := rfl
def x969 : Model := ⟨["m1"],[],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x969 "v" = [] := rfl
example : possibleMessages x969 "w" = [] := rfl
example : closedLedger x969 = [] := rfl
def x972 : Model := ⟨["m1"],["k0"],[],[]⟩
example : possibleMessages x972 "v" = [] := rfl
example : possibleMessages x972 "w" = [] := rfl
example : closedLedger x972 = [] := rfl
def x975 : Model := ⟨["m1"],["k0"],[],[("c1","v")]⟩
example : possibleMessages x975 "v" = [] := rfl
example : possibleMessages x975 "w" = [] := rfl
example : closedLedger x975 = [] := rfl
def x978 : Model := ⟨["m1"],["k0"],[],[("c1","w")]⟩
example : possibleMessages x978 "v" = [] := rfl
example : possibleMessages x978 "w" = [] := rfl
example : closedLedger x978 = [] := rfl
def x981 : Model := ⟨["m1"],["k0"],[],[("c0","v")]⟩
example : possibleMessages x981 "v" = [] := rfl
example : possibleMessages x981 "w" = [] := rfl
example : closedLedger x981 = [] := rfl
def x984 : Model := ⟨["m1"],["k0"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x984 "v" = [] := rfl
example : possibleMessages x984 "w" = [] := rfl
example : closedLedger x984 = [] := rfl
def x987 : Model := ⟨["m1"],["k0"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x987 "v" = [] := rfl
example : possibleMessages x987 "w" = [] := rfl
example : closedLedger x987 = [] := rfl
def x990 : Model := ⟨["m1"],["k0"],[],[("c0","w")]⟩
example : possibleMessages x990 "v" = [] := rfl
example : possibleMessages x990 "w" = [] := rfl
example : closedLedger x990 = [] := rfl
def x993 : Model := ⟨["m1"],["k0"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x993 "v" = [] := rfl
example : possibleMessages x993 "w" = [] := rfl
example : closedLedger x993 = [] := rfl
def x996 : Model := ⟨["m1"],["k0"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x996 "v" = [] := rfl
example : possibleMessages x996 "w" = [] := rfl
example : closedLedger x996 = [] := rfl
def x999 : Model := ⟨["m1"],["k0"],[a],[]⟩
example : possibleMessages x999 "v" = [] := rfl
example : possibleMessages x999 "w" = [] := rfl
example : closedLedger x999 = [] := rfl
def x1002 : Model := ⟨["m1"],["k0"],[a],[("c1","v")]⟩
example : possibleMessages x1002 "v" = [] := rfl
example : possibleMessages x1002 "w" = [] := rfl
example : closedLedger x1002 = [] := rfl
def x1005 : Model := ⟨["m1"],["k0"],[a],[("c1","w")]⟩
example : possibleMessages x1005 "v" = [] := rfl
example : possibleMessages x1005 "w" = [] := rfl
example : closedLedger x1005 = [] := rfl
def x1008 : Model := ⟨["m1"],["k0"],[a],[("c0","v")]⟩
example : possibleMessages x1008 "v" = [] := rfl
example : possibleMessages x1008 "w" = [] := rfl
example : closedLedger x1008 = [] := rfl
def x1011 : Model := ⟨["m1"],["k0"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1011 "v" = [] := rfl
example : possibleMessages x1011 "w" = [] := rfl
example : closedLedger x1011 = [] := rfl
def x1014 : Model := ⟨["m1"],["k0"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1014 "v" = [] := rfl
example : possibleMessages x1014 "w" = [] := rfl
example : closedLedger x1014 = [] := rfl
def x1017 : Model := ⟨["m1"],["k0"],[a],[("c0","w")]⟩
example : possibleMessages x1017 "v" = [] := rfl
example : possibleMessages x1017 "w" = [] := rfl
example : closedLedger x1017 = [] := rfl
def x1020 : Model := ⟨["m1"],["k0"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1020 "v" = [] := rfl
example : possibleMessages x1020 "w" = [] := rfl
example : closedLedger x1020 = [] := rfl
def x1023 : Model := ⟨["m1"],["k0"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1023 "v" = [] := rfl
example : possibleMessages x1023 "w" = [] := rfl
example : closedLedger x1023 = [] := rfl
def x1026 : Model := ⟨["m1"],["k0"],[b],[]⟩
example : possibleMessages x1026 "v" = [] := rfl
example : possibleMessages x1026 "w" = [] := rfl
example : closedLedger x1026 = [] := rfl
def x1029 : Model := ⟨["m1"],["k0"],[b],[("c1","v")]⟩
example : possibleMessages x1029 "v" = [] := rfl
example : possibleMessages x1029 "w" = [] := rfl
example : closedLedger x1029 = [] := rfl
def x1032 : Model := ⟨["m1"],["k0"],[b],[("c1","w")]⟩
example : possibleMessages x1032 "v" = [] := rfl
example : possibleMessages x1032 "w" = [] := rfl
example : closedLedger x1032 = [] := rfl
def x1035 : Model := ⟨["m1"],["k0"],[b],[("c0","v")]⟩
example : possibleMessages x1035 "v" = [] := rfl
example : possibleMessages x1035 "w" = [] := rfl
example : closedLedger x1035 = [] := rfl
def x1038 : Model := ⟨["m1"],["k0"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1038 "v" = [] := rfl
example : possibleMessages x1038 "w" = [] := rfl
example : closedLedger x1038 = [] := rfl
def x1041 : Model := ⟨["m1"],["k0"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1041 "v" = [] := rfl
example : possibleMessages x1041 "w" = [] := rfl
example : closedLedger x1041 = [] := rfl
def x1044 : Model := ⟨["m1"],["k0"],[b],[("c0","w")]⟩
example : possibleMessages x1044 "v" = [] := rfl
example : possibleMessages x1044 "w" = [] := rfl
example : closedLedger x1044 = [] := rfl
def x1047 : Model := ⟨["m1"],["k0"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1047 "v" = [] := rfl
example : possibleMessages x1047 "w" = [] := rfl
example : closedLedger x1047 = [] := rfl
def x1050 : Model := ⟨["m1"],["k0"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1050 "v" = [] := rfl
example : possibleMessages x1050 "w" = [] := rfl
example : closedLedger x1050 = [] := rfl
def x1053 : Model := ⟨["m1"],["k0"],[a,b],[]⟩
example : possibleMessages x1053 "v" = [] := rfl
example : possibleMessages x1053 "w" = [] := rfl
example : closedLedger x1053 = [] := rfl
def x1056 : Model := ⟨["m1"],["k0"],[a,b],[("c1","v")]⟩
example : possibleMessages x1056 "v" = [] := rfl
example : possibleMessages x1056 "w" = [] := rfl
example : closedLedger x1056 = [] := rfl
def x1059 : Model := ⟨["m1"],["k0"],[a,b],[("c1","w")]⟩
example : possibleMessages x1059 "v" = [] := rfl
example : possibleMessages x1059 "w" = [] := rfl
example : closedLedger x1059 = [] := rfl
def x1062 : Model := ⟨["m1"],["k0"],[a,b],[("c0","v")]⟩
example : possibleMessages x1062 "v" = [] := rfl
example : possibleMessages x1062 "w" = [] := rfl
example : closedLedger x1062 = [] := rfl
def x1065 : Model := ⟨["m1"],["k0"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1065 "v" = [] := rfl
example : possibleMessages x1065 "w" = [] := rfl
example : closedLedger x1065 = [] := rfl
def x1068 : Model := ⟨["m1"],["k0"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1068 "v" = [] := rfl
example : possibleMessages x1068 "w" = [] := rfl
example : closedLedger x1068 = [] := rfl
def x1071 : Model := ⟨["m1"],["k0"],[a,b],[("c0","w")]⟩
example : possibleMessages x1071 "v" = [] := rfl
example : possibleMessages x1071 "w" = [] := rfl
example : closedLedger x1071 = [] := rfl
def x1074 : Model := ⟨["m1"],["k0"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1074 "v" = [] := rfl
example : possibleMessages x1074 "w" = [] := rfl
example : closedLedger x1074 = [] := rfl
def x1077 : Model := ⟨["m1"],["k0"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1077 "v" = [] := rfl
example : possibleMessages x1077 "w" = [] := rfl
example : closedLedger x1077 = [] := rfl
def x1080 : Model := ⟨["m1"],["k1"],[],[]⟩
example : possibleMessages x1080 "v" = [] := rfl
example : possibleMessages x1080 "w" = [] := rfl
example : closedLedger x1080 = [] := rfl
def x1083 : Model := ⟨["m1"],["k1"],[],[("c1","v")]⟩
example : possibleMessages x1083 "v" = [] := rfl
example : possibleMessages x1083 "w" = [] := rfl
example : closedLedger x1083 = [] := rfl
def x1086 : Model := ⟨["m1"],["k1"],[],[("c1","w")]⟩
example : possibleMessages x1086 "v" = [] := rfl
example : possibleMessages x1086 "w" = [] := rfl
example : closedLedger x1086 = [] := rfl
def x1089 : Model := ⟨["m1"],["k1"],[],[("c0","v")]⟩
example : possibleMessages x1089 "v" = [] := rfl
example : possibleMessages x1089 "w" = [] := rfl
example : closedLedger x1089 = [] := rfl
def x1092 : Model := ⟨["m1"],["k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1092 "v" = [] := rfl
example : possibleMessages x1092 "w" = [] := rfl
example : closedLedger x1092 = [] := rfl
def x1095 : Model := ⟨["m1"],["k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1095 "v" = [] := rfl
example : possibleMessages x1095 "w" = [] := rfl
example : closedLedger x1095 = [] := rfl
def x1098 : Model := ⟨["m1"],["k1"],[],[("c0","w")]⟩
example : possibleMessages x1098 "v" = [] := rfl
example : possibleMessages x1098 "w" = [] := rfl
example : closedLedger x1098 = [] := rfl
def x1101 : Model := ⟨["m1"],["k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1101 "v" = [] := rfl
example : possibleMessages x1101 "w" = [] := rfl
example : closedLedger x1101 = [] := rfl
def x1104 : Model := ⟨["m1"],["k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1104 "v" = [] := rfl
example : possibleMessages x1104 "w" = [] := rfl
example : closedLedger x1104 = [] := rfl
def x1107 : Model := ⟨["m1"],["k1"],[a],[]⟩
example : possibleMessages x1107 "v" = [] := rfl
example : possibleMessages x1107 "w" = [] := rfl
example : closedLedger x1107 = [] := rfl
def x1110 : Model := ⟨["m1"],["k1"],[a],[("c1","v")]⟩
example : possibleMessages x1110 "v" = [] := rfl
example : possibleMessages x1110 "w" = [] := rfl
example : closedLedger x1110 = [] := rfl
def x1113 : Model := ⟨["m1"],["k1"],[a],[("c1","w")]⟩
example : possibleMessages x1113 "v" = [] := rfl
example : possibleMessages x1113 "w" = [] := rfl
example : closedLedger x1113 = [] := rfl
def x1116 : Model := ⟨["m1"],["k1"],[a],[("c0","v")]⟩
example : possibleMessages x1116 "v" = [] := rfl
example : possibleMessages x1116 "w" = [] := rfl
example : closedLedger x1116 = [] := rfl
def x1119 : Model := ⟨["m1"],["k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1119 "v" = [] := rfl
example : possibleMessages x1119 "w" = [] := rfl
example : closedLedger x1119 = [] := rfl
def x1122 : Model := ⟨["m1"],["k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1122 "v" = [] := rfl
example : possibleMessages x1122 "w" = [] := rfl
example : closedLedger x1122 = [] := rfl
def x1125 : Model := ⟨["m1"],["k1"],[a],[("c0","w")]⟩
example : possibleMessages x1125 "v" = [] := rfl
example : possibleMessages x1125 "w" = [] := rfl
example : closedLedger x1125 = [] := rfl
def x1128 : Model := ⟨["m1"],["k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1128 "v" = [] := rfl
example : possibleMessages x1128 "w" = [] := rfl
example : closedLedger x1128 = [] := rfl
def x1131 : Model := ⟨["m1"],["k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1131 "v" = [] := rfl
example : possibleMessages x1131 "w" = [] := rfl
example : closedLedger x1131 = [] := rfl
def x1134 : Model := ⟨["m1"],["k1"],[b],[]⟩
example : possibleMessages x1134 "v" = [] := rfl
example : possibleMessages x1134 "w" = [] := rfl
example : closedLedger x1134 = [] := rfl
def x1137 : Model := ⟨["m1"],["k1"],[b],[("c1","v")]⟩
example : possibleMessages x1137 "v" = ["m1"] := rfl
example : possibleMessages x1137 "w" = [] := rfl
example : closedLedger x1137 = [] := rfl
def x1140 : Model := ⟨["m1"],["k1"],[b],[("c1","w")]⟩
example : possibleMessages x1140 "v" = [] := rfl
example : possibleMessages x1140 "w" = ["m1"] := rfl
example : closedLedger x1140 = [] := rfl
def x1143 : Model := ⟨["m1"],["k1"],[b],[("c0","v")]⟩
example : possibleMessages x1143 "v" = [] := rfl
example : possibleMessages x1143 "w" = [] := rfl
example : closedLedger x1143 = [] := rfl
def x1146 : Model := ⟨["m1"],["k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1146 "v" = ["m1"] := rfl
example : possibleMessages x1146 "w" = [] := rfl
example : closedLedger x1146 = [] := rfl
def x1149 : Model := ⟨["m1"],["k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1149 "v" = [] := rfl
example : possibleMessages x1149 "w" = ["m1"] := rfl
example : closedLedger x1149 = [] := rfl
def x1152 : Model := ⟨["m1"],["k1"],[b],[("c0","w")]⟩
example : possibleMessages x1152 "v" = [] := rfl
example : possibleMessages x1152 "w" = [] := rfl
example : closedLedger x1152 = [] := rfl
def x1155 : Model := ⟨["m1"],["k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1155 "v" = ["m1"] := rfl
example : possibleMessages x1155 "w" = [] := rfl
example : closedLedger x1155 = [] := rfl
def x1158 : Model := ⟨["m1"],["k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1158 "v" = [] := rfl
example : possibleMessages x1158 "w" = ["m1"] := rfl
example : closedLedger x1158 = [] := rfl
def x1161 : Model := ⟨["m1"],["k1"],[a,b],[]⟩
example : possibleMessages x1161 "v" = [] := rfl
example : possibleMessages x1161 "w" = [] := rfl
example : closedLedger x1161 = [] := rfl
def x1164 : Model := ⟨["m1"],["k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x1164 "v" = ["m1"] := rfl
example : possibleMessages x1164 "w" = [] := rfl
example : closedLedger x1164 = [] := rfl
def x1167 : Model := ⟨["m1"],["k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x1167 "v" = [] := rfl
example : possibleMessages x1167 "w" = ["m1"] := rfl
example : closedLedger x1167 = [] := rfl
def x1170 : Model := ⟨["m1"],["k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x1170 "v" = [] := rfl
example : possibleMessages x1170 "w" = [] := rfl
example : closedLedger x1170 = [] := rfl
def x1173 : Model := ⟨["m1"],["k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1173 "v" = ["m1"] := rfl
example : possibleMessages x1173 "w" = [] := rfl
example : closedLedger x1173 = [] := rfl
def x1176 : Model := ⟨["m1"],["k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1176 "v" = [] := rfl
example : possibleMessages x1176 "w" = ["m1"] := rfl
example : closedLedger x1176 = [] := rfl
def x1179 : Model := ⟨["m1"],["k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x1179 "v" = [] := rfl
example : possibleMessages x1179 "w" = [] := rfl
example : closedLedger x1179 = [] := rfl
def x1182 : Model := ⟨["m1"],["k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1182 "v" = ["m1"] := rfl
example : possibleMessages x1182 "w" = [] := rfl
example : closedLedger x1182 = [] := rfl
def x1185 : Model := ⟨["m1"],["k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1185 "v" = [] := rfl
example : possibleMessages x1185 "w" = ["m1"] := rfl
example : closedLedger x1185 = [] := rfl
def x1188 : Model := ⟨["m1"],["k0","k1"],[],[]⟩
example : possibleMessages x1188 "v" = [] := rfl
example : possibleMessages x1188 "w" = [] := rfl
example : closedLedger x1188 = [] := rfl
def x1191 : Model := ⟨["m1"],["k0","k1"],[],[("c1","v")]⟩
example : possibleMessages x1191 "v" = [] := rfl
example : possibleMessages x1191 "w" = [] := rfl
example : closedLedger x1191 = [] := rfl
def x1194 : Model := ⟨["m1"],["k0","k1"],[],[("c1","w")]⟩
example : possibleMessages x1194 "v" = [] := rfl
example : possibleMessages x1194 "w" = [] := rfl
example : closedLedger x1194 = [] := rfl
def x1197 : Model := ⟨["m1"],["k0","k1"],[],[("c0","v")]⟩
example : possibleMessages x1197 "v" = [] := rfl
example : possibleMessages x1197 "w" = [] := rfl
example : closedLedger x1197 = [] := rfl
def x1200 : Model := ⟨["m1"],["k0","k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1200 "v" = [] := rfl
example : possibleMessages x1200 "w" = [] := rfl
example : closedLedger x1200 = [] := rfl
def x1203 : Model := ⟨["m1"],["k0","k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1203 "v" = [] := rfl
example : possibleMessages x1203 "w" = [] := rfl
example : closedLedger x1203 = [] := rfl
def x1206 : Model := ⟨["m1"],["k0","k1"],[],[("c0","w")]⟩
example : possibleMessages x1206 "v" = [] := rfl
example : possibleMessages x1206 "w" = [] := rfl
example : closedLedger x1206 = [] := rfl
def x1209 : Model := ⟨["m1"],["k0","k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1209 "v" = [] := rfl
example : possibleMessages x1209 "w" = [] := rfl
example : closedLedger x1209 = [] := rfl
def x1212 : Model := ⟨["m1"],["k0","k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1212 "v" = [] := rfl
example : possibleMessages x1212 "w" = [] := rfl
example : closedLedger x1212 = [] := rfl
def x1215 : Model := ⟨["m1"],["k0","k1"],[a],[]⟩
example : possibleMessages x1215 "v" = [] := rfl
example : possibleMessages x1215 "w" = [] := rfl
example : closedLedger x1215 = [] := rfl
def x1218 : Model := ⟨["m1"],["k0","k1"],[a],[("c1","v")]⟩
example : possibleMessages x1218 "v" = [] := rfl
example : possibleMessages x1218 "w" = [] := rfl
example : closedLedger x1218 = [] := rfl
def x1221 : Model := ⟨["m1"],["k0","k1"],[a],[("c1","w")]⟩
example : possibleMessages x1221 "v" = [] := rfl
example : possibleMessages x1221 "w" = [] := rfl
example : closedLedger x1221 = [] := rfl
def x1224 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","v")]⟩
example : possibleMessages x1224 "v" = [] := rfl
example : possibleMessages x1224 "w" = [] := rfl
example : closedLedger x1224 = [] := rfl
def x1227 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1227 "v" = [] := rfl
example : possibleMessages x1227 "w" = [] := rfl
example : closedLedger x1227 = [] := rfl
def x1230 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1230 "v" = [] := rfl
example : possibleMessages x1230 "w" = [] := rfl
example : closedLedger x1230 = [] := rfl
def x1233 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","w")]⟩
example : possibleMessages x1233 "v" = [] := rfl
example : possibleMessages x1233 "w" = [] := rfl
example : closedLedger x1233 = [] := rfl
def x1236 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1236 "v" = [] := rfl
example : possibleMessages x1236 "w" = [] := rfl
example : closedLedger x1236 = [] := rfl
def x1239 : Model := ⟨["m1"],["k0","k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1239 "v" = [] := rfl
example : possibleMessages x1239 "w" = [] := rfl
example : closedLedger x1239 = [] := rfl
def x1242 : Model := ⟨["m1"],["k0","k1"],[b],[]⟩
example : possibleMessages x1242 "v" = [] := rfl
example : possibleMessages x1242 "w" = [] := rfl
example : closedLedger x1242 = [] := rfl
def x1245 : Model := ⟨["m1"],["k0","k1"],[b],[("c1","v")]⟩
example : possibleMessages x1245 "v" = ["m1"] := rfl
example : possibleMessages x1245 "w" = [] := rfl
example : closedLedger x1245 = [] := rfl
def x1248 : Model := ⟨["m1"],["k0","k1"],[b],[("c1","w")]⟩
example : possibleMessages x1248 "v" = [] := rfl
example : possibleMessages x1248 "w" = ["m1"] := rfl
example : closedLedger x1248 = [] := rfl
def x1251 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","v")]⟩
example : possibleMessages x1251 "v" = [] := rfl
example : possibleMessages x1251 "w" = [] := rfl
example : closedLedger x1251 = [] := rfl
def x1254 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1254 "v" = ["m1"] := rfl
example : possibleMessages x1254 "w" = [] := rfl
example : closedLedger x1254 = [] := rfl
def x1257 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1257 "v" = [] := rfl
example : possibleMessages x1257 "w" = ["m1"] := rfl
example : closedLedger x1257 = [] := rfl
def x1260 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","w")]⟩
example : possibleMessages x1260 "v" = [] := rfl
example : possibleMessages x1260 "w" = [] := rfl
example : closedLedger x1260 = [] := rfl
def x1263 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1263 "v" = ["m1"] := rfl
example : possibleMessages x1263 "w" = [] := rfl
example : closedLedger x1263 = [] := rfl
def x1266 : Model := ⟨["m1"],["k0","k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1266 "v" = [] := rfl
example : possibleMessages x1266 "w" = ["m1"] := rfl
example : closedLedger x1266 = [] := rfl
def x1269 : Model := ⟨["m1"],["k0","k1"],[a,b],[]⟩
example : possibleMessages x1269 "v" = [] := rfl
example : possibleMessages x1269 "w" = [] := rfl
example : closedLedger x1269 = [] := rfl
def x1272 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x1272 "v" = ["m1"] := rfl
example : possibleMessages x1272 "w" = [] := rfl
example : closedLedger x1272 = [] := rfl
def x1275 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x1275 "v" = [] := rfl
example : possibleMessages x1275 "w" = ["m1"] := rfl
example : closedLedger x1275 = [] := rfl
def x1278 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x1278 "v" = [] := rfl
example : possibleMessages x1278 "w" = [] := rfl
example : closedLedger x1278 = [] := rfl
def x1281 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1281 "v" = ["m1"] := rfl
example : possibleMessages x1281 "w" = [] := rfl
example : closedLedger x1281 = [] := rfl
def x1284 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1284 "v" = [] := rfl
example : possibleMessages x1284 "w" = ["m1"] := rfl
example : closedLedger x1284 = [] := rfl
def x1287 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x1287 "v" = [] := rfl
example : possibleMessages x1287 "w" = [] := rfl
example : closedLedger x1287 = [] := rfl
def x1290 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1290 "v" = ["m1"] := rfl
example : possibleMessages x1290 "w" = [] := rfl
example : closedLedger x1290 = [] := rfl
def x1293 : Model := ⟨["m1"],["k0","k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1293 "v" = [] := rfl
example : possibleMessages x1293 "w" = ["m1"] := rfl
example : closedLedger x1293 = [] := rfl
def x1296 : Model := ⟨["m0","m1"],[],[],[]⟩
example : possibleMessages x1296 "v" = [] := rfl
example : possibleMessages x1296 "w" = [] := rfl
example : closedLedger x1296 = [] := rfl
def x1299 : Model := ⟨["m0","m1"],[],[],[("c1","v")]⟩
example : possibleMessages x1299 "v" = [] := rfl
example : possibleMessages x1299 "w" = [] := rfl
example : closedLedger x1299 = [] := rfl
def x1302 : Model := ⟨["m0","m1"],[],[],[("c1","w")]⟩
example : possibleMessages x1302 "v" = [] := rfl
example : possibleMessages x1302 "w" = [] := rfl
example : closedLedger x1302 = [] := rfl
def x1305 : Model := ⟨["m0","m1"],[],[],[("c0","v")]⟩
example : possibleMessages x1305 "v" = [] := rfl
example : possibleMessages x1305 "w" = [] := rfl
example : closedLedger x1305 = [] := rfl
def x1308 : Model := ⟨["m0","m1"],[],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1308 "v" = [] := rfl
example : possibleMessages x1308 "w" = [] := rfl
example : closedLedger x1308 = [] := rfl
def x1311 : Model := ⟨["m0","m1"],[],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1311 "v" = [] := rfl
example : possibleMessages x1311 "w" = [] := rfl
example : closedLedger x1311 = [] := rfl
def x1314 : Model := ⟨["m0","m1"],[],[],[("c0","w")]⟩
example : possibleMessages x1314 "v" = [] := rfl
example : possibleMessages x1314 "w" = [] := rfl
example : closedLedger x1314 = [] := rfl
def x1317 : Model := ⟨["m0","m1"],[],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1317 "v" = [] := rfl
example : possibleMessages x1317 "w" = [] := rfl
example : closedLedger x1317 = [] := rfl
def x1320 : Model := ⟨["m0","m1"],[],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1320 "v" = [] := rfl
example : possibleMessages x1320 "w" = [] := rfl
example : closedLedger x1320 = [] := rfl
def x1323 : Model := ⟨["m0","m1"],[],[a],[]⟩
example : possibleMessages x1323 "v" = [] := rfl
example : possibleMessages x1323 "w" = [] := rfl
example : closedLedger x1323 = [] := rfl
def x1326 : Model := ⟨["m0","m1"],[],[a],[("c1","v")]⟩
example : possibleMessages x1326 "v" = [] := rfl
example : possibleMessages x1326 "w" = [] := rfl
example : closedLedger x1326 = [] := rfl
def x1329 : Model := ⟨["m0","m1"],[],[a],[("c1","w")]⟩
example : possibleMessages x1329 "v" = [] := rfl
example : possibleMessages x1329 "w" = [] := rfl
example : closedLedger x1329 = [] := rfl
def x1332 : Model := ⟨["m0","m1"],[],[a],[("c0","v")]⟩
example : possibleMessages x1332 "v" = [] := rfl
example : possibleMessages x1332 "w" = [] := rfl
example : closedLedger x1332 = [] := rfl
def x1335 : Model := ⟨["m0","m1"],[],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1335 "v" = [] := rfl
example : possibleMessages x1335 "w" = [] := rfl
example : closedLedger x1335 = [] := rfl
def x1338 : Model := ⟨["m0","m1"],[],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1338 "v" = [] := rfl
example : possibleMessages x1338 "w" = [] := rfl
example : closedLedger x1338 = [] := rfl
def x1341 : Model := ⟨["m0","m1"],[],[a],[("c0","w")]⟩
example : possibleMessages x1341 "v" = [] := rfl
example : possibleMessages x1341 "w" = [] := rfl
example : closedLedger x1341 = [] := rfl
def x1344 : Model := ⟨["m0","m1"],[],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1344 "v" = [] := rfl
example : possibleMessages x1344 "w" = [] := rfl
example : closedLedger x1344 = [] := rfl
def x1347 : Model := ⟨["m0","m1"],[],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1347 "v" = [] := rfl
example : possibleMessages x1347 "w" = [] := rfl
example : closedLedger x1347 = [] := rfl
def x1350 : Model := ⟨["m0","m1"],[],[b],[]⟩
example : possibleMessages x1350 "v" = [] := rfl
example : possibleMessages x1350 "w" = [] := rfl
example : closedLedger x1350 = [] := rfl
def x1353 : Model := ⟨["m0","m1"],[],[b],[("c1","v")]⟩
example : possibleMessages x1353 "v" = [] := rfl
example : possibleMessages x1353 "w" = [] := rfl
example : closedLedger x1353 = [] := rfl
def x1356 : Model := ⟨["m0","m1"],[],[b],[("c1","w")]⟩
example : possibleMessages x1356 "v" = [] := rfl
example : possibleMessages x1356 "w" = [] := rfl
example : closedLedger x1356 = [] := rfl
def x1359 : Model := ⟨["m0","m1"],[],[b],[("c0","v")]⟩
example : possibleMessages x1359 "v" = [] := rfl
example : possibleMessages x1359 "w" = [] := rfl
example : closedLedger x1359 = [] := rfl
def x1362 : Model := ⟨["m0","m1"],[],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1362 "v" = [] := rfl
example : possibleMessages x1362 "w" = [] := rfl
example : closedLedger x1362 = [] := rfl
def x1365 : Model := ⟨["m0","m1"],[],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1365 "v" = [] := rfl
example : possibleMessages x1365 "w" = [] := rfl
example : closedLedger x1365 = [] := rfl
def x1368 : Model := ⟨["m0","m1"],[],[b],[("c0","w")]⟩
example : possibleMessages x1368 "v" = [] := rfl
example : possibleMessages x1368 "w" = [] := rfl
example : closedLedger x1368 = [] := rfl
def x1371 : Model := ⟨["m0","m1"],[],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1371 "v" = [] := rfl
example : possibleMessages x1371 "w" = [] := rfl
example : closedLedger x1371 = [] := rfl
def x1374 : Model := ⟨["m0","m1"],[],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1374 "v" = [] := rfl
example : possibleMessages x1374 "w" = [] := rfl
example : closedLedger x1374 = [] := rfl
def x1377 : Model := ⟨["m0","m1"],[],[a,b],[]⟩
example : possibleMessages x1377 "v" = [] := rfl
example : possibleMessages x1377 "w" = [] := rfl
example : closedLedger x1377 = [] := rfl
def x1380 : Model := ⟨["m0","m1"],[],[a,b],[("c1","v")]⟩
example : possibleMessages x1380 "v" = [] := rfl
example : possibleMessages x1380 "w" = [] := rfl
example : closedLedger x1380 = [] := rfl
def x1383 : Model := ⟨["m0","m1"],[],[a,b],[("c1","w")]⟩
example : possibleMessages x1383 "v" = [] := rfl
example : possibleMessages x1383 "w" = [] := rfl
example : closedLedger x1383 = [] := rfl
def x1386 : Model := ⟨["m0","m1"],[],[a,b],[("c0","v")]⟩
example : possibleMessages x1386 "v" = [] := rfl
example : possibleMessages x1386 "w" = [] := rfl
example : closedLedger x1386 = [] := rfl
def x1389 : Model := ⟨["m0","m1"],[],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1389 "v" = [] := rfl
example : possibleMessages x1389 "w" = [] := rfl
example : closedLedger x1389 = [] := rfl
def x1392 : Model := ⟨["m0","m1"],[],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1392 "v" = [] := rfl
example : possibleMessages x1392 "w" = [] := rfl
example : closedLedger x1392 = [] := rfl
def x1395 : Model := ⟨["m0","m1"],[],[a,b],[("c0","w")]⟩
example : possibleMessages x1395 "v" = [] := rfl
example : possibleMessages x1395 "w" = [] := rfl
example : closedLedger x1395 = [] := rfl
def x1398 : Model := ⟨["m0","m1"],[],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1398 "v" = [] := rfl
example : possibleMessages x1398 "w" = [] := rfl
example : closedLedger x1398 = [] := rfl
def x1401 : Model := ⟨["m0","m1"],[],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1401 "v" = [] := rfl
example : possibleMessages x1401 "w" = [] := rfl
example : closedLedger x1401 = [] := rfl
def x1404 : Model := ⟨["m0","m1"],["k0"],[],[]⟩
example : possibleMessages x1404 "v" = [] := rfl
example : possibleMessages x1404 "w" = [] := rfl
example : closedLedger x1404 = [] := rfl
def x1407 : Model := ⟨["m0","m1"],["k0"],[],[("c1","v")]⟩
example : possibleMessages x1407 "v" = [] := rfl
example : possibleMessages x1407 "w" = [] := rfl
example : closedLedger x1407 = [] := rfl
def x1410 : Model := ⟨["m0","m1"],["k0"],[],[("c1","w")]⟩
example : possibleMessages x1410 "v" = [] := rfl
example : possibleMessages x1410 "w" = [] := rfl
example : closedLedger x1410 = [] := rfl
def x1413 : Model := ⟨["m0","m1"],["k0"],[],[("c0","v")]⟩
example : possibleMessages x1413 "v" = [] := rfl
example : possibleMessages x1413 "w" = [] := rfl
example : closedLedger x1413 = [] := rfl
def x1416 : Model := ⟨["m0","m1"],["k0"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1416 "v" = [] := rfl
example : possibleMessages x1416 "w" = [] := rfl
example : closedLedger x1416 = [] := rfl
def x1419 : Model := ⟨["m0","m1"],["k0"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1419 "v" = [] := rfl
example : possibleMessages x1419 "w" = [] := rfl
example : closedLedger x1419 = [] := rfl
def x1422 : Model := ⟨["m0","m1"],["k0"],[],[("c0","w")]⟩
example : possibleMessages x1422 "v" = [] := rfl
example : possibleMessages x1422 "w" = [] := rfl
example : closedLedger x1422 = [] := rfl
def x1425 : Model := ⟨["m0","m1"],["k0"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1425 "v" = [] := rfl
example : possibleMessages x1425 "w" = [] := rfl
example : closedLedger x1425 = [] := rfl
def x1428 : Model := ⟨["m0","m1"],["k0"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1428 "v" = [] := rfl
example : possibleMessages x1428 "w" = [] := rfl
example : closedLedger x1428 = [] := rfl
def x1431 : Model := ⟨["m0","m1"],["k0"],[a],[]⟩
example : possibleMessages x1431 "v" = [] := rfl
example : possibleMessages x1431 "w" = [] := rfl
example : closedLedger x1431 = [] := rfl
def x1434 : Model := ⟨["m0","m1"],["k0"],[a],[("c1","v")]⟩
example : possibleMessages x1434 "v" = [] := rfl
example : possibleMessages x1434 "w" = [] := rfl
example : closedLedger x1434 = [] := rfl
def x1437 : Model := ⟨["m0","m1"],["k0"],[a],[("c1","w")]⟩
example : possibleMessages x1437 "v" = [] := rfl
example : possibleMessages x1437 "w" = [] := rfl
example : closedLedger x1437 = [] := rfl
def x1440 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","v")]⟩
example : possibleMessages x1440 "v" = ["m0"] := rfl
example : possibleMessages x1440 "w" = [] := rfl
example : closedLedger x1440 = [] := rfl
def x1443 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1443 "v" = ["m0"] := rfl
example : possibleMessages x1443 "w" = [] := rfl
example : closedLedger x1443 = [] := rfl
def x1446 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1446 "v" = ["m0"] := rfl
example : possibleMessages x1446 "w" = [] := rfl
example : closedLedger x1446 = [] := rfl
def x1449 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","w")]⟩
example : possibleMessages x1449 "v" = [] := rfl
example : possibleMessages x1449 "w" = ["m0"] := rfl
example : closedLedger x1449 = [] := rfl
def x1452 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1452 "v" = [] := rfl
example : possibleMessages x1452 "w" = ["m0"] := rfl
example : closedLedger x1452 = [] := rfl
def x1455 : Model := ⟨["m0","m1"],["k0"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1455 "v" = [] := rfl
example : possibleMessages x1455 "w" = ["m0"] := rfl
example : closedLedger x1455 = [] := rfl
def x1458 : Model := ⟨["m0","m1"],["k0"],[b],[]⟩
example : possibleMessages x1458 "v" = [] := rfl
example : possibleMessages x1458 "w" = [] := rfl
example : closedLedger x1458 = [] := rfl
def x1461 : Model := ⟨["m0","m1"],["k0"],[b],[("c1","v")]⟩
example : possibleMessages x1461 "v" = [] := rfl
example : possibleMessages x1461 "w" = [] := rfl
example : closedLedger x1461 = [] := rfl
def x1464 : Model := ⟨["m0","m1"],["k0"],[b],[("c1","w")]⟩
example : possibleMessages x1464 "v" = [] := rfl
example : possibleMessages x1464 "w" = [] := rfl
example : closedLedger x1464 = [] := rfl
def x1467 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","v")]⟩
example : possibleMessages x1467 "v" = [] := rfl
example : possibleMessages x1467 "w" = [] := rfl
example : closedLedger x1467 = [] := rfl
def x1470 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1470 "v" = [] := rfl
example : possibleMessages x1470 "w" = [] := rfl
example : closedLedger x1470 = [] := rfl
def x1473 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1473 "v" = [] := rfl
example : possibleMessages x1473 "w" = [] := rfl
example : closedLedger x1473 = [] := rfl
def x1476 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","w")]⟩
example : possibleMessages x1476 "v" = [] := rfl
example : possibleMessages x1476 "w" = [] := rfl
example : closedLedger x1476 = [] := rfl
def x1479 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1479 "v" = [] := rfl
example : possibleMessages x1479 "w" = [] := rfl
example : closedLedger x1479 = [] := rfl
def x1482 : Model := ⟨["m0","m1"],["k0"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1482 "v" = [] := rfl
example : possibleMessages x1482 "w" = [] := rfl
example : closedLedger x1482 = [] := rfl
def x1485 : Model := ⟨["m0","m1"],["k0"],[a,b],[]⟩
example : possibleMessages x1485 "v" = [] := rfl
example : possibleMessages x1485 "w" = [] := rfl
example : closedLedger x1485 = [] := rfl
def x1488 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c1","v")]⟩
example : possibleMessages x1488 "v" = [] := rfl
example : possibleMessages x1488 "w" = [] := rfl
example : closedLedger x1488 = [] := rfl
def x1491 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c1","w")]⟩
example : possibleMessages x1491 "v" = [] := rfl
example : possibleMessages x1491 "w" = [] := rfl
example : closedLedger x1491 = [] := rfl
def x1494 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","v")]⟩
example : possibleMessages x1494 "v" = ["m0"] := rfl
example : possibleMessages x1494 "w" = [] := rfl
example : closedLedger x1494 = [] := rfl
def x1497 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1497 "v" = ["m0"] := rfl
example : possibleMessages x1497 "w" = [] := rfl
example : closedLedger x1497 = [] := rfl
def x1500 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1500 "v" = ["m0"] := rfl
example : possibleMessages x1500 "w" = [] := rfl
example : closedLedger x1500 = [] := rfl
def x1503 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","w")]⟩
example : possibleMessages x1503 "v" = [] := rfl
example : possibleMessages x1503 "w" = ["m0"] := rfl
example : closedLedger x1503 = [] := rfl
def x1506 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1506 "v" = [] := rfl
example : possibleMessages x1506 "w" = ["m0"] := rfl
example : closedLedger x1506 = [] := rfl
def x1509 : Model := ⟨["m0","m1"],["k0"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1509 "v" = [] := rfl
example : possibleMessages x1509 "w" = ["m0"] := rfl
example : closedLedger x1509 = [] := rfl
def x1512 : Model := ⟨["m0","m1"],["k1"],[],[]⟩
example : possibleMessages x1512 "v" = [] := rfl
example : possibleMessages x1512 "w" = [] := rfl
example : closedLedger x1512 = [] := rfl
def x1515 : Model := ⟨["m0","m1"],["k1"],[],[("c1","v")]⟩
example : possibleMessages x1515 "v" = [] := rfl
example : possibleMessages x1515 "w" = [] := rfl
example : closedLedger x1515 = [] := rfl
def x1518 : Model := ⟨["m0","m1"],["k1"],[],[("c1","w")]⟩
example : possibleMessages x1518 "v" = [] := rfl
example : possibleMessages x1518 "w" = [] := rfl
example : closedLedger x1518 = [] := rfl
def x1521 : Model := ⟨["m0","m1"],["k1"],[],[("c0","v")]⟩
example : possibleMessages x1521 "v" = [] := rfl
example : possibleMessages x1521 "w" = [] := rfl
example : closedLedger x1521 = [] := rfl
def x1524 : Model := ⟨["m0","m1"],["k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1524 "v" = [] := rfl
example : possibleMessages x1524 "w" = [] := rfl
example : closedLedger x1524 = [] := rfl
def x1527 : Model := ⟨["m0","m1"],["k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1527 "v" = [] := rfl
example : possibleMessages x1527 "w" = [] := rfl
example : closedLedger x1527 = [] := rfl
def x1530 : Model := ⟨["m0","m1"],["k1"],[],[("c0","w")]⟩
example : possibleMessages x1530 "v" = [] := rfl
example : possibleMessages x1530 "w" = [] := rfl
example : closedLedger x1530 = [] := rfl
def x1533 : Model := ⟨["m0","m1"],["k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1533 "v" = [] := rfl
example : possibleMessages x1533 "w" = [] := rfl
example : closedLedger x1533 = [] := rfl
def x1536 : Model := ⟨["m0","m1"],["k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1536 "v" = [] := rfl
example : possibleMessages x1536 "w" = [] := rfl
example : closedLedger x1536 = [] := rfl
def x1539 : Model := ⟨["m0","m1"],["k1"],[a],[]⟩
example : possibleMessages x1539 "v" = [] := rfl
example : possibleMessages x1539 "w" = [] := rfl
example : closedLedger x1539 = [] := rfl
def x1542 : Model := ⟨["m0","m1"],["k1"],[a],[("c1","v")]⟩
example : possibleMessages x1542 "v" = [] := rfl
example : possibleMessages x1542 "w" = [] := rfl
example : closedLedger x1542 = [] := rfl
def x1545 : Model := ⟨["m0","m1"],["k1"],[a],[("c1","w")]⟩
example : possibleMessages x1545 "v" = [] := rfl
example : possibleMessages x1545 "w" = [] := rfl
example : closedLedger x1545 = [] := rfl
def x1548 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","v")]⟩
example : possibleMessages x1548 "v" = [] := rfl
example : possibleMessages x1548 "w" = [] := rfl
example : closedLedger x1548 = [] := rfl
def x1551 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1551 "v" = [] := rfl
example : possibleMessages x1551 "w" = [] := rfl
example : closedLedger x1551 = [] := rfl
def x1554 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1554 "v" = [] := rfl
example : possibleMessages x1554 "w" = [] := rfl
example : closedLedger x1554 = [] := rfl
def x1557 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","w")]⟩
example : possibleMessages x1557 "v" = [] := rfl
example : possibleMessages x1557 "w" = [] := rfl
example : closedLedger x1557 = [] := rfl
def x1560 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1560 "v" = [] := rfl
example : possibleMessages x1560 "w" = [] := rfl
example : closedLedger x1560 = [] := rfl
def x1563 : Model := ⟨["m0","m1"],["k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1563 "v" = [] := rfl
example : possibleMessages x1563 "w" = [] := rfl
example : closedLedger x1563 = [] := rfl
def x1566 : Model := ⟨["m0","m1"],["k1"],[b],[]⟩
example : possibleMessages x1566 "v" = [] := rfl
example : possibleMessages x1566 "w" = [] := rfl
example : closedLedger x1566 = [] := rfl
def x1569 : Model := ⟨["m0","m1"],["k1"],[b],[("c1","v")]⟩
example : possibleMessages x1569 "v" = ["m1"] := rfl
example : possibleMessages x1569 "w" = [] := rfl
example : closedLedger x1569 = [] := rfl
def x1572 : Model := ⟨["m0","m1"],["k1"],[b],[("c1","w")]⟩
example : possibleMessages x1572 "v" = [] := rfl
example : possibleMessages x1572 "w" = ["m1"] := rfl
example : closedLedger x1572 = [] := rfl
def x1575 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","v")]⟩
example : possibleMessages x1575 "v" = [] := rfl
example : possibleMessages x1575 "w" = [] := rfl
example : closedLedger x1575 = [] := rfl
def x1578 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1578 "v" = ["m1"] := rfl
example : possibleMessages x1578 "w" = [] := rfl
example : closedLedger x1578 = [] := rfl
def x1581 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1581 "v" = [] := rfl
example : possibleMessages x1581 "w" = ["m1"] := rfl
example : closedLedger x1581 = [] := rfl
def x1584 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","w")]⟩
example : possibleMessages x1584 "v" = [] := rfl
example : possibleMessages x1584 "w" = [] := rfl
example : closedLedger x1584 = [] := rfl
def x1587 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1587 "v" = ["m1"] := rfl
example : possibleMessages x1587 "w" = [] := rfl
example : closedLedger x1587 = [] := rfl
def x1590 : Model := ⟨["m0","m1"],["k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1590 "v" = [] := rfl
example : possibleMessages x1590 "w" = ["m1"] := rfl
example : closedLedger x1590 = [] := rfl
def x1593 : Model := ⟨["m0","m1"],["k1"],[a,b],[]⟩
example : possibleMessages x1593 "v" = [] := rfl
example : possibleMessages x1593 "w" = [] := rfl
example : closedLedger x1593 = [] := rfl
def x1596 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x1596 "v" = ["m1"] := rfl
example : possibleMessages x1596 "w" = [] := rfl
example : closedLedger x1596 = [] := rfl
def x1599 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x1599 "v" = [] := rfl
example : possibleMessages x1599 "w" = ["m1"] := rfl
example : closedLedger x1599 = [] := rfl
def x1602 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x1602 "v" = [] := rfl
example : possibleMessages x1602 "w" = [] := rfl
example : closedLedger x1602 = [] := rfl
def x1605 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1605 "v" = ["m1"] := rfl
example : possibleMessages x1605 "w" = [] := rfl
example : closedLedger x1605 = [] := rfl
def x1608 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1608 "v" = [] := rfl
example : possibleMessages x1608 "w" = ["m1"] := rfl
example : closedLedger x1608 = [] := rfl
def x1611 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x1611 "v" = [] := rfl
example : possibleMessages x1611 "w" = [] := rfl
example : closedLedger x1611 = [] := rfl
def x1614 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1614 "v" = ["m1"] := rfl
example : possibleMessages x1614 "w" = [] := rfl
example : closedLedger x1614 = [] := rfl
def x1617 : Model := ⟨["m0","m1"],["k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1617 "v" = [] := rfl
example : possibleMessages x1617 "w" = ["m1"] := rfl
example : closedLedger x1617 = [] := rfl
def x1620 : Model := ⟨["m0","m1"],["k0","k1"],[],[]⟩
example : possibleMessages x1620 "v" = [] := rfl
example : possibleMessages x1620 "w" = [] := rfl
example : closedLedger x1620 = [] := rfl
def x1623 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c1","v")]⟩
example : possibleMessages x1623 "v" = [] := rfl
example : possibleMessages x1623 "w" = [] := rfl
example : closedLedger x1623 = [] := rfl
def x1626 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c1","w")]⟩
example : possibleMessages x1626 "v" = [] := rfl
example : possibleMessages x1626 "w" = [] := rfl
example : closedLedger x1626 = [] := rfl
def x1629 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","v")]⟩
example : possibleMessages x1629 "v" = [] := rfl
example : possibleMessages x1629 "w" = [] := rfl
example : closedLedger x1629 = [] := rfl
def x1632 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1632 "v" = [] := rfl
example : possibleMessages x1632 "w" = [] := rfl
example : closedLedger x1632 = [] := rfl
def x1635 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1635 "v" = [] := rfl
example : possibleMessages x1635 "w" = [] := rfl
example : closedLedger x1635 = [] := rfl
def x1638 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","w")]⟩
example : possibleMessages x1638 "v" = [] := rfl
example : possibleMessages x1638 "w" = [] := rfl
example : closedLedger x1638 = [] := rfl
def x1641 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1641 "v" = [] := rfl
example : possibleMessages x1641 "w" = [] := rfl
example : closedLedger x1641 = [] := rfl
def x1644 : Model := ⟨["m0","m1"],["k0","k1"],[],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1644 "v" = [] := rfl
example : possibleMessages x1644 "w" = [] := rfl
example : closedLedger x1644 = [] := rfl
def x1647 : Model := ⟨["m0","m1"],["k0","k1"],[a],[]⟩
example : possibleMessages x1647 "v" = [] := rfl
example : possibleMessages x1647 "w" = [] := rfl
example : closedLedger x1647 = [] := rfl
def x1650 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c1","v")]⟩
example : possibleMessages x1650 "v" = [] := rfl
example : possibleMessages x1650 "w" = [] := rfl
example : closedLedger x1650 = [] := rfl
def x1653 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c1","w")]⟩
example : possibleMessages x1653 "v" = [] := rfl
example : possibleMessages x1653 "w" = [] := rfl
example : closedLedger x1653 = [] := rfl
def x1656 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","v")]⟩
example : possibleMessages x1656 "v" = ["m0"] := rfl
example : possibleMessages x1656 "w" = [] := rfl
example : closedLedger x1656 = [] := rfl
def x1659 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1659 "v" = ["m0"] := rfl
example : possibleMessages x1659 "w" = [] := rfl
example : closedLedger x1659 = [] := rfl
def x1662 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1662 "v" = ["m0"] := rfl
example : possibleMessages x1662 "w" = [] := rfl
example : closedLedger x1662 = [] := rfl
def x1665 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","w")]⟩
example : possibleMessages x1665 "v" = [] := rfl
example : possibleMessages x1665 "w" = ["m0"] := rfl
example : closedLedger x1665 = [] := rfl
def x1668 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1668 "v" = [] := rfl
example : possibleMessages x1668 "w" = ["m0"] := rfl
example : closedLedger x1668 = [] := rfl
def x1671 : Model := ⟨["m0","m1"],["k0","k1"],[a],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1671 "v" = [] := rfl
example : possibleMessages x1671 "w" = ["m0"] := rfl
example : closedLedger x1671 = [] := rfl
def x1674 : Model := ⟨["m0","m1"],["k0","k1"],[b],[]⟩
example : possibleMessages x1674 "v" = [] := rfl
example : possibleMessages x1674 "w" = [] := rfl
example : closedLedger x1674 = [] := rfl
def x1677 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c1","v")]⟩
example : possibleMessages x1677 "v" = ["m1"] := rfl
example : possibleMessages x1677 "w" = [] := rfl
example : closedLedger x1677 = [] := rfl
def x1680 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c1","w")]⟩
example : possibleMessages x1680 "v" = [] := rfl
example : possibleMessages x1680 "w" = ["m1"] := rfl
example : closedLedger x1680 = [] := rfl
def x1683 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","v")]⟩
example : possibleMessages x1683 "v" = [] := rfl
example : possibleMessages x1683 "w" = [] := rfl
example : closedLedger x1683 = [] := rfl
def x1686 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1686 "v" = ["m1"] := rfl
example : possibleMessages x1686 "w" = [] := rfl
example : closedLedger x1686 = [] := rfl
def x1689 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1689 "v" = [] := rfl
example : possibleMessages x1689 "w" = ["m1"] := rfl
example : closedLedger x1689 = [] := rfl
def x1692 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","w")]⟩
example : possibleMessages x1692 "v" = [] := rfl
example : possibleMessages x1692 "w" = [] := rfl
example : closedLedger x1692 = [] := rfl
def x1695 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1695 "v" = ["m1"] := rfl
example : possibleMessages x1695 "w" = [] := rfl
example : closedLedger x1695 = [] := rfl
def x1698 : Model := ⟨["m0","m1"],["k0","k1"],[b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1698 "v" = [] := rfl
example : possibleMessages x1698 "w" = ["m1"] := rfl
example : closedLedger x1698 = [] := rfl
def x1701 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[]⟩
example : possibleMessages x1701 "v" = [] := rfl
example : possibleMessages x1701 "w" = [] := rfl
example : closedLedger x1701 = [] := rfl
def x1704 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c1","v")]⟩
example : possibleMessages x1704 "v" = ["m1"] := rfl
example : possibleMessages x1704 "w" = [] := rfl
example : closedLedger x1704 = [] := rfl
def x1707 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c1","w")]⟩
example : possibleMessages x1707 "v" = [] := rfl
example : possibleMessages x1707 "w" = ["m1"] := rfl
example : closedLedger x1707 = [] := rfl
def x1710 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","v")]⟩
example : possibleMessages x1710 "v" = ["m0"] := rfl
example : possibleMessages x1710 "w" = [] := rfl
example : closedLedger x1710 = [] := rfl
def x1713 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","v"),("c1","v")]⟩
example : possibleMessages x1713 "v" = ["m0","m1"] := rfl
example : possibleMessages x1713 "w" = [] := rfl
example : closedLedger x1713 = [(a,b),(b,a)] := rfl
def x1716 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","v"),("c1","w")]⟩
example : possibleMessages x1716 "v" = ["m0"] := rfl
example : possibleMessages x1716 "w" = ["m1"] := rfl
example : closedLedger x1716 = [] := rfl
def x1719 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","w")]⟩
example : possibleMessages x1719 "v" = [] := rfl
example : possibleMessages x1719 "w" = ["m0"] := rfl
example : closedLedger x1719 = [] := rfl
def x1722 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","w"),("c1","v")]⟩
example : possibleMessages x1722 "v" = ["m1"] := rfl
example : possibleMessages x1722 "w" = ["m0"] := rfl
example : closedLedger x1722 = [] := rfl
def x1725 : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","w"),("c1","w")]⟩
example : possibleMessages x1725 "v" = [] := rfl
example : possibleMessages x1725 "w" = ["m0","m1"] := rfl
example : closedLedger x1725 = [(a,b),(b,a)] := rfl
def hidden : Model := ⟨["m0","m1"],["k0","k1"],[a,b],[("c0","v"),("c1","v")]⟩
theorem nativeClosed : closed hidden a b := by
  refine ⟨⟨.head _,.head _,.head _,⟨"v",rfl⟩⟩,
    ⟨.tail _ (.head _),.tail _ (.head _),.tail _ (.head _),⟨"v",rfl⟩⟩,?_,rfl⟩
  decide
theorem nativeNoRecovery : ¬ ∃ decode : Option String → String,
    decode (SFT.Mathematics.GeometryTopology.image hidden.observation a.ciphertext) = a.message ∧
    decode (SFT.Mathematics.GeometryTopology.image hidden.observation b.ciphertext) = b.message :=
  noObservationRecovery hidden a b nativeClosed
example : disclosedView hidden (fun r => some r.message) a ≠ disclosedView hidden (fun r => some r.message) b := by decide
#print axioms nativeClosed
#print axioms nativeNoRecovery
