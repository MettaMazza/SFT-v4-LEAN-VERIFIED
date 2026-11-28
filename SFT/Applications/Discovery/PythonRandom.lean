import SFT.Host.SHA256
/- Integer-seeded Random.random protocol used by USDE.run_null_baseline.
   Direct translation of CPython _randommodule.c (v3.12.0), whose retained
   reference file includes the Matsumoto/Nishimura and CPython notices. -/
namespace SFT.Applications.Discovery.PythonRandom
open SFT.Host.SHA256 (xor and)
def word : Nat := 4294967296
structure Generator where
 state : Array Nat
 index : Nat

def initGenrand (seed : Nat) : Array Nat :=
 (List.range 623).foldl (fun mt k =>
  let i := k+1
  let previous := mt.getD (i-1) 0
  mt.setIfInBounds i ((1812433253*xor previous (previous/1073741824)+i)%word))
  (((List.replicate 624 0).toArray).setIfInBounds 0 (seed%word))

def initByArray (key : Array Nat) : Generator :=
 let (mt,i,_) := (List.range (max 624 key.size)).foldl (fun (mt,i,j) _ =>
  let previous := mt.getD (i-1) 0
  let value := (xor (mt.getD i 0) (xor previous (previous/1073741824)*1664525)+key.getD j 0+j)%word
  let mt := mt.setIfInBounds i value
  let next := i+1
  let (mt,next) := if next≥624 then (mt.setIfInBounds 0 (mt.getD 623 0),1) else (mt,next)
  (mt,next,if j+1≥key.size then 0 else j+1)) (initGenrand 19650218,1,0)
 let (mt,_) := (List.range 623).foldl (fun (mt,i) _ =>
  let previous := mt.getD (i-1) 0
  let value := (xor (mt.getD i 0) (xor previous (previous/1073741824)*1566083941)+word-i)%word
  let mt := mt.setIfInBounds i value
  if i+1≥624 then (mt.setIfInBounds 0 (mt.getD 623 0),1) else (mt,i+1)) (mt,i)
 {state := mt.setIfInBounds 0 2147483648,index := 624}

def seed (value : Int) : Generator :=
 let magnitude := value.natAbs
 let length := if magnitude=0 then 1 else Nat.log2 magnitude/32+1
 let key := ((List.range length).map (fun i => (magnitude/(2^(32*i)))%word)).toArray
 initByArray key

def twist (mt : Array Nat) : Array Nat :=
 let mt := (List.range 623).foldl (fun mt k =>
  let y := (mt.getD k 0 / 2147483648)*2147483648 + mt.getD (k+1) 0 % 2147483648
  let position := if k<227 then k+397 else k-227
  mt.setIfInBounds k (xor (xor (mt.getD position 0) (y/2)) (if y%2=1 then 0x9908b0df else 0))) mt
 let y := (mt.getD 623 0 /2147483648)*2147483648 + mt.getD 0 0 %2147483648
 mt.setIfInBounds 623 (xor (xor (mt.getD 396 0) (y/2)) (if y%2=1 then 0x9908b0df else 0))

def nextWord (g : Generator) : Nat × Generator :=
 let g := if g.index≥624 then {state := twist g.state,index := 0} else g
 let y := g.state.getD g.index 0
 let y := xor y (y/2048)
 let y := xor y (and (y*128) 0x9d2c5680)
 let y := xor y (and (y*32768) 0xefc60000)
 let y := xor y (y/262144)
 (y,{g with index := g.index+1})

def next53 (g : Generator) : Nat × Generator :=
 let (a,g) := nextWord g
 let (b,g) := nextWord g
 ((a/32)*67108864+b/64,g)
def random (g : Generator) : Float × Generator :=
 let (numerator,g) := next53 g
 (Float.ofNat numerator*(1.0/9007199254740992.0),g)
end SFT.Applications.Discovery.PythonRandom
