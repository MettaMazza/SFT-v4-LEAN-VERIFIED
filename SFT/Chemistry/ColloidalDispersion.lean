import SFT.Chemistry.SurfaceAdsorption
namespace SFT.Chemistry.ColloidalDispersion
open SFT.Foundation.Count.TraceDerivation
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev Raw := SurfaceAdsorption.Raw
abbrev admit := SurfaceAdsorption.admit

structure Context where
 raw : Raw
 accepted : admit raw=.ok raw
 geometry : ChemicalPhase.Boundary
 continuous : ChemicalPhase.Record
 sameGeometry : continuous.boundary=geometry
 continuousIdentity : continuous.raw.identity=raw.secondPhase.label
 dispersedTrace : List HeldLabel
 distinctTrace : dispersedTrace≠geometry.trace continuous.root
 lowerSize : PositiveCount
 upperSize : PositiveCount
 observationInterval : PositiveCount
 conditions : SFT.Host.Canonical.Value
 sourceRecord : SFT.Host.Canonical.Value

structure Particle (context : Context) where
 region : ChemicalPhase.Record
 sameGeometry : region.boundary=context.geometry
 phaseIdentity : region.raw.identity=context.raw.firstPhase.label
 sameTrace : context.geometry.trace region.root=context.dispersedTrace
 interface : ChemicalPhase.Interface context.geometry region.root
 outsideInMedium : ChemicalPhase.InPhase context.geometry context.continuous.root interface.outside
 position : HeldLabel
 size : PositiveCount
 completeSize : region.members.length=size.value
 lowerBound : context.lowerSize.value≤size.value
 upperBound : size.value≤context.upperSize.value
 sourceRecord : SFT.Host.Canonical.Value

theorem everyRegionCellSamePhase {c : Context} (p : Particle c) (cell : String) (held : cell∈p.region.members) :
 c.geometry.trace cell=c.dispersedTrace := by
 have h := ChemicalPhase.completeIntensiveHomogeneity p.region cell held
 unfold ChemicalPhase.intensiveIdentity at h
 rw [p.sameGeometry] at h
 exact h.trans p.sameTrace

theorem dispersedCellOutsideContinuous {c : Context} (p : Particle c) (cell : String) (held : cell∈p.region.members) :
 ¬ChemicalPhase.InPhase c.geometry c.continuous.root cell := by
 apply ChemicalPhase.differentTraceExcluded
 intro same
 exact c.distinctTrace ((everyRegionCellSamePhase p cell held).symm.trans same)

theorem completeInterfaceRetained {c : Context} (p : Particle c) :
 ChemicalPhase.InPhase c.geometry p.region.root p.interface.inside ∧
 ¬ChemicalPhase.InPhase c.geometry p.region.root p.interface.outside :=
 ChemicalPhase.interfaceSeparates _ _ _

theorem interfaceBordersMedium {c : Context} (p : Particle c) :
 ChemicalPhase.InPhase c.geometry c.continuous.root p.interface.outside := p.outsideInMedium

theorem sourceSizeBounds {c : Context} (p : Particle c) :
 c.lowerSize.value≤p.region.members.length ∧ p.region.members.length≤c.upperSize.value := by
 rw [p.completeSize]
 exact ⟨p.lowerBound,p.upperBound⟩

def disjoint {c : Context} (p q : Particle c) : Prop :=
 p.position≠q.position ∧ ∀ cell∈p.region.members, cell∉q.region.members

inductive Separated {c : Context} : List (Particle c) → Prop where
 | empty : Separated []
 | next (p : Particle c) (rest : List (Particle c))
   (apart : ∀ q∈rest, disjoint p q) (tail : Separated rest) : Separated (p::rest)

structure Population where
 context : Context
 first : Particle context
 rest : List (Particle context)
 separated : Separated (first::rest)
 completeCount : context.raw.carriers.value=(first::rest).length

def particles (p : Population) := p.first::p.rest

def distribution {c : Context} (ps : List (Particle c)) := ps.map fun p =>
 (p.region.raw.identity,p.region.members,p.position,p.size,p.interface.inside,p.interface.outside,p.sourceRecord)

theorem completePopulationPositive (p : Population) : 0<(particles p).length := Nat.zero_lt_succ _

theorem allParticleIdentities (p : Population) (q : Particle p.context) (held : q∈particles p) :
 q.region.raw.identity=p.context.raw.firstPhase.label := q.phaseIdentity

theorem everyParticleBounded (p : Population) (q : Particle p.context) (held : q∈particles p) :
 p.context.lowerSize.value≤q.region.members.length ∧ q.region.members.length≤p.context.upperSize.value :=
 sourceSizeBounds q

theorem distributionCount {c : Context} (ps : List (Particle c)) : (distribution ps).length=ps.length :=
 SFT.Foundation.CommonRefinement.mapLength _ _

theorem registeredPopulationCount (p : Population) : (distribution (particles p)).length=p.context.raw.carriers.value :=
 (distributionCount _).trans p.completeCount.symm

theorem singleRegionBase {c : Context} (q : Particle c) : Separated [q] :=
 .next q [] (fun other h => by cases h) .empty

theorem separatedAppend {c : Context} (ps : List (Particle c)) (fresh : Particle c)
 (prior : Separated ps) (apart : ∀ old∈ps, disjoint old fresh) : Separated (ps++[fresh]) := by
 induction prior with
 | empty => exact singleRegionBase fresh
 | next first rest separated tail ih =>
   apply Separated.next
   · intro other member
     cases memAppendCases other rest [fresh] member with
     | inl held => exact separated other held
     | inr held =>
       cases held with
       | head => exact apart first (.head _)
       | tail _ impossible => cases impossible
   · exact ih (fun old held => apart old (.tail _ held))

-- The fixed observation context is retained; the population count is read
-- from the complete occurrence word after extension.
structure Extension (p : Population) where
 fresh : Particle p.context
 apart : ∀ old∈particles p, disjoint old fresh

def extendedParticles {p : Population} (e : Extension p) := particles p++[e.fresh]

theorem extendedSeparated {p : Population} (e : Extension p) : Separated (extendedParticles e) :=
 separatedAppend _ _ p.separated e.apart

theorem priorParticleRetained {p : Population} (e : Extension p) (old : Particle p.context)
 (held : old∈particles p) : old∈extendedParticles e := memAppendLeft _ _ _ held

theorem exactPopulationSuccessor {p : Population} (e : Extension p) :
 (extendedParticles e).length=p.context.raw.carriers.value+1 := by
 change ((p.first::p.rest)++[e.fresh]).length=p.context.raw.carriers.value+1
 rw [SFT.Foundation.CommonRefinement.appendLength,← p.completeCount]
 rfl

theorem completeDistributionSuccessor {p : Population} (e : Extension p) :
 distribution (extendedParticles e)=distribution (particles p)++distribution [e.fresh] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

theorem newRegionHasSamePhase {p : Population} (e : Extension p) :
 e.fresh.region.raw.identity=p.context.raw.firstPhase.label := e.fresh.phaseIdentity

theorem newRegionRemainsBounded {p : Population} (e : Extension p) :
 p.context.lowerSize.value≤e.fresh.region.members.length ∧ e.fresh.region.members.length≤p.context.upperSize.value :=
 sourceSizeBounds _

def sourceTrace (p : Population) :=
 (p.context.raw,p.context.geometry.resolution,p.context.observationInterval,p.context.conditions,
 p.context.continuous.raw,p.context.sourceRecord,distribution (particles p))

def extensionTrace {p : Population} (e : Extension p) :=
 (p.context.geometry.resolution,p.context.observationInterval,p.context.conditions,
 p.context.continuous.raw,distribution (extendedParticles e))
end SFT.Chemistry.ColloidalDispersion
