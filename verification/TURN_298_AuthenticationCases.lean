import SFT.Computation.Authentication
open SFT.Computation.Authentication
def cred0 : Credential := ⟨"credential-p","p"⟩
def cred1 : Credential := ⟨"credential-q","q"⟩
def response0 : Response := ⟨"credential-p","challenge-0","response-0"⟩
def response1 : Response := ⟨"credential-q","challenge-1","response-1"⟩
def a0 : Attempt := ⟨"p","p","credential-p","challenge-0","response-0"⟩
def a1 : Attempt := ⟨"q","p","credential-p","challenge-0","response-0"⟩
def m0 : Model := ⟨[],[],[],[],[]⟩
example : accepts m0 a0 = false := rfl
example : accepts m0 a1 = false := rfl
example : impersonations m0 = [] := rfl
example : authentic m0 = true := rfl
def m4 : Model := ⟨[],[],[],[],[a0]⟩
example : accepts m4 a0 = false := rfl
example : accepts m4 a1 = false := rfl
example : impersonations m4 = [] := rfl
example : authentic m4 = true := rfl
def m8 : Model := ⟨[],[],[],[],[a1]⟩
example : accepts m8 a0 = false := rfl
example : accepts m8 a1 = false := rfl
example : impersonations m8 = [] := rfl
example : authentic m8 = true := rfl
def m12 : Model := ⟨[],[],[],[],[a0,a1]⟩
example : accepts m12 a0 = false := rfl
example : accepts m12 a1 = false := rfl
example : impersonations m12 = [] := rfl
example : authentic m12 = true := rfl
def m16 : Model := ⟨[],[],[],[response0],[]⟩
example : accepts m16 a0 = false := rfl
example : accepts m16 a1 = false := rfl
example : impersonations m16 = [] := rfl
example : authentic m16 = true := rfl
def m20 : Model := ⟨[],[],[],[response0],[a0]⟩
example : accepts m20 a0 = false := rfl
example : accepts m20 a1 = false := rfl
example : impersonations m20 = [] := rfl
example : authentic m20 = true := rfl
def m24 : Model := ⟨[],[],[],[response0],[a1]⟩
example : accepts m24 a0 = false := rfl
example : accepts m24 a1 = false := rfl
example : impersonations m24 = [] := rfl
example : authentic m24 = true := rfl
def m28 : Model := ⟨[],[],[],[response0],[a0,a1]⟩
example : accepts m28 a0 = false := rfl
example : accepts m28 a1 = false := rfl
example : impersonations m28 = [] := rfl
example : authentic m28 = true := rfl
def m32 : Model := ⟨[],[],[],[response1],[]⟩
example : accepts m32 a0 = false := rfl
example : accepts m32 a1 = false := rfl
example : impersonations m32 = [] := rfl
example : authentic m32 = true := rfl
def m36 : Model := ⟨[],[],[],[response1],[a0]⟩
example : accepts m36 a0 = false := rfl
example : accepts m36 a1 = false := rfl
example : impersonations m36 = [] := rfl
example : authentic m36 = true := rfl
def m40 : Model := ⟨[],[],[],[response1],[a1]⟩
example : accepts m40 a0 = false := rfl
example : accepts m40 a1 = false := rfl
example : impersonations m40 = [] := rfl
example : authentic m40 = true := rfl
def m44 : Model := ⟨[],[],[],[response1],[a0,a1]⟩
example : accepts m44 a0 = false := rfl
example : accepts m44 a1 = false := rfl
example : impersonations m44 = [] := rfl
example : authentic m44 = true := rfl
def m48 : Model := ⟨[],[],[],[response0,response1],[]⟩
example : accepts m48 a0 = false := rfl
example : accepts m48 a1 = false := rfl
example : impersonations m48 = [] := rfl
example : authentic m48 = true := rfl
def m52 : Model := ⟨[],[],[],[response0,response1],[a0]⟩
example : accepts m52 a0 = false := rfl
example : accepts m52 a1 = false := rfl
example : impersonations m52 = [] := rfl
example : authentic m52 = true := rfl
def m56 : Model := ⟨[],[],[],[response0,response1],[a1]⟩
example : accepts m56 a0 = false := rfl
example : accepts m56 a1 = false := rfl
example : impersonations m56 = [] := rfl
example : authentic m56 = true := rfl
def m60 : Model := ⟨[],[],[],[response0,response1],[a0,a1]⟩
example : accepts m60 a0 = false := rfl
example : accepts m60 a1 = false := rfl
example : impersonations m60 = [] := rfl
example : authentic m60 = true := rfl
def m64 : Model := ⟨[],[],["challenge-0"],[],[]⟩
example : accepts m64 a0 = false := rfl
example : accepts m64 a1 = false := rfl
example : impersonations m64 = [] := rfl
example : authentic m64 = true := rfl
def m68 : Model := ⟨[],[],["challenge-0"],[],[a0]⟩
example : accepts m68 a0 = false := rfl
example : accepts m68 a1 = false := rfl
example : impersonations m68 = [] := rfl
example : authentic m68 = true := rfl
def m72 : Model := ⟨[],[],["challenge-0"],[],[a1]⟩
example : accepts m72 a0 = false := rfl
example : accepts m72 a1 = false := rfl
example : impersonations m72 = [] := rfl
example : authentic m72 = true := rfl
def m76 : Model := ⟨[],[],["challenge-0"],[],[a0,a1]⟩
example : accepts m76 a0 = false := rfl
example : accepts m76 a1 = false := rfl
example : impersonations m76 = [] := rfl
example : authentic m76 = true := rfl
def m80 : Model := ⟨[],[],["challenge-0"],[response0],[]⟩
example : accepts m80 a0 = false := rfl
example : accepts m80 a1 = false := rfl
example : impersonations m80 = [] := rfl
example : authentic m80 = true := rfl
def m84 : Model := ⟨[],[],["challenge-0"],[response0],[a0]⟩
example : accepts m84 a0 = false := rfl
example : accepts m84 a1 = false := rfl
example : impersonations m84 = [] := rfl
example : authentic m84 = true := rfl
def m88 : Model := ⟨[],[],["challenge-0"],[response0],[a1]⟩
example : accepts m88 a0 = false := rfl
example : accepts m88 a1 = false := rfl
example : impersonations m88 = [] := rfl
example : authentic m88 = true := rfl
def m92 : Model := ⟨[],[],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m92 a0 = false := rfl
example : accepts m92 a1 = false := rfl
example : impersonations m92 = [] := rfl
example : authentic m92 = true := rfl
def m96 : Model := ⟨[],[],["challenge-0"],[response1],[]⟩
example : accepts m96 a0 = false := rfl
example : accepts m96 a1 = false := rfl
example : impersonations m96 = [] := rfl
example : authentic m96 = true := rfl
def m100 : Model := ⟨[],[],["challenge-0"],[response1],[a0]⟩
example : accepts m100 a0 = false := rfl
example : accepts m100 a1 = false := rfl
example : impersonations m100 = [] := rfl
example : authentic m100 = true := rfl
def m104 : Model := ⟨[],[],["challenge-0"],[response1],[a1]⟩
example : accepts m104 a0 = false := rfl
example : accepts m104 a1 = false := rfl
example : impersonations m104 = [] := rfl
example : authentic m104 = true := rfl
def m108 : Model := ⟨[],[],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m108 a0 = false := rfl
example : accepts m108 a1 = false := rfl
example : impersonations m108 = [] := rfl
example : authentic m108 = true := rfl
def m112 : Model := ⟨[],[],["challenge-0"],[response0,response1],[]⟩
example : accepts m112 a0 = false := rfl
example : accepts m112 a1 = false := rfl
example : impersonations m112 = [] := rfl
example : authentic m112 = true := rfl
def m116 : Model := ⟨[],[],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m116 a0 = false := rfl
example : accepts m116 a1 = false := rfl
example : impersonations m116 = [] := rfl
example : authentic m116 = true := rfl
def m120 : Model := ⟨[],[],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m120 a0 = false := rfl
example : accepts m120 a1 = false := rfl
example : impersonations m120 = [] := rfl
example : authentic m120 = true := rfl
def m124 : Model := ⟨[],[],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m124 a0 = false := rfl
example : accepts m124 a1 = false := rfl
example : impersonations m124 = [] := rfl
example : authentic m124 = true := rfl
def m128 : Model := ⟨[],[],["challenge-1"],[],[]⟩
example : accepts m128 a0 = false := rfl
example : accepts m128 a1 = false := rfl
example : impersonations m128 = [] := rfl
example : authentic m128 = true := rfl
def m132 : Model := ⟨[],[],["challenge-1"],[],[a0]⟩
example : accepts m132 a0 = false := rfl
example : accepts m132 a1 = false := rfl
example : impersonations m132 = [] := rfl
example : authentic m132 = true := rfl
def m136 : Model := ⟨[],[],["challenge-1"],[],[a1]⟩
example : accepts m136 a0 = false := rfl
example : accepts m136 a1 = false := rfl
example : impersonations m136 = [] := rfl
example : authentic m136 = true := rfl
def m140 : Model := ⟨[],[],["challenge-1"],[],[a0,a1]⟩
example : accepts m140 a0 = false := rfl
example : accepts m140 a1 = false := rfl
example : impersonations m140 = [] := rfl
example : authentic m140 = true := rfl
def m144 : Model := ⟨[],[],["challenge-1"],[response0],[]⟩
example : accepts m144 a0 = false := rfl
example : accepts m144 a1 = false := rfl
example : impersonations m144 = [] := rfl
example : authentic m144 = true := rfl
def m148 : Model := ⟨[],[],["challenge-1"],[response0],[a0]⟩
example : accepts m148 a0 = false := rfl
example : accepts m148 a1 = false := rfl
example : impersonations m148 = [] := rfl
example : authentic m148 = true := rfl
def m152 : Model := ⟨[],[],["challenge-1"],[response0],[a1]⟩
example : accepts m152 a0 = false := rfl
example : accepts m152 a1 = false := rfl
example : impersonations m152 = [] := rfl
example : authentic m152 = true := rfl
def m156 : Model := ⟨[],[],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m156 a0 = false := rfl
example : accepts m156 a1 = false := rfl
example : impersonations m156 = [] := rfl
example : authentic m156 = true := rfl
def m160 : Model := ⟨[],[],["challenge-1"],[response1],[]⟩
example : accepts m160 a0 = false := rfl
example : accepts m160 a1 = false := rfl
example : impersonations m160 = [] := rfl
example : authentic m160 = true := rfl
def m164 : Model := ⟨[],[],["challenge-1"],[response1],[a0]⟩
example : accepts m164 a0 = false := rfl
example : accepts m164 a1 = false := rfl
example : impersonations m164 = [] := rfl
example : authentic m164 = true := rfl
def m168 : Model := ⟨[],[],["challenge-1"],[response1],[a1]⟩
example : accepts m168 a0 = false := rfl
example : accepts m168 a1 = false := rfl
example : impersonations m168 = [] := rfl
example : authentic m168 = true := rfl
def m172 : Model := ⟨[],[],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m172 a0 = false := rfl
example : accepts m172 a1 = false := rfl
example : impersonations m172 = [] := rfl
example : authentic m172 = true := rfl
def m176 : Model := ⟨[],[],["challenge-1"],[response0,response1],[]⟩
example : accepts m176 a0 = false := rfl
example : accepts m176 a1 = false := rfl
example : impersonations m176 = [] := rfl
example : authentic m176 = true := rfl
def m180 : Model := ⟨[],[],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m180 a0 = false := rfl
example : accepts m180 a1 = false := rfl
example : impersonations m180 = [] := rfl
example : authentic m180 = true := rfl
def m184 : Model := ⟨[],[],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m184 a0 = false := rfl
example : accepts m184 a1 = false := rfl
example : impersonations m184 = [] := rfl
example : authentic m184 = true := rfl
def m188 : Model := ⟨[],[],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m188 a0 = false := rfl
example : accepts m188 a1 = false := rfl
example : impersonations m188 = [] := rfl
example : authentic m188 = true := rfl
def m192 : Model := ⟨[],[],["challenge-0","challenge-1"],[],[]⟩
example : accepts m192 a0 = false := rfl
example : accepts m192 a1 = false := rfl
example : impersonations m192 = [] := rfl
example : authentic m192 = true := rfl
def m196 : Model := ⟨[],[],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m196 a0 = false := rfl
example : accepts m196 a1 = false := rfl
example : impersonations m196 = [] := rfl
example : authentic m196 = true := rfl
def m200 : Model := ⟨[],[],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m200 a0 = false := rfl
example : accepts m200 a1 = false := rfl
example : impersonations m200 = [] := rfl
example : authentic m200 = true := rfl
def m204 : Model := ⟨[],[],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m204 a0 = false := rfl
example : accepts m204 a1 = false := rfl
example : impersonations m204 = [] := rfl
example : authentic m204 = true := rfl
def m208 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m208 a0 = false := rfl
example : accepts m208 a1 = false := rfl
example : impersonations m208 = [] := rfl
example : authentic m208 = true := rfl
def m212 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m212 a0 = false := rfl
example : accepts m212 a1 = false := rfl
example : impersonations m212 = [] := rfl
example : authentic m212 = true := rfl
def m216 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m216 a0 = false := rfl
example : accepts m216 a1 = false := rfl
example : impersonations m216 = [] := rfl
example : authentic m216 = true := rfl
def m220 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m220 a0 = false := rfl
example : accepts m220 a1 = false := rfl
example : impersonations m220 = [] := rfl
example : authentic m220 = true := rfl
def m224 : Model := ⟨[],[],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m224 a0 = false := rfl
example : accepts m224 a1 = false := rfl
example : impersonations m224 = [] := rfl
example : authentic m224 = true := rfl
def m228 : Model := ⟨[],[],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m228 a0 = false := rfl
example : accepts m228 a1 = false := rfl
example : impersonations m228 = [] := rfl
example : authentic m228 = true := rfl
def m232 : Model := ⟨[],[],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m232 a0 = false := rfl
example : accepts m232 a1 = false := rfl
example : impersonations m232 = [] := rfl
example : authentic m232 = true := rfl
def m236 : Model := ⟨[],[],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m236 a0 = false := rfl
example : accepts m236 a1 = false := rfl
example : impersonations m236 = [] := rfl
example : authentic m236 = true := rfl
def m240 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m240 a0 = false := rfl
example : accepts m240 a1 = false := rfl
example : impersonations m240 = [] := rfl
example : authentic m240 = true := rfl
def m244 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m244 a0 = false := rfl
example : accepts m244 a1 = false := rfl
example : impersonations m244 = [] := rfl
example : authentic m244 = true := rfl
def m248 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m248 a0 = false := rfl
example : accepts m248 a1 = false := rfl
example : impersonations m248 = [] := rfl
example : authentic m248 = true := rfl
def m252 : Model := ⟨[],[],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m252 a0 = false := rfl
example : accepts m252 a1 = false := rfl
example : impersonations m252 = [] := rfl
example : authentic m252 = true := rfl
def m256 : Model := ⟨[],[cred0],[],[],[]⟩
example : accepts m256 a0 = false := rfl
example : accepts m256 a1 = false := rfl
example : impersonations m256 = [] := rfl
example : authentic m256 = true := rfl
def m260 : Model := ⟨[],[cred0],[],[],[a0]⟩
example : accepts m260 a0 = false := rfl
example : accepts m260 a1 = false := rfl
example : impersonations m260 = [] := rfl
example : authentic m260 = true := rfl
def m264 : Model := ⟨[],[cred0],[],[],[a1]⟩
example : accepts m264 a0 = false := rfl
example : accepts m264 a1 = false := rfl
example : impersonations m264 = [] := rfl
example : authentic m264 = true := rfl
def m268 : Model := ⟨[],[cred0],[],[],[a0,a1]⟩
example : accepts m268 a0 = false := rfl
example : accepts m268 a1 = false := rfl
example : impersonations m268 = [] := rfl
example : authentic m268 = true := rfl
def m272 : Model := ⟨[],[cred0],[],[response0],[]⟩
example : accepts m272 a0 = false := rfl
example : accepts m272 a1 = false := rfl
example : impersonations m272 = [] := rfl
example : authentic m272 = true := rfl
def m276 : Model := ⟨[],[cred0],[],[response0],[a0]⟩
example : accepts m276 a0 = false := rfl
example : accepts m276 a1 = false := rfl
example : impersonations m276 = [] := rfl
example : authentic m276 = true := rfl
def m280 : Model := ⟨[],[cred0],[],[response0],[a1]⟩
example : accepts m280 a0 = false := rfl
example : accepts m280 a1 = false := rfl
example : impersonations m280 = [] := rfl
example : authentic m280 = true := rfl
def m284 : Model := ⟨[],[cred0],[],[response0],[a0,a1]⟩
example : accepts m284 a0 = false := rfl
example : accepts m284 a1 = false := rfl
example : impersonations m284 = [] := rfl
example : authentic m284 = true := rfl
def m288 : Model := ⟨[],[cred0],[],[response1],[]⟩
example : accepts m288 a0 = false := rfl
example : accepts m288 a1 = false := rfl
example : impersonations m288 = [] := rfl
example : authentic m288 = true := rfl
def m292 : Model := ⟨[],[cred0],[],[response1],[a0]⟩
example : accepts m292 a0 = false := rfl
example : accepts m292 a1 = false := rfl
example : impersonations m292 = [] := rfl
example : authentic m292 = true := rfl
def m296 : Model := ⟨[],[cred0],[],[response1],[a1]⟩
example : accepts m296 a0 = false := rfl
example : accepts m296 a1 = false := rfl
example : impersonations m296 = [] := rfl
example : authentic m296 = true := rfl
def m300 : Model := ⟨[],[cred0],[],[response1],[a0,a1]⟩
example : accepts m300 a0 = false := rfl
example : accepts m300 a1 = false := rfl
example : impersonations m300 = [] := rfl
example : authentic m300 = true := rfl
def m304 : Model := ⟨[],[cred0],[],[response0,response1],[]⟩
example : accepts m304 a0 = false := rfl
example : accepts m304 a1 = false := rfl
example : impersonations m304 = [] := rfl
example : authentic m304 = true := rfl
def m308 : Model := ⟨[],[cred0],[],[response0,response1],[a0]⟩
example : accepts m308 a0 = false := rfl
example : accepts m308 a1 = false := rfl
example : impersonations m308 = [] := rfl
example : authentic m308 = true := rfl
def m312 : Model := ⟨[],[cred0],[],[response0,response1],[a1]⟩
example : accepts m312 a0 = false := rfl
example : accepts m312 a1 = false := rfl
example : impersonations m312 = [] := rfl
example : authentic m312 = true := rfl
def m316 : Model := ⟨[],[cred0],[],[response0,response1],[a0,a1]⟩
example : accepts m316 a0 = false := rfl
example : accepts m316 a1 = false := rfl
example : impersonations m316 = [] := rfl
example : authentic m316 = true := rfl
def m320 : Model := ⟨[],[cred0],["challenge-0"],[],[]⟩
example : accepts m320 a0 = false := rfl
example : accepts m320 a1 = false := rfl
example : impersonations m320 = [] := rfl
example : authentic m320 = true := rfl
def m324 : Model := ⟨[],[cred0],["challenge-0"],[],[a0]⟩
example : accepts m324 a0 = false := rfl
example : accepts m324 a1 = false := rfl
example : impersonations m324 = [] := rfl
example : authentic m324 = true := rfl
def m328 : Model := ⟨[],[cred0],["challenge-0"],[],[a1]⟩
example : accepts m328 a0 = false := rfl
example : accepts m328 a1 = false := rfl
example : impersonations m328 = [] := rfl
example : authentic m328 = true := rfl
def m332 : Model := ⟨[],[cred0],["challenge-0"],[],[a0,a1]⟩
example : accepts m332 a0 = false := rfl
example : accepts m332 a1 = false := rfl
example : impersonations m332 = [] := rfl
example : authentic m332 = true := rfl
def m336 : Model := ⟨[],[cred0],["challenge-0"],[response0],[]⟩
example : accepts m336 a0 = false := rfl
example : accepts m336 a1 = false := rfl
example : impersonations m336 = [] := rfl
example : authentic m336 = true := rfl
def m340 : Model := ⟨[],[cred0],["challenge-0"],[response0],[a0]⟩
example : accepts m340 a0 = false := rfl
example : accepts m340 a1 = false := rfl
example : impersonations m340 = [] := rfl
example : authentic m340 = true := rfl
def m344 : Model := ⟨[],[cred0],["challenge-0"],[response0],[a1]⟩
example : accepts m344 a0 = false := rfl
example : accepts m344 a1 = false := rfl
example : impersonations m344 = [] := rfl
example : authentic m344 = true := rfl
def m348 : Model := ⟨[],[cred0],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m348 a0 = false := rfl
example : accepts m348 a1 = false := rfl
example : impersonations m348 = [] := rfl
example : authentic m348 = true := rfl
def m352 : Model := ⟨[],[cred0],["challenge-0"],[response1],[]⟩
example : accepts m352 a0 = false := rfl
example : accepts m352 a1 = false := rfl
example : impersonations m352 = [] := rfl
example : authentic m352 = true := rfl
def m356 : Model := ⟨[],[cred0],["challenge-0"],[response1],[a0]⟩
example : accepts m356 a0 = false := rfl
example : accepts m356 a1 = false := rfl
example : impersonations m356 = [] := rfl
example : authentic m356 = true := rfl
def m360 : Model := ⟨[],[cred0],["challenge-0"],[response1],[a1]⟩
example : accepts m360 a0 = false := rfl
example : accepts m360 a1 = false := rfl
example : impersonations m360 = [] := rfl
example : authentic m360 = true := rfl
def m364 : Model := ⟨[],[cred0],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m364 a0 = false := rfl
example : accepts m364 a1 = false := rfl
example : impersonations m364 = [] := rfl
example : authentic m364 = true := rfl
def m368 : Model := ⟨[],[cred0],["challenge-0"],[response0,response1],[]⟩
example : accepts m368 a0 = false := rfl
example : accepts m368 a1 = false := rfl
example : impersonations m368 = [] := rfl
example : authentic m368 = true := rfl
def m372 : Model := ⟨[],[cred0],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m372 a0 = false := rfl
example : accepts m372 a1 = false := rfl
example : impersonations m372 = [] := rfl
example : authentic m372 = true := rfl
def m376 : Model := ⟨[],[cred0],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m376 a0 = false := rfl
example : accepts m376 a1 = false := rfl
example : impersonations m376 = [] := rfl
example : authentic m376 = true := rfl
def m380 : Model := ⟨[],[cred0],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m380 a0 = false := rfl
example : accepts m380 a1 = false := rfl
example : impersonations m380 = [] := rfl
example : authentic m380 = true := rfl
def m384 : Model := ⟨[],[cred0],["challenge-1"],[],[]⟩
example : accepts m384 a0 = false := rfl
example : accepts m384 a1 = false := rfl
example : impersonations m384 = [] := rfl
example : authentic m384 = true := rfl
def m388 : Model := ⟨[],[cred0],["challenge-1"],[],[a0]⟩
example : accepts m388 a0 = false := rfl
example : accepts m388 a1 = false := rfl
example : impersonations m388 = [] := rfl
example : authentic m388 = true := rfl
def m392 : Model := ⟨[],[cred0],["challenge-1"],[],[a1]⟩
example : accepts m392 a0 = false := rfl
example : accepts m392 a1 = false := rfl
example : impersonations m392 = [] := rfl
example : authentic m392 = true := rfl
def m396 : Model := ⟨[],[cred0],["challenge-1"],[],[a0,a1]⟩
example : accepts m396 a0 = false := rfl
example : accepts m396 a1 = false := rfl
example : impersonations m396 = [] := rfl
example : authentic m396 = true := rfl
def m400 : Model := ⟨[],[cred0],["challenge-1"],[response0],[]⟩
example : accepts m400 a0 = false := rfl
example : accepts m400 a1 = false := rfl
example : impersonations m400 = [] := rfl
example : authentic m400 = true := rfl
def m404 : Model := ⟨[],[cred0],["challenge-1"],[response0],[a0]⟩
example : accepts m404 a0 = false := rfl
example : accepts m404 a1 = false := rfl
example : impersonations m404 = [] := rfl
example : authentic m404 = true := rfl
def m408 : Model := ⟨[],[cred0],["challenge-1"],[response0],[a1]⟩
example : accepts m408 a0 = false := rfl
example : accepts m408 a1 = false := rfl
example : impersonations m408 = [] := rfl
example : authentic m408 = true := rfl
def m412 : Model := ⟨[],[cred0],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m412 a0 = false := rfl
example : accepts m412 a1 = false := rfl
example : impersonations m412 = [] := rfl
example : authentic m412 = true := rfl
def m416 : Model := ⟨[],[cred0],["challenge-1"],[response1],[]⟩
example : accepts m416 a0 = false := rfl
example : accepts m416 a1 = false := rfl
example : impersonations m416 = [] := rfl
example : authentic m416 = true := rfl
def m420 : Model := ⟨[],[cred0],["challenge-1"],[response1],[a0]⟩
example : accepts m420 a0 = false := rfl
example : accepts m420 a1 = false := rfl
example : impersonations m420 = [] := rfl
example : authentic m420 = true := rfl
def m424 : Model := ⟨[],[cred0],["challenge-1"],[response1],[a1]⟩
example : accepts m424 a0 = false := rfl
example : accepts m424 a1 = false := rfl
example : impersonations m424 = [] := rfl
example : authentic m424 = true := rfl
def m428 : Model := ⟨[],[cred0],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m428 a0 = false := rfl
example : accepts m428 a1 = false := rfl
example : impersonations m428 = [] := rfl
example : authentic m428 = true := rfl
def m432 : Model := ⟨[],[cred0],["challenge-1"],[response0,response1],[]⟩
example : accepts m432 a0 = false := rfl
example : accepts m432 a1 = false := rfl
example : impersonations m432 = [] := rfl
example : authentic m432 = true := rfl
def m436 : Model := ⟨[],[cred0],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m436 a0 = false := rfl
example : accepts m436 a1 = false := rfl
example : impersonations m436 = [] := rfl
example : authentic m436 = true := rfl
def m440 : Model := ⟨[],[cred0],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m440 a0 = false := rfl
example : accepts m440 a1 = false := rfl
example : impersonations m440 = [] := rfl
example : authentic m440 = true := rfl
def m444 : Model := ⟨[],[cred0],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m444 a0 = false := rfl
example : accepts m444 a1 = false := rfl
example : impersonations m444 = [] := rfl
example : authentic m444 = true := rfl
def m448 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[],[]⟩
example : accepts m448 a0 = false := rfl
example : accepts m448 a1 = false := rfl
example : impersonations m448 = [] := rfl
example : authentic m448 = true := rfl
def m452 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m452 a0 = false := rfl
example : accepts m452 a1 = false := rfl
example : impersonations m452 = [] := rfl
example : authentic m452 = true := rfl
def m456 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m456 a0 = false := rfl
example : accepts m456 a1 = false := rfl
example : impersonations m456 = [] := rfl
example : authentic m456 = true := rfl
def m460 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m460 a0 = false := rfl
example : accepts m460 a1 = false := rfl
example : impersonations m460 = [] := rfl
example : authentic m460 = true := rfl
def m464 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m464 a0 = false := rfl
example : accepts m464 a1 = false := rfl
example : impersonations m464 = [] := rfl
example : authentic m464 = true := rfl
def m468 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m468 a0 = false := rfl
example : accepts m468 a1 = false := rfl
example : impersonations m468 = [] := rfl
example : authentic m468 = true := rfl
def m472 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m472 a0 = false := rfl
example : accepts m472 a1 = false := rfl
example : impersonations m472 = [] := rfl
example : authentic m472 = true := rfl
def m476 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m476 a0 = false := rfl
example : accepts m476 a1 = false := rfl
example : impersonations m476 = [] := rfl
example : authentic m476 = true := rfl
def m480 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m480 a0 = false := rfl
example : accepts m480 a1 = false := rfl
example : impersonations m480 = [] := rfl
example : authentic m480 = true := rfl
def m484 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m484 a0 = false := rfl
example : accepts m484 a1 = false := rfl
example : impersonations m484 = [] := rfl
example : authentic m484 = true := rfl
def m488 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m488 a0 = false := rfl
example : accepts m488 a1 = false := rfl
example : impersonations m488 = [] := rfl
example : authentic m488 = true := rfl
def m492 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m492 a0 = false := rfl
example : accepts m492 a1 = false := rfl
example : impersonations m492 = [] := rfl
example : authentic m492 = true := rfl
def m496 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m496 a0 = false := rfl
example : accepts m496 a1 = false := rfl
example : impersonations m496 = [] := rfl
example : authentic m496 = true := rfl
def m500 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m500 a0 = false := rfl
example : accepts m500 a1 = false := rfl
example : impersonations m500 = [] := rfl
example : authentic m500 = true := rfl
def m504 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m504 a0 = false := rfl
example : accepts m504 a1 = false := rfl
example : impersonations m504 = [] := rfl
example : authentic m504 = true := rfl
def m508 : Model := ⟨[],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m508 a0 = false := rfl
example : accepts m508 a1 = false := rfl
example : impersonations m508 = [] := rfl
example : authentic m508 = true := rfl
def m512 : Model := ⟨[],[cred1],[],[],[]⟩
example : accepts m512 a0 = false := rfl
example : accepts m512 a1 = false := rfl
example : impersonations m512 = [] := rfl
example : authentic m512 = true := rfl
def m516 : Model := ⟨[],[cred1],[],[],[a0]⟩
example : accepts m516 a0 = false := rfl
example : accepts m516 a1 = false := rfl
example : impersonations m516 = [] := rfl
example : authentic m516 = true := rfl
def m520 : Model := ⟨[],[cred1],[],[],[a1]⟩
example : accepts m520 a0 = false := rfl
example : accepts m520 a1 = false := rfl
example : impersonations m520 = [] := rfl
example : authentic m520 = true := rfl
def m524 : Model := ⟨[],[cred1],[],[],[a0,a1]⟩
example : accepts m524 a0 = false := rfl
example : accepts m524 a1 = false := rfl
example : impersonations m524 = [] := rfl
example : authentic m524 = true := rfl
def m528 : Model := ⟨[],[cred1],[],[response0],[]⟩
example : accepts m528 a0 = false := rfl
example : accepts m528 a1 = false := rfl
example : impersonations m528 = [] := rfl
example : authentic m528 = true := rfl
def m532 : Model := ⟨[],[cred1],[],[response0],[a0]⟩
example : accepts m532 a0 = false := rfl
example : accepts m532 a1 = false := rfl
example : impersonations m532 = [] := rfl
example : authentic m532 = true := rfl
def m536 : Model := ⟨[],[cred1],[],[response0],[a1]⟩
example : accepts m536 a0 = false := rfl
example : accepts m536 a1 = false := rfl
example : impersonations m536 = [] := rfl
example : authentic m536 = true := rfl
def m540 : Model := ⟨[],[cred1],[],[response0],[a0,a1]⟩
example : accepts m540 a0 = false := rfl
example : accepts m540 a1 = false := rfl
example : impersonations m540 = [] := rfl
example : authentic m540 = true := rfl
def m544 : Model := ⟨[],[cred1],[],[response1],[]⟩
example : accepts m544 a0 = false := rfl
example : accepts m544 a1 = false := rfl
example : impersonations m544 = [] := rfl
example : authentic m544 = true := rfl
def m548 : Model := ⟨[],[cred1],[],[response1],[a0]⟩
example : accepts m548 a0 = false := rfl
example : accepts m548 a1 = false := rfl
example : impersonations m548 = [] := rfl
example : authentic m548 = true := rfl
def m552 : Model := ⟨[],[cred1],[],[response1],[a1]⟩
example : accepts m552 a0 = false := rfl
example : accepts m552 a1 = false := rfl
example : impersonations m552 = [] := rfl
example : authentic m552 = true := rfl
def m556 : Model := ⟨[],[cred1],[],[response1],[a0,a1]⟩
example : accepts m556 a0 = false := rfl
example : accepts m556 a1 = false := rfl
example : impersonations m556 = [] := rfl
example : authentic m556 = true := rfl
def m560 : Model := ⟨[],[cred1],[],[response0,response1],[]⟩
example : accepts m560 a0 = false := rfl
example : accepts m560 a1 = false := rfl
example : impersonations m560 = [] := rfl
example : authentic m560 = true := rfl
def m564 : Model := ⟨[],[cred1],[],[response0,response1],[a0]⟩
example : accepts m564 a0 = false := rfl
example : accepts m564 a1 = false := rfl
example : impersonations m564 = [] := rfl
example : authentic m564 = true := rfl
def m568 : Model := ⟨[],[cred1],[],[response0,response1],[a1]⟩
example : accepts m568 a0 = false := rfl
example : accepts m568 a1 = false := rfl
example : impersonations m568 = [] := rfl
example : authentic m568 = true := rfl
def m572 : Model := ⟨[],[cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m572 a0 = false := rfl
example : accepts m572 a1 = false := rfl
example : impersonations m572 = [] := rfl
example : authentic m572 = true := rfl
def m576 : Model := ⟨[],[cred1],["challenge-0"],[],[]⟩
example : accepts m576 a0 = false := rfl
example : accepts m576 a1 = false := rfl
example : impersonations m576 = [] := rfl
example : authentic m576 = true := rfl
def m580 : Model := ⟨[],[cred1],["challenge-0"],[],[a0]⟩
example : accepts m580 a0 = false := rfl
example : accepts m580 a1 = false := rfl
example : impersonations m580 = [] := rfl
example : authentic m580 = true := rfl
def m584 : Model := ⟨[],[cred1],["challenge-0"],[],[a1]⟩
example : accepts m584 a0 = false := rfl
example : accepts m584 a1 = false := rfl
example : impersonations m584 = [] := rfl
example : authentic m584 = true := rfl
def m588 : Model := ⟨[],[cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m588 a0 = false := rfl
example : accepts m588 a1 = false := rfl
example : impersonations m588 = [] := rfl
example : authentic m588 = true := rfl
def m592 : Model := ⟨[],[cred1],["challenge-0"],[response0],[]⟩
example : accepts m592 a0 = false := rfl
example : accepts m592 a1 = false := rfl
example : impersonations m592 = [] := rfl
example : authentic m592 = true := rfl
def m596 : Model := ⟨[],[cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m596 a0 = false := rfl
example : accepts m596 a1 = false := rfl
example : impersonations m596 = [] := rfl
example : authentic m596 = true := rfl
def m600 : Model := ⟨[],[cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m600 a0 = false := rfl
example : accepts m600 a1 = false := rfl
example : impersonations m600 = [] := rfl
example : authentic m600 = true := rfl
def m604 : Model := ⟨[],[cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m604 a0 = false := rfl
example : accepts m604 a1 = false := rfl
example : impersonations m604 = [] := rfl
example : authentic m604 = true := rfl
def m608 : Model := ⟨[],[cred1],["challenge-0"],[response1],[]⟩
example : accepts m608 a0 = false := rfl
example : accepts m608 a1 = false := rfl
example : impersonations m608 = [] := rfl
example : authentic m608 = true := rfl
def m612 : Model := ⟨[],[cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m612 a0 = false := rfl
example : accepts m612 a1 = false := rfl
example : impersonations m612 = [] := rfl
example : authentic m612 = true := rfl
def m616 : Model := ⟨[],[cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m616 a0 = false := rfl
example : accepts m616 a1 = false := rfl
example : impersonations m616 = [] := rfl
example : authentic m616 = true := rfl
def m620 : Model := ⟨[],[cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m620 a0 = false := rfl
example : accepts m620 a1 = false := rfl
example : impersonations m620 = [] := rfl
example : authentic m620 = true := rfl
def m624 : Model := ⟨[],[cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m624 a0 = false := rfl
example : accepts m624 a1 = false := rfl
example : impersonations m624 = [] := rfl
example : authentic m624 = true := rfl
def m628 : Model := ⟨[],[cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m628 a0 = false := rfl
example : accepts m628 a1 = false := rfl
example : impersonations m628 = [] := rfl
example : authentic m628 = true := rfl
def m632 : Model := ⟨[],[cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m632 a0 = false := rfl
example : accepts m632 a1 = false := rfl
example : impersonations m632 = [] := rfl
example : authentic m632 = true := rfl
def m636 : Model := ⟨[],[cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m636 a0 = false := rfl
example : accepts m636 a1 = false := rfl
example : impersonations m636 = [] := rfl
example : authentic m636 = true := rfl
def m640 : Model := ⟨[],[cred1],["challenge-1"],[],[]⟩
example : accepts m640 a0 = false := rfl
example : accepts m640 a1 = false := rfl
example : impersonations m640 = [] := rfl
example : authentic m640 = true := rfl
def m644 : Model := ⟨[],[cred1],["challenge-1"],[],[a0]⟩
example : accepts m644 a0 = false := rfl
example : accepts m644 a1 = false := rfl
example : impersonations m644 = [] := rfl
example : authentic m644 = true := rfl
def m648 : Model := ⟨[],[cred1],["challenge-1"],[],[a1]⟩
example : accepts m648 a0 = false := rfl
example : accepts m648 a1 = false := rfl
example : impersonations m648 = [] := rfl
example : authentic m648 = true := rfl
def m652 : Model := ⟨[],[cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m652 a0 = false := rfl
example : accepts m652 a1 = false := rfl
example : impersonations m652 = [] := rfl
example : authentic m652 = true := rfl
def m656 : Model := ⟨[],[cred1],["challenge-1"],[response0],[]⟩
example : accepts m656 a0 = false := rfl
example : accepts m656 a1 = false := rfl
example : impersonations m656 = [] := rfl
example : authentic m656 = true := rfl
def m660 : Model := ⟨[],[cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m660 a0 = false := rfl
example : accepts m660 a1 = false := rfl
example : impersonations m660 = [] := rfl
example : authentic m660 = true := rfl
def m664 : Model := ⟨[],[cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m664 a0 = false := rfl
example : accepts m664 a1 = false := rfl
example : impersonations m664 = [] := rfl
example : authentic m664 = true := rfl
def m668 : Model := ⟨[],[cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m668 a0 = false := rfl
example : accepts m668 a1 = false := rfl
example : impersonations m668 = [] := rfl
example : authentic m668 = true := rfl
def m672 : Model := ⟨[],[cred1],["challenge-1"],[response1],[]⟩
example : accepts m672 a0 = false := rfl
example : accepts m672 a1 = false := rfl
example : impersonations m672 = [] := rfl
example : authentic m672 = true := rfl
def m676 : Model := ⟨[],[cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m676 a0 = false := rfl
example : accepts m676 a1 = false := rfl
example : impersonations m676 = [] := rfl
example : authentic m676 = true := rfl
def m680 : Model := ⟨[],[cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m680 a0 = false := rfl
example : accepts m680 a1 = false := rfl
example : impersonations m680 = [] := rfl
example : authentic m680 = true := rfl
def m684 : Model := ⟨[],[cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m684 a0 = false := rfl
example : accepts m684 a1 = false := rfl
example : impersonations m684 = [] := rfl
example : authentic m684 = true := rfl
def m688 : Model := ⟨[],[cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m688 a0 = false := rfl
example : accepts m688 a1 = false := rfl
example : impersonations m688 = [] := rfl
example : authentic m688 = true := rfl
def m692 : Model := ⟨[],[cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m692 a0 = false := rfl
example : accepts m692 a1 = false := rfl
example : impersonations m692 = [] := rfl
example : authentic m692 = true := rfl
def m696 : Model := ⟨[],[cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m696 a0 = false := rfl
example : accepts m696 a1 = false := rfl
example : impersonations m696 = [] := rfl
example : authentic m696 = true := rfl
def m700 : Model := ⟨[],[cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m700 a0 = false := rfl
example : accepts m700 a1 = false := rfl
example : impersonations m700 = [] := rfl
example : authentic m700 = true := rfl
def m704 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m704 a0 = false := rfl
example : accepts m704 a1 = false := rfl
example : impersonations m704 = [] := rfl
example : authentic m704 = true := rfl
def m708 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m708 a0 = false := rfl
example : accepts m708 a1 = false := rfl
example : impersonations m708 = [] := rfl
example : authentic m708 = true := rfl
def m712 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m712 a0 = false := rfl
example : accepts m712 a1 = false := rfl
example : impersonations m712 = [] := rfl
example : authentic m712 = true := rfl
def m716 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m716 a0 = false := rfl
example : accepts m716 a1 = false := rfl
example : impersonations m716 = [] := rfl
example : authentic m716 = true := rfl
def m720 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m720 a0 = false := rfl
example : accepts m720 a1 = false := rfl
example : impersonations m720 = [] := rfl
example : authentic m720 = true := rfl
def m724 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m724 a0 = false := rfl
example : accepts m724 a1 = false := rfl
example : impersonations m724 = [] := rfl
example : authentic m724 = true := rfl
def m728 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m728 a0 = false := rfl
example : accepts m728 a1 = false := rfl
example : impersonations m728 = [] := rfl
example : authentic m728 = true := rfl
def m732 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m732 a0 = false := rfl
example : accepts m732 a1 = false := rfl
example : impersonations m732 = [] := rfl
example : authentic m732 = true := rfl
def m736 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m736 a0 = false := rfl
example : accepts m736 a1 = false := rfl
example : impersonations m736 = [] := rfl
example : authentic m736 = true := rfl
def m740 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m740 a0 = false := rfl
example : accepts m740 a1 = false := rfl
example : impersonations m740 = [] := rfl
example : authentic m740 = true := rfl
def m744 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m744 a0 = false := rfl
example : accepts m744 a1 = false := rfl
example : impersonations m744 = [] := rfl
example : authentic m744 = true := rfl
def m748 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m748 a0 = false := rfl
example : accepts m748 a1 = false := rfl
example : impersonations m748 = [] := rfl
example : authentic m748 = true := rfl
def m752 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m752 a0 = false := rfl
example : accepts m752 a1 = false := rfl
example : impersonations m752 = [] := rfl
example : authentic m752 = true := rfl
def m756 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m756 a0 = false := rfl
example : accepts m756 a1 = false := rfl
example : impersonations m756 = [] := rfl
example : authentic m756 = true := rfl
def m760 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m760 a0 = false := rfl
example : accepts m760 a1 = false := rfl
example : impersonations m760 = [] := rfl
example : authentic m760 = true := rfl
def m764 : Model := ⟨[],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m764 a0 = false := rfl
example : accepts m764 a1 = false := rfl
example : impersonations m764 = [] := rfl
example : authentic m764 = true := rfl
def m768 : Model := ⟨[],[cred0,cred1],[],[],[]⟩
example : accepts m768 a0 = false := rfl
example : accepts m768 a1 = false := rfl
example : impersonations m768 = [] := rfl
example : authentic m768 = true := rfl
def m772 : Model := ⟨[],[cred0,cred1],[],[],[a0]⟩
example : accepts m772 a0 = false := rfl
example : accepts m772 a1 = false := rfl
example : impersonations m772 = [] := rfl
example : authentic m772 = true := rfl
def m776 : Model := ⟨[],[cred0,cred1],[],[],[a1]⟩
example : accepts m776 a0 = false := rfl
example : accepts m776 a1 = false := rfl
example : impersonations m776 = [] := rfl
example : authentic m776 = true := rfl
def m780 : Model := ⟨[],[cred0,cred1],[],[],[a0,a1]⟩
example : accepts m780 a0 = false := rfl
example : accepts m780 a1 = false := rfl
example : impersonations m780 = [] := rfl
example : authentic m780 = true := rfl
def m784 : Model := ⟨[],[cred0,cred1],[],[response0],[]⟩
example : accepts m784 a0 = false := rfl
example : accepts m784 a1 = false := rfl
example : impersonations m784 = [] := rfl
example : authentic m784 = true := rfl
def m788 : Model := ⟨[],[cred0,cred1],[],[response0],[a0]⟩
example : accepts m788 a0 = false := rfl
example : accepts m788 a1 = false := rfl
example : impersonations m788 = [] := rfl
example : authentic m788 = true := rfl
def m792 : Model := ⟨[],[cred0,cred1],[],[response0],[a1]⟩
example : accepts m792 a0 = false := rfl
example : accepts m792 a1 = false := rfl
example : impersonations m792 = [] := rfl
example : authentic m792 = true := rfl
def m796 : Model := ⟨[],[cred0,cred1],[],[response0],[a0,a1]⟩
example : accepts m796 a0 = false := rfl
example : accepts m796 a1 = false := rfl
example : impersonations m796 = [] := rfl
example : authentic m796 = true := rfl
def m800 : Model := ⟨[],[cred0,cred1],[],[response1],[]⟩
example : accepts m800 a0 = false := rfl
example : accepts m800 a1 = false := rfl
example : impersonations m800 = [] := rfl
example : authentic m800 = true := rfl
def m804 : Model := ⟨[],[cred0,cred1],[],[response1],[a0]⟩
example : accepts m804 a0 = false := rfl
example : accepts m804 a1 = false := rfl
example : impersonations m804 = [] := rfl
example : authentic m804 = true := rfl
def m808 : Model := ⟨[],[cred0,cred1],[],[response1],[a1]⟩
example : accepts m808 a0 = false := rfl
example : accepts m808 a1 = false := rfl
example : impersonations m808 = [] := rfl
example : authentic m808 = true := rfl
def m812 : Model := ⟨[],[cred0,cred1],[],[response1],[a0,a1]⟩
example : accepts m812 a0 = false := rfl
example : accepts m812 a1 = false := rfl
example : impersonations m812 = [] := rfl
example : authentic m812 = true := rfl
def m816 : Model := ⟨[],[cred0,cred1],[],[response0,response1],[]⟩
example : accepts m816 a0 = false := rfl
example : accepts m816 a1 = false := rfl
example : impersonations m816 = [] := rfl
example : authentic m816 = true := rfl
def m820 : Model := ⟨[],[cred0,cred1],[],[response0,response1],[a0]⟩
example : accepts m820 a0 = false := rfl
example : accepts m820 a1 = false := rfl
example : impersonations m820 = [] := rfl
example : authentic m820 = true := rfl
def m824 : Model := ⟨[],[cred0,cred1],[],[response0,response1],[a1]⟩
example : accepts m824 a0 = false := rfl
example : accepts m824 a1 = false := rfl
example : impersonations m824 = [] := rfl
example : authentic m824 = true := rfl
def m828 : Model := ⟨[],[cred0,cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m828 a0 = false := rfl
example : accepts m828 a1 = false := rfl
example : impersonations m828 = [] := rfl
example : authentic m828 = true := rfl
def m832 : Model := ⟨[],[cred0,cred1],["challenge-0"],[],[]⟩
example : accepts m832 a0 = false := rfl
example : accepts m832 a1 = false := rfl
example : impersonations m832 = [] := rfl
example : authentic m832 = true := rfl
def m836 : Model := ⟨[],[cred0,cred1],["challenge-0"],[],[a0]⟩
example : accepts m836 a0 = false := rfl
example : accepts m836 a1 = false := rfl
example : impersonations m836 = [] := rfl
example : authentic m836 = true := rfl
def m840 : Model := ⟨[],[cred0,cred1],["challenge-0"],[],[a1]⟩
example : accepts m840 a0 = false := rfl
example : accepts m840 a1 = false := rfl
example : impersonations m840 = [] := rfl
example : authentic m840 = true := rfl
def m844 : Model := ⟨[],[cred0,cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m844 a0 = false := rfl
example : accepts m844 a1 = false := rfl
example : impersonations m844 = [] := rfl
example : authentic m844 = true := rfl
def m848 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0],[]⟩
example : accepts m848 a0 = false := rfl
example : accepts m848 a1 = false := rfl
example : impersonations m848 = [] := rfl
example : authentic m848 = true := rfl
def m852 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m852 a0 = false := rfl
example : accepts m852 a1 = false := rfl
example : impersonations m852 = [] := rfl
example : authentic m852 = true := rfl
def m856 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m856 a0 = false := rfl
example : accepts m856 a1 = false := rfl
example : impersonations m856 = [] := rfl
example : authentic m856 = true := rfl
def m860 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m860 a0 = false := rfl
example : accepts m860 a1 = false := rfl
example : impersonations m860 = [] := rfl
example : authentic m860 = true := rfl
def m864 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response1],[]⟩
example : accepts m864 a0 = false := rfl
example : accepts m864 a1 = false := rfl
example : impersonations m864 = [] := rfl
example : authentic m864 = true := rfl
def m868 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m868 a0 = false := rfl
example : accepts m868 a1 = false := rfl
example : impersonations m868 = [] := rfl
example : authentic m868 = true := rfl
def m872 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m872 a0 = false := rfl
example : accepts m872 a1 = false := rfl
example : impersonations m872 = [] := rfl
example : authentic m872 = true := rfl
def m876 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m876 a0 = false := rfl
example : accepts m876 a1 = false := rfl
example : impersonations m876 = [] := rfl
example : authentic m876 = true := rfl
def m880 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m880 a0 = false := rfl
example : accepts m880 a1 = false := rfl
example : impersonations m880 = [] := rfl
example : authentic m880 = true := rfl
def m884 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m884 a0 = false := rfl
example : accepts m884 a1 = false := rfl
example : impersonations m884 = [] := rfl
example : authentic m884 = true := rfl
def m888 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m888 a0 = false := rfl
example : accepts m888 a1 = false := rfl
example : impersonations m888 = [] := rfl
example : authentic m888 = true := rfl
def m892 : Model := ⟨[],[cred0,cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m892 a0 = false := rfl
example : accepts m892 a1 = false := rfl
example : impersonations m892 = [] := rfl
example : authentic m892 = true := rfl
def m896 : Model := ⟨[],[cred0,cred1],["challenge-1"],[],[]⟩
example : accepts m896 a0 = false := rfl
example : accepts m896 a1 = false := rfl
example : impersonations m896 = [] := rfl
example : authentic m896 = true := rfl
def m900 : Model := ⟨[],[cred0,cred1],["challenge-1"],[],[a0]⟩
example : accepts m900 a0 = false := rfl
example : accepts m900 a1 = false := rfl
example : impersonations m900 = [] := rfl
example : authentic m900 = true := rfl
def m904 : Model := ⟨[],[cred0,cred1],["challenge-1"],[],[a1]⟩
example : accepts m904 a0 = false := rfl
example : accepts m904 a1 = false := rfl
example : impersonations m904 = [] := rfl
example : authentic m904 = true := rfl
def m908 : Model := ⟨[],[cred0,cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m908 a0 = false := rfl
example : accepts m908 a1 = false := rfl
example : impersonations m908 = [] := rfl
example : authentic m908 = true := rfl
def m912 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0],[]⟩
example : accepts m912 a0 = false := rfl
example : accepts m912 a1 = false := rfl
example : impersonations m912 = [] := rfl
example : authentic m912 = true := rfl
def m916 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m916 a0 = false := rfl
example : accepts m916 a1 = false := rfl
example : impersonations m916 = [] := rfl
example : authentic m916 = true := rfl
def m920 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m920 a0 = false := rfl
example : accepts m920 a1 = false := rfl
example : impersonations m920 = [] := rfl
example : authentic m920 = true := rfl
def m924 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m924 a0 = false := rfl
example : accepts m924 a1 = false := rfl
example : impersonations m924 = [] := rfl
example : authentic m924 = true := rfl
def m928 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response1],[]⟩
example : accepts m928 a0 = false := rfl
example : accepts m928 a1 = false := rfl
example : impersonations m928 = [] := rfl
example : authentic m928 = true := rfl
def m932 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m932 a0 = false := rfl
example : accepts m932 a1 = false := rfl
example : impersonations m932 = [] := rfl
example : authentic m932 = true := rfl
def m936 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m936 a0 = false := rfl
example : accepts m936 a1 = false := rfl
example : impersonations m936 = [] := rfl
example : authentic m936 = true := rfl
def m940 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m940 a0 = false := rfl
example : accepts m940 a1 = false := rfl
example : impersonations m940 = [] := rfl
example : authentic m940 = true := rfl
def m944 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m944 a0 = false := rfl
example : accepts m944 a1 = false := rfl
example : impersonations m944 = [] := rfl
example : authentic m944 = true := rfl
def m948 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m948 a0 = false := rfl
example : accepts m948 a1 = false := rfl
example : impersonations m948 = [] := rfl
example : authentic m948 = true := rfl
def m952 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m952 a0 = false := rfl
example : accepts m952 a1 = false := rfl
example : impersonations m952 = [] := rfl
example : authentic m952 = true := rfl
def m956 : Model := ⟨[],[cred0,cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m956 a0 = false := rfl
example : accepts m956 a1 = false := rfl
example : impersonations m956 = [] := rfl
example : authentic m956 = true := rfl
def m960 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m960 a0 = false := rfl
example : accepts m960 a1 = false := rfl
example : impersonations m960 = [] := rfl
example : authentic m960 = true := rfl
def m964 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m964 a0 = false := rfl
example : accepts m964 a1 = false := rfl
example : impersonations m964 = [] := rfl
example : authentic m964 = true := rfl
def m968 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m968 a0 = false := rfl
example : accepts m968 a1 = false := rfl
example : impersonations m968 = [] := rfl
example : authentic m968 = true := rfl
def m972 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m972 a0 = false := rfl
example : accepts m972 a1 = false := rfl
example : impersonations m972 = [] := rfl
example : authentic m972 = true := rfl
def m976 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m976 a0 = false := rfl
example : accepts m976 a1 = false := rfl
example : impersonations m976 = [] := rfl
example : authentic m976 = true := rfl
def m980 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m980 a0 = false := rfl
example : accepts m980 a1 = false := rfl
example : impersonations m980 = [] := rfl
example : authentic m980 = true := rfl
def m984 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m984 a0 = false := rfl
example : accepts m984 a1 = false := rfl
example : impersonations m984 = [] := rfl
example : authentic m984 = true := rfl
def m988 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m988 a0 = false := rfl
example : accepts m988 a1 = false := rfl
example : impersonations m988 = [] := rfl
example : authentic m988 = true := rfl
def m992 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m992 a0 = false := rfl
example : accepts m992 a1 = false := rfl
example : impersonations m992 = [] := rfl
example : authentic m992 = true := rfl
def m996 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m996 a0 = false := rfl
example : accepts m996 a1 = false := rfl
example : impersonations m996 = [] := rfl
example : authentic m996 = true := rfl
def m1000 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m1000 a0 = false := rfl
example : accepts m1000 a1 = false := rfl
example : impersonations m1000 = [] := rfl
example : authentic m1000 = true := rfl
def m1004 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m1004 a0 = false := rfl
example : accepts m1004 a1 = false := rfl
example : impersonations m1004 = [] := rfl
example : authentic m1004 = true := rfl
def m1008 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m1008 a0 = false := rfl
example : accepts m1008 a1 = false := rfl
example : impersonations m1008 = [] := rfl
example : authentic m1008 = true := rfl
def m1012 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m1012 a0 = false := rfl
example : accepts m1012 a1 = false := rfl
example : impersonations m1012 = [] := rfl
example : authentic m1012 = true := rfl
def m1016 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m1016 a0 = false := rfl
example : accepts m1016 a1 = false := rfl
example : impersonations m1016 = [] := rfl
example : authentic m1016 = true := rfl
def m1020 : Model := ⟨[],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1020 a0 = false := rfl
example : accepts m1020 a1 = false := rfl
example : impersonations m1020 = [] := rfl
example : authentic m1020 = true := rfl
def m1024 : Model := ⟨["p"],[],[],[],[]⟩
example : accepts m1024 a0 = false := rfl
example : accepts m1024 a1 = false := rfl
example : impersonations m1024 = [] := rfl
example : authentic m1024 = true := rfl
def m1028 : Model := ⟨["p"],[],[],[],[a0]⟩
example : accepts m1028 a0 = false := rfl
example : accepts m1028 a1 = false := rfl
example : impersonations m1028 = [] := rfl
example : authentic m1028 = true := rfl
def m1032 : Model := ⟨["p"],[],[],[],[a1]⟩
example : accepts m1032 a0 = false := rfl
example : accepts m1032 a1 = false := rfl
example : impersonations m1032 = [] := rfl
example : authentic m1032 = true := rfl
def m1036 : Model := ⟨["p"],[],[],[],[a0,a1]⟩
example : accepts m1036 a0 = false := rfl
example : accepts m1036 a1 = false := rfl
example : impersonations m1036 = [] := rfl
example : authentic m1036 = true := rfl
def m1040 : Model := ⟨["p"],[],[],[response0],[]⟩
example : accepts m1040 a0 = false := rfl
example : accepts m1040 a1 = false := rfl
example : impersonations m1040 = [] := rfl
example : authentic m1040 = true := rfl
def m1044 : Model := ⟨["p"],[],[],[response0],[a0]⟩
example : accepts m1044 a0 = false := rfl
example : accepts m1044 a1 = false := rfl
example : impersonations m1044 = [] := rfl
example : authentic m1044 = true := rfl
def m1048 : Model := ⟨["p"],[],[],[response0],[a1]⟩
example : accepts m1048 a0 = false := rfl
example : accepts m1048 a1 = false := rfl
example : impersonations m1048 = [] := rfl
example : authentic m1048 = true := rfl
def m1052 : Model := ⟨["p"],[],[],[response0],[a0,a1]⟩
example : accepts m1052 a0 = false := rfl
example : accepts m1052 a1 = false := rfl
example : impersonations m1052 = [] := rfl
example : authentic m1052 = true := rfl
def m1056 : Model := ⟨["p"],[],[],[response1],[]⟩
example : accepts m1056 a0 = false := rfl
example : accepts m1056 a1 = false := rfl
example : impersonations m1056 = [] := rfl
example : authentic m1056 = true := rfl
def m1060 : Model := ⟨["p"],[],[],[response1],[a0]⟩
example : accepts m1060 a0 = false := rfl
example : accepts m1060 a1 = false := rfl
example : impersonations m1060 = [] := rfl
example : authentic m1060 = true := rfl
def m1064 : Model := ⟨["p"],[],[],[response1],[a1]⟩
example : accepts m1064 a0 = false := rfl
example : accepts m1064 a1 = false := rfl
example : impersonations m1064 = [] := rfl
example : authentic m1064 = true := rfl
def m1068 : Model := ⟨["p"],[],[],[response1],[a0,a1]⟩
example : accepts m1068 a0 = false := rfl
example : accepts m1068 a1 = false := rfl
example : impersonations m1068 = [] := rfl
example : authentic m1068 = true := rfl
def m1072 : Model := ⟨["p"],[],[],[response0,response1],[]⟩
example : accepts m1072 a0 = false := rfl
example : accepts m1072 a1 = false := rfl
example : impersonations m1072 = [] := rfl
example : authentic m1072 = true := rfl
def m1076 : Model := ⟨["p"],[],[],[response0,response1],[a0]⟩
example : accepts m1076 a0 = false := rfl
example : accepts m1076 a1 = false := rfl
example : impersonations m1076 = [] := rfl
example : authentic m1076 = true := rfl
def m1080 : Model := ⟨["p"],[],[],[response0,response1],[a1]⟩
example : accepts m1080 a0 = false := rfl
example : accepts m1080 a1 = false := rfl
example : impersonations m1080 = [] := rfl
example : authentic m1080 = true := rfl
def m1084 : Model := ⟨["p"],[],[],[response0,response1],[a0,a1]⟩
example : accepts m1084 a0 = false := rfl
example : accepts m1084 a1 = false := rfl
example : impersonations m1084 = [] := rfl
example : authentic m1084 = true := rfl
def m1088 : Model := ⟨["p"],[],["challenge-0"],[],[]⟩
example : accepts m1088 a0 = false := rfl
example : accepts m1088 a1 = false := rfl
example : impersonations m1088 = [] := rfl
example : authentic m1088 = true := rfl
def m1092 : Model := ⟨["p"],[],["challenge-0"],[],[a0]⟩
example : accepts m1092 a0 = false := rfl
example : accepts m1092 a1 = false := rfl
example : impersonations m1092 = [] := rfl
example : authentic m1092 = true := rfl
def m1096 : Model := ⟨["p"],[],["challenge-0"],[],[a1]⟩
example : accepts m1096 a0 = false := rfl
example : accepts m1096 a1 = false := rfl
example : impersonations m1096 = [] := rfl
example : authentic m1096 = true := rfl
def m1100 : Model := ⟨["p"],[],["challenge-0"],[],[a0,a1]⟩
example : accepts m1100 a0 = false := rfl
example : accepts m1100 a1 = false := rfl
example : impersonations m1100 = [] := rfl
example : authentic m1100 = true := rfl
def m1104 : Model := ⟨["p"],[],["challenge-0"],[response0],[]⟩
example : accepts m1104 a0 = false := rfl
example : accepts m1104 a1 = false := rfl
example : impersonations m1104 = [] := rfl
example : authentic m1104 = true := rfl
def m1108 : Model := ⟨["p"],[],["challenge-0"],[response0],[a0]⟩
example : accepts m1108 a0 = false := rfl
example : accepts m1108 a1 = false := rfl
example : impersonations m1108 = [] := rfl
example : authentic m1108 = true := rfl
def m1112 : Model := ⟨["p"],[],["challenge-0"],[response0],[a1]⟩
example : accepts m1112 a0 = false := rfl
example : accepts m1112 a1 = false := rfl
example : impersonations m1112 = [] := rfl
example : authentic m1112 = true := rfl
def m1116 : Model := ⟨["p"],[],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m1116 a0 = false := rfl
example : accepts m1116 a1 = false := rfl
example : impersonations m1116 = [] := rfl
example : authentic m1116 = true := rfl
def m1120 : Model := ⟨["p"],[],["challenge-0"],[response1],[]⟩
example : accepts m1120 a0 = false := rfl
example : accepts m1120 a1 = false := rfl
example : impersonations m1120 = [] := rfl
example : authentic m1120 = true := rfl
def m1124 : Model := ⟨["p"],[],["challenge-0"],[response1],[a0]⟩
example : accepts m1124 a0 = false := rfl
example : accepts m1124 a1 = false := rfl
example : impersonations m1124 = [] := rfl
example : authentic m1124 = true := rfl
def m1128 : Model := ⟨["p"],[],["challenge-0"],[response1],[a1]⟩
example : accepts m1128 a0 = false := rfl
example : accepts m1128 a1 = false := rfl
example : impersonations m1128 = [] := rfl
example : authentic m1128 = true := rfl
def m1132 : Model := ⟨["p"],[],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m1132 a0 = false := rfl
example : accepts m1132 a1 = false := rfl
example : impersonations m1132 = [] := rfl
example : authentic m1132 = true := rfl
def m1136 : Model := ⟨["p"],[],["challenge-0"],[response0,response1],[]⟩
example : accepts m1136 a0 = false := rfl
example : accepts m1136 a1 = false := rfl
example : impersonations m1136 = [] := rfl
example : authentic m1136 = true := rfl
def m1140 : Model := ⟨["p"],[],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m1140 a0 = false := rfl
example : accepts m1140 a1 = false := rfl
example : impersonations m1140 = [] := rfl
example : authentic m1140 = true := rfl
def m1144 : Model := ⟨["p"],[],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m1144 a0 = false := rfl
example : accepts m1144 a1 = false := rfl
example : impersonations m1144 = [] := rfl
example : authentic m1144 = true := rfl
def m1148 : Model := ⟨["p"],[],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m1148 a0 = false := rfl
example : accepts m1148 a1 = false := rfl
example : impersonations m1148 = [] := rfl
example : authentic m1148 = true := rfl
def m1152 : Model := ⟨["p"],[],["challenge-1"],[],[]⟩
example : accepts m1152 a0 = false := rfl
example : accepts m1152 a1 = false := rfl
example : impersonations m1152 = [] := rfl
example : authentic m1152 = true := rfl
def m1156 : Model := ⟨["p"],[],["challenge-1"],[],[a0]⟩
example : accepts m1156 a0 = false := rfl
example : accepts m1156 a1 = false := rfl
example : impersonations m1156 = [] := rfl
example : authentic m1156 = true := rfl
def m1160 : Model := ⟨["p"],[],["challenge-1"],[],[a1]⟩
example : accepts m1160 a0 = false := rfl
example : accepts m1160 a1 = false := rfl
example : impersonations m1160 = [] := rfl
example : authentic m1160 = true := rfl
def m1164 : Model := ⟨["p"],[],["challenge-1"],[],[a0,a1]⟩
example : accepts m1164 a0 = false := rfl
example : accepts m1164 a1 = false := rfl
example : impersonations m1164 = [] := rfl
example : authentic m1164 = true := rfl
def m1168 : Model := ⟨["p"],[],["challenge-1"],[response0],[]⟩
example : accepts m1168 a0 = false := rfl
example : accepts m1168 a1 = false := rfl
example : impersonations m1168 = [] := rfl
example : authentic m1168 = true := rfl
def m1172 : Model := ⟨["p"],[],["challenge-1"],[response0],[a0]⟩
example : accepts m1172 a0 = false := rfl
example : accepts m1172 a1 = false := rfl
example : impersonations m1172 = [] := rfl
example : authentic m1172 = true := rfl
def m1176 : Model := ⟨["p"],[],["challenge-1"],[response0],[a1]⟩
example : accepts m1176 a0 = false := rfl
example : accepts m1176 a1 = false := rfl
example : impersonations m1176 = [] := rfl
example : authentic m1176 = true := rfl
def m1180 : Model := ⟨["p"],[],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m1180 a0 = false := rfl
example : accepts m1180 a1 = false := rfl
example : impersonations m1180 = [] := rfl
example : authentic m1180 = true := rfl
def m1184 : Model := ⟨["p"],[],["challenge-1"],[response1],[]⟩
example : accepts m1184 a0 = false := rfl
example : accepts m1184 a1 = false := rfl
example : impersonations m1184 = [] := rfl
example : authentic m1184 = true := rfl
def m1188 : Model := ⟨["p"],[],["challenge-1"],[response1],[a0]⟩
example : accepts m1188 a0 = false := rfl
example : accepts m1188 a1 = false := rfl
example : impersonations m1188 = [] := rfl
example : authentic m1188 = true := rfl
def m1192 : Model := ⟨["p"],[],["challenge-1"],[response1],[a1]⟩
example : accepts m1192 a0 = false := rfl
example : accepts m1192 a1 = false := rfl
example : impersonations m1192 = [] := rfl
example : authentic m1192 = true := rfl
def m1196 : Model := ⟨["p"],[],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m1196 a0 = false := rfl
example : accepts m1196 a1 = false := rfl
example : impersonations m1196 = [] := rfl
example : authentic m1196 = true := rfl
def m1200 : Model := ⟨["p"],[],["challenge-1"],[response0,response1],[]⟩
example : accepts m1200 a0 = false := rfl
example : accepts m1200 a1 = false := rfl
example : impersonations m1200 = [] := rfl
example : authentic m1200 = true := rfl
def m1204 : Model := ⟨["p"],[],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m1204 a0 = false := rfl
example : accepts m1204 a1 = false := rfl
example : impersonations m1204 = [] := rfl
example : authentic m1204 = true := rfl
def m1208 : Model := ⟨["p"],[],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m1208 a0 = false := rfl
example : accepts m1208 a1 = false := rfl
example : impersonations m1208 = [] := rfl
example : authentic m1208 = true := rfl
def m1212 : Model := ⟨["p"],[],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1212 a0 = false := rfl
example : accepts m1212 a1 = false := rfl
example : impersonations m1212 = [] := rfl
example : authentic m1212 = true := rfl
def m1216 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[],[]⟩
example : accepts m1216 a0 = false := rfl
example : accepts m1216 a1 = false := rfl
example : impersonations m1216 = [] := rfl
example : authentic m1216 = true := rfl
def m1220 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m1220 a0 = false := rfl
example : accepts m1220 a1 = false := rfl
example : impersonations m1220 = [] := rfl
example : authentic m1220 = true := rfl
def m1224 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m1224 a0 = false := rfl
example : accepts m1224 a1 = false := rfl
example : impersonations m1224 = [] := rfl
example : authentic m1224 = true := rfl
def m1228 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m1228 a0 = false := rfl
example : accepts m1228 a1 = false := rfl
example : impersonations m1228 = [] := rfl
example : authentic m1228 = true := rfl
def m1232 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m1232 a0 = false := rfl
example : accepts m1232 a1 = false := rfl
example : impersonations m1232 = [] := rfl
example : authentic m1232 = true := rfl
def m1236 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m1236 a0 = false := rfl
example : accepts m1236 a1 = false := rfl
example : impersonations m1236 = [] := rfl
example : authentic m1236 = true := rfl
def m1240 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m1240 a0 = false := rfl
example : accepts m1240 a1 = false := rfl
example : impersonations m1240 = [] := rfl
example : authentic m1240 = true := rfl
def m1244 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m1244 a0 = false := rfl
example : accepts m1244 a1 = false := rfl
example : impersonations m1244 = [] := rfl
example : authentic m1244 = true := rfl
def m1248 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m1248 a0 = false := rfl
example : accepts m1248 a1 = false := rfl
example : impersonations m1248 = [] := rfl
example : authentic m1248 = true := rfl
def m1252 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m1252 a0 = false := rfl
example : accepts m1252 a1 = false := rfl
example : impersonations m1252 = [] := rfl
example : authentic m1252 = true := rfl
def m1256 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m1256 a0 = false := rfl
example : accepts m1256 a1 = false := rfl
example : impersonations m1256 = [] := rfl
example : authentic m1256 = true := rfl
def m1260 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m1260 a0 = false := rfl
example : accepts m1260 a1 = false := rfl
example : impersonations m1260 = [] := rfl
example : authentic m1260 = true := rfl
def m1264 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m1264 a0 = false := rfl
example : accepts m1264 a1 = false := rfl
example : impersonations m1264 = [] := rfl
example : authentic m1264 = true := rfl
def m1268 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m1268 a0 = false := rfl
example : accepts m1268 a1 = false := rfl
example : impersonations m1268 = [] := rfl
example : authentic m1268 = true := rfl
def m1272 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m1272 a0 = false := rfl
example : accepts m1272 a1 = false := rfl
example : impersonations m1272 = [] := rfl
example : authentic m1272 = true := rfl
def m1276 : Model := ⟨["p"],[],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1276 a0 = false := rfl
example : accepts m1276 a1 = false := rfl
example : impersonations m1276 = [] := rfl
example : authentic m1276 = true := rfl
def m1280 : Model := ⟨["p"],[cred0],[],[],[]⟩
example : accepts m1280 a0 = false := rfl
example : accepts m1280 a1 = false := rfl
example : impersonations m1280 = [] := rfl
example : authentic m1280 = true := rfl
def m1284 : Model := ⟨["p"],[cred0],[],[],[a0]⟩
example : accepts m1284 a0 = false := rfl
example : accepts m1284 a1 = false := rfl
example : impersonations m1284 = [] := rfl
example : authentic m1284 = true := rfl
def m1288 : Model := ⟨["p"],[cred0],[],[],[a1]⟩
example : accepts m1288 a0 = false := rfl
example : accepts m1288 a1 = false := rfl
example : impersonations m1288 = [] := rfl
example : authentic m1288 = true := rfl
def m1292 : Model := ⟨["p"],[cred0],[],[],[a0,a1]⟩
example : accepts m1292 a0 = false := rfl
example : accepts m1292 a1 = false := rfl
example : impersonations m1292 = [] := rfl
example : authentic m1292 = true := rfl
def m1296 : Model := ⟨["p"],[cred0],[],[response0],[]⟩
example : accepts m1296 a0 = false := rfl
example : accepts m1296 a1 = false := rfl
example : impersonations m1296 = [] := rfl
example : authentic m1296 = true := rfl
def m1300 : Model := ⟨["p"],[cred0],[],[response0],[a0]⟩
example : accepts m1300 a0 = false := rfl
example : accepts m1300 a1 = false := rfl
example : impersonations m1300 = [] := rfl
example : authentic m1300 = true := rfl
def m1304 : Model := ⟨["p"],[cred0],[],[response0],[a1]⟩
example : accepts m1304 a0 = false := rfl
example : accepts m1304 a1 = false := rfl
example : impersonations m1304 = [] := rfl
example : authentic m1304 = true := rfl
def m1308 : Model := ⟨["p"],[cred0],[],[response0],[a0,a1]⟩
example : accepts m1308 a0 = false := rfl
example : accepts m1308 a1 = false := rfl
example : impersonations m1308 = [] := rfl
example : authentic m1308 = true := rfl
def m1312 : Model := ⟨["p"],[cred0],[],[response1],[]⟩
example : accepts m1312 a0 = false := rfl
example : accepts m1312 a1 = false := rfl
example : impersonations m1312 = [] := rfl
example : authentic m1312 = true := rfl
def m1316 : Model := ⟨["p"],[cred0],[],[response1],[a0]⟩
example : accepts m1316 a0 = false := rfl
example : accepts m1316 a1 = false := rfl
example : impersonations m1316 = [] := rfl
example : authentic m1316 = true := rfl
def m1320 : Model := ⟨["p"],[cred0],[],[response1],[a1]⟩
example : accepts m1320 a0 = false := rfl
example : accepts m1320 a1 = false := rfl
example : impersonations m1320 = [] := rfl
example : authentic m1320 = true := rfl
def m1324 : Model := ⟨["p"],[cred0],[],[response1],[a0,a1]⟩
example : accepts m1324 a0 = false := rfl
example : accepts m1324 a1 = false := rfl
example : impersonations m1324 = [] := rfl
example : authentic m1324 = true := rfl
def m1328 : Model := ⟨["p"],[cred0],[],[response0,response1],[]⟩
example : accepts m1328 a0 = false := rfl
example : accepts m1328 a1 = false := rfl
example : impersonations m1328 = [] := rfl
example : authentic m1328 = true := rfl
def m1332 : Model := ⟨["p"],[cred0],[],[response0,response1],[a0]⟩
example : accepts m1332 a0 = false := rfl
example : accepts m1332 a1 = false := rfl
example : impersonations m1332 = [] := rfl
example : authentic m1332 = true := rfl
def m1336 : Model := ⟨["p"],[cred0],[],[response0,response1],[a1]⟩
example : accepts m1336 a0 = false := rfl
example : accepts m1336 a1 = false := rfl
example : impersonations m1336 = [] := rfl
example : authentic m1336 = true := rfl
def m1340 : Model := ⟨["p"],[cred0],[],[response0,response1],[a0,a1]⟩
example : accepts m1340 a0 = false := rfl
example : accepts m1340 a1 = false := rfl
example : impersonations m1340 = [] := rfl
example : authentic m1340 = true := rfl
def m1344 : Model := ⟨["p"],[cred0],["challenge-0"],[],[]⟩
example : accepts m1344 a0 = false := rfl
example : accepts m1344 a1 = false := rfl
example : impersonations m1344 = [] := rfl
example : authentic m1344 = true := rfl
def m1348 : Model := ⟨["p"],[cred0],["challenge-0"],[],[a0]⟩
example : accepts m1348 a0 = false := rfl
example : accepts m1348 a1 = false := rfl
example : impersonations m1348 = [] := rfl
example : authentic m1348 = true := rfl
def m1352 : Model := ⟨["p"],[cred0],["challenge-0"],[],[a1]⟩
example : accepts m1352 a0 = false := rfl
example : accepts m1352 a1 = false := rfl
example : impersonations m1352 = [] := rfl
example : authentic m1352 = true := rfl
def m1356 : Model := ⟨["p"],[cred0],["challenge-0"],[],[a0,a1]⟩
example : accepts m1356 a0 = false := rfl
example : accepts m1356 a1 = false := rfl
example : impersonations m1356 = [] := rfl
example : authentic m1356 = true := rfl
def m1360 : Model := ⟨["p"],[cred0],["challenge-0"],[response0],[]⟩
example : accepts m1360 a0 = false := rfl
example : accepts m1360 a1 = false := rfl
example : impersonations m1360 = [] := rfl
example : authentic m1360 = true := rfl
def m1364 : Model := ⟨["p"],[cred0],["challenge-0"],[response0],[a0]⟩
example : accepts m1364 a0 = true := rfl
example : accepts m1364 a1 = false := rfl
example : impersonations m1364 = [] := rfl
example : authentic m1364 = true := rfl
def m1368 : Model := ⟨["p"],[cred0],["challenge-0"],[response0],[a1]⟩
example : accepts m1368 a0 = false := rfl
example : accepts m1368 a1 = true := rfl
example : impersonations m1368 = [a1] := rfl
example : authentic m1368 = false := rfl
def m1372 : Model := ⟨["p"],[cred0],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m1372 a0 = true := rfl
example : accepts m1372 a1 = true := rfl
example : impersonations m1372 = [a1] := rfl
example : authentic m1372 = false := rfl
def m1376 : Model := ⟨["p"],[cred0],["challenge-0"],[response1],[]⟩
example : accepts m1376 a0 = false := rfl
example : accepts m1376 a1 = false := rfl
example : impersonations m1376 = [] := rfl
example : authentic m1376 = true := rfl
def m1380 : Model := ⟨["p"],[cred0],["challenge-0"],[response1],[a0]⟩
example : accepts m1380 a0 = false := rfl
example : accepts m1380 a1 = false := rfl
example : impersonations m1380 = [] := rfl
example : authentic m1380 = true := rfl
def m1384 : Model := ⟨["p"],[cred0],["challenge-0"],[response1],[a1]⟩
example : accepts m1384 a0 = false := rfl
example : accepts m1384 a1 = false := rfl
example : impersonations m1384 = [] := rfl
example : authentic m1384 = true := rfl
def m1388 : Model := ⟨["p"],[cred0],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m1388 a0 = false := rfl
example : accepts m1388 a1 = false := rfl
example : impersonations m1388 = [] := rfl
example : authentic m1388 = true := rfl
def m1392 : Model := ⟨["p"],[cred0],["challenge-0"],[response0,response1],[]⟩
example : accepts m1392 a0 = false := rfl
example : accepts m1392 a1 = false := rfl
example : impersonations m1392 = [] := rfl
example : authentic m1392 = true := rfl
def m1396 : Model := ⟨["p"],[cred0],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m1396 a0 = true := rfl
example : accepts m1396 a1 = false := rfl
example : impersonations m1396 = [] := rfl
example : authentic m1396 = true := rfl
def m1400 : Model := ⟨["p"],[cred0],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m1400 a0 = false := rfl
example : accepts m1400 a1 = true := rfl
example : impersonations m1400 = [a1] := rfl
example : authentic m1400 = false := rfl
def m1404 : Model := ⟨["p"],[cred0],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m1404 a0 = true := rfl
example : accepts m1404 a1 = true := rfl
example : impersonations m1404 = [a1] := rfl
example : authentic m1404 = false := rfl
def m1408 : Model := ⟨["p"],[cred0],["challenge-1"],[],[]⟩
example : accepts m1408 a0 = false := rfl
example : accepts m1408 a1 = false := rfl
example : impersonations m1408 = [] := rfl
example : authentic m1408 = true := rfl
def m1412 : Model := ⟨["p"],[cred0],["challenge-1"],[],[a0]⟩
example : accepts m1412 a0 = false := rfl
example : accepts m1412 a1 = false := rfl
example : impersonations m1412 = [] := rfl
example : authentic m1412 = true := rfl
def m1416 : Model := ⟨["p"],[cred0],["challenge-1"],[],[a1]⟩
example : accepts m1416 a0 = false := rfl
example : accepts m1416 a1 = false := rfl
example : impersonations m1416 = [] := rfl
example : authentic m1416 = true := rfl
def m1420 : Model := ⟨["p"],[cred0],["challenge-1"],[],[a0,a1]⟩
example : accepts m1420 a0 = false := rfl
example : accepts m1420 a1 = false := rfl
example : impersonations m1420 = [] := rfl
example : authentic m1420 = true := rfl
def m1424 : Model := ⟨["p"],[cred0],["challenge-1"],[response0],[]⟩
example : accepts m1424 a0 = false := rfl
example : accepts m1424 a1 = false := rfl
example : impersonations m1424 = [] := rfl
example : authentic m1424 = true := rfl
def m1428 : Model := ⟨["p"],[cred0],["challenge-1"],[response0],[a0]⟩
example : accepts m1428 a0 = false := rfl
example : accepts m1428 a1 = false := rfl
example : impersonations m1428 = [] := rfl
example : authentic m1428 = true := rfl
def m1432 : Model := ⟨["p"],[cred0],["challenge-1"],[response0],[a1]⟩
example : accepts m1432 a0 = false := rfl
example : accepts m1432 a1 = false := rfl
example : impersonations m1432 = [] := rfl
example : authentic m1432 = true := rfl
def m1436 : Model := ⟨["p"],[cred0],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m1436 a0 = false := rfl
example : accepts m1436 a1 = false := rfl
example : impersonations m1436 = [] := rfl
example : authentic m1436 = true := rfl
def m1440 : Model := ⟨["p"],[cred0],["challenge-1"],[response1],[]⟩
example : accepts m1440 a0 = false := rfl
example : accepts m1440 a1 = false := rfl
example : impersonations m1440 = [] := rfl
example : authentic m1440 = true := rfl
def m1444 : Model := ⟨["p"],[cred0],["challenge-1"],[response1],[a0]⟩
example : accepts m1444 a0 = false := rfl
example : accepts m1444 a1 = false := rfl
example : impersonations m1444 = [] := rfl
example : authentic m1444 = true := rfl
def m1448 : Model := ⟨["p"],[cred0],["challenge-1"],[response1],[a1]⟩
example : accepts m1448 a0 = false := rfl
example : accepts m1448 a1 = false := rfl
example : impersonations m1448 = [] := rfl
example : authentic m1448 = true := rfl
def m1452 : Model := ⟨["p"],[cred0],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m1452 a0 = false := rfl
example : accepts m1452 a1 = false := rfl
example : impersonations m1452 = [] := rfl
example : authentic m1452 = true := rfl
def m1456 : Model := ⟨["p"],[cred0],["challenge-1"],[response0,response1],[]⟩
example : accepts m1456 a0 = false := rfl
example : accepts m1456 a1 = false := rfl
example : impersonations m1456 = [] := rfl
example : authentic m1456 = true := rfl
def m1460 : Model := ⟨["p"],[cred0],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m1460 a0 = false := rfl
example : accepts m1460 a1 = false := rfl
example : impersonations m1460 = [] := rfl
example : authentic m1460 = true := rfl
def m1464 : Model := ⟨["p"],[cred0],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m1464 a0 = false := rfl
example : accepts m1464 a1 = false := rfl
example : impersonations m1464 = [] := rfl
example : authentic m1464 = true := rfl
def m1468 : Model := ⟨["p"],[cred0],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1468 a0 = false := rfl
example : accepts m1468 a1 = false := rfl
example : impersonations m1468 = [] := rfl
example : authentic m1468 = true := rfl
def m1472 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[],[]⟩
example : accepts m1472 a0 = false := rfl
example : accepts m1472 a1 = false := rfl
example : impersonations m1472 = [] := rfl
example : authentic m1472 = true := rfl
def m1476 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m1476 a0 = false := rfl
example : accepts m1476 a1 = false := rfl
example : impersonations m1476 = [] := rfl
example : authentic m1476 = true := rfl
def m1480 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m1480 a0 = false := rfl
example : accepts m1480 a1 = false := rfl
example : impersonations m1480 = [] := rfl
example : authentic m1480 = true := rfl
def m1484 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m1484 a0 = false := rfl
example : accepts m1484 a1 = false := rfl
example : impersonations m1484 = [] := rfl
example : authentic m1484 = true := rfl
def m1488 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m1488 a0 = false := rfl
example : accepts m1488 a1 = false := rfl
example : impersonations m1488 = [] := rfl
example : authentic m1488 = true := rfl
def m1492 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m1492 a0 = true := rfl
example : accepts m1492 a1 = false := rfl
example : impersonations m1492 = [] := rfl
example : authentic m1492 = true := rfl
def m1496 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m1496 a0 = false := rfl
example : accepts m1496 a1 = true := rfl
example : impersonations m1496 = [a1] := rfl
example : authentic m1496 = false := rfl
def m1500 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m1500 a0 = true := rfl
example : accepts m1500 a1 = true := rfl
example : impersonations m1500 = [a1] := rfl
example : authentic m1500 = false := rfl
def m1504 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m1504 a0 = false := rfl
example : accepts m1504 a1 = false := rfl
example : impersonations m1504 = [] := rfl
example : authentic m1504 = true := rfl
def m1508 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m1508 a0 = false := rfl
example : accepts m1508 a1 = false := rfl
example : impersonations m1508 = [] := rfl
example : authentic m1508 = true := rfl
def m1512 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m1512 a0 = false := rfl
example : accepts m1512 a1 = false := rfl
example : impersonations m1512 = [] := rfl
example : authentic m1512 = true := rfl
def m1516 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m1516 a0 = false := rfl
example : accepts m1516 a1 = false := rfl
example : impersonations m1516 = [] := rfl
example : authentic m1516 = true := rfl
def m1520 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m1520 a0 = false := rfl
example : accepts m1520 a1 = false := rfl
example : impersonations m1520 = [] := rfl
example : authentic m1520 = true := rfl
def m1524 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m1524 a0 = true := rfl
example : accepts m1524 a1 = false := rfl
example : impersonations m1524 = [] := rfl
example : authentic m1524 = true := rfl
def m1528 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m1528 a0 = false := rfl
example : accepts m1528 a1 = true := rfl
example : impersonations m1528 = [a1] := rfl
example : authentic m1528 = false := rfl
def m1532 : Model := ⟨["p"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1532 a0 = true := rfl
example : accepts m1532 a1 = true := rfl
example : impersonations m1532 = [a1] := rfl
example : authentic m1532 = false := rfl
def m1536 : Model := ⟨["p"],[cred1],[],[],[]⟩
example : accepts m1536 a0 = false := rfl
example : accepts m1536 a1 = false := rfl
example : impersonations m1536 = [] := rfl
example : authentic m1536 = true := rfl
def m1540 : Model := ⟨["p"],[cred1],[],[],[a0]⟩
example : accepts m1540 a0 = false := rfl
example : accepts m1540 a1 = false := rfl
example : impersonations m1540 = [] := rfl
example : authentic m1540 = true := rfl
def m1544 : Model := ⟨["p"],[cred1],[],[],[a1]⟩
example : accepts m1544 a0 = false := rfl
example : accepts m1544 a1 = false := rfl
example : impersonations m1544 = [] := rfl
example : authentic m1544 = true := rfl
def m1548 : Model := ⟨["p"],[cred1],[],[],[a0,a1]⟩
example : accepts m1548 a0 = false := rfl
example : accepts m1548 a1 = false := rfl
example : impersonations m1548 = [] := rfl
example : authentic m1548 = true := rfl
def m1552 : Model := ⟨["p"],[cred1],[],[response0],[]⟩
example : accepts m1552 a0 = false := rfl
example : accepts m1552 a1 = false := rfl
example : impersonations m1552 = [] := rfl
example : authentic m1552 = true := rfl
def m1556 : Model := ⟨["p"],[cred1],[],[response0],[a0]⟩
example : accepts m1556 a0 = false := rfl
example : accepts m1556 a1 = false := rfl
example : impersonations m1556 = [] := rfl
example : authentic m1556 = true := rfl
def m1560 : Model := ⟨["p"],[cred1],[],[response0],[a1]⟩
example : accepts m1560 a0 = false := rfl
example : accepts m1560 a1 = false := rfl
example : impersonations m1560 = [] := rfl
example : authentic m1560 = true := rfl
def m1564 : Model := ⟨["p"],[cred1],[],[response0],[a0,a1]⟩
example : accepts m1564 a0 = false := rfl
example : accepts m1564 a1 = false := rfl
example : impersonations m1564 = [] := rfl
example : authentic m1564 = true := rfl
def m1568 : Model := ⟨["p"],[cred1],[],[response1],[]⟩
example : accepts m1568 a0 = false := rfl
example : accepts m1568 a1 = false := rfl
example : impersonations m1568 = [] := rfl
example : authentic m1568 = true := rfl
def m1572 : Model := ⟨["p"],[cred1],[],[response1],[a0]⟩
example : accepts m1572 a0 = false := rfl
example : accepts m1572 a1 = false := rfl
example : impersonations m1572 = [] := rfl
example : authentic m1572 = true := rfl
def m1576 : Model := ⟨["p"],[cred1],[],[response1],[a1]⟩
example : accepts m1576 a0 = false := rfl
example : accepts m1576 a1 = false := rfl
example : impersonations m1576 = [] := rfl
example : authentic m1576 = true := rfl
def m1580 : Model := ⟨["p"],[cred1],[],[response1],[a0,a1]⟩
example : accepts m1580 a0 = false := rfl
example : accepts m1580 a1 = false := rfl
example : impersonations m1580 = [] := rfl
example : authentic m1580 = true := rfl
def m1584 : Model := ⟨["p"],[cred1],[],[response0,response1],[]⟩
example : accepts m1584 a0 = false := rfl
example : accepts m1584 a1 = false := rfl
example : impersonations m1584 = [] := rfl
example : authentic m1584 = true := rfl
def m1588 : Model := ⟨["p"],[cred1],[],[response0,response1],[a0]⟩
example : accepts m1588 a0 = false := rfl
example : accepts m1588 a1 = false := rfl
example : impersonations m1588 = [] := rfl
example : authentic m1588 = true := rfl
def m1592 : Model := ⟨["p"],[cred1],[],[response0,response1],[a1]⟩
example : accepts m1592 a0 = false := rfl
example : accepts m1592 a1 = false := rfl
example : impersonations m1592 = [] := rfl
example : authentic m1592 = true := rfl
def m1596 : Model := ⟨["p"],[cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m1596 a0 = false := rfl
example : accepts m1596 a1 = false := rfl
example : impersonations m1596 = [] := rfl
example : authentic m1596 = true := rfl
def m1600 : Model := ⟨["p"],[cred1],["challenge-0"],[],[]⟩
example : accepts m1600 a0 = false := rfl
example : accepts m1600 a1 = false := rfl
example : impersonations m1600 = [] := rfl
example : authentic m1600 = true := rfl
def m1604 : Model := ⟨["p"],[cred1],["challenge-0"],[],[a0]⟩
example : accepts m1604 a0 = false := rfl
example : accepts m1604 a1 = false := rfl
example : impersonations m1604 = [] := rfl
example : authentic m1604 = true := rfl
def m1608 : Model := ⟨["p"],[cred1],["challenge-0"],[],[a1]⟩
example : accepts m1608 a0 = false := rfl
example : accepts m1608 a1 = false := rfl
example : impersonations m1608 = [] := rfl
example : authentic m1608 = true := rfl
def m1612 : Model := ⟨["p"],[cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m1612 a0 = false := rfl
example : accepts m1612 a1 = false := rfl
example : impersonations m1612 = [] := rfl
example : authentic m1612 = true := rfl
def m1616 : Model := ⟨["p"],[cred1],["challenge-0"],[response0],[]⟩
example : accepts m1616 a0 = false := rfl
example : accepts m1616 a1 = false := rfl
example : impersonations m1616 = [] := rfl
example : authentic m1616 = true := rfl
def m1620 : Model := ⟨["p"],[cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m1620 a0 = false := rfl
example : accepts m1620 a1 = false := rfl
example : impersonations m1620 = [] := rfl
example : authentic m1620 = true := rfl
def m1624 : Model := ⟨["p"],[cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m1624 a0 = false := rfl
example : accepts m1624 a1 = false := rfl
example : impersonations m1624 = [] := rfl
example : authentic m1624 = true := rfl
def m1628 : Model := ⟨["p"],[cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m1628 a0 = false := rfl
example : accepts m1628 a1 = false := rfl
example : impersonations m1628 = [] := rfl
example : authentic m1628 = true := rfl
def m1632 : Model := ⟨["p"],[cred1],["challenge-0"],[response1],[]⟩
example : accepts m1632 a0 = false := rfl
example : accepts m1632 a1 = false := rfl
example : impersonations m1632 = [] := rfl
example : authentic m1632 = true := rfl
def m1636 : Model := ⟨["p"],[cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m1636 a0 = false := rfl
example : accepts m1636 a1 = false := rfl
example : impersonations m1636 = [] := rfl
example : authentic m1636 = true := rfl
def m1640 : Model := ⟨["p"],[cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m1640 a0 = false := rfl
example : accepts m1640 a1 = false := rfl
example : impersonations m1640 = [] := rfl
example : authentic m1640 = true := rfl
def m1644 : Model := ⟨["p"],[cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m1644 a0 = false := rfl
example : accepts m1644 a1 = false := rfl
example : impersonations m1644 = [] := rfl
example : authentic m1644 = true := rfl
def m1648 : Model := ⟨["p"],[cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m1648 a0 = false := rfl
example : accepts m1648 a1 = false := rfl
example : impersonations m1648 = [] := rfl
example : authentic m1648 = true := rfl
def m1652 : Model := ⟨["p"],[cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m1652 a0 = false := rfl
example : accepts m1652 a1 = false := rfl
example : impersonations m1652 = [] := rfl
example : authentic m1652 = true := rfl
def m1656 : Model := ⟨["p"],[cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m1656 a0 = false := rfl
example : accepts m1656 a1 = false := rfl
example : impersonations m1656 = [] := rfl
example : authentic m1656 = true := rfl
def m1660 : Model := ⟨["p"],[cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m1660 a0 = false := rfl
example : accepts m1660 a1 = false := rfl
example : impersonations m1660 = [] := rfl
example : authentic m1660 = true := rfl
def m1664 : Model := ⟨["p"],[cred1],["challenge-1"],[],[]⟩
example : accepts m1664 a0 = false := rfl
example : accepts m1664 a1 = false := rfl
example : impersonations m1664 = [] := rfl
example : authentic m1664 = true := rfl
def m1668 : Model := ⟨["p"],[cred1],["challenge-1"],[],[a0]⟩
example : accepts m1668 a0 = false := rfl
example : accepts m1668 a1 = false := rfl
example : impersonations m1668 = [] := rfl
example : authentic m1668 = true := rfl
def m1672 : Model := ⟨["p"],[cred1],["challenge-1"],[],[a1]⟩
example : accepts m1672 a0 = false := rfl
example : accepts m1672 a1 = false := rfl
example : impersonations m1672 = [] := rfl
example : authentic m1672 = true := rfl
def m1676 : Model := ⟨["p"],[cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m1676 a0 = false := rfl
example : accepts m1676 a1 = false := rfl
example : impersonations m1676 = [] := rfl
example : authentic m1676 = true := rfl
def m1680 : Model := ⟨["p"],[cred1],["challenge-1"],[response0],[]⟩
example : accepts m1680 a0 = false := rfl
example : accepts m1680 a1 = false := rfl
example : impersonations m1680 = [] := rfl
example : authentic m1680 = true := rfl
def m1684 : Model := ⟨["p"],[cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m1684 a0 = false := rfl
example : accepts m1684 a1 = false := rfl
example : impersonations m1684 = [] := rfl
example : authentic m1684 = true := rfl
def m1688 : Model := ⟨["p"],[cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m1688 a0 = false := rfl
example : accepts m1688 a1 = false := rfl
example : impersonations m1688 = [] := rfl
example : authentic m1688 = true := rfl
def m1692 : Model := ⟨["p"],[cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m1692 a0 = false := rfl
example : accepts m1692 a1 = false := rfl
example : impersonations m1692 = [] := rfl
example : authentic m1692 = true := rfl
def m1696 : Model := ⟨["p"],[cred1],["challenge-1"],[response1],[]⟩
example : accepts m1696 a0 = false := rfl
example : accepts m1696 a1 = false := rfl
example : impersonations m1696 = [] := rfl
example : authentic m1696 = true := rfl
def m1700 : Model := ⟨["p"],[cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m1700 a0 = false := rfl
example : accepts m1700 a1 = false := rfl
example : impersonations m1700 = [] := rfl
example : authentic m1700 = true := rfl
def m1704 : Model := ⟨["p"],[cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m1704 a0 = false := rfl
example : accepts m1704 a1 = false := rfl
example : impersonations m1704 = [] := rfl
example : authentic m1704 = true := rfl
def m1708 : Model := ⟨["p"],[cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m1708 a0 = false := rfl
example : accepts m1708 a1 = false := rfl
example : impersonations m1708 = [] := rfl
example : authentic m1708 = true := rfl
def m1712 : Model := ⟨["p"],[cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m1712 a0 = false := rfl
example : accepts m1712 a1 = false := rfl
example : impersonations m1712 = [] := rfl
example : authentic m1712 = true := rfl
def m1716 : Model := ⟨["p"],[cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m1716 a0 = false := rfl
example : accepts m1716 a1 = false := rfl
example : impersonations m1716 = [] := rfl
example : authentic m1716 = true := rfl
def m1720 : Model := ⟨["p"],[cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m1720 a0 = false := rfl
example : accepts m1720 a1 = false := rfl
example : impersonations m1720 = [] := rfl
example : authentic m1720 = true := rfl
def m1724 : Model := ⟨["p"],[cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1724 a0 = false := rfl
example : accepts m1724 a1 = false := rfl
example : impersonations m1724 = [] := rfl
example : authentic m1724 = true := rfl
def m1728 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m1728 a0 = false := rfl
example : accepts m1728 a1 = false := rfl
example : impersonations m1728 = [] := rfl
example : authentic m1728 = true := rfl
def m1732 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m1732 a0 = false := rfl
example : accepts m1732 a1 = false := rfl
example : impersonations m1732 = [] := rfl
example : authentic m1732 = true := rfl
def m1736 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m1736 a0 = false := rfl
example : accepts m1736 a1 = false := rfl
example : impersonations m1736 = [] := rfl
example : authentic m1736 = true := rfl
def m1740 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m1740 a0 = false := rfl
example : accepts m1740 a1 = false := rfl
example : impersonations m1740 = [] := rfl
example : authentic m1740 = true := rfl
def m1744 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m1744 a0 = false := rfl
example : accepts m1744 a1 = false := rfl
example : impersonations m1744 = [] := rfl
example : authentic m1744 = true := rfl
def m1748 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m1748 a0 = false := rfl
example : accepts m1748 a1 = false := rfl
example : impersonations m1748 = [] := rfl
example : authentic m1748 = true := rfl
def m1752 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m1752 a0 = false := rfl
example : accepts m1752 a1 = false := rfl
example : impersonations m1752 = [] := rfl
example : authentic m1752 = true := rfl
def m1756 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m1756 a0 = false := rfl
example : accepts m1756 a1 = false := rfl
example : impersonations m1756 = [] := rfl
example : authentic m1756 = true := rfl
def m1760 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m1760 a0 = false := rfl
example : accepts m1760 a1 = false := rfl
example : impersonations m1760 = [] := rfl
example : authentic m1760 = true := rfl
def m1764 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m1764 a0 = false := rfl
example : accepts m1764 a1 = false := rfl
example : impersonations m1764 = [] := rfl
example : authentic m1764 = true := rfl
def m1768 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m1768 a0 = false := rfl
example : accepts m1768 a1 = false := rfl
example : impersonations m1768 = [] := rfl
example : authentic m1768 = true := rfl
def m1772 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m1772 a0 = false := rfl
example : accepts m1772 a1 = false := rfl
example : impersonations m1772 = [] := rfl
example : authentic m1772 = true := rfl
def m1776 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m1776 a0 = false := rfl
example : accepts m1776 a1 = false := rfl
example : impersonations m1776 = [] := rfl
example : authentic m1776 = true := rfl
def m1780 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m1780 a0 = false := rfl
example : accepts m1780 a1 = false := rfl
example : impersonations m1780 = [] := rfl
example : authentic m1780 = true := rfl
def m1784 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m1784 a0 = false := rfl
example : accepts m1784 a1 = false := rfl
example : impersonations m1784 = [] := rfl
example : authentic m1784 = true := rfl
def m1788 : Model := ⟨["p"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1788 a0 = false := rfl
example : accepts m1788 a1 = false := rfl
example : impersonations m1788 = [] := rfl
example : authentic m1788 = true := rfl
def m1792 : Model := ⟨["p"],[cred0,cred1],[],[],[]⟩
example : accepts m1792 a0 = false := rfl
example : accepts m1792 a1 = false := rfl
example : impersonations m1792 = [] := rfl
example : authentic m1792 = true := rfl
def m1796 : Model := ⟨["p"],[cred0,cred1],[],[],[a0]⟩
example : accepts m1796 a0 = false := rfl
example : accepts m1796 a1 = false := rfl
example : impersonations m1796 = [] := rfl
example : authentic m1796 = true := rfl
def m1800 : Model := ⟨["p"],[cred0,cred1],[],[],[a1]⟩
example : accepts m1800 a0 = false := rfl
example : accepts m1800 a1 = false := rfl
example : impersonations m1800 = [] := rfl
example : authentic m1800 = true := rfl
def m1804 : Model := ⟨["p"],[cred0,cred1],[],[],[a0,a1]⟩
example : accepts m1804 a0 = false := rfl
example : accepts m1804 a1 = false := rfl
example : impersonations m1804 = [] := rfl
example : authentic m1804 = true := rfl
def m1808 : Model := ⟨["p"],[cred0,cred1],[],[response0],[]⟩
example : accepts m1808 a0 = false := rfl
example : accepts m1808 a1 = false := rfl
example : impersonations m1808 = [] := rfl
example : authentic m1808 = true := rfl
def m1812 : Model := ⟨["p"],[cred0,cred1],[],[response0],[a0]⟩
example : accepts m1812 a0 = false := rfl
example : accepts m1812 a1 = false := rfl
example : impersonations m1812 = [] := rfl
example : authentic m1812 = true := rfl
def m1816 : Model := ⟨["p"],[cred0,cred1],[],[response0],[a1]⟩
example : accepts m1816 a0 = false := rfl
example : accepts m1816 a1 = false := rfl
example : impersonations m1816 = [] := rfl
example : authentic m1816 = true := rfl
def m1820 : Model := ⟨["p"],[cred0,cred1],[],[response0],[a0,a1]⟩
example : accepts m1820 a0 = false := rfl
example : accepts m1820 a1 = false := rfl
example : impersonations m1820 = [] := rfl
example : authentic m1820 = true := rfl
def m1824 : Model := ⟨["p"],[cred0,cred1],[],[response1],[]⟩
example : accepts m1824 a0 = false := rfl
example : accepts m1824 a1 = false := rfl
example : impersonations m1824 = [] := rfl
example : authentic m1824 = true := rfl
def m1828 : Model := ⟨["p"],[cred0,cred1],[],[response1],[a0]⟩
example : accepts m1828 a0 = false := rfl
example : accepts m1828 a1 = false := rfl
example : impersonations m1828 = [] := rfl
example : authentic m1828 = true := rfl
def m1832 : Model := ⟨["p"],[cred0,cred1],[],[response1],[a1]⟩
example : accepts m1832 a0 = false := rfl
example : accepts m1832 a1 = false := rfl
example : impersonations m1832 = [] := rfl
example : authentic m1832 = true := rfl
def m1836 : Model := ⟨["p"],[cred0,cred1],[],[response1],[a0,a1]⟩
example : accepts m1836 a0 = false := rfl
example : accepts m1836 a1 = false := rfl
example : impersonations m1836 = [] := rfl
example : authentic m1836 = true := rfl
def m1840 : Model := ⟨["p"],[cred0,cred1],[],[response0,response1],[]⟩
example : accepts m1840 a0 = false := rfl
example : accepts m1840 a1 = false := rfl
example : impersonations m1840 = [] := rfl
example : authentic m1840 = true := rfl
def m1844 : Model := ⟨["p"],[cred0,cred1],[],[response0,response1],[a0]⟩
example : accepts m1844 a0 = false := rfl
example : accepts m1844 a1 = false := rfl
example : impersonations m1844 = [] := rfl
example : authentic m1844 = true := rfl
def m1848 : Model := ⟨["p"],[cred0,cred1],[],[response0,response1],[a1]⟩
example : accepts m1848 a0 = false := rfl
example : accepts m1848 a1 = false := rfl
example : impersonations m1848 = [] := rfl
example : authentic m1848 = true := rfl
def m1852 : Model := ⟨["p"],[cred0,cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m1852 a0 = false := rfl
example : accepts m1852 a1 = false := rfl
example : impersonations m1852 = [] := rfl
example : authentic m1852 = true := rfl
def m1856 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[],[]⟩
example : accepts m1856 a0 = false := rfl
example : accepts m1856 a1 = false := rfl
example : impersonations m1856 = [] := rfl
example : authentic m1856 = true := rfl
def m1860 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[],[a0]⟩
example : accepts m1860 a0 = false := rfl
example : accepts m1860 a1 = false := rfl
example : impersonations m1860 = [] := rfl
example : authentic m1860 = true := rfl
def m1864 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[],[a1]⟩
example : accepts m1864 a0 = false := rfl
example : accepts m1864 a1 = false := rfl
example : impersonations m1864 = [] := rfl
example : authentic m1864 = true := rfl
def m1868 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m1868 a0 = false := rfl
example : accepts m1868 a1 = false := rfl
example : impersonations m1868 = [] := rfl
example : authentic m1868 = true := rfl
def m1872 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0],[]⟩
example : accepts m1872 a0 = false := rfl
example : accepts m1872 a1 = false := rfl
example : impersonations m1872 = [] := rfl
example : authentic m1872 = true := rfl
def m1876 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m1876 a0 = true := rfl
example : accepts m1876 a1 = false := rfl
example : impersonations m1876 = [] := rfl
example : authentic m1876 = true := rfl
def m1880 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m1880 a0 = false := rfl
example : accepts m1880 a1 = true := rfl
example : impersonations m1880 = [a1] := rfl
example : authentic m1880 = false := rfl
def m1884 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m1884 a0 = true := rfl
example : accepts m1884 a1 = true := rfl
example : impersonations m1884 = [a1] := rfl
example : authentic m1884 = false := rfl
def m1888 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response1],[]⟩
example : accepts m1888 a0 = false := rfl
example : accepts m1888 a1 = false := rfl
example : impersonations m1888 = [] := rfl
example : authentic m1888 = true := rfl
def m1892 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m1892 a0 = false := rfl
example : accepts m1892 a1 = false := rfl
example : impersonations m1892 = [] := rfl
example : authentic m1892 = true := rfl
def m1896 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m1896 a0 = false := rfl
example : accepts m1896 a1 = false := rfl
example : impersonations m1896 = [] := rfl
example : authentic m1896 = true := rfl
def m1900 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m1900 a0 = false := rfl
example : accepts m1900 a1 = false := rfl
example : impersonations m1900 = [] := rfl
example : authentic m1900 = true := rfl
def m1904 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m1904 a0 = false := rfl
example : accepts m1904 a1 = false := rfl
example : impersonations m1904 = [] := rfl
example : authentic m1904 = true := rfl
def m1908 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m1908 a0 = true := rfl
example : accepts m1908 a1 = false := rfl
example : impersonations m1908 = [] := rfl
example : authentic m1908 = true := rfl
def m1912 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m1912 a0 = false := rfl
example : accepts m1912 a1 = true := rfl
example : impersonations m1912 = [a1] := rfl
example : authentic m1912 = false := rfl
def m1916 : Model := ⟨["p"],[cred0,cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m1916 a0 = true := rfl
example : accepts m1916 a1 = true := rfl
example : impersonations m1916 = [a1] := rfl
example : authentic m1916 = false := rfl
def m1920 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[],[]⟩
example : accepts m1920 a0 = false := rfl
example : accepts m1920 a1 = false := rfl
example : impersonations m1920 = [] := rfl
example : authentic m1920 = true := rfl
def m1924 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[],[a0]⟩
example : accepts m1924 a0 = false := rfl
example : accepts m1924 a1 = false := rfl
example : impersonations m1924 = [] := rfl
example : authentic m1924 = true := rfl
def m1928 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[],[a1]⟩
example : accepts m1928 a0 = false := rfl
example : accepts m1928 a1 = false := rfl
example : impersonations m1928 = [] := rfl
example : authentic m1928 = true := rfl
def m1932 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m1932 a0 = false := rfl
example : accepts m1932 a1 = false := rfl
example : impersonations m1932 = [] := rfl
example : authentic m1932 = true := rfl
def m1936 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0],[]⟩
example : accepts m1936 a0 = false := rfl
example : accepts m1936 a1 = false := rfl
example : impersonations m1936 = [] := rfl
example : authentic m1936 = true := rfl
def m1940 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m1940 a0 = false := rfl
example : accepts m1940 a1 = false := rfl
example : impersonations m1940 = [] := rfl
example : authentic m1940 = true := rfl
def m1944 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m1944 a0 = false := rfl
example : accepts m1944 a1 = false := rfl
example : impersonations m1944 = [] := rfl
example : authentic m1944 = true := rfl
def m1948 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m1948 a0 = false := rfl
example : accepts m1948 a1 = false := rfl
example : impersonations m1948 = [] := rfl
example : authentic m1948 = true := rfl
def m1952 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response1],[]⟩
example : accepts m1952 a0 = false := rfl
example : accepts m1952 a1 = false := rfl
example : impersonations m1952 = [] := rfl
example : authentic m1952 = true := rfl
def m1956 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m1956 a0 = false := rfl
example : accepts m1956 a1 = false := rfl
example : impersonations m1956 = [] := rfl
example : authentic m1956 = true := rfl
def m1960 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m1960 a0 = false := rfl
example : accepts m1960 a1 = false := rfl
example : impersonations m1960 = [] := rfl
example : authentic m1960 = true := rfl
def m1964 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m1964 a0 = false := rfl
example : accepts m1964 a1 = false := rfl
example : impersonations m1964 = [] := rfl
example : authentic m1964 = true := rfl
def m1968 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m1968 a0 = false := rfl
example : accepts m1968 a1 = false := rfl
example : impersonations m1968 = [] := rfl
example : authentic m1968 = true := rfl
def m1972 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m1972 a0 = false := rfl
example : accepts m1972 a1 = false := rfl
example : impersonations m1972 = [] := rfl
example : authentic m1972 = true := rfl
def m1976 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m1976 a0 = false := rfl
example : accepts m1976 a1 = false := rfl
example : impersonations m1976 = [] := rfl
example : authentic m1976 = true := rfl
def m1980 : Model := ⟨["p"],[cred0,cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m1980 a0 = false := rfl
example : accepts m1980 a1 = false := rfl
example : impersonations m1980 = [] := rfl
example : authentic m1980 = true := rfl
def m1984 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m1984 a0 = false := rfl
example : accepts m1984 a1 = false := rfl
example : impersonations m1984 = [] := rfl
example : authentic m1984 = true := rfl
def m1988 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m1988 a0 = false := rfl
example : accepts m1988 a1 = false := rfl
example : impersonations m1988 = [] := rfl
example : authentic m1988 = true := rfl
def m1992 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m1992 a0 = false := rfl
example : accepts m1992 a1 = false := rfl
example : impersonations m1992 = [] := rfl
example : authentic m1992 = true := rfl
def m1996 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m1996 a0 = false := rfl
example : accepts m1996 a1 = false := rfl
example : impersonations m1996 = [] := rfl
example : authentic m1996 = true := rfl
def m2000 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m2000 a0 = false := rfl
example : accepts m2000 a1 = false := rfl
example : impersonations m2000 = [] := rfl
example : authentic m2000 = true := rfl
def m2004 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m2004 a0 = true := rfl
example : accepts m2004 a1 = false := rfl
example : impersonations m2004 = [] := rfl
example : authentic m2004 = true := rfl
def m2008 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m2008 a0 = false := rfl
example : accepts m2008 a1 = true := rfl
example : impersonations m2008 = [a1] := rfl
example : authentic m2008 = false := rfl
def m2012 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m2012 a0 = true := rfl
example : accepts m2012 a1 = true := rfl
example : impersonations m2012 = [a1] := rfl
example : authentic m2012 = false := rfl
def m2016 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m2016 a0 = false := rfl
example : accepts m2016 a1 = false := rfl
example : impersonations m2016 = [] := rfl
example : authentic m2016 = true := rfl
def m2020 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m2020 a0 = false := rfl
example : accepts m2020 a1 = false := rfl
example : impersonations m2020 = [] := rfl
example : authentic m2020 = true := rfl
def m2024 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m2024 a0 = false := rfl
example : accepts m2024 a1 = false := rfl
example : impersonations m2024 = [] := rfl
example : authentic m2024 = true := rfl
def m2028 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m2028 a0 = false := rfl
example : accepts m2028 a1 = false := rfl
example : impersonations m2028 = [] := rfl
example : authentic m2028 = true := rfl
def m2032 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m2032 a0 = false := rfl
example : accepts m2032 a1 = false := rfl
example : impersonations m2032 = [] := rfl
example : authentic m2032 = true := rfl
def m2036 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m2036 a0 = true := rfl
example : accepts m2036 a1 = false := rfl
example : impersonations m2036 = [] := rfl
example : authentic m2036 = true := rfl
def m2040 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m2040 a0 = false := rfl
example : accepts m2040 a1 = true := rfl
example : impersonations m2040 = [a1] := rfl
example : authentic m2040 = false := rfl
def m2044 : Model := ⟨["p"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2044 a0 = true := rfl
example : accepts m2044 a1 = true := rfl
example : impersonations m2044 = [a1] := rfl
example : authentic m2044 = false := rfl
def m2048 : Model := ⟨["q"],[],[],[],[]⟩
example : accepts m2048 a0 = false := rfl
example : accepts m2048 a1 = false := rfl
example : impersonations m2048 = [] := rfl
example : authentic m2048 = true := rfl
def m2052 : Model := ⟨["q"],[],[],[],[a0]⟩
example : accepts m2052 a0 = false := rfl
example : accepts m2052 a1 = false := rfl
example : impersonations m2052 = [] := rfl
example : authentic m2052 = true := rfl
def m2056 : Model := ⟨["q"],[],[],[],[a1]⟩
example : accepts m2056 a0 = false := rfl
example : accepts m2056 a1 = false := rfl
example : impersonations m2056 = [] := rfl
example : authentic m2056 = true := rfl
def m2060 : Model := ⟨["q"],[],[],[],[a0,a1]⟩
example : accepts m2060 a0 = false := rfl
example : accepts m2060 a1 = false := rfl
example : impersonations m2060 = [] := rfl
example : authentic m2060 = true := rfl
def m2064 : Model := ⟨["q"],[],[],[response0],[]⟩
example : accepts m2064 a0 = false := rfl
example : accepts m2064 a1 = false := rfl
example : impersonations m2064 = [] := rfl
example : authentic m2064 = true := rfl
def m2068 : Model := ⟨["q"],[],[],[response0],[a0]⟩
example : accepts m2068 a0 = false := rfl
example : accepts m2068 a1 = false := rfl
example : impersonations m2068 = [] := rfl
example : authentic m2068 = true := rfl
def m2072 : Model := ⟨["q"],[],[],[response0],[a1]⟩
example : accepts m2072 a0 = false := rfl
example : accepts m2072 a1 = false := rfl
example : impersonations m2072 = [] := rfl
example : authentic m2072 = true := rfl
def m2076 : Model := ⟨["q"],[],[],[response0],[a0,a1]⟩
example : accepts m2076 a0 = false := rfl
example : accepts m2076 a1 = false := rfl
example : impersonations m2076 = [] := rfl
example : authentic m2076 = true := rfl
def m2080 : Model := ⟨["q"],[],[],[response1],[]⟩
example : accepts m2080 a0 = false := rfl
example : accepts m2080 a1 = false := rfl
example : impersonations m2080 = [] := rfl
example : authentic m2080 = true := rfl
def m2084 : Model := ⟨["q"],[],[],[response1],[a0]⟩
example : accepts m2084 a0 = false := rfl
example : accepts m2084 a1 = false := rfl
example : impersonations m2084 = [] := rfl
example : authentic m2084 = true := rfl
def m2088 : Model := ⟨["q"],[],[],[response1],[a1]⟩
example : accepts m2088 a0 = false := rfl
example : accepts m2088 a1 = false := rfl
example : impersonations m2088 = [] := rfl
example : authentic m2088 = true := rfl
def m2092 : Model := ⟨["q"],[],[],[response1],[a0,a1]⟩
example : accepts m2092 a0 = false := rfl
example : accepts m2092 a1 = false := rfl
example : impersonations m2092 = [] := rfl
example : authentic m2092 = true := rfl
def m2096 : Model := ⟨["q"],[],[],[response0,response1],[]⟩
example : accepts m2096 a0 = false := rfl
example : accepts m2096 a1 = false := rfl
example : impersonations m2096 = [] := rfl
example : authentic m2096 = true := rfl
def m2100 : Model := ⟨["q"],[],[],[response0,response1],[a0]⟩
example : accepts m2100 a0 = false := rfl
example : accepts m2100 a1 = false := rfl
example : impersonations m2100 = [] := rfl
example : authentic m2100 = true := rfl
def m2104 : Model := ⟨["q"],[],[],[response0,response1],[a1]⟩
example : accepts m2104 a0 = false := rfl
example : accepts m2104 a1 = false := rfl
example : impersonations m2104 = [] := rfl
example : authentic m2104 = true := rfl
def m2108 : Model := ⟨["q"],[],[],[response0,response1],[a0,a1]⟩
example : accepts m2108 a0 = false := rfl
example : accepts m2108 a1 = false := rfl
example : impersonations m2108 = [] := rfl
example : authentic m2108 = true := rfl
def m2112 : Model := ⟨["q"],[],["challenge-0"],[],[]⟩
example : accepts m2112 a0 = false := rfl
example : accepts m2112 a1 = false := rfl
example : impersonations m2112 = [] := rfl
example : authentic m2112 = true := rfl
def m2116 : Model := ⟨["q"],[],["challenge-0"],[],[a0]⟩
example : accepts m2116 a0 = false := rfl
example : accepts m2116 a1 = false := rfl
example : impersonations m2116 = [] := rfl
example : authentic m2116 = true := rfl
def m2120 : Model := ⟨["q"],[],["challenge-0"],[],[a1]⟩
example : accepts m2120 a0 = false := rfl
example : accepts m2120 a1 = false := rfl
example : impersonations m2120 = [] := rfl
example : authentic m2120 = true := rfl
def m2124 : Model := ⟨["q"],[],["challenge-0"],[],[a0,a1]⟩
example : accepts m2124 a0 = false := rfl
example : accepts m2124 a1 = false := rfl
example : impersonations m2124 = [] := rfl
example : authentic m2124 = true := rfl
def m2128 : Model := ⟨["q"],[],["challenge-0"],[response0],[]⟩
example : accepts m2128 a0 = false := rfl
example : accepts m2128 a1 = false := rfl
example : impersonations m2128 = [] := rfl
example : authentic m2128 = true := rfl
def m2132 : Model := ⟨["q"],[],["challenge-0"],[response0],[a0]⟩
example : accepts m2132 a0 = false := rfl
example : accepts m2132 a1 = false := rfl
example : impersonations m2132 = [] := rfl
example : authentic m2132 = true := rfl
def m2136 : Model := ⟨["q"],[],["challenge-0"],[response0],[a1]⟩
example : accepts m2136 a0 = false := rfl
example : accepts m2136 a1 = false := rfl
example : impersonations m2136 = [] := rfl
example : authentic m2136 = true := rfl
def m2140 : Model := ⟨["q"],[],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m2140 a0 = false := rfl
example : accepts m2140 a1 = false := rfl
example : impersonations m2140 = [] := rfl
example : authentic m2140 = true := rfl
def m2144 : Model := ⟨["q"],[],["challenge-0"],[response1],[]⟩
example : accepts m2144 a0 = false := rfl
example : accepts m2144 a1 = false := rfl
example : impersonations m2144 = [] := rfl
example : authentic m2144 = true := rfl
def m2148 : Model := ⟨["q"],[],["challenge-0"],[response1],[a0]⟩
example : accepts m2148 a0 = false := rfl
example : accepts m2148 a1 = false := rfl
example : impersonations m2148 = [] := rfl
example : authentic m2148 = true := rfl
def m2152 : Model := ⟨["q"],[],["challenge-0"],[response1],[a1]⟩
example : accepts m2152 a0 = false := rfl
example : accepts m2152 a1 = false := rfl
example : impersonations m2152 = [] := rfl
example : authentic m2152 = true := rfl
def m2156 : Model := ⟨["q"],[],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m2156 a0 = false := rfl
example : accepts m2156 a1 = false := rfl
example : impersonations m2156 = [] := rfl
example : authentic m2156 = true := rfl
def m2160 : Model := ⟨["q"],[],["challenge-0"],[response0,response1],[]⟩
example : accepts m2160 a0 = false := rfl
example : accepts m2160 a1 = false := rfl
example : impersonations m2160 = [] := rfl
example : authentic m2160 = true := rfl
def m2164 : Model := ⟨["q"],[],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m2164 a0 = false := rfl
example : accepts m2164 a1 = false := rfl
example : impersonations m2164 = [] := rfl
example : authentic m2164 = true := rfl
def m2168 : Model := ⟨["q"],[],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m2168 a0 = false := rfl
example : accepts m2168 a1 = false := rfl
example : impersonations m2168 = [] := rfl
example : authentic m2168 = true := rfl
def m2172 : Model := ⟨["q"],[],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m2172 a0 = false := rfl
example : accepts m2172 a1 = false := rfl
example : impersonations m2172 = [] := rfl
example : authentic m2172 = true := rfl
def m2176 : Model := ⟨["q"],[],["challenge-1"],[],[]⟩
example : accepts m2176 a0 = false := rfl
example : accepts m2176 a1 = false := rfl
example : impersonations m2176 = [] := rfl
example : authentic m2176 = true := rfl
def m2180 : Model := ⟨["q"],[],["challenge-1"],[],[a0]⟩
example : accepts m2180 a0 = false := rfl
example : accepts m2180 a1 = false := rfl
example : impersonations m2180 = [] := rfl
example : authentic m2180 = true := rfl
def m2184 : Model := ⟨["q"],[],["challenge-1"],[],[a1]⟩
example : accepts m2184 a0 = false := rfl
example : accepts m2184 a1 = false := rfl
example : impersonations m2184 = [] := rfl
example : authentic m2184 = true := rfl
def m2188 : Model := ⟨["q"],[],["challenge-1"],[],[a0,a1]⟩
example : accepts m2188 a0 = false := rfl
example : accepts m2188 a1 = false := rfl
example : impersonations m2188 = [] := rfl
example : authentic m2188 = true := rfl
def m2192 : Model := ⟨["q"],[],["challenge-1"],[response0],[]⟩
example : accepts m2192 a0 = false := rfl
example : accepts m2192 a1 = false := rfl
example : impersonations m2192 = [] := rfl
example : authentic m2192 = true := rfl
def m2196 : Model := ⟨["q"],[],["challenge-1"],[response0],[a0]⟩
example : accepts m2196 a0 = false := rfl
example : accepts m2196 a1 = false := rfl
example : impersonations m2196 = [] := rfl
example : authentic m2196 = true := rfl
def m2200 : Model := ⟨["q"],[],["challenge-1"],[response0],[a1]⟩
example : accepts m2200 a0 = false := rfl
example : accepts m2200 a1 = false := rfl
example : impersonations m2200 = [] := rfl
example : authentic m2200 = true := rfl
def m2204 : Model := ⟨["q"],[],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m2204 a0 = false := rfl
example : accepts m2204 a1 = false := rfl
example : impersonations m2204 = [] := rfl
example : authentic m2204 = true := rfl
def m2208 : Model := ⟨["q"],[],["challenge-1"],[response1],[]⟩
example : accepts m2208 a0 = false := rfl
example : accepts m2208 a1 = false := rfl
example : impersonations m2208 = [] := rfl
example : authentic m2208 = true := rfl
def m2212 : Model := ⟨["q"],[],["challenge-1"],[response1],[a0]⟩
example : accepts m2212 a0 = false := rfl
example : accepts m2212 a1 = false := rfl
example : impersonations m2212 = [] := rfl
example : authentic m2212 = true := rfl
def m2216 : Model := ⟨["q"],[],["challenge-1"],[response1],[a1]⟩
example : accepts m2216 a0 = false := rfl
example : accepts m2216 a1 = false := rfl
example : impersonations m2216 = [] := rfl
example : authentic m2216 = true := rfl
def m2220 : Model := ⟨["q"],[],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m2220 a0 = false := rfl
example : accepts m2220 a1 = false := rfl
example : impersonations m2220 = [] := rfl
example : authentic m2220 = true := rfl
def m2224 : Model := ⟨["q"],[],["challenge-1"],[response0,response1],[]⟩
example : accepts m2224 a0 = false := rfl
example : accepts m2224 a1 = false := rfl
example : impersonations m2224 = [] := rfl
example : authentic m2224 = true := rfl
def m2228 : Model := ⟨["q"],[],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m2228 a0 = false := rfl
example : accepts m2228 a1 = false := rfl
example : impersonations m2228 = [] := rfl
example : authentic m2228 = true := rfl
def m2232 : Model := ⟨["q"],[],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m2232 a0 = false := rfl
example : accepts m2232 a1 = false := rfl
example : impersonations m2232 = [] := rfl
example : authentic m2232 = true := rfl
def m2236 : Model := ⟨["q"],[],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2236 a0 = false := rfl
example : accepts m2236 a1 = false := rfl
example : impersonations m2236 = [] := rfl
example : authentic m2236 = true := rfl
def m2240 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[],[]⟩
example : accepts m2240 a0 = false := rfl
example : accepts m2240 a1 = false := rfl
example : impersonations m2240 = [] := rfl
example : authentic m2240 = true := rfl
def m2244 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m2244 a0 = false := rfl
example : accepts m2244 a1 = false := rfl
example : impersonations m2244 = [] := rfl
example : authentic m2244 = true := rfl
def m2248 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m2248 a0 = false := rfl
example : accepts m2248 a1 = false := rfl
example : impersonations m2248 = [] := rfl
example : authentic m2248 = true := rfl
def m2252 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m2252 a0 = false := rfl
example : accepts m2252 a1 = false := rfl
example : impersonations m2252 = [] := rfl
example : authentic m2252 = true := rfl
def m2256 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m2256 a0 = false := rfl
example : accepts m2256 a1 = false := rfl
example : impersonations m2256 = [] := rfl
example : authentic m2256 = true := rfl
def m2260 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m2260 a0 = false := rfl
example : accepts m2260 a1 = false := rfl
example : impersonations m2260 = [] := rfl
example : authentic m2260 = true := rfl
def m2264 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m2264 a0 = false := rfl
example : accepts m2264 a1 = false := rfl
example : impersonations m2264 = [] := rfl
example : authentic m2264 = true := rfl
def m2268 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m2268 a0 = false := rfl
example : accepts m2268 a1 = false := rfl
example : impersonations m2268 = [] := rfl
example : authentic m2268 = true := rfl
def m2272 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m2272 a0 = false := rfl
example : accepts m2272 a1 = false := rfl
example : impersonations m2272 = [] := rfl
example : authentic m2272 = true := rfl
def m2276 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m2276 a0 = false := rfl
example : accepts m2276 a1 = false := rfl
example : impersonations m2276 = [] := rfl
example : authentic m2276 = true := rfl
def m2280 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m2280 a0 = false := rfl
example : accepts m2280 a1 = false := rfl
example : impersonations m2280 = [] := rfl
example : authentic m2280 = true := rfl
def m2284 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m2284 a0 = false := rfl
example : accepts m2284 a1 = false := rfl
example : impersonations m2284 = [] := rfl
example : authentic m2284 = true := rfl
def m2288 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m2288 a0 = false := rfl
example : accepts m2288 a1 = false := rfl
example : impersonations m2288 = [] := rfl
example : authentic m2288 = true := rfl
def m2292 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m2292 a0 = false := rfl
example : accepts m2292 a1 = false := rfl
example : impersonations m2292 = [] := rfl
example : authentic m2292 = true := rfl
def m2296 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m2296 a0 = false := rfl
example : accepts m2296 a1 = false := rfl
example : impersonations m2296 = [] := rfl
example : authentic m2296 = true := rfl
def m2300 : Model := ⟨["q"],[],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2300 a0 = false := rfl
example : accepts m2300 a1 = false := rfl
example : impersonations m2300 = [] := rfl
example : authentic m2300 = true := rfl
def m2304 : Model := ⟨["q"],[cred0],[],[],[]⟩
example : accepts m2304 a0 = false := rfl
example : accepts m2304 a1 = false := rfl
example : impersonations m2304 = [] := rfl
example : authentic m2304 = true := rfl
def m2308 : Model := ⟨["q"],[cred0],[],[],[a0]⟩
example : accepts m2308 a0 = false := rfl
example : accepts m2308 a1 = false := rfl
example : impersonations m2308 = [] := rfl
example : authentic m2308 = true := rfl
def m2312 : Model := ⟨["q"],[cred0],[],[],[a1]⟩
example : accepts m2312 a0 = false := rfl
example : accepts m2312 a1 = false := rfl
example : impersonations m2312 = [] := rfl
example : authentic m2312 = true := rfl
def m2316 : Model := ⟨["q"],[cred0],[],[],[a0,a1]⟩
example : accepts m2316 a0 = false := rfl
example : accepts m2316 a1 = false := rfl
example : impersonations m2316 = [] := rfl
example : authentic m2316 = true := rfl
def m2320 : Model := ⟨["q"],[cred0],[],[response0],[]⟩
example : accepts m2320 a0 = false := rfl
example : accepts m2320 a1 = false := rfl
example : impersonations m2320 = [] := rfl
example : authentic m2320 = true := rfl
def m2324 : Model := ⟨["q"],[cred0],[],[response0],[a0]⟩
example : accepts m2324 a0 = false := rfl
example : accepts m2324 a1 = false := rfl
example : impersonations m2324 = [] := rfl
example : authentic m2324 = true := rfl
def m2328 : Model := ⟨["q"],[cred0],[],[response0],[a1]⟩
example : accepts m2328 a0 = false := rfl
example : accepts m2328 a1 = false := rfl
example : impersonations m2328 = [] := rfl
example : authentic m2328 = true := rfl
def m2332 : Model := ⟨["q"],[cred0],[],[response0],[a0,a1]⟩
example : accepts m2332 a0 = false := rfl
example : accepts m2332 a1 = false := rfl
example : impersonations m2332 = [] := rfl
example : authentic m2332 = true := rfl
def m2336 : Model := ⟨["q"],[cred0],[],[response1],[]⟩
example : accepts m2336 a0 = false := rfl
example : accepts m2336 a1 = false := rfl
example : impersonations m2336 = [] := rfl
example : authentic m2336 = true := rfl
def m2340 : Model := ⟨["q"],[cred0],[],[response1],[a0]⟩
example : accepts m2340 a0 = false := rfl
example : accepts m2340 a1 = false := rfl
example : impersonations m2340 = [] := rfl
example : authentic m2340 = true := rfl
def m2344 : Model := ⟨["q"],[cred0],[],[response1],[a1]⟩
example : accepts m2344 a0 = false := rfl
example : accepts m2344 a1 = false := rfl
example : impersonations m2344 = [] := rfl
example : authentic m2344 = true := rfl
def m2348 : Model := ⟨["q"],[cred0],[],[response1],[a0,a1]⟩
example : accepts m2348 a0 = false := rfl
example : accepts m2348 a1 = false := rfl
example : impersonations m2348 = [] := rfl
example : authentic m2348 = true := rfl
def m2352 : Model := ⟨["q"],[cred0],[],[response0,response1],[]⟩
example : accepts m2352 a0 = false := rfl
example : accepts m2352 a1 = false := rfl
example : impersonations m2352 = [] := rfl
example : authentic m2352 = true := rfl
def m2356 : Model := ⟨["q"],[cred0],[],[response0,response1],[a0]⟩
example : accepts m2356 a0 = false := rfl
example : accepts m2356 a1 = false := rfl
example : impersonations m2356 = [] := rfl
example : authentic m2356 = true := rfl
def m2360 : Model := ⟨["q"],[cred0],[],[response0,response1],[a1]⟩
example : accepts m2360 a0 = false := rfl
example : accepts m2360 a1 = false := rfl
example : impersonations m2360 = [] := rfl
example : authentic m2360 = true := rfl
def m2364 : Model := ⟨["q"],[cred0],[],[response0,response1],[a0,a1]⟩
example : accepts m2364 a0 = false := rfl
example : accepts m2364 a1 = false := rfl
example : impersonations m2364 = [] := rfl
example : authentic m2364 = true := rfl
def m2368 : Model := ⟨["q"],[cred0],["challenge-0"],[],[]⟩
example : accepts m2368 a0 = false := rfl
example : accepts m2368 a1 = false := rfl
example : impersonations m2368 = [] := rfl
example : authentic m2368 = true := rfl
def m2372 : Model := ⟨["q"],[cred0],["challenge-0"],[],[a0]⟩
example : accepts m2372 a0 = false := rfl
example : accepts m2372 a1 = false := rfl
example : impersonations m2372 = [] := rfl
example : authentic m2372 = true := rfl
def m2376 : Model := ⟨["q"],[cred0],["challenge-0"],[],[a1]⟩
example : accepts m2376 a0 = false := rfl
example : accepts m2376 a1 = false := rfl
example : impersonations m2376 = [] := rfl
example : authentic m2376 = true := rfl
def m2380 : Model := ⟨["q"],[cred0],["challenge-0"],[],[a0,a1]⟩
example : accepts m2380 a0 = false := rfl
example : accepts m2380 a1 = false := rfl
example : impersonations m2380 = [] := rfl
example : authentic m2380 = true := rfl
def m2384 : Model := ⟨["q"],[cred0],["challenge-0"],[response0],[]⟩
example : accepts m2384 a0 = false := rfl
example : accepts m2384 a1 = false := rfl
example : impersonations m2384 = [] := rfl
example : authentic m2384 = true := rfl
def m2388 : Model := ⟨["q"],[cred0],["challenge-0"],[response0],[a0]⟩
example : accepts m2388 a0 = false := rfl
example : accepts m2388 a1 = false := rfl
example : impersonations m2388 = [] := rfl
example : authentic m2388 = true := rfl
def m2392 : Model := ⟨["q"],[cred0],["challenge-0"],[response0],[a1]⟩
example : accepts m2392 a0 = false := rfl
example : accepts m2392 a1 = false := rfl
example : impersonations m2392 = [] := rfl
example : authentic m2392 = true := rfl
def m2396 : Model := ⟨["q"],[cred0],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m2396 a0 = false := rfl
example : accepts m2396 a1 = false := rfl
example : impersonations m2396 = [] := rfl
example : authentic m2396 = true := rfl
def m2400 : Model := ⟨["q"],[cred0],["challenge-0"],[response1],[]⟩
example : accepts m2400 a0 = false := rfl
example : accepts m2400 a1 = false := rfl
example : impersonations m2400 = [] := rfl
example : authentic m2400 = true := rfl
def m2404 : Model := ⟨["q"],[cred0],["challenge-0"],[response1],[a0]⟩
example : accepts m2404 a0 = false := rfl
example : accepts m2404 a1 = false := rfl
example : impersonations m2404 = [] := rfl
example : authentic m2404 = true := rfl
def m2408 : Model := ⟨["q"],[cred0],["challenge-0"],[response1],[a1]⟩
example : accepts m2408 a0 = false := rfl
example : accepts m2408 a1 = false := rfl
example : impersonations m2408 = [] := rfl
example : authentic m2408 = true := rfl
def m2412 : Model := ⟨["q"],[cred0],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m2412 a0 = false := rfl
example : accepts m2412 a1 = false := rfl
example : impersonations m2412 = [] := rfl
example : authentic m2412 = true := rfl
def m2416 : Model := ⟨["q"],[cred0],["challenge-0"],[response0,response1],[]⟩
example : accepts m2416 a0 = false := rfl
example : accepts m2416 a1 = false := rfl
example : impersonations m2416 = [] := rfl
example : authentic m2416 = true := rfl
def m2420 : Model := ⟨["q"],[cred0],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m2420 a0 = false := rfl
example : accepts m2420 a1 = false := rfl
example : impersonations m2420 = [] := rfl
example : authentic m2420 = true := rfl
def m2424 : Model := ⟨["q"],[cred0],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m2424 a0 = false := rfl
example : accepts m2424 a1 = false := rfl
example : impersonations m2424 = [] := rfl
example : authentic m2424 = true := rfl
def m2428 : Model := ⟨["q"],[cred0],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m2428 a0 = false := rfl
example : accepts m2428 a1 = false := rfl
example : impersonations m2428 = [] := rfl
example : authentic m2428 = true := rfl
def m2432 : Model := ⟨["q"],[cred0],["challenge-1"],[],[]⟩
example : accepts m2432 a0 = false := rfl
example : accepts m2432 a1 = false := rfl
example : impersonations m2432 = [] := rfl
example : authentic m2432 = true := rfl
def m2436 : Model := ⟨["q"],[cred0],["challenge-1"],[],[a0]⟩
example : accepts m2436 a0 = false := rfl
example : accepts m2436 a1 = false := rfl
example : impersonations m2436 = [] := rfl
example : authentic m2436 = true := rfl
def m2440 : Model := ⟨["q"],[cred0],["challenge-1"],[],[a1]⟩
example : accepts m2440 a0 = false := rfl
example : accepts m2440 a1 = false := rfl
example : impersonations m2440 = [] := rfl
example : authentic m2440 = true := rfl
def m2444 : Model := ⟨["q"],[cred0],["challenge-1"],[],[a0,a1]⟩
example : accepts m2444 a0 = false := rfl
example : accepts m2444 a1 = false := rfl
example : impersonations m2444 = [] := rfl
example : authentic m2444 = true := rfl
def m2448 : Model := ⟨["q"],[cred0],["challenge-1"],[response0],[]⟩
example : accepts m2448 a0 = false := rfl
example : accepts m2448 a1 = false := rfl
example : impersonations m2448 = [] := rfl
example : authentic m2448 = true := rfl
def m2452 : Model := ⟨["q"],[cred0],["challenge-1"],[response0],[a0]⟩
example : accepts m2452 a0 = false := rfl
example : accepts m2452 a1 = false := rfl
example : impersonations m2452 = [] := rfl
example : authentic m2452 = true := rfl
def m2456 : Model := ⟨["q"],[cred0],["challenge-1"],[response0],[a1]⟩
example : accepts m2456 a0 = false := rfl
example : accepts m2456 a1 = false := rfl
example : impersonations m2456 = [] := rfl
example : authentic m2456 = true := rfl
def m2460 : Model := ⟨["q"],[cred0],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m2460 a0 = false := rfl
example : accepts m2460 a1 = false := rfl
example : impersonations m2460 = [] := rfl
example : authentic m2460 = true := rfl
def m2464 : Model := ⟨["q"],[cred0],["challenge-1"],[response1],[]⟩
example : accepts m2464 a0 = false := rfl
example : accepts m2464 a1 = false := rfl
example : impersonations m2464 = [] := rfl
example : authentic m2464 = true := rfl
def m2468 : Model := ⟨["q"],[cred0],["challenge-1"],[response1],[a0]⟩
example : accepts m2468 a0 = false := rfl
example : accepts m2468 a1 = false := rfl
example : impersonations m2468 = [] := rfl
example : authentic m2468 = true := rfl
def m2472 : Model := ⟨["q"],[cred0],["challenge-1"],[response1],[a1]⟩
example : accepts m2472 a0 = false := rfl
example : accepts m2472 a1 = false := rfl
example : impersonations m2472 = [] := rfl
example : authentic m2472 = true := rfl
def m2476 : Model := ⟨["q"],[cred0],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m2476 a0 = false := rfl
example : accepts m2476 a1 = false := rfl
example : impersonations m2476 = [] := rfl
example : authentic m2476 = true := rfl
def m2480 : Model := ⟨["q"],[cred0],["challenge-1"],[response0,response1],[]⟩
example : accepts m2480 a0 = false := rfl
example : accepts m2480 a1 = false := rfl
example : impersonations m2480 = [] := rfl
example : authentic m2480 = true := rfl
def m2484 : Model := ⟨["q"],[cred0],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m2484 a0 = false := rfl
example : accepts m2484 a1 = false := rfl
example : impersonations m2484 = [] := rfl
example : authentic m2484 = true := rfl
def m2488 : Model := ⟨["q"],[cred0],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m2488 a0 = false := rfl
example : accepts m2488 a1 = false := rfl
example : impersonations m2488 = [] := rfl
example : authentic m2488 = true := rfl
def m2492 : Model := ⟨["q"],[cred0],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2492 a0 = false := rfl
example : accepts m2492 a1 = false := rfl
example : impersonations m2492 = [] := rfl
example : authentic m2492 = true := rfl
def m2496 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[],[]⟩
example : accepts m2496 a0 = false := rfl
example : accepts m2496 a1 = false := rfl
example : impersonations m2496 = [] := rfl
example : authentic m2496 = true := rfl
def m2500 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m2500 a0 = false := rfl
example : accepts m2500 a1 = false := rfl
example : impersonations m2500 = [] := rfl
example : authentic m2500 = true := rfl
def m2504 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m2504 a0 = false := rfl
example : accepts m2504 a1 = false := rfl
example : impersonations m2504 = [] := rfl
example : authentic m2504 = true := rfl
def m2508 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m2508 a0 = false := rfl
example : accepts m2508 a1 = false := rfl
example : impersonations m2508 = [] := rfl
example : authentic m2508 = true := rfl
def m2512 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m2512 a0 = false := rfl
example : accepts m2512 a1 = false := rfl
example : impersonations m2512 = [] := rfl
example : authentic m2512 = true := rfl
def m2516 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m2516 a0 = false := rfl
example : accepts m2516 a1 = false := rfl
example : impersonations m2516 = [] := rfl
example : authentic m2516 = true := rfl
def m2520 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m2520 a0 = false := rfl
example : accepts m2520 a1 = false := rfl
example : impersonations m2520 = [] := rfl
example : authentic m2520 = true := rfl
def m2524 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m2524 a0 = false := rfl
example : accepts m2524 a1 = false := rfl
example : impersonations m2524 = [] := rfl
example : authentic m2524 = true := rfl
def m2528 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m2528 a0 = false := rfl
example : accepts m2528 a1 = false := rfl
example : impersonations m2528 = [] := rfl
example : authentic m2528 = true := rfl
def m2532 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m2532 a0 = false := rfl
example : accepts m2532 a1 = false := rfl
example : impersonations m2532 = [] := rfl
example : authentic m2532 = true := rfl
def m2536 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m2536 a0 = false := rfl
example : accepts m2536 a1 = false := rfl
example : impersonations m2536 = [] := rfl
example : authentic m2536 = true := rfl
def m2540 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m2540 a0 = false := rfl
example : accepts m2540 a1 = false := rfl
example : impersonations m2540 = [] := rfl
example : authentic m2540 = true := rfl
def m2544 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m2544 a0 = false := rfl
example : accepts m2544 a1 = false := rfl
example : impersonations m2544 = [] := rfl
example : authentic m2544 = true := rfl
def m2548 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m2548 a0 = false := rfl
example : accepts m2548 a1 = false := rfl
example : impersonations m2548 = [] := rfl
example : authentic m2548 = true := rfl
def m2552 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m2552 a0 = false := rfl
example : accepts m2552 a1 = false := rfl
example : impersonations m2552 = [] := rfl
example : authentic m2552 = true := rfl
def m2556 : Model := ⟨["q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2556 a0 = false := rfl
example : accepts m2556 a1 = false := rfl
example : impersonations m2556 = [] := rfl
example : authentic m2556 = true := rfl
def m2560 : Model := ⟨["q"],[cred1],[],[],[]⟩
example : accepts m2560 a0 = false := rfl
example : accepts m2560 a1 = false := rfl
example : impersonations m2560 = [] := rfl
example : authentic m2560 = true := rfl
def m2564 : Model := ⟨["q"],[cred1],[],[],[a0]⟩
example : accepts m2564 a0 = false := rfl
example : accepts m2564 a1 = false := rfl
example : impersonations m2564 = [] := rfl
example : authentic m2564 = true := rfl
def m2568 : Model := ⟨["q"],[cred1],[],[],[a1]⟩
example : accepts m2568 a0 = false := rfl
example : accepts m2568 a1 = false := rfl
example : impersonations m2568 = [] := rfl
example : authentic m2568 = true := rfl
def m2572 : Model := ⟨["q"],[cred1],[],[],[a0,a1]⟩
example : accepts m2572 a0 = false := rfl
example : accepts m2572 a1 = false := rfl
example : impersonations m2572 = [] := rfl
example : authentic m2572 = true := rfl
def m2576 : Model := ⟨["q"],[cred1],[],[response0],[]⟩
example : accepts m2576 a0 = false := rfl
example : accepts m2576 a1 = false := rfl
example : impersonations m2576 = [] := rfl
example : authentic m2576 = true := rfl
def m2580 : Model := ⟨["q"],[cred1],[],[response0],[a0]⟩
example : accepts m2580 a0 = false := rfl
example : accepts m2580 a1 = false := rfl
example : impersonations m2580 = [] := rfl
example : authentic m2580 = true := rfl
def m2584 : Model := ⟨["q"],[cred1],[],[response0],[a1]⟩
example : accepts m2584 a0 = false := rfl
example : accepts m2584 a1 = false := rfl
example : impersonations m2584 = [] := rfl
example : authentic m2584 = true := rfl
def m2588 : Model := ⟨["q"],[cred1],[],[response0],[a0,a1]⟩
example : accepts m2588 a0 = false := rfl
example : accepts m2588 a1 = false := rfl
example : impersonations m2588 = [] := rfl
example : authentic m2588 = true := rfl
def m2592 : Model := ⟨["q"],[cred1],[],[response1],[]⟩
example : accepts m2592 a0 = false := rfl
example : accepts m2592 a1 = false := rfl
example : impersonations m2592 = [] := rfl
example : authentic m2592 = true := rfl
def m2596 : Model := ⟨["q"],[cred1],[],[response1],[a0]⟩
example : accepts m2596 a0 = false := rfl
example : accepts m2596 a1 = false := rfl
example : impersonations m2596 = [] := rfl
example : authentic m2596 = true := rfl
def m2600 : Model := ⟨["q"],[cred1],[],[response1],[a1]⟩
example : accepts m2600 a0 = false := rfl
example : accepts m2600 a1 = false := rfl
example : impersonations m2600 = [] := rfl
example : authentic m2600 = true := rfl
def m2604 : Model := ⟨["q"],[cred1],[],[response1],[a0,a1]⟩
example : accepts m2604 a0 = false := rfl
example : accepts m2604 a1 = false := rfl
example : impersonations m2604 = [] := rfl
example : authentic m2604 = true := rfl
def m2608 : Model := ⟨["q"],[cred1],[],[response0,response1],[]⟩
example : accepts m2608 a0 = false := rfl
example : accepts m2608 a1 = false := rfl
example : impersonations m2608 = [] := rfl
example : authentic m2608 = true := rfl
def m2612 : Model := ⟨["q"],[cred1],[],[response0,response1],[a0]⟩
example : accepts m2612 a0 = false := rfl
example : accepts m2612 a1 = false := rfl
example : impersonations m2612 = [] := rfl
example : authentic m2612 = true := rfl
def m2616 : Model := ⟨["q"],[cred1],[],[response0,response1],[a1]⟩
example : accepts m2616 a0 = false := rfl
example : accepts m2616 a1 = false := rfl
example : impersonations m2616 = [] := rfl
example : authentic m2616 = true := rfl
def m2620 : Model := ⟨["q"],[cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m2620 a0 = false := rfl
example : accepts m2620 a1 = false := rfl
example : impersonations m2620 = [] := rfl
example : authentic m2620 = true := rfl
def m2624 : Model := ⟨["q"],[cred1],["challenge-0"],[],[]⟩
example : accepts m2624 a0 = false := rfl
example : accepts m2624 a1 = false := rfl
example : impersonations m2624 = [] := rfl
example : authentic m2624 = true := rfl
def m2628 : Model := ⟨["q"],[cred1],["challenge-0"],[],[a0]⟩
example : accepts m2628 a0 = false := rfl
example : accepts m2628 a1 = false := rfl
example : impersonations m2628 = [] := rfl
example : authentic m2628 = true := rfl
def m2632 : Model := ⟨["q"],[cred1],["challenge-0"],[],[a1]⟩
example : accepts m2632 a0 = false := rfl
example : accepts m2632 a1 = false := rfl
example : impersonations m2632 = [] := rfl
example : authentic m2632 = true := rfl
def m2636 : Model := ⟨["q"],[cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m2636 a0 = false := rfl
example : accepts m2636 a1 = false := rfl
example : impersonations m2636 = [] := rfl
example : authentic m2636 = true := rfl
def m2640 : Model := ⟨["q"],[cred1],["challenge-0"],[response0],[]⟩
example : accepts m2640 a0 = false := rfl
example : accepts m2640 a1 = false := rfl
example : impersonations m2640 = [] := rfl
example : authentic m2640 = true := rfl
def m2644 : Model := ⟨["q"],[cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m2644 a0 = false := rfl
example : accepts m2644 a1 = false := rfl
example : impersonations m2644 = [] := rfl
example : authentic m2644 = true := rfl
def m2648 : Model := ⟨["q"],[cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m2648 a0 = false := rfl
example : accepts m2648 a1 = false := rfl
example : impersonations m2648 = [] := rfl
example : authentic m2648 = true := rfl
def m2652 : Model := ⟨["q"],[cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m2652 a0 = false := rfl
example : accepts m2652 a1 = false := rfl
example : impersonations m2652 = [] := rfl
example : authentic m2652 = true := rfl
def m2656 : Model := ⟨["q"],[cred1],["challenge-0"],[response1],[]⟩
example : accepts m2656 a0 = false := rfl
example : accepts m2656 a1 = false := rfl
example : impersonations m2656 = [] := rfl
example : authentic m2656 = true := rfl
def m2660 : Model := ⟨["q"],[cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m2660 a0 = false := rfl
example : accepts m2660 a1 = false := rfl
example : impersonations m2660 = [] := rfl
example : authentic m2660 = true := rfl
def m2664 : Model := ⟨["q"],[cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m2664 a0 = false := rfl
example : accepts m2664 a1 = false := rfl
example : impersonations m2664 = [] := rfl
example : authentic m2664 = true := rfl
def m2668 : Model := ⟨["q"],[cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m2668 a0 = false := rfl
example : accepts m2668 a1 = false := rfl
example : impersonations m2668 = [] := rfl
example : authentic m2668 = true := rfl
def m2672 : Model := ⟨["q"],[cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m2672 a0 = false := rfl
example : accepts m2672 a1 = false := rfl
example : impersonations m2672 = [] := rfl
example : authentic m2672 = true := rfl
def m2676 : Model := ⟨["q"],[cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m2676 a0 = false := rfl
example : accepts m2676 a1 = false := rfl
example : impersonations m2676 = [] := rfl
example : authentic m2676 = true := rfl
def m2680 : Model := ⟨["q"],[cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m2680 a0 = false := rfl
example : accepts m2680 a1 = false := rfl
example : impersonations m2680 = [] := rfl
example : authentic m2680 = true := rfl
def m2684 : Model := ⟨["q"],[cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m2684 a0 = false := rfl
example : accepts m2684 a1 = false := rfl
example : impersonations m2684 = [] := rfl
example : authentic m2684 = true := rfl
def m2688 : Model := ⟨["q"],[cred1],["challenge-1"],[],[]⟩
example : accepts m2688 a0 = false := rfl
example : accepts m2688 a1 = false := rfl
example : impersonations m2688 = [] := rfl
example : authentic m2688 = true := rfl
def m2692 : Model := ⟨["q"],[cred1],["challenge-1"],[],[a0]⟩
example : accepts m2692 a0 = false := rfl
example : accepts m2692 a1 = false := rfl
example : impersonations m2692 = [] := rfl
example : authentic m2692 = true := rfl
def m2696 : Model := ⟨["q"],[cred1],["challenge-1"],[],[a1]⟩
example : accepts m2696 a0 = false := rfl
example : accepts m2696 a1 = false := rfl
example : impersonations m2696 = [] := rfl
example : authentic m2696 = true := rfl
def m2700 : Model := ⟨["q"],[cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m2700 a0 = false := rfl
example : accepts m2700 a1 = false := rfl
example : impersonations m2700 = [] := rfl
example : authentic m2700 = true := rfl
def m2704 : Model := ⟨["q"],[cred1],["challenge-1"],[response0],[]⟩
example : accepts m2704 a0 = false := rfl
example : accepts m2704 a1 = false := rfl
example : impersonations m2704 = [] := rfl
example : authentic m2704 = true := rfl
def m2708 : Model := ⟨["q"],[cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m2708 a0 = false := rfl
example : accepts m2708 a1 = false := rfl
example : impersonations m2708 = [] := rfl
example : authentic m2708 = true := rfl
def m2712 : Model := ⟨["q"],[cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m2712 a0 = false := rfl
example : accepts m2712 a1 = false := rfl
example : impersonations m2712 = [] := rfl
example : authentic m2712 = true := rfl
def m2716 : Model := ⟨["q"],[cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m2716 a0 = false := rfl
example : accepts m2716 a1 = false := rfl
example : impersonations m2716 = [] := rfl
example : authentic m2716 = true := rfl
def m2720 : Model := ⟨["q"],[cred1],["challenge-1"],[response1],[]⟩
example : accepts m2720 a0 = false := rfl
example : accepts m2720 a1 = false := rfl
example : impersonations m2720 = [] := rfl
example : authentic m2720 = true := rfl
def m2724 : Model := ⟨["q"],[cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m2724 a0 = false := rfl
example : accepts m2724 a1 = false := rfl
example : impersonations m2724 = [] := rfl
example : authentic m2724 = true := rfl
def m2728 : Model := ⟨["q"],[cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m2728 a0 = false := rfl
example : accepts m2728 a1 = false := rfl
example : impersonations m2728 = [] := rfl
example : authentic m2728 = true := rfl
def m2732 : Model := ⟨["q"],[cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m2732 a0 = false := rfl
example : accepts m2732 a1 = false := rfl
example : impersonations m2732 = [] := rfl
example : authentic m2732 = true := rfl
def m2736 : Model := ⟨["q"],[cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m2736 a0 = false := rfl
example : accepts m2736 a1 = false := rfl
example : impersonations m2736 = [] := rfl
example : authentic m2736 = true := rfl
def m2740 : Model := ⟨["q"],[cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m2740 a0 = false := rfl
example : accepts m2740 a1 = false := rfl
example : impersonations m2740 = [] := rfl
example : authentic m2740 = true := rfl
def m2744 : Model := ⟨["q"],[cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m2744 a0 = false := rfl
example : accepts m2744 a1 = false := rfl
example : impersonations m2744 = [] := rfl
example : authentic m2744 = true := rfl
def m2748 : Model := ⟨["q"],[cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2748 a0 = false := rfl
example : accepts m2748 a1 = false := rfl
example : impersonations m2748 = [] := rfl
example : authentic m2748 = true := rfl
def m2752 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m2752 a0 = false := rfl
example : accepts m2752 a1 = false := rfl
example : impersonations m2752 = [] := rfl
example : authentic m2752 = true := rfl
def m2756 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m2756 a0 = false := rfl
example : accepts m2756 a1 = false := rfl
example : impersonations m2756 = [] := rfl
example : authentic m2756 = true := rfl
def m2760 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m2760 a0 = false := rfl
example : accepts m2760 a1 = false := rfl
example : impersonations m2760 = [] := rfl
example : authentic m2760 = true := rfl
def m2764 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m2764 a0 = false := rfl
example : accepts m2764 a1 = false := rfl
example : impersonations m2764 = [] := rfl
example : authentic m2764 = true := rfl
def m2768 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m2768 a0 = false := rfl
example : accepts m2768 a1 = false := rfl
example : impersonations m2768 = [] := rfl
example : authentic m2768 = true := rfl
def m2772 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m2772 a0 = false := rfl
example : accepts m2772 a1 = false := rfl
example : impersonations m2772 = [] := rfl
example : authentic m2772 = true := rfl
def m2776 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m2776 a0 = false := rfl
example : accepts m2776 a1 = false := rfl
example : impersonations m2776 = [] := rfl
example : authentic m2776 = true := rfl
def m2780 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m2780 a0 = false := rfl
example : accepts m2780 a1 = false := rfl
example : impersonations m2780 = [] := rfl
example : authentic m2780 = true := rfl
def m2784 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m2784 a0 = false := rfl
example : accepts m2784 a1 = false := rfl
example : impersonations m2784 = [] := rfl
example : authentic m2784 = true := rfl
def m2788 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m2788 a0 = false := rfl
example : accepts m2788 a1 = false := rfl
example : impersonations m2788 = [] := rfl
example : authentic m2788 = true := rfl
def m2792 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m2792 a0 = false := rfl
example : accepts m2792 a1 = false := rfl
example : impersonations m2792 = [] := rfl
example : authentic m2792 = true := rfl
def m2796 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m2796 a0 = false := rfl
example : accepts m2796 a1 = false := rfl
example : impersonations m2796 = [] := rfl
example : authentic m2796 = true := rfl
def m2800 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m2800 a0 = false := rfl
example : accepts m2800 a1 = false := rfl
example : impersonations m2800 = [] := rfl
example : authentic m2800 = true := rfl
def m2804 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m2804 a0 = false := rfl
example : accepts m2804 a1 = false := rfl
example : impersonations m2804 = [] := rfl
example : authentic m2804 = true := rfl
def m2808 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m2808 a0 = false := rfl
example : accepts m2808 a1 = false := rfl
example : impersonations m2808 = [] := rfl
example : authentic m2808 = true := rfl
def m2812 : Model := ⟨["q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m2812 a0 = false := rfl
example : accepts m2812 a1 = false := rfl
example : impersonations m2812 = [] := rfl
example : authentic m2812 = true := rfl
def m2816 : Model := ⟨["q"],[cred0,cred1],[],[],[]⟩
example : accepts m2816 a0 = false := rfl
example : accepts m2816 a1 = false := rfl
example : impersonations m2816 = [] := rfl
example : authentic m2816 = true := rfl
def m2820 : Model := ⟨["q"],[cred0,cred1],[],[],[a0]⟩
example : accepts m2820 a0 = false := rfl
example : accepts m2820 a1 = false := rfl
example : impersonations m2820 = [] := rfl
example : authentic m2820 = true := rfl
def m2824 : Model := ⟨["q"],[cred0,cred1],[],[],[a1]⟩
example : accepts m2824 a0 = false := rfl
example : accepts m2824 a1 = false := rfl
example : impersonations m2824 = [] := rfl
example : authentic m2824 = true := rfl
def m2828 : Model := ⟨["q"],[cred0,cred1],[],[],[a0,a1]⟩
example : accepts m2828 a0 = false := rfl
example : accepts m2828 a1 = false := rfl
example : impersonations m2828 = [] := rfl
example : authentic m2828 = true := rfl
def m2832 : Model := ⟨["q"],[cred0,cred1],[],[response0],[]⟩
example : accepts m2832 a0 = false := rfl
example : accepts m2832 a1 = false := rfl
example : impersonations m2832 = [] := rfl
example : authentic m2832 = true := rfl
def m2836 : Model := ⟨["q"],[cred0,cred1],[],[response0],[a0]⟩
example : accepts m2836 a0 = false := rfl
example : accepts m2836 a1 = false := rfl
example : impersonations m2836 = [] := rfl
example : authentic m2836 = true := rfl
def m2840 : Model := ⟨["q"],[cred0,cred1],[],[response0],[a1]⟩
example : accepts m2840 a0 = false := rfl
example : accepts m2840 a1 = false := rfl
example : impersonations m2840 = [] := rfl
example : authentic m2840 = true := rfl
def m2844 : Model := ⟨["q"],[cred0,cred1],[],[response0],[a0,a1]⟩
example : accepts m2844 a0 = false := rfl
example : accepts m2844 a1 = false := rfl
example : impersonations m2844 = [] := rfl
example : authentic m2844 = true := rfl
def m2848 : Model := ⟨["q"],[cred0,cred1],[],[response1],[]⟩
example : accepts m2848 a0 = false := rfl
example : accepts m2848 a1 = false := rfl
example : impersonations m2848 = [] := rfl
example : authentic m2848 = true := rfl
def m2852 : Model := ⟨["q"],[cred0,cred1],[],[response1],[a0]⟩
example : accepts m2852 a0 = false := rfl
example : accepts m2852 a1 = false := rfl
example : impersonations m2852 = [] := rfl
example : authentic m2852 = true := rfl
def m2856 : Model := ⟨["q"],[cred0,cred1],[],[response1],[a1]⟩
example : accepts m2856 a0 = false := rfl
example : accepts m2856 a1 = false := rfl
example : impersonations m2856 = [] := rfl
example : authentic m2856 = true := rfl
def m2860 : Model := ⟨["q"],[cred0,cred1],[],[response1],[a0,a1]⟩
example : accepts m2860 a0 = false := rfl
example : accepts m2860 a1 = false := rfl
example : impersonations m2860 = [] := rfl
example : authentic m2860 = true := rfl
def m2864 : Model := ⟨["q"],[cred0,cred1],[],[response0,response1],[]⟩
example : accepts m2864 a0 = false := rfl
example : accepts m2864 a1 = false := rfl
example : impersonations m2864 = [] := rfl
example : authentic m2864 = true := rfl
def m2868 : Model := ⟨["q"],[cred0,cred1],[],[response0,response1],[a0]⟩
example : accepts m2868 a0 = false := rfl
example : accepts m2868 a1 = false := rfl
example : impersonations m2868 = [] := rfl
example : authentic m2868 = true := rfl
def m2872 : Model := ⟨["q"],[cred0,cred1],[],[response0,response1],[a1]⟩
example : accepts m2872 a0 = false := rfl
example : accepts m2872 a1 = false := rfl
example : impersonations m2872 = [] := rfl
example : authentic m2872 = true := rfl
def m2876 : Model := ⟨["q"],[cred0,cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m2876 a0 = false := rfl
example : accepts m2876 a1 = false := rfl
example : impersonations m2876 = [] := rfl
example : authentic m2876 = true := rfl
def m2880 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[],[]⟩
example : accepts m2880 a0 = false := rfl
example : accepts m2880 a1 = false := rfl
example : impersonations m2880 = [] := rfl
example : authentic m2880 = true := rfl
def m2884 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[],[a0]⟩
example : accepts m2884 a0 = false := rfl
example : accepts m2884 a1 = false := rfl
example : impersonations m2884 = [] := rfl
example : authentic m2884 = true := rfl
def m2888 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[],[a1]⟩
example : accepts m2888 a0 = false := rfl
example : accepts m2888 a1 = false := rfl
example : impersonations m2888 = [] := rfl
example : authentic m2888 = true := rfl
def m2892 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m2892 a0 = false := rfl
example : accepts m2892 a1 = false := rfl
example : impersonations m2892 = [] := rfl
example : authentic m2892 = true := rfl
def m2896 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0],[]⟩
example : accepts m2896 a0 = false := rfl
example : accepts m2896 a1 = false := rfl
example : impersonations m2896 = [] := rfl
example : authentic m2896 = true := rfl
def m2900 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m2900 a0 = false := rfl
example : accepts m2900 a1 = false := rfl
example : impersonations m2900 = [] := rfl
example : authentic m2900 = true := rfl
def m2904 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m2904 a0 = false := rfl
example : accepts m2904 a1 = false := rfl
example : impersonations m2904 = [] := rfl
example : authentic m2904 = true := rfl
def m2908 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m2908 a0 = false := rfl
example : accepts m2908 a1 = false := rfl
example : impersonations m2908 = [] := rfl
example : authentic m2908 = true := rfl
def m2912 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response1],[]⟩
example : accepts m2912 a0 = false := rfl
example : accepts m2912 a1 = false := rfl
example : impersonations m2912 = [] := rfl
example : authentic m2912 = true := rfl
def m2916 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m2916 a0 = false := rfl
example : accepts m2916 a1 = false := rfl
example : impersonations m2916 = [] := rfl
example : authentic m2916 = true := rfl
def m2920 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m2920 a0 = false := rfl
example : accepts m2920 a1 = false := rfl
example : impersonations m2920 = [] := rfl
example : authentic m2920 = true := rfl
def m2924 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m2924 a0 = false := rfl
example : accepts m2924 a1 = false := rfl
example : impersonations m2924 = [] := rfl
example : authentic m2924 = true := rfl
def m2928 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m2928 a0 = false := rfl
example : accepts m2928 a1 = false := rfl
example : impersonations m2928 = [] := rfl
example : authentic m2928 = true := rfl
def m2932 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m2932 a0 = false := rfl
example : accepts m2932 a1 = false := rfl
example : impersonations m2932 = [] := rfl
example : authentic m2932 = true := rfl
def m2936 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m2936 a0 = false := rfl
example : accepts m2936 a1 = false := rfl
example : impersonations m2936 = [] := rfl
example : authentic m2936 = true := rfl
def m2940 : Model := ⟨["q"],[cred0,cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m2940 a0 = false := rfl
example : accepts m2940 a1 = false := rfl
example : impersonations m2940 = [] := rfl
example : authentic m2940 = true := rfl
def m2944 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[],[]⟩
example : accepts m2944 a0 = false := rfl
example : accepts m2944 a1 = false := rfl
example : impersonations m2944 = [] := rfl
example : authentic m2944 = true := rfl
def m2948 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[],[a0]⟩
example : accepts m2948 a0 = false := rfl
example : accepts m2948 a1 = false := rfl
example : impersonations m2948 = [] := rfl
example : authentic m2948 = true := rfl
def m2952 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[],[a1]⟩
example : accepts m2952 a0 = false := rfl
example : accepts m2952 a1 = false := rfl
example : impersonations m2952 = [] := rfl
example : authentic m2952 = true := rfl
def m2956 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m2956 a0 = false := rfl
example : accepts m2956 a1 = false := rfl
example : impersonations m2956 = [] := rfl
example : authentic m2956 = true := rfl
def m2960 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0],[]⟩
example : accepts m2960 a0 = false := rfl
example : accepts m2960 a1 = false := rfl
example : impersonations m2960 = [] := rfl
example : authentic m2960 = true := rfl
def m2964 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m2964 a0 = false := rfl
example : accepts m2964 a1 = false := rfl
example : impersonations m2964 = [] := rfl
example : authentic m2964 = true := rfl
def m2968 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m2968 a0 = false := rfl
example : accepts m2968 a1 = false := rfl
example : impersonations m2968 = [] := rfl
example : authentic m2968 = true := rfl
def m2972 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m2972 a0 = false := rfl
example : accepts m2972 a1 = false := rfl
example : impersonations m2972 = [] := rfl
example : authentic m2972 = true := rfl
def m2976 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response1],[]⟩
example : accepts m2976 a0 = false := rfl
example : accepts m2976 a1 = false := rfl
example : impersonations m2976 = [] := rfl
example : authentic m2976 = true := rfl
def m2980 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m2980 a0 = false := rfl
example : accepts m2980 a1 = false := rfl
example : impersonations m2980 = [] := rfl
example : authentic m2980 = true := rfl
def m2984 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m2984 a0 = false := rfl
example : accepts m2984 a1 = false := rfl
example : impersonations m2984 = [] := rfl
example : authentic m2984 = true := rfl
def m2988 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m2988 a0 = false := rfl
example : accepts m2988 a1 = false := rfl
example : impersonations m2988 = [] := rfl
example : authentic m2988 = true := rfl
def m2992 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m2992 a0 = false := rfl
example : accepts m2992 a1 = false := rfl
example : impersonations m2992 = [] := rfl
example : authentic m2992 = true := rfl
def m2996 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m2996 a0 = false := rfl
example : accepts m2996 a1 = false := rfl
example : impersonations m2996 = [] := rfl
example : authentic m2996 = true := rfl
def m3000 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m3000 a0 = false := rfl
example : accepts m3000 a1 = false := rfl
example : impersonations m3000 = [] := rfl
example : authentic m3000 = true := rfl
def m3004 : Model := ⟨["q"],[cred0,cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3004 a0 = false := rfl
example : accepts m3004 a1 = false := rfl
example : impersonations m3004 = [] := rfl
example : authentic m3004 = true := rfl
def m3008 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m3008 a0 = false := rfl
example : accepts m3008 a1 = false := rfl
example : impersonations m3008 = [] := rfl
example : authentic m3008 = true := rfl
def m3012 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m3012 a0 = false := rfl
example : accepts m3012 a1 = false := rfl
example : impersonations m3012 = [] := rfl
example : authentic m3012 = true := rfl
def m3016 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m3016 a0 = false := rfl
example : accepts m3016 a1 = false := rfl
example : impersonations m3016 = [] := rfl
example : authentic m3016 = true := rfl
def m3020 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m3020 a0 = false := rfl
example : accepts m3020 a1 = false := rfl
example : impersonations m3020 = [] := rfl
example : authentic m3020 = true := rfl
def m3024 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m3024 a0 = false := rfl
example : accepts m3024 a1 = false := rfl
example : impersonations m3024 = [] := rfl
example : authentic m3024 = true := rfl
def m3028 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m3028 a0 = false := rfl
example : accepts m3028 a1 = false := rfl
example : impersonations m3028 = [] := rfl
example : authentic m3028 = true := rfl
def m3032 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m3032 a0 = false := rfl
example : accepts m3032 a1 = false := rfl
example : impersonations m3032 = [] := rfl
example : authentic m3032 = true := rfl
def m3036 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m3036 a0 = false := rfl
example : accepts m3036 a1 = false := rfl
example : impersonations m3036 = [] := rfl
example : authentic m3036 = true := rfl
def m3040 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m3040 a0 = false := rfl
example : accepts m3040 a1 = false := rfl
example : impersonations m3040 = [] := rfl
example : authentic m3040 = true := rfl
def m3044 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m3044 a0 = false := rfl
example : accepts m3044 a1 = false := rfl
example : impersonations m3044 = [] := rfl
example : authentic m3044 = true := rfl
def m3048 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m3048 a0 = false := rfl
example : accepts m3048 a1 = false := rfl
example : impersonations m3048 = [] := rfl
example : authentic m3048 = true := rfl
def m3052 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m3052 a0 = false := rfl
example : accepts m3052 a1 = false := rfl
example : impersonations m3052 = [] := rfl
example : authentic m3052 = true := rfl
def m3056 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m3056 a0 = false := rfl
example : accepts m3056 a1 = false := rfl
example : impersonations m3056 = [] := rfl
example : authentic m3056 = true := rfl
def m3060 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m3060 a0 = false := rfl
example : accepts m3060 a1 = false := rfl
example : impersonations m3060 = [] := rfl
example : authentic m3060 = true := rfl
def m3064 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m3064 a0 = false := rfl
example : accepts m3064 a1 = false := rfl
example : impersonations m3064 = [] := rfl
example : authentic m3064 = true := rfl
def m3068 : Model := ⟨["q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3068 a0 = false := rfl
example : accepts m3068 a1 = false := rfl
example : impersonations m3068 = [] := rfl
example : authentic m3068 = true := rfl
def m3072 : Model := ⟨["p","q"],[],[],[],[]⟩
example : accepts m3072 a0 = false := rfl
example : accepts m3072 a1 = false := rfl
example : impersonations m3072 = [] := rfl
example : authentic m3072 = true := rfl
def m3076 : Model := ⟨["p","q"],[],[],[],[a0]⟩
example : accepts m3076 a0 = false := rfl
example : accepts m3076 a1 = false := rfl
example : impersonations m3076 = [] := rfl
example : authentic m3076 = true := rfl
def m3080 : Model := ⟨["p","q"],[],[],[],[a1]⟩
example : accepts m3080 a0 = false := rfl
example : accepts m3080 a1 = false := rfl
example : impersonations m3080 = [] := rfl
example : authentic m3080 = true := rfl
def m3084 : Model := ⟨["p","q"],[],[],[],[a0,a1]⟩
example : accepts m3084 a0 = false := rfl
example : accepts m3084 a1 = false := rfl
example : impersonations m3084 = [] := rfl
example : authentic m3084 = true := rfl
def m3088 : Model := ⟨["p","q"],[],[],[response0],[]⟩
example : accepts m3088 a0 = false := rfl
example : accepts m3088 a1 = false := rfl
example : impersonations m3088 = [] := rfl
example : authentic m3088 = true := rfl
def m3092 : Model := ⟨["p","q"],[],[],[response0],[a0]⟩
example : accepts m3092 a0 = false := rfl
example : accepts m3092 a1 = false := rfl
example : impersonations m3092 = [] := rfl
example : authentic m3092 = true := rfl
def m3096 : Model := ⟨["p","q"],[],[],[response0],[a1]⟩
example : accepts m3096 a0 = false := rfl
example : accepts m3096 a1 = false := rfl
example : impersonations m3096 = [] := rfl
example : authentic m3096 = true := rfl
def m3100 : Model := ⟨["p","q"],[],[],[response0],[a0,a1]⟩
example : accepts m3100 a0 = false := rfl
example : accepts m3100 a1 = false := rfl
example : impersonations m3100 = [] := rfl
example : authentic m3100 = true := rfl
def m3104 : Model := ⟨["p","q"],[],[],[response1],[]⟩
example : accepts m3104 a0 = false := rfl
example : accepts m3104 a1 = false := rfl
example : impersonations m3104 = [] := rfl
example : authentic m3104 = true := rfl
def m3108 : Model := ⟨["p","q"],[],[],[response1],[a0]⟩
example : accepts m3108 a0 = false := rfl
example : accepts m3108 a1 = false := rfl
example : impersonations m3108 = [] := rfl
example : authentic m3108 = true := rfl
def m3112 : Model := ⟨["p","q"],[],[],[response1],[a1]⟩
example : accepts m3112 a0 = false := rfl
example : accepts m3112 a1 = false := rfl
example : impersonations m3112 = [] := rfl
example : authentic m3112 = true := rfl
def m3116 : Model := ⟨["p","q"],[],[],[response1],[a0,a1]⟩
example : accepts m3116 a0 = false := rfl
example : accepts m3116 a1 = false := rfl
example : impersonations m3116 = [] := rfl
example : authentic m3116 = true := rfl
def m3120 : Model := ⟨["p","q"],[],[],[response0,response1],[]⟩
example : accepts m3120 a0 = false := rfl
example : accepts m3120 a1 = false := rfl
example : impersonations m3120 = [] := rfl
example : authentic m3120 = true := rfl
def m3124 : Model := ⟨["p","q"],[],[],[response0,response1],[a0]⟩
example : accepts m3124 a0 = false := rfl
example : accepts m3124 a1 = false := rfl
example : impersonations m3124 = [] := rfl
example : authentic m3124 = true := rfl
def m3128 : Model := ⟨["p","q"],[],[],[response0,response1],[a1]⟩
example : accepts m3128 a0 = false := rfl
example : accepts m3128 a1 = false := rfl
example : impersonations m3128 = [] := rfl
example : authentic m3128 = true := rfl
def m3132 : Model := ⟨["p","q"],[],[],[response0,response1],[a0,a1]⟩
example : accepts m3132 a0 = false := rfl
example : accepts m3132 a1 = false := rfl
example : impersonations m3132 = [] := rfl
example : authentic m3132 = true := rfl
def m3136 : Model := ⟨["p","q"],[],["challenge-0"],[],[]⟩
example : accepts m3136 a0 = false := rfl
example : accepts m3136 a1 = false := rfl
example : impersonations m3136 = [] := rfl
example : authentic m3136 = true := rfl
def m3140 : Model := ⟨["p","q"],[],["challenge-0"],[],[a0]⟩
example : accepts m3140 a0 = false := rfl
example : accepts m3140 a1 = false := rfl
example : impersonations m3140 = [] := rfl
example : authentic m3140 = true := rfl
def m3144 : Model := ⟨["p","q"],[],["challenge-0"],[],[a1]⟩
example : accepts m3144 a0 = false := rfl
example : accepts m3144 a1 = false := rfl
example : impersonations m3144 = [] := rfl
example : authentic m3144 = true := rfl
def m3148 : Model := ⟨["p","q"],[],["challenge-0"],[],[a0,a1]⟩
example : accepts m3148 a0 = false := rfl
example : accepts m3148 a1 = false := rfl
example : impersonations m3148 = [] := rfl
example : authentic m3148 = true := rfl
def m3152 : Model := ⟨["p","q"],[],["challenge-0"],[response0],[]⟩
example : accepts m3152 a0 = false := rfl
example : accepts m3152 a1 = false := rfl
example : impersonations m3152 = [] := rfl
example : authentic m3152 = true := rfl
def m3156 : Model := ⟨["p","q"],[],["challenge-0"],[response0],[a0]⟩
example : accepts m3156 a0 = false := rfl
example : accepts m3156 a1 = false := rfl
example : impersonations m3156 = [] := rfl
example : authentic m3156 = true := rfl
def m3160 : Model := ⟨["p","q"],[],["challenge-0"],[response0],[a1]⟩
example : accepts m3160 a0 = false := rfl
example : accepts m3160 a1 = false := rfl
example : impersonations m3160 = [] := rfl
example : authentic m3160 = true := rfl
def m3164 : Model := ⟨["p","q"],[],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m3164 a0 = false := rfl
example : accepts m3164 a1 = false := rfl
example : impersonations m3164 = [] := rfl
example : authentic m3164 = true := rfl
def m3168 : Model := ⟨["p","q"],[],["challenge-0"],[response1],[]⟩
example : accepts m3168 a0 = false := rfl
example : accepts m3168 a1 = false := rfl
example : impersonations m3168 = [] := rfl
example : authentic m3168 = true := rfl
def m3172 : Model := ⟨["p","q"],[],["challenge-0"],[response1],[a0]⟩
example : accepts m3172 a0 = false := rfl
example : accepts m3172 a1 = false := rfl
example : impersonations m3172 = [] := rfl
example : authentic m3172 = true := rfl
def m3176 : Model := ⟨["p","q"],[],["challenge-0"],[response1],[a1]⟩
example : accepts m3176 a0 = false := rfl
example : accepts m3176 a1 = false := rfl
example : impersonations m3176 = [] := rfl
example : authentic m3176 = true := rfl
def m3180 : Model := ⟨["p","q"],[],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m3180 a0 = false := rfl
example : accepts m3180 a1 = false := rfl
example : impersonations m3180 = [] := rfl
example : authentic m3180 = true := rfl
def m3184 : Model := ⟨["p","q"],[],["challenge-0"],[response0,response1],[]⟩
example : accepts m3184 a0 = false := rfl
example : accepts m3184 a1 = false := rfl
example : impersonations m3184 = [] := rfl
example : authentic m3184 = true := rfl
def m3188 : Model := ⟨["p","q"],[],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m3188 a0 = false := rfl
example : accepts m3188 a1 = false := rfl
example : impersonations m3188 = [] := rfl
example : authentic m3188 = true := rfl
def m3192 : Model := ⟨["p","q"],[],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m3192 a0 = false := rfl
example : accepts m3192 a1 = false := rfl
example : impersonations m3192 = [] := rfl
example : authentic m3192 = true := rfl
def m3196 : Model := ⟨["p","q"],[],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m3196 a0 = false := rfl
example : accepts m3196 a1 = false := rfl
example : impersonations m3196 = [] := rfl
example : authentic m3196 = true := rfl
def m3200 : Model := ⟨["p","q"],[],["challenge-1"],[],[]⟩
example : accepts m3200 a0 = false := rfl
example : accepts m3200 a1 = false := rfl
example : impersonations m3200 = [] := rfl
example : authentic m3200 = true := rfl
def m3204 : Model := ⟨["p","q"],[],["challenge-1"],[],[a0]⟩
example : accepts m3204 a0 = false := rfl
example : accepts m3204 a1 = false := rfl
example : impersonations m3204 = [] := rfl
example : authentic m3204 = true := rfl
def m3208 : Model := ⟨["p","q"],[],["challenge-1"],[],[a1]⟩
example : accepts m3208 a0 = false := rfl
example : accepts m3208 a1 = false := rfl
example : impersonations m3208 = [] := rfl
example : authentic m3208 = true := rfl
def m3212 : Model := ⟨["p","q"],[],["challenge-1"],[],[a0,a1]⟩
example : accepts m3212 a0 = false := rfl
example : accepts m3212 a1 = false := rfl
example : impersonations m3212 = [] := rfl
example : authentic m3212 = true := rfl
def m3216 : Model := ⟨["p","q"],[],["challenge-1"],[response0],[]⟩
example : accepts m3216 a0 = false := rfl
example : accepts m3216 a1 = false := rfl
example : impersonations m3216 = [] := rfl
example : authentic m3216 = true := rfl
def m3220 : Model := ⟨["p","q"],[],["challenge-1"],[response0],[a0]⟩
example : accepts m3220 a0 = false := rfl
example : accepts m3220 a1 = false := rfl
example : impersonations m3220 = [] := rfl
example : authentic m3220 = true := rfl
def m3224 : Model := ⟨["p","q"],[],["challenge-1"],[response0],[a1]⟩
example : accepts m3224 a0 = false := rfl
example : accepts m3224 a1 = false := rfl
example : impersonations m3224 = [] := rfl
example : authentic m3224 = true := rfl
def m3228 : Model := ⟨["p","q"],[],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m3228 a0 = false := rfl
example : accepts m3228 a1 = false := rfl
example : impersonations m3228 = [] := rfl
example : authentic m3228 = true := rfl
def m3232 : Model := ⟨["p","q"],[],["challenge-1"],[response1],[]⟩
example : accepts m3232 a0 = false := rfl
example : accepts m3232 a1 = false := rfl
example : impersonations m3232 = [] := rfl
example : authentic m3232 = true := rfl
def m3236 : Model := ⟨["p","q"],[],["challenge-1"],[response1],[a0]⟩
example : accepts m3236 a0 = false := rfl
example : accepts m3236 a1 = false := rfl
example : impersonations m3236 = [] := rfl
example : authentic m3236 = true := rfl
def m3240 : Model := ⟨["p","q"],[],["challenge-1"],[response1],[a1]⟩
example : accepts m3240 a0 = false := rfl
example : accepts m3240 a1 = false := rfl
example : impersonations m3240 = [] := rfl
example : authentic m3240 = true := rfl
def m3244 : Model := ⟨["p","q"],[],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m3244 a0 = false := rfl
example : accepts m3244 a1 = false := rfl
example : impersonations m3244 = [] := rfl
example : authentic m3244 = true := rfl
def m3248 : Model := ⟨["p","q"],[],["challenge-1"],[response0,response1],[]⟩
example : accepts m3248 a0 = false := rfl
example : accepts m3248 a1 = false := rfl
example : impersonations m3248 = [] := rfl
example : authentic m3248 = true := rfl
def m3252 : Model := ⟨["p","q"],[],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m3252 a0 = false := rfl
example : accepts m3252 a1 = false := rfl
example : impersonations m3252 = [] := rfl
example : authentic m3252 = true := rfl
def m3256 : Model := ⟨["p","q"],[],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m3256 a0 = false := rfl
example : accepts m3256 a1 = false := rfl
example : impersonations m3256 = [] := rfl
example : authentic m3256 = true := rfl
def m3260 : Model := ⟨["p","q"],[],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3260 a0 = false := rfl
example : accepts m3260 a1 = false := rfl
example : impersonations m3260 = [] := rfl
example : authentic m3260 = true := rfl
def m3264 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[],[]⟩
example : accepts m3264 a0 = false := rfl
example : accepts m3264 a1 = false := rfl
example : impersonations m3264 = [] := rfl
example : authentic m3264 = true := rfl
def m3268 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m3268 a0 = false := rfl
example : accepts m3268 a1 = false := rfl
example : impersonations m3268 = [] := rfl
example : authentic m3268 = true := rfl
def m3272 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m3272 a0 = false := rfl
example : accepts m3272 a1 = false := rfl
example : impersonations m3272 = [] := rfl
example : authentic m3272 = true := rfl
def m3276 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m3276 a0 = false := rfl
example : accepts m3276 a1 = false := rfl
example : impersonations m3276 = [] := rfl
example : authentic m3276 = true := rfl
def m3280 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m3280 a0 = false := rfl
example : accepts m3280 a1 = false := rfl
example : impersonations m3280 = [] := rfl
example : authentic m3280 = true := rfl
def m3284 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m3284 a0 = false := rfl
example : accepts m3284 a1 = false := rfl
example : impersonations m3284 = [] := rfl
example : authentic m3284 = true := rfl
def m3288 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m3288 a0 = false := rfl
example : accepts m3288 a1 = false := rfl
example : impersonations m3288 = [] := rfl
example : authentic m3288 = true := rfl
def m3292 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m3292 a0 = false := rfl
example : accepts m3292 a1 = false := rfl
example : impersonations m3292 = [] := rfl
example : authentic m3292 = true := rfl
def m3296 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m3296 a0 = false := rfl
example : accepts m3296 a1 = false := rfl
example : impersonations m3296 = [] := rfl
example : authentic m3296 = true := rfl
def m3300 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m3300 a0 = false := rfl
example : accepts m3300 a1 = false := rfl
example : impersonations m3300 = [] := rfl
example : authentic m3300 = true := rfl
def m3304 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m3304 a0 = false := rfl
example : accepts m3304 a1 = false := rfl
example : impersonations m3304 = [] := rfl
example : authentic m3304 = true := rfl
def m3308 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m3308 a0 = false := rfl
example : accepts m3308 a1 = false := rfl
example : impersonations m3308 = [] := rfl
example : authentic m3308 = true := rfl
def m3312 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m3312 a0 = false := rfl
example : accepts m3312 a1 = false := rfl
example : impersonations m3312 = [] := rfl
example : authentic m3312 = true := rfl
def m3316 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m3316 a0 = false := rfl
example : accepts m3316 a1 = false := rfl
example : impersonations m3316 = [] := rfl
example : authentic m3316 = true := rfl
def m3320 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m3320 a0 = false := rfl
example : accepts m3320 a1 = false := rfl
example : impersonations m3320 = [] := rfl
example : authentic m3320 = true := rfl
def m3324 : Model := ⟨["p","q"],[],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3324 a0 = false := rfl
example : accepts m3324 a1 = false := rfl
example : impersonations m3324 = [] := rfl
example : authentic m3324 = true := rfl
def m3328 : Model := ⟨["p","q"],[cred0],[],[],[]⟩
example : accepts m3328 a0 = false := rfl
example : accepts m3328 a1 = false := rfl
example : impersonations m3328 = [] := rfl
example : authentic m3328 = true := rfl
def m3332 : Model := ⟨["p","q"],[cred0],[],[],[a0]⟩
example : accepts m3332 a0 = false := rfl
example : accepts m3332 a1 = false := rfl
example : impersonations m3332 = [] := rfl
example : authentic m3332 = true := rfl
def m3336 : Model := ⟨["p","q"],[cred0],[],[],[a1]⟩
example : accepts m3336 a0 = false := rfl
example : accepts m3336 a1 = false := rfl
example : impersonations m3336 = [] := rfl
example : authentic m3336 = true := rfl
def m3340 : Model := ⟨["p","q"],[cred0],[],[],[a0,a1]⟩
example : accepts m3340 a0 = false := rfl
example : accepts m3340 a1 = false := rfl
example : impersonations m3340 = [] := rfl
example : authentic m3340 = true := rfl
def m3344 : Model := ⟨["p","q"],[cred0],[],[response0],[]⟩
example : accepts m3344 a0 = false := rfl
example : accepts m3344 a1 = false := rfl
example : impersonations m3344 = [] := rfl
example : authentic m3344 = true := rfl
def m3348 : Model := ⟨["p","q"],[cred0],[],[response0],[a0]⟩
example : accepts m3348 a0 = false := rfl
example : accepts m3348 a1 = false := rfl
example : impersonations m3348 = [] := rfl
example : authentic m3348 = true := rfl
def m3352 : Model := ⟨["p","q"],[cred0],[],[response0],[a1]⟩
example : accepts m3352 a0 = false := rfl
example : accepts m3352 a1 = false := rfl
example : impersonations m3352 = [] := rfl
example : authentic m3352 = true := rfl
def m3356 : Model := ⟨["p","q"],[cred0],[],[response0],[a0,a1]⟩
example : accepts m3356 a0 = false := rfl
example : accepts m3356 a1 = false := rfl
example : impersonations m3356 = [] := rfl
example : authentic m3356 = true := rfl
def m3360 : Model := ⟨["p","q"],[cred0],[],[response1],[]⟩
example : accepts m3360 a0 = false := rfl
example : accepts m3360 a1 = false := rfl
example : impersonations m3360 = [] := rfl
example : authentic m3360 = true := rfl
def m3364 : Model := ⟨["p","q"],[cred0],[],[response1],[a0]⟩
example : accepts m3364 a0 = false := rfl
example : accepts m3364 a1 = false := rfl
example : impersonations m3364 = [] := rfl
example : authentic m3364 = true := rfl
def m3368 : Model := ⟨["p","q"],[cred0],[],[response1],[a1]⟩
example : accepts m3368 a0 = false := rfl
example : accepts m3368 a1 = false := rfl
example : impersonations m3368 = [] := rfl
example : authentic m3368 = true := rfl
def m3372 : Model := ⟨["p","q"],[cred0],[],[response1],[a0,a1]⟩
example : accepts m3372 a0 = false := rfl
example : accepts m3372 a1 = false := rfl
example : impersonations m3372 = [] := rfl
example : authentic m3372 = true := rfl
def m3376 : Model := ⟨["p","q"],[cred0],[],[response0,response1],[]⟩
example : accepts m3376 a0 = false := rfl
example : accepts m3376 a1 = false := rfl
example : impersonations m3376 = [] := rfl
example : authentic m3376 = true := rfl
def m3380 : Model := ⟨["p","q"],[cred0],[],[response0,response1],[a0]⟩
example : accepts m3380 a0 = false := rfl
example : accepts m3380 a1 = false := rfl
example : impersonations m3380 = [] := rfl
example : authentic m3380 = true := rfl
def m3384 : Model := ⟨["p","q"],[cred0],[],[response0,response1],[a1]⟩
example : accepts m3384 a0 = false := rfl
example : accepts m3384 a1 = false := rfl
example : impersonations m3384 = [] := rfl
example : authentic m3384 = true := rfl
def m3388 : Model := ⟨["p","q"],[cred0],[],[response0,response1],[a0,a1]⟩
example : accepts m3388 a0 = false := rfl
example : accepts m3388 a1 = false := rfl
example : impersonations m3388 = [] := rfl
example : authentic m3388 = true := rfl
def m3392 : Model := ⟨["p","q"],[cred0],["challenge-0"],[],[]⟩
example : accepts m3392 a0 = false := rfl
example : accepts m3392 a1 = false := rfl
example : impersonations m3392 = [] := rfl
example : authentic m3392 = true := rfl
def m3396 : Model := ⟨["p","q"],[cred0],["challenge-0"],[],[a0]⟩
example : accepts m3396 a0 = false := rfl
example : accepts m3396 a1 = false := rfl
example : impersonations m3396 = [] := rfl
example : authentic m3396 = true := rfl
def m3400 : Model := ⟨["p","q"],[cred0],["challenge-0"],[],[a1]⟩
example : accepts m3400 a0 = false := rfl
example : accepts m3400 a1 = false := rfl
example : impersonations m3400 = [] := rfl
example : authentic m3400 = true := rfl
def m3404 : Model := ⟨["p","q"],[cred0],["challenge-0"],[],[a0,a1]⟩
example : accepts m3404 a0 = false := rfl
example : accepts m3404 a1 = false := rfl
example : impersonations m3404 = [] := rfl
example : authentic m3404 = true := rfl
def m3408 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0],[]⟩
example : accepts m3408 a0 = false := rfl
example : accepts m3408 a1 = false := rfl
example : impersonations m3408 = [] := rfl
example : authentic m3408 = true := rfl
def m3412 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0],[a0]⟩
example : accepts m3412 a0 = true := rfl
example : accepts m3412 a1 = false := rfl
example : impersonations m3412 = [] := rfl
example : authentic m3412 = true := rfl
def m3416 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0],[a1]⟩
example : accepts m3416 a0 = false := rfl
example : accepts m3416 a1 = true := rfl
example : impersonations m3416 = [a1] := rfl
example : authentic m3416 = false := rfl
def m3420 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m3420 a0 = true := rfl
example : accepts m3420 a1 = true := rfl
example : impersonations m3420 = [a1] := rfl
example : authentic m3420 = false := rfl
def m3424 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response1],[]⟩
example : accepts m3424 a0 = false := rfl
example : accepts m3424 a1 = false := rfl
example : impersonations m3424 = [] := rfl
example : authentic m3424 = true := rfl
def m3428 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response1],[a0]⟩
example : accepts m3428 a0 = false := rfl
example : accepts m3428 a1 = false := rfl
example : impersonations m3428 = [] := rfl
example : authentic m3428 = true := rfl
def m3432 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response1],[a1]⟩
example : accepts m3432 a0 = false := rfl
example : accepts m3432 a1 = false := rfl
example : impersonations m3432 = [] := rfl
example : authentic m3432 = true := rfl
def m3436 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m3436 a0 = false := rfl
example : accepts m3436 a1 = false := rfl
example : impersonations m3436 = [] := rfl
example : authentic m3436 = true := rfl
def m3440 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0,response1],[]⟩
example : accepts m3440 a0 = false := rfl
example : accepts m3440 a1 = false := rfl
example : impersonations m3440 = [] := rfl
example : authentic m3440 = true := rfl
def m3444 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m3444 a0 = true := rfl
example : accepts m3444 a1 = false := rfl
example : impersonations m3444 = [] := rfl
example : authentic m3444 = true := rfl
def m3448 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m3448 a0 = false := rfl
example : accepts m3448 a1 = true := rfl
example : impersonations m3448 = [a1] := rfl
example : authentic m3448 = false := rfl
def m3452 : Model := ⟨["p","q"],[cred0],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m3452 a0 = true := rfl
example : accepts m3452 a1 = true := rfl
example : impersonations m3452 = [a1] := rfl
example : authentic m3452 = false := rfl
def m3456 : Model := ⟨["p","q"],[cred0],["challenge-1"],[],[]⟩
example : accepts m3456 a0 = false := rfl
example : accepts m3456 a1 = false := rfl
example : impersonations m3456 = [] := rfl
example : authentic m3456 = true := rfl
def m3460 : Model := ⟨["p","q"],[cred0],["challenge-1"],[],[a0]⟩
example : accepts m3460 a0 = false := rfl
example : accepts m3460 a1 = false := rfl
example : impersonations m3460 = [] := rfl
example : authentic m3460 = true := rfl
def m3464 : Model := ⟨["p","q"],[cred0],["challenge-1"],[],[a1]⟩
example : accepts m3464 a0 = false := rfl
example : accepts m3464 a1 = false := rfl
example : impersonations m3464 = [] := rfl
example : authentic m3464 = true := rfl
def m3468 : Model := ⟨["p","q"],[cred0],["challenge-1"],[],[a0,a1]⟩
example : accepts m3468 a0 = false := rfl
example : accepts m3468 a1 = false := rfl
example : impersonations m3468 = [] := rfl
example : authentic m3468 = true := rfl
def m3472 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0],[]⟩
example : accepts m3472 a0 = false := rfl
example : accepts m3472 a1 = false := rfl
example : impersonations m3472 = [] := rfl
example : authentic m3472 = true := rfl
def m3476 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0],[a0]⟩
example : accepts m3476 a0 = false := rfl
example : accepts m3476 a1 = false := rfl
example : impersonations m3476 = [] := rfl
example : authentic m3476 = true := rfl
def m3480 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0],[a1]⟩
example : accepts m3480 a0 = false := rfl
example : accepts m3480 a1 = false := rfl
example : impersonations m3480 = [] := rfl
example : authentic m3480 = true := rfl
def m3484 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m3484 a0 = false := rfl
example : accepts m3484 a1 = false := rfl
example : impersonations m3484 = [] := rfl
example : authentic m3484 = true := rfl
def m3488 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response1],[]⟩
example : accepts m3488 a0 = false := rfl
example : accepts m3488 a1 = false := rfl
example : impersonations m3488 = [] := rfl
example : authentic m3488 = true := rfl
def m3492 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response1],[a0]⟩
example : accepts m3492 a0 = false := rfl
example : accepts m3492 a1 = false := rfl
example : impersonations m3492 = [] := rfl
example : authentic m3492 = true := rfl
def m3496 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response1],[a1]⟩
example : accepts m3496 a0 = false := rfl
example : accepts m3496 a1 = false := rfl
example : impersonations m3496 = [] := rfl
example : authentic m3496 = true := rfl
def m3500 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m3500 a0 = false := rfl
example : accepts m3500 a1 = false := rfl
example : impersonations m3500 = [] := rfl
example : authentic m3500 = true := rfl
def m3504 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0,response1],[]⟩
example : accepts m3504 a0 = false := rfl
example : accepts m3504 a1 = false := rfl
example : impersonations m3504 = [] := rfl
example : authentic m3504 = true := rfl
def m3508 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m3508 a0 = false := rfl
example : accepts m3508 a1 = false := rfl
example : impersonations m3508 = [] := rfl
example : authentic m3508 = true := rfl
def m3512 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m3512 a0 = false := rfl
example : accepts m3512 a1 = false := rfl
example : impersonations m3512 = [] := rfl
example : authentic m3512 = true := rfl
def m3516 : Model := ⟨["p","q"],[cred0],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3516 a0 = false := rfl
example : accepts m3516 a1 = false := rfl
example : impersonations m3516 = [] := rfl
example : authentic m3516 = true := rfl
def m3520 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[],[]⟩
example : accepts m3520 a0 = false := rfl
example : accepts m3520 a1 = false := rfl
example : impersonations m3520 = [] := rfl
example : authentic m3520 = true := rfl
def m3524 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m3524 a0 = false := rfl
example : accepts m3524 a1 = false := rfl
example : impersonations m3524 = [] := rfl
example : authentic m3524 = true := rfl
def m3528 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m3528 a0 = false := rfl
example : accepts m3528 a1 = false := rfl
example : impersonations m3528 = [] := rfl
example : authentic m3528 = true := rfl
def m3532 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m3532 a0 = false := rfl
example : accepts m3532 a1 = false := rfl
example : impersonations m3532 = [] := rfl
example : authentic m3532 = true := rfl
def m3536 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m3536 a0 = false := rfl
example : accepts m3536 a1 = false := rfl
example : impersonations m3536 = [] := rfl
example : authentic m3536 = true := rfl
def m3540 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m3540 a0 = true := rfl
example : accepts m3540 a1 = false := rfl
example : impersonations m3540 = [] := rfl
example : authentic m3540 = true := rfl
def m3544 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m3544 a0 = false := rfl
example : accepts m3544 a1 = true := rfl
example : impersonations m3544 = [a1] := rfl
example : authentic m3544 = false := rfl
def m3548 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m3548 a0 = true := rfl
example : accepts m3548 a1 = true := rfl
example : impersonations m3548 = [a1] := rfl
example : authentic m3548 = false := rfl
def m3552 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m3552 a0 = false := rfl
example : accepts m3552 a1 = false := rfl
example : impersonations m3552 = [] := rfl
example : authentic m3552 = true := rfl
def m3556 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m3556 a0 = false := rfl
example : accepts m3556 a1 = false := rfl
example : impersonations m3556 = [] := rfl
example : authentic m3556 = true := rfl
def m3560 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m3560 a0 = false := rfl
example : accepts m3560 a1 = false := rfl
example : impersonations m3560 = [] := rfl
example : authentic m3560 = true := rfl
def m3564 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m3564 a0 = false := rfl
example : accepts m3564 a1 = false := rfl
example : impersonations m3564 = [] := rfl
example : authentic m3564 = true := rfl
def m3568 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m3568 a0 = false := rfl
example : accepts m3568 a1 = false := rfl
example : impersonations m3568 = [] := rfl
example : authentic m3568 = true := rfl
def m3572 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m3572 a0 = true := rfl
example : accepts m3572 a1 = false := rfl
example : impersonations m3572 = [] := rfl
example : authentic m3572 = true := rfl
def m3576 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m3576 a0 = false := rfl
example : accepts m3576 a1 = true := rfl
example : impersonations m3576 = [a1] := rfl
example : authentic m3576 = false := rfl
def m3580 : Model := ⟨["p","q"],[cred0],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3580 a0 = true := rfl
example : accepts m3580 a1 = true := rfl
example : impersonations m3580 = [a1] := rfl
example : authentic m3580 = false := rfl
def m3584 : Model := ⟨["p","q"],[cred1],[],[],[]⟩
example : accepts m3584 a0 = false := rfl
example : accepts m3584 a1 = false := rfl
example : impersonations m3584 = [] := rfl
example : authentic m3584 = true := rfl
def m3588 : Model := ⟨["p","q"],[cred1],[],[],[a0]⟩
example : accepts m3588 a0 = false := rfl
example : accepts m3588 a1 = false := rfl
example : impersonations m3588 = [] := rfl
example : authentic m3588 = true := rfl
def m3592 : Model := ⟨["p","q"],[cred1],[],[],[a1]⟩
example : accepts m3592 a0 = false := rfl
example : accepts m3592 a1 = false := rfl
example : impersonations m3592 = [] := rfl
example : authentic m3592 = true := rfl
def m3596 : Model := ⟨["p","q"],[cred1],[],[],[a0,a1]⟩
example : accepts m3596 a0 = false := rfl
example : accepts m3596 a1 = false := rfl
example : impersonations m3596 = [] := rfl
example : authentic m3596 = true := rfl
def m3600 : Model := ⟨["p","q"],[cred1],[],[response0],[]⟩
example : accepts m3600 a0 = false := rfl
example : accepts m3600 a1 = false := rfl
example : impersonations m3600 = [] := rfl
example : authentic m3600 = true := rfl
def m3604 : Model := ⟨["p","q"],[cred1],[],[response0],[a0]⟩
example : accepts m3604 a0 = false := rfl
example : accepts m3604 a1 = false := rfl
example : impersonations m3604 = [] := rfl
example : authentic m3604 = true := rfl
def m3608 : Model := ⟨["p","q"],[cred1],[],[response0],[a1]⟩
example : accepts m3608 a0 = false := rfl
example : accepts m3608 a1 = false := rfl
example : impersonations m3608 = [] := rfl
example : authentic m3608 = true := rfl
def m3612 : Model := ⟨["p","q"],[cred1],[],[response0],[a0,a1]⟩
example : accepts m3612 a0 = false := rfl
example : accepts m3612 a1 = false := rfl
example : impersonations m3612 = [] := rfl
example : authentic m3612 = true := rfl
def m3616 : Model := ⟨["p","q"],[cred1],[],[response1],[]⟩
example : accepts m3616 a0 = false := rfl
example : accepts m3616 a1 = false := rfl
example : impersonations m3616 = [] := rfl
example : authentic m3616 = true := rfl
def m3620 : Model := ⟨["p","q"],[cred1],[],[response1],[a0]⟩
example : accepts m3620 a0 = false := rfl
example : accepts m3620 a1 = false := rfl
example : impersonations m3620 = [] := rfl
example : authentic m3620 = true := rfl
def m3624 : Model := ⟨["p","q"],[cred1],[],[response1],[a1]⟩
example : accepts m3624 a0 = false := rfl
example : accepts m3624 a1 = false := rfl
example : impersonations m3624 = [] := rfl
example : authentic m3624 = true := rfl
def m3628 : Model := ⟨["p","q"],[cred1],[],[response1],[a0,a1]⟩
example : accepts m3628 a0 = false := rfl
example : accepts m3628 a1 = false := rfl
example : impersonations m3628 = [] := rfl
example : authentic m3628 = true := rfl
def m3632 : Model := ⟨["p","q"],[cred1],[],[response0,response1],[]⟩
example : accepts m3632 a0 = false := rfl
example : accepts m3632 a1 = false := rfl
example : impersonations m3632 = [] := rfl
example : authentic m3632 = true := rfl
def m3636 : Model := ⟨["p","q"],[cred1],[],[response0,response1],[a0]⟩
example : accepts m3636 a0 = false := rfl
example : accepts m3636 a1 = false := rfl
example : impersonations m3636 = [] := rfl
example : authentic m3636 = true := rfl
def m3640 : Model := ⟨["p","q"],[cred1],[],[response0,response1],[a1]⟩
example : accepts m3640 a0 = false := rfl
example : accepts m3640 a1 = false := rfl
example : impersonations m3640 = [] := rfl
example : authentic m3640 = true := rfl
def m3644 : Model := ⟨["p","q"],[cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m3644 a0 = false := rfl
example : accepts m3644 a1 = false := rfl
example : impersonations m3644 = [] := rfl
example : authentic m3644 = true := rfl
def m3648 : Model := ⟨["p","q"],[cred1],["challenge-0"],[],[]⟩
example : accepts m3648 a0 = false := rfl
example : accepts m3648 a1 = false := rfl
example : impersonations m3648 = [] := rfl
example : authentic m3648 = true := rfl
def m3652 : Model := ⟨["p","q"],[cred1],["challenge-0"],[],[a0]⟩
example : accepts m3652 a0 = false := rfl
example : accepts m3652 a1 = false := rfl
example : impersonations m3652 = [] := rfl
example : authentic m3652 = true := rfl
def m3656 : Model := ⟨["p","q"],[cred1],["challenge-0"],[],[a1]⟩
example : accepts m3656 a0 = false := rfl
example : accepts m3656 a1 = false := rfl
example : impersonations m3656 = [] := rfl
example : authentic m3656 = true := rfl
def m3660 : Model := ⟨["p","q"],[cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m3660 a0 = false := rfl
example : accepts m3660 a1 = false := rfl
example : impersonations m3660 = [] := rfl
example : authentic m3660 = true := rfl
def m3664 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0],[]⟩
example : accepts m3664 a0 = false := rfl
example : accepts m3664 a1 = false := rfl
example : impersonations m3664 = [] := rfl
example : authentic m3664 = true := rfl
def m3668 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m3668 a0 = false := rfl
example : accepts m3668 a1 = false := rfl
example : impersonations m3668 = [] := rfl
example : authentic m3668 = true := rfl
def m3672 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m3672 a0 = false := rfl
example : accepts m3672 a1 = false := rfl
example : impersonations m3672 = [] := rfl
example : authentic m3672 = true := rfl
def m3676 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m3676 a0 = false := rfl
example : accepts m3676 a1 = false := rfl
example : impersonations m3676 = [] := rfl
example : authentic m3676 = true := rfl
def m3680 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response1],[]⟩
example : accepts m3680 a0 = false := rfl
example : accepts m3680 a1 = false := rfl
example : impersonations m3680 = [] := rfl
example : authentic m3680 = true := rfl
def m3684 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m3684 a0 = false := rfl
example : accepts m3684 a1 = false := rfl
example : impersonations m3684 = [] := rfl
example : authentic m3684 = true := rfl
def m3688 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m3688 a0 = false := rfl
example : accepts m3688 a1 = false := rfl
example : impersonations m3688 = [] := rfl
example : authentic m3688 = true := rfl
def m3692 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m3692 a0 = false := rfl
example : accepts m3692 a1 = false := rfl
example : impersonations m3692 = [] := rfl
example : authentic m3692 = true := rfl
def m3696 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m3696 a0 = false := rfl
example : accepts m3696 a1 = false := rfl
example : impersonations m3696 = [] := rfl
example : authentic m3696 = true := rfl
def m3700 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m3700 a0 = false := rfl
example : accepts m3700 a1 = false := rfl
example : impersonations m3700 = [] := rfl
example : authentic m3700 = true := rfl
def m3704 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m3704 a0 = false := rfl
example : accepts m3704 a1 = false := rfl
example : impersonations m3704 = [] := rfl
example : authentic m3704 = true := rfl
def m3708 : Model := ⟨["p","q"],[cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m3708 a0 = false := rfl
example : accepts m3708 a1 = false := rfl
example : impersonations m3708 = [] := rfl
example : authentic m3708 = true := rfl
def m3712 : Model := ⟨["p","q"],[cred1],["challenge-1"],[],[]⟩
example : accepts m3712 a0 = false := rfl
example : accepts m3712 a1 = false := rfl
example : impersonations m3712 = [] := rfl
example : authentic m3712 = true := rfl
def m3716 : Model := ⟨["p","q"],[cred1],["challenge-1"],[],[a0]⟩
example : accepts m3716 a0 = false := rfl
example : accepts m3716 a1 = false := rfl
example : impersonations m3716 = [] := rfl
example : authentic m3716 = true := rfl
def m3720 : Model := ⟨["p","q"],[cred1],["challenge-1"],[],[a1]⟩
example : accepts m3720 a0 = false := rfl
example : accepts m3720 a1 = false := rfl
example : impersonations m3720 = [] := rfl
example : authentic m3720 = true := rfl
def m3724 : Model := ⟨["p","q"],[cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m3724 a0 = false := rfl
example : accepts m3724 a1 = false := rfl
example : impersonations m3724 = [] := rfl
example : authentic m3724 = true := rfl
def m3728 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0],[]⟩
example : accepts m3728 a0 = false := rfl
example : accepts m3728 a1 = false := rfl
example : impersonations m3728 = [] := rfl
example : authentic m3728 = true := rfl
def m3732 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m3732 a0 = false := rfl
example : accepts m3732 a1 = false := rfl
example : impersonations m3732 = [] := rfl
example : authentic m3732 = true := rfl
def m3736 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m3736 a0 = false := rfl
example : accepts m3736 a1 = false := rfl
example : impersonations m3736 = [] := rfl
example : authentic m3736 = true := rfl
def m3740 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m3740 a0 = false := rfl
example : accepts m3740 a1 = false := rfl
example : impersonations m3740 = [] := rfl
example : authentic m3740 = true := rfl
def m3744 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response1],[]⟩
example : accepts m3744 a0 = false := rfl
example : accepts m3744 a1 = false := rfl
example : impersonations m3744 = [] := rfl
example : authentic m3744 = true := rfl
def m3748 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m3748 a0 = false := rfl
example : accepts m3748 a1 = false := rfl
example : impersonations m3748 = [] := rfl
example : authentic m3748 = true := rfl
def m3752 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m3752 a0 = false := rfl
example : accepts m3752 a1 = false := rfl
example : impersonations m3752 = [] := rfl
example : authentic m3752 = true := rfl
def m3756 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m3756 a0 = false := rfl
example : accepts m3756 a1 = false := rfl
example : impersonations m3756 = [] := rfl
example : authentic m3756 = true := rfl
def m3760 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m3760 a0 = false := rfl
example : accepts m3760 a1 = false := rfl
example : impersonations m3760 = [] := rfl
example : authentic m3760 = true := rfl
def m3764 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m3764 a0 = false := rfl
example : accepts m3764 a1 = false := rfl
example : impersonations m3764 = [] := rfl
example : authentic m3764 = true := rfl
def m3768 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m3768 a0 = false := rfl
example : accepts m3768 a1 = false := rfl
example : impersonations m3768 = [] := rfl
example : authentic m3768 = true := rfl
def m3772 : Model := ⟨["p","q"],[cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3772 a0 = false := rfl
example : accepts m3772 a1 = false := rfl
example : impersonations m3772 = [] := rfl
example : authentic m3772 = true := rfl
def m3776 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m3776 a0 = false := rfl
example : accepts m3776 a1 = false := rfl
example : impersonations m3776 = [] := rfl
example : authentic m3776 = true := rfl
def m3780 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m3780 a0 = false := rfl
example : accepts m3780 a1 = false := rfl
example : impersonations m3780 = [] := rfl
example : authentic m3780 = true := rfl
def m3784 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m3784 a0 = false := rfl
example : accepts m3784 a1 = false := rfl
example : impersonations m3784 = [] := rfl
example : authentic m3784 = true := rfl
def m3788 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m3788 a0 = false := rfl
example : accepts m3788 a1 = false := rfl
example : impersonations m3788 = [] := rfl
example : authentic m3788 = true := rfl
def m3792 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m3792 a0 = false := rfl
example : accepts m3792 a1 = false := rfl
example : impersonations m3792 = [] := rfl
example : authentic m3792 = true := rfl
def m3796 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m3796 a0 = false := rfl
example : accepts m3796 a1 = false := rfl
example : impersonations m3796 = [] := rfl
example : authentic m3796 = true := rfl
def m3800 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m3800 a0 = false := rfl
example : accepts m3800 a1 = false := rfl
example : impersonations m3800 = [] := rfl
example : authentic m3800 = true := rfl
def m3804 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m3804 a0 = false := rfl
example : accepts m3804 a1 = false := rfl
example : impersonations m3804 = [] := rfl
example : authentic m3804 = true := rfl
def m3808 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m3808 a0 = false := rfl
example : accepts m3808 a1 = false := rfl
example : impersonations m3808 = [] := rfl
example : authentic m3808 = true := rfl
def m3812 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m3812 a0 = false := rfl
example : accepts m3812 a1 = false := rfl
example : impersonations m3812 = [] := rfl
example : authentic m3812 = true := rfl
def m3816 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m3816 a0 = false := rfl
example : accepts m3816 a1 = false := rfl
example : impersonations m3816 = [] := rfl
example : authentic m3816 = true := rfl
def m3820 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m3820 a0 = false := rfl
example : accepts m3820 a1 = false := rfl
example : impersonations m3820 = [] := rfl
example : authentic m3820 = true := rfl
def m3824 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m3824 a0 = false := rfl
example : accepts m3824 a1 = false := rfl
example : impersonations m3824 = [] := rfl
example : authentic m3824 = true := rfl
def m3828 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m3828 a0 = false := rfl
example : accepts m3828 a1 = false := rfl
example : impersonations m3828 = [] := rfl
example : authentic m3828 = true := rfl
def m3832 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m3832 a0 = false := rfl
example : accepts m3832 a1 = false := rfl
example : impersonations m3832 = [] := rfl
example : authentic m3832 = true := rfl
def m3836 : Model := ⟨["p","q"],[cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m3836 a0 = false := rfl
example : accepts m3836 a1 = false := rfl
example : impersonations m3836 = [] := rfl
example : authentic m3836 = true := rfl
def m3840 : Model := ⟨["p","q"],[cred0,cred1],[],[],[]⟩
example : accepts m3840 a0 = false := rfl
example : accepts m3840 a1 = false := rfl
example : impersonations m3840 = [] := rfl
example : authentic m3840 = true := rfl
def m3844 : Model := ⟨["p","q"],[cred0,cred1],[],[],[a0]⟩
example : accepts m3844 a0 = false := rfl
example : accepts m3844 a1 = false := rfl
example : impersonations m3844 = [] := rfl
example : authentic m3844 = true := rfl
def m3848 : Model := ⟨["p","q"],[cred0,cred1],[],[],[a1]⟩
example : accepts m3848 a0 = false := rfl
example : accepts m3848 a1 = false := rfl
example : impersonations m3848 = [] := rfl
example : authentic m3848 = true := rfl
def m3852 : Model := ⟨["p","q"],[cred0,cred1],[],[],[a0,a1]⟩
example : accepts m3852 a0 = false := rfl
example : accepts m3852 a1 = false := rfl
example : impersonations m3852 = [] := rfl
example : authentic m3852 = true := rfl
def m3856 : Model := ⟨["p","q"],[cred0,cred1],[],[response0],[]⟩
example : accepts m3856 a0 = false := rfl
example : accepts m3856 a1 = false := rfl
example : impersonations m3856 = [] := rfl
example : authentic m3856 = true := rfl
def m3860 : Model := ⟨["p","q"],[cred0,cred1],[],[response0],[a0]⟩
example : accepts m3860 a0 = false := rfl
example : accepts m3860 a1 = false := rfl
example : impersonations m3860 = [] := rfl
example : authentic m3860 = true := rfl
def m3864 : Model := ⟨["p","q"],[cred0,cred1],[],[response0],[a1]⟩
example : accepts m3864 a0 = false := rfl
example : accepts m3864 a1 = false := rfl
example : impersonations m3864 = [] := rfl
example : authentic m3864 = true := rfl
def m3868 : Model := ⟨["p","q"],[cred0,cred1],[],[response0],[a0,a1]⟩
example : accepts m3868 a0 = false := rfl
example : accepts m3868 a1 = false := rfl
example : impersonations m3868 = [] := rfl
example : authentic m3868 = true := rfl
def m3872 : Model := ⟨["p","q"],[cred0,cred1],[],[response1],[]⟩
example : accepts m3872 a0 = false := rfl
example : accepts m3872 a1 = false := rfl
example : impersonations m3872 = [] := rfl
example : authentic m3872 = true := rfl
def m3876 : Model := ⟨["p","q"],[cred0,cred1],[],[response1],[a0]⟩
example : accepts m3876 a0 = false := rfl
example : accepts m3876 a1 = false := rfl
example : impersonations m3876 = [] := rfl
example : authentic m3876 = true := rfl
def m3880 : Model := ⟨["p","q"],[cred0,cred1],[],[response1],[a1]⟩
example : accepts m3880 a0 = false := rfl
example : accepts m3880 a1 = false := rfl
example : impersonations m3880 = [] := rfl
example : authentic m3880 = true := rfl
def m3884 : Model := ⟨["p","q"],[cred0,cred1],[],[response1],[a0,a1]⟩
example : accepts m3884 a0 = false := rfl
example : accepts m3884 a1 = false := rfl
example : impersonations m3884 = [] := rfl
example : authentic m3884 = true := rfl
def m3888 : Model := ⟨["p","q"],[cred0,cred1],[],[response0,response1],[]⟩
example : accepts m3888 a0 = false := rfl
example : accepts m3888 a1 = false := rfl
example : impersonations m3888 = [] := rfl
example : authentic m3888 = true := rfl
def m3892 : Model := ⟨["p","q"],[cred0,cred1],[],[response0,response1],[a0]⟩
example : accepts m3892 a0 = false := rfl
example : accepts m3892 a1 = false := rfl
example : impersonations m3892 = [] := rfl
example : authentic m3892 = true := rfl
def m3896 : Model := ⟨["p","q"],[cred0,cred1],[],[response0,response1],[a1]⟩
example : accepts m3896 a0 = false := rfl
example : accepts m3896 a1 = false := rfl
example : impersonations m3896 = [] := rfl
example : authentic m3896 = true := rfl
def m3900 : Model := ⟨["p","q"],[cred0,cred1],[],[response0,response1],[a0,a1]⟩
example : accepts m3900 a0 = false := rfl
example : accepts m3900 a1 = false := rfl
example : impersonations m3900 = [] := rfl
example : authentic m3900 = true := rfl
def m3904 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[],[]⟩
example : accepts m3904 a0 = false := rfl
example : accepts m3904 a1 = false := rfl
example : impersonations m3904 = [] := rfl
example : authentic m3904 = true := rfl
def m3908 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[],[a0]⟩
example : accepts m3908 a0 = false := rfl
example : accepts m3908 a1 = false := rfl
example : impersonations m3908 = [] := rfl
example : authentic m3908 = true := rfl
def m3912 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[],[a1]⟩
example : accepts m3912 a0 = false := rfl
example : accepts m3912 a1 = false := rfl
example : impersonations m3912 = [] := rfl
example : authentic m3912 = true := rfl
def m3916 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[],[a0,a1]⟩
example : accepts m3916 a0 = false := rfl
example : accepts m3916 a1 = false := rfl
example : impersonations m3916 = [] := rfl
example : authentic m3916 = true := rfl
def m3920 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0],[]⟩
example : accepts m3920 a0 = false := rfl
example : accepts m3920 a1 = false := rfl
example : impersonations m3920 = [] := rfl
example : authentic m3920 = true := rfl
def m3924 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0],[a0]⟩
example : accepts m3924 a0 = true := rfl
example : accepts m3924 a1 = false := rfl
example : impersonations m3924 = [] := rfl
example : authentic m3924 = true := rfl
def m3928 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0],[a1]⟩
example : accepts m3928 a0 = false := rfl
example : accepts m3928 a1 = true := rfl
example : impersonations m3928 = [a1] := rfl
example : authentic m3928 = false := rfl
def m3932 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0],[a0,a1]⟩
example : accepts m3932 a0 = true := rfl
example : accepts m3932 a1 = true := rfl
example : impersonations m3932 = [a1] := rfl
example : authentic m3932 = false := rfl
def m3936 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response1],[]⟩
example : accepts m3936 a0 = false := rfl
example : accepts m3936 a1 = false := rfl
example : impersonations m3936 = [] := rfl
example : authentic m3936 = true := rfl
def m3940 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response1],[a0]⟩
example : accepts m3940 a0 = false := rfl
example : accepts m3940 a1 = false := rfl
example : impersonations m3940 = [] := rfl
example : authentic m3940 = true := rfl
def m3944 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response1],[a1]⟩
example : accepts m3944 a0 = false := rfl
example : accepts m3944 a1 = false := rfl
example : impersonations m3944 = [] := rfl
example : authentic m3944 = true := rfl
def m3948 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response1],[a0,a1]⟩
example : accepts m3948 a0 = false := rfl
example : accepts m3948 a1 = false := rfl
example : impersonations m3948 = [] := rfl
example : authentic m3948 = true := rfl
def m3952 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0,response1],[]⟩
example : accepts m3952 a0 = false := rfl
example : accepts m3952 a1 = false := rfl
example : impersonations m3952 = [] := rfl
example : authentic m3952 = true := rfl
def m3956 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0,response1],[a0]⟩
example : accepts m3956 a0 = true := rfl
example : accepts m3956 a1 = false := rfl
example : impersonations m3956 = [] := rfl
example : authentic m3956 = true := rfl
def m3960 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0,response1],[a1]⟩
example : accepts m3960 a0 = false := rfl
example : accepts m3960 a1 = true := rfl
example : impersonations m3960 = [a1] := rfl
example : authentic m3960 = false := rfl
def m3964 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0"],[response0,response1],[a0,a1]⟩
example : accepts m3964 a0 = true := rfl
example : accepts m3964 a1 = true := rfl
example : impersonations m3964 = [a1] := rfl
example : authentic m3964 = false := rfl
def m3968 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[],[]⟩
example : accepts m3968 a0 = false := rfl
example : accepts m3968 a1 = false := rfl
example : impersonations m3968 = [] := rfl
example : authentic m3968 = true := rfl
def m3972 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[],[a0]⟩
example : accepts m3972 a0 = false := rfl
example : accepts m3972 a1 = false := rfl
example : impersonations m3972 = [] := rfl
example : authentic m3972 = true := rfl
def m3976 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[],[a1]⟩
example : accepts m3976 a0 = false := rfl
example : accepts m3976 a1 = false := rfl
example : impersonations m3976 = [] := rfl
example : authentic m3976 = true := rfl
def m3980 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[],[a0,a1]⟩
example : accepts m3980 a0 = false := rfl
example : accepts m3980 a1 = false := rfl
example : impersonations m3980 = [] := rfl
example : authentic m3980 = true := rfl
def m3984 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0],[]⟩
example : accepts m3984 a0 = false := rfl
example : accepts m3984 a1 = false := rfl
example : impersonations m3984 = [] := rfl
example : authentic m3984 = true := rfl
def m3988 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0],[a0]⟩
example : accepts m3988 a0 = false := rfl
example : accepts m3988 a1 = false := rfl
example : impersonations m3988 = [] := rfl
example : authentic m3988 = true := rfl
def m3992 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0],[a1]⟩
example : accepts m3992 a0 = false := rfl
example : accepts m3992 a1 = false := rfl
example : impersonations m3992 = [] := rfl
example : authentic m3992 = true := rfl
def m3996 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0],[a0,a1]⟩
example : accepts m3996 a0 = false := rfl
example : accepts m3996 a1 = false := rfl
example : impersonations m3996 = [] := rfl
example : authentic m3996 = true := rfl
def m4000 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response1],[]⟩
example : accepts m4000 a0 = false := rfl
example : accepts m4000 a1 = false := rfl
example : impersonations m4000 = [] := rfl
example : authentic m4000 = true := rfl
def m4004 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response1],[a0]⟩
example : accepts m4004 a0 = false := rfl
example : accepts m4004 a1 = false := rfl
example : impersonations m4004 = [] := rfl
example : authentic m4004 = true := rfl
def m4008 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response1],[a1]⟩
example : accepts m4008 a0 = false := rfl
example : accepts m4008 a1 = false := rfl
example : impersonations m4008 = [] := rfl
example : authentic m4008 = true := rfl
def m4012 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response1],[a0,a1]⟩
example : accepts m4012 a0 = false := rfl
example : accepts m4012 a1 = false := rfl
example : impersonations m4012 = [] := rfl
example : authentic m4012 = true := rfl
def m4016 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0,response1],[]⟩
example : accepts m4016 a0 = false := rfl
example : accepts m4016 a1 = false := rfl
example : impersonations m4016 = [] := rfl
example : authentic m4016 = true := rfl
def m4020 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0,response1],[a0]⟩
example : accepts m4020 a0 = false := rfl
example : accepts m4020 a1 = false := rfl
example : impersonations m4020 = [] := rfl
example : authentic m4020 = true := rfl
def m4024 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0,response1],[a1]⟩
example : accepts m4024 a0 = false := rfl
example : accepts m4024 a1 = false := rfl
example : impersonations m4024 = [] := rfl
example : authentic m4024 = true := rfl
def m4028 : Model := ⟨["p","q"],[cred0,cred1],["challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m4028 a0 = false := rfl
example : accepts m4028 a1 = false := rfl
example : impersonations m4028 = [] := rfl
example : authentic m4028 = true := rfl
def m4032 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[],[]⟩
example : accepts m4032 a0 = false := rfl
example : accepts m4032 a1 = false := rfl
example : impersonations m4032 = [] := rfl
example : authentic m4032 = true := rfl
def m4036 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0]⟩
example : accepts m4036 a0 = false := rfl
example : accepts m4036 a1 = false := rfl
example : impersonations m4036 = [] := rfl
example : authentic m4036 = true := rfl
def m4040 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a1]⟩
example : accepts m4040 a0 = false := rfl
example : accepts m4040 a1 = false := rfl
example : impersonations m4040 = [] := rfl
example : authentic m4040 = true := rfl
def m4044 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[],[a0,a1]⟩
example : accepts m4044 a0 = false := rfl
example : accepts m4044 a1 = false := rfl
example : impersonations m4044 = [] := rfl
example : authentic m4044 = true := rfl
def m4048 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[]⟩
example : accepts m4048 a0 = false := rfl
example : accepts m4048 a1 = false := rfl
example : impersonations m4048 = [] := rfl
example : authentic m4048 = true := rfl
def m4052 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0]⟩
example : accepts m4052 a0 = true := rfl
example : accepts m4052 a1 = false := rfl
example : impersonations m4052 = [] := rfl
example : authentic m4052 = true := rfl
def m4056 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a1]⟩
example : accepts m4056 a0 = false := rfl
example : accepts m4056 a1 = true := rfl
example : impersonations m4056 = [a1] := rfl
example : authentic m4056 = false := rfl
def m4060 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0],[a0,a1]⟩
example : accepts m4060 a0 = true := rfl
example : accepts m4060 a1 = true := rfl
example : impersonations m4060 = [a1] := rfl
example : authentic m4060 = false := rfl
def m4064 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[]⟩
example : accepts m4064 a0 = false := rfl
example : accepts m4064 a1 = false := rfl
example : impersonations m4064 = [] := rfl
example : authentic m4064 = true := rfl
def m4068 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0]⟩
example : accepts m4068 a0 = false := rfl
example : accepts m4068 a1 = false := rfl
example : impersonations m4068 = [] := rfl
example : authentic m4068 = true := rfl
def m4072 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a1]⟩
example : accepts m4072 a0 = false := rfl
example : accepts m4072 a1 = false := rfl
example : impersonations m4072 = [] := rfl
example : authentic m4072 = true := rfl
def m4076 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response1],[a0,a1]⟩
example : accepts m4076 a0 = false := rfl
example : accepts m4076 a1 = false := rfl
example : impersonations m4076 = [] := rfl
example : authentic m4076 = true := rfl
def m4080 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[]⟩
example : accepts m4080 a0 = false := rfl
example : accepts m4080 a1 = false := rfl
example : impersonations m4080 = [] := rfl
example : authentic m4080 = true := rfl
def m4084 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0]⟩
example : accepts m4084 a0 = true := rfl
example : accepts m4084 a1 = false := rfl
example : impersonations m4084 = [] := rfl
example : authentic m4084 = true := rfl
def m4088 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a1]⟩
example : accepts m4088 a0 = false := rfl
example : accepts m4088 a1 = true := rfl
example : impersonations m4088 = [a1] := rfl
example : authentic m4088 = false := rfl
def m4092 : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
example : accepts m4092 a0 = true := rfl
example : accepts m4092 a1 = true := rfl
example : impersonations m4092 = [a1] := rfl
example : authentic m4092 = false := rfl
def model : Model := ⟨["p","q"],[cred0,cred1],["challenge-0","challenge-1"],[response0,response1],[a0,a1]⟩
theorem nativeTrace : VerificationTrace model a0 := (exactVerificationTrace model a0).mp rfl
theorem nativeImpersonationFailure : authentic model ≠ true := acceptedImpersonationFails model a1 rfl (by decide)
example : accepts {model with attempts := [a0]} a1 = false := rfl
example : accepts {model with challenges := []} a0 = false := rfl
example : accepts {model with credentials := [cred1]} a0 = false := rfl
example : accepts {model with responses := [response1]} a0 = false := rfl
#print axioms nativeTrace
#print axioms nativeImpersonationFailure
