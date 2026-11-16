import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.StateEnergySourceTables
open SFT.Host ElectronSpinHtml
structure Parser where
 depth : Nat := 0
 rowFlag : Bool := false
 cellFlag : Bool := false
 note : Nat := 0
 cell : List String := []
 row : List String := []
 rows : List (List String) := []
def startTag (p : Parser) (tag : String) (attrs : List (String × Option String)) : Parser :=
 if Text.equal tag "table" && hasDataClass attrs then {p with depth:=p.depth+1}
 else if p.depth != 0 && Text.equal tag "tr" then {p with rowFlag:=true,row:=[]}
 else if p.rowFlag && (Text.equal tag "td" || Text.equal tag "th") then {p with cellFlag:=true,cell:=[]}
 else if p.cellFlag && Text.equal tag "a" && Text.isPrefix "#Dia".toUTF8.data.toList (((lookupAttribute attrs "href").getD "").toUTF8.data.toList) then {p with note:=p.note+1}
 else if p.cellFlag && p.note==0 && Text.equal tag "sup" then {p with cell:=p.cell++["^"]}
 else if p.cellFlag && p.note==0 && Text.equal tag "sub" then {p with cell:=p.cell++["_"]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if Text.equal tag "a" && p.note != 0 then {p with note:=p.note-1}
 else if p.cellFlag && (Text.equal tag "td" || Text.equal tag "th") then
  {p with row:=p.row++[normalizeSpace (unescape (Text.join p.cell))],cellFlag:=false}
 else if p.rowFlag && Text.equal tag "tr" then
  {p with rows:=if p.row.isEmpty then p.rows else p.rows++[p.row],rowFlag:=false}
 else if p.depth != 0 && Text.equal tag "table" then {p with depth:=p.depth-1}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag attrs => startTag p tag attrs
 | .endTag tag => endTag p tag
 | .data text => if p.cellFlag && p.note==0 then {p with cell:=p.cell++[text]} else p
def parseEvents (events : List Event) : Parser := events.foldl handle {}
#print axioms startTag
#print axioms endTag
#print axioms handle
#print axioms parseEvents
end SFT.Chemistry.StateEnergySourceTables
