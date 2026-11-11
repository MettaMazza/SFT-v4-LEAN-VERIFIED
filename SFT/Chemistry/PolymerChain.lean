import SFT.Chemistry.Functional
import SFT.Mathematics.GraphInduction
namespace SFT.Chemistry.PolymerChain
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.GraphOperations
open SFT.Mathematics.DiscreteObjects

structure Occurrence (unit : Functional.Group) where
 identity : String
 embedding : Functional.Embedding unit

structure Connection (unit : Functional.Group) (Word Cell : Type) where
 left : Occurrence unit
 right : Occurrence unit
 covalent : CovalentSharing.BoundChannels Word Cell
 leftAtomHeld : covalent.bond.support.raw.left∈Functional.imageSupport left.embedding
 rightAtomHeld : covalent.bond.support.raw.right∈Functional.imageSupport right.embedding

def connectionEdge {unit : Functional.Group} {Word Cell : Type} (c : Connection unit Word Cell) : Edge :=
 (c.left.identity,c.right.identity)

def copyTrace {unit : Functional.Group} (first : Occurrence unit) (middle : List (Occurrence unit))
 (last : Occurrence unit) := first::middle++[last]

def names {unit : Functional.Group} (copies : List (Occurrence unit)) := copies.map Occurrence.identity

structure Incidence (unit : Functional.Group) (Word Cell : Type) where
 first : Occurrence unit
 middle : List (Occurrence unit)
 last : Occurrence unit
 unique : distinct (names (copyTrace first middle last))=true
 connections : List (Connection unit Word Cell)
 completeOrder : connections.map connectionEdge=adjacentPairs (names (copyTrace first middle last))
 allCopies : ∀ c∈connections, c.left∈copyTrace first middle last ∧ c.right∈copyTrace first middle last

def copies {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) := copyTrace c.first c.middle c.last

def extent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) := (copies c).length

def graph {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) : GeneratedGraph :=
 ⟨names (copies c),c.connections.map connectionEdge⟩

theorem positiveExtent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) : 0<extent c :=
 Nat.zero_lt_succ _

theorem completeOrderedPath {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) :
 pathIsValid (graph c) (names (copies c))=true := by
 apply (pathMeaning _ _).mpr
 refine ⟨?_,fun _ held => held,?_⟩
 · rfl
 · intro edge held
   change edge∈c.connections.map connectionEdge
   rw [c.completeOrder]
   exact held

theorem everyNeighborIsCovalent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (edge : Edge) (held : edge∈adjacentPairs (names (copies c))) :
 ∃ bond∈c.connections, connectionEdge bond=edge := by
 change edge∈adjacentPairs (names (copyTrace c.first c.middle c.last)) at held
 rw [←c.completeOrder] at held
 exact memMapPreimage _ _ _ held

theorem everyConnectionOnTrace {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (bond : Connection unit Word Cell) (held : bond∈c.connections) :
 connectionEdge bond∈adjacentPairs (names (copies c)) := by
 change connectionEdge bond∈adjacentPairs (names (copyTrace c.first c.middle c.last))
 rw [←c.completeOrder]
 exact memMap _ _ _ held

theorem covalentRecurrenceRetained {unit : Functional.Group} {Word Cell : Type}
 (bond : Connection unit Word Cell) :
 SFT.QuantumComputation.ReversibleModel.phaseAction bond.covalent.bond.recurrence.prepared.state
 (bond.covalent.bond.interactionTrace.flatMap Prod.snd)=.ok bond.covalent.bond.recurrence.prepared.state :=
 CovalentSharing.boundSourceRecurs bond.covalent

theorem appendedCopies {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 copyTrace first (middle++[last]) next=copyTrace first middle last++[next] := by
 change first::((middle++[last])++[next])=first::(middle++[last]++[next])
 rfl

theorem appendedNames {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 names (copyTrace first (middle++[last]) next)=names (copyTrace first middle last)++[next.identity] := by
 rw [appendedCopies]
 exact SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem appendedEdges {unit : Functional.Group} (first last next : Occurrence unit)
 (middle : List (Occurrence unit)) :
 adjacentPairs (names (copyTrace first (middle++[last]) next))=
 adjacentPairs (names (copyTrace first middle last))++[(last.identity,next.identity)] := by
 have split : names (copyTrace first (middle++[last]) next)=
  (first.identity::names middle)++[last.identity,next.identity] := by
   change first.identity::((middle++[last]++[next]).map Occurrence.identity)=_
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,SFT.Mathematics.ExactTraceArithmetic.mapAppend]
   exact congrArg (List.cons first.identity) (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _)
 have old : names (copyTrace first middle last)=(first.identity::names middle)++[last.identity] := by
   unfold names copyTrace
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
   rfl
 rw [split,old]
 exact adjacentPairsComposition _ _ _

def append {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 Incidence unit Word Cell where
 first := c.first
 middle := c.middle++[c.last]
 last := next
 unique := by
  rw [appendedNames]
  exact Chirality.appendFreshDistinct _ _ c.unique fresh
 connections := c.connections++[bond]
 completeOrder := by
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,c.completeOrder,appendedEdges]
  change _++[(bond.left.identity,bond.right.identity)]=_
  rw [left,right]
 allCopies := by
  intro old held
  rw [appendedCopies]
  cases memAppendCases old c.connections [bond] held with
  | inl previous =>
    have bound := c.allCopies old previous
    exact ⟨memAppendLeft _ _ _ bound.1,memAppendLeft _ _ _ bound.2⟩
  | inr added => cases added with
    | head =>
      rw [left,right]
      exact ⟨memAppendLeft _ _ _ (.tail _ (memAppendRight _ _ _ (.head []))),memAppendRight _ _ _ (.head [])⟩
    | tail _ impossible => cases impossible

theorem successorExtent {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 extent (append c next bond fresh left right)=extent c+1 := by
 change (copyTrace c.first (c.middle++[c.last]) next).length=(copies c).length+1
 rw [appendedCopies,SFT.Foundation.CommonRefinement.appendLength]
 rfl

theorem successorEnds {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (next : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next) :
 (append c next bond fresh left right).first=c.first ∧ (append c next bond fresh left right).last=next := ⟨rfl,rfl⟩


def base {unit : Functional.Group} {Word Cell : Type} (bond : Connection unit Word Cell)
 (fresh : ¬bond.right.identity∈[bond.left.identity]) : Incidence unit Word Cell where
 first := bond.left
 middle := []
 last := bond.right
 unique := Chirality.appendFreshDistinct [bond.left.identity] bond.right.identity rfl fresh
 connections := [bond]
 completeOrder := rfl
 allCopies := by
  intro c held
  cases held with
  | head => exact ⟨.head _,.tail _ (.head _)⟩
  | tail _ impossible => cases impossible

theorem baseExtent {unit : Functional.Group} {Word Cell : Type} (bond : Connection unit Word Cell)
 (fresh : ¬bond.right.identity∈[bond.left.identity]) : extent (base bond fresh)=2 := rfl

theorem pathToEveryMember (network : GeneratedGraph) (tail : List String) :
 ∀ first, (∀ x∈first::tail, x∈network.nodes) →
 (∀ e∈adjacentPairs (first::tail), e∈network.edges) →
 ∀ target∈first::tail, PathWitness network first target := by
 induction tail with
 | nil =>
   intro first nodes edges target held
   cases held with
   | head => exact identityPathWitness network first (nodes first (.head []))
   | tail _ impossible => cases impossible
 | cons second tail ih =>
   intro first nodes edges target held
   cases held with
   | head => exact identityPathWitness network first (nodes first (.head _))
   | tail _ rest =>
     have bridge := extendPathWitness network first first second
      (identityPathWitness network first (nodes first (.head _)))
      (edges (first,second) (.head _)) (nodes second (.tail _ (.head _)))
     have remaining := ih second (fun x h => nodes x (.tail _ h))
      (fun e h => edges e (.tail _ h)) target rest
     exact composePathWitnesses network first second target bridge remaining

theorem everyRepeatReachable {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (name : String) (held : name∈names (copies c)) :
 reachable (graph c) c.first.identity name=true := by
 apply pathWitnessReachable
 apply pathToEveryMember (graph c) (names (c.middle++[c.last])) c.first.identity
 · intro x h; exact h
 · intro e h
   change e∈c.connections.map connectionEdge
   rw [c.completeOrder]
   exact h
 · exact held

theorem priorOccurrenceRetained {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (next old : Occurrence unit) (bond : Connection unit Word Cell)
 (fresh : ¬next.identity∈names (copies c)) (left : bond.left=c.last) (right : bond.right=next)
 (held : old∈copies c) : old∈copies (append c next bond fresh left right) := by
 change old∈copyTrace c.first (c.middle++[c.last]) next
 rw [appendedCopies]
 exact memAppendLeft _ _ _ held


def repeatEdges {unit : Functional.Group} (o : Occurrence unit) : List Edge :=
 unit.fragment.carrier.bonds.map (fun e => (o.embedding.image e.1,o.embedding.image e.2))

def repeatGraph {unit : Functional.Group} (o : Occurrence unit) : GeneratedGraph :=
 ⟨Functional.imageSupport o.embedding,MetallicNetwork.symmetricEdges (repeatEdges o)⟩

def atomicGraph {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell) : GeneratedGraph :=
 ⟨(copies c).flatMap (fun o => (repeatGraph o).nodes),
  (copies c).flatMap (fun o => (repeatGraph o).edges)++
  MetallicNetwork.symmetricEdges (c.connections.map
   (fun bond => (bond.covalent.bond.support.raw.left,bond.covalent.bond.support.raw.right)))⟩

theorem repeatNodeRetained {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (o : Occurrence unit) (held : o∈copies c) (atom : String) (inside : atom∈(repeatGraph o).nodes) :
 atom∈(atomicGraph c).nodes := SFT.Foundation.CommonRefinement.memFlatMap _ _ _ _ held inside

theorem repeatEdgeRetained {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (o : Occurrence unit) (held : o∈copies c) (edge : Edge) (inside : edge∈(repeatGraph o).edges) :
 edge∈(atomicGraph c).edges := memAppendLeft _ _ _
 (SFT.Foundation.CommonRefinement.memFlatMap _ _ _ _ held inside)

theorem repeatPathRetained {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (o : Occurrence unit) (held : o∈copies c) (a b : String) (path : PathWitness (repeatGraph o) a b) :
 PathWitness (atomicGraph c) a b := retainedPathWitness _ _
 (repeatNodeRetained c o held) (repeatEdgeRetained c o held) a b path

theorem allAtomicNodesCovered {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (atom : String) (held : atom∈(atomicGraph c).nodes) :
 ∃ o∈copies c, atom∈(repeatGraph o).nodes :=
 SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ held

theorem covalentEdgeRetained {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (bond : Connection unit Word Cell) (held : bond∈c.connections) :
 (bond.covalent.bond.support.raw.left,bond.covalent.bond.support.raw.right)∈(atomicGraph c).edges :=
 memAppendRight _ _ _ (memAppendLeft _ _ _ (memMap _ _ _ held))

theorem copyIdentityInjective {unit : Functional.Group} (os : List (Occurrence unit))
 (unique : distinct (names os)=true) (a b : Occurrence unit)
 (ha : a∈os) (hb : b∈os) (equal : a.identity=b.identity) : a=b := by
 induction os with
 | nil => cases ha
 | cons first rest ih =>
   have parts := (distinctCons first.identity (names rest)).mp unique
   have absent := (absentIff (names rest) first.identity).mp parts.1
   cases ha with
   | head => cases hb with
     | head => rfl
     | tail _ held =>
       exact False.elim (absent (equal.symm ▸ memMap Occurrence.identity b rest held))
   | tail _ held => cases hb with
     | head => exact False.elim (absent (equal ▸ memMap Occurrence.identity a rest held))
     | tail _ other => exact ih parts.2 held other

theorem actualNeighborConnection {unit : Functional.Group} {Word Cell : Type} (c : Incidence unit Word Cell)
 (a b : Occurrence unit) (ha : a∈copies c) (hb : b∈copies c)
 (neighbor : (a.identity,b.identity)∈adjacentPairs (names (copies c))) :
 ∃ bond∈c.connections, bond.left=a ∧ bond.right=b := by
 obtain ⟨bond,held,equal⟩ := everyNeighborIsCovalent c _ neighbor
 have bound := c.allCopies bond held
 exact ⟨bond,held,copyIdentityInjective (copies c) c.unique bond.left a bound.1 ha (congrArg Prod.fst equal),
  copyIdentityInjective (copies c) c.unique bond.right b bound.2 hb (congrArg Prod.snd equal)⟩


theorem orderedCopyInduction {unit : Functional.Group} (tail : List (Occurrence unit))
 (property : Occurrence unit → Prop) : ∀ first, property first →
 (∀ a∈first::tail, ∀ b∈first::tail,
  (a.identity,b.identity)∈adjacentPairs (names (first::tail)) → property a → property b) →
 ∀ o∈first::tail, property o := by
 induction tail with
 | nil =>
   intro first initial step o held
   cases held with
   | head => exact initial
   | tail _ impossible => cases impossible
 | cons second rest ih =>
   intro first initial step o held
   cases held with
   | head => exact initial
   | tail _ held =>
     have next := step first (.head _) second (.tail _ (.head _)) (.head _) initial
     apply ih second next (fun a ha b hb edge pa => step a (.tail _ ha) b (.tail _ hb) (.tail _ edge) pa) o held

theorem atomPathsAcrossNeighbor {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (origin : String) (a b : Occurrence unit)
 (ha : a∈copies c) (hb : b∈copies c)
 (neighbor : (a.identity,b.identity)∈adjacentPairs (names (copies c)))
 (within : ∀ x∈(repeatGraph b).nodes, ∀ y∈(repeatGraph b).nodes, PathWitness (repeatGraph b) x y)
 (previous : ∀ x∈(repeatGraph a).nodes, PathWitness (atomicGraph c) origin x) :
 ∀ y∈(repeatGraph b).nodes, PathWitness (atomicGraph c) origin y := by
 obtain ⟨bond,held,left,right⟩ := actualNeighborConnection c a b ha hb neighbor
 have leftAtom := bond.leftAtomHeld
 have rightAtom := bond.rightAtomHeld
 rw [left] at leftAtom
 rw [right] at rightAtom
 have toLeft := previous _ leftAtom
 have cross := extendPathWitness (atomicGraph c) origin
  bond.covalent.bond.support.raw.left bond.covalent.bond.support.raw.right
  toLeft (covalentEdgeRetained c bond held) (repeatNodeRetained c b hb _ rightAtom)
 intro y hy
 exact composePathWitnesses (atomicGraph c) origin bond.covalent.bond.support.raw.right y cross
  (repeatPathRetained c b hb _ _ (within _ rightAtom y hy))

theorem allAtomsReachableFromFirst {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (origin : String) (originHeld : origin∈(repeatGraph c.first).nodes)
 (within : ∀ o∈copies c, ∀ x∈(repeatGraph o).nodes, ∀ y∈(repeatGraph o).nodes,
  PathWitness (repeatGraph o) x y) :
 ∀ atom∈(atomicGraph c).nodes, reachable (atomicGraph c) origin atom=true := by
 have firstHeld : c.first∈copies c := .head _
 have reached : ∀ o∈copies c, ∀ atom∈(repeatGraph o).nodes,
  PathWitness (atomicGraph c) origin atom := by
   apply orderedCopyInduction (c.middle++[c.last])
    (fun o => ∀ atom∈(repeatGraph o).nodes, PathWitness (atomicGraph c) origin atom) c.first
   · intro atom held
     exact repeatPathRetained c c.first firstHeld origin atom (within c.first firstHeld origin originHeld atom held)
   · intro a ha b hb neighbor before
     exact atomPathsAcrossNeighbor c origin a b ha hb neighbor (within b hb) before
 intro atom held
 obtain ⟨o,copyHeld,atomHeld⟩ := allAtomicNodesCovered c atom held
 exact pathWitnessReachable _ _ _ (reached o copyHeld atom atomHeld)


-- Exact standalone RepeatingCarrier source domain: positive counts remain
-- independently supplied; this constructor does not impose a path-count identity.
structure Raw where
 repeatIdentity : SFT.Physics.CapabilityValues.HeldLabel
 occurrences : SFT.Physics.CapabilityValues.PositiveCount
 connections : SFT.Physics.CapabilityValues.PositiveCount

def admit (r : Raw) : Except String Raw :=
 if r.repeatIdentity.family="repeat-unit" then .ok r
 else .error "polymer witness requires a repeat-unit identity"

def originalRaw : Raw := ⟨⟨"repeat-unit","unit-a",rfl,rfl⟩,⟨3,by decide⟩,⟨2,by decide⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl

theorem sourcePositiveExtent (r : Raw) : 0<r.occurrences.value := r.occurrences.positive
theorem sourcePositiveConnections (r : Raw) : 0<r.connections.value := r.connections.positive

def incrementRaw (r : Raw) : Raw :=
 ⟨r.repeatIdentity,⟨r.occurrences.value+1,Nat.zero_lt_succ _⟩,
  ⟨r.connections.value+1,Nat.zero_lt_succ _⟩⟩

theorem rawSuccessorPreservesIdentity (r : Raw) : (incrementRaw r).repeatIdentity=r.repeatIdentity := rfl

theorem rawSuccessorPreservesAdmission (r : Raw) (held : admit r=.ok r) :
 admit (incrementRaw r)=.ok (incrementRaw r) := by
 unfold admit at held ⊢
 change (if r.repeatIdentity.family="repeat-unit" then Except.ok (incrementRaw r)
  else Except.error "polymer witness requires a repeat-unit identity")=Except.ok (incrementRaw r)
 split at held
 · rename_i family
   rw [ite_eq_left family]
 · cases held

theorem reversedEdgeHeld (edges : List Edge) (edge : Edge)
 (held : edge∈MetallicNetwork.symmetricEdges edges) :
 (edge.2,edge.1)∈MetallicNetwork.symmetricEdges edges := by
 cases memAppendCases edge edges (edges.map (fun e : Edge => (e.2,e.1))) held with
 | inl original => exact memAppendRight _ _ _ (memMap _ _ _ original)
 | inr reversed =>
   obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ reversed
   cases equal
   exact memAppendLeft _ _ _ member

theorem reverseSourcePath (network : GeneratedGraph)
 (symmetric : ∀ edge∈network.edges, (edge.2,edge.1)∈network.edges)
 (origin target : String) (path : PathWitness network origin target) : PathWitness network target origin := by
 obtain ⟨initialPath,valid,starts⟩ := path
 induction initialPath generalizing origin with
 | nil =>
   have same : target=origin := Option.some.inj starts
   cases same
   exact identityPathWitness network target (((pathMeaning _ _).mp valid).2.1 target (.head []))
 | cons first rest ih =>
   have same : first=origin := Option.some.inj starts
   cases same
   cases rest with
   | nil =>
     have data := (pathMeaning _ _).mp valid
     exact extendPathWitness network target target first
      (identityPathWitness network target (data.2.1 target (.tail _ (.head []))))
      (symmetric (first,target) (data.2.2 _ (.head []))) (data.2.1 first (.head _))
   | cons second rest =>
     have data := (pathMeaning _ _).mp valid
     have tailValid : pathIsValid network ((second::rest)++[target])=true :=
      (pathMeaning _ _).mpr ⟨rfl,fun n h => data.2.1 n (.tail _ h),fun e h => data.2.2 e (.tail _ h)⟩
     have tailReverse := ih second tailValid rfl
     exact extendPathWitness network target second first tailReverse
      (symmetric (first,second) (data.2.2 _ (.head _))) (data.2.1 first (.head _))

def mapEdge (f : String → String) (e : Edge) : Edge := (f e.1,f e.2)
def mappedGraph (f : String → String) (network : GeneratedGraph) : GeneratedGraph :=
 ⟨network.nodes.map f,network.edges.map (mapEdge f)⟩

theorem mapAdjacent (f : String → String) (path : List String) :
 adjacentPairs (path.map f)=(adjacentPairs path).map (mapEdge f) := by
 induction path with
 | nil => rfl
 | cons first rest ih =>
   cases rest with
   | nil => rfl
   | cons second rest => exact congrArg (List.cons (f first,f second)) ih

theorem mappedPathValid (f : String → String) (network : GeneratedGraph) (path : List String)
 (valid : pathIsValid network path=true) : pathIsValid (mappedGraph f network) (path.map f)=true := by
 have data := (pathMeaning _ _).mp valid
 apply (pathMeaning _ _).mpr
 refine ⟨?_,?_,?_⟩
 · cases path with
   | nil => cases data.1
   | cons first rest => rfl
 · intro node held
   obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ held
   exact equal ▸ memMap f original network.nodes (data.2.1 original member)
 · intro edge held
   rw [mapAdjacent] at held
   obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ held
   exact equal ▸ memMap (mapEdge f) original network.edges (data.2.2 original member)

theorem mappedPathWitness (f : String → String) (network : GeneratedGraph) (a b : String)
 (path : PathWitness network a b) : PathWitness (mappedGraph f network) (f a) (f b) := by
 obtain ⟨initialPath,valid,starts⟩ := path
 refine ⟨initialPath.map f,?_,?_⟩
 · have mapped := mappedPathValid f network (initialPath++[b]) valid
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend] at mapped
   exact mapped
 · cases initialPath with
   | nil =>
     have same : b=a := Option.some.inj starts
     cases same
     rfl
   | cons first rest =>
     have same : first=a := Option.some.inj starts
     cases same
     rfl

theorem mappedSymmetricEdges (f : String → String) (edges : List Edge) :
 (MetallicNetwork.symmetricEdges edges).map (mapEdge f)=
 MetallicNetwork.symmetricEdges (edges.map (mapEdge f)) := by
 unfold MetallicNetwork.symmetricEdges
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 rw [Diastereomer.sourceMapCompose,Diastereomer.sourceMapCompose]
 rfl


-- The source's connected low-mass unit trace supplies paths before embedding;
-- no connectedness of an arbitrary surrounding molecule is substituted here.
theorem connectedUnitPaths (unit : Functional.Group)
 (connected : MolecularCarrier.connected unit.fragment.carrier.occurrences unit.fragment.carrier.bonds=true)
 (a b : String) (ha : a∈unit.fragment.carrier.occurrences) (hb : b∈unit.fragment.carrier.occurrences) :
 PathWitness (MetallicNetwork.graph unit.fragment.carrier.occurrences unit.fragment.carrier.bonds) a b := by
 have rooted : ∀ first rest, unit.fragment.carrier.occurrences=first::rest →
  PathWitness (MetallicNetwork.graph unit.fragment.carrier.occurrences unit.fragment.carrier.bonds) a b := by
  intro first rest shape
  have checked := connected
  rw [shape] at checked
  have paths := MolecularCarrier.connectedPaths first rest unit.fragment.carrier.bonds checked
  have pa := paths a (shape ▸ ha)
  have pb := paths b (shape ▸ hb)
  have joined := composePathWitnesses _ a first b
   (reverseSourcePath _ (fun e h => reversedEdgeHeld _ e h) first a pa) pb
  apply retainedPathWitness (MolecularCarrier.helperGraph unit.fragment.carrier.occurrences unit.fragment.carrier.bonds) (MetallicNetwork.graph unit.fragment.carrier.occurrences unit.fragment.carrier.bonds) (MolecularCarrier.helperNodesKnown _ _ unit.endpoints)
   (fun _ h => h) a b
  rw [shape]
  exact joined
 cases shape : unit.fragment.carrier.occurrences with
 | nil => exact False.elim (unit.positive shape)
 | cons first rest => exact shape ▸ rooted first rest shape

theorem repeatPathsFromConnectedUnit {unit : Functional.Group} (o : Occurrence unit)
 (connected : MolecularCarrier.connected unit.fragment.carrier.occurrences unit.fragment.carrier.bonds=true)
 (x y : String) (hx : x∈(repeatGraph o).nodes) (hy : y∈(repeatGraph o).nodes) :
 PathWitness (repeatGraph o) x y := by
 obtain ⟨a,ha,ea⟩ := memMapPreimage o.embedding.image x unit.fragment.carrier.occurrences hx
 obtain ⟨b,hb,eb⟩ := memMapPreimage o.embedding.image y unit.fragment.carrier.occurrences hy
 have mapped := mappedPathWitness o.embedding.image _ a b (connectedUnitPaths unit connected a b ha hb)
 have same : mappedGraph o.embedding.image
  (MetallicNetwork.graph unit.fragment.carrier.occurrences unit.fragment.carrier.bonds)=repeatGraph o := by
  unfold mappedGraph MetallicNetwork.graph repeatGraph repeatEdges Functional.imageSupport
  rw [mappedSymmetricEdges]
  rfl
 rw [same,ea,eb] at mapped
 exact mapped

theorem allAtomsReachableFromConnectedUnit {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell)
 (connected : MolecularCarrier.connected unit.fragment.carrier.occurrences unit.fragment.carrier.bonds=true)
 (origin : String) (originHeld : origin∈(repeatGraph c.first).nodes) :
 ∀ atom∈(atomicGraph c).nodes, reachable (atomicGraph c) origin atom=true :=
 allAtomsReachableFromFirst c origin originHeld (fun o _ x hx y hy => repeatPathsFromConnectedUnit o connected x y hx hy)


theorem repeatEndpoints {unit : Functional.Group} (o : Occurrence unit)
 (edge : Edge) (held : edge∈(repeatGraph o).edges) :
 edge.1∈(repeatGraph o).nodes ∧ edge.2∈(repeatGraph o).nodes := by
 have direct : ∀ e∈repeatEdges o, e.1∈(repeatGraph o).nodes ∧ e.2∈(repeatGraph o).nodes := by
  intro e h
  obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ h
  cases equal
  have covered := unit.endpoints original member
  exact ⟨memMap _ _ _ covered.1,memMap _ _ _ covered.2⟩
 cases memAppendCases edge (repeatEdges o) ((repeatEdges o).map (fun e : Edge => (e.2,e.1))) held with
 | inl original => exact direct edge original
 | inr reversed =>
  obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ reversed
  cases equal
  exact ⟨(direct original member).2,(direct original member).1⟩

theorem atomicEndpoints {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (edge : Edge) (held : edge∈(atomicGraph c).edges) :
 edge.1∈(atomicGraph c).nodes ∧ edge.2∈(atomicGraph c).nodes := by
 cases memAppendCases edge _ _ held with
 | inl internal =>
  obtain ⟨o,member,inside⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ internal
  have covered := repeatEndpoints o edge inside
  exact ⟨repeatNodeRetained c o member _ covered.1,repeatNodeRetained c o member _ covered.2⟩
 | inr connection =>
  have direct : ∀ e∈c.connections.map (fun bond =>
   (bond.covalent.bond.support.raw.left,bond.covalent.bond.support.raw.right)),
   e.1∈(atomicGraph c).nodes ∧ e.2∈(atomicGraph c).nodes := by
   intro e h
   obtain ⟨bond,member,equal⟩ := memMapPreimage _ _ _ h
   cases equal
   have copiesHeld := c.allCopies bond member
   exact ⟨repeatNodeRetained c bond.left copiesHeld.1 _ bond.leftAtomHeld,
    repeatNodeRetained c bond.right copiesHeld.2 _ bond.rightAtomHeld⟩
  cases memAppendCases edge _ _ connection with
  | inl original => exact direct edge original
  | inr reversed =>
   obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ reversed
   cases equal
   exact ⟨(direct original member).2,(direct original member).1⟩


theorem atomicEdgesSymmetric {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell) (edge : Edge) (held : edge∈(atomicGraph c).edges) :
 (edge.2,edge.1)∈(atomicGraph c).edges := by
 cases memAppendCases edge _ _ held with
 | inl internal =>
  obtain ⟨o,member,inside⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ internal
  exact repeatEdgeRetained c o member _ (reversedEdgeHeld _ edge inside)
 | inr connection => exact memAppendRight _ _ _ (reversedEdgeHeld _ edge connection)

theorem atomicConnected {unit : Functional.Group} {Word Cell : Type}
 (c : Incidence unit Word Cell)
 (connected : MolecularCarrier.connected unit.fragment.carrier.occurrences unit.fragment.carrier.bonds=true)
 (origin : String) (originHeld : origin∈(repeatGraph c.first).nodes) :
 MolecularCarrier.connected (atomicGraph c).nodes (atomicGraph c).edges=true := by
 have reaches := allAtomsReachableFromConnectedUnit c connected origin originHeld
 have paths : ∀ atom∈(atomicGraph c).nodes, PathWitness (atomicGraph c) origin atom :=
  fun atom held => reachableHasPath _ _ _ (atomicEndpoints c) (reaches atom held)
 have nonempty : (atomicGraph c).nodes≠[] := by
  intro empty
  have held := repeatNodeRetained c c.first (.head _) origin originHeld
  rw [empty] at held
  cases held
 have result : ∀ first rest, (atomicGraph c).nodes=first::rest →
  MolecularCarrier.connected (first::rest) (atomicGraph c).edges=true := by
  intro first rest shape
  apply MolecularCarrier.connectedFromPaths
  · intro target member
    have firstHeld : first∈(atomicGraph c).nodes := shape.symm ▸ List.Mem.head rest
    have targetHeld : target∈(atomicGraph c).nodes := shape.symm ▸ member
    have path := composePathWitnesses _ first origin target
     (reverseSourcePath _ (atomicEdgesSymmetric c) origin first (paths first firstHeld))
     (paths target targetHeld)
    apply retainedPathWitness (atomicGraph c) (MolecularCarrier.helperGraph (first::rest) (atomicGraph c).edges)
     (fun n h => memAppendLeft _ _ _ (shape ▸ h))
     (fun e h => memAppendLeft _ _ _ h) first target path
  · intro target path
    apply MolecularCarrier.helperNodesKnown (first::rest) (atomicGraph c).edges
     (fun e h => ⟨shape ▸ (atomicEndpoints c e h).1,shape ▸ (atomicEndpoints c e h).2⟩)
     target (pathWitnessTarget _ _ _ path)
 cases shape : (atomicGraph c).nodes with
 | nil => exact False.elim (nonempty shape)
 | cons first rest => exact result first rest shape

end SFT.Chemistry.PolymerChain
