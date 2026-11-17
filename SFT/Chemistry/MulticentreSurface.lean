import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.MulticentreSurface
open SFT.Host
abbrev Event := ElectronSpinHtml.Event
structure Parser where
 inCell : Bool := false
 inRow : Bool := false
 cell : List String := []
 row : List String := []
 rows : List (List String) := []
 allParts : List String := []
def normalize (parts : List String) : String := ElectronSpinHtml.normalizeSpace (ElectronSpinHtml.unescape (Text.join parts))
def startTag (p : Parser) (tag : String) : Parser :=
 if Text.equal tag "tr" then {p with inRow:=true,row:=[]}
 else if p.inRow && (Text.equal tag "td" || Text.equal tag "th") then {p with inCell:=true,cell:=[]}
 else if Text.equal tag "sub" then
  {p with allParts:=p.allParts++["_"],cell:=if p.inCell then p.cell++["_"] else p.cell}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if p.inCell && (Text.equal tag "td" || Text.equal tag "th") then {p with row:=p.row++[normalize p.cell],inCell:=false}
 else if p.inRow && Text.equal tag "tr" then {p with rows:=if p.row.isEmpty then p.rows else p.rows++[p.row],inRow:=false}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag _ => startTag p tag
 | .endTag tag => endTag p tag
 | .data value => {p with allParts:=p.allParts++[value],cell:=if p.inCell then p.cell++[value] else p.cell}
def parseEvents (events : List Event) : Parser := events.foldl handle {}
def text (p : Parser) : String := normalize p.allParts
end SFT.Chemistry.MulticentreSurface
