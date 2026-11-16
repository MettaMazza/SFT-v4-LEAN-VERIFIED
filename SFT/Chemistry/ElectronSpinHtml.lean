import SFT.Chemistry.ElectronSpinHtmlEntities
namespace SFT.Chemistry.ElectronSpinHtml
open SFT.Host
set_option maxRecDepth 100000
def decimal (c : Char) : Bool := 48 ≤ c.toNat && c.toNat ≤ 57
def hexadecimal (c : Char) : Bool := decimal c || (65 ≤ c.toNat && c.toNat ≤ 70) || (97 ≤ c.toNat && c.toNat ≤ 102)
def digit (c : Char) : Nat := if decimal c then c.toNat-48 else if c.toNat ≤ 70 then c.toNat-55 else c.toNat-87
def number (base : Nat) (cs : List Char) : Nat := cs.foldl (fun n c=>base*n+digit c) 0
def namedChar (c : Char) : Bool := !([9,10,12,32,60,38,35,59].contains c.toNat)
def takeNamed : Nat → List Char → List Char × List Char
 | 0,cs => ([],cs)
 | _+1,[] => ([],[])
 | fuel+1,c::cs => if namedChar c then
    let (head,tail) := takeNamed fuel cs
    (c::head,tail)
   else ([],c::cs)
def stripSemicolon : List Char → List Char
 | []=>[]
 | c::cs=>if c.toNat==59 then cs else c::cs
def numericReplacement (n : Nat) : String :=
 match ElectronSpinHtmlEntities.invalidReferences.find? (fun p=>p.1==n) with
 | some p=>p.2
 | none=>if (55296 ≤ n && n ≤ 57343) || n > 1114111 then "�"
   else if ElectronSpinHtmlEntities.invalidCodepoints.contains n then ""
   else String.ofList [Char.ofNat n]
def namedPrefix (name : List Char) : Nat → Option String
 | 0=>none
 | k+1=>if k+1<2 then none else
   match ElectronSpinHtmlEntities.names.find? (fun p=>Text.equal p.1 (String.ofList (name.take (k+1)))) with
   | some p=>some (Text.append p.2 (String.ofList (name.drop (k+1))))
   | none=>namedPrefix name k
def characterReference (cs : List Char) : Option (String × List Char) :=
 match cs with
 | []=>none
 | first::rest=>
   if first.toNat==35 then
    match rest with
    | []=>none
    | c::tail=>
      let hex := c.toNat==120 || c.toNat==88
      let body := if hex then tail else rest
      let digits := body.takeWhile (if hex then hexadecimal else decimal)
      if digits.isEmpty then none else
       some (numericReplacement (number (if hex then 16 else 10) digits),stripSemicolon (body.drop digits.length))
   else
    let (body,tail) := takeNamed 32 cs
    if body.isEmpty then none else
     let hasSemi := match tail with | []=>false | c::_=>c.toNat==59
     let token := if hasSemi then body++[';'] else body
     let decoded := (namedPrefix token token.length).getD (Text.append "&" (String.ofList token))
     some (decoded,if hasSemi then stripSemicolon tail else tail)
def unescapeAux : Nat → List Char → String
 | 0,cs=>String.ofList cs
 | _+1,[]=>""
 | fuel+1,c::cs=>
   if c.toNat==38 then
    match characterReference cs with
    | some (decoded,tail)=>Text.append decoded (unescapeAux fuel tail)
    | none=>Text.append "&" (unescapeAux fuel cs)
   else Text.append (String.ofList [c]) (unescapeAux fuel cs)
def unescape (s : String) : String := let cs:=Text.chars s; unescapeAux (cs.length+1) cs
def normalizeSpace (s : String) : String :=
 let result := (Text.chars s).foldl (fun (acc : List (List Char) × List Char) c=>
  if SFT.Physics.CapabilityValues.whitespace c then
   if acc.2.isEmpty then acc else (acc.1++[acc.2],[])
  else (acc.1,acc.2++[c])) ([],[])
 Text.intercalate " " ((if result.2.isEmpty then result.1 else result.1++[result.2]).map String.ofList)
inductive Event where
 | startTag : String → List (String × Option String) → Event
 | endTag : String → Event
 | data : String → Event
structure Parser where
 inDataTable : Bool := false
 inRow : Bool := false
 inCell : Bool := false
 cellText : List String := []
 currentRow : List String := []
 rows : List (List String) := []
def lookupAttribute (attrs : List (String × Option String)) (key : String) : Option String :=
 attrs.foldl (fun found p=>if Text.equal p.1 key then p.2 else found) none
def hasDataClass (attrs : List (String × Option String)) : Bool :=
 ((Text.chars (normalizeSpace ((lookupAttribute attrs "class").getD ""))).splitOn ' ').any (fun cs=>Text.equal (String.ofList cs) "data")
def startTag (p : Parser) (tag : String) (attrs : List (String × Option String)) : Parser :=
 if Text.equal tag "table" && hasDataClass attrs then {p with inDataTable:=true}
 else if p.inDataTable && Text.equal tag "tr" then {p with inRow:=true,currentRow:=[]}
 else if p.inRow && (Text.equal tag "td" || Text.equal tag "th") then {p with inCell:=true,cellText:=[]}
 else if p.inCell && Text.equal tag "sup" then {p with cellText:=p.cellText++["^"]}
 else if p.inCell && Text.equal tag "sub" then {p with cellText:=p.cellText++["_"]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if p.inCell && (Text.equal tag "td" || Text.equal tag "th") then
  {p with currentRow:=p.currentRow++[normalizeSpace (unescape (Text.join p.cellText))],inCell:=false}
 else if p.inRow && Text.equal tag "tr" then
  {p with rows:=if p.currentRow.isEmpty then p.rows else p.rows++[p.currentRow],inRow:=false}
 else if p.inDataTable && Text.equal tag "table" then {p with inDataTable:=false}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag attrs=>startTag p tag attrs
 | .endTag tag=>endTag p tag
 | .data s=>if p.inCell then {p with cellText:=p.cellText++[s]} else p
def parseEvents (events : List Event) : Parser := events.foldl handle {}
end SFT.Chemistry.ElectronSpinHtml
