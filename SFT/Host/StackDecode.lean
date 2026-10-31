import SFT.Host.Text
namespace SFT.Host.StackDecode

def run : Nat → List UInt8 → List Char → List Char
 | 0,_,acc => acc.reverse
 | fuel+1,[],acc => acc.reverse
 | fuel+1,b::bs,acc =>
   let n := b.toNat
   if n < 128 then run fuel bs (Char.ofNat n :: acc)
   else
    let c := (bs.headD 0).toNat
    let d := ((bs.drop 1).headD 0).toNat
    let e := ((bs.drop 2).headD 0).toNat
    if n < 224 then run fuel (bs.drop 1) (Char.ofNat ((n-192)*64+(c-128)) :: acc)
    else if n < 240 then run fuel (bs.drop 2) (Char.ofNat ((n-224)*4096+(c-128)*64+(d-128)) :: acc)
    else run fuel (bs.drop 3) (Char.ofNat ((n-240)*262144+(c-128)*4096+(d-128)*64+(e-128)) :: acc)

theorem runPreserves (fuel : Nat) (bytes : List UInt8) (acc : List Char) :
 run fuel bytes acc = List.reverseAux acc (Text.decode fuel bytes) := by
 induction fuel generalizing bytes acc with
 | zero => rfl
 | succ fuel ih =>
   cases bytes with
   | nil => rfl
   | cons b bs =>
     simp only [run,Text.decode]
     split
     · exact ih _ _
     · split
       · exact ih _ _
       · split
         · exact ih _ _
         · exact ih _ _

def decode (fuel : Nat) (bytes : List UInt8) : List Char := run fuel bytes []

theorem decodePreserves (fuel : Nat) (bytes : List UInt8) : decode fuel bytes = Text.decode fuel bytes := by
 exact runPreserves fuel bytes []
end SFT.Host.StackDecode
#print axioms SFT.Host.StackDecode.decodePreserves
