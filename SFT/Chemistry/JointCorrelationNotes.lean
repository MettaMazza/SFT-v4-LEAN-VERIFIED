import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.JointCorrelationNotes
open SFT.Host
abbrev Event := ElectronSpinHtml.Event
structure Parser where
 inRow : Bool := false
 noteId : Option String := none
 parts : List String := []
 notes : List (String × String) := []

def storeNote (notes : List (String × String)) (key value : String) : List (String × String) :=
 if notes.any (fun row => Text.equal row.1 key) then notes.map (fun row => if Text.equal row.1 key then (key,value) else row)
 else notes++[(key,value)]
def startTag (p : Parser) (tag : String) (attrs : List (String × Option String)) : Parser :=
 let id := (ElectronSpinHtml.lookupAttribute attrs "id").getD ""
 if Text.equal tag "tr" then {p with inRow:=true,noteId:=none,parts:=[]}
 else if p.inRow && Text.equal tag "a" && (Text.chars "Dia").isPrefixOf (Text.chars id) then {p with noteId:=some id}
 else if p.inRow && Text.equal tag "sup" then {p with parts:=p.parts++["^"]}
 else if p.inRow && Text.equal tag "sub" then {p with parts:=p.parts++["_"]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if Text.equal tag "tr" && p.inRow then
  let notes := match p.noteId with
   | none => p.notes
   | some id => storeNote p.notes id (ElectronSpinHtml.normalizeSpace (ElectronSpinHtml.unescape (Text.join p.parts)))
  {p with inRow:=false,notes:=notes}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag attrs => startTag p tag attrs
 | .endTag tag => endTag p tag
 | .data value => if p.inRow then {p with parts:=p.parts++[value]} else p
def parseEvents (events : List Event) : Parser := events.foldl handle {}
end SFT.Chemistry.JointCorrelationNotes
