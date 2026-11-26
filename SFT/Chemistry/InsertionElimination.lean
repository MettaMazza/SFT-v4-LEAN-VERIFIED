import SFT.Chemistry.OxidativeReductiveDerivation
namespace SFT.Chemistry.InsertionElimination
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
abbrev Edge := HeldLabel × HeldLabel
def edge (a b : HeldLabel) : Edge :=
 if (if Text.equal a.family b.family then Text.le a.label b.label else Text.le a.family b.family) then (a,b) else (b,a)
def sameEdge (a b : Edge) : Bool := sameLabel a.1 b.1 && sameLabel a.2 b.2
def containsEdge (xs : List Edge) (e : Edge) : Bool := xs.any (sameEdge e)
def distinctEdges : List Edge → Bool
 | [] => true
 | e::es => !containsEdge es e && distinctEdges es
def uniqueEdges (xs : List Edge) : List Edge := xs.foldl (fun out e => if containsEdge out e then out else out++[e]) []
def difference (xs ys : List Edge) : List Edge := xs.filter (fun e => !containsEdge ys e)
def sameSet (xs ys : List Edge) : Bool := xs.all (containsEdge ys) && ys.all (containsEdge xs)
structure Trace where
 carriers : List HeldLabel
 before : List Edge
 after : List Edge
 removed : List Edge
 added : List Edge
 pathwayClass : HeldLabel
 composition : List HeldLabel
def trace (carriers : List HeldLabel) (before after removed added : List Edge)
 (pathwayClass : HeldLabel) (composition : List HeldLabel) : Except String Trace :=
 if !distinctLabels carriers || carriers.length < 2 then
  .error "pathway requires complete distinct retained carrier support"
 else if (before++after).any (fun e => sameLabel e.1 e.2) then
  .error "self-adjacency is inadmissible"
 else if !distinctEdges before || !distinctEdges after then
  .error "adjacency support cannot duplicate an edge"
 else if !sameSet removed (difference before after) || !sameSet added (difference after before) then
  .error "removed and added support must be the complete exact adjacency difference"
 else if (before++after).any (fun e => !carriers.any (sameLabel e.1) || !carriers.any (sameLabel e.2)) then
  .error "an adjacency loses a retained carrier"
 else if !Text.equal pathwayClass.family "organometallic-pathway" || composition.isEmpty then
  .error "pathway class and composition must remain held"
 else .ok ⟨carriers,before,after,removed,added,pathwayClass,composition⟩
def insertionHeld (x z y : HeldLabel) : Except String Trace :=
 let before := [edge x z]
 let after := [edge x y,edge y z]
 trace [x,z,y] before after before after ⟨"organometallic-pathway","insertion",rfl,rfl⟩
  [⟨"process-component","insertion",rfl,rfl⟩]
def insertion (x z y : String) : Except String Trace := do
 insertionHeld (← heldLabel "carrier" x) (← heldLabel "carrier" z) (← heldLabel "carrier" y)
def extrusion (t : Trace) : Except String Trace :=
 if !Text.equal t.pathwayClass.label "insertion" then
  .error "extrusion requires one exact insertion trace"
 else trace t.carriers t.after t.before t.added t.removed
  ⟨"organometallic-pathway","extrusion",rfl,rfl⟩ [⟨"process-component","reverse-insertion",rfl,rfl⟩]
def migratoryHeld (m x y : HeldLabel) : Except String Trace :=
 trace [m,x,y] [edge m x,edge m y] [edge m y,edge x y] [edge m x] [edge x y]
  ⟨"organometallic-pathway","migratory-insertion",rfl,rfl⟩
  [⟨"process-component","migration",rfl,rfl⟩,⟨"process-component","insertion",rfl,rfl⟩]
def migratory (metal migrant inserted : String) : Except String Trace := do
 migratoryHeld (← heldLabel "metal-occurrence" metal) (← heldLabel "carrier" migrant) (← heldLabel "carrier" inserted)
def eliminationHeld (a b x y : HeldLabel) : Except String Trace :=
 let carriers := OxidativeReductive.uniqueLabels [a,b,x,y]
 let before := uniqueEdges [edge a x,edge b y]
 let added := if !sameLabel a b then [edge a b] else [edge x y]
 trace carriers before added before added
  ⟨"organometallic-pathway","elimination",rfl,rfl⟩
  [⟨"process-component","two-eliminand-loss",rfl,rfl⟩,⟨"product-class","new-unsaturation-ring-or-carbene-boundary",rfl,rfl⟩]
def elimination (centreLeft centreRight eliminandLeft eliminandRight : String) : Except String Trace := do
 eliminationHeld (← heldLabel "reaction-centre" centreLeft) (← heldLabel "reaction-centre" centreRight)
  (← heldLabel "eliminand" eliminandLeft) (← heldLabel "eliminand" eliminandRight)
def insertionWitness : Bool := match insertion "X" "Z" "Y" with
 | .error _ => false | .ok t => t.removed.length==1 && t.added.length==2
def extrusionWitness : Bool := match insertion "X" "Z" "Y" with
 | .error _ => false
 | .ok t => match extrusion t with
  | .error _ => false | .ok r => OxidativeReductive.sameIncidences r.after t.before
def migrationWitness : Bool := match migratory "M" "X" "Y" with
 | .error _ => false | .ok t => t.composition.map HeldLabel.label == ["migration","insertion"]
def eliminationWitness : Bool := match elimination "A" "B" "X" "Y" with
 | .error _ => false
 | .ok t => match elimination "A" "A" "X" "Y" with
  | .error _ => false | .ok r => t.removed.length==2 && r.carriers.length==3
theorem insertionPassed : insertionWitness=true := by decide
theorem extrusionPassed : extrusionWitness=true := by decide
theorem migrationPassed : migrationWitness=true := by decide
theorem eliminationPassed : eliminationWitness=true := by decide
end SFT.Chemistry.InsertionElimination
