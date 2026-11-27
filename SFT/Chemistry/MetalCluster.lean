import SFT.Chemistry.InsertionEliminationDerivation
import SFT.Chemistry.MetalClusterClosure
namespace SFT.Chemistry.MetalCluster
open SFT.Host SFT.Physics.CapabilityValues
open InorganicColour (sameLabel distinctLabels)
structure Relation where
 left : HeldLabel
 right : HeldLabel
 mode : HeldLabel
 bridges : List HeldLabel
def makeRelation (left right mode : HeldLabel) (bridges : List HeldLabel) : Except String Relation :=
 if !Text.equal left.family "metal-centre" || !Text.equal right.family "metal-centre" || sameLabel left right then
  .error "cluster relation requires two distinct metal centres"
 else if !Text.equal mode.family "cluster-relation" ||
  !(Text.equal mode.label "direct-metal-bond" || Text.equal mode.label "bridging-ligand-path" || Text.equal mode.label "held-grouping-relation") then
  .error "cluster relation mode is outside the complete forced set"
 else if Text.equal mode.label "bridging-ligand-path" && (bridges.isEmpty || bridges.any (fun x => !Text.equal x.family "bridging-ligand-occurrence")) then
  .error "bridging relation requires positive complete bridge support"
 else if !Text.equal mode.label "bridging-ligand-path" && !bridges.isEmpty then
  .error "only a bridging relation carries bridge support"
 else .ok ⟨left,right,mode,bridges⟩
def relation (left right mode : String) (bridgeCount : ElectronCountSpin.CountOrEmpty := .emptyOne "empty-One") : Except String Relation := do
 let n := match bridgeCount with | .emptyOne _ => 0 | .count n => n.value
 let l ← heldLabel "metal-centre" left
 let r ← heldLabel "metal-centre" right
 let m ← heldLabel "cluster-relation" mode
 let bridges ← (List.range n).mapM fun i => heldLabel "bridging-ligand-occurrence" (Text.intercalate "-" [left,right,"bridge",toString (i+1)])
 makeRelation l r m bridges
def relationKey (r : Relation) : String × String × String :=
 if Text.le r.left.label r.right.label then (r.left.label,r.right.label,r.mode.label)
 else (r.right.label,r.left.label,r.mode.label)
def sameKey (a b : Relation) : Bool :=
 let x := relationKey a
 let y := relationKey b
 Text.equal x.1 y.1 && Text.equal x.2.1 y.2.1 && Text.equal x.2.2 y.2.2
def distinctRelations : List Relation → Bool
 | [] => true
 | r::rs => !(rs.any (sameKey r)) && distinctRelations rs
def edges (rs : List Relation) : List MulticentreSupport.Edge := rs.map fun r => ⟨r.left,r.right⟩
def reached (rs : List Relation) (first : HeldLabel) : List HeldLabel :=
 MulticentreSupport.connectedScan ((MetalClusterClosure.endpoints (edges rs)).length+1) (edges rs) [first]
def connected (cs : List HeldLabel) (rs : List Relation) : Bool := match cs with
 | [] => false
 | first::_ =>
  let found := reached rs first
  found.all (MulticentreSupport.contains cs) && cs.all (MulticentreSupport.contains found)
def classCount (mode : String) (rs : List Relation) : Nat := (rs.filter (fun r => Text.equal r.mode.label mode)).length
def counted (n : Nat) : ElectronCountSpin.CountOrEmpty :=
 if h : 0<n then .count ⟨n,h⟩ else .emptyOne "empty-One"
def sameCount : ElectronCountSpin.CountOrEmpty → ElectronCountSpin.CountOrEmpty → Bool
 | .emptyOne a,.emptyOne b => Text.equal a b
 | .count a,.count b => a.value==b.value
 | .emptyOne _,.count _ | .count _,.emptyOne _ => false
structure Cluster where
 entity : HeldLabel
 centres : List HeldLabel
 relations : List Relation
 centreCount : PositiveCount
 directCount : ElectronCountSpin.CountOrEmpty
 bridgeCount : ElectronCountSpin.CountOrEmpty
def cluster (entity : HeldLabel) (cs : List HeldLabel) (rs : List Relation) (n : PositiveCount)
 (direct bridge : ElectronCountSpin.CountOrEmpty) : Except String Cluster :=
 if !Text.equal entity.family "cluster-entity" || cs.length<2 || !distinctLabels cs || cs.any (fun x => !Text.equal x.family "metal-centre") then
  .error "cluster requires finite complete support of at least two distinct metal centres"
 else if n.value != cs.length || rs.isEmpty then
  .error "cluster count and positive relation support must be complete"
 else if !distinctRelations rs then .error "cluster relations cannot duplicate"
 else if !connected cs rs then .error "cluster support must be connected"
 else if !sameCount direct (counted (classCount "direct-metal-bond" rs)) || !sameCount bridge (counted (classCount "bridging-ligand-path" rs)) then
  .error "direct and bridging counts must preserve exact support or structural EmptyOne"
 else .ok ⟨entity,cs,rs,n,direct,bridge⟩
def forced (entity : String) (centres : List String) (rs : List Relation) : Except String Cluster := do
 let cs ← centres.mapM (heldLabel "metal-centre")
 let e ← heldLabel "cluster-entity" entity
 let n ← count cs.length
 cluster e cs rs n (counted (classCount "direct-metal-bond" rs)) (counted (classCount "bridging-ligand-path" rs))
def appendCentre (c : Cluster) (label attachTo mode : String) : Except String Cluster := do
 let bridge := if Text.equal mode "bridging-ligand-path" then ElectronCountSpin.CountOrEmpty.count ⟨1,by decide⟩ else .emptyOne "empty-One"
 let r ← relation attachTo label mode bridge
 forced c.entity.label (c.centres.map HeldLabel.label++[label]) (c.relations++[r])
def direct : Except String Cluster := do forced "d" ["M1","M2"] [← relation "M1" "M2" "direct-metal-bond"]
def bridged : Except String Cluster := do forced "b" ["M1","M2"] [← relation "M1" "M2" "bridging-ligand-path" (.count ⟨2,by decide⟩)]
def grouped : Except String Cluster := do forced "g" ["M1","M2"] [← relation "M1" "M2" "held-grouping-relation"]
def positiveValue : ElectronCountSpin.CountOrEmpty → Nat
 | .emptyOne _ => 0 | .count n => n.value
def isEmpty : ElectronCountSpin.CountOrEmpty → Bool
 | .emptyOne _ => true | .count _ => false
def directWitness : Bool := match direct with
 | .error _ => false | .ok c => positiveValue c.directCount==1
def bridgeGroupWitness : Bool := match bridged,grouped with
 | .ok b,.ok g => positiveValue b.bridgeCount==1 && isEmpty g.directCount
 | .error _,.error _ | .error _,.ok _ | .ok _,.error _ => false
def successorWitness : Bool := match bridged with
 | .error _ => false
 | .ok b => match appendCentre b "M3" "M2" "bridging-ligand-path" with
  | .error _ => false | .ok s => s.centreCount.value==3
def disconnectedWitness : Bool := match (do forced "x" ["M1","M2","M3"] [← relation "M1" "M2" "direct-metal-bond"]) with
 | .error _ => true | .ok _ => false
theorem directPassed : directWitness=true := by decide
theorem bridgeGroupPassed : bridgeGroupWitness=true := by decide
theorem successorPassed : successorWitness=true := by decide
theorem disconnectedPassed : disconnectedWitness=true := by decide
end SFT.Chemistry.MetalCluster
