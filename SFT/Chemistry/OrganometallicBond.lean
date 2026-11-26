import SFT.Chemistry.InorganicColourDerivation
namespace SFT.Chemistry.OrganometallicBond
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
structure Incidence where
 centre : HeldLabel
 carbon : HeldLabel
 electrons : List HeldLabel
def incidence (centre carbon : HeldLabel) (electrons : List HeldLabel) : Except String Incidence :=
 if !Text.equal centre.family "organometallic-centre-occurrence" then
  .error "organometallic incidence requires one retained centre occurrence"
 else if !Text.equal carbon.family "carbon-occurrence" then
  .error "organometallic incidence requires one retained carbon occurrence"
 else if electrons.isEmpty || electrons.any (fun e => !Text.equal e.family "held-bond-electron") then
  .error "direct metal-carbon incidence requires complete positive held electron support"
 else if !distinctLabels electrons then .error "held bond-electron support cannot duplicate an occurrence"
 else .ok ⟨centre,carbon,electrons⟩
def sameKey (a b : Incidence) : Bool := sameLabel a.centre b.centre && sameLabel a.carbon b.carbon
def distinctKeys : List Incidence → Bool
 | [] => true
 | row::rest => !(rest.any (sameKey row)) && distinctKeys rest
structure Topology where
 entity : HeldLabel
 incidences : List Incidence
 directCount : PositiveCount
 classification : HeldLabel
def topology (entity : HeldLabel) (rows : List Incidence) (count : PositiveCount) (classification : HeldLabel) : Except String Topology :=
 if !Text.equal entity.family "chemical-entity" then
  .error "organometallic topology requires one retained chemical entity"
 else if rows.isEmpty || count.value != rows.length then
  .error "organometallic count must equal complete positive direct incidence support"
 else if !distinctKeys rows then .error "metal-carbon direct incidences cannot be duplicated"
 else if !sameLabel classification ⟨"chemical-class","organometallic",rfl,rfl⟩ then
  .error "positive direct metal-carbon support uniquely forces organometallic class"
 else .ok ⟨entity,rows,count,classification⟩
def direct (centre carbon : String) (n : PositiveCount) : Except String Incidence := do
 let c ← heldLabel "organometallic-centre-occurrence" centre
 let a ← heldLabel "carbon-occurrence" carbon
 let electrons ← ((List.range n.value).map (fun i => i+1)).mapM fun i =>
  heldLabel "held-bond-electron" (Text.intercalate "-" [centre,carbon,toString i])
 incidence c a electrons
inductive Input where
 | empty (identity : String := "empty-One")
 | rows (values : List Incidence)
inductive BondSupport where
 | empty (identity : String := "empty-One")
 | positive (value : Topology)
def forceRows (entity : String) (rows : List Incidence) : Except String Topology := do
 if h : 0<rows.length then
  topology (← heldLabel "chemical-entity" entity) rows ⟨rows.length,h⟩
   (← heldLabel "chemical-class" "organometallic")
 else throw "host empty tuple is not structural EmptyOne"
def forced (entity : String) : Input → Except String BondSupport
 | .empty _ => .ok (.empty "empty-One")
 | .rows rows => (forceRows entity rows).map BondSupport.positive
def appendDirect (t : Topology) (i : Incidence) : Except String Topology :=
 forceRows t.entity.label (t.incidences++[i])
def first : Except String Topology := do forceRows "one" [← direct "M1" "C1" ⟨2,by decide⟩]
def second : Except String Topology := do appendDirect (← first) (← direct "M1" "C2" ⟨2,by decide⟩)
def absenceWitness : Bool := match forced "absent" (.empty "empty-One") with
 | .ok (.empty _) => true | .error _ | .ok (.positive _) => false
def firstWitness : Bool := match first with
 | .error _ => false
 | .ok t => t.directCount.value==1 && Text.equal t.classification.label "organometallic"
def successorWitness : Bool := match second with
 | .error _ => false | .ok t => t.directCount.value==2
def duplicateControl : Except String Topology := do
 let row ← direct "M1" "C1" ⟨2,by decide⟩
 forceRows "bad" [row,row]
def duplicateWitness : Bool := match duplicateControl with
 | .error _ => true | .ok _ => false
theorem absencePassed : absenceWitness=true := by decide
theorem firstPassed : firstWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem duplicatePassed : duplicateWitness=true := by decide
end SFT.Chemistry.OrganometallicBond
