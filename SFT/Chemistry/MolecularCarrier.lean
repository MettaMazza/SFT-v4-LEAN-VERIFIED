import SFT.Chemistry.MetallicNetwork
import SFT.Chemistry.SourceText
namespace SFT.Chemistry.MolecularCarrier
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

structure Raw where
 occurrences : List String
 elements : List String
 bonds : List Edge
 openChargeFibres : List (String × String)

-- Preserve the helper's standalone domain, including duplicate node names
-- and edges outside the supplied node set. All reached nodes must be known.
def helperNodes (nodes : List String) (edges : List Edge) := nodes ++ edges.flatMap (fun e => [e.1,e.2])
def helperGraph (nodes : List String) (edges : List Edge) : GeneratedGraph :=
 ⟨helperNodes nodes edges,MetallicNetwork.symmetricEdges edges⟩
def connected (nodes : List String) (edges : List Edge) : Bool :=
 match nodes with
 | [] => false
 | first::rest =>
   let network := helperGraph (first::rest) edges
   (first::rest).all (reachable network first) &&
   network.nodes.all (fun node => !(reachable network first node) || has (first::rest) node)

def normalizedEdge (edge : Edge) : Edge :=
 if SFT.Host.Text.le edge.1 edge.2 then edge else (edge.2,edge.1)

def checkEdges (nodes : List String) : List Edge → List Edge → Except String Unit
 | [], _ => .ok ()
 | edge::rest, seen =>
   if !has nodes edge.1 || !has nodes edge.2 || decide (edge.1=edge.2) then
    .error "a molecular bond must join two registered occurrences"
   else if has seen (normalizedEdge edge) then
    .error "a molecular bond occurrence cannot be duplicated"
   else checkEdges nodes rest (normalizedEdge edge::seen)

def basicFailure (raw : Raw) : Bool :=
 raw.occurrences.length < 2 || decide (raw.occurrences.length ≠ raw.elements.length) ||
  !distinct raw.occurrences || !(raw.occurrences++raw.elements).all SourceText.nonblank || raw.bonds.isEmpty

def admit (raw : Raw) : Except String Raw :=
 if basicFailure raw then
  .error "a molecular carrier requires multiple named atomic occurrences and bonds"
 else do
  checkEdges raw.occurrences raw.bonds []
  if !connected raw.occurrences raw.bonds then
   .error "a molecule is one connected bonded carrier"
  else if !raw.openChargeFibres.isEmpty then
   .error "a molecular carrier has no open net-charge fibre"
  else .ok raw

structure Carrier where
 raw : Raw
 accepted : admit raw = .ok raw

def labelCount (label : String) : List String → Nat
 | [] => 0
 | first::rest => if label=first then 1+labelCount label rest else labelCount label rest

def insertLabel (label : String) : List String → List String
 | [] => [label]
 | first::rest =>
   if SFT.Host.Text.equal label first then first::rest
   else if SFT.Host.Text.le label first then label::first::rest
   else first::insertLabel label rest

def sortedLabels : List String → List String
 | [] => []
 | first::rest => insertLabel first (sortedLabels rest)

def compositionSignature (carrier : Raw) :=
 (sortedLabels carrier.elements).map (fun label => (label,labelCount label carrier.elements))

theorem labelCountAppend (label : String) (before after : List String) :
 labelCount label (before++after)=labelCount label before+labelCount label after := by
 induction before with
 | nil => exact (Nat.zero_add _).symm
 | cons first rest ih =>
   change (if label=first then 1+labelCount label (rest++after) else labelCount label (rest++after)) =
    (if label=first then 1+labelCount label rest else labelCount label rest)+labelCount label after
   by_cases equal : label=first
   · rw [ite_eq_left equal,ite_eq_left equal,ih,Nat.add_assoc]
   · rw [ite_eq_right equal,ite_eq_right equal]; exact ih

theorem labelCountPositive (label : String) (labels : List String) (held : label ∈ labels) :
 0<labelCount label labels := by
 induction labels with
 | nil => cases held
 | cons first rest ih =>
   unfold labelCount
   split
   · exact Nat.add_pos_left (by decide : 0<1) _
   · rename_i different
     cases held with
     | head => exact False.elim (different rfl)
     | tail _ member => exact ih member

theorem diatomicComposition :
 compositionSignature ⟨["first","second"],["E","E"],[("first","second")],[]⟩=[("E",2)] := rfl

theorem acceptedConditions (raw output : Raw) (success : admit raw=.ok output) :
 basicFailure raw=false ∧ checkEdges raw.occurrences raw.bonds []=.ok () ∧
 connected raw.occurrences raw.bonds=true ∧ raw.openChargeFibres=[] ∧ output=raw := by
 unfold admit at success
 split at success
 · cases success
 · rename_i base
   have basic : basicFailure raw=false := by
    cases value : basicFailure raw with
    | false => rfl
    | true => exact False.elim (base value)
   cases edges : checkEdges raw.occurrences raw.bonds [] with
   | error message => rw [edges] at success; cases success
   | ok result =>
     cases result
     rw [edges] at success
     change (if !connected raw.occurrences raw.bonds then Except.error "a molecule is one connected bonded carrier"
       else if !raw.openChargeFibres.isEmpty then Except.error "a molecular carrier has no open net-charge fibre"
       else Except.ok raw)=Except.ok output at success
     cases connectivity : connected raw.occurrences raw.bonds with
     | false => rw [connectivity] at success; cases success
     | true =>
       rw [connectivity] at success
       cases fibres : raw.openChargeFibres with
       | nil =>
         rw [fibres] at success
         exact ⟨basic,rfl,rfl,rfl,(Except.ok.inj success).symm⟩
       | cons first rest => rw [fibres] at success; cases success

theorem closedChargeBoundary (carrier : Carrier) : carrier.raw.openChargeFibres=[] :=
 (acceptedConditions _ _ carrier.accepted).2.2.2.1

theorem sourceConnectivity (carrier : Carrier) : connected carrier.raw.occurrences carrier.raw.bonds=true :=
 (acceptedConditions _ _ carrier.accepted).2.2.1

theorem completeRecordRetained (raw output : Raw) (accepted : admit raw=.ok output) :
 output.occurrences=raw.occurrences ∧ output.elements=raw.elements ∧ output.bonds=raw.bonds := by
 have same := (acceptedConditions _ _ accepted).2.2.2.2
 cases same
 exact ⟨rfl,rfl,rfl⟩

theorem helperSourceEndpoints (nodes : List String) (edges : List Edge) (edge : Edge)
 (held : edge ∈ edges) : edge.1 ∈ helperNodes nodes edges ∧ edge.2 ∈ helperNodes nodes edges := by
 constructor
 · exact memAppendRight _ _ _ (SFT.Foundation.CommonRefinement.memFlatMap
    (fun e : Edge => [e.1,e.2]) edges edge edge.1 held (.head _))
 · exact memAppendRight _ _ _ (SFT.Foundation.CommonRefinement.memFlatMap
    (fun e : Edge => [e.1,e.2]) edges edge edge.2 held (.tail _ (.head [])))

theorem helperEndpointCoverage (nodes : List String) (edges : List Edge) :
 ∀ edge ∈ (helperGraph nodes edges).edges,
 edge.1 ∈ (helperGraph nodes edges).nodes ∧ edge.2 ∈ (helperGraph nodes edges).nodes := by
 intro edge member
 cases memAppendCases edge edges (edges.map (fun e : Edge => (e.2,e.1))) member with
 | inl direct => exact helperSourceEndpoints nodes edges edge direct
 | inr reversed =>
   obtain ⟨original,held,equal⟩ := memMapPreimage (fun e : Edge => (e.2,e.1)) edge edges reversed
   have covered := helperSourceEndpoints nodes edges original held
   cases equal
   exact ⟨covered.2,covered.1⟩

theorem connectedPaths (first : String) (rest : List String) (edges : List Edge)
 (success : connected (first::rest) edges=true) :
 ∀ target ∈ first::rest, PathWitness (helperGraph (first::rest) edges) first target := by
 have complete := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp success
 intro target held
 exact reachableHasPath _ _ _ (helperEndpointCoverage _ _)
  (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ complete.1 target held)

theorem connectedExcludesOutside (first : String) (rest : List String) (edges : List Edge)
 (success : connected (first::rest) edges=true) (target : String)
 (path : PathWitness (helperGraph (first::rest) edges) first target) : target ∈ first::rest := by
 have complete := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp success
 have targetNode := pathWitnessTarget _ _ _ path
 have check := SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ complete.2 target targetNode
 have reached := pathWitnessReachable _ _ _ path
 change (!reachable (helperGraph (first::rest) edges) first target || has (first::rest) target)=true at check
 rw [reached] at check
 exact (hasIff _ _).mp check

theorem connectedFromPaths (first : String) (rest : List String) (edges : List Edge)
 (paths : ∀ target ∈ first::rest, PathWitness (helperGraph (first::rest) edges) first target)
 (noOutside : ∀ target, PathWitness (helperGraph (first::rest) edges) first target → target ∈ first::rest) :
 connected (first::rest) edges=true := by
 apply (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr
 constructor
 · exact (allTrueIffMembers _ _).mpr (fun target held => pathWitnessReachable _ _ _ (paths target held))
 · apply (allTrueIffMembers _ _).mpr
   intro target member
   cases reach : reachable (helperGraph (first::rest) edges) first target with
   | false => rfl
   | true =>
     have known := noOutside target (reachableHasPath _ _ _ (helperEndpointCoverage _ _) reach)
     have check := (hasIff _ _).mpr known
     change (!true || has (first::rest) target)=true
     rw [check]
     rfl

theorem connectedFixedPointEquivalent (first : String) (rest : List String) (edges : List Edge)
 (reached : List String)
 (history : MetallicNetwork.ReachedBySweeps (helperGraph (first::rest) edges) first reached)
 (initial : first ∈ reached)
 (closed : ∀ left right, left ∈ reached → (left,right) ∈ (helperGraph (first::rest) edges).edges → right ∈ reached) :
 connected (first::rest) edges=true ↔
 (∀ target ∈ first::rest, target ∈ reached) ∧ (∀ target ∈ reached, target ∈ first::rest) := by
 constructor
 · intro success
   constructor
   · intro target held
     exact pathWitnessInClosedSet _ _ _ reached closed initial (connectedPaths _ _ _ success target held)
   · intro target held
     exact connectedExcludesOutside _ _ _ success target (MetallicNetwork.sweepAdditionsHavePaths _ _ _ history target held)
 · intro sameSet
   apply connectedFromPaths
   · intro target held
     exact MetallicNetwork.sweepAdditionsHavePaths _ _ _ history target (sameSet.1 target held)
   · intro target path
     exact sameSet.2 target (pathWitnessInClosedSet _ _ _ reached closed initial path)

theorem checkedEndpoints (nodes : List String) (edges seen : List Edge)
 (checked : checkEdges nodes edges seen=.ok ()) :
 ∀ edge ∈ edges, edge.1 ∈ nodes ∧ edge.2 ∈ nodes := by
 induction edges generalizing seen with
 | nil => intro edge held; cases held
 | cons first rest ih =>
   unfold checkEdges at checked
   split at checked
   · cases checked
   · rename_i valid
     have endpoints : first.1 ∈ nodes ∧ first.2 ∈ nodes := by
      have left : has nodes first.1=true := by
       cases h : has nodes first.1 with
       | true => rfl
       | false =>
         rw [h] at valid
         exact False.elim (valid rfl)
      have right : has nodes first.2=true := by
       cases h : has nodes first.2 with
       | true => rfl
       | false =>
         rw [h,left] at valid
         exact False.elim (valid rfl)
      exact ⟨(hasIff _ _).mp left,(hasIff _ _).mp right⟩
     split at checked
     · cases checked
     · intro edge held
       cases held with
       | head => exact endpoints
       | tail _ member => exact ih _ checked edge member

theorem allConstituentEndpoints (carrier : Carrier) :
 ∀ edge ∈ carrier.raw.bonds, edge.1 ∈ carrier.raw.occurrences ∧ edge.2 ∈ carrier.raw.occurrences :=
 checkedEndpoints _ _ _ (acceptedConditions _ _ carrier.accepted).2.1

theorem helperNodesKnown (nodes : List String) (edges : List Edge)
 (covered : ∀ edge ∈ edges, edge.1 ∈ nodes ∧ edge.2 ∈ nodes) :
 ∀ node ∈ helperNodes nodes edges, node ∈ nodes := by
 intro node member
 cases memAppendCases node nodes (edges.flatMap (fun e : Edge => [e.1,e.2])) member with
 | inl original => exact original
 | inr endpoint =>
   obtain ⟨edge,held,endpoint⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin (fun e : Edge => [e.1,e.2]) edges node endpoint
   cases endpoint with
   | head => exact (covered edge held).1
   | tail _ second =>
     cases second with
     | head => exact (covered edge held).2
     | tail _ impossible => cases impossible

def appendOccurrence (raw : Raw) (occurrence element anchor : String) : Raw :=
 ⟨raw.occurrences++[occurrence],raw.elements++[element],raw.bonds++[(anchor,occurrence)],raw.openChargeFibres⟩

theorem appendRetainsCharge (carrier : Carrier) (occurrence element anchor : String) :
 (appendOccurrence carrier.raw occurrence element anchor).openChargeFibres=[] := closedChargeBoundary carrier

theorem appendRetainsIdentities (raw : Raw) (occurrence element anchor prior : String)
 (held : prior ∈ raw.occurrences) : prior ∈ (appendOccurrence raw occurrence element anchor).occurrences :=
 memAppendLeft _ _ _ held

theorem appendRetainsBonds (raw : Raw) (occurrence element anchor : String) (edge : Edge)
 (held : edge ∈ raw.bonds) : edge ∈ (appendOccurrence raw occurrence element anchor).bonds :=
 memAppendLeft _ _ _ held

theorem appendCountsElement (raw : Raw) (occurrence element anchor label : String) :
 labelCount label (appendOccurrence raw occurrence element anchor).elements =
 labelCount label raw.elements + (if label=element then 1 else 0) := by
 rw [show (appendOccurrence raw occurrence element anchor).elements=raw.elements++[element] from rfl,labelCountAppend]
 unfold labelCount
 split <;> rfl

theorem adjacentOccurrencePreservesConnectivity (first : String) (rest : List String)
 (edges : List Edge) (anchor fresh : String)
 (covered : ∀ edge ∈ edges, edge.1 ∈ first::rest ∧ edge.2 ∈ first::rest)
 (prior : connected (first::rest) edges=true) (anchorHeld : anchor ∈ first::rest) :
 connected ((first::rest)++[fresh]) (edges++[(anchor,fresh)])=true := by
 let newNodes := (first::rest)++[fresh]
 let newEdges := edges++[(anchor,fresh)]
 have newCovered : ∀ edge ∈ newEdges, edge.1 ∈ newNodes ∧ edge.2 ∈ newNodes := by
  intro edge held
  cases memAppendCases edge edges [(anchor,fresh)] held with
  | inl old => exact ⟨memAppendLeft _ _ _ (covered edge old).1,memAppendLeft _ _ _ (covered edge old).2⟩
  | inr added =>
    cases added with
    | head => exact ⟨memAppendLeft _ _ _ anchorHeld,memAppendRight _ _ _ (.head [])⟩
    | tail _ impossible => cases impossible
 have keepNodes : ∀ node ∈ helperNodes (first::rest) edges, node ∈ helperNodes newNodes newEdges := by
  intro node held
  exact memAppendLeft _ _ _ (memAppendLeft _ _ _ (helperNodesKnown _ _ covered node held))
 have keepEdges := MetallicNetwork.symmetricEdgesMonotone edges newEdges (fun edge held => memAppendLeft _ _ _ held)
 have oldPaths := connectedPaths first rest edges prior
 have retained : ∀ target ∈ first::rest, PathWitness (helperGraph newNodes newEdges) first target :=
  fun target held => retainedPathWitness _ _ keepNodes keepEdges _ _ (oldPaths target held)
 apply connectedFromPaths first (rest++[fresh]) newEdges
 · intro target held
   cases memAppendCases target (first::rest) [fresh] held with
   | inl old => exact retained target old
   | inr added =>
     cases added with
     | head =>
       exact extendPathWitness _ _ _ _ (retained anchor anchorHeld)
        (memAppendLeft _ _ _ (memAppendRight _ _ _ (.head [])))
        (memAppendLeft _ _ _ (memAppendRight fresh (first::rest) [fresh] (.head [])))
     | tail _ impossible => cases impossible
 · intro target path
   exact helperNodesKnown newNodes newEdges newCovered target (pathWitnessTarget _ _ _ path)

def originalDiatomic : Raw :=
 ⟨["atom-occurrence-one","atom-occurrence-two"],["E","E"],[("atom-occurrence-one","atom-occurrence-two")],[]⟩

theorem originalDiatomicConnected : connected originalDiatomic.occurrences originalDiatomic.bonds=true := by
 apply connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ remaining =>
     cases remaining with
     | head => exact ⟨["atom-occurrence-one"],by decide,rfl⟩
     | tail _ impossible => cases impossible
 · intro target path
   apply helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head [])⟩
   | tail _ impossible => cases impossible

theorem originalDiatomicAdmitted : admit originalDiatomic=.ok originalDiatomic := by
 unfold admit
 rw [show basicFailure originalDiatomic=false from rfl]
 change (if (!connected originalDiatomic.occurrences originalDiatomic.bonds)=true then _ else _)=_
 rw [originalDiatomicConnected]
 rfl

theorem originalDiatomicComposition : compositionSignature originalDiatomic=[("E",2)] := rfl

end SFT.Chemistry.MolecularCarrier



