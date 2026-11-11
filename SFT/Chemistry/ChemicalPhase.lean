import SFT.Chemistry.ReactionDirection
import SFT.Physics.CollectivePhaseOrder
namespace SFT.Chemistry.ChemicalPhase
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 identity : String
 homogeneousTrace : List HeldLabel
 boundary : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if !SourceText.nonblank r.identity || r.homogeneousTrace.isEmpty ||
 !(SFT.Host.Text.equal r.boundary.family "phase-boundary") then
 .error "phase witness is incomplete" else .ok r

structure Boundary where
 graph : GeneratedGraph
 trace : String → List HeldLabel
 resolution : HeldLabel
 temperature : HeldLabel
 pressure : HeldLabel
 composition : HeldLabel

def homogeneousGraph (b : Boundary) (value : List HeldLabel) : GeneratedGraph :=
 ⟨b.graph.nodes.filter (fun x => decide (b.trace x=value)),
 b.graph.edges.filter (fun e => decide (b.trace e.1=value) && decide (b.trace e.2=value))⟩

def InPhase (b : Boundary) (root cell : String) : Prop :=
 PathWitness (homogeneousGraph b (b.trace root)) root cell

theorem homogeneousMember (b : Boundary) (root cell : String) (h : InPhase b root cell) :
 cell∈b.graph.nodes ∧ b.trace cell=b.trace root := by
 have member := pathWitnessTarget _ _ _ h
 have parts := (filterMemberIff _ _ _).mp member
 exact ⟨parts.1,of_decide_eq_true parts.2⟩

theorem base (b : Boundary) (root : String) (held : root∈b.graph.nodes) : InPhase b root root := by
 apply identityPathWitness
 exact (filterMemberIff _ _ _).mpr ⟨held,decide_eq_true rfl⟩

theorem liftHomogeneousPath (b : Boundary) (root cell : String) (priorNodes : List String)
 (valid : pathIsValid b.graph (priorNodes++[cell])=true)
 (starts : (priorNodes++[cell]).head?=some root)
 (homogeneous : ∀ x∈priorNodes++[cell], b.trace x=b.trace root) : InPhase b root cell := by
 refine ⟨priorNodes,?_,starts⟩
 have original := (pathMeaning _ _).mp valid
 apply (pathMeaning _ _).mpr
 refine ⟨original.1,?_,?_⟩
 · intro x hx
   exact (filterMemberIff _ _ _).mpr ⟨original.2.1 x hx,decide_eq_true (homogeneous x hx)⟩
 · intro e he
   apply (filterMemberIff _ _ _).mpr
   refine ⟨original.2.2 e he,?_⟩
   have ends : ∀ (xs : List String) (edge : Edge), edge∈adjacentPairs xs → edge.1∈xs ∧ edge.2∈xs := by
    intro xs
    induction xs with
    | nil => intro edge h; cases h
    | cons a rest ih =>
      intro edge h
      cases rest with
      | nil => cases h
      | cons c tail =>
        cases h with
        | head => exact ⟨.head _,.tail _ (.head _)⟩
        | tail _ h => have p := ih edge h; exact ⟨.tail _ p.1,.tail _ p.2⟩
   have endpoints := ends _ e he
   rw [decide_eq_true (homogeneous e.1 endpoints.1),decide_eq_true (homogeneous e.2 endpoints.2)]
   rfl

-- Every homogeneous connected region containing the root is contained in
-- this component. No omitted reachable equal-trace cell may be excluded.
theorem maximalHomogeneousComponent (b : Boundary) (root : String) (region : List String)
 (homogeneous : ∀ x∈region, b.trace x=b.trace root)
 (connected : ∀ x∈region, ∃ priorNodes, pathIsValid b.graph (priorNodes++[x])=true ∧
   (priorNodes++[x]).head?=some root ∧ ∀ n∈priorNodes++[x], n∈region) :
 ∀ x∈region, InPhase b root x := by
 intro x hx
 obtain ⟨priorNodes,valid,starts,inside⟩ := connected x hx
 exact liftHomogeneousPath b root x priorNodes valid starts (fun n hn => homogeneous n (inside n hn))

theorem adjacentEquivalentJoins (b : Boundary) (root anchor cell : String)
 (prior : InPhase b root anchor) (edge : (anchor,cell)∈b.graph.edges)
 (held : cell∈b.graph.nodes) (same : b.trace cell=b.trace root) : InPhase b root cell := by
 apply extendPathWitness _ _ _ _ prior
 · apply (filterMemberIff _ _ _).mpr
   refine ⟨edge,?_⟩
   rw [decide_eq_true (homogeneousMember b root anchor prior).2,decide_eq_true same]
   rfl
 · exact (filterMemberIff _ _ _).mpr ⟨held,decide_eq_true same⟩

theorem differentTraceExcluded (b : Boundary) (root cell : String)
 (different : b.trace cell≠b.trace root) : ¬ InPhase b root cell :=
 fun h => different (homogeneousMember b root cell h).2

structure Interface (b : Boundary) (root : String) where
 inside : String
 outside : String
 heldInside : InPhase b root inside
 heldOutside : outside∈b.graph.nodes
 adjacent : (inside,outside)∈b.graph.edges
 different : b.trace outside≠b.trace root

theorem interfaceSeparates (b : Boundary) (root : String) (i : Interface b root) :
 InPhase b root i.inside ∧ ¬InPhase b root i.outside :=
 ⟨i.heldInside,differentTraceExcluded _ _ _ i.different⟩

def appendCell (b : Boundary) (fresh anchor : String) (value : List HeldLabel) : Boundary :=
 { b with graph := ⟨b.graph.nodes++[fresh],b.graph.edges++[(anchor,fresh),(fresh,anchor)]⟩,
          trace := fun x => if x=fresh then value else b.trace x }

theorem oldTraceRetained (b : Boundary) (fresh anchor x : String) (value : List HeldLabel)
 (new : ¬fresh∈b.graph.nodes) (held : x∈b.graph.nodes) :
 (appendCell b fresh anchor value).trace x=b.trace x := by
 change (if x=fresh then value else b.trace x)=_
 split
 · rename_i h; exact False.elim (new (h ▸ held))
 · rfl

theorem oldComponentRetained (b : Boundary) (root cell fresh anchor : String) (value : List HeldLabel)
 (new : ¬fresh∈b.graph.nodes) (rootHeld : root∈b.graph.nodes) (prior : InPhase b root cell) :
 InPhase (appendCell b fresh anchor value) root cell := by
 obtain ⟨priorNodes,valid,starts⟩ := prior
 have old := (pathMeaning _ _).mp valid
 apply liftHomogeneousPath _ _ _ priorNodes ?_ starts ?_
 · apply (pathMeaning _ _).mpr
   refine ⟨old.1,?_,?_⟩
   · intro x hx
     exact memAppendLeft _ _ _ ((filterMemberIff _ _ _).mp (old.2.1 x hx)).1
   · intro e he
     exact memAppendLeft _ _ _ ((filterMemberIff _ _ _).mp (old.2.2 e he)).1
 · intro x hx
   have member := (filterMemberIff _ _ _).mp (old.2.1 x hx)
   rw [oldTraceRetained b fresh anchor x value new member.1,oldTraceRetained b fresh anchor root value new rootHeld]
   exact of_decide_eq_true member.2

theorem equivalentSuccessor (b : Boundary) (root fresh anchor : String)
 (new : ¬fresh∈b.graph.nodes) (rootHeld : root∈b.graph.nodes) (heldAnchor : InPhase b root anchor) :
 InPhase (appendCell b fresh anchor (b.trace root)) root fresh := by
 apply adjacentEquivalentJoins _ _ anchor
 · exact oldComponentRetained _ _ _ _ _ _ new rootHeld heldAnchor
 · exact memAppendRight _ _ _ (.head _)
 · exact memAppendRight _ _ _ (.head _)
 · change (if fresh=fresh then b.trace root else b.trace fresh)=_
   rw [ite_eq_left rfl,oldTraceRetained _ _ _ _ _ new rootHeld]

theorem distinctSuccessor (b : Boundary) (root fresh anchor : String) (value : List HeldLabel)
 (new : ¬fresh∈b.graph.nodes) (rootHeld : root∈b.graph.nodes)
 (different : value≠b.trace root) : ¬InPhase (appendCell b fresh anchor value) root fresh := by
 apply differentTraceExcluded
 change (if fresh=fresh then value else b.trace fresh)≠_
 rw [ite_eq_left rfl,oldTraceRetained _ _ _ _ _ new rootHeld]
 exact different

structure Record where
 raw : Raw
 accepted : admit raw=.ok raw
 boundary : Boundary
 root : String
 rootHeld : root∈boundary.graph.nodes
 members : List String
 complete : ∀ cell, cell∈members ↔ InPhase boundary root cell
 labels : String → HeldLabel
 completeTrace : members.map labels=raw.homogeneousTrace

def intensiveIdentity (r : Record) := r.boundary.trace r.root

theorem completeIntensiveHomogeneity (r : Record) (cell : String) (held : cell∈r.members) :
 r.boundary.trace cell=intensiveIdentity r := (homogeneousMember _ _ _ ((r.complete cell).mp held)).2

theorem extentIndependent (r : Record) (copies : List String)
 (retained : ∀ x∈copies, r.boundary.trace x=intensiveIdentity r) :
 ∀ x∈r.members++copies, r.boundary.trace x=intensiveIdentity r := by
 intro x hx
 cases memAppendCases x r.members copies hx with
 | inl old => exact completeIntensiveHomogeneity r x old
 | inr copied => exact retained x copied

def phaseView (r : Record) := (r.raw.identity,r.members)
def conditions (r : Record) := (r.boundary.resolution,r.boundary.temperature,r.boundary.pressure,r.boundary.composition)

structure Coexistence {Part Support State ClockState Clock : Type}
 (reference : SFT.Physics.ThermoTemperature.Transition Part Support State ClockState Clock) where
 leftBefore : Record
 rightBefore : Record
 leftAfter : Record
 rightAfter : Record
 exchange : SFT.Physics.ThermoEquilibriumExchange.Exchange reference String HeldLabel
 recurring : SFT.Physics.ThermoPhaseEquilibrium.coexists exchange
 leftSource : phaseView leftBefore=SFT.Physics.ThermoEquilibrium.classView exchange.before.left.after
 rightSource : phaseView rightBefore=SFT.Physics.ThermoEquilibrium.classView exchange.before.right.after
 leftResult : phaseView leftAfter=SFT.Physics.ThermoEquilibrium.classView exchange.after.left.after
 rightResult : phaseView rightAfter=SFT.Physics.ThermoEquilibrium.classView exchange.after.right.after
 interface : Interface leftBefore.boundary leftBefore.root
 rightAtInterface : interface.outside=rightBefore.root
 sameBoundary : rightBefore.boundary=leftBefore.boundary
 transferSource : exchange.transfer.source=leftBefore.raw.identity
 transferDestination : exchange.transfer.destination=rightBefore.raw.identity
 fixedLeft : conditions leftBefore=conditions leftAfter
 fixedRight : conditions rightBefore=conditions rightAfter
 commonConditions : conditions leftBefore=conditions rightBefore

variable {Part Support State ClockState Clock : Type}
variable {reference : SFT.Physics.ThermoTemperature.Transition Part Support State ClockState Clock}

theorem coexistenceRetainsBothPhases (c : Coexistence reference) :
 phaseView c.leftBefore=phaseView c.leftAfter ∧ phaseView c.rightBefore=phaseView c.rightAfter := by
 have h := (SFT.Physics.ThermoEquilibriumExchange.sourceCriterion c.exchange).mp c.recurring.2
 exact ⟨c.leftSource.trans (h.1.trans c.leftResult.symm),c.rightSource.trans (h.2.1.trans c.rightResult.symm)⟩

theorem coexistenceRemainsDistinct (c : Coexistence reference) : phaseView c.leftAfter≠phaseView c.rightAfter := by
 intro same
 have different := SFT.Physics.ThermoPhaseEquilibrium.distinctFibresPersist c.exchange c.recurring
 exact different (c.leftResult.symm.trans (same.trans c.rightResult))

theorem coexistenceBoundaryConserved (c : Coexistence reference) :
 SFT.Physics.MechanicalConservation.outgoingSupport (SFT.Physics.ThermoEquilibriumExchange.records c.exchange)=
 SFT.Physics.MechanicalConservation.incomingSupport (SFT.Physics.ThermoEquilibriumExchange.records c.exchange) :=
 SFT.Physics.ThermoPhaseEquilibrium.completeBoundaryBalance c.exchange

theorem coexistenceFixedCoordinates (c : Coexistence reference) :
 conditions c.leftAfter=conditions c.rightAfter :=
 c.fixedLeft.symm.trans (c.commonConditions.trans c.fixedRight)

theorem coexistenceRetainsInterface (c : Coexistence reference) :
 ¬ InPhase c.leftBefore.boundary c.leftBefore.root c.rightBefore.root := by
 rw [← c.rightAtInterface]
 exact (interfaceSeparates _ _ c.interface).2

def originalRaw : Raw := ⟨"phase-a",[⟨"intensive-trace","cell-one",rfl,rfl⟩,
 ⟨"intensive-trace","cell-two",rfl,rfl⟩],⟨"phase-boundary","a-b",rfl,rfl⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
end SFT.Chemistry.ChemicalPhase
