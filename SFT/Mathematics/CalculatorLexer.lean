import SFT.Mathematics.CalculatorNumerals
namespace SFT.Mathematics.CalculatorLexer
open SFT.Host SFT.Physics
set_option maxRecDepth 100000
structure Token where
 kind : String
 text : String
def decimalChar (c : Char) : Bool := (LeptonDecimal.decimalDigit c).isSome
def asciiLetter (c : Char) : Bool := (65 <= c.toNat && c.toNat <= 90) || (97 <= c.toNat && c.toNat <= 122)
def nameFirst (c : Char) : Bool := asciiLetter c || c == '_'
def nameTail (c : Char) : Bool := nameFirst c || (48 <= c.toNat && c.toNat <= 57)
def readWhile (test : Char → Bool) : List Char → List Char × List Char
 | [] => ([],[])
 | c::cs => if test c then
   let pair := readWhile test cs
   (c::pair.1,pair.2)
  else ([],c::cs)
def readExponent (cs : List Char) : List Char × List Char := match cs with
 | [] => ([],[])
 | first::rest =>
  if first == 'e' || first == 'E' then
   let (sign,body) := match rest with
    | [] => ([],[])
    | s::tail => if s == '+' || s == '-' then ([s],tail) else ([],rest)
   let (digits,remaining) := readWhile decimalChar body
   if digits.isEmpty then ([],cs) else (first::(sign++digits),remaining)
  else ([],cs)
def readNumber (cs : List Char) : Option (List Char × List Char) :=
 let (whole,tail) := readWhile decimalChar cs
 if whole.isEmpty then
  match cs with
  | [] => none
  | first::rest =>
   if first == '.' then
    let (parts,remaining) := readWhile decimalChar rest
    if parts.isEmpty then none else
     let (exp,final) := readExponent remaining
     some ('.'::(parts++exp),final)
   else none
 else
  let (mantissa,remaining) := match tail with
   | [] => (whole,[])
   | first::rest => if first == '.' then
     let (parts,remaining) := readWhile decimalChar rest
     (whole++('.'::parts),remaining)
    else (whole,tail)
  let (exp,final) := readExponent remaining
  some (mantissa++exp,final)
def lexLoop : Nat → Nat → List Char → Except String (List Token)
 | 0,_,_ => .error "unreachable lexer traversal boundary"
 | fuel+1,position,cs => do
  match cs with
  | [] => pure []
  | _::_ =>
   let (spaces,body) := readWhile (fun c => LeptonDecimal.spaceCodes.contains c.toNat) cs
   if body.isEmpty then pure [] else
   let (token,remaining) ← match readNumber body with
    | some (number,remaining) => pure (Token.mk "number" (String.ofList number),remaining)
    | none => match body with
     | [] => throw "unreachable lexer traversal boundary"
     | first::rest =>
      if nameFirst first then
       let (name,remaining) := readWhile nameTail body
       pure (Token.mk "name" (String.ofList name),remaining)
      else if ['+','-','*','/','^','!','%','(',')',','].contains first then
       pure (Token.mk "operator" (String.ofList [first]),rest)
      else throw (Text.append "ungenerated character at boundary position " (String.ofList (Nat.toDigits 10 position)))
   let consumed := spaces.length + body.length - remaining.length
   let rest ← lexLoop fuel (position+consumed) remaining
   pure (token::rest)
def lex (expression : String) : Except String (List Token) :=
 let chars := Text.chars expression
 if (LeptonDecimal.strip chars).isEmpty then .error "an expression is required"
 else lexLoop (chars.length+1) 0 chars
end SFT.Mathematics.CalculatorLexer
