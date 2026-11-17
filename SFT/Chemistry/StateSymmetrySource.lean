import SFT.Chemistry.StateSymmetry
import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.StateSymmetrySource
open SFT.Host
open SFT.Physics.CapabilityValues
abbrev Event := ElectronSpinHtml.Event
-- Original state_symmetry_validation_v1.py: _IndependentStateTableParser.
-- This parser retains the original depth counter, rather than the earlier
-- electron-spin parser's Boolean table state.
structure Parser where
 tableDepth : Nat := 0
 inRow : Bool := false
 inCell : Bool := false
 cellParts : List String := []
 currentRow : List String := []
 rows : List (List String) := []
def startTag (p : Parser) (tag : String) (attrs : List (String × Option String)) : Parser :=
 if Text.equal tag "table" && ElectronSpinHtml.hasDataClass attrs then {p with tableDepth:=p.tableDepth+1}
 else if p.tableDepth != 0 && Text.equal tag "tr" then {p with inRow:=true,currentRow:=[]}
 else if p.inRow && (Text.equal tag "td" || Text.equal tag "th") then {p with inCell:=true,cellParts:=[]}
 else if p.inCell && Text.equal tag "sup" then {p with cellParts:=p.cellParts++["^"]}
 else if p.inCell && Text.equal tag "sub" then {p with cellParts:=p.cellParts++["_"]}
 else p
def endTag (p : Parser) (tag : String) : Parser :=
 if p.inCell && (Text.equal tag "td" || Text.equal tag "th") then
  {p with currentRow:=p.currentRow++[ElectronSpinHtml.normalizeSpace (ElectronSpinHtml.unescape (Text.join p.cellParts))],inCell:=false}
 else if p.inRow && Text.equal tag "tr" then
  {p with rows:=if p.currentRow.isEmpty then p.rows else p.rows++[p.currentRow],inRow:=false}
 else if p.tableDepth != 0 && Text.equal tag "table" then {p with tableDepth:=p.tableDepth-1}
 else p
def handle (p : Parser) : Event → Parser
 | .startTag tag attrs => startTag p tag attrs
 | .endTag tag => endTag p tag
 | .data text => if p.inCell then {p with cellParts:=p.cellParts++[text]} else p
def parseEvents (events : List Event) : Parser := events.foldl handle {}

def decimal (c : Char) : Bool := 48 ≤ c.toNat && c.toNat ≤ 57
def symbolChar (c : Char) : Bool := [931,928,916,934].contains c.toNat
structure Term where
 multiplicity : Nat
 symbol : String
 inscription : String
 suffix : String
-- re.finditer(r"\^([1-9][0-9]*)(Σ|Π|Δ|Φ)") consumes the
-- match, but not its suffix. The next scan therefore starts after the symbol.
def termsAux : Nat → List Char → List Term
 | 0,_ => []
 | _+1,[] => []
 | fuel+1,c::cs =>
  let digits := cs.takeWhile decimal
  let rest := cs.drop digits.length
  let firstPositive := match digits with | [] => false | d::_ => 49 ≤ d.toNat && d.toNat ≤ 57
  if c.toNat==94 && firstPositive then
   match rest with
   | [] => termsAux fuel cs
   | symbol::tail =>
    if symbolChar symbol then
     let suffix := tail.takeWhile (fun x => !([44,41,32].contains x.toNat))
     ⟨digits.foldl (fun n d => 10*n+d.toNat-48) 0,String.ofList [symbol],
       String.ofList (c::(digits++[symbol])),String.ofList suffix⟩ :: termsAux fuel tail
    else termsAux fuel cs
  else termsAux fuel cs
def terms (s : String) : List Term := let cs := Text.chars s; termsAux (cs.length+1) cs
def sourceRows (events : List Event) : List (List String) :=
 (parseEvents events).rows.filter (fun row => row.length==13 && !(terms (row.headD "")).isEmpty)
def inversionLabel (suffix : String) : String :=
 if Text.contains suffix "u" then "u" else if Text.contains suffix "g" then "g" else "absence"
def reflectionLabel (suffix : String) : String :=
 if Text.contains suffix "+" then "plus-fibre" else if Text.contains suffix "-" then "minus-fibre" else "absence"
def componentDigits : List Char → Option (List Char)
 | [] => none
 | c::cs =>
  let digits := cs.takeWhile decimal
  if c.toNat==95 && !digits.isEmpty then some digits else componentDigits cs
def axisComponent (suffix : String) : String :=
 match componentDigits (Text.chars suffix) with
 | none => "absence"
 | some digits =>
  let positive := digits.dropWhile (fun c => c.toNat==48)
  if positive.isEmpty then "absence" else Text.append "positive-component-" (String.ofList positive)
def componentKind (suffix : String) : String :=
 if Text.contains suffix "_i" || Text.contains suffix "_gi" || Text.contains suffix "_ui" then "i"
 else if Text.contains suffix "_r" then "r"
 else if Text.contains suffix "_o" then "o"
 else if Text.equal suffix "p" then "p" else "absence"
def rankInscription (symbol : String) : Except String String :=
 if Text.equal symbol "Σ" then .ok "structural-empty-One"
 else if Text.equal symbol "Π" then .ok "first-recurrence"
 else if Text.equal symbol "Δ" then .ok "second-recurrence"
 else if Text.equal symbol "Φ" then .ok "third-recurrence"
 else .error "source term symbol is outside the declared comparison grammar"
def reconstructed (state : String) (term : Term) : Except String Canonical.Value := do
 let signature ← StateSymmetry.fromSource "source-record" (← count term.multiplicity) term.symbol
  (inversionLabel term.suffix) (reflectionLabel term.suffix) (axisComponent term.suffix) (componentKind term.suffix)
 let rank ← rankInscription term.symbol
 return .object [
  ("state_record",.text state),("term_assignment_inscription",.text (Text.append term.inscription term.suffix)),
  ("positive_spin_multiplicity",.integer (.ofNat term.multiplicity)),("axis_support_symbol",.text term.symbol),
  ("fold_axis_rank",.text rank),("positive_axis_orientation_count",.integer (.ofNat signature.orientationCount.value)),
  ("positive_combined_degeneracy_count",.integer (.ofNat (StateSymmetry.degeneracy signature).value)),
  ("held_inversion_label",.text (inversionLabel term.suffix)),("held_reflection_label",.text (reflectionLabel term.suffix)),
  ("held_axis_component",.text (axisComponent term.suffix)),("held_component_kind",.text (componentKind term.suffix)),
  ("raw_suffix",.text term.suffix)]

#print axioms startTag
#print axioms endTag
#print axioms handle
#print axioms parseEvents
#print axioms decimal
#print axioms symbolChar
#print axioms termsAux
#print axioms terms
#print axioms sourceRows
#print axioms inversionLabel
#print axioms reflectionLabel
#print axioms componentDigits
#print axioms axisComponent
#print axioms componentKind
#print axioms rankInscription
#print axioms reconstructed
end SFT.Chemistry.StateSymmetrySource
