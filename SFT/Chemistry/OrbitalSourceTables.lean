import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.OrbitalSourceTables
open SFT.Host ElectronSpinHtml
-- Exact _SourceTableParser from orbital_support_validation_v1.py.
-- Its depth counter is retained; it differs from ELEC-002's boolean table flag.
structure Parser where
 depth : Nat := 0
 inRow : Bool := false
 inCell : Bool := false
 cell : List String := []
 row : List String := []
 rows : List (List String) := []
def startTag (p : Parser) (tag : String) (attrs : List (String × Option String)) : Parser :=
 if Text.equal tag "table" && hasDataClass attrs then {p with depth:=p.depth+1}
 else if p.depth != 0 && Text.equal tag "tr" then {p with inRow:=true,row:=[]}
 else if p.inRow && (Text.equal tag "td" || Text.equal tag "th") then {p with inCell:=true,cell:=[]}
 else if p.inCell && Text.equal tag "sup" then {p with cell:=p.cell++["^"]}
 else if p.inCell && Text.equal tag "sub" then {p with cell:=p.cell++["_"]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if p.inCell && (Text.equal tag "td" || Text.equal tag "th") then
  {p with row:=p.row++[normalizeSpace (unescape (Text.join p.cell))],inCell:=false}
 else if p.inRow && Text.equal tag "tr" then
  {p with rows:=if p.row.isEmpty then p.rows else p.rows++[p.row],inRow:=false}
 else if p.depth != 0 && Text.equal tag "table" then {p with depth:=p.depth-1}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag attrs => startTag p tag attrs
 | .endTag tag => endTag p tag
 | .data text => if p.inCell then {p with cell:=p.cell++[text]} else p
def parseEvents (events : List Event) : Parser := events.foldl handle {}
end SFT.Chemistry.OrbitalSourceTables
