import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ColloidGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Phases where
  | rejected | admitted

def phasesName : Phases → String
  | .rejected => "single-uniform-phase"
  | .admitted => "dispersed-and-continuous-phases"

inductive Extent where
  | rejected | admitted

def extentName : Extent → String
  | .rejected => "molecular-solution-only"
  | .admitted => "finite-dispersed-particles"

inductive Interface where
  | rejected | admitted

def interfaceName : Interface → String
  | .rejected => "phase-boundary-erased"
  | .admitted => "phase-interface-retained"

inductive Distribution where
  | rejected | admitted

def distributionName : Distribution → String
  | .rejected => "one-settled-region"
  | .admitted => "particles-distributed-through-medium"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "size-free-label"
  | .admitted => "particle-size-source-bounded"

inductive Stability where
  | rejected | admitted

def stabilityName : Stability → String
  | .rejected => "eternal-stability-assumed"
  | .admitted => "dispersion-condition-bounded"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "colloid-name-only"
  | .admitted => "particle-interface-distribution-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-dispersion-fit"
  | .admitted => "no-extra-rule"

structure Candidate where
  phases : Phases
  extent : Extent
  interface : Interface
  distribution : Distribution
  scale : Scale
  stability : Stability
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [phasesName c.phases, extentName c.extent, interfaceName c.interface, distributionName c.distribution, scaleName c.scale, stabilityName c.stability, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "phases=" (phasesName c.phases), SFT.Host.Text.append "extent=" (extentName c.extent), SFT.Host.Text.append "interface=" (interfaceName c.interface), SFT.Host.Text.append "distribution=" (distributionName c.distribution), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "stability=" (stabilityName c.stability), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "dispersed-and-continuous-phases__finite-dispersed-particles__phase-interface-retained__particles-distributed-through-medium__particle-size-source-bounded__dispersion-condition-bounded__particle-interface-distribution-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (phasesName c.phases) "dispersed-and-continuous-phases" &&
  SFT.Host.Text.equal (extentName c.extent) "finite-dispersed-particles" &&
  SFT.Host.Text.equal (interfaceName c.interface) "phase-interface-retained" &&
  SFT.Host.Text.equal (distributionName c.distribution) "particles-distributed-through-medium" &&
  SFT.Host.Text.equal (scaleName c.scale) "particle-size-source-bounded" &&
  SFT.Host.Text.equal (stabilityName c.stability) "dispersion-condition-bounded" &&
  SFT.Host.Text.equal (recordName c.record) "particle-interface-distribution-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (phasesName c.phases) "dispersed-and-continuous-phases") then "No dispersion exists." else
  if !(SFT.Host.Text.equal (extentName c.extent) "finite-dispersed-particles") then "No mesoscopic carrier is retained." else
  if !(SFT.Host.Text.equal (interfaceName c.interface) "phase-interface-retained") then "Particle identity is lost." else
  if !(SFT.Host.Text.equal (distributionName c.distribution) "particles-distributed-through-medium") then "Dispersion is absent." else
  if !(SFT.Host.Text.equal (scaleName c.scale) "particle-size-source-bounded") then "Colloid identity is unbounded." else
  if !(SFT.Host.Text.equal (stabilityName c.stability) "dispersion-condition-bounded") then "Persistence is condition-dependent." else
  if !(SFT.Host.Text.equal (recordName c.record) "particle-interface-distribution-trace") then "Phase support cannot be checked." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A fit can force stability." else
  "dispersed-and-continuous-phases__finite-dispersed-particles__phase-interface-retained__particles-distributed-through-medium__particle-size-source-bounded"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite population of separated same-phase regions within a distinct continuous phase, with complete interfaces, sizes, positions, conditions and observation interval."

def candidates : List Candidate :=
  ([Phases.rejected,Phases.admitted]).flatMap fun phases =>
  ([Extent.rejected,Extent.admitted]).flatMap fun extent =>
  ([Interface.rejected,Interface.admitted]).flatMap fun interface =>
  ([Distribution.rejected,Distribution.admitted]).flatMap fun distribution =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Stability.rejected,Stability.admitted]).flatMap fun stability =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨phases,extent,interface,distribution,scale,stability,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk phases extent interface distribution scale stability record extra =>
    have hphases : phases ∈ [Phases.rejected,Phases.admitted] := by
      cases phases <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextent : extent ∈ [Extent.rejected,Extent.admitted] := by
      cases extent <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinterface : interface ∈ [Interface.rejected,Interface.admitted] := by
      cases interface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistribution : distribution ∈ [Distribution.rejected,Distribution.admitted] := by
      cases distribution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstability : stability ∈ [Stability.rejected,Stability.admitted] := by
      cases stability <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ phases _ hphases
    apply CommonRefinement.memFlatMap _ _ extent _ hextent
    apply CommonRefinement.memFlatMap _ _ interface _ hinterface
    apply CommonRefinement.memFlatMap _ _ distribution _ hdistribution
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ stability _ hstability
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk phases extent interface distribution scale stability record extra =>
    cases phases <;> cases extent <;> cases interface <;> cases distribution <;> cases scale <;> cases stability <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk phases extent interface distribution scale stability record extra =>
    cases phases <;> cases extent <;> cases interface <;> cases distribution <;> cases scale <;> cases stability <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.phases = .admitted ∧ c.extent = .admitted ∧ c.interface = .admitted ∧ c.distribution = .admitted ∧ c.scale = .admitted ∧ c.stability = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk phases extent interface distribution scale stability record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem phases_rejected_rejected (c : Candidate) (h : c.phases = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phases eq
    rw [h] at field
    cases field

theorem extent_rejected_rejected (c : Candidate) (h : c.extent = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extent eq
    rw [h] at field
    cases field

theorem interface_rejected_rejected (c : Candidate) (h : c.interface = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.interface eq
    rw [h] at field
    cases field

theorem distribution_rejected_rejected (c : Candidate) (h : c.distribution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distribution eq
    rw [h] at field
    cases field

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem stability_rejected_rejected (c : Candidate) (h : c.stability = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.stability eq
    rw [h] at field
    cases field

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem extra_rejected_rejected (c : Candidate) (h : c.extra = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Chemistry.ColloidGrammar
