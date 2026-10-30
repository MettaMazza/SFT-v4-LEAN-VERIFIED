import SFT.Computation.Commitment
open SFT.Computation.Commitment
def a : Row := ⟨"m0","o0","c0"⟩
def b : Row := ⟨"m1","o1","c0"⟩
def c : Row := ⟨"m1","o1","c1"⟩
def m0 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[]⟩
example : binding m0 = true := rfl
example : bindingCollisions m0 = [] := rfl
example : observationClass m0 "v" = [] := rfl
example : observationClass m0 "w" = [] := rfl
def m4 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c1","v")]⟩
example : binding m4 = true := rfl
example : bindingCollisions m4 = [] := rfl
example : observationClass m4 "v" = [] := rfl
example : observationClass m4 "w" = [] := rfl
def m8 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c1","w")]⟩
example : binding m8 = true := rfl
example : bindingCollisions m8 = [] := rfl
example : observationClass m8 "v" = [] := rfl
example : observationClass m8 "w" = [] := rfl
def m12 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","v")]⟩
example : binding m12 = true := rfl
example : bindingCollisions m12 = [] := rfl
example : observationClass m12 "v" = [] := rfl
example : observationClass m12 "w" = [] := rfl
def m16 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","v"),("c1","v")]⟩
example : binding m16 = true := rfl
example : bindingCollisions m16 = [] := rfl
example : observationClass m16 "v" = [] := rfl
example : observationClass m16 "w" = [] := rfl
def m20 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","v"),("c1","w")]⟩
example : binding m20 = true := rfl
example : bindingCollisions m20 = [] := rfl
example : observationClass m20 "v" = [] := rfl
example : observationClass m20 "w" = [] := rfl
def m24 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","w")]⟩
example : binding m24 = true := rfl
example : bindingCollisions m24 = [] := rfl
example : observationClass m24 "v" = [] := rfl
example : observationClass m24 "w" = [] := rfl
def m28 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","w"),("c1","v")]⟩
example : binding m28 = true := rfl
example : bindingCollisions m28 = [] := rfl
example : observationClass m28 "v" = [] := rfl
example : observationClass m28 "w" = [] := rfl
def m32 : Model := ⟨["m0","m1"],["o0","o1"],[],[],[("c0","w"),("c1","w")]⟩
example : binding m32 = true := rfl
example : bindingCollisions m32 = [] := rfl
example : observationClass m32 "v" = [] := rfl
example : observationClass m32 "w" = [] := rfl
def m36 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[]⟩
example : binding m36 = true := rfl
example : bindingCollisions m36 = [] := rfl
example : observationClass m36 "v" = [] := rfl
example : observationClass m36 "w" = [] := rfl
def m40 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c1","v")]⟩
example : binding m40 = true := rfl
example : bindingCollisions m40 = [] := rfl
example : observationClass m40 "v" = [] := rfl
example : observationClass m40 "w" = [] := rfl
def m44 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c1","w")]⟩
example : binding m44 = true := rfl
example : bindingCollisions m44 = [] := rfl
example : observationClass m44 "v" = [] := rfl
example : observationClass m44 "w" = [] := rfl
def m48 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","v")]⟩
example : binding m48 = true := rfl
example : bindingCollisions m48 = [] := rfl
example : observationClass m48 "v" = [] := rfl
example : observationClass m48 "w" = [] := rfl
def m52 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","v"),("c1","v")]⟩
example : binding m52 = true := rfl
example : bindingCollisions m52 = [] := rfl
example : observationClass m52 "v" = [] := rfl
example : observationClass m52 "w" = [] := rfl
def m56 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","v"),("c1","w")]⟩
example : binding m56 = true := rfl
example : bindingCollisions m56 = [] := rfl
example : observationClass m56 "v" = [] := rfl
example : observationClass m56 "w" = [] := rfl
def m60 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","w")]⟩
example : binding m60 = true := rfl
example : bindingCollisions m60 = [] := rfl
example : observationClass m60 "v" = [] := rfl
example : observationClass m60 "w" = [] := rfl
def m64 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","w"),("c1","v")]⟩
example : binding m64 = true := rfl
example : bindingCollisions m64 = [] := rfl
example : observationClass m64 "v" = [] := rfl
example : observationClass m64 "w" = [] := rfl
def m68 : Model := ⟨["m0","m1"],["o0","o1"],[],[a],[("c0","w"),("c1","w")]⟩
example : binding m68 = true := rfl
example : bindingCollisions m68 = [] := rfl
example : observationClass m68 "v" = [] := rfl
example : observationClass m68 "w" = [] := rfl
def m72 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[]⟩
example : binding m72 = true := rfl
example : bindingCollisions m72 = [] := rfl
example : observationClass m72 "v" = [] := rfl
example : observationClass m72 "w" = [] := rfl
def m76 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c1","v")]⟩
example : binding m76 = true := rfl
example : bindingCollisions m76 = [] := rfl
example : observationClass m76 "v" = [] := rfl
example : observationClass m76 "w" = [] := rfl
def m80 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c1","w")]⟩
example : binding m80 = true := rfl
example : bindingCollisions m80 = [] := rfl
example : observationClass m80 "v" = [] := rfl
example : observationClass m80 "w" = [] := rfl
def m84 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","v")]⟩
example : binding m84 = true := rfl
example : bindingCollisions m84 = [] := rfl
example : observationClass m84 "v" = [] := rfl
example : observationClass m84 "w" = [] := rfl
def m88 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","v"),("c1","v")]⟩
example : binding m88 = true := rfl
example : bindingCollisions m88 = [] := rfl
example : observationClass m88 "v" = [] := rfl
example : observationClass m88 "w" = [] := rfl
def m92 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","v"),("c1","w")]⟩
example : binding m92 = true := rfl
example : bindingCollisions m92 = [] := rfl
example : observationClass m92 "v" = [] := rfl
example : observationClass m92 "w" = [] := rfl
def m96 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","w")]⟩
example : binding m96 = true := rfl
example : bindingCollisions m96 = [] := rfl
example : observationClass m96 "v" = [] := rfl
example : observationClass m96 "w" = [] := rfl
def m100 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","w"),("c1","v")]⟩
example : binding m100 = true := rfl
example : bindingCollisions m100 = [] := rfl
example : observationClass m100 "v" = [] := rfl
example : observationClass m100 "w" = [] := rfl
def m104 : Model := ⟨["m0","m1"],["o0","o1"],[],[b],[("c0","w"),("c1","w")]⟩
example : binding m104 = true := rfl
example : bindingCollisions m104 = [] := rfl
example : observationClass m104 "v" = [] := rfl
example : observationClass m104 "w" = [] := rfl
def m108 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[]⟩
example : binding m108 = false := rfl
example : bindingCollisions m108 = [(a,b),(b,a)] := rfl
example : observationClass m108 "v" = [] := rfl
example : observationClass m108 "w" = [] := rfl
def m112 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c1","v")]⟩
example : binding m112 = false := rfl
example : bindingCollisions m112 = [(a,b),(b,a)] := rfl
example : observationClass m112 "v" = [] := rfl
example : observationClass m112 "w" = [] := rfl
def m116 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c1","w")]⟩
example : binding m116 = false := rfl
example : bindingCollisions m116 = [(a,b),(b,a)] := rfl
example : observationClass m116 "v" = [] := rfl
example : observationClass m116 "w" = [] := rfl
def m120 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","v")]⟩
example : binding m120 = false := rfl
example : bindingCollisions m120 = [(a,b),(b,a)] := rfl
example : observationClass m120 "v" = [] := rfl
example : observationClass m120 "w" = [] := rfl
def m124 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m124 = false := rfl
example : bindingCollisions m124 = [(a,b),(b,a)] := rfl
example : observationClass m124 "v" = [] := rfl
example : observationClass m124 "w" = [] := rfl
def m128 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m128 = false := rfl
example : bindingCollisions m128 = [(a,b),(b,a)] := rfl
example : observationClass m128 "v" = [] := rfl
example : observationClass m128 "w" = [] := rfl
def m132 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","w")]⟩
example : binding m132 = false := rfl
example : bindingCollisions m132 = [(a,b),(b,a)] := rfl
example : observationClass m132 "v" = [] := rfl
example : observationClass m132 "w" = [] := rfl
def m136 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m136 = false := rfl
example : bindingCollisions m136 = [(a,b),(b,a)] := rfl
example : observationClass m136 "v" = [] := rfl
example : observationClass m136 "w" = [] := rfl
def m140 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m140 = false := rfl
example : bindingCollisions m140 = [(a,b),(b,a)] := rfl
example : observationClass m140 "v" = [] := rfl
example : observationClass m140 "w" = [] := rfl
def m144 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[]⟩
example : binding m144 = true := rfl
example : bindingCollisions m144 = [] := rfl
example : observationClass m144 "v" = [] := rfl
example : observationClass m144 "w" = [] := rfl
def m148 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c1","v")]⟩
example : binding m148 = true := rfl
example : bindingCollisions m148 = [] := rfl
example : observationClass m148 "v" = [] := rfl
example : observationClass m148 "w" = [] := rfl
def m152 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c1","w")]⟩
example : binding m152 = true := rfl
example : bindingCollisions m152 = [] := rfl
example : observationClass m152 "v" = [] := rfl
example : observationClass m152 "w" = [] := rfl
def m156 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","v")]⟩
example : binding m156 = true := rfl
example : bindingCollisions m156 = [] := rfl
example : observationClass m156 "v" = [] := rfl
example : observationClass m156 "w" = [] := rfl
def m160 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","v"),("c1","v")]⟩
example : binding m160 = true := rfl
example : bindingCollisions m160 = [] := rfl
example : observationClass m160 "v" = [] := rfl
example : observationClass m160 "w" = [] := rfl
def m164 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","v"),("c1","w")]⟩
example : binding m164 = true := rfl
example : bindingCollisions m164 = [] := rfl
example : observationClass m164 "v" = [] := rfl
example : observationClass m164 "w" = [] := rfl
def m168 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","w")]⟩
example : binding m168 = true := rfl
example : bindingCollisions m168 = [] := rfl
example : observationClass m168 "v" = [] := rfl
example : observationClass m168 "w" = [] := rfl
def m172 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","w"),("c1","v")]⟩
example : binding m172 = true := rfl
example : bindingCollisions m172 = [] := rfl
example : observationClass m172 "v" = [] := rfl
example : observationClass m172 "w" = [] := rfl
def m176 : Model := ⟨["m0","m1"],["o0","o1"],[],[c],[("c0","w"),("c1","w")]⟩
example : binding m176 = true := rfl
example : bindingCollisions m176 = [] := rfl
example : observationClass m176 "v" = [] := rfl
example : observationClass m176 "w" = [] := rfl
def m180 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[]⟩
example : binding m180 = true := rfl
example : bindingCollisions m180 = [] := rfl
example : observationClass m180 "v" = [] := rfl
example : observationClass m180 "w" = [] := rfl
def m184 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c1","v")]⟩
example : binding m184 = true := rfl
example : bindingCollisions m184 = [] := rfl
example : observationClass m184 "v" = [] := rfl
example : observationClass m184 "w" = [] := rfl
def m188 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c1","w")]⟩
example : binding m188 = true := rfl
example : bindingCollisions m188 = [] := rfl
example : observationClass m188 "v" = [] := rfl
example : observationClass m188 "w" = [] := rfl
def m192 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","v")]⟩
example : binding m192 = true := rfl
example : bindingCollisions m192 = [] := rfl
example : observationClass m192 "v" = [] := rfl
example : observationClass m192 "w" = [] := rfl
def m196 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m196 = true := rfl
example : bindingCollisions m196 = [] := rfl
example : observationClass m196 "v" = [] := rfl
example : observationClass m196 "w" = [] := rfl
def m200 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m200 = true := rfl
example : bindingCollisions m200 = [] := rfl
example : observationClass m200 "v" = [] := rfl
example : observationClass m200 "w" = [] := rfl
def m204 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","w")]⟩
example : binding m204 = true := rfl
example : bindingCollisions m204 = [] := rfl
example : observationClass m204 "v" = [] := rfl
example : observationClass m204 "w" = [] := rfl
def m208 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m208 = true := rfl
example : bindingCollisions m208 = [] := rfl
example : observationClass m208 "v" = [] := rfl
example : observationClass m208 "w" = [] := rfl
def m212 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m212 = true := rfl
example : bindingCollisions m212 = [] := rfl
example : observationClass m212 "v" = [] := rfl
example : observationClass m212 "w" = [] := rfl
def m216 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[]⟩
example : binding m216 = true := rfl
example : bindingCollisions m216 = [] := rfl
example : observationClass m216 "v" = [] := rfl
example : observationClass m216 "w" = [] := rfl
def m220 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c1","v")]⟩
example : binding m220 = true := rfl
example : bindingCollisions m220 = [] := rfl
example : observationClass m220 "v" = [] := rfl
example : observationClass m220 "w" = [] := rfl
def m224 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c1","w")]⟩
example : binding m224 = true := rfl
example : bindingCollisions m224 = [] := rfl
example : observationClass m224 "v" = [] := rfl
example : observationClass m224 "w" = [] := rfl
def m228 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","v")]⟩
example : binding m228 = true := rfl
example : bindingCollisions m228 = [] := rfl
example : observationClass m228 "v" = [] := rfl
example : observationClass m228 "w" = [] := rfl
def m232 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m232 = true := rfl
example : bindingCollisions m232 = [] := rfl
example : observationClass m232 "v" = [] := rfl
example : observationClass m232 "w" = [] := rfl
def m236 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m236 = true := rfl
example : bindingCollisions m236 = [] := rfl
example : observationClass m236 "v" = [] := rfl
example : observationClass m236 "w" = [] := rfl
def m240 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","w")]⟩
example : binding m240 = true := rfl
example : bindingCollisions m240 = [] := rfl
example : observationClass m240 "v" = [] := rfl
example : observationClass m240 "w" = [] := rfl
def m244 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m244 = true := rfl
example : bindingCollisions m244 = [] := rfl
example : observationClass m244 "v" = [] := rfl
example : observationClass m244 "w" = [] := rfl
def m248 : Model := ⟨["m0","m1"],["o0","o1"],[],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m248 = true := rfl
example : bindingCollisions m248 = [] := rfl
example : observationClass m248 "v" = [] := rfl
example : observationClass m248 "w" = [] := rfl
def m252 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[]⟩
example : binding m252 = false := rfl
example : bindingCollisions m252 = [(a,b),(b,a)] := rfl
example : observationClass m252 "v" = [] := rfl
example : observationClass m252 "w" = [] := rfl
def m256 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c1","v")]⟩
example : binding m256 = false := rfl
example : bindingCollisions m256 = [(a,b),(b,a)] := rfl
example : observationClass m256 "v" = [] := rfl
example : observationClass m256 "w" = [] := rfl
def m260 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c1","w")]⟩
example : binding m260 = false := rfl
example : bindingCollisions m260 = [(a,b),(b,a)] := rfl
example : observationClass m260 "v" = [] := rfl
example : observationClass m260 "w" = [] := rfl
def m264 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","v")]⟩
example : binding m264 = false := rfl
example : bindingCollisions m264 = [(a,b),(b,a)] := rfl
example : observationClass m264 "v" = [] := rfl
example : observationClass m264 "w" = [] := rfl
def m268 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m268 = false := rfl
example : bindingCollisions m268 = [(a,b),(b,a)] := rfl
example : observationClass m268 "v" = [] := rfl
example : observationClass m268 "w" = [] := rfl
def m272 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m272 = false := rfl
example : bindingCollisions m272 = [(a,b),(b,a)] := rfl
example : observationClass m272 "v" = [] := rfl
example : observationClass m272 "w" = [] := rfl
def m276 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","w")]⟩
example : binding m276 = false := rfl
example : bindingCollisions m276 = [(a,b),(b,a)] := rfl
example : observationClass m276 "v" = [] := rfl
example : observationClass m276 "w" = [] := rfl
def m280 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m280 = false := rfl
example : bindingCollisions m280 = [(a,b),(b,a)] := rfl
example : observationClass m280 "v" = [] := rfl
example : observationClass m280 "w" = [] := rfl
def m284 : Model := ⟨["m0","m1"],["o0","o1"],[],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m284 = false := rfl
example : bindingCollisions m284 = [(a,b),(b,a)] := rfl
example : observationClass m284 "v" = [] := rfl
example : observationClass m284 "w" = [] := rfl
def m288 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[]⟩
example : binding m288 = true := rfl
example : bindingCollisions m288 = [] := rfl
example : observationClass m288 "v" = [] := rfl
example : observationClass m288 "w" = [] := rfl
def m292 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c1","v")]⟩
example : binding m292 = true := rfl
example : bindingCollisions m292 = [] := rfl
example : observationClass m292 "v" = [] := rfl
example : observationClass m292 "w" = [] := rfl
def m296 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c1","w")]⟩
example : binding m296 = true := rfl
example : bindingCollisions m296 = [] := rfl
example : observationClass m296 "v" = [] := rfl
example : observationClass m296 "w" = [] := rfl
def m300 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","v")]⟩
example : binding m300 = true := rfl
example : bindingCollisions m300 = [] := rfl
example : observationClass m300 "v" = [a] := rfl
example : observationClass m300 "w" = [] := rfl
def m304 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","v"),("c1","v")]⟩
example : binding m304 = true := rfl
example : bindingCollisions m304 = [] := rfl
example : observationClass m304 "v" = [a] := rfl
example : observationClass m304 "w" = [] := rfl
def m308 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","v"),("c1","w")]⟩
example : binding m308 = true := rfl
example : bindingCollisions m308 = [] := rfl
example : observationClass m308 "v" = [a] := rfl
example : observationClass m308 "w" = [] := rfl
def m312 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","w")]⟩
example : binding m312 = true := rfl
example : bindingCollisions m312 = [] := rfl
example : observationClass m312 "v" = [] := rfl
example : observationClass m312 "w" = [a] := rfl
def m316 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","w"),("c1","v")]⟩
example : binding m316 = true := rfl
example : bindingCollisions m316 = [] := rfl
example : observationClass m316 "v" = [] := rfl
example : observationClass m316 "w" = [a] := rfl
def m320 : Model := ⟨["m0","m1"],["o0","o1"],[a],[],[("c0","w"),("c1","w")]⟩
example : binding m320 = true := rfl
example : bindingCollisions m320 = [] := rfl
example : observationClass m320 "v" = [] := rfl
example : observationClass m320 "w" = [a] := rfl
def m324 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[]⟩
example : binding m324 = true := rfl
example : bindingCollisions m324 = [] := rfl
example : observationClass m324 "v" = [] := rfl
example : observationClass m324 "w" = [] := rfl
def m328 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c1","v")]⟩
example : binding m328 = true := rfl
example : bindingCollisions m328 = [] := rfl
example : observationClass m328 "v" = [] := rfl
example : observationClass m328 "w" = [] := rfl
def m332 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c1","w")]⟩
example : binding m332 = true := rfl
example : bindingCollisions m332 = [] := rfl
example : observationClass m332 "v" = [] := rfl
example : observationClass m332 "w" = [] := rfl
def m336 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","v")]⟩
example : binding m336 = true := rfl
example : bindingCollisions m336 = [] := rfl
example : observationClass m336 "v" = [a] := rfl
example : observationClass m336 "w" = [] := rfl
def m340 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","v"),("c1","v")]⟩
example : binding m340 = true := rfl
example : bindingCollisions m340 = [] := rfl
example : observationClass m340 "v" = [a] := rfl
example : observationClass m340 "w" = [] := rfl
def m344 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","v"),("c1","w")]⟩
example : binding m344 = true := rfl
example : bindingCollisions m344 = [] := rfl
example : observationClass m344 "v" = [a] := rfl
example : observationClass m344 "w" = [] := rfl
def m348 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","w")]⟩
example : binding m348 = true := rfl
example : bindingCollisions m348 = [] := rfl
example : observationClass m348 "v" = [] := rfl
example : observationClass m348 "w" = [a] := rfl
def m352 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","w"),("c1","v")]⟩
example : binding m352 = true := rfl
example : bindingCollisions m352 = [] := rfl
example : observationClass m352 "v" = [] := rfl
example : observationClass m352 "w" = [a] := rfl
def m356 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a],[("c0","w"),("c1","w")]⟩
example : binding m356 = true := rfl
example : bindingCollisions m356 = [] := rfl
example : observationClass m356 "v" = [] := rfl
example : observationClass m356 "w" = [a] := rfl
def m360 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[]⟩
example : binding m360 = true := rfl
example : bindingCollisions m360 = [] := rfl
example : observationClass m360 "v" = [] := rfl
example : observationClass m360 "w" = [] := rfl
def m364 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c1","v")]⟩
example : binding m364 = true := rfl
example : bindingCollisions m364 = [] := rfl
example : observationClass m364 "v" = [] := rfl
example : observationClass m364 "w" = [] := rfl
def m368 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c1","w")]⟩
example : binding m368 = true := rfl
example : bindingCollisions m368 = [] := rfl
example : observationClass m368 "v" = [] := rfl
example : observationClass m368 "w" = [] := rfl
def m372 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","v")]⟩
example : binding m372 = true := rfl
example : bindingCollisions m372 = [] := rfl
example : observationClass m372 "v" = [a] := rfl
example : observationClass m372 "w" = [] := rfl
def m376 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","v"),("c1","v")]⟩
example : binding m376 = true := rfl
example : bindingCollisions m376 = [] := rfl
example : observationClass m376 "v" = [a] := rfl
example : observationClass m376 "w" = [] := rfl
def m380 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","v"),("c1","w")]⟩
example : binding m380 = true := rfl
example : bindingCollisions m380 = [] := rfl
example : observationClass m380 "v" = [a] := rfl
example : observationClass m380 "w" = [] := rfl
def m384 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","w")]⟩
example : binding m384 = true := rfl
example : bindingCollisions m384 = [] := rfl
example : observationClass m384 "v" = [] := rfl
example : observationClass m384 "w" = [a] := rfl
def m388 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","w"),("c1","v")]⟩
example : binding m388 = true := rfl
example : bindingCollisions m388 = [] := rfl
example : observationClass m388 "v" = [] := rfl
example : observationClass m388 "w" = [a] := rfl
def m392 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b],[("c0","w"),("c1","w")]⟩
example : binding m392 = true := rfl
example : bindingCollisions m392 = [] := rfl
example : observationClass m392 "v" = [] := rfl
example : observationClass m392 "w" = [a] := rfl
def m396 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[]⟩
example : binding m396 = false := rfl
example : bindingCollisions m396 = [(a,b),(b,a)] := rfl
example : observationClass m396 "v" = [] := rfl
example : observationClass m396 "w" = [] := rfl
def m400 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c1","v")]⟩
example : binding m400 = false := rfl
example : bindingCollisions m400 = [(a,b),(b,a)] := rfl
example : observationClass m400 "v" = [] := rfl
example : observationClass m400 "w" = [] := rfl
def m404 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c1","w")]⟩
example : binding m404 = false := rfl
example : bindingCollisions m404 = [(a,b),(b,a)] := rfl
example : observationClass m404 "v" = [] := rfl
example : observationClass m404 "w" = [] := rfl
def m408 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","v")]⟩
example : binding m408 = false := rfl
example : bindingCollisions m408 = [(a,b),(b,a)] := rfl
example : observationClass m408 "v" = [a] := rfl
example : observationClass m408 "w" = [] := rfl
def m412 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m412 = false := rfl
example : bindingCollisions m412 = [(a,b),(b,a)] := rfl
example : observationClass m412 "v" = [a] := rfl
example : observationClass m412 "w" = [] := rfl
def m416 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m416 = false := rfl
example : bindingCollisions m416 = [(a,b),(b,a)] := rfl
example : observationClass m416 "v" = [a] := rfl
example : observationClass m416 "w" = [] := rfl
def m420 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","w")]⟩
example : binding m420 = false := rfl
example : bindingCollisions m420 = [(a,b),(b,a)] := rfl
example : observationClass m420 "v" = [] := rfl
example : observationClass m420 "w" = [a] := rfl
def m424 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m424 = false := rfl
example : bindingCollisions m424 = [(a,b),(b,a)] := rfl
example : observationClass m424 "v" = [] := rfl
example : observationClass m424 "w" = [a] := rfl
def m428 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m428 = false := rfl
example : bindingCollisions m428 = [(a,b),(b,a)] := rfl
example : observationClass m428 "v" = [] := rfl
example : observationClass m428 "w" = [a] := rfl
def m432 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[]⟩
example : binding m432 = true := rfl
example : bindingCollisions m432 = [] := rfl
example : observationClass m432 "v" = [] := rfl
example : observationClass m432 "w" = [] := rfl
def m436 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c1","v")]⟩
example : binding m436 = true := rfl
example : bindingCollisions m436 = [] := rfl
example : observationClass m436 "v" = [] := rfl
example : observationClass m436 "w" = [] := rfl
def m440 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c1","w")]⟩
example : binding m440 = true := rfl
example : bindingCollisions m440 = [] := rfl
example : observationClass m440 "v" = [] := rfl
example : observationClass m440 "w" = [] := rfl
def m444 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","v")]⟩
example : binding m444 = true := rfl
example : bindingCollisions m444 = [] := rfl
example : observationClass m444 "v" = [a] := rfl
example : observationClass m444 "w" = [] := rfl
def m448 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","v"),("c1","v")]⟩
example : binding m448 = true := rfl
example : bindingCollisions m448 = [] := rfl
example : observationClass m448 "v" = [a] := rfl
example : observationClass m448 "w" = [] := rfl
def m452 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","v"),("c1","w")]⟩
example : binding m452 = true := rfl
example : bindingCollisions m452 = [] := rfl
example : observationClass m452 "v" = [a] := rfl
example : observationClass m452 "w" = [] := rfl
def m456 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","w")]⟩
example : binding m456 = true := rfl
example : bindingCollisions m456 = [] := rfl
example : observationClass m456 "v" = [] := rfl
example : observationClass m456 "w" = [a] := rfl
def m460 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","w"),("c1","v")]⟩
example : binding m460 = true := rfl
example : bindingCollisions m460 = [] := rfl
example : observationClass m460 "v" = [] := rfl
example : observationClass m460 "w" = [a] := rfl
def m464 : Model := ⟨["m0","m1"],["o0","o1"],[a],[c],[("c0","w"),("c1","w")]⟩
example : binding m464 = true := rfl
example : bindingCollisions m464 = [] := rfl
example : observationClass m464 "v" = [] := rfl
example : observationClass m464 "w" = [a] := rfl
def m468 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[]⟩
example : binding m468 = true := rfl
example : bindingCollisions m468 = [] := rfl
example : observationClass m468 "v" = [] := rfl
example : observationClass m468 "w" = [] := rfl
def m472 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c1","v")]⟩
example : binding m472 = true := rfl
example : bindingCollisions m472 = [] := rfl
example : observationClass m472 "v" = [] := rfl
example : observationClass m472 "w" = [] := rfl
def m476 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c1","w")]⟩
example : binding m476 = true := rfl
example : bindingCollisions m476 = [] := rfl
example : observationClass m476 "v" = [] := rfl
example : observationClass m476 "w" = [] := rfl
def m480 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","v")]⟩
example : binding m480 = true := rfl
example : bindingCollisions m480 = [] := rfl
example : observationClass m480 "v" = [a] := rfl
example : observationClass m480 "w" = [] := rfl
def m484 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m484 = true := rfl
example : bindingCollisions m484 = [] := rfl
example : observationClass m484 "v" = [a] := rfl
example : observationClass m484 "w" = [] := rfl
def m488 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m488 = true := rfl
example : bindingCollisions m488 = [] := rfl
example : observationClass m488 "v" = [a] := rfl
example : observationClass m488 "w" = [] := rfl
def m492 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","w")]⟩
example : binding m492 = true := rfl
example : bindingCollisions m492 = [] := rfl
example : observationClass m492 "v" = [] := rfl
example : observationClass m492 "w" = [a] := rfl
def m496 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m496 = true := rfl
example : bindingCollisions m496 = [] := rfl
example : observationClass m496 "v" = [] := rfl
example : observationClass m496 "w" = [a] := rfl
def m500 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m500 = true := rfl
example : bindingCollisions m500 = [] := rfl
example : observationClass m500 "v" = [] := rfl
example : observationClass m500 "w" = [a] := rfl
def m504 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[]⟩
example : binding m504 = true := rfl
example : bindingCollisions m504 = [] := rfl
example : observationClass m504 "v" = [] := rfl
example : observationClass m504 "w" = [] := rfl
def m508 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c1","v")]⟩
example : binding m508 = true := rfl
example : bindingCollisions m508 = [] := rfl
example : observationClass m508 "v" = [] := rfl
example : observationClass m508 "w" = [] := rfl
def m512 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c1","w")]⟩
example : binding m512 = true := rfl
example : bindingCollisions m512 = [] := rfl
example : observationClass m512 "v" = [] := rfl
example : observationClass m512 "w" = [] := rfl
def m516 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","v")]⟩
example : binding m516 = true := rfl
example : bindingCollisions m516 = [] := rfl
example : observationClass m516 "v" = [a] := rfl
example : observationClass m516 "w" = [] := rfl
def m520 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m520 = true := rfl
example : bindingCollisions m520 = [] := rfl
example : observationClass m520 "v" = [a] := rfl
example : observationClass m520 "w" = [] := rfl
def m524 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m524 = true := rfl
example : bindingCollisions m524 = [] := rfl
example : observationClass m524 "v" = [a] := rfl
example : observationClass m524 "w" = [] := rfl
def m528 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","w")]⟩
example : binding m528 = true := rfl
example : bindingCollisions m528 = [] := rfl
example : observationClass m528 "v" = [] := rfl
example : observationClass m528 "w" = [a] := rfl
def m532 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m532 = true := rfl
example : bindingCollisions m532 = [] := rfl
example : observationClass m532 "v" = [] := rfl
example : observationClass m532 "w" = [a] := rfl
def m536 : Model := ⟨["m0","m1"],["o0","o1"],[a],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m536 = true := rfl
example : bindingCollisions m536 = [] := rfl
example : observationClass m536 "v" = [] := rfl
example : observationClass m536 "w" = [a] := rfl
def m540 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[]⟩
example : binding m540 = false := rfl
example : bindingCollisions m540 = [(a,b),(b,a)] := rfl
example : observationClass m540 "v" = [] := rfl
example : observationClass m540 "w" = [] := rfl
def m544 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c1","v")]⟩
example : binding m544 = false := rfl
example : bindingCollisions m544 = [(a,b),(b,a)] := rfl
example : observationClass m544 "v" = [] := rfl
example : observationClass m544 "w" = [] := rfl
def m548 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c1","w")]⟩
example : binding m548 = false := rfl
example : bindingCollisions m548 = [(a,b),(b,a)] := rfl
example : observationClass m548 "v" = [] := rfl
example : observationClass m548 "w" = [] := rfl
def m552 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","v")]⟩
example : binding m552 = false := rfl
example : bindingCollisions m552 = [(a,b),(b,a)] := rfl
example : observationClass m552 "v" = [a] := rfl
example : observationClass m552 "w" = [] := rfl
def m556 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m556 = false := rfl
example : bindingCollisions m556 = [(a,b),(b,a)] := rfl
example : observationClass m556 "v" = [a] := rfl
example : observationClass m556 "w" = [] := rfl
def m560 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m560 = false := rfl
example : bindingCollisions m560 = [(a,b),(b,a)] := rfl
example : observationClass m560 "v" = [a] := rfl
example : observationClass m560 "w" = [] := rfl
def m564 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","w")]⟩
example : binding m564 = false := rfl
example : bindingCollisions m564 = [(a,b),(b,a)] := rfl
example : observationClass m564 "v" = [] := rfl
example : observationClass m564 "w" = [a] := rfl
def m568 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m568 = false := rfl
example : bindingCollisions m568 = [(a,b),(b,a)] := rfl
example : observationClass m568 "v" = [] := rfl
example : observationClass m568 "w" = [a] := rfl
def m572 : Model := ⟨["m0","m1"],["o0","o1"],[a],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m572 = false := rfl
example : bindingCollisions m572 = [(a,b),(b,a)] := rfl
example : observationClass m572 "v" = [] := rfl
example : observationClass m572 "w" = [a] := rfl
def m576 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[]⟩
example : binding m576 = true := rfl
example : bindingCollisions m576 = [] := rfl
example : observationClass m576 "v" = [] := rfl
example : observationClass m576 "w" = [] := rfl
def m580 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c1","v")]⟩
example : binding m580 = true := rfl
example : bindingCollisions m580 = [] := rfl
example : observationClass m580 "v" = [] := rfl
example : observationClass m580 "w" = [] := rfl
def m584 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c1","w")]⟩
example : binding m584 = true := rfl
example : bindingCollisions m584 = [] := rfl
example : observationClass m584 "v" = [] := rfl
example : observationClass m584 "w" = [] := rfl
def m588 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","v")]⟩
example : binding m588 = true := rfl
example : bindingCollisions m588 = [] := rfl
example : observationClass m588 "v" = [b] := rfl
example : observationClass m588 "w" = [] := rfl
def m592 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","v"),("c1","v")]⟩
example : binding m592 = true := rfl
example : bindingCollisions m592 = [] := rfl
example : observationClass m592 "v" = [b] := rfl
example : observationClass m592 "w" = [] := rfl
def m596 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","v"),("c1","w")]⟩
example : binding m596 = true := rfl
example : bindingCollisions m596 = [] := rfl
example : observationClass m596 "v" = [b] := rfl
example : observationClass m596 "w" = [] := rfl
def m600 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","w")]⟩
example : binding m600 = true := rfl
example : bindingCollisions m600 = [] := rfl
example : observationClass m600 "v" = [] := rfl
example : observationClass m600 "w" = [b] := rfl
def m604 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","w"),("c1","v")]⟩
example : binding m604 = true := rfl
example : bindingCollisions m604 = [] := rfl
example : observationClass m604 "v" = [] := rfl
example : observationClass m604 "w" = [b] := rfl
def m608 : Model := ⟨["m0","m1"],["o0","o1"],[b],[],[("c0","w"),("c1","w")]⟩
example : binding m608 = true := rfl
example : bindingCollisions m608 = [] := rfl
example : observationClass m608 "v" = [] := rfl
example : observationClass m608 "w" = [b] := rfl
def m612 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[]⟩
example : binding m612 = true := rfl
example : bindingCollisions m612 = [] := rfl
example : observationClass m612 "v" = [] := rfl
example : observationClass m612 "w" = [] := rfl
def m616 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c1","v")]⟩
example : binding m616 = true := rfl
example : bindingCollisions m616 = [] := rfl
example : observationClass m616 "v" = [] := rfl
example : observationClass m616 "w" = [] := rfl
def m620 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c1","w")]⟩
example : binding m620 = true := rfl
example : bindingCollisions m620 = [] := rfl
example : observationClass m620 "v" = [] := rfl
example : observationClass m620 "w" = [] := rfl
def m624 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","v")]⟩
example : binding m624 = true := rfl
example : bindingCollisions m624 = [] := rfl
example : observationClass m624 "v" = [b] := rfl
example : observationClass m624 "w" = [] := rfl
def m628 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","v"),("c1","v")]⟩
example : binding m628 = true := rfl
example : bindingCollisions m628 = [] := rfl
example : observationClass m628 "v" = [b] := rfl
example : observationClass m628 "w" = [] := rfl
def m632 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","v"),("c1","w")]⟩
example : binding m632 = true := rfl
example : bindingCollisions m632 = [] := rfl
example : observationClass m632 "v" = [b] := rfl
example : observationClass m632 "w" = [] := rfl
def m636 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","w")]⟩
example : binding m636 = true := rfl
example : bindingCollisions m636 = [] := rfl
example : observationClass m636 "v" = [] := rfl
example : observationClass m636 "w" = [b] := rfl
def m640 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","w"),("c1","v")]⟩
example : binding m640 = true := rfl
example : bindingCollisions m640 = [] := rfl
example : observationClass m640 "v" = [] := rfl
example : observationClass m640 "w" = [b] := rfl
def m644 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a],[("c0","w"),("c1","w")]⟩
example : binding m644 = true := rfl
example : bindingCollisions m644 = [] := rfl
example : observationClass m644 "v" = [] := rfl
example : observationClass m644 "w" = [b] := rfl
def m648 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[]⟩
example : binding m648 = true := rfl
example : bindingCollisions m648 = [] := rfl
example : observationClass m648 "v" = [] := rfl
example : observationClass m648 "w" = [] := rfl
def m652 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c1","v")]⟩
example : binding m652 = true := rfl
example : bindingCollisions m652 = [] := rfl
example : observationClass m652 "v" = [] := rfl
example : observationClass m652 "w" = [] := rfl
def m656 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c1","w")]⟩
example : binding m656 = true := rfl
example : bindingCollisions m656 = [] := rfl
example : observationClass m656 "v" = [] := rfl
example : observationClass m656 "w" = [] := rfl
def m660 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","v")]⟩
example : binding m660 = true := rfl
example : bindingCollisions m660 = [] := rfl
example : observationClass m660 "v" = [b] := rfl
example : observationClass m660 "w" = [] := rfl
def m664 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","v"),("c1","v")]⟩
example : binding m664 = true := rfl
example : bindingCollisions m664 = [] := rfl
example : observationClass m664 "v" = [b] := rfl
example : observationClass m664 "w" = [] := rfl
def m668 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","v"),("c1","w")]⟩
example : binding m668 = true := rfl
example : bindingCollisions m668 = [] := rfl
example : observationClass m668 "v" = [b] := rfl
example : observationClass m668 "w" = [] := rfl
def m672 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","w")]⟩
example : binding m672 = true := rfl
example : bindingCollisions m672 = [] := rfl
example : observationClass m672 "v" = [] := rfl
example : observationClass m672 "w" = [b] := rfl
def m676 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","w"),("c1","v")]⟩
example : binding m676 = true := rfl
example : bindingCollisions m676 = [] := rfl
example : observationClass m676 "v" = [] := rfl
example : observationClass m676 "w" = [b] := rfl
def m680 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b],[("c0","w"),("c1","w")]⟩
example : binding m680 = true := rfl
example : bindingCollisions m680 = [] := rfl
example : observationClass m680 "v" = [] := rfl
example : observationClass m680 "w" = [b] := rfl
def m684 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[]⟩
example : binding m684 = false := rfl
example : bindingCollisions m684 = [(a,b),(b,a)] := rfl
example : observationClass m684 "v" = [] := rfl
example : observationClass m684 "w" = [] := rfl
def m688 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c1","v")]⟩
example : binding m688 = false := rfl
example : bindingCollisions m688 = [(a,b),(b,a)] := rfl
example : observationClass m688 "v" = [] := rfl
example : observationClass m688 "w" = [] := rfl
def m692 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c1","w")]⟩
example : binding m692 = false := rfl
example : bindingCollisions m692 = [(a,b),(b,a)] := rfl
example : observationClass m692 "v" = [] := rfl
example : observationClass m692 "w" = [] := rfl
def m696 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","v")]⟩
example : binding m696 = false := rfl
example : bindingCollisions m696 = [(a,b),(b,a)] := rfl
example : observationClass m696 "v" = [b] := rfl
example : observationClass m696 "w" = [] := rfl
def m700 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m700 = false := rfl
example : bindingCollisions m700 = [(a,b),(b,a)] := rfl
example : observationClass m700 "v" = [b] := rfl
example : observationClass m700 "w" = [] := rfl
def m704 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m704 = false := rfl
example : bindingCollisions m704 = [(a,b),(b,a)] := rfl
example : observationClass m704 "v" = [b] := rfl
example : observationClass m704 "w" = [] := rfl
def m708 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","w")]⟩
example : binding m708 = false := rfl
example : bindingCollisions m708 = [(a,b),(b,a)] := rfl
example : observationClass m708 "v" = [] := rfl
example : observationClass m708 "w" = [b] := rfl
def m712 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m712 = false := rfl
example : bindingCollisions m712 = [(a,b),(b,a)] := rfl
example : observationClass m712 "v" = [] := rfl
example : observationClass m712 "w" = [b] := rfl
def m716 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m716 = false := rfl
example : bindingCollisions m716 = [(a,b),(b,a)] := rfl
example : observationClass m716 "v" = [] := rfl
example : observationClass m716 "w" = [b] := rfl
def m720 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[]⟩
example : binding m720 = true := rfl
example : bindingCollisions m720 = [] := rfl
example : observationClass m720 "v" = [] := rfl
example : observationClass m720 "w" = [] := rfl
def m724 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c1","v")]⟩
example : binding m724 = true := rfl
example : bindingCollisions m724 = [] := rfl
example : observationClass m724 "v" = [] := rfl
example : observationClass m724 "w" = [] := rfl
def m728 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c1","w")]⟩
example : binding m728 = true := rfl
example : bindingCollisions m728 = [] := rfl
example : observationClass m728 "v" = [] := rfl
example : observationClass m728 "w" = [] := rfl
def m732 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","v")]⟩
example : binding m732 = true := rfl
example : bindingCollisions m732 = [] := rfl
example : observationClass m732 "v" = [b] := rfl
example : observationClass m732 "w" = [] := rfl
def m736 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","v"),("c1","v")]⟩
example : binding m736 = true := rfl
example : bindingCollisions m736 = [] := rfl
example : observationClass m736 "v" = [b] := rfl
example : observationClass m736 "w" = [] := rfl
def m740 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","v"),("c1","w")]⟩
example : binding m740 = true := rfl
example : bindingCollisions m740 = [] := rfl
example : observationClass m740 "v" = [b] := rfl
example : observationClass m740 "w" = [] := rfl
def m744 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","w")]⟩
example : binding m744 = true := rfl
example : bindingCollisions m744 = [] := rfl
example : observationClass m744 "v" = [] := rfl
example : observationClass m744 "w" = [b] := rfl
def m748 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","w"),("c1","v")]⟩
example : binding m748 = true := rfl
example : bindingCollisions m748 = [] := rfl
example : observationClass m748 "v" = [] := rfl
example : observationClass m748 "w" = [b] := rfl
def m752 : Model := ⟨["m0","m1"],["o0","o1"],[b],[c],[("c0","w"),("c1","w")]⟩
example : binding m752 = true := rfl
example : bindingCollisions m752 = [] := rfl
example : observationClass m752 "v" = [] := rfl
example : observationClass m752 "w" = [b] := rfl
def m756 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[]⟩
example : binding m756 = true := rfl
example : bindingCollisions m756 = [] := rfl
example : observationClass m756 "v" = [] := rfl
example : observationClass m756 "w" = [] := rfl
def m760 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c1","v")]⟩
example : binding m760 = true := rfl
example : bindingCollisions m760 = [] := rfl
example : observationClass m760 "v" = [] := rfl
example : observationClass m760 "w" = [] := rfl
def m764 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c1","w")]⟩
example : binding m764 = true := rfl
example : bindingCollisions m764 = [] := rfl
example : observationClass m764 "v" = [] := rfl
example : observationClass m764 "w" = [] := rfl
def m768 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","v")]⟩
example : binding m768 = true := rfl
example : bindingCollisions m768 = [] := rfl
example : observationClass m768 "v" = [b] := rfl
example : observationClass m768 "w" = [] := rfl
def m772 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m772 = true := rfl
example : bindingCollisions m772 = [] := rfl
example : observationClass m772 "v" = [b] := rfl
example : observationClass m772 "w" = [] := rfl
def m776 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m776 = true := rfl
example : bindingCollisions m776 = [] := rfl
example : observationClass m776 "v" = [b] := rfl
example : observationClass m776 "w" = [] := rfl
def m780 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","w")]⟩
example : binding m780 = true := rfl
example : bindingCollisions m780 = [] := rfl
example : observationClass m780 "v" = [] := rfl
example : observationClass m780 "w" = [b] := rfl
def m784 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m784 = true := rfl
example : bindingCollisions m784 = [] := rfl
example : observationClass m784 "v" = [] := rfl
example : observationClass m784 "w" = [b] := rfl
def m788 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m788 = true := rfl
example : bindingCollisions m788 = [] := rfl
example : observationClass m788 "v" = [] := rfl
example : observationClass m788 "w" = [b] := rfl
def m792 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[]⟩
example : binding m792 = true := rfl
example : bindingCollisions m792 = [] := rfl
example : observationClass m792 "v" = [] := rfl
example : observationClass m792 "w" = [] := rfl
def m796 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c1","v")]⟩
example : binding m796 = true := rfl
example : bindingCollisions m796 = [] := rfl
example : observationClass m796 "v" = [] := rfl
example : observationClass m796 "w" = [] := rfl
def m800 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c1","w")]⟩
example : binding m800 = true := rfl
example : bindingCollisions m800 = [] := rfl
example : observationClass m800 "v" = [] := rfl
example : observationClass m800 "w" = [] := rfl
def m804 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","v")]⟩
example : binding m804 = true := rfl
example : bindingCollisions m804 = [] := rfl
example : observationClass m804 "v" = [b] := rfl
example : observationClass m804 "w" = [] := rfl
def m808 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m808 = true := rfl
example : bindingCollisions m808 = [] := rfl
example : observationClass m808 "v" = [b] := rfl
example : observationClass m808 "w" = [] := rfl
def m812 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m812 = true := rfl
example : bindingCollisions m812 = [] := rfl
example : observationClass m812 "v" = [b] := rfl
example : observationClass m812 "w" = [] := rfl
def m816 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","w")]⟩
example : binding m816 = true := rfl
example : bindingCollisions m816 = [] := rfl
example : observationClass m816 "v" = [] := rfl
example : observationClass m816 "w" = [b] := rfl
def m820 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m820 = true := rfl
example : bindingCollisions m820 = [] := rfl
example : observationClass m820 "v" = [] := rfl
example : observationClass m820 "w" = [b] := rfl
def m824 : Model := ⟨["m0","m1"],["o0","o1"],[b],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m824 = true := rfl
example : bindingCollisions m824 = [] := rfl
example : observationClass m824 "v" = [] := rfl
example : observationClass m824 "w" = [b] := rfl
def m828 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[]⟩
example : binding m828 = false := rfl
example : bindingCollisions m828 = [(a,b),(b,a)] := rfl
example : observationClass m828 "v" = [] := rfl
example : observationClass m828 "w" = [] := rfl
def m832 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c1","v")]⟩
example : binding m832 = false := rfl
example : bindingCollisions m832 = [(a,b),(b,a)] := rfl
example : observationClass m832 "v" = [] := rfl
example : observationClass m832 "w" = [] := rfl
def m836 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c1","w")]⟩
example : binding m836 = false := rfl
example : bindingCollisions m836 = [(a,b),(b,a)] := rfl
example : observationClass m836 "v" = [] := rfl
example : observationClass m836 "w" = [] := rfl
def m840 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","v")]⟩
example : binding m840 = false := rfl
example : bindingCollisions m840 = [(a,b),(b,a)] := rfl
example : observationClass m840 "v" = [b] := rfl
example : observationClass m840 "w" = [] := rfl
def m844 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m844 = false := rfl
example : bindingCollisions m844 = [(a,b),(b,a)] := rfl
example : observationClass m844 "v" = [b] := rfl
example : observationClass m844 "w" = [] := rfl
def m848 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m848 = false := rfl
example : bindingCollisions m848 = [(a,b),(b,a)] := rfl
example : observationClass m848 "v" = [b] := rfl
example : observationClass m848 "w" = [] := rfl
def m852 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","w")]⟩
example : binding m852 = false := rfl
example : bindingCollisions m852 = [(a,b),(b,a)] := rfl
example : observationClass m852 "v" = [] := rfl
example : observationClass m852 "w" = [b] := rfl
def m856 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m856 = false := rfl
example : bindingCollisions m856 = [(a,b),(b,a)] := rfl
example : observationClass m856 "v" = [] := rfl
example : observationClass m856 "w" = [b] := rfl
def m860 : Model := ⟨["m0","m1"],["o0","o1"],[b],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m860 = false := rfl
example : bindingCollisions m860 = [(a,b),(b,a)] := rfl
example : observationClass m860 "v" = [] := rfl
example : observationClass m860 "w" = [b] := rfl
def m864 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[]⟩
example : binding m864 = true := rfl
example : bindingCollisions m864 = [] := rfl
example : observationClass m864 "v" = [] := rfl
example : observationClass m864 "w" = [] := rfl
def m868 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c1","v")]⟩
example : binding m868 = true := rfl
example : bindingCollisions m868 = [] := rfl
example : observationClass m868 "v" = [] := rfl
example : observationClass m868 "w" = [] := rfl
def m872 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c1","w")]⟩
example : binding m872 = true := rfl
example : bindingCollisions m872 = [] := rfl
example : observationClass m872 "v" = [] := rfl
example : observationClass m872 "w" = [] := rfl
def m876 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","v")]⟩
example : binding m876 = true := rfl
example : bindingCollisions m876 = [] := rfl
example : observationClass m876 "v" = [a,b] := rfl
example : observationClass m876 "w" = [] := rfl
def m880 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","v"),("c1","v")]⟩
example : binding m880 = true := rfl
example : bindingCollisions m880 = [] := rfl
example : observationClass m880 "v" = [a,b] := rfl
example : observationClass m880 "w" = [] := rfl
def m884 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","v"),("c1","w")]⟩
example : binding m884 = true := rfl
example : bindingCollisions m884 = [] := rfl
example : observationClass m884 "v" = [a,b] := rfl
example : observationClass m884 "w" = [] := rfl
def m888 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","w")]⟩
example : binding m888 = true := rfl
example : bindingCollisions m888 = [] := rfl
example : observationClass m888 "v" = [] := rfl
example : observationClass m888 "w" = [a,b] := rfl
def m892 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","w"),("c1","v")]⟩
example : binding m892 = true := rfl
example : bindingCollisions m892 = [] := rfl
example : observationClass m892 "v" = [] := rfl
example : observationClass m892 "w" = [a,b] := rfl
def m896 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[],[("c0","w"),("c1","w")]⟩
example : binding m896 = true := rfl
example : bindingCollisions m896 = [] := rfl
example : observationClass m896 "v" = [] := rfl
example : observationClass m896 "w" = [a,b] := rfl
def m900 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[]⟩
example : binding m900 = true := rfl
example : bindingCollisions m900 = [] := rfl
example : observationClass m900 "v" = [] := rfl
example : observationClass m900 "w" = [] := rfl
def m904 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c1","v")]⟩
example : binding m904 = true := rfl
example : bindingCollisions m904 = [] := rfl
example : observationClass m904 "v" = [] := rfl
example : observationClass m904 "w" = [] := rfl
def m908 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c1","w")]⟩
example : binding m908 = true := rfl
example : bindingCollisions m908 = [] := rfl
example : observationClass m908 "v" = [] := rfl
example : observationClass m908 "w" = [] := rfl
def m912 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","v")]⟩
example : binding m912 = true := rfl
example : bindingCollisions m912 = [] := rfl
example : observationClass m912 "v" = [a,b] := rfl
example : observationClass m912 "w" = [] := rfl
def m916 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","v"),("c1","v")]⟩
example : binding m916 = true := rfl
example : bindingCollisions m916 = [] := rfl
example : observationClass m916 "v" = [a,b] := rfl
example : observationClass m916 "w" = [] := rfl
def m920 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","v"),("c1","w")]⟩
example : binding m920 = true := rfl
example : bindingCollisions m920 = [] := rfl
example : observationClass m920 "v" = [a,b] := rfl
example : observationClass m920 "w" = [] := rfl
def m924 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","w")]⟩
example : binding m924 = true := rfl
example : bindingCollisions m924 = [] := rfl
example : observationClass m924 "v" = [] := rfl
example : observationClass m924 "w" = [a,b] := rfl
def m928 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","w"),("c1","v")]⟩
example : binding m928 = true := rfl
example : bindingCollisions m928 = [] := rfl
example : observationClass m928 "v" = [] := rfl
example : observationClass m928 "w" = [a,b] := rfl
def m932 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a],[("c0","w"),("c1","w")]⟩
example : binding m932 = true := rfl
example : bindingCollisions m932 = [] := rfl
example : observationClass m932 "v" = [] := rfl
example : observationClass m932 "w" = [a,b] := rfl
def m936 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[]⟩
example : binding m936 = true := rfl
example : bindingCollisions m936 = [] := rfl
example : observationClass m936 "v" = [] := rfl
example : observationClass m936 "w" = [] := rfl
def m940 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c1","v")]⟩
example : binding m940 = true := rfl
example : bindingCollisions m940 = [] := rfl
example : observationClass m940 "v" = [] := rfl
example : observationClass m940 "w" = [] := rfl
def m944 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c1","w")]⟩
example : binding m944 = true := rfl
example : bindingCollisions m944 = [] := rfl
example : observationClass m944 "v" = [] := rfl
example : observationClass m944 "w" = [] := rfl
def m948 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","v")]⟩
example : binding m948 = true := rfl
example : bindingCollisions m948 = [] := rfl
example : observationClass m948 "v" = [a,b] := rfl
example : observationClass m948 "w" = [] := rfl
def m952 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","v"),("c1","v")]⟩
example : binding m952 = true := rfl
example : bindingCollisions m952 = [] := rfl
example : observationClass m952 "v" = [a,b] := rfl
example : observationClass m952 "w" = [] := rfl
def m956 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","v"),("c1","w")]⟩
example : binding m956 = true := rfl
example : bindingCollisions m956 = [] := rfl
example : observationClass m956 "v" = [a,b] := rfl
example : observationClass m956 "w" = [] := rfl
def m960 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","w")]⟩
example : binding m960 = true := rfl
example : bindingCollisions m960 = [] := rfl
example : observationClass m960 "v" = [] := rfl
example : observationClass m960 "w" = [a,b] := rfl
def m964 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","w"),("c1","v")]⟩
example : binding m964 = true := rfl
example : bindingCollisions m964 = [] := rfl
example : observationClass m964 "v" = [] := rfl
example : observationClass m964 "w" = [a,b] := rfl
def m968 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b],[("c0","w"),("c1","w")]⟩
example : binding m968 = true := rfl
example : bindingCollisions m968 = [] := rfl
example : observationClass m968 "v" = [] := rfl
example : observationClass m968 "w" = [a,b] := rfl
def m972 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[]⟩
example : binding m972 = false := rfl
example : bindingCollisions m972 = [(a,b),(b,a)] := rfl
example : observationClass m972 "v" = [] := rfl
example : observationClass m972 "w" = [] := rfl
def m976 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c1","v")]⟩
example : binding m976 = false := rfl
example : bindingCollisions m976 = [(a,b),(b,a)] := rfl
example : observationClass m976 "v" = [] := rfl
example : observationClass m976 "w" = [] := rfl
def m980 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c1","w")]⟩
example : binding m980 = false := rfl
example : bindingCollisions m980 = [(a,b),(b,a)] := rfl
example : observationClass m980 "v" = [] := rfl
example : observationClass m980 "w" = [] := rfl
def m984 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","v")]⟩
example : binding m984 = false := rfl
example : bindingCollisions m984 = [(a,b),(b,a)] := rfl
example : observationClass m984 "v" = [a,b] := rfl
example : observationClass m984 "w" = [] := rfl
def m988 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m988 = false := rfl
example : bindingCollisions m988 = [(a,b),(b,a)] := rfl
example : observationClass m988 "v" = [a,b] := rfl
example : observationClass m988 "w" = [] := rfl
def m992 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m992 = false := rfl
example : bindingCollisions m992 = [(a,b),(b,a)] := rfl
example : observationClass m992 "v" = [a,b] := rfl
example : observationClass m992 "w" = [] := rfl
def m996 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","w")]⟩
example : binding m996 = false := rfl
example : bindingCollisions m996 = [(a,b),(b,a)] := rfl
example : observationClass m996 "v" = [] := rfl
example : observationClass m996 "w" = [a,b] := rfl
def m1000 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m1000 = false := rfl
example : bindingCollisions m1000 = [(a,b),(b,a)] := rfl
example : observationClass m1000 "v" = [] := rfl
example : observationClass m1000 "w" = [a,b] := rfl
def m1004 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m1004 = false := rfl
example : bindingCollisions m1004 = [(a,b),(b,a)] := rfl
example : observationClass m1004 "v" = [] := rfl
example : observationClass m1004 "w" = [a,b] := rfl
def m1008 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[]⟩
example : binding m1008 = true := rfl
example : bindingCollisions m1008 = [] := rfl
example : observationClass m1008 "v" = [] := rfl
example : observationClass m1008 "w" = [] := rfl
def m1012 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c1","v")]⟩
example : binding m1012 = true := rfl
example : bindingCollisions m1012 = [] := rfl
example : observationClass m1012 "v" = [] := rfl
example : observationClass m1012 "w" = [] := rfl
def m1016 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c1","w")]⟩
example : binding m1016 = true := rfl
example : bindingCollisions m1016 = [] := rfl
example : observationClass m1016 "v" = [] := rfl
example : observationClass m1016 "w" = [] := rfl
def m1020 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","v")]⟩
example : binding m1020 = true := rfl
example : bindingCollisions m1020 = [] := rfl
example : observationClass m1020 "v" = [a,b] := rfl
example : observationClass m1020 "w" = [] := rfl
def m1024 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","v"),("c1","v")]⟩
example : binding m1024 = true := rfl
example : bindingCollisions m1024 = [] := rfl
example : observationClass m1024 "v" = [a,b] := rfl
example : observationClass m1024 "w" = [] := rfl
def m1028 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","v"),("c1","w")]⟩
example : binding m1028 = true := rfl
example : bindingCollisions m1028 = [] := rfl
example : observationClass m1028 "v" = [a,b] := rfl
example : observationClass m1028 "w" = [] := rfl
def m1032 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","w")]⟩
example : binding m1032 = true := rfl
example : bindingCollisions m1032 = [] := rfl
example : observationClass m1032 "v" = [] := rfl
example : observationClass m1032 "w" = [a,b] := rfl
def m1036 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","w"),("c1","v")]⟩
example : binding m1036 = true := rfl
example : bindingCollisions m1036 = [] := rfl
example : observationClass m1036 "v" = [] := rfl
example : observationClass m1036 "w" = [a,b] := rfl
def m1040 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[c],[("c0","w"),("c1","w")]⟩
example : binding m1040 = true := rfl
example : bindingCollisions m1040 = [] := rfl
example : observationClass m1040 "v" = [] := rfl
example : observationClass m1040 "w" = [a,b] := rfl
def m1044 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[]⟩
example : binding m1044 = true := rfl
example : bindingCollisions m1044 = [] := rfl
example : observationClass m1044 "v" = [] := rfl
example : observationClass m1044 "w" = [] := rfl
def m1048 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c1","v")]⟩
example : binding m1048 = true := rfl
example : bindingCollisions m1048 = [] := rfl
example : observationClass m1048 "v" = [] := rfl
example : observationClass m1048 "w" = [] := rfl
def m1052 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c1","w")]⟩
example : binding m1052 = true := rfl
example : bindingCollisions m1052 = [] := rfl
example : observationClass m1052 "v" = [] := rfl
example : observationClass m1052 "w" = [] := rfl
def m1056 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","v")]⟩
example : binding m1056 = true := rfl
example : bindingCollisions m1056 = [] := rfl
example : observationClass m1056 "v" = [a,b] := rfl
example : observationClass m1056 "w" = [] := rfl
def m1060 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m1060 = true := rfl
example : bindingCollisions m1060 = [] := rfl
example : observationClass m1060 "v" = [a,b] := rfl
example : observationClass m1060 "w" = [] := rfl
def m1064 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m1064 = true := rfl
example : bindingCollisions m1064 = [] := rfl
example : observationClass m1064 "v" = [a,b] := rfl
example : observationClass m1064 "w" = [] := rfl
def m1068 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","w")]⟩
example : binding m1068 = true := rfl
example : bindingCollisions m1068 = [] := rfl
example : observationClass m1068 "v" = [] := rfl
example : observationClass m1068 "w" = [a,b] := rfl
def m1072 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m1072 = true := rfl
example : bindingCollisions m1072 = [] := rfl
example : observationClass m1072 "v" = [] := rfl
example : observationClass m1072 "w" = [a,b] := rfl
def m1076 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m1076 = true := rfl
example : bindingCollisions m1076 = [] := rfl
example : observationClass m1076 "v" = [] := rfl
example : observationClass m1076 "w" = [a,b] := rfl
def m1080 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[]⟩
example : binding m1080 = true := rfl
example : bindingCollisions m1080 = [] := rfl
example : observationClass m1080 "v" = [] := rfl
example : observationClass m1080 "w" = [] := rfl
def m1084 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c1","v")]⟩
example : binding m1084 = true := rfl
example : bindingCollisions m1084 = [] := rfl
example : observationClass m1084 "v" = [] := rfl
example : observationClass m1084 "w" = [] := rfl
def m1088 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c1","w")]⟩
example : binding m1088 = true := rfl
example : bindingCollisions m1088 = [] := rfl
example : observationClass m1088 "v" = [] := rfl
example : observationClass m1088 "w" = [] := rfl
def m1092 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","v")]⟩
example : binding m1092 = true := rfl
example : bindingCollisions m1092 = [] := rfl
example : observationClass m1092 "v" = [a,b] := rfl
example : observationClass m1092 "w" = [] := rfl
def m1096 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m1096 = true := rfl
example : bindingCollisions m1096 = [] := rfl
example : observationClass m1096 "v" = [a,b] := rfl
example : observationClass m1096 "w" = [] := rfl
def m1100 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m1100 = true := rfl
example : bindingCollisions m1100 = [] := rfl
example : observationClass m1100 "v" = [a,b] := rfl
example : observationClass m1100 "w" = [] := rfl
def m1104 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","w")]⟩
example : binding m1104 = true := rfl
example : bindingCollisions m1104 = [] := rfl
example : observationClass m1104 "v" = [] := rfl
example : observationClass m1104 "w" = [a,b] := rfl
def m1108 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m1108 = true := rfl
example : bindingCollisions m1108 = [] := rfl
example : observationClass m1108 "v" = [] := rfl
example : observationClass m1108 "w" = [a,b] := rfl
def m1112 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m1112 = true := rfl
example : bindingCollisions m1112 = [] := rfl
example : observationClass m1112 "v" = [] := rfl
example : observationClass m1112 "w" = [a,b] := rfl
def m1116 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[]⟩
example : binding m1116 = false := rfl
example : bindingCollisions m1116 = [(a,b),(b,a)] := rfl
example : observationClass m1116 "v" = [] := rfl
example : observationClass m1116 "w" = [] := rfl
def m1120 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c1","v")]⟩
example : binding m1120 = false := rfl
example : bindingCollisions m1120 = [(a,b),(b,a)] := rfl
example : observationClass m1120 "v" = [] := rfl
example : observationClass m1120 "w" = [] := rfl
def m1124 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c1","w")]⟩
example : binding m1124 = false := rfl
example : bindingCollisions m1124 = [(a,b),(b,a)] := rfl
example : observationClass m1124 "v" = [] := rfl
example : observationClass m1124 "w" = [] := rfl
def m1128 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","v")]⟩
example : binding m1128 = false := rfl
example : bindingCollisions m1128 = [(a,b),(b,a)] := rfl
example : observationClass m1128 "v" = [a,b] := rfl
example : observationClass m1128 "w" = [] := rfl
def m1132 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m1132 = false := rfl
example : bindingCollisions m1132 = [(a,b),(b,a)] := rfl
example : observationClass m1132 "v" = [a,b] := rfl
example : observationClass m1132 "w" = [] := rfl
def m1136 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m1136 = false := rfl
example : bindingCollisions m1136 = [(a,b),(b,a)] := rfl
example : observationClass m1136 "v" = [a,b] := rfl
example : observationClass m1136 "w" = [] := rfl
def m1140 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","w")]⟩
example : binding m1140 = false := rfl
example : bindingCollisions m1140 = [(a,b),(b,a)] := rfl
example : observationClass m1140 "v" = [] := rfl
example : observationClass m1140 "w" = [a,b] := rfl
def m1144 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m1144 = false := rfl
example : bindingCollisions m1144 = [(a,b),(b,a)] := rfl
example : observationClass m1144 "v" = [] := rfl
example : observationClass m1144 "w" = [a,b] := rfl
def m1148 : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m1148 = false := rfl
example : bindingCollisions m1148 = [(a,b),(b,a)] := rfl
example : observationClass m1148 "v" = [] := rfl
example : observationClass m1148 "w" = [a,b] := rfl
def m1152 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[]⟩
example : binding m1152 = true := rfl
example : bindingCollisions m1152 = [] := rfl
example : observationClass m1152 "v" = [] := rfl
example : observationClass m1152 "w" = [] := rfl
def m1156 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c1","v")]⟩
example : binding m1156 = true := rfl
example : bindingCollisions m1156 = [] := rfl
example : observationClass m1156 "v" = [c] := rfl
example : observationClass m1156 "w" = [] := rfl
def m1160 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c1","w")]⟩
example : binding m1160 = true := rfl
example : bindingCollisions m1160 = [] := rfl
example : observationClass m1160 "v" = [] := rfl
example : observationClass m1160 "w" = [c] := rfl
def m1164 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","v")]⟩
example : binding m1164 = true := rfl
example : bindingCollisions m1164 = [] := rfl
example : observationClass m1164 "v" = [] := rfl
example : observationClass m1164 "w" = [] := rfl
def m1168 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","v"),("c1","v")]⟩
example : binding m1168 = true := rfl
example : bindingCollisions m1168 = [] := rfl
example : observationClass m1168 "v" = [c] := rfl
example : observationClass m1168 "w" = [] := rfl
def m1172 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","v"),("c1","w")]⟩
example : binding m1172 = true := rfl
example : bindingCollisions m1172 = [] := rfl
example : observationClass m1172 "v" = [] := rfl
example : observationClass m1172 "w" = [c] := rfl
def m1176 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","w")]⟩
example : binding m1176 = true := rfl
example : bindingCollisions m1176 = [] := rfl
example : observationClass m1176 "v" = [] := rfl
example : observationClass m1176 "w" = [] := rfl
def m1180 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","w"),("c1","v")]⟩
example : binding m1180 = true := rfl
example : bindingCollisions m1180 = [] := rfl
example : observationClass m1180 "v" = [c] := rfl
example : observationClass m1180 "w" = [] := rfl
def m1184 : Model := ⟨["m0","m1"],["o0","o1"],[c],[],[("c0","w"),("c1","w")]⟩
example : binding m1184 = true := rfl
example : bindingCollisions m1184 = [] := rfl
example : observationClass m1184 "v" = [] := rfl
example : observationClass m1184 "w" = [c] := rfl
def m1188 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[]⟩
example : binding m1188 = true := rfl
example : bindingCollisions m1188 = [] := rfl
example : observationClass m1188 "v" = [] := rfl
example : observationClass m1188 "w" = [] := rfl
def m1192 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c1","v")]⟩
example : binding m1192 = true := rfl
example : bindingCollisions m1192 = [] := rfl
example : observationClass m1192 "v" = [c] := rfl
example : observationClass m1192 "w" = [] := rfl
def m1196 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c1","w")]⟩
example : binding m1196 = true := rfl
example : bindingCollisions m1196 = [] := rfl
example : observationClass m1196 "v" = [] := rfl
example : observationClass m1196 "w" = [c] := rfl
def m1200 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","v")]⟩
example : binding m1200 = true := rfl
example : bindingCollisions m1200 = [] := rfl
example : observationClass m1200 "v" = [] := rfl
example : observationClass m1200 "w" = [] := rfl
def m1204 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","v"),("c1","v")]⟩
example : binding m1204 = true := rfl
example : bindingCollisions m1204 = [] := rfl
example : observationClass m1204 "v" = [c] := rfl
example : observationClass m1204 "w" = [] := rfl
def m1208 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","v"),("c1","w")]⟩
example : binding m1208 = true := rfl
example : bindingCollisions m1208 = [] := rfl
example : observationClass m1208 "v" = [] := rfl
example : observationClass m1208 "w" = [c] := rfl
def m1212 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","w")]⟩
example : binding m1212 = true := rfl
example : bindingCollisions m1212 = [] := rfl
example : observationClass m1212 "v" = [] := rfl
example : observationClass m1212 "w" = [] := rfl
def m1216 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","w"),("c1","v")]⟩
example : binding m1216 = true := rfl
example : bindingCollisions m1216 = [] := rfl
example : observationClass m1216 "v" = [c] := rfl
example : observationClass m1216 "w" = [] := rfl
def m1220 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a],[("c0","w"),("c1","w")]⟩
example : binding m1220 = true := rfl
example : bindingCollisions m1220 = [] := rfl
example : observationClass m1220 "v" = [] := rfl
example : observationClass m1220 "w" = [c] := rfl
def m1224 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[]⟩
example : binding m1224 = true := rfl
example : bindingCollisions m1224 = [] := rfl
example : observationClass m1224 "v" = [] := rfl
example : observationClass m1224 "w" = [] := rfl
def m1228 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c1","v")]⟩
example : binding m1228 = true := rfl
example : bindingCollisions m1228 = [] := rfl
example : observationClass m1228 "v" = [c] := rfl
example : observationClass m1228 "w" = [] := rfl
def m1232 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c1","w")]⟩
example : binding m1232 = true := rfl
example : bindingCollisions m1232 = [] := rfl
example : observationClass m1232 "v" = [] := rfl
example : observationClass m1232 "w" = [c] := rfl
def m1236 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","v")]⟩
example : binding m1236 = true := rfl
example : bindingCollisions m1236 = [] := rfl
example : observationClass m1236 "v" = [] := rfl
example : observationClass m1236 "w" = [] := rfl
def m1240 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","v"),("c1","v")]⟩
example : binding m1240 = true := rfl
example : bindingCollisions m1240 = [] := rfl
example : observationClass m1240 "v" = [c] := rfl
example : observationClass m1240 "w" = [] := rfl
def m1244 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","v"),("c1","w")]⟩
example : binding m1244 = true := rfl
example : bindingCollisions m1244 = [] := rfl
example : observationClass m1244 "v" = [] := rfl
example : observationClass m1244 "w" = [c] := rfl
def m1248 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","w")]⟩
example : binding m1248 = true := rfl
example : bindingCollisions m1248 = [] := rfl
example : observationClass m1248 "v" = [] := rfl
example : observationClass m1248 "w" = [] := rfl
def m1252 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","w"),("c1","v")]⟩
example : binding m1252 = true := rfl
example : bindingCollisions m1252 = [] := rfl
example : observationClass m1252 "v" = [c] := rfl
example : observationClass m1252 "w" = [] := rfl
def m1256 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b],[("c0","w"),("c1","w")]⟩
example : binding m1256 = true := rfl
example : bindingCollisions m1256 = [] := rfl
example : observationClass m1256 "v" = [] := rfl
example : observationClass m1256 "w" = [c] := rfl
def m1260 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[]⟩
example : binding m1260 = false := rfl
example : bindingCollisions m1260 = [(a,b),(b,a)] := rfl
example : observationClass m1260 "v" = [] := rfl
example : observationClass m1260 "w" = [] := rfl
def m1264 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c1","v")]⟩
example : binding m1264 = false := rfl
example : bindingCollisions m1264 = [(a,b),(b,a)] := rfl
example : observationClass m1264 "v" = [c] := rfl
example : observationClass m1264 "w" = [] := rfl
def m1268 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c1","w")]⟩
example : binding m1268 = false := rfl
example : bindingCollisions m1268 = [(a,b),(b,a)] := rfl
example : observationClass m1268 "v" = [] := rfl
example : observationClass m1268 "w" = [c] := rfl
def m1272 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","v")]⟩
example : binding m1272 = false := rfl
example : bindingCollisions m1272 = [(a,b),(b,a)] := rfl
example : observationClass m1272 "v" = [] := rfl
example : observationClass m1272 "w" = [] := rfl
def m1276 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m1276 = false := rfl
example : bindingCollisions m1276 = [(a,b),(b,a)] := rfl
example : observationClass m1276 "v" = [c] := rfl
example : observationClass m1276 "w" = [] := rfl
def m1280 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m1280 = false := rfl
example : bindingCollisions m1280 = [(a,b),(b,a)] := rfl
example : observationClass m1280 "v" = [] := rfl
example : observationClass m1280 "w" = [c] := rfl
def m1284 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","w")]⟩
example : binding m1284 = false := rfl
example : bindingCollisions m1284 = [(a,b),(b,a)] := rfl
example : observationClass m1284 "v" = [] := rfl
example : observationClass m1284 "w" = [] := rfl
def m1288 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m1288 = false := rfl
example : bindingCollisions m1288 = [(a,b),(b,a)] := rfl
example : observationClass m1288 "v" = [c] := rfl
example : observationClass m1288 "w" = [] := rfl
def m1292 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m1292 = false := rfl
example : bindingCollisions m1292 = [(a,b),(b,a)] := rfl
example : observationClass m1292 "v" = [] := rfl
example : observationClass m1292 "w" = [c] := rfl
def m1296 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[]⟩
example : binding m1296 = true := rfl
example : bindingCollisions m1296 = [] := rfl
example : observationClass m1296 "v" = [] := rfl
example : observationClass m1296 "w" = [] := rfl
def m1300 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c1","v")]⟩
example : binding m1300 = true := rfl
example : bindingCollisions m1300 = [] := rfl
example : observationClass m1300 "v" = [c] := rfl
example : observationClass m1300 "w" = [] := rfl
def m1304 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c1","w")]⟩
example : binding m1304 = true := rfl
example : bindingCollisions m1304 = [] := rfl
example : observationClass m1304 "v" = [] := rfl
example : observationClass m1304 "w" = [c] := rfl
def m1308 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","v")]⟩
example : binding m1308 = true := rfl
example : bindingCollisions m1308 = [] := rfl
example : observationClass m1308 "v" = [] := rfl
example : observationClass m1308 "w" = [] := rfl
def m1312 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","v"),("c1","v")]⟩
example : binding m1312 = true := rfl
example : bindingCollisions m1312 = [] := rfl
example : observationClass m1312 "v" = [c] := rfl
example : observationClass m1312 "w" = [] := rfl
def m1316 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","v"),("c1","w")]⟩
example : binding m1316 = true := rfl
example : bindingCollisions m1316 = [] := rfl
example : observationClass m1316 "v" = [] := rfl
example : observationClass m1316 "w" = [c] := rfl
def m1320 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","w")]⟩
example : binding m1320 = true := rfl
example : bindingCollisions m1320 = [] := rfl
example : observationClass m1320 "v" = [] := rfl
example : observationClass m1320 "w" = [] := rfl
def m1324 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","w"),("c1","v")]⟩
example : binding m1324 = true := rfl
example : bindingCollisions m1324 = [] := rfl
example : observationClass m1324 "v" = [c] := rfl
example : observationClass m1324 "w" = [] := rfl
def m1328 : Model := ⟨["m0","m1"],["o0","o1"],[c],[c],[("c0","w"),("c1","w")]⟩
example : binding m1328 = true := rfl
example : bindingCollisions m1328 = [] := rfl
example : observationClass m1328 "v" = [] := rfl
example : observationClass m1328 "w" = [c] := rfl
def m1332 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[]⟩
example : binding m1332 = true := rfl
example : bindingCollisions m1332 = [] := rfl
example : observationClass m1332 "v" = [] := rfl
example : observationClass m1332 "w" = [] := rfl
def m1336 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c1","v")]⟩
example : binding m1336 = true := rfl
example : bindingCollisions m1336 = [] := rfl
example : observationClass m1336 "v" = [c] := rfl
example : observationClass m1336 "w" = [] := rfl
def m1340 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c1","w")]⟩
example : binding m1340 = true := rfl
example : bindingCollisions m1340 = [] := rfl
example : observationClass m1340 "v" = [] := rfl
example : observationClass m1340 "w" = [c] := rfl
def m1344 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","v")]⟩
example : binding m1344 = true := rfl
example : bindingCollisions m1344 = [] := rfl
example : observationClass m1344 "v" = [] := rfl
example : observationClass m1344 "w" = [] := rfl
def m1348 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m1348 = true := rfl
example : bindingCollisions m1348 = [] := rfl
example : observationClass m1348 "v" = [c] := rfl
example : observationClass m1348 "w" = [] := rfl
def m1352 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m1352 = true := rfl
example : bindingCollisions m1352 = [] := rfl
example : observationClass m1352 "v" = [] := rfl
example : observationClass m1352 "w" = [c] := rfl
def m1356 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","w")]⟩
example : binding m1356 = true := rfl
example : bindingCollisions m1356 = [] := rfl
example : observationClass m1356 "v" = [] := rfl
example : observationClass m1356 "w" = [] := rfl
def m1360 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m1360 = true := rfl
example : bindingCollisions m1360 = [] := rfl
example : observationClass m1360 "v" = [c] := rfl
example : observationClass m1360 "w" = [] := rfl
def m1364 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m1364 = true := rfl
example : bindingCollisions m1364 = [] := rfl
example : observationClass m1364 "v" = [] := rfl
example : observationClass m1364 "w" = [c] := rfl
def m1368 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[]⟩
example : binding m1368 = true := rfl
example : bindingCollisions m1368 = [] := rfl
example : observationClass m1368 "v" = [] := rfl
example : observationClass m1368 "w" = [] := rfl
def m1372 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c1","v")]⟩
example : binding m1372 = true := rfl
example : bindingCollisions m1372 = [] := rfl
example : observationClass m1372 "v" = [c] := rfl
example : observationClass m1372 "w" = [] := rfl
def m1376 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c1","w")]⟩
example : binding m1376 = true := rfl
example : bindingCollisions m1376 = [] := rfl
example : observationClass m1376 "v" = [] := rfl
example : observationClass m1376 "w" = [c] := rfl
def m1380 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","v")]⟩
example : binding m1380 = true := rfl
example : bindingCollisions m1380 = [] := rfl
example : observationClass m1380 "v" = [] := rfl
example : observationClass m1380 "w" = [] := rfl
def m1384 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m1384 = true := rfl
example : bindingCollisions m1384 = [] := rfl
example : observationClass m1384 "v" = [c] := rfl
example : observationClass m1384 "w" = [] := rfl
def m1388 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m1388 = true := rfl
example : bindingCollisions m1388 = [] := rfl
example : observationClass m1388 "v" = [] := rfl
example : observationClass m1388 "w" = [c] := rfl
def m1392 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","w")]⟩
example : binding m1392 = true := rfl
example : bindingCollisions m1392 = [] := rfl
example : observationClass m1392 "v" = [] := rfl
example : observationClass m1392 "w" = [] := rfl
def m1396 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m1396 = true := rfl
example : bindingCollisions m1396 = [] := rfl
example : observationClass m1396 "v" = [c] := rfl
example : observationClass m1396 "w" = [] := rfl
def m1400 : Model := ⟨["m0","m1"],["o0","o1"],[c],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m1400 = true := rfl
example : bindingCollisions m1400 = [] := rfl
example : observationClass m1400 "v" = [] := rfl
example : observationClass m1400 "w" = [c] := rfl
def m1404 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[]⟩
example : binding m1404 = false := rfl
example : bindingCollisions m1404 = [(a,b),(b,a)] := rfl
example : observationClass m1404 "v" = [] := rfl
example : observationClass m1404 "w" = [] := rfl
def m1408 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c1","v")]⟩
example : binding m1408 = false := rfl
example : bindingCollisions m1408 = [(a,b),(b,a)] := rfl
example : observationClass m1408 "v" = [c] := rfl
example : observationClass m1408 "w" = [] := rfl
def m1412 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c1","w")]⟩
example : binding m1412 = false := rfl
example : bindingCollisions m1412 = [(a,b),(b,a)] := rfl
example : observationClass m1412 "v" = [] := rfl
example : observationClass m1412 "w" = [c] := rfl
def m1416 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","v")]⟩
example : binding m1416 = false := rfl
example : bindingCollisions m1416 = [(a,b),(b,a)] := rfl
example : observationClass m1416 "v" = [] := rfl
example : observationClass m1416 "w" = [] := rfl
def m1420 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m1420 = false := rfl
example : bindingCollisions m1420 = [(a,b),(b,a)] := rfl
example : observationClass m1420 "v" = [c] := rfl
example : observationClass m1420 "w" = [] := rfl
def m1424 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m1424 = false := rfl
example : bindingCollisions m1424 = [(a,b),(b,a)] := rfl
example : observationClass m1424 "v" = [] := rfl
example : observationClass m1424 "w" = [c] := rfl
def m1428 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","w")]⟩
example : binding m1428 = false := rfl
example : bindingCollisions m1428 = [(a,b),(b,a)] := rfl
example : observationClass m1428 "v" = [] := rfl
example : observationClass m1428 "w" = [] := rfl
def m1432 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m1432 = false := rfl
example : bindingCollisions m1432 = [(a,b),(b,a)] := rfl
example : observationClass m1432 "v" = [c] := rfl
example : observationClass m1432 "w" = [] := rfl
def m1436 : Model := ⟨["m0","m1"],["o0","o1"],[c],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m1436 = false := rfl
example : bindingCollisions m1436 = [(a,b),(b,a)] := rfl
example : observationClass m1436 "v" = [] := rfl
example : observationClass m1436 "w" = [c] := rfl
def m1440 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[]⟩
example : binding m1440 = true := rfl
example : bindingCollisions m1440 = [] := rfl
example : observationClass m1440 "v" = [] := rfl
example : observationClass m1440 "w" = [] := rfl
def m1444 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c1","v")]⟩
example : binding m1444 = true := rfl
example : bindingCollisions m1444 = [] := rfl
example : observationClass m1444 "v" = [c] := rfl
example : observationClass m1444 "w" = [] := rfl
def m1448 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c1","w")]⟩
example : binding m1448 = true := rfl
example : bindingCollisions m1448 = [] := rfl
example : observationClass m1448 "v" = [] := rfl
example : observationClass m1448 "w" = [c] := rfl
def m1452 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","v")]⟩
example : binding m1452 = true := rfl
example : bindingCollisions m1452 = [] := rfl
example : observationClass m1452 "v" = [a] := rfl
example : observationClass m1452 "w" = [] := rfl
def m1456 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","v"),("c1","v")]⟩
example : binding m1456 = true := rfl
example : bindingCollisions m1456 = [] := rfl
example : observationClass m1456 "v" = [a,c] := rfl
example : observationClass m1456 "w" = [] := rfl
def m1460 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","v"),("c1","w")]⟩
example : binding m1460 = true := rfl
example : bindingCollisions m1460 = [] := rfl
example : observationClass m1460 "v" = [a] := rfl
example : observationClass m1460 "w" = [c] := rfl
def m1464 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","w")]⟩
example : binding m1464 = true := rfl
example : bindingCollisions m1464 = [] := rfl
example : observationClass m1464 "v" = [] := rfl
example : observationClass m1464 "w" = [a] := rfl
def m1468 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","w"),("c1","v")]⟩
example : binding m1468 = true := rfl
example : bindingCollisions m1468 = [] := rfl
example : observationClass m1468 "v" = [c] := rfl
example : observationClass m1468 "w" = [a] := rfl
def m1472 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[],[("c0","w"),("c1","w")]⟩
example : binding m1472 = true := rfl
example : bindingCollisions m1472 = [] := rfl
example : observationClass m1472 "v" = [] := rfl
example : observationClass m1472 "w" = [a,c] := rfl
def m1476 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[]⟩
example : binding m1476 = true := rfl
example : bindingCollisions m1476 = [] := rfl
example : observationClass m1476 "v" = [] := rfl
example : observationClass m1476 "w" = [] := rfl
def m1480 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c1","v")]⟩
example : binding m1480 = true := rfl
example : bindingCollisions m1480 = [] := rfl
example : observationClass m1480 "v" = [c] := rfl
example : observationClass m1480 "w" = [] := rfl
def m1484 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c1","w")]⟩
example : binding m1484 = true := rfl
example : bindingCollisions m1484 = [] := rfl
example : observationClass m1484 "v" = [] := rfl
example : observationClass m1484 "w" = [c] := rfl
def m1488 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","v")]⟩
example : binding m1488 = true := rfl
example : bindingCollisions m1488 = [] := rfl
example : observationClass m1488 "v" = [a] := rfl
example : observationClass m1488 "w" = [] := rfl
def m1492 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","v"),("c1","v")]⟩
example : binding m1492 = true := rfl
example : bindingCollisions m1492 = [] := rfl
example : observationClass m1492 "v" = [a,c] := rfl
example : observationClass m1492 "w" = [] := rfl
def m1496 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","v"),("c1","w")]⟩
example : binding m1496 = true := rfl
example : bindingCollisions m1496 = [] := rfl
example : observationClass m1496 "v" = [a] := rfl
example : observationClass m1496 "w" = [c] := rfl
def m1500 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","w")]⟩
example : binding m1500 = true := rfl
example : bindingCollisions m1500 = [] := rfl
example : observationClass m1500 "v" = [] := rfl
example : observationClass m1500 "w" = [a] := rfl
def m1504 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","w"),("c1","v")]⟩
example : binding m1504 = true := rfl
example : bindingCollisions m1504 = [] := rfl
example : observationClass m1504 "v" = [c] := rfl
example : observationClass m1504 "w" = [a] := rfl
def m1508 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a],[("c0","w"),("c1","w")]⟩
example : binding m1508 = true := rfl
example : bindingCollisions m1508 = [] := rfl
example : observationClass m1508 "v" = [] := rfl
example : observationClass m1508 "w" = [a,c] := rfl
def m1512 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[]⟩
example : binding m1512 = true := rfl
example : bindingCollisions m1512 = [] := rfl
example : observationClass m1512 "v" = [] := rfl
example : observationClass m1512 "w" = [] := rfl
def m1516 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c1","v")]⟩
example : binding m1516 = true := rfl
example : bindingCollisions m1516 = [] := rfl
example : observationClass m1516 "v" = [c] := rfl
example : observationClass m1516 "w" = [] := rfl
def m1520 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c1","w")]⟩
example : binding m1520 = true := rfl
example : bindingCollisions m1520 = [] := rfl
example : observationClass m1520 "v" = [] := rfl
example : observationClass m1520 "w" = [c] := rfl
def m1524 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","v")]⟩
example : binding m1524 = true := rfl
example : bindingCollisions m1524 = [] := rfl
example : observationClass m1524 "v" = [a] := rfl
example : observationClass m1524 "w" = [] := rfl
def m1528 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","v"),("c1","v")]⟩
example : binding m1528 = true := rfl
example : bindingCollisions m1528 = [] := rfl
example : observationClass m1528 "v" = [a,c] := rfl
example : observationClass m1528 "w" = [] := rfl
def m1532 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","v"),("c1","w")]⟩
example : binding m1532 = true := rfl
example : bindingCollisions m1532 = [] := rfl
example : observationClass m1532 "v" = [a] := rfl
example : observationClass m1532 "w" = [c] := rfl
def m1536 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","w")]⟩
example : binding m1536 = true := rfl
example : bindingCollisions m1536 = [] := rfl
example : observationClass m1536 "v" = [] := rfl
example : observationClass m1536 "w" = [a] := rfl
def m1540 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","w"),("c1","v")]⟩
example : binding m1540 = true := rfl
example : bindingCollisions m1540 = [] := rfl
example : observationClass m1540 "v" = [c] := rfl
example : observationClass m1540 "w" = [a] := rfl
def m1544 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b],[("c0","w"),("c1","w")]⟩
example : binding m1544 = true := rfl
example : bindingCollisions m1544 = [] := rfl
example : observationClass m1544 "v" = [] := rfl
example : observationClass m1544 "w" = [a,c] := rfl
def m1548 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[]⟩
example : binding m1548 = false := rfl
example : bindingCollisions m1548 = [(a,b),(b,a)] := rfl
example : observationClass m1548 "v" = [] := rfl
example : observationClass m1548 "w" = [] := rfl
def m1552 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c1","v")]⟩
example : binding m1552 = false := rfl
example : bindingCollisions m1552 = [(a,b),(b,a)] := rfl
example : observationClass m1552 "v" = [c] := rfl
example : observationClass m1552 "w" = [] := rfl
def m1556 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c1","w")]⟩
example : binding m1556 = false := rfl
example : bindingCollisions m1556 = [(a,b),(b,a)] := rfl
example : observationClass m1556 "v" = [] := rfl
example : observationClass m1556 "w" = [c] := rfl
def m1560 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","v")]⟩
example : binding m1560 = false := rfl
example : bindingCollisions m1560 = [(a,b),(b,a)] := rfl
example : observationClass m1560 "v" = [a] := rfl
example : observationClass m1560 "w" = [] := rfl
def m1564 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m1564 = false := rfl
example : bindingCollisions m1564 = [(a,b),(b,a)] := rfl
example : observationClass m1564 "v" = [a,c] := rfl
example : observationClass m1564 "w" = [] := rfl
def m1568 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m1568 = false := rfl
example : bindingCollisions m1568 = [(a,b),(b,a)] := rfl
example : observationClass m1568 "v" = [a] := rfl
example : observationClass m1568 "w" = [c] := rfl
def m1572 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","w")]⟩
example : binding m1572 = false := rfl
example : bindingCollisions m1572 = [(a,b),(b,a)] := rfl
example : observationClass m1572 "v" = [] := rfl
example : observationClass m1572 "w" = [a] := rfl
def m1576 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m1576 = false := rfl
example : bindingCollisions m1576 = [(a,b),(b,a)] := rfl
example : observationClass m1576 "v" = [c] := rfl
example : observationClass m1576 "w" = [a] := rfl
def m1580 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m1580 = false := rfl
example : bindingCollisions m1580 = [(a,b),(b,a)] := rfl
example : observationClass m1580 "v" = [] := rfl
example : observationClass m1580 "w" = [a,c] := rfl
def m1584 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[]⟩
example : binding m1584 = true := rfl
example : bindingCollisions m1584 = [] := rfl
example : observationClass m1584 "v" = [] := rfl
example : observationClass m1584 "w" = [] := rfl
def m1588 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c1","v")]⟩
example : binding m1588 = true := rfl
example : bindingCollisions m1588 = [] := rfl
example : observationClass m1588 "v" = [c] := rfl
example : observationClass m1588 "w" = [] := rfl
def m1592 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c1","w")]⟩
example : binding m1592 = true := rfl
example : bindingCollisions m1592 = [] := rfl
example : observationClass m1592 "v" = [] := rfl
example : observationClass m1592 "w" = [c] := rfl
def m1596 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","v")]⟩
example : binding m1596 = true := rfl
example : bindingCollisions m1596 = [] := rfl
example : observationClass m1596 "v" = [a] := rfl
example : observationClass m1596 "w" = [] := rfl
def m1600 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","v"),("c1","v")]⟩
example : binding m1600 = true := rfl
example : bindingCollisions m1600 = [] := rfl
example : observationClass m1600 "v" = [a,c] := rfl
example : observationClass m1600 "w" = [] := rfl
def m1604 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","v"),("c1","w")]⟩
example : binding m1604 = true := rfl
example : bindingCollisions m1604 = [] := rfl
example : observationClass m1604 "v" = [a] := rfl
example : observationClass m1604 "w" = [c] := rfl
def m1608 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","w")]⟩
example : binding m1608 = true := rfl
example : bindingCollisions m1608 = [] := rfl
example : observationClass m1608 "v" = [] := rfl
example : observationClass m1608 "w" = [a] := rfl
def m1612 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","w"),("c1","v")]⟩
example : binding m1612 = true := rfl
example : bindingCollisions m1612 = [] := rfl
example : observationClass m1612 "v" = [c] := rfl
example : observationClass m1612 "w" = [a] := rfl
def m1616 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[c],[("c0","w"),("c1","w")]⟩
example : binding m1616 = true := rfl
example : bindingCollisions m1616 = [] := rfl
example : observationClass m1616 "v" = [] := rfl
example : observationClass m1616 "w" = [a,c] := rfl
def m1620 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[]⟩
example : binding m1620 = true := rfl
example : bindingCollisions m1620 = [] := rfl
example : observationClass m1620 "v" = [] := rfl
example : observationClass m1620 "w" = [] := rfl
def m1624 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c1","v")]⟩
example : binding m1624 = true := rfl
example : bindingCollisions m1624 = [] := rfl
example : observationClass m1624 "v" = [c] := rfl
example : observationClass m1624 "w" = [] := rfl
def m1628 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c1","w")]⟩
example : binding m1628 = true := rfl
example : bindingCollisions m1628 = [] := rfl
example : observationClass m1628 "v" = [] := rfl
example : observationClass m1628 "w" = [c] := rfl
def m1632 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","v")]⟩
example : binding m1632 = true := rfl
example : bindingCollisions m1632 = [] := rfl
example : observationClass m1632 "v" = [a] := rfl
example : observationClass m1632 "w" = [] := rfl
def m1636 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m1636 = true := rfl
example : bindingCollisions m1636 = [] := rfl
example : observationClass m1636 "v" = [a,c] := rfl
example : observationClass m1636 "w" = [] := rfl
def m1640 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m1640 = true := rfl
example : bindingCollisions m1640 = [] := rfl
example : observationClass m1640 "v" = [a] := rfl
example : observationClass m1640 "w" = [c] := rfl
def m1644 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","w")]⟩
example : binding m1644 = true := rfl
example : bindingCollisions m1644 = [] := rfl
example : observationClass m1644 "v" = [] := rfl
example : observationClass m1644 "w" = [a] := rfl
def m1648 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m1648 = true := rfl
example : bindingCollisions m1648 = [] := rfl
example : observationClass m1648 "v" = [c] := rfl
example : observationClass m1648 "w" = [a] := rfl
def m1652 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m1652 = true := rfl
example : bindingCollisions m1652 = [] := rfl
example : observationClass m1652 "v" = [] := rfl
example : observationClass m1652 "w" = [a,c] := rfl
def m1656 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[]⟩
example : binding m1656 = true := rfl
example : bindingCollisions m1656 = [] := rfl
example : observationClass m1656 "v" = [] := rfl
example : observationClass m1656 "w" = [] := rfl
def m1660 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c1","v")]⟩
example : binding m1660 = true := rfl
example : bindingCollisions m1660 = [] := rfl
example : observationClass m1660 "v" = [c] := rfl
example : observationClass m1660 "w" = [] := rfl
def m1664 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c1","w")]⟩
example : binding m1664 = true := rfl
example : bindingCollisions m1664 = [] := rfl
example : observationClass m1664 "v" = [] := rfl
example : observationClass m1664 "w" = [c] := rfl
def m1668 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","v")]⟩
example : binding m1668 = true := rfl
example : bindingCollisions m1668 = [] := rfl
example : observationClass m1668 "v" = [a] := rfl
example : observationClass m1668 "w" = [] := rfl
def m1672 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m1672 = true := rfl
example : bindingCollisions m1672 = [] := rfl
example : observationClass m1672 "v" = [a,c] := rfl
example : observationClass m1672 "w" = [] := rfl
def m1676 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m1676 = true := rfl
example : bindingCollisions m1676 = [] := rfl
example : observationClass m1676 "v" = [a] := rfl
example : observationClass m1676 "w" = [c] := rfl
def m1680 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","w")]⟩
example : binding m1680 = true := rfl
example : bindingCollisions m1680 = [] := rfl
example : observationClass m1680 "v" = [] := rfl
example : observationClass m1680 "w" = [a] := rfl
def m1684 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m1684 = true := rfl
example : bindingCollisions m1684 = [] := rfl
example : observationClass m1684 "v" = [c] := rfl
example : observationClass m1684 "w" = [a] := rfl
def m1688 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m1688 = true := rfl
example : bindingCollisions m1688 = [] := rfl
example : observationClass m1688 "v" = [] := rfl
example : observationClass m1688 "w" = [a,c] := rfl
def m1692 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[]⟩
example : binding m1692 = false := rfl
example : bindingCollisions m1692 = [(a,b),(b,a)] := rfl
example : observationClass m1692 "v" = [] := rfl
example : observationClass m1692 "w" = [] := rfl
def m1696 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c1","v")]⟩
example : binding m1696 = false := rfl
example : bindingCollisions m1696 = [(a,b),(b,a)] := rfl
example : observationClass m1696 "v" = [c] := rfl
example : observationClass m1696 "w" = [] := rfl
def m1700 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c1","w")]⟩
example : binding m1700 = false := rfl
example : bindingCollisions m1700 = [(a,b),(b,a)] := rfl
example : observationClass m1700 "v" = [] := rfl
example : observationClass m1700 "w" = [c] := rfl
def m1704 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","v")]⟩
example : binding m1704 = false := rfl
example : bindingCollisions m1704 = [(a,b),(b,a)] := rfl
example : observationClass m1704 "v" = [a] := rfl
example : observationClass m1704 "w" = [] := rfl
def m1708 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m1708 = false := rfl
example : bindingCollisions m1708 = [(a,b),(b,a)] := rfl
example : observationClass m1708 "v" = [a,c] := rfl
example : observationClass m1708 "w" = [] := rfl
def m1712 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m1712 = false := rfl
example : bindingCollisions m1712 = [(a,b),(b,a)] := rfl
example : observationClass m1712 "v" = [a] := rfl
example : observationClass m1712 "w" = [c] := rfl
def m1716 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","w")]⟩
example : binding m1716 = false := rfl
example : bindingCollisions m1716 = [(a,b),(b,a)] := rfl
example : observationClass m1716 "v" = [] := rfl
example : observationClass m1716 "w" = [a] := rfl
def m1720 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m1720 = false := rfl
example : bindingCollisions m1720 = [(a,b),(b,a)] := rfl
example : observationClass m1720 "v" = [c] := rfl
example : observationClass m1720 "w" = [a] := rfl
def m1724 : Model := ⟨["m0","m1"],["o0","o1"],[a,c],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m1724 = false := rfl
example : bindingCollisions m1724 = [(a,b),(b,a)] := rfl
example : observationClass m1724 "v" = [] := rfl
example : observationClass m1724 "w" = [a,c] := rfl
def m1728 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[]⟩
example : binding m1728 = true := rfl
example : bindingCollisions m1728 = [] := rfl
example : observationClass m1728 "v" = [] := rfl
example : observationClass m1728 "w" = [] := rfl
def m1732 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c1","v")]⟩
example : binding m1732 = true := rfl
example : bindingCollisions m1732 = [] := rfl
example : observationClass m1732 "v" = [c] := rfl
example : observationClass m1732 "w" = [] := rfl
def m1736 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c1","w")]⟩
example : binding m1736 = true := rfl
example : bindingCollisions m1736 = [] := rfl
example : observationClass m1736 "v" = [] := rfl
example : observationClass m1736 "w" = [c] := rfl
def m1740 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","v")]⟩
example : binding m1740 = true := rfl
example : bindingCollisions m1740 = [] := rfl
example : observationClass m1740 "v" = [b] := rfl
example : observationClass m1740 "w" = [] := rfl
def m1744 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","v"),("c1","v")]⟩
example : binding m1744 = true := rfl
example : bindingCollisions m1744 = [] := rfl
example : observationClass m1744 "v" = [b,c] := rfl
example : observationClass m1744 "w" = [] := rfl
def m1748 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","v"),("c1","w")]⟩
example : binding m1748 = true := rfl
example : bindingCollisions m1748 = [] := rfl
example : observationClass m1748 "v" = [b] := rfl
example : observationClass m1748 "w" = [c] := rfl
def m1752 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","w")]⟩
example : binding m1752 = true := rfl
example : bindingCollisions m1752 = [] := rfl
example : observationClass m1752 "v" = [] := rfl
example : observationClass m1752 "w" = [b] := rfl
def m1756 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","w"),("c1","v")]⟩
example : binding m1756 = true := rfl
example : bindingCollisions m1756 = [] := rfl
example : observationClass m1756 "v" = [c] := rfl
example : observationClass m1756 "w" = [b] := rfl
def m1760 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[],[("c0","w"),("c1","w")]⟩
example : binding m1760 = true := rfl
example : bindingCollisions m1760 = [] := rfl
example : observationClass m1760 "v" = [] := rfl
example : observationClass m1760 "w" = [b,c] := rfl
def m1764 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[]⟩
example : binding m1764 = true := rfl
example : bindingCollisions m1764 = [] := rfl
example : observationClass m1764 "v" = [] := rfl
example : observationClass m1764 "w" = [] := rfl
def m1768 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c1","v")]⟩
example : binding m1768 = true := rfl
example : bindingCollisions m1768 = [] := rfl
example : observationClass m1768 "v" = [c] := rfl
example : observationClass m1768 "w" = [] := rfl
def m1772 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c1","w")]⟩
example : binding m1772 = true := rfl
example : bindingCollisions m1772 = [] := rfl
example : observationClass m1772 "v" = [] := rfl
example : observationClass m1772 "w" = [c] := rfl
def m1776 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","v")]⟩
example : binding m1776 = true := rfl
example : bindingCollisions m1776 = [] := rfl
example : observationClass m1776 "v" = [b] := rfl
example : observationClass m1776 "w" = [] := rfl
def m1780 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","v"),("c1","v")]⟩
example : binding m1780 = true := rfl
example : bindingCollisions m1780 = [] := rfl
example : observationClass m1780 "v" = [b,c] := rfl
example : observationClass m1780 "w" = [] := rfl
def m1784 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","v"),("c1","w")]⟩
example : binding m1784 = true := rfl
example : bindingCollisions m1784 = [] := rfl
example : observationClass m1784 "v" = [b] := rfl
example : observationClass m1784 "w" = [c] := rfl
def m1788 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","w")]⟩
example : binding m1788 = true := rfl
example : bindingCollisions m1788 = [] := rfl
example : observationClass m1788 "v" = [] := rfl
example : observationClass m1788 "w" = [b] := rfl
def m1792 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","w"),("c1","v")]⟩
example : binding m1792 = true := rfl
example : bindingCollisions m1792 = [] := rfl
example : observationClass m1792 "v" = [c] := rfl
example : observationClass m1792 "w" = [b] := rfl
def m1796 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a],[("c0","w"),("c1","w")]⟩
example : binding m1796 = true := rfl
example : bindingCollisions m1796 = [] := rfl
example : observationClass m1796 "v" = [] := rfl
example : observationClass m1796 "w" = [b,c] := rfl
def m1800 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[]⟩
example : binding m1800 = true := rfl
example : bindingCollisions m1800 = [] := rfl
example : observationClass m1800 "v" = [] := rfl
example : observationClass m1800 "w" = [] := rfl
def m1804 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c1","v")]⟩
example : binding m1804 = true := rfl
example : bindingCollisions m1804 = [] := rfl
example : observationClass m1804 "v" = [c] := rfl
example : observationClass m1804 "w" = [] := rfl
def m1808 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c1","w")]⟩
example : binding m1808 = true := rfl
example : bindingCollisions m1808 = [] := rfl
example : observationClass m1808 "v" = [] := rfl
example : observationClass m1808 "w" = [c] := rfl
def m1812 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","v")]⟩
example : binding m1812 = true := rfl
example : bindingCollisions m1812 = [] := rfl
example : observationClass m1812 "v" = [b] := rfl
example : observationClass m1812 "w" = [] := rfl
def m1816 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","v"),("c1","v")]⟩
example : binding m1816 = true := rfl
example : bindingCollisions m1816 = [] := rfl
example : observationClass m1816 "v" = [b,c] := rfl
example : observationClass m1816 "w" = [] := rfl
def m1820 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","v"),("c1","w")]⟩
example : binding m1820 = true := rfl
example : bindingCollisions m1820 = [] := rfl
example : observationClass m1820 "v" = [b] := rfl
example : observationClass m1820 "w" = [c] := rfl
def m1824 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","w")]⟩
example : binding m1824 = true := rfl
example : bindingCollisions m1824 = [] := rfl
example : observationClass m1824 "v" = [] := rfl
example : observationClass m1824 "w" = [b] := rfl
def m1828 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","w"),("c1","v")]⟩
example : binding m1828 = true := rfl
example : bindingCollisions m1828 = [] := rfl
example : observationClass m1828 "v" = [c] := rfl
example : observationClass m1828 "w" = [b] := rfl
def m1832 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b],[("c0","w"),("c1","w")]⟩
example : binding m1832 = true := rfl
example : bindingCollisions m1832 = [] := rfl
example : observationClass m1832 "v" = [] := rfl
example : observationClass m1832 "w" = [b,c] := rfl
def m1836 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[]⟩
example : binding m1836 = false := rfl
example : bindingCollisions m1836 = [(a,b),(b,a)] := rfl
example : observationClass m1836 "v" = [] := rfl
example : observationClass m1836 "w" = [] := rfl
def m1840 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c1","v")]⟩
example : binding m1840 = false := rfl
example : bindingCollisions m1840 = [(a,b),(b,a)] := rfl
example : observationClass m1840 "v" = [c] := rfl
example : observationClass m1840 "w" = [] := rfl
def m1844 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c1","w")]⟩
example : binding m1844 = false := rfl
example : bindingCollisions m1844 = [(a,b),(b,a)] := rfl
example : observationClass m1844 "v" = [] := rfl
example : observationClass m1844 "w" = [c] := rfl
def m1848 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","v")]⟩
example : binding m1848 = false := rfl
example : bindingCollisions m1848 = [(a,b),(b,a)] := rfl
example : observationClass m1848 "v" = [b] := rfl
example : observationClass m1848 "w" = [] := rfl
def m1852 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m1852 = false := rfl
example : bindingCollisions m1852 = [(a,b),(b,a)] := rfl
example : observationClass m1852 "v" = [b,c] := rfl
example : observationClass m1852 "w" = [] := rfl
def m1856 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m1856 = false := rfl
example : bindingCollisions m1856 = [(a,b),(b,a)] := rfl
example : observationClass m1856 "v" = [b] := rfl
example : observationClass m1856 "w" = [c] := rfl
def m1860 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","w")]⟩
example : binding m1860 = false := rfl
example : bindingCollisions m1860 = [(a,b),(b,a)] := rfl
example : observationClass m1860 "v" = [] := rfl
example : observationClass m1860 "w" = [b] := rfl
def m1864 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m1864 = false := rfl
example : bindingCollisions m1864 = [(a,b),(b,a)] := rfl
example : observationClass m1864 "v" = [c] := rfl
example : observationClass m1864 "w" = [b] := rfl
def m1868 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m1868 = false := rfl
example : bindingCollisions m1868 = [(a,b),(b,a)] := rfl
example : observationClass m1868 "v" = [] := rfl
example : observationClass m1868 "w" = [b,c] := rfl
def m1872 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[]⟩
example : binding m1872 = true := rfl
example : bindingCollisions m1872 = [] := rfl
example : observationClass m1872 "v" = [] := rfl
example : observationClass m1872 "w" = [] := rfl
def m1876 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c1","v")]⟩
example : binding m1876 = true := rfl
example : bindingCollisions m1876 = [] := rfl
example : observationClass m1876 "v" = [c] := rfl
example : observationClass m1876 "w" = [] := rfl
def m1880 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c1","w")]⟩
example : binding m1880 = true := rfl
example : bindingCollisions m1880 = [] := rfl
example : observationClass m1880 "v" = [] := rfl
example : observationClass m1880 "w" = [c] := rfl
def m1884 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","v")]⟩
example : binding m1884 = true := rfl
example : bindingCollisions m1884 = [] := rfl
example : observationClass m1884 "v" = [b] := rfl
example : observationClass m1884 "w" = [] := rfl
def m1888 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","v"),("c1","v")]⟩
example : binding m1888 = true := rfl
example : bindingCollisions m1888 = [] := rfl
example : observationClass m1888 "v" = [b,c] := rfl
example : observationClass m1888 "w" = [] := rfl
def m1892 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","v"),("c1","w")]⟩
example : binding m1892 = true := rfl
example : bindingCollisions m1892 = [] := rfl
example : observationClass m1892 "v" = [b] := rfl
example : observationClass m1892 "w" = [c] := rfl
def m1896 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","w")]⟩
example : binding m1896 = true := rfl
example : bindingCollisions m1896 = [] := rfl
example : observationClass m1896 "v" = [] := rfl
example : observationClass m1896 "w" = [b] := rfl
def m1900 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","w"),("c1","v")]⟩
example : binding m1900 = true := rfl
example : bindingCollisions m1900 = [] := rfl
example : observationClass m1900 "v" = [c] := rfl
example : observationClass m1900 "w" = [b] := rfl
def m1904 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[c],[("c0","w"),("c1","w")]⟩
example : binding m1904 = true := rfl
example : bindingCollisions m1904 = [] := rfl
example : observationClass m1904 "v" = [] := rfl
example : observationClass m1904 "w" = [b,c] := rfl
def m1908 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[]⟩
example : binding m1908 = true := rfl
example : bindingCollisions m1908 = [] := rfl
example : observationClass m1908 "v" = [] := rfl
example : observationClass m1908 "w" = [] := rfl
def m1912 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c1","v")]⟩
example : binding m1912 = true := rfl
example : bindingCollisions m1912 = [] := rfl
example : observationClass m1912 "v" = [c] := rfl
example : observationClass m1912 "w" = [] := rfl
def m1916 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c1","w")]⟩
example : binding m1916 = true := rfl
example : bindingCollisions m1916 = [] := rfl
example : observationClass m1916 "v" = [] := rfl
example : observationClass m1916 "w" = [c] := rfl
def m1920 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","v")]⟩
example : binding m1920 = true := rfl
example : bindingCollisions m1920 = [] := rfl
example : observationClass m1920 "v" = [b] := rfl
example : observationClass m1920 "w" = [] := rfl
def m1924 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m1924 = true := rfl
example : bindingCollisions m1924 = [] := rfl
example : observationClass m1924 "v" = [b,c] := rfl
example : observationClass m1924 "w" = [] := rfl
def m1928 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m1928 = true := rfl
example : bindingCollisions m1928 = [] := rfl
example : observationClass m1928 "v" = [b] := rfl
example : observationClass m1928 "w" = [c] := rfl
def m1932 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","w")]⟩
example : binding m1932 = true := rfl
example : bindingCollisions m1932 = [] := rfl
example : observationClass m1932 "v" = [] := rfl
example : observationClass m1932 "w" = [b] := rfl
def m1936 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m1936 = true := rfl
example : bindingCollisions m1936 = [] := rfl
example : observationClass m1936 "v" = [c] := rfl
example : observationClass m1936 "w" = [b] := rfl
def m1940 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m1940 = true := rfl
example : bindingCollisions m1940 = [] := rfl
example : observationClass m1940 "v" = [] := rfl
example : observationClass m1940 "w" = [b,c] := rfl
def m1944 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[]⟩
example : binding m1944 = true := rfl
example : bindingCollisions m1944 = [] := rfl
example : observationClass m1944 "v" = [] := rfl
example : observationClass m1944 "w" = [] := rfl
def m1948 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c1","v")]⟩
example : binding m1948 = true := rfl
example : bindingCollisions m1948 = [] := rfl
example : observationClass m1948 "v" = [c] := rfl
example : observationClass m1948 "w" = [] := rfl
def m1952 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c1","w")]⟩
example : binding m1952 = true := rfl
example : bindingCollisions m1952 = [] := rfl
example : observationClass m1952 "v" = [] := rfl
example : observationClass m1952 "w" = [c] := rfl
def m1956 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","v")]⟩
example : binding m1956 = true := rfl
example : bindingCollisions m1956 = [] := rfl
example : observationClass m1956 "v" = [b] := rfl
example : observationClass m1956 "w" = [] := rfl
def m1960 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m1960 = true := rfl
example : bindingCollisions m1960 = [] := rfl
example : observationClass m1960 "v" = [b,c] := rfl
example : observationClass m1960 "w" = [] := rfl
def m1964 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m1964 = true := rfl
example : bindingCollisions m1964 = [] := rfl
example : observationClass m1964 "v" = [b] := rfl
example : observationClass m1964 "w" = [c] := rfl
def m1968 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","w")]⟩
example : binding m1968 = true := rfl
example : bindingCollisions m1968 = [] := rfl
example : observationClass m1968 "v" = [] := rfl
example : observationClass m1968 "w" = [b] := rfl
def m1972 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m1972 = true := rfl
example : bindingCollisions m1972 = [] := rfl
example : observationClass m1972 "v" = [c] := rfl
example : observationClass m1972 "w" = [b] := rfl
def m1976 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m1976 = true := rfl
example : bindingCollisions m1976 = [] := rfl
example : observationClass m1976 "v" = [] := rfl
example : observationClass m1976 "w" = [b,c] := rfl
def m1980 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[]⟩
example : binding m1980 = false := rfl
example : bindingCollisions m1980 = [(a,b),(b,a)] := rfl
example : observationClass m1980 "v" = [] := rfl
example : observationClass m1980 "w" = [] := rfl
def m1984 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c1","v")]⟩
example : binding m1984 = false := rfl
example : bindingCollisions m1984 = [(a,b),(b,a)] := rfl
example : observationClass m1984 "v" = [c] := rfl
example : observationClass m1984 "w" = [] := rfl
def m1988 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c1","w")]⟩
example : binding m1988 = false := rfl
example : bindingCollisions m1988 = [(a,b),(b,a)] := rfl
example : observationClass m1988 "v" = [] := rfl
example : observationClass m1988 "w" = [c] := rfl
def m1992 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","v")]⟩
example : binding m1992 = false := rfl
example : bindingCollisions m1992 = [(a,b),(b,a)] := rfl
example : observationClass m1992 "v" = [b] := rfl
example : observationClass m1992 "w" = [] := rfl
def m1996 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m1996 = false := rfl
example : bindingCollisions m1996 = [(a,b),(b,a)] := rfl
example : observationClass m1996 "v" = [b,c] := rfl
example : observationClass m1996 "w" = [] := rfl
def m2000 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m2000 = false := rfl
example : bindingCollisions m2000 = [(a,b),(b,a)] := rfl
example : observationClass m2000 "v" = [b] := rfl
example : observationClass m2000 "w" = [c] := rfl
def m2004 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","w")]⟩
example : binding m2004 = false := rfl
example : bindingCollisions m2004 = [(a,b),(b,a)] := rfl
example : observationClass m2004 "v" = [] := rfl
example : observationClass m2004 "w" = [b] := rfl
def m2008 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m2008 = false := rfl
example : bindingCollisions m2008 = [(a,b),(b,a)] := rfl
example : observationClass m2008 "v" = [c] := rfl
example : observationClass m2008 "w" = [b] := rfl
def m2012 : Model := ⟨["m0","m1"],["o0","o1"],[b,c],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m2012 = false := rfl
example : bindingCollisions m2012 = [(a,b),(b,a)] := rfl
example : observationClass m2012 "v" = [] := rfl
example : observationClass m2012 "w" = [b,c] := rfl
def m2016 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[]⟩
example : binding m2016 = true := rfl
example : bindingCollisions m2016 = [] := rfl
example : observationClass m2016 "v" = [] := rfl
example : observationClass m2016 "w" = [] := rfl
def m2020 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c1","v")]⟩
example : binding m2020 = true := rfl
example : bindingCollisions m2020 = [] := rfl
example : observationClass m2020 "v" = [c] := rfl
example : observationClass m2020 "w" = [] := rfl
def m2024 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c1","w")]⟩
example : binding m2024 = true := rfl
example : bindingCollisions m2024 = [] := rfl
example : observationClass m2024 "v" = [] := rfl
example : observationClass m2024 "w" = [c] := rfl
def m2028 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","v")]⟩
example : binding m2028 = true := rfl
example : bindingCollisions m2028 = [] := rfl
example : observationClass m2028 "v" = [a,b] := rfl
example : observationClass m2028 "w" = [] := rfl
def m2032 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","v"),("c1","v")]⟩
example : binding m2032 = true := rfl
example : bindingCollisions m2032 = [] := rfl
example : observationClass m2032 "v" = [a,b,c] := rfl
example : observationClass m2032 "w" = [] := rfl
def m2036 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","v"),("c1","w")]⟩
example : binding m2036 = true := rfl
example : bindingCollisions m2036 = [] := rfl
example : observationClass m2036 "v" = [a,b] := rfl
example : observationClass m2036 "w" = [c] := rfl
def m2040 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","w")]⟩
example : binding m2040 = true := rfl
example : bindingCollisions m2040 = [] := rfl
example : observationClass m2040 "v" = [] := rfl
example : observationClass m2040 "w" = [a,b] := rfl
def m2044 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","w"),("c1","v")]⟩
example : binding m2044 = true := rfl
example : bindingCollisions m2044 = [] := rfl
example : observationClass m2044 "v" = [c] := rfl
example : observationClass m2044 "w" = [a,b] := rfl
def m2048 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[],[("c0","w"),("c1","w")]⟩
example : binding m2048 = true := rfl
example : bindingCollisions m2048 = [] := rfl
example : observationClass m2048 "v" = [] := rfl
example : observationClass m2048 "w" = [a,b,c] := rfl
def m2052 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[]⟩
example : binding m2052 = true := rfl
example : bindingCollisions m2052 = [] := rfl
example : observationClass m2052 "v" = [] := rfl
example : observationClass m2052 "w" = [] := rfl
def m2056 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c1","v")]⟩
example : binding m2056 = true := rfl
example : bindingCollisions m2056 = [] := rfl
example : observationClass m2056 "v" = [c] := rfl
example : observationClass m2056 "w" = [] := rfl
def m2060 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c1","w")]⟩
example : binding m2060 = true := rfl
example : bindingCollisions m2060 = [] := rfl
example : observationClass m2060 "v" = [] := rfl
example : observationClass m2060 "w" = [c] := rfl
def m2064 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","v")]⟩
example : binding m2064 = true := rfl
example : bindingCollisions m2064 = [] := rfl
example : observationClass m2064 "v" = [a,b] := rfl
example : observationClass m2064 "w" = [] := rfl
def m2068 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","v"),("c1","v")]⟩
example : binding m2068 = true := rfl
example : bindingCollisions m2068 = [] := rfl
example : observationClass m2068 "v" = [a,b,c] := rfl
example : observationClass m2068 "w" = [] := rfl
def m2072 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","v"),("c1","w")]⟩
example : binding m2072 = true := rfl
example : bindingCollisions m2072 = [] := rfl
example : observationClass m2072 "v" = [a,b] := rfl
example : observationClass m2072 "w" = [c] := rfl
def m2076 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","w")]⟩
example : binding m2076 = true := rfl
example : bindingCollisions m2076 = [] := rfl
example : observationClass m2076 "v" = [] := rfl
example : observationClass m2076 "w" = [a,b] := rfl
def m2080 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","w"),("c1","v")]⟩
example : binding m2080 = true := rfl
example : bindingCollisions m2080 = [] := rfl
example : observationClass m2080 "v" = [c] := rfl
example : observationClass m2080 "w" = [a,b] := rfl
def m2084 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a],[("c0","w"),("c1","w")]⟩
example : binding m2084 = true := rfl
example : bindingCollisions m2084 = [] := rfl
example : observationClass m2084 "v" = [] := rfl
example : observationClass m2084 "w" = [a,b,c] := rfl
def m2088 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[]⟩
example : binding m2088 = true := rfl
example : bindingCollisions m2088 = [] := rfl
example : observationClass m2088 "v" = [] := rfl
example : observationClass m2088 "w" = [] := rfl
def m2092 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c1","v")]⟩
example : binding m2092 = true := rfl
example : bindingCollisions m2092 = [] := rfl
example : observationClass m2092 "v" = [c] := rfl
example : observationClass m2092 "w" = [] := rfl
def m2096 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c1","w")]⟩
example : binding m2096 = true := rfl
example : bindingCollisions m2096 = [] := rfl
example : observationClass m2096 "v" = [] := rfl
example : observationClass m2096 "w" = [c] := rfl
def m2100 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","v")]⟩
example : binding m2100 = true := rfl
example : bindingCollisions m2100 = [] := rfl
example : observationClass m2100 "v" = [a,b] := rfl
example : observationClass m2100 "w" = [] := rfl
def m2104 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","v"),("c1","v")]⟩
example : binding m2104 = true := rfl
example : bindingCollisions m2104 = [] := rfl
example : observationClass m2104 "v" = [a,b,c] := rfl
example : observationClass m2104 "w" = [] := rfl
def m2108 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","v"),("c1","w")]⟩
example : binding m2108 = true := rfl
example : bindingCollisions m2108 = [] := rfl
example : observationClass m2108 "v" = [a,b] := rfl
example : observationClass m2108 "w" = [c] := rfl
def m2112 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","w")]⟩
example : binding m2112 = true := rfl
example : bindingCollisions m2112 = [] := rfl
example : observationClass m2112 "v" = [] := rfl
example : observationClass m2112 "w" = [a,b] := rfl
def m2116 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","w"),("c1","v")]⟩
example : binding m2116 = true := rfl
example : bindingCollisions m2116 = [] := rfl
example : observationClass m2116 "v" = [c] := rfl
example : observationClass m2116 "w" = [a,b] := rfl
def m2120 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b],[("c0","w"),("c1","w")]⟩
example : binding m2120 = true := rfl
example : bindingCollisions m2120 = [] := rfl
example : observationClass m2120 "v" = [] := rfl
example : observationClass m2120 "w" = [a,b,c] := rfl
def m2124 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[]⟩
example : binding m2124 = false := rfl
example : bindingCollisions m2124 = [(a,b),(b,a)] := rfl
example : observationClass m2124 "v" = [] := rfl
example : observationClass m2124 "w" = [] := rfl
def m2128 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c1","v")]⟩
example : binding m2128 = false := rfl
example : bindingCollisions m2128 = [(a,b),(b,a)] := rfl
example : observationClass m2128 "v" = [c] := rfl
example : observationClass m2128 "w" = [] := rfl
def m2132 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c1","w")]⟩
example : binding m2132 = false := rfl
example : bindingCollisions m2132 = [(a,b),(b,a)] := rfl
example : observationClass m2132 "v" = [] := rfl
example : observationClass m2132 "w" = [c] := rfl
def m2136 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","v")]⟩
example : binding m2136 = false := rfl
example : bindingCollisions m2136 = [(a,b),(b,a)] := rfl
example : observationClass m2136 "v" = [a,b] := rfl
example : observationClass m2136 "w" = [] := rfl
def m2140 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","v"),("c1","v")]⟩
example : binding m2140 = false := rfl
example : bindingCollisions m2140 = [(a,b),(b,a)] := rfl
example : observationClass m2140 "v" = [a,b,c] := rfl
example : observationClass m2140 "w" = [] := rfl
def m2144 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","v"),("c1","w")]⟩
example : binding m2144 = false := rfl
example : bindingCollisions m2144 = [(a,b),(b,a)] := rfl
example : observationClass m2144 "v" = [a,b] := rfl
example : observationClass m2144 "w" = [c] := rfl
def m2148 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","w")]⟩
example : binding m2148 = false := rfl
example : bindingCollisions m2148 = [(a,b),(b,a)] := rfl
example : observationClass m2148 "v" = [] := rfl
example : observationClass m2148 "w" = [a,b] := rfl
def m2152 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","w"),("c1","v")]⟩
example : binding m2152 = false := rfl
example : bindingCollisions m2152 = [(a,b),(b,a)] := rfl
example : observationClass m2152 "v" = [c] := rfl
example : observationClass m2152 "w" = [a,b] := rfl
def m2156 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b],[("c0","w"),("c1","w")]⟩
example : binding m2156 = false := rfl
example : bindingCollisions m2156 = [(a,b),(b,a)] := rfl
example : observationClass m2156 "v" = [] := rfl
example : observationClass m2156 "w" = [a,b,c] := rfl
def m2160 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[]⟩
example : binding m2160 = true := rfl
example : bindingCollisions m2160 = [] := rfl
example : observationClass m2160 "v" = [] := rfl
example : observationClass m2160 "w" = [] := rfl
def m2164 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c1","v")]⟩
example : binding m2164 = true := rfl
example : bindingCollisions m2164 = [] := rfl
example : observationClass m2164 "v" = [c] := rfl
example : observationClass m2164 "w" = [] := rfl
def m2168 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c1","w")]⟩
example : binding m2168 = true := rfl
example : bindingCollisions m2168 = [] := rfl
example : observationClass m2168 "v" = [] := rfl
example : observationClass m2168 "w" = [c] := rfl
def m2172 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","v")]⟩
example : binding m2172 = true := rfl
example : bindingCollisions m2172 = [] := rfl
example : observationClass m2172 "v" = [a,b] := rfl
example : observationClass m2172 "w" = [] := rfl
def m2176 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","v"),("c1","v")]⟩
example : binding m2176 = true := rfl
example : bindingCollisions m2176 = [] := rfl
example : observationClass m2176 "v" = [a,b,c] := rfl
example : observationClass m2176 "w" = [] := rfl
def m2180 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","v"),("c1","w")]⟩
example : binding m2180 = true := rfl
example : bindingCollisions m2180 = [] := rfl
example : observationClass m2180 "v" = [a,b] := rfl
example : observationClass m2180 "w" = [c] := rfl
def m2184 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","w")]⟩
example : binding m2184 = true := rfl
example : bindingCollisions m2184 = [] := rfl
example : observationClass m2184 "v" = [] := rfl
example : observationClass m2184 "w" = [a,b] := rfl
def m2188 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","w"),("c1","v")]⟩
example : binding m2188 = true := rfl
example : bindingCollisions m2188 = [] := rfl
example : observationClass m2188 "v" = [c] := rfl
example : observationClass m2188 "w" = [a,b] := rfl
def m2192 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[c],[("c0","w"),("c1","w")]⟩
example : binding m2192 = true := rfl
example : bindingCollisions m2192 = [] := rfl
example : observationClass m2192 "v" = [] := rfl
example : observationClass m2192 "w" = [a,b,c] := rfl
def m2196 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[]⟩
example : binding m2196 = true := rfl
example : bindingCollisions m2196 = [] := rfl
example : observationClass m2196 "v" = [] := rfl
example : observationClass m2196 "w" = [] := rfl
def m2200 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c1","v")]⟩
example : binding m2200 = true := rfl
example : bindingCollisions m2200 = [] := rfl
example : observationClass m2200 "v" = [c] := rfl
example : observationClass m2200 "w" = [] := rfl
def m2204 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c1","w")]⟩
example : binding m2204 = true := rfl
example : bindingCollisions m2204 = [] := rfl
example : observationClass m2204 "v" = [] := rfl
example : observationClass m2204 "w" = [c] := rfl
def m2208 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","v")]⟩
example : binding m2208 = true := rfl
example : bindingCollisions m2208 = [] := rfl
example : observationClass m2208 "v" = [a,b] := rfl
example : observationClass m2208 "w" = [] := rfl
def m2212 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","v"),("c1","v")]⟩
example : binding m2212 = true := rfl
example : bindingCollisions m2212 = [] := rfl
example : observationClass m2212 "v" = [a,b,c] := rfl
example : observationClass m2212 "w" = [] := rfl
def m2216 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","v"),("c1","w")]⟩
example : binding m2216 = true := rfl
example : bindingCollisions m2216 = [] := rfl
example : observationClass m2216 "v" = [a,b] := rfl
example : observationClass m2216 "w" = [c] := rfl
def m2220 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","w")]⟩
example : binding m2220 = true := rfl
example : bindingCollisions m2220 = [] := rfl
example : observationClass m2220 "v" = [] := rfl
example : observationClass m2220 "w" = [a,b] := rfl
def m2224 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","w"),("c1","v")]⟩
example : binding m2224 = true := rfl
example : bindingCollisions m2224 = [] := rfl
example : observationClass m2224 "v" = [c] := rfl
example : observationClass m2224 "w" = [a,b] := rfl
def m2228 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,c],[("c0","w"),("c1","w")]⟩
example : binding m2228 = true := rfl
example : bindingCollisions m2228 = [] := rfl
example : observationClass m2228 "v" = [] := rfl
example : observationClass m2228 "w" = [a,b,c] := rfl
def m2232 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[]⟩
example : binding m2232 = true := rfl
example : bindingCollisions m2232 = [] := rfl
example : observationClass m2232 "v" = [] := rfl
example : observationClass m2232 "w" = [] := rfl
def m2236 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c1","v")]⟩
example : binding m2236 = true := rfl
example : bindingCollisions m2236 = [] := rfl
example : observationClass m2236 "v" = [c] := rfl
example : observationClass m2236 "w" = [] := rfl
def m2240 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c1","w")]⟩
example : binding m2240 = true := rfl
example : bindingCollisions m2240 = [] := rfl
example : observationClass m2240 "v" = [] := rfl
example : observationClass m2240 "w" = [c] := rfl
def m2244 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","v")]⟩
example : binding m2244 = true := rfl
example : bindingCollisions m2244 = [] := rfl
example : observationClass m2244 "v" = [a,b] := rfl
example : observationClass m2244 "w" = [] := rfl
def m2248 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","v"),("c1","v")]⟩
example : binding m2248 = true := rfl
example : bindingCollisions m2248 = [] := rfl
example : observationClass m2248 "v" = [a,b,c] := rfl
example : observationClass m2248 "w" = [] := rfl
def m2252 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","v"),("c1","w")]⟩
example : binding m2252 = true := rfl
example : bindingCollisions m2252 = [] := rfl
example : observationClass m2252 "v" = [a,b] := rfl
example : observationClass m2252 "w" = [c] := rfl
def m2256 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","w")]⟩
example : binding m2256 = true := rfl
example : bindingCollisions m2256 = [] := rfl
example : observationClass m2256 "v" = [] := rfl
example : observationClass m2256 "w" = [a,b] := rfl
def m2260 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","w"),("c1","v")]⟩
example : binding m2260 = true := rfl
example : bindingCollisions m2260 = [] := rfl
example : observationClass m2260 "v" = [c] := rfl
example : observationClass m2260 "w" = [a,b] := rfl
def m2264 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[b,c],[("c0","w"),("c1","w")]⟩
example : binding m2264 = true := rfl
example : bindingCollisions m2264 = [] := rfl
example : observationClass m2264 "v" = [] := rfl
example : observationClass m2264 "w" = [a,b,c] := rfl
def m2268 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[]⟩
example : binding m2268 = false := rfl
example : bindingCollisions m2268 = [(a,b),(b,a)] := rfl
example : observationClass m2268 "v" = [] := rfl
example : observationClass m2268 "w" = [] := rfl
def m2272 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c1","v")]⟩
example : binding m2272 = false := rfl
example : bindingCollisions m2272 = [(a,b),(b,a)] := rfl
example : observationClass m2272 "v" = [c] := rfl
example : observationClass m2272 "w" = [] := rfl
def m2276 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c1","w")]⟩
example : binding m2276 = false := rfl
example : bindingCollisions m2276 = [(a,b),(b,a)] := rfl
example : observationClass m2276 "v" = [] := rfl
example : observationClass m2276 "w" = [c] := rfl
def m2280 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","v")]⟩
example : binding m2280 = false := rfl
example : bindingCollisions m2280 = [(a,b),(b,a)] := rfl
example : observationClass m2280 "v" = [a,b] := rfl
example : observationClass m2280 "w" = [] := rfl
def m2284 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","v"),("c1","v")]⟩
example : binding m2284 = false := rfl
example : bindingCollisions m2284 = [(a,b),(b,a)] := rfl
example : observationClass m2284 "v" = [a,b,c] := rfl
example : observationClass m2284 "w" = [] := rfl
def m2288 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","v"),("c1","w")]⟩
example : binding m2288 = false := rfl
example : bindingCollisions m2288 = [(a,b),(b,a)] := rfl
example : observationClass m2288 "v" = [a,b] := rfl
example : observationClass m2288 "w" = [c] := rfl
def m2292 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","w")]⟩
example : binding m2292 = false := rfl
example : bindingCollisions m2292 = [(a,b),(b,a)] := rfl
example : observationClass m2292 "v" = [] := rfl
example : observationClass m2292 "w" = [a,b] := rfl
def m2296 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","w"),("c1","v")]⟩
example : binding m2296 = false := rfl
example : bindingCollisions m2296 = [(a,b),(b,a)] := rfl
example : observationClass m2296 "v" = [c] := rfl
example : observationClass m2296 "w" = [a,b] := rfl
def m2300 : Model := ⟨["m0","m1"],["o0","o1"],[a,b,c],[a,b,c],[("c0","w"),("c1","w")]⟩
example : binding m2300 = false := rfl
example : bindingCollisions m2300 = [(a,b),(b,a)] := rfl
example : observationClass m2300 "v" = [] := rfl
example : observationClass m2300 "w" = [a,b,c] := rfl

def bSeparated : Row := ⟨"m1","o1","c1"⟩
def collisionModel : Model := ⟨["m0","m1"],["o0","o1"],[a,b],[a,b],[("c0","v")]⟩
def separatedModel : Model := ⟨["m0","m1"],["o0","o1"],[a,bSeparated],[a,bSeparated],[("c0","v"),("c1","v")]⟩
example : binding collisionModel = false := rfl
example : bindingCollisions collisionModel = [(a,b),(b,a)] := rfl
example : binding separatedModel = true := rfl
example : observationClass separatedModel "v" = [a,bSeparated] := rfl
example : bindingCollisions separatedModel = [] := rfl
def commit : CommitTrace collisionModel := ⟨a,rfl⟩
def firstOpening : OpeningTrace collisionModel commit := ⟨a,rfl,rfl⟩
def secondOpening : OpeningTrace collisionModel commit := ⟨b,rfl,rfl⟩
theorem nativeCompatibleHiding : ¬ ∃ decode : Option String → String,
    decode (SFT.Mathematics.GeometryTopology.image separatedModel.observation a.commitment) = a.message ∧
    decode (SFT.Mathematics.GeometryTopology.image separatedModel.observation bSeparated.commitment) = bSeparated.message :=
  hiddenMessagesCannotRecover separatedModel "v" a bSeparated (.head _) (.tail _ (.head _)) (by decide)
#print axioms nativeCompatibleHiding

example : generated {collisionModel with messages := []} a = false := rfl
example : generated {collisionModel with openings := []} a = false := rfl
example : generated {collisionModel with commits := []} a = false := rfl
example : verifies {collisionModel with verification := []} a = false := rfl
