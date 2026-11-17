import SFT.Chemistry.SourceText
import SFT.Host.Canonical
import SFT.Host.SHA256Window
namespace SFT.Chemistry.NuclideCarrierSurface
open SFT.Host
abbrev J := Canonical.Value

def lineBreak (c : Char) : Bool := [10,11,12,13,28,29,30,133,8232,8233].contains c.toNat
def trimLine (cs : List Char) : List Char :=
 ((cs.dropWhile SourceText.whitespace).reverse.dropWhile SourceText.whitespace).reverse
def clean (text : String) : String :=
 let chars := (Text.chars text).filter (fun c => c.toNat != 173)
 let state := chars.foldl (fun (state : List (List Char) × List Char) c =>
  if lineBreak c then (state.2.reverse::state.1,[]) else (state.1,c::state.2)) ([],[])
 let lines := ((state.2.reverse::state.1).reverse.map trimLine).filter (fun line => !line.isEmpty)
 Text.intercalate "\n" (lines.map String.ofList)
inductive Event where
 | startTag : String → Event
 | endTag : String → Event
 | data : String → Event
structure Parser where
 hidden : Nat
 partsReversed : List String

def hiddenTag (tag : String) : Bool :=
 Text.equal tag "script" || Text.equal tag "style" || Text.equal tag "noscript"
def handle (state : Parser) : Event → Parser
 | .startTag tag => if hiddenTag tag then {state with hidden := state.hidden+1} else state
 | .endTag tag => if hiddenTag tag && state.hidden != 0 then {state with hidden := state.hidden-1} else state
 | .data value => if state.hidden==0 then {state with partsReversed := value::state.partsReversed} else state
def visible (events : List Event) : String :=
 let state := events.foldl handle ⟨0,[]⟩
 Text.intercalate "\n" state.partsReversed.reverse
def surfaceRow (kind : String) (index : Nat) (raw : String) : J :=
 let text := clean raw
 .object [(kind,.integer (.ofNat index)),("character_count",.integer (.ofNat (Text.chars text).length)),
  ("text_sha256",.text (Text.append "sha256:" (SHA256Window.digest text.toUTF8)))]
def surface (kind : String) (pages : List (Option String)) (events : List Event) : List J :=
 if Text.equal kind "pdf" then
  (pages.zipIdx 1).map (fun (text,n) => surfaceRow "page" n (text.getD ""))
 else [surfaceRow "document" 1 (visible events)]
end SFT.Chemistry.NuclideCarrierSurface
