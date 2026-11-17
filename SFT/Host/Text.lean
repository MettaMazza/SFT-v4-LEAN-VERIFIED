/-! Constructive host text operations. UTF-8 decoding follows valid Lean String bytes.
These are representation operations, not additional scientific objects. -/
namespace SFT.Host.Text

def decodeRev : Nat → List UInt8 → List Char → List Char
 | 0 => fun _ acc => acc
 | fuel+1 => fun bytes acc =>
   match bytes with
   | [] => acc
   | b::bs =>
     let n := b.toNat
     if n < 128 then decodeRev fuel bs (Char.ofNat n :: acc)
     else
       let c := (bs.headD 0).toNat
       let d := ((bs.drop 1).headD 0).toNat
       let e := ((bs.drop 2).headD 0).toNat
       if n < 224 then decodeRev fuel (bs.drop 1) (Char.ofNat ((n-192)*64 + (c-128)) :: acc)
       else if n < 240 then decodeRev fuel (bs.drop 2) (Char.ofNat ((n-224)*4096 + (c-128)*64 + (d-128)) :: acc)
       else decodeRev fuel (bs.drop 3) (Char.ofNat ((n-240)*262144 + (c-128)*4096 + (d-128)*64 + (e-128)) :: acc)

def decodeSafe (fuel : Nat) (bytes : List UInt8) : List Char := (decodeRev fuel bytes []).reverse

@[implemented_by decodeSafe]
def decode : Nat → List UInt8 → List Char
 | 0 => fun _ => []
 | fuel+1 => fun bytes =>
   match bytes with
   | [] => []
   | b::bs =>
     let n := b.toNat
     if n < 128 then Char.ofNat n :: decode fuel bs
     else
       let c := (bs.headD 0).toNat
       let d := ((bs.drop 1).headD 0).toNat
       let e := ((bs.drop 2).headD 0).toNat
       if n < 224 then Char.ofNat ((n-192)*64 + (c-128)) :: decode fuel (bs.drop 1)
       else if n < 240 then Char.ofNat ((n-224)*4096 + (c-128)*64 + (d-128)) :: decode fuel (bs.drop 2)
       else Char.ofNat ((n-240)*262144 + (c-128)*4096 + (d-128)*64 + (e-128)) :: decode fuel (bs.drop 3)


theorem decodeRevCorrect (fuel : Nat) (bytes : List UInt8) (acc tail : List Char) :
 List.reverseAux (decodeRev fuel bytes acc) tail = List.reverseAux acc (decode fuel bytes ++ tail) := by
 induction fuel generalizing bytes acc tail with
 | zero => rfl
 | succ fuel ih =>
  cases bytes with
  | nil => rfl
  | cons b bs =>
   simp only [decodeRev,decode]
   split
   · rw [ih]
     rfl
   · split
     · rw [ih]
       rfl
     · split
       · rw [ih]
         rfl
       · rw [ih]
         rfl

theorem decodeSafeCorrect (fuel : Nat) (bytes : List UInt8) :
 decodeSafe fuel bytes = decode fuel bytes := by
 unfold decodeSafe List.reverse
 rw [decodeRevCorrect]
 change decode fuel bytes ++ [] = decode fuel bytes
 have appendNil : ∀ xs : List Char, xs ++ [] = xs := by
  intro xs
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih
 exact appendNil _


def chars (s : String) : List Char := decode s.toUTF8.size s.toUTF8.data.toList
def append (a b : String) : String := String.ofList (chars a ++ chars b)
def join (xs : List String) : String := String.ofList (xs.flatMap chars)
def intercalate (sep : String) : List String → String
 | [] => ""
 | x::xs => join (x :: xs.flatMap (fun s => [sep,s]))
def equal (a b : String) : Bool := (a.toUTF8.data.toList.map UInt8.toNat) == (b.toUTF8.data.toList.map UInt8.toNat)

def lexLE : List UInt8 → List UInt8 → Bool
 | [], _ => true
 | _::_, [] => false
 | a::as, b::bs => if a.toNat == b.toNat then lexLE as bs else a.toNat < b.toNat

def le (a b : String) : Bool := lexLE a.toUTF8.data.toList b.toUTF8.data.toList

def lowerAscii (s : String) : String := String.ofList (chars s |>.map fun c =>
  if 65 ≤ c.toNat && c.toNat ≤ 90 then Char.ofNat (c.toNat+32) else c)

def isPrefix : List UInt8 → List UInt8 → Bool
 | [], _ => true
 | _::_, [] => false
 | a::as, b::bs => (a.toNat == b.toNat) && isPrefix as bs

def containsBytes (needle : List UInt8) : List UInt8 → Bool
 | [] => needle.isEmpty
 | x::xs => isPrefix needle (x::xs) || containsBytes needle xs

def contains (s needle : String) : Bool :=
 containsBytes needle.toUTF8.data.toList s.toUTF8.data.toList
end SFT.Host.Text
