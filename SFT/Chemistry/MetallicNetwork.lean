import SFT.Mathematics.GraphInduction
import SFT.Chemistry.BondClosure
namespace SFT.Chemistry.MetallicNetwork
open SFT.Mathematics.GraphOperations SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

-- The original helper permits repeated adjacency rows and blank-but-distinct
-- identities. Its guards are preserved separately from graph reachability.
def admissible (identities : List String) (adjacency : List Edge) : Bool :=
 !identities.isEmpty && distinct identities && !adjacency.isEmpty &&
 adjacency.all (fun edge => has identities edge.1 && has identities edge.2 && decide (edge.1 ≠ edge.2))

def symmetricEdges (adjacency : List Edge) : List Edge := adjacency ++ adjacency.map (fun edge => (edge.2,edge.1))
def graph (identities : List String) (adjacency : List Edge) : GeneratedGraph :=
 ⟨identities,symmetricEdges adjacency⟩

def connectedCollectiveSupport (identities : List String) (adjacency : List Edge) : Bool :=
 if admissible identities adjacency then
  match identities with
  | [] => false
  | first::rest => (first::rest).all (reachable (graph identities adjacency) first)
 else false

theorem emptyIdentitiesRejected (adjacency : List Edge) : connectedCollectiveSupport [] adjacency=false := by
 unfold connectedCollectiveSupport
 split <;> rfl

theorem sourceEdgesRetained (identities : List String) (adjacency : List Edge) (edge : Edge)
 (member : edge ∈ adjacency) : edge ∈ (graph identities adjacency).edges := memAppendLeft _ _ _ member

theorem reverseEdgesRetained (identities : List String) (adjacency : List Edge) (edge : Edge)
 (member : edge ∈ adjacency) : (edge.2,edge.1) ∈ (graph identities adjacency).edges :=
 memAppendRight _ _ _ (memMap (fun edge : Edge => (edge.2,edge.1)) edge adjacency member)

theorem sourceEndpointCoverage (identities : List String) (adjacency : List Edge)
 (valid : admissible identities adjacency=true) (edge : Edge) (member : edge ∈ adjacency) :
 edge.1 ∈ identities ∧ edge.2 ∈ identities := by
 have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp valid
 have check := SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ both.2 edge member
 have pair := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp check
 have endpoints := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp pair.1
 exact ⟨(hasIff _ _).mp endpoints.1,(hasIff _ _).mp endpoints.2⟩

theorem symmetricEndpointCoverage (identities : List String) (adjacency : List Edge)
 (valid : admissible identities adjacency=true) (edge : Edge) (member : edge ∈ (graph identities adjacency).edges) :
 edge.1 ∈ identities ∧ edge.2 ∈ identities := by
 cases memAppendCases edge adjacency (adjacency.map (fun e : Edge => (e.2,e.1))) member with
 | inl original => exact sourceEndpointCoverage identities adjacency valid edge original
 | inr reverse =>
   obtain ⟨original,held,equal⟩ := memMapPreimage (fun e : Edge => (e.2,e.1)) edge adjacency reverse
   have covered := sourceEndpointCoverage identities adjacency valid original held
   cases equal
   exact ⟨covered.2,covered.1⟩

theorem connectedExactlyPaths (first : String) (rest : List String) (adjacency : List Edge)
 (valid : admissible (first::rest) adjacency=true) :
 connectedCollectiveSupport (first::rest) adjacency=true ↔
 ∀ target ∈ first::rest, PathWitness (graph (first::rest) adjacency) first target := by
 unfold connectedCollectiveSupport
 rw [valid]
 constructor
 · intro all target held
   exact reachableHasPath _ _ _ (symmetricEndpointCoverage _ _ valid)
    (SFT.Mathematics.AlgebraOperations.allTrueAtMember _ _ all target held)
 · intro paths
   exact (SFT.Mathematics.DiscreteObjects.allTrueIffMembers _ _).mpr
    (fun target held => pathWitnessReachable _ _ _ (paths target held))

theorem reachedClosureCovers (first : String) (rest : List String) (adjacency : List Edge)
 (valid : admissible (first::rest) adjacency=true)
 (connected : connectedCollectiveSupport (first::rest) adjacency=true)
 (reached : List String) (initial : first ∈ reached)
 (closed : ∀ left right, left ∈ reached → (left,right) ∈ (graph (first::rest) adjacency).edges → right ∈ reached) :
 ∀ target ∈ first::rest, target ∈ reached := by
 intro target held
 exact pathWitnessInClosedSet _ _ _ reached closed initial
  ((connectedExactlyPaths first rest adjacency valid).mp connected target held)

-- The two tests inside each original adjacency sweep add only an endpoint
-- adjoining an already reached endpoint. This records exactly those additions.
inductive ReachedBySweeps (network : GeneratedGraph) (origin : String) : List String → Prop where
 | initial (member : origin ∈ network.nodes) : ReachedBySweeps network origin [origin]
 | add (reached : List String) (prior next : String)
   (history : ReachedBySweeps network origin reached)
   (held : prior ∈ reached) (edge : (prior,next) ∈ network.edges)
   (node : next ∈ network.nodes) (fresh : ¬ next ∈ reached) :
   ReachedBySweeps network origin (next::reached)

theorem sweepAdditionsHavePaths (network : GeneratedGraph) (origin : String) (reached : List String)
 (history : ReachedBySweeps network origin reached) :
 ∀ target ∈ reached, PathWitness network origin target := by
 induction history with
 | initial member =>
   intro target held
   cases held with
   | head => exact identityPathWitness _ _ member
   | tail _ impossible => cases impossible
 | add reached prior next history held edge node fresh ih =>
   intro target member
   cases member with
   | head => exact extendPathWitness _ _ _ _ (ih prior held) edge node
   | tail _ old => exact ih target old

theorem sourceFixedPointEquivalent (first : String) (rest : List String) (adjacency : List Edge)
 (valid : admissible (first::rest) adjacency=true) (reached : List String)
 (history : ReachedBySweeps (graph (first::rest) adjacency) first reached)
 (initial : first ∈ reached)
 (closed : ∀ left right, left ∈ reached → (left,right) ∈ (graph (first::rest) adjacency).edges → right ∈ reached) :
 connectedCollectiveSupport (first::rest) adjacency=true ↔
 ∀ target ∈ first::rest, target ∈ reached := by
 constructor
 · intro connected; exact reachedClosureCovers _ _ _ valid connected reached initial closed
 · intro covers
   apply (connectedExactlyPaths _ _ _ valid).mpr
   intro target member
   exact sweepAdditionsHavePaths _ _ _ history target (covers target member)

theorem symmetricEdgesMonotone (before after : List Edge)
 (retained : ∀ edge ∈ before, edge ∈ after) :
 ∀ edge ∈ symmetricEdges before, edge ∈ symmetricEdges after := by
 intro edge member
 cases memAppendCases edge before (before.map (fun e : Edge => (e.2,e.1))) member with
 | inl direct => exact memAppendLeft _ _ _ (retained edge direct)
 | inr reversed =>
   obtain ⟨original,held,equal⟩ := memMapPreimage (fun e : Edge => (e.2,e.1)) edge before reversed
   cases equal
   exact memAppendRight _ _ _ (memMap (fun e : Edge => (e.2,e.1)) original after (retained original held))

theorem adjacentCellPreservesConnectedness (first : String) (rest : List String)
 (adjacency : List Edge) (anchor fresh : String)
 (oldValid : admissible (first::rest) adjacency=true)
 (oldConnected : connectedCollectiveSupport (first::rest) adjacency=true)
 (anchorHeld : anchor ∈ first::rest)
 (newValid : admissible (first::rest++[fresh]) (adjacency++[(anchor,fresh)])=true) :
 connectedCollectiveSupport (first::rest++[fresh]) (adjacency++[(anchor,fresh)])=true := by
 have keepNodes : ∀ node ∈ first::rest, node ∈ first::rest++[fresh] :=
  fun node held => memAppendLeft _ _ _ held
 have keepEdges := symmetricEdgesMonotone adjacency (adjacency++[(anchor,fresh)])
  (fun edge held => memAppendLeft _ _ _ held)
 have oldPaths := (connectedExactlyPaths _ _ _ oldValid).mp oldConnected
 have newPaths : ∀ target ∈ first::rest,
   PathWitness (graph (first::rest++[fresh]) (adjacency++[(anchor,fresh)])) first target :=
  fun target held => retainedPathWitness _ _ keepNodes keepEdges _ _ (oldPaths target held)
 apply (connectedExactlyPaths _ _ _ newValid).mpr
 intro target member
 cases memAppendCases target (first::rest) [fresh] member with
 | inl old => exact newPaths target old
 | inr added =>
   cases added with
   | head =>
     exact extendPathWitness _ _ _ _ (newPaths anchor anchorHeld)
      (sourceEdgesRetained _ _ _ (memAppendRight _ _ _ (.head [])))
      (show fresh ∈ (first::rest)++[fresh] from memAppendRight fresh (first::rest) [fresh] (.head []))
   | tail _ impossible => cases impossible

theorem originalThreeCellWitness : connectedCollectiveSupport ["A","B","C"] [("A","B"),("B","C")]=true := by
 apply (connectedExactlyPaths "A" ["B","C"] [("A","B"),("B","C")] (by decide)).mpr
 intro target held
 cases held with
 | head => exact ⟨[],by decide,rfl⟩
 | tail _ rest =>
   cases rest with
   | head => exact ⟨["A"],by decide,rfl⟩
   | tail _ last =>
     cases last with
     | head => exact ⟨["A","B"],by decide,rfl⟩
     | tail _ impossible => cases impossible

theorem originalDisconnectedControl : connectedCollectiveSupport ["A","B","C"] [("A","B")]=false := by
 cases result : connectedCollectiveSupport ["A","B","C"] [("A","B")] with
 | false => rfl
 | true =>
   have covers := reachedClosureCovers "A" ["B","C"] [("A","B")] (by decide) result
    ["A","B"] (.head _) (by
      intro left right seen edge
      change (left,right) ∈ [("A","B"),("B","A")] at edge
      cases edge with
      | head => exact .tail _ (.head [])
      | tail _ other =>
        cases other with
        | head => exact .head _
        | tail _ impossible => cases impossible)
   have impossible := covers "C" (.tail _ (.tail _ (.head [])))
   have check := (hasIff ["A","B"] "C").mpr impossible
   have absent : has ["A","B"] "C" = false := rfl
   rw [absent] at check
   cases check

structure Network where
 first : String
 rest : List String
 adjacency : List Edge
 valid : admissible (first::rest) adjacency=true
 connected : connectedCollectiveSupport (first::rest) adjacency=true

def identities (network : Network) := network.first::network.rest

structure ElectronPath (network : Network) where
 label : String
 labelHeld : SFT.Chemistry.SourceText.nonblank label=true
 nodes : List String
 valid : pathIsValid (graph (identities network) network.adjacency) nodes=true
 actions : List String

structure Collective where
 network : Network
 channels : List (ElectronPath network)
 completeSupport : ∀ node ∈ identities network, ∃ channel, channel ∈ channels ∧ node ∈ channel.nodes
 recurrence : BondClosure.Recurrence
 completeActions : (channels.flatMap ElectronPath.actions) = recurrence.steps
 wholeIdentity : SFT.Chemistry.EntityIdentity.Entity
 observationBoundary : SFT.Host.Canonical.Value

-- Every generated atomic cell is retained and reached by the shared support.
theorem everyAtomicCellCovered (record : Collective) (node : String) (held : node ∈ identities record.network) :
 ∃ channel, channel ∈ record.channels ∧ node ∈ channel.nodes := record.completeSupport node held

theorem channelNodesWithinNetwork (record : Collective) (channel : ElectronPath record.network)
 (node : String) (held : node ∈ channel.nodes) : node ∈ identities record.network :=
 (pathMeaning _ _).mp channel.valid |>.2.1 node held

theorem collectiveSourceRecurs (record : Collective) :
 SFT.QuantumComputation.ReversibleModel.phaseAction record.recurrence.prepared.state
 (record.channels.flatMap ElectronPath.actions) = .ok record.recurrence.prepared.state := by
 rw [record.completeActions]
 exact BondClosure.jointReturn record.recurrence

theorem completeAtomicConnectivity (record : Collective) (node : String)
 (held : node ∈ identities record.network) :
 PathWitness (graph (identities record.network) record.network.adjacency) record.network.first node :=
 (connectedExactlyPaths _ _ _ record.network.valid).mp record.network.connected node held

end SFT.Chemistry.MetallicNetwork


