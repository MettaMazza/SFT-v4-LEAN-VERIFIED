import SFT.Foundation.FoldUniformCheck
import SFT.Foundation.CommonRefinement
namespace SFT.Foundation.FoldDynamicsGrammar
set_option maxRecDepth 20000

inductive Domain where
  | leaking | closed

def domainName : Domain → String
  | .leaking => "domain-leaking"
  | .closed => "domain-closed"

inductive Fibre where
  | notTwo | exactlyTwo

def fibreName : Fibre → String
  | .notTwo => "fibre-not-two"
  | .exactlyTwo => "fibre-exactly-two"

inductive Collision where
  | absent | present

def collisionName : Collision → String
  | .absent => "phase-collision-absent"
  | .present => "phase-collision-present"

inductive Involution where
  | absent | present

def involutionName : Involution → String
  | .absent => "phase-involution-absent"
  | .present => "phase-involution-present"

inductive Uniform where
  | broken | preserved

def uniformName : Uniform → String
  | .broken => "uniform-division-broken"
  | .preserved => "uniform-division-preserved"

inductive Cycle where
  | openCycle | two

def cycleName : Cycle → String
  | .openCycle => "first-cycle-open"
  | .two => "first-cycle-two"

inductive Extra where
  | noExtra | hasExtra

def extraName : Extra → String
  | .noExtra => "no-extra"
  | .hasExtra => "has-extra"

structure Candidate where
  domain : Domain
  fibre : Fibre
  collision : Collision
  involution : Involution
  uniform : Uniform
  cycle : Cycle
  extra : Extra

def sourceFields (c : Candidate) : List String := [domainName c.domain, fibreName c.fibre, collisionName c.collision, involutionName c.involution, uniformName c.uniform, cycleName c.cycle, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)

def exactForm (c : Candidate) : String := SFT.Host.Text.join ["Fold dynamics proposal has ", SFT.Host.Text.intercalate ", " (sourceFields c), "."]

def survivorId : String := "domain-closed__fibre-exactly-two__phase-collision-present__phase-involution-present__uniform-division-preserved__first-cycle-two__no-extra"

def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId

def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "domain-closed" &&
  SFT.Host.Text.equal (fibreName c.fibre) "fibre-exactly-two" &&
  SFT.Host.Text.equal (collisionName c.collision) "phase-collision-present" &&
  SFT.Host.Text.equal (involutionName c.involution) "phase-involution-present" &&
  SFT.Host.Text.equal (uniformName c.uniform) "uniform-division-preserved" &&
  SFT.Host.Text.equal (cycleName c.cycle) "first-cycle-two" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.contains (candidateId c) "domain-leaking" then "An image leaves the exact positive domain." else
  if SFT.Host.Text.contains (candidateId c) "fibre-not-two" then "The inverse relation does not retain both held preimages." else
  if SFT.Host.Text.contains (candidateId c) "phase-collision-absent" then "A half-One phase pair is not identified by Fold." else
  if SFT.Host.Text.contains (candidateId c) "phase-involution-absent" then "Two half-One phase translations fail to return the source." else
  if SFT.Host.Text.contains (candidateId c) "uniform-division-broken" then "An even uniform partition loses uniformity after duplicate images are identified." else
  if SFT.Host.Text.contains (candidateId c) "first-cycle-open" then "The first nonstatic recurrent orbit does not close in two Fold moves." else
  if SFT.Host.Text.contains (candidateId c) "has-extra" then "It adds a dynamical selector not supplied by exact Fold." else
  "Exact Fold is closed, exactly two-to-one, phase-antipodal, uniform-partition preserving and has the first two-cycle."

def generationRule : String := "Generate the complete product of Fold-domain closure, fibre cardinality, half-One phase collision, phase involution, uniform-division image, first recurrent cycle and added-data class."
def grammarBoundary : String := "All dynamical invariants of exact doubling-and-cast on the positive rational circle of the One, with half-One phase translation and generated even uniform partitions."

def candidates : List Candidate :=
  ([Domain.leaking,.closed]).flatMap fun domain =>
  ([Fibre.notTwo,.exactlyTwo]).flatMap fun fibre =>
  ([Collision.absent,.present]).flatMap fun collision =>
  ([Involution.absent,.present]).flatMap fun involution =>
  ([Uniform.broken,.preserved]).flatMap fun uniform =>
  ([Cycle.openCycle,.two]).flatMap fun cycle =>
  ([Extra.noExtra,.hasExtra]).map fun extra =>
  ⟨domain,fibre,collision,involution,uniform,cycle,extra⟩

def survivor : Candidate := ⟨.closed,.exactlyTwo,.present,.present,.preserved,.two,.noExtra⟩

theorem generatedCardinality : candidates.length = 128 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain fibre collision involution uniform cycle extra =>
    have hdomain : domain ∈ [Domain.leaking,.closed] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfibre : fibre ∈ [Fibre.notTwo,.exactlyTwo] := by
      cases fibre <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcollision : collision ∈ [Collision.absent,.present] := by
      cases collision <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinvolution : involution ∈ [Involution.absent,.present] := by
      cases involution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have huniform : uniform ∈ [Uniform.broken,.preserved] := by
      cases uniform <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycle : cycle ∈ [Cycle.openCycle,.two] := by
      cases cycle <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.noExtra,.hasExtra] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ fibre _ hfibre
    apply CommonRefinement.memFlatMap _ _ collision _ hcollision
    apply CommonRefinement.memFlatMap _ _ involution _ hinvolution
    apply CommonRefinement.memFlatMap _ _ uniform _ huniform
    apply CommonRefinement.memFlatMap _ _ cycle _ hcycle
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 10000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain fibre collision involution uniform cycle extra =>
    cases domain <;> cases fibre <;> cases collision <;> cases involution <;> cases uniform <;> cases cycle <;> cases extra
    all_goals rfl

set_option maxHeartbeats 4000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain fibre collision involution uniform cycle extra =>
    cases domain <;> cases fibre <;> cases collision <;> cases involution <;> cases uniform <;> cases cycle <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .closed ∧ c.fibre = .exactlyTwo ∧ c.collision = .present ∧ c.involution = .present ∧ c.uniform = .preserved ∧ c.cycle = .two ∧ c.extra = .noExtra

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain fibre collision involution uniform cycle extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6
      rfl

theorem domainRejected (c : Candidate) (h : c.domain = .leaking) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem fibreRejected (c : Candidate) (h : c.fibre = .notTwo) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibre eq
    rw [h] at field
    cases field

theorem collisionRejected (c : Candidate) (h : c.collision = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.collision eq
    rw [h] at field
    cases field

theorem involutionRejected (c : Candidate) (h : c.involution = .absent) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.involution eq
    rw [h] at field
    cases field

theorem uniformRejected (c : Candidate) (h : c.uniform = .broken) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.uniform eq
    rw [h] at field
    cases field

theorem cycleRejected (c : Candidate) (h : c.cycle = .openCycle) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycle eq
    rw [h] at field
    cases field

theorem extraRejected (c : Candidate) (h : c.extra = .hasExtra) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extra eq
    rw [h] at field
    cases field

end SFT.Foundation.FoldDynamicsGrammar
