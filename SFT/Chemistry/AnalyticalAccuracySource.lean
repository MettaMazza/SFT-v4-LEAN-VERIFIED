import SFT.Chemistry.NuclideCarrierSurface
namespace SFT.Chemistry.AnalyticalAccuracySource
open SFT.Host
open NuclideCarrierSurface (Event Parser)
-- BeautifulSoup get_text excludes script/style/template string classes.
-- noscript text remains ordinary text; this differs from the prior nuclide adapter.
def hiddenTag (tag : String) : Bool :=
 Text.equal tag "script" || Text.equal tag "style" || Text.equal tag "template"
def handle (state : Parser) : Event → Parser
 | .startTag tag => if hiddenTag tag then {state with hidden := state.hidden+1} else state
 | .endTag tag => if hiddenTag tag && state.hidden != 0 then {state with hidden := state.hidden-1} else state
 | .data value => if state.hidden==0 then {state with partsReversed := value::state.partsReversed} else state
def visible (events : List Event) : String :=
 let state := events.foldl handle ⟨0,[]⟩
 Text.intercalate "\n" state.partsReversed.reverse
def surface (kind : String) (pages : List (Option String)) (events : List Event) : List Canonical.Value :=
 if Text.equal kind "html" then [NuclideCarrierSurface.surfaceRow "page" 1 (visible events)]
 else (pages.zipIdx 1).map (fun (text,n) => NuclideCarrierSurface.surfaceRow "page" n (text.getD ""))
end SFT.Chemistry.AnalyticalAccuracySource
