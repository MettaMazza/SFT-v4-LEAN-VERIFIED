import SFT.Chemistry.SourceText
namespace SFT.Chemistry.PeriodicPDF
-- generated_periodic_law.py _pdf_literal_strings: literal parsing after the
-- standard-library stream/decompression IO boundary, from the same PDF bytes.
def byte (s : ByteArray) (i : Nat) : Nat := (s[i]!).toNat
def octal (n : Nat) : Bool := 48 ≤ n && n ≤ 55

def octalTail (s : ByteArray) : Nat → Nat → Nat → Nat × Nat
 | 0, cursor, value => (cursor,value)
 | fuel+1, cursor, value =>
   if cursor < s.size && octal (byte s cursor) then octalTail s fuel (cursor+1) (value*8 + (byte s cursor - 48))
   else (cursor,value)

def escaped (n : Nat) : Nat :=
 if n == 110 then 10 else if n == 114 then 13 else if n == 116 then 9
 else if n == 98 then 8 else if n == 102 then 12 else n

def literal (s : ByteArray) : Nat → Nat → Nat → List Char → Except String (Nat × List Char)
 | 0, cursor, _, value => .ok (cursor,value.reverse)
 | fuel+1, cursor, depth, value =>
   if cursor ≥ s.size || depth == 0 then .ok (cursor,value.reverse)
   else
    let b := byte s cursor
    if b == 92 && cursor+1 < s.size then
     let next := byte s (cursor+1)
     if octal next then
      let result := octalTail s 2 (cursor+2) (next-48)
      if result.2 > 255 then .error "byte must be in range(0, 256)"
      else literal s fuel result.1 depth (Char.ofNat result.2 :: value)
     else literal s fuel (cursor+2) depth (Char.ofNat (escaped next) :: value)
    else if b == 40 then literal s fuel (cursor+1) (depth+1) ('('::value)
    else if b == 41 then
     if depth == 1 then .ok (cursor+1,value.reverse)
     else literal s fuel (cursor+1) (depth-1) (')'::value)
    else literal s fuel (cursor+1) depth (Char.ofNat b :: value)

def scan (s : ByteArray) : Nat → Nat → List String → Except String (List String)
 | 0, _, values => .ok values.reverse
 | fuel+1, cursor, values => do
   if cursor ≥ s.size then .ok values.reverse
   else if byte s cursor == 40 then
    let result ← literal s s.size (cursor+1) 1 []
    scan s fuel result.1 (String.ofList result.2 :: values)
   else scan s fuel (cursor+1) values

def strings (streams : List ByteArray) : Except String (List String) := do
 let lists ← streams.mapM (fun s => scan s s.size 0 [])
 .ok lists.flatten

def normalizeChars : List Char → Bool → Bool → List Char
 | [], _, _ => []
 | c::rest, seen, pending =>
   if SourceText.whitespace c then normalizeChars rest seen true
   else if seen && pending then ' '::c::normalizeChars rest true false
   else c::normalizeChars rest true false

def digit (c : Char) : Bool := 48 ≤ c.toNat && c.toNat ≤ 57

def joinDigits : List Char → Bool → List Char
 | [], _ => []
 | c::rest, previousDigit =>
   if c == ' ' && previousDigit then
    match rest with
    | [] => [c]
    | next::_ => if digit next then joinDigits rest previousDigit else c::joinDigits rest false
   else c::joinDigits rest (digit c)

def texts (streams : List ByteArray) : Except String (String × String) := do
 let ss ← strings streams
 let normalized := normalizeChars (SFT.Host.Text.chars (SFT.Host.Text.intercalate " " ss)) false false
 .ok (String.ofList normalized,String.ofList (joinDigits normalized false))
end SFT.Chemistry.PeriodicPDF
