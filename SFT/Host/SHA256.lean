import SFT.Host.Text
/-! Constructive SHA-256 host evidence implementation of canonical.py hashing.
Fixed SHA-256 constants and word width are algorithm data, not scientific parameters. -/
namespace SFT.Host.SHA256
def initial : List Nat := [
  0x6a09e667, 0xbb67ae85, 0x3c6ef372, 0xa54ff53a,
  0x510e527f, 0x9b05688c, 0x1f83d9ab, 0x5be0cd19]

def constants : List Nat := [
  0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,
  0xd807aa98,0x12835b01,0x243185be,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,
  0xe49b69c1,0xefbe4786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,
  0x983e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x14292967,
  0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0x81c2c92e,0x92722c85,
  0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819,0xd6990624,0xf40e3585,0x106aa070,
  0x19a4c116,0x1e376c08,0x2748774c,0x34b0bcb5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,
  0x748f82ee,0x78a5636f,0x84c87814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2]


def bits (op : Bool → Bool → Bool) : Nat → Nat → Nat → Nat
 | 0, _, _ => 0
 | k+1, a, b => (if op (a%2 == 1) (b%2 == 1) then 1 else 0) + 2 * bits op k (a/2) (b/2)
def xor (a b : Nat) := bits (fun x y => x != y) 32 a b
def and (a b : Nat) := bits (fun x y => x && y) 32 a b
def add (xs : List Nat) := xs.foldl Nat.add 0 % 4294967296
def rotate (x n : Nat) := x / 2^n + (x % 2^n) * 2^(32-n)
def small0 (x : Nat) := xor (xor (rotate x 7) (rotate x 18)) (x / 8)
def small1 (x : Nat) := xor (xor (rotate x 17) (rotate x 19)) (x / 1024)
def big0 (x : Nat) := xor (xor (rotate x 2) (rotate x 13)) (rotate x 22)
def big1 (x : Nat) := xor (xor (rotate x 6) (rotate x 11)) (rotate x 25)
def pad (input : List Nat) : List Nat := input ++ [128] ++
  List.replicate ((64 - ((input.length+9)%64))%64) 0 ++
  (List.range 8).map (fun i => (input.length*8 / 2^(8*(7-i)))%256)
def get : List Nat → Nat → Nat
 | [], _ => 0
 | x::_, 0 => x
 | _::xs, i+1 => get xs i

def schedule (bytes : List Nat) (offset : Nat) : List Nat :=
 let first := (List.range 16).map fun i =>
   let j := offset+4*i
   get bytes j * 16777216 + get bytes (j+1)*65536 + get bytes (j+2)*256 + get bytes (j+3)
 (List.range 48).foldl (fun w k =>
   let i := k+16
   w ++ [add [small1 (get w (i-2)),get w (i-7),small0 (get w (i-15)),get w (i-16)]]) first

def round (h : List Nat) (kw : Nat × Nat) : List Nat :=
 let a := get h 0; let b := get h 1; let c := get h 2; let d := get h 3
 let e := get h 4; let f := get h 5; let g := get h 6; let hh := get h 7
 let t1 := add [hh,big1 e,xor (and e f) (and (4294967295-e) g),kw.1,kw.2]
 let t2 := add [big0 a,xor (xor (and a b) (and a c)) (and b c)]
 [add [t1,t2],a,b,c,add [d,t1],e,f,g]
def block (h bytes : List Nat) (offset : Nat) : List Nat :=
 let last := (constants.zip (schedule bytes offset)).foldl round h
 (h.zip last).map fun x => add [x.1,x.2]
def hexDigit (n : Nat) : Char := Char.ofNat (if n < 10 then 48+n else 87+n)
def wordHex (w : Nat) : String := String.ofList <|
 (List.range 8).map fun i => hexDigit ((w / 2^(4*(7-i)))%16)
def digest (input : ByteArray) : String :=
 let bytes := pad (input.data.toList.map UInt8.toNat)
 let h := (List.range (bytes.length/64)).foldl (fun h i => block h bytes (64*i)) initial
 Text.join (h.map wordHex)
end SFT.Host.SHA256
