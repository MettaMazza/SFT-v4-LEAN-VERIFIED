import SFT.Computation.Integrity
open SFT.Computation.Integrity
def r0 : Record := ⟨"message","original"⟩
def r1 : Record := ⟨"message","changed"⟩
def c0 : Change := ⟨"forward",r0,r1⟩
def c1 : Change := ⟨"return",r1,r0⟩
def m0 : Model := ⟨[],[],[],[]⟩
example : accepted m0 = [] := rfl
example : rejected m0 = [] := rfl
example : falseAccepts m0 = [] := rfl
example : integrity m0 = true := rfl
def m4 : Model := ⟨[],[],[],[(c0.before,c0.after)]⟩
example : accepted m4 = [] := rfl
example : rejected m4 = [] := rfl
example : falseAccepts m4 = [] := rfl
example : integrity m4 = true := rfl
def m8 : Model := ⟨[],[],[],[(c1.before,c1.after)]⟩
example : accepted m8 = [] := rfl
example : rejected m8 = [] := rfl
example : falseAccepts m8 = [] := rfl
example : integrity m8 = true := rfl
def m12 : Model := ⟨[],[],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m12 = [] := rfl
example : rejected m12 = [] := rfl
example : falseAccepts m12 = [] := rfl
example : integrity m12 = true := rfl
def m16 : Model := ⟨[],[],[c0],[]⟩
example : accepted m16 = [] := rfl
example : rejected m16 = [] := rfl
example : falseAccepts m16 = [] := rfl
example : integrity m16 = true := rfl
def m20 : Model := ⟨[],[],[c0],[(c0.before,c0.after)]⟩
example : accepted m20 = [] := rfl
example : rejected m20 = [] := rfl
example : falseAccepts m20 = [] := rfl
example : integrity m20 = true := rfl
def m24 : Model := ⟨[],[],[c0],[(c1.before,c1.after)]⟩
example : accepted m24 = [] := rfl
example : rejected m24 = [] := rfl
example : falseAccepts m24 = [] := rfl
example : integrity m24 = true := rfl
def m28 : Model := ⟨[],[],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m28 = [] := rfl
example : rejected m28 = [] := rfl
example : falseAccepts m28 = [] := rfl
example : integrity m28 = true := rfl
def m32 : Model := ⟨[],[],[c1],[]⟩
example : accepted m32 = [] := rfl
example : rejected m32 = [] := rfl
example : falseAccepts m32 = [] := rfl
example : integrity m32 = true := rfl
def m36 : Model := ⟨[],[],[c1],[(c0.before,c0.after)]⟩
example : accepted m36 = [] := rfl
example : rejected m36 = [] := rfl
example : falseAccepts m36 = [] := rfl
example : integrity m36 = true := rfl
def m40 : Model := ⟨[],[],[c1],[(c1.before,c1.after)]⟩
example : accepted m40 = [] := rfl
example : rejected m40 = [] := rfl
example : falseAccepts m40 = [] := rfl
example : integrity m40 = true := rfl
def m44 : Model := ⟨[],[],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m44 = [] := rfl
example : rejected m44 = [] := rfl
example : falseAccepts m44 = [] := rfl
example : integrity m44 = true := rfl
def m48 : Model := ⟨[],[],[c0,c1],[]⟩
example : accepted m48 = [] := rfl
example : rejected m48 = [] := rfl
example : falseAccepts m48 = [] := rfl
example : integrity m48 = true := rfl
def m52 : Model := ⟨[],[],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m52 = [] := rfl
example : rejected m52 = [] := rfl
example : falseAccepts m52 = [] := rfl
example : integrity m52 = true := rfl
def m56 : Model := ⟨[],[],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m56 = [] := rfl
example : rejected m56 = [] := rfl
example : falseAccepts m56 = [] := rfl
example : integrity m56 = true := rfl
def m60 : Model := ⟨[],[],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m60 = [] := rfl
example : rejected m60 = [] := rfl
example : falseAccepts m60 = [] := rfl
example : integrity m60 = true := rfl
def m64 : Model := ⟨[],[c0],[],[]⟩
example : accepted m64 = [] := rfl
example : rejected m64 = [] := rfl
example : falseAccepts m64 = [] := rfl
example : integrity m64 = true := rfl
def m68 : Model := ⟨[],[c0],[],[(c0.before,c0.after)]⟩
example : accepted m68 = [] := rfl
example : rejected m68 = [] := rfl
example : falseAccepts m68 = [] := rfl
example : integrity m68 = true := rfl
def m72 : Model := ⟨[],[c0],[],[(c1.before,c1.after)]⟩
example : accepted m72 = [] := rfl
example : rejected m72 = [] := rfl
example : falseAccepts m72 = [] := rfl
example : integrity m72 = true := rfl
def m76 : Model := ⟨[],[c0],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m76 = [] := rfl
example : rejected m76 = [] := rfl
example : falseAccepts m76 = [] := rfl
example : integrity m76 = true := rfl
def m80 : Model := ⟨[],[c0],[c0],[]⟩
example : accepted m80 = [] := rfl
example : rejected m80 = [] := rfl
example : falseAccepts m80 = [] := rfl
example : integrity m80 = true := rfl
def m84 : Model := ⟨[],[c0],[c0],[(c0.before,c0.after)]⟩
example : accepted m84 = [] := rfl
example : rejected m84 = [] := rfl
example : falseAccepts m84 = [] := rfl
example : integrity m84 = true := rfl
def m88 : Model := ⟨[],[c0],[c0],[(c1.before,c1.after)]⟩
example : accepted m88 = [] := rfl
example : rejected m88 = [] := rfl
example : falseAccepts m88 = [] := rfl
example : integrity m88 = true := rfl
def m92 : Model := ⟨[],[c0],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m92 = [] := rfl
example : rejected m92 = [] := rfl
example : falseAccepts m92 = [] := rfl
example : integrity m92 = true := rfl
def m96 : Model := ⟨[],[c0],[c1],[]⟩
example : accepted m96 = [] := rfl
example : rejected m96 = [] := rfl
example : falseAccepts m96 = [] := rfl
example : integrity m96 = true := rfl
def m100 : Model := ⟨[],[c0],[c1],[(c0.before,c0.after)]⟩
example : accepted m100 = [] := rfl
example : rejected m100 = [] := rfl
example : falseAccepts m100 = [] := rfl
example : integrity m100 = true := rfl
def m104 : Model := ⟨[],[c0],[c1],[(c1.before,c1.after)]⟩
example : accepted m104 = [] := rfl
example : rejected m104 = [] := rfl
example : falseAccepts m104 = [] := rfl
example : integrity m104 = true := rfl
def m108 : Model := ⟨[],[c0],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m108 = [] := rfl
example : rejected m108 = [] := rfl
example : falseAccepts m108 = [] := rfl
example : integrity m108 = true := rfl
def m112 : Model := ⟨[],[c0],[c0,c1],[]⟩
example : accepted m112 = [] := rfl
example : rejected m112 = [] := rfl
example : falseAccepts m112 = [] := rfl
example : integrity m112 = true := rfl
def m116 : Model := ⟨[],[c0],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m116 = [] := rfl
example : rejected m116 = [] := rfl
example : falseAccepts m116 = [] := rfl
example : integrity m116 = true := rfl
def m120 : Model := ⟨[],[c0],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m120 = [] := rfl
example : rejected m120 = [] := rfl
example : falseAccepts m120 = [] := rfl
example : integrity m120 = true := rfl
def m124 : Model := ⟨[],[c0],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m124 = [] := rfl
example : rejected m124 = [] := rfl
example : falseAccepts m124 = [] := rfl
example : integrity m124 = true := rfl
def m128 : Model := ⟨[],[c1],[],[]⟩
example : accepted m128 = [] := rfl
example : rejected m128 = [] := rfl
example : falseAccepts m128 = [] := rfl
example : integrity m128 = true := rfl
def m132 : Model := ⟨[],[c1],[],[(c0.before,c0.after)]⟩
example : accepted m132 = [] := rfl
example : rejected m132 = [] := rfl
example : falseAccepts m132 = [] := rfl
example : integrity m132 = true := rfl
def m136 : Model := ⟨[],[c1],[],[(c1.before,c1.after)]⟩
example : accepted m136 = [] := rfl
example : rejected m136 = [] := rfl
example : falseAccepts m136 = [] := rfl
example : integrity m136 = true := rfl
def m140 : Model := ⟨[],[c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m140 = [] := rfl
example : rejected m140 = [] := rfl
example : falseAccepts m140 = [] := rfl
example : integrity m140 = true := rfl
def m144 : Model := ⟨[],[c1],[c0],[]⟩
example : accepted m144 = [] := rfl
example : rejected m144 = [] := rfl
example : falseAccepts m144 = [] := rfl
example : integrity m144 = true := rfl
def m148 : Model := ⟨[],[c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m148 = [] := rfl
example : rejected m148 = [] := rfl
example : falseAccepts m148 = [] := rfl
example : integrity m148 = true := rfl
def m152 : Model := ⟨[],[c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m152 = [] := rfl
example : rejected m152 = [] := rfl
example : falseAccepts m152 = [] := rfl
example : integrity m152 = true := rfl
def m156 : Model := ⟨[],[c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m156 = [] := rfl
example : rejected m156 = [] := rfl
example : falseAccepts m156 = [] := rfl
example : integrity m156 = true := rfl
def m160 : Model := ⟨[],[c1],[c1],[]⟩
example : accepted m160 = [] := rfl
example : rejected m160 = [] := rfl
example : falseAccepts m160 = [] := rfl
example : integrity m160 = true := rfl
def m164 : Model := ⟨[],[c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m164 = [] := rfl
example : rejected m164 = [] := rfl
example : falseAccepts m164 = [] := rfl
example : integrity m164 = true := rfl
def m168 : Model := ⟨[],[c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m168 = [] := rfl
example : rejected m168 = [] := rfl
example : falseAccepts m168 = [] := rfl
example : integrity m168 = true := rfl
def m172 : Model := ⟨[],[c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m172 = [] := rfl
example : rejected m172 = [] := rfl
example : falseAccepts m172 = [] := rfl
example : integrity m172 = true := rfl
def m176 : Model := ⟨[],[c1],[c0,c1],[]⟩
example : accepted m176 = [] := rfl
example : rejected m176 = [] := rfl
example : falseAccepts m176 = [] := rfl
example : integrity m176 = true := rfl
def m180 : Model := ⟨[],[c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m180 = [] := rfl
example : rejected m180 = [] := rfl
example : falseAccepts m180 = [] := rfl
example : integrity m180 = true := rfl
def m184 : Model := ⟨[],[c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m184 = [] := rfl
example : rejected m184 = [] := rfl
example : falseAccepts m184 = [] := rfl
example : integrity m184 = true := rfl
def m188 : Model := ⟨[],[c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m188 = [] := rfl
example : rejected m188 = [] := rfl
example : falseAccepts m188 = [] := rfl
example : integrity m188 = true := rfl
def m192 : Model := ⟨[],[c0,c1],[],[]⟩
example : accepted m192 = [] := rfl
example : rejected m192 = [] := rfl
example : falseAccepts m192 = [] := rfl
example : integrity m192 = true := rfl
def m196 : Model := ⟨[],[c0,c1],[],[(c0.before,c0.after)]⟩
example : accepted m196 = [] := rfl
example : rejected m196 = [] := rfl
example : falseAccepts m196 = [] := rfl
example : integrity m196 = true := rfl
def m200 : Model := ⟨[],[c0,c1],[],[(c1.before,c1.after)]⟩
example : accepted m200 = [] := rfl
example : rejected m200 = [] := rfl
example : falseAccepts m200 = [] := rfl
example : integrity m200 = true := rfl
def m204 : Model := ⟨[],[c0,c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m204 = [] := rfl
example : rejected m204 = [] := rfl
example : falseAccepts m204 = [] := rfl
example : integrity m204 = true := rfl
def m208 : Model := ⟨[],[c0,c1],[c0],[]⟩
example : accepted m208 = [] := rfl
example : rejected m208 = [] := rfl
example : falseAccepts m208 = [] := rfl
example : integrity m208 = true := rfl
def m212 : Model := ⟨[],[c0,c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m212 = [] := rfl
example : rejected m212 = [] := rfl
example : falseAccepts m212 = [] := rfl
example : integrity m212 = true := rfl
def m216 : Model := ⟨[],[c0,c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m216 = [] := rfl
example : rejected m216 = [] := rfl
example : falseAccepts m216 = [] := rfl
example : integrity m216 = true := rfl
def m220 : Model := ⟨[],[c0,c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m220 = [] := rfl
example : rejected m220 = [] := rfl
example : falseAccepts m220 = [] := rfl
example : integrity m220 = true := rfl
def m224 : Model := ⟨[],[c0,c1],[c1],[]⟩
example : accepted m224 = [] := rfl
example : rejected m224 = [] := rfl
example : falseAccepts m224 = [] := rfl
example : integrity m224 = true := rfl
def m228 : Model := ⟨[],[c0,c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m228 = [] := rfl
example : rejected m228 = [] := rfl
example : falseAccepts m228 = [] := rfl
example : integrity m228 = true := rfl
def m232 : Model := ⟨[],[c0,c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m232 = [] := rfl
example : rejected m232 = [] := rfl
example : falseAccepts m232 = [] := rfl
example : integrity m232 = true := rfl
def m236 : Model := ⟨[],[c0,c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m236 = [] := rfl
example : rejected m236 = [] := rfl
example : falseAccepts m236 = [] := rfl
example : integrity m236 = true := rfl
def m240 : Model := ⟨[],[c0,c1],[c0,c1],[]⟩
example : accepted m240 = [] := rfl
example : rejected m240 = [] := rfl
example : falseAccepts m240 = [] := rfl
example : integrity m240 = true := rfl
def m244 : Model := ⟨[],[c0,c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m244 = [] := rfl
example : rejected m244 = [] := rfl
example : falseAccepts m244 = [] := rfl
example : integrity m244 = true := rfl
def m248 : Model := ⟨[],[c0,c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m248 = [] := rfl
example : rejected m248 = [] := rfl
example : falseAccepts m248 = [] := rfl
example : integrity m248 = true := rfl
def m252 : Model := ⟨[],[c0,c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m252 = [] := rfl
example : rejected m252 = [] := rfl
example : falseAccepts m252 = [] := rfl
example : integrity m252 = true := rfl
def m256 : Model := ⟨[r0],[],[],[]⟩
example : accepted m256 = [] := rfl
example : rejected m256 = [] := rfl
example : falseAccepts m256 = [] := rfl
example : integrity m256 = true := rfl
def m260 : Model := ⟨[r0],[],[],[(c0.before,c0.after)]⟩
example : accepted m260 = [] := rfl
example : rejected m260 = [] := rfl
example : falseAccepts m260 = [] := rfl
example : integrity m260 = true := rfl
def m264 : Model := ⟨[r0],[],[],[(c1.before,c1.after)]⟩
example : accepted m264 = [] := rfl
example : rejected m264 = [] := rfl
example : falseAccepts m264 = [] := rfl
example : integrity m264 = true := rfl
def m268 : Model := ⟨[r0],[],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m268 = [] := rfl
example : rejected m268 = [] := rfl
example : falseAccepts m268 = [] := rfl
example : integrity m268 = true := rfl
def m272 : Model := ⟨[r0],[],[c0],[]⟩
example : accepted m272 = [] := rfl
example : rejected m272 = [c0] := rfl
example : falseAccepts m272 = [] := rfl
example : integrity m272 = true := rfl
def m276 : Model := ⟨[r0],[],[c0],[(c0.before,c0.after)]⟩
example : accepted m276 = [c0] := rfl
example : rejected m276 = [] := rfl
example : falseAccepts m276 = [c0] := rfl
example : integrity m276 = false := rfl
def m280 : Model := ⟨[r0],[],[c0],[(c1.before,c1.after)]⟩
example : accepted m280 = [] := rfl
example : rejected m280 = [c0] := rfl
example : falseAccepts m280 = [] := rfl
example : integrity m280 = true := rfl
def m284 : Model := ⟨[r0],[],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m284 = [c0] := rfl
example : rejected m284 = [] := rfl
example : falseAccepts m284 = [c0] := rfl
example : integrity m284 = false := rfl
def m288 : Model := ⟨[r0],[],[c1],[]⟩
example : accepted m288 = [] := rfl
example : rejected m288 = [] := rfl
example : falseAccepts m288 = [] := rfl
example : integrity m288 = true := rfl
def m292 : Model := ⟨[r0],[],[c1],[(c0.before,c0.after)]⟩
example : accepted m292 = [] := rfl
example : rejected m292 = [] := rfl
example : falseAccepts m292 = [] := rfl
example : integrity m292 = true := rfl
def m296 : Model := ⟨[r0],[],[c1],[(c1.before,c1.after)]⟩
example : accepted m296 = [] := rfl
example : rejected m296 = [] := rfl
example : falseAccepts m296 = [] := rfl
example : integrity m296 = true := rfl
def m300 : Model := ⟨[r0],[],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m300 = [] := rfl
example : rejected m300 = [] := rfl
example : falseAccepts m300 = [] := rfl
example : integrity m300 = true := rfl
def m304 : Model := ⟨[r0],[],[c0,c1],[]⟩
example : accepted m304 = [] := rfl
example : rejected m304 = [c0] := rfl
example : falseAccepts m304 = [] := rfl
example : integrity m304 = true := rfl
def m308 : Model := ⟨[r0],[],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m308 = [c0] := rfl
example : rejected m308 = [] := rfl
example : falseAccepts m308 = [c0] := rfl
example : integrity m308 = false := rfl
def m312 : Model := ⟨[r0],[],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m312 = [] := rfl
example : rejected m312 = [c0] := rfl
example : falseAccepts m312 = [] := rfl
example : integrity m312 = true := rfl
def m316 : Model := ⟨[r0],[],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m316 = [c0] := rfl
example : rejected m316 = [] := rfl
example : falseAccepts m316 = [c0] := rfl
example : integrity m316 = false := rfl
def m320 : Model := ⟨[r0],[c0],[],[]⟩
example : accepted m320 = [] := rfl
example : rejected m320 = [] := rfl
example : falseAccepts m320 = [] := rfl
example : integrity m320 = true := rfl
def m324 : Model := ⟨[r0],[c0],[],[(c0.before,c0.after)]⟩
example : accepted m324 = [] := rfl
example : rejected m324 = [] := rfl
example : falseAccepts m324 = [] := rfl
example : integrity m324 = true := rfl
def m328 : Model := ⟨[r0],[c0],[],[(c1.before,c1.after)]⟩
example : accepted m328 = [] := rfl
example : rejected m328 = [] := rfl
example : falseAccepts m328 = [] := rfl
example : integrity m328 = true := rfl
def m332 : Model := ⟨[r0],[c0],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m332 = [] := rfl
example : rejected m332 = [] := rfl
example : falseAccepts m332 = [] := rfl
example : integrity m332 = true := rfl
def m336 : Model := ⟨[r0],[c0],[c0],[]⟩
example : accepted m336 = [] := rfl
example : rejected m336 = [c0] := rfl
example : falseAccepts m336 = [] := rfl
example : integrity m336 = true := rfl
def m340 : Model := ⟨[r0],[c0],[c0],[(c0.before,c0.after)]⟩
example : accepted m340 = [c0] := rfl
example : rejected m340 = [] := rfl
example : falseAccepts m340 = [] := rfl
example : integrity m340 = true := rfl
def m344 : Model := ⟨[r0],[c0],[c0],[(c1.before,c1.after)]⟩
example : accepted m344 = [] := rfl
example : rejected m344 = [c0] := rfl
example : falseAccepts m344 = [] := rfl
example : integrity m344 = true := rfl
def m348 : Model := ⟨[r0],[c0],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m348 = [c0] := rfl
example : rejected m348 = [] := rfl
example : falseAccepts m348 = [] := rfl
example : integrity m348 = true := rfl
def m352 : Model := ⟨[r0],[c0],[c1],[]⟩
example : accepted m352 = [] := rfl
example : rejected m352 = [] := rfl
example : falseAccepts m352 = [] := rfl
example : integrity m352 = true := rfl
def m356 : Model := ⟨[r0],[c0],[c1],[(c0.before,c0.after)]⟩
example : accepted m356 = [] := rfl
example : rejected m356 = [] := rfl
example : falseAccepts m356 = [] := rfl
example : integrity m356 = true := rfl
def m360 : Model := ⟨[r0],[c0],[c1],[(c1.before,c1.after)]⟩
example : accepted m360 = [] := rfl
example : rejected m360 = [] := rfl
example : falseAccepts m360 = [] := rfl
example : integrity m360 = true := rfl
def m364 : Model := ⟨[r0],[c0],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m364 = [] := rfl
example : rejected m364 = [] := rfl
example : falseAccepts m364 = [] := rfl
example : integrity m364 = true := rfl
def m368 : Model := ⟨[r0],[c0],[c0,c1],[]⟩
example : accepted m368 = [] := rfl
example : rejected m368 = [c0] := rfl
example : falseAccepts m368 = [] := rfl
example : integrity m368 = true := rfl
def m372 : Model := ⟨[r0],[c0],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m372 = [c0] := rfl
example : rejected m372 = [] := rfl
example : falseAccepts m372 = [] := rfl
example : integrity m372 = true := rfl
def m376 : Model := ⟨[r0],[c0],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m376 = [] := rfl
example : rejected m376 = [c0] := rfl
example : falseAccepts m376 = [] := rfl
example : integrity m376 = true := rfl
def m380 : Model := ⟨[r0],[c0],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m380 = [c0] := rfl
example : rejected m380 = [] := rfl
example : falseAccepts m380 = [] := rfl
example : integrity m380 = true := rfl
def m384 : Model := ⟨[r0],[c1],[],[]⟩
example : accepted m384 = [] := rfl
example : rejected m384 = [] := rfl
example : falseAccepts m384 = [] := rfl
example : integrity m384 = true := rfl
def m388 : Model := ⟨[r0],[c1],[],[(c0.before,c0.after)]⟩
example : accepted m388 = [] := rfl
example : rejected m388 = [] := rfl
example : falseAccepts m388 = [] := rfl
example : integrity m388 = true := rfl
def m392 : Model := ⟨[r0],[c1],[],[(c1.before,c1.after)]⟩
example : accepted m392 = [] := rfl
example : rejected m392 = [] := rfl
example : falseAccepts m392 = [] := rfl
example : integrity m392 = true := rfl
def m396 : Model := ⟨[r0],[c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m396 = [] := rfl
example : rejected m396 = [] := rfl
example : falseAccepts m396 = [] := rfl
example : integrity m396 = true := rfl
def m400 : Model := ⟨[r0],[c1],[c0],[]⟩
example : accepted m400 = [] := rfl
example : rejected m400 = [c0] := rfl
example : falseAccepts m400 = [] := rfl
example : integrity m400 = true := rfl
def m404 : Model := ⟨[r0],[c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m404 = [c0] := rfl
example : rejected m404 = [] := rfl
example : falseAccepts m404 = [c0] := rfl
example : integrity m404 = false := rfl
def m408 : Model := ⟨[r0],[c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m408 = [] := rfl
example : rejected m408 = [c0] := rfl
example : falseAccepts m408 = [] := rfl
example : integrity m408 = true := rfl
def m412 : Model := ⟨[r0],[c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m412 = [c0] := rfl
example : rejected m412 = [] := rfl
example : falseAccepts m412 = [c0] := rfl
example : integrity m412 = false := rfl
def m416 : Model := ⟨[r0],[c1],[c1],[]⟩
example : accepted m416 = [] := rfl
example : rejected m416 = [] := rfl
example : falseAccepts m416 = [] := rfl
example : integrity m416 = true := rfl
def m420 : Model := ⟨[r0],[c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m420 = [] := rfl
example : rejected m420 = [] := rfl
example : falseAccepts m420 = [] := rfl
example : integrity m420 = true := rfl
def m424 : Model := ⟨[r0],[c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m424 = [] := rfl
example : rejected m424 = [] := rfl
example : falseAccepts m424 = [] := rfl
example : integrity m424 = true := rfl
def m428 : Model := ⟨[r0],[c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m428 = [] := rfl
example : rejected m428 = [] := rfl
example : falseAccepts m428 = [] := rfl
example : integrity m428 = true := rfl
def m432 : Model := ⟨[r0],[c1],[c0,c1],[]⟩
example : accepted m432 = [] := rfl
example : rejected m432 = [c0] := rfl
example : falseAccepts m432 = [] := rfl
example : integrity m432 = true := rfl
def m436 : Model := ⟨[r0],[c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m436 = [c0] := rfl
example : rejected m436 = [] := rfl
example : falseAccepts m436 = [c0] := rfl
example : integrity m436 = false := rfl
def m440 : Model := ⟨[r0],[c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m440 = [] := rfl
example : rejected m440 = [c0] := rfl
example : falseAccepts m440 = [] := rfl
example : integrity m440 = true := rfl
def m444 : Model := ⟨[r0],[c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m444 = [c0] := rfl
example : rejected m444 = [] := rfl
example : falseAccepts m444 = [c0] := rfl
example : integrity m444 = false := rfl
def m448 : Model := ⟨[r0],[c0,c1],[],[]⟩
example : accepted m448 = [] := rfl
example : rejected m448 = [] := rfl
example : falseAccepts m448 = [] := rfl
example : integrity m448 = true := rfl
def m452 : Model := ⟨[r0],[c0,c1],[],[(c0.before,c0.after)]⟩
example : accepted m452 = [] := rfl
example : rejected m452 = [] := rfl
example : falseAccepts m452 = [] := rfl
example : integrity m452 = true := rfl
def m456 : Model := ⟨[r0],[c0,c1],[],[(c1.before,c1.after)]⟩
example : accepted m456 = [] := rfl
example : rejected m456 = [] := rfl
example : falseAccepts m456 = [] := rfl
example : integrity m456 = true := rfl
def m460 : Model := ⟨[r0],[c0,c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m460 = [] := rfl
example : rejected m460 = [] := rfl
example : falseAccepts m460 = [] := rfl
example : integrity m460 = true := rfl
def m464 : Model := ⟨[r0],[c0,c1],[c0],[]⟩
example : accepted m464 = [] := rfl
example : rejected m464 = [c0] := rfl
example : falseAccepts m464 = [] := rfl
example : integrity m464 = true := rfl
def m468 : Model := ⟨[r0],[c0,c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m468 = [c0] := rfl
example : rejected m468 = [] := rfl
example : falseAccepts m468 = [] := rfl
example : integrity m468 = true := rfl
def m472 : Model := ⟨[r0],[c0,c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m472 = [] := rfl
example : rejected m472 = [c0] := rfl
example : falseAccepts m472 = [] := rfl
example : integrity m472 = true := rfl
def m476 : Model := ⟨[r0],[c0,c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m476 = [c0] := rfl
example : rejected m476 = [] := rfl
example : falseAccepts m476 = [] := rfl
example : integrity m476 = true := rfl
def m480 : Model := ⟨[r0],[c0,c1],[c1],[]⟩
example : accepted m480 = [] := rfl
example : rejected m480 = [] := rfl
example : falseAccepts m480 = [] := rfl
example : integrity m480 = true := rfl
def m484 : Model := ⟨[r0],[c0,c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m484 = [] := rfl
example : rejected m484 = [] := rfl
example : falseAccepts m484 = [] := rfl
example : integrity m484 = true := rfl
def m488 : Model := ⟨[r0],[c0,c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m488 = [] := rfl
example : rejected m488 = [] := rfl
example : falseAccepts m488 = [] := rfl
example : integrity m488 = true := rfl
def m492 : Model := ⟨[r0],[c0,c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m492 = [] := rfl
example : rejected m492 = [] := rfl
example : falseAccepts m492 = [] := rfl
example : integrity m492 = true := rfl
def m496 : Model := ⟨[r0],[c0,c1],[c0,c1],[]⟩
example : accepted m496 = [] := rfl
example : rejected m496 = [c0] := rfl
example : falseAccepts m496 = [] := rfl
example : integrity m496 = true := rfl
def m500 : Model := ⟨[r0],[c0,c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m500 = [c0] := rfl
example : rejected m500 = [] := rfl
example : falseAccepts m500 = [] := rfl
example : integrity m500 = true := rfl
def m504 : Model := ⟨[r0],[c0,c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m504 = [] := rfl
example : rejected m504 = [c0] := rfl
example : falseAccepts m504 = [] := rfl
example : integrity m504 = true := rfl
def m508 : Model := ⟨[r0],[c0,c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m508 = [c0] := rfl
example : rejected m508 = [] := rfl
example : falseAccepts m508 = [] := rfl
example : integrity m508 = true := rfl
def m512 : Model := ⟨[r1],[],[],[]⟩
example : accepted m512 = [] := rfl
example : rejected m512 = [] := rfl
example : falseAccepts m512 = [] := rfl
example : integrity m512 = true := rfl
def m516 : Model := ⟨[r1],[],[],[(c0.before,c0.after)]⟩
example : accepted m516 = [] := rfl
example : rejected m516 = [] := rfl
example : falseAccepts m516 = [] := rfl
example : integrity m516 = true := rfl
def m520 : Model := ⟨[r1],[],[],[(c1.before,c1.after)]⟩
example : accepted m520 = [] := rfl
example : rejected m520 = [] := rfl
example : falseAccepts m520 = [] := rfl
example : integrity m520 = true := rfl
def m524 : Model := ⟨[r1],[],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m524 = [] := rfl
example : rejected m524 = [] := rfl
example : falseAccepts m524 = [] := rfl
example : integrity m524 = true := rfl
def m528 : Model := ⟨[r1],[],[c0],[]⟩
example : accepted m528 = [] := rfl
example : rejected m528 = [] := rfl
example : falseAccepts m528 = [] := rfl
example : integrity m528 = true := rfl
def m532 : Model := ⟨[r1],[],[c0],[(c0.before,c0.after)]⟩
example : accepted m532 = [] := rfl
example : rejected m532 = [] := rfl
example : falseAccepts m532 = [] := rfl
example : integrity m532 = true := rfl
def m536 : Model := ⟨[r1],[],[c0],[(c1.before,c1.after)]⟩
example : accepted m536 = [] := rfl
example : rejected m536 = [] := rfl
example : falseAccepts m536 = [] := rfl
example : integrity m536 = true := rfl
def m540 : Model := ⟨[r1],[],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m540 = [] := rfl
example : rejected m540 = [] := rfl
example : falseAccepts m540 = [] := rfl
example : integrity m540 = true := rfl
def m544 : Model := ⟨[r1],[],[c1],[]⟩
example : accepted m544 = [] := rfl
example : rejected m544 = [c1] := rfl
example : falseAccepts m544 = [] := rfl
example : integrity m544 = true := rfl
def m548 : Model := ⟨[r1],[],[c1],[(c0.before,c0.after)]⟩
example : accepted m548 = [] := rfl
example : rejected m548 = [c1] := rfl
example : falseAccepts m548 = [] := rfl
example : integrity m548 = true := rfl
def m552 : Model := ⟨[r1],[],[c1],[(c1.before,c1.after)]⟩
example : accepted m552 = [c1] := rfl
example : rejected m552 = [] := rfl
example : falseAccepts m552 = [c1] := rfl
example : integrity m552 = false := rfl
def m556 : Model := ⟨[r1],[],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m556 = [c1] := rfl
example : rejected m556 = [] := rfl
example : falseAccepts m556 = [c1] := rfl
example : integrity m556 = false := rfl
def m560 : Model := ⟨[r1],[],[c0,c1],[]⟩
example : accepted m560 = [] := rfl
example : rejected m560 = [c1] := rfl
example : falseAccepts m560 = [] := rfl
example : integrity m560 = true := rfl
def m564 : Model := ⟨[r1],[],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m564 = [] := rfl
example : rejected m564 = [c1] := rfl
example : falseAccepts m564 = [] := rfl
example : integrity m564 = true := rfl
def m568 : Model := ⟨[r1],[],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m568 = [c1] := rfl
example : rejected m568 = [] := rfl
example : falseAccepts m568 = [c1] := rfl
example : integrity m568 = false := rfl
def m572 : Model := ⟨[r1],[],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m572 = [c1] := rfl
example : rejected m572 = [] := rfl
example : falseAccepts m572 = [c1] := rfl
example : integrity m572 = false := rfl
def m576 : Model := ⟨[r1],[c0],[],[]⟩
example : accepted m576 = [] := rfl
example : rejected m576 = [] := rfl
example : falseAccepts m576 = [] := rfl
example : integrity m576 = true := rfl
def m580 : Model := ⟨[r1],[c0],[],[(c0.before,c0.after)]⟩
example : accepted m580 = [] := rfl
example : rejected m580 = [] := rfl
example : falseAccepts m580 = [] := rfl
example : integrity m580 = true := rfl
def m584 : Model := ⟨[r1],[c0],[],[(c1.before,c1.after)]⟩
example : accepted m584 = [] := rfl
example : rejected m584 = [] := rfl
example : falseAccepts m584 = [] := rfl
example : integrity m584 = true := rfl
def m588 : Model := ⟨[r1],[c0],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m588 = [] := rfl
example : rejected m588 = [] := rfl
example : falseAccepts m588 = [] := rfl
example : integrity m588 = true := rfl
def m592 : Model := ⟨[r1],[c0],[c0],[]⟩
example : accepted m592 = [] := rfl
example : rejected m592 = [] := rfl
example : falseAccepts m592 = [] := rfl
example : integrity m592 = true := rfl
def m596 : Model := ⟨[r1],[c0],[c0],[(c0.before,c0.after)]⟩
example : accepted m596 = [] := rfl
example : rejected m596 = [] := rfl
example : falseAccepts m596 = [] := rfl
example : integrity m596 = true := rfl
def m600 : Model := ⟨[r1],[c0],[c0],[(c1.before,c1.after)]⟩
example : accepted m600 = [] := rfl
example : rejected m600 = [] := rfl
example : falseAccepts m600 = [] := rfl
example : integrity m600 = true := rfl
def m604 : Model := ⟨[r1],[c0],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m604 = [] := rfl
example : rejected m604 = [] := rfl
example : falseAccepts m604 = [] := rfl
example : integrity m604 = true := rfl
def m608 : Model := ⟨[r1],[c0],[c1],[]⟩
example : accepted m608 = [] := rfl
example : rejected m608 = [c1] := rfl
example : falseAccepts m608 = [] := rfl
example : integrity m608 = true := rfl
def m612 : Model := ⟨[r1],[c0],[c1],[(c0.before,c0.after)]⟩
example : accepted m612 = [] := rfl
example : rejected m612 = [c1] := rfl
example : falseAccepts m612 = [] := rfl
example : integrity m612 = true := rfl
def m616 : Model := ⟨[r1],[c0],[c1],[(c1.before,c1.after)]⟩
example : accepted m616 = [c1] := rfl
example : rejected m616 = [] := rfl
example : falseAccepts m616 = [c1] := rfl
example : integrity m616 = false := rfl
def m620 : Model := ⟨[r1],[c0],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m620 = [c1] := rfl
example : rejected m620 = [] := rfl
example : falseAccepts m620 = [c1] := rfl
example : integrity m620 = false := rfl
def m624 : Model := ⟨[r1],[c0],[c0,c1],[]⟩
example : accepted m624 = [] := rfl
example : rejected m624 = [c1] := rfl
example : falseAccepts m624 = [] := rfl
example : integrity m624 = true := rfl
def m628 : Model := ⟨[r1],[c0],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m628 = [] := rfl
example : rejected m628 = [c1] := rfl
example : falseAccepts m628 = [] := rfl
example : integrity m628 = true := rfl
def m632 : Model := ⟨[r1],[c0],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m632 = [c1] := rfl
example : rejected m632 = [] := rfl
example : falseAccepts m632 = [c1] := rfl
example : integrity m632 = false := rfl
def m636 : Model := ⟨[r1],[c0],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m636 = [c1] := rfl
example : rejected m636 = [] := rfl
example : falseAccepts m636 = [c1] := rfl
example : integrity m636 = false := rfl
def m640 : Model := ⟨[r1],[c1],[],[]⟩
example : accepted m640 = [] := rfl
example : rejected m640 = [] := rfl
example : falseAccepts m640 = [] := rfl
example : integrity m640 = true := rfl
def m644 : Model := ⟨[r1],[c1],[],[(c0.before,c0.after)]⟩
example : accepted m644 = [] := rfl
example : rejected m644 = [] := rfl
example : falseAccepts m644 = [] := rfl
example : integrity m644 = true := rfl
def m648 : Model := ⟨[r1],[c1],[],[(c1.before,c1.after)]⟩
example : accepted m648 = [] := rfl
example : rejected m648 = [] := rfl
example : falseAccepts m648 = [] := rfl
example : integrity m648 = true := rfl
def m652 : Model := ⟨[r1],[c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m652 = [] := rfl
example : rejected m652 = [] := rfl
example : falseAccepts m652 = [] := rfl
example : integrity m652 = true := rfl
def m656 : Model := ⟨[r1],[c1],[c0],[]⟩
example : accepted m656 = [] := rfl
example : rejected m656 = [] := rfl
example : falseAccepts m656 = [] := rfl
example : integrity m656 = true := rfl
def m660 : Model := ⟨[r1],[c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m660 = [] := rfl
example : rejected m660 = [] := rfl
example : falseAccepts m660 = [] := rfl
example : integrity m660 = true := rfl
def m664 : Model := ⟨[r1],[c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m664 = [] := rfl
example : rejected m664 = [] := rfl
example : falseAccepts m664 = [] := rfl
example : integrity m664 = true := rfl
def m668 : Model := ⟨[r1],[c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m668 = [] := rfl
example : rejected m668 = [] := rfl
example : falseAccepts m668 = [] := rfl
example : integrity m668 = true := rfl
def m672 : Model := ⟨[r1],[c1],[c1],[]⟩
example : accepted m672 = [] := rfl
example : rejected m672 = [c1] := rfl
example : falseAccepts m672 = [] := rfl
example : integrity m672 = true := rfl
def m676 : Model := ⟨[r1],[c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m676 = [] := rfl
example : rejected m676 = [c1] := rfl
example : falseAccepts m676 = [] := rfl
example : integrity m676 = true := rfl
def m680 : Model := ⟨[r1],[c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m680 = [c1] := rfl
example : rejected m680 = [] := rfl
example : falseAccepts m680 = [] := rfl
example : integrity m680 = true := rfl
def m684 : Model := ⟨[r1],[c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m684 = [c1] := rfl
example : rejected m684 = [] := rfl
example : falseAccepts m684 = [] := rfl
example : integrity m684 = true := rfl
def m688 : Model := ⟨[r1],[c1],[c0,c1],[]⟩
example : accepted m688 = [] := rfl
example : rejected m688 = [c1] := rfl
example : falseAccepts m688 = [] := rfl
example : integrity m688 = true := rfl
def m692 : Model := ⟨[r1],[c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m692 = [] := rfl
example : rejected m692 = [c1] := rfl
example : falseAccepts m692 = [] := rfl
example : integrity m692 = true := rfl
def m696 : Model := ⟨[r1],[c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m696 = [c1] := rfl
example : rejected m696 = [] := rfl
example : falseAccepts m696 = [] := rfl
example : integrity m696 = true := rfl
def m700 : Model := ⟨[r1],[c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m700 = [c1] := rfl
example : rejected m700 = [] := rfl
example : falseAccepts m700 = [] := rfl
example : integrity m700 = true := rfl
def m704 : Model := ⟨[r1],[c0,c1],[],[]⟩
example : accepted m704 = [] := rfl
example : rejected m704 = [] := rfl
example : falseAccepts m704 = [] := rfl
example : integrity m704 = true := rfl
def m708 : Model := ⟨[r1],[c0,c1],[],[(c0.before,c0.after)]⟩
example : accepted m708 = [] := rfl
example : rejected m708 = [] := rfl
example : falseAccepts m708 = [] := rfl
example : integrity m708 = true := rfl
def m712 : Model := ⟨[r1],[c0,c1],[],[(c1.before,c1.after)]⟩
example : accepted m712 = [] := rfl
example : rejected m712 = [] := rfl
example : falseAccepts m712 = [] := rfl
example : integrity m712 = true := rfl
def m716 : Model := ⟨[r1],[c0,c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m716 = [] := rfl
example : rejected m716 = [] := rfl
example : falseAccepts m716 = [] := rfl
example : integrity m716 = true := rfl
def m720 : Model := ⟨[r1],[c0,c1],[c0],[]⟩
example : accepted m720 = [] := rfl
example : rejected m720 = [] := rfl
example : falseAccepts m720 = [] := rfl
example : integrity m720 = true := rfl
def m724 : Model := ⟨[r1],[c0,c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m724 = [] := rfl
example : rejected m724 = [] := rfl
example : falseAccepts m724 = [] := rfl
example : integrity m724 = true := rfl
def m728 : Model := ⟨[r1],[c0,c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m728 = [] := rfl
example : rejected m728 = [] := rfl
example : falseAccepts m728 = [] := rfl
example : integrity m728 = true := rfl
def m732 : Model := ⟨[r1],[c0,c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m732 = [] := rfl
example : rejected m732 = [] := rfl
example : falseAccepts m732 = [] := rfl
example : integrity m732 = true := rfl
def m736 : Model := ⟨[r1],[c0,c1],[c1],[]⟩
example : accepted m736 = [] := rfl
example : rejected m736 = [c1] := rfl
example : falseAccepts m736 = [] := rfl
example : integrity m736 = true := rfl
def m740 : Model := ⟨[r1],[c0,c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m740 = [] := rfl
example : rejected m740 = [c1] := rfl
example : falseAccepts m740 = [] := rfl
example : integrity m740 = true := rfl
def m744 : Model := ⟨[r1],[c0,c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m744 = [c1] := rfl
example : rejected m744 = [] := rfl
example : falseAccepts m744 = [] := rfl
example : integrity m744 = true := rfl
def m748 : Model := ⟨[r1],[c0,c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m748 = [c1] := rfl
example : rejected m748 = [] := rfl
example : falseAccepts m748 = [] := rfl
example : integrity m748 = true := rfl
def m752 : Model := ⟨[r1],[c0,c1],[c0,c1],[]⟩
example : accepted m752 = [] := rfl
example : rejected m752 = [c1] := rfl
example : falseAccepts m752 = [] := rfl
example : integrity m752 = true := rfl
def m756 : Model := ⟨[r1],[c0,c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m756 = [] := rfl
example : rejected m756 = [c1] := rfl
example : falseAccepts m756 = [] := rfl
example : integrity m756 = true := rfl
def m760 : Model := ⟨[r1],[c0,c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m760 = [c1] := rfl
example : rejected m760 = [] := rfl
example : falseAccepts m760 = [] := rfl
example : integrity m760 = true := rfl
def m764 : Model := ⟨[r1],[c0,c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m764 = [c1] := rfl
example : rejected m764 = [] := rfl
example : falseAccepts m764 = [] := rfl
example : integrity m764 = true := rfl
def m768 : Model := ⟨[r0,r1],[],[],[]⟩
example : accepted m768 = [] := rfl
example : rejected m768 = [] := rfl
example : falseAccepts m768 = [] := rfl
example : integrity m768 = true := rfl
def m772 : Model := ⟨[r0,r1],[],[],[(c0.before,c0.after)]⟩
example : accepted m772 = [] := rfl
example : rejected m772 = [] := rfl
example : falseAccepts m772 = [] := rfl
example : integrity m772 = true := rfl
def m776 : Model := ⟨[r0,r1],[],[],[(c1.before,c1.after)]⟩
example : accepted m776 = [] := rfl
example : rejected m776 = [] := rfl
example : falseAccepts m776 = [] := rfl
example : integrity m776 = true := rfl
def m780 : Model := ⟨[r0,r1],[],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m780 = [] := rfl
example : rejected m780 = [] := rfl
example : falseAccepts m780 = [] := rfl
example : integrity m780 = true := rfl
def m784 : Model := ⟨[r0,r1],[],[c0],[]⟩
example : accepted m784 = [] := rfl
example : rejected m784 = [c0] := rfl
example : falseAccepts m784 = [] := rfl
example : integrity m784 = true := rfl
def m788 : Model := ⟨[r0,r1],[],[c0],[(c0.before,c0.after)]⟩
example : accepted m788 = [c0] := rfl
example : rejected m788 = [] := rfl
example : falseAccepts m788 = [c0] := rfl
example : integrity m788 = false := rfl
def m792 : Model := ⟨[r0,r1],[],[c0],[(c1.before,c1.after)]⟩
example : accepted m792 = [] := rfl
example : rejected m792 = [c0] := rfl
example : falseAccepts m792 = [] := rfl
example : integrity m792 = true := rfl
def m796 : Model := ⟨[r0,r1],[],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m796 = [c0] := rfl
example : rejected m796 = [] := rfl
example : falseAccepts m796 = [c0] := rfl
example : integrity m796 = false := rfl
def m800 : Model := ⟨[r0,r1],[],[c1],[]⟩
example : accepted m800 = [] := rfl
example : rejected m800 = [c1] := rfl
example : falseAccepts m800 = [] := rfl
example : integrity m800 = true := rfl
def m804 : Model := ⟨[r0,r1],[],[c1],[(c0.before,c0.after)]⟩
example : accepted m804 = [] := rfl
example : rejected m804 = [c1] := rfl
example : falseAccepts m804 = [] := rfl
example : integrity m804 = true := rfl
def m808 : Model := ⟨[r0,r1],[],[c1],[(c1.before,c1.after)]⟩
example : accepted m808 = [c1] := rfl
example : rejected m808 = [] := rfl
example : falseAccepts m808 = [c1] := rfl
example : integrity m808 = false := rfl
def m812 : Model := ⟨[r0,r1],[],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m812 = [c1] := rfl
example : rejected m812 = [] := rfl
example : falseAccepts m812 = [c1] := rfl
example : integrity m812 = false := rfl
def m816 : Model := ⟨[r0,r1],[],[c0,c1],[]⟩
example : accepted m816 = [] := rfl
example : rejected m816 = [c0,c1] := rfl
example : falseAccepts m816 = [] := rfl
example : integrity m816 = true := rfl
def m820 : Model := ⟨[r0,r1],[],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m820 = [c0] := rfl
example : rejected m820 = [c1] := rfl
example : falseAccepts m820 = [c0] := rfl
example : integrity m820 = false := rfl
def m824 : Model := ⟨[r0,r1],[],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m824 = [c1] := rfl
example : rejected m824 = [c0] := rfl
example : falseAccepts m824 = [c1] := rfl
example : integrity m824 = false := rfl
def m828 : Model := ⟨[r0,r1],[],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m828 = [c0,c1] := rfl
example : rejected m828 = [] := rfl
example : falseAccepts m828 = [c0,c1] := rfl
example : integrity m828 = false := rfl
def m832 : Model := ⟨[r0,r1],[c0],[],[]⟩
example : accepted m832 = [] := rfl
example : rejected m832 = [] := rfl
example : falseAccepts m832 = [] := rfl
example : integrity m832 = true := rfl
def m836 : Model := ⟨[r0,r1],[c0],[],[(c0.before,c0.after)]⟩
example : accepted m836 = [] := rfl
example : rejected m836 = [] := rfl
example : falseAccepts m836 = [] := rfl
example : integrity m836 = true := rfl
def m840 : Model := ⟨[r0,r1],[c0],[],[(c1.before,c1.after)]⟩
example : accepted m840 = [] := rfl
example : rejected m840 = [] := rfl
example : falseAccepts m840 = [] := rfl
example : integrity m840 = true := rfl
def m844 : Model := ⟨[r0,r1],[c0],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m844 = [] := rfl
example : rejected m844 = [] := rfl
example : falseAccepts m844 = [] := rfl
example : integrity m844 = true := rfl
def m848 : Model := ⟨[r0,r1],[c0],[c0],[]⟩
example : accepted m848 = [] := rfl
example : rejected m848 = [c0] := rfl
example : falseAccepts m848 = [] := rfl
example : integrity m848 = true := rfl
def m852 : Model := ⟨[r0,r1],[c0],[c0],[(c0.before,c0.after)]⟩
example : accepted m852 = [c0] := rfl
example : rejected m852 = [] := rfl
example : falseAccepts m852 = [] := rfl
example : integrity m852 = true := rfl
def m856 : Model := ⟨[r0,r1],[c0],[c0],[(c1.before,c1.after)]⟩
example : accepted m856 = [] := rfl
example : rejected m856 = [c0] := rfl
example : falseAccepts m856 = [] := rfl
example : integrity m856 = true := rfl
def m860 : Model := ⟨[r0,r1],[c0],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m860 = [c0] := rfl
example : rejected m860 = [] := rfl
example : falseAccepts m860 = [] := rfl
example : integrity m860 = true := rfl
def m864 : Model := ⟨[r0,r1],[c0],[c1],[]⟩
example : accepted m864 = [] := rfl
example : rejected m864 = [c1] := rfl
example : falseAccepts m864 = [] := rfl
example : integrity m864 = true := rfl
def m868 : Model := ⟨[r0,r1],[c0],[c1],[(c0.before,c0.after)]⟩
example : accepted m868 = [] := rfl
example : rejected m868 = [c1] := rfl
example : falseAccepts m868 = [] := rfl
example : integrity m868 = true := rfl
def m872 : Model := ⟨[r0,r1],[c0],[c1],[(c1.before,c1.after)]⟩
example : accepted m872 = [c1] := rfl
example : rejected m872 = [] := rfl
example : falseAccepts m872 = [c1] := rfl
example : integrity m872 = false := rfl
def m876 : Model := ⟨[r0,r1],[c0],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m876 = [c1] := rfl
example : rejected m876 = [] := rfl
example : falseAccepts m876 = [c1] := rfl
example : integrity m876 = false := rfl
def m880 : Model := ⟨[r0,r1],[c0],[c0,c1],[]⟩
example : accepted m880 = [] := rfl
example : rejected m880 = [c0,c1] := rfl
example : falseAccepts m880 = [] := rfl
example : integrity m880 = true := rfl
def m884 : Model := ⟨[r0,r1],[c0],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m884 = [c0] := rfl
example : rejected m884 = [c1] := rfl
example : falseAccepts m884 = [] := rfl
example : integrity m884 = true := rfl
def m888 : Model := ⟨[r0,r1],[c0],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m888 = [c1] := rfl
example : rejected m888 = [c0] := rfl
example : falseAccepts m888 = [c1] := rfl
example : integrity m888 = false := rfl
def m892 : Model := ⟨[r0,r1],[c0],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m892 = [c0,c1] := rfl
example : rejected m892 = [] := rfl
example : falseAccepts m892 = [c1] := rfl
example : integrity m892 = false := rfl
def m896 : Model := ⟨[r0,r1],[c1],[],[]⟩
example : accepted m896 = [] := rfl
example : rejected m896 = [] := rfl
example : falseAccepts m896 = [] := rfl
example : integrity m896 = true := rfl
def m900 : Model := ⟨[r0,r1],[c1],[],[(c0.before,c0.after)]⟩
example : accepted m900 = [] := rfl
example : rejected m900 = [] := rfl
example : falseAccepts m900 = [] := rfl
example : integrity m900 = true := rfl
def m904 : Model := ⟨[r0,r1],[c1],[],[(c1.before,c1.after)]⟩
example : accepted m904 = [] := rfl
example : rejected m904 = [] := rfl
example : falseAccepts m904 = [] := rfl
example : integrity m904 = true := rfl
def m908 : Model := ⟨[r0,r1],[c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m908 = [] := rfl
example : rejected m908 = [] := rfl
example : falseAccepts m908 = [] := rfl
example : integrity m908 = true := rfl
def m912 : Model := ⟨[r0,r1],[c1],[c0],[]⟩
example : accepted m912 = [] := rfl
example : rejected m912 = [c0] := rfl
example : falseAccepts m912 = [] := rfl
example : integrity m912 = true := rfl
def m916 : Model := ⟨[r0,r1],[c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m916 = [c0] := rfl
example : rejected m916 = [] := rfl
example : falseAccepts m916 = [c0] := rfl
example : integrity m916 = false := rfl
def m920 : Model := ⟨[r0,r1],[c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m920 = [] := rfl
example : rejected m920 = [c0] := rfl
example : falseAccepts m920 = [] := rfl
example : integrity m920 = true := rfl
def m924 : Model := ⟨[r0,r1],[c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m924 = [c0] := rfl
example : rejected m924 = [] := rfl
example : falseAccepts m924 = [c0] := rfl
example : integrity m924 = false := rfl
def m928 : Model := ⟨[r0,r1],[c1],[c1],[]⟩
example : accepted m928 = [] := rfl
example : rejected m928 = [c1] := rfl
example : falseAccepts m928 = [] := rfl
example : integrity m928 = true := rfl
def m932 : Model := ⟨[r0,r1],[c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m932 = [] := rfl
example : rejected m932 = [c1] := rfl
example : falseAccepts m932 = [] := rfl
example : integrity m932 = true := rfl
def m936 : Model := ⟨[r0,r1],[c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m936 = [c1] := rfl
example : rejected m936 = [] := rfl
example : falseAccepts m936 = [] := rfl
example : integrity m936 = true := rfl
def m940 : Model := ⟨[r0,r1],[c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m940 = [c1] := rfl
example : rejected m940 = [] := rfl
example : falseAccepts m940 = [] := rfl
example : integrity m940 = true := rfl
def m944 : Model := ⟨[r0,r1],[c1],[c0,c1],[]⟩
example : accepted m944 = [] := rfl
example : rejected m944 = [c0,c1] := rfl
example : falseAccepts m944 = [] := rfl
example : integrity m944 = true := rfl
def m948 : Model := ⟨[r0,r1],[c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m948 = [c0] := rfl
example : rejected m948 = [c1] := rfl
example : falseAccepts m948 = [c0] := rfl
example : integrity m948 = false := rfl
def m952 : Model := ⟨[r0,r1],[c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m952 = [c1] := rfl
example : rejected m952 = [c0] := rfl
example : falseAccepts m952 = [] := rfl
example : integrity m952 = true := rfl
def m956 : Model := ⟨[r0,r1],[c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m956 = [c0,c1] := rfl
example : rejected m956 = [] := rfl
example : falseAccepts m956 = [c0] := rfl
example : integrity m956 = false := rfl
def m960 : Model := ⟨[r0,r1],[c0,c1],[],[]⟩
example : accepted m960 = [] := rfl
example : rejected m960 = [] := rfl
example : falseAccepts m960 = [] := rfl
example : integrity m960 = true := rfl
def m964 : Model := ⟨[r0,r1],[c0,c1],[],[(c0.before,c0.after)]⟩
example : accepted m964 = [] := rfl
example : rejected m964 = [] := rfl
example : falseAccepts m964 = [] := rfl
example : integrity m964 = true := rfl
def m968 : Model := ⟨[r0,r1],[c0,c1],[],[(c1.before,c1.after)]⟩
example : accepted m968 = [] := rfl
example : rejected m968 = [] := rfl
example : falseAccepts m968 = [] := rfl
example : integrity m968 = true := rfl
def m972 : Model := ⟨[r0,r1],[c0,c1],[],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m972 = [] := rfl
example : rejected m972 = [] := rfl
example : falseAccepts m972 = [] := rfl
example : integrity m972 = true := rfl
def m976 : Model := ⟨[r0,r1],[c0,c1],[c0],[]⟩
example : accepted m976 = [] := rfl
example : rejected m976 = [c0] := rfl
example : falseAccepts m976 = [] := rfl
example : integrity m976 = true := rfl
def m980 : Model := ⟨[r0,r1],[c0,c1],[c0],[(c0.before,c0.after)]⟩
example : accepted m980 = [c0] := rfl
example : rejected m980 = [] := rfl
example : falseAccepts m980 = [] := rfl
example : integrity m980 = true := rfl
def m984 : Model := ⟨[r0,r1],[c0,c1],[c0],[(c1.before,c1.after)]⟩
example : accepted m984 = [] := rfl
example : rejected m984 = [c0] := rfl
example : falseAccepts m984 = [] := rfl
example : integrity m984 = true := rfl
def m988 : Model := ⟨[r0,r1],[c0,c1],[c0],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m988 = [c0] := rfl
example : rejected m988 = [] := rfl
example : falseAccepts m988 = [] := rfl
example : integrity m988 = true := rfl
def m992 : Model := ⟨[r0,r1],[c0,c1],[c1],[]⟩
example : accepted m992 = [] := rfl
example : rejected m992 = [c1] := rfl
example : falseAccepts m992 = [] := rfl
example : integrity m992 = true := rfl
def m996 : Model := ⟨[r0,r1],[c0,c1],[c1],[(c0.before,c0.after)]⟩
example : accepted m996 = [] := rfl
example : rejected m996 = [c1] := rfl
example : falseAccepts m996 = [] := rfl
example : integrity m996 = true := rfl
def m1000 : Model := ⟨[r0,r1],[c0,c1],[c1],[(c1.before,c1.after)]⟩
example : accepted m1000 = [c1] := rfl
example : rejected m1000 = [] := rfl
example : falseAccepts m1000 = [] := rfl
example : integrity m1000 = true := rfl
def m1004 : Model := ⟨[r0,r1],[c0,c1],[c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m1004 = [c1] := rfl
example : rejected m1004 = [] := rfl
example : falseAccepts m1004 = [] := rfl
example : integrity m1004 = true := rfl
def m1008 : Model := ⟨[r0,r1],[c0,c1],[c0,c1],[]⟩
example : accepted m1008 = [] := rfl
example : rejected m1008 = [c0,c1] := rfl
example : falseAccepts m1008 = [] := rfl
example : integrity m1008 = true := rfl
def m1012 : Model := ⟨[r0,r1],[c0,c1],[c0,c1],[(c0.before,c0.after)]⟩
example : accepted m1012 = [c0] := rfl
example : rejected m1012 = [c1] := rfl
example : falseAccepts m1012 = [] := rfl
example : integrity m1012 = true := rfl
def m1016 : Model := ⟨[r0,r1],[c0,c1],[c0,c1],[(c1.before,c1.after)]⟩
example : accepted m1016 = [c1] := rfl
example : rejected m1016 = [c0] := rfl
example : falseAccepts m1016 = [] := rfl
example : integrity m1016 = true := rfl
def m1020 : Model := ⟨[r0,r1],[c0,c1],[c0,c1],[(c0.before,c0.after),(c1.before,c1.after)]⟩
example : accepted m1020 = [c0,c1] := rfl
example : rejected m1020 = [] := rfl
example : falseAccepts m1020 = [] := rfl
example : integrity m1020 = true := rfl
def complete : Model := ⟨[r0,r1],[c0,c1],[c0,c1],[(r0,r1),(r1,r0)]⟩
theorem nativeTrace : Trace complete r0 [c0,c1] r0 :=
  .next _ _ _ _ _ rfl rfl rfl (.next _ _ _ _ _ rfl rfl rfl (.identity _))
theorem nativeAuthorized : ∀ c, c ∈ [c0,c1] → c ∈ complete.allowed :=
  traceAuthorized complete rfl _ _ _ nativeTrace
example : integrity {complete with allowed := [c0]} = false := rfl
example : falseAccepts {complete with allowed := [c0]} = [c1] := rfl
#print axioms nativeTrace
#print axioms nativeAuthorized
