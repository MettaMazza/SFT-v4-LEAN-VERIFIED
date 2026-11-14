import SFT.Computation.NativeCircuitPaths
import SFT.Foundation.CommonRefinement
namespace SFT.Computation.NativeCircuitGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Gate where
  | rejected | admitted

def gateName : Gate → String
  | .rejected => "rewired-or-multi-depth-gate"
  | .admitted => "unique-lawful-one-depth-edge"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "reported-k-depth"
  | .admitted => "one-distinction-per-dependent-edge"

inductive Width where
  | rejected | admitted

def widthName : Width → String
  | .rejected => "sampled-input-width"
  | .admitted => "all-b-to-k-source-words"

inductive Size where
  | rejected | admitted

def sizeName : Size → String
  | .rejected => "one-implementation-count"
  | .admitted => "every-source-edge-required"

inductive Exhaustion where
  | rejected | admitted

def exhaustionName : Exhaustion → String
  | .rejected => "selected-subsets"
  | .admitted => "complete-forced-edge-subset-census"

inductive Attainment where
  | rejected | admitted

def attainmentName : Attainment → String
  | .rejected => "unattained-bound"
  | .admitted => "registered-circuit-attains-all-bounds"

inductive Successor where
  | rejected | admitted

def successorName : Successor → String
  | .rejected => "finite-table-only"
  | .admitted => "add-next-complete-source-layer"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "arbitrary-gate-basis-export"
  | .admitted => "admitted-fold-circuits-only"

structure Candidate where
  gate : Gate
  path : Path
  width : Width
  size : Size
  exhaustion : Exhaustion
  attainment : Attainment
  successor : Successor
  boundary : Boundary

def sourceFields (c : Candidate) : List String := [gateName c.gate, pathName c.path, widthName c.width, sizeName c.size, exhaustionName c.exhaustion, attainmentName c.attainment, successorName c.successor, boundaryName c.boundary]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "gate=" (gateName c.gate), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "width=" (widthName c.width), SFT.Host.Text.append "size=" (sizeName c.size), SFT.Host.Text.append "exhaustion=" (exhaustionName c.exhaustion), SFT.Host.Text.append "attainment=" (attainmentName c.attainment), SFT.Host.Text.append "successor=" (successorName c.successor), SFT.Host.Text.append "boundary=" (boundaryName c.boundary)]
def survivorId : String := "unique-lawful-one-depth-edge__one-distinction-per-dependent-edge__all-b-to-k-source-words__every-source-edge-required__complete-forced-edge-subset-census__registered-circuit-attains-all-bounds__add-next-complete-source-layer__admitted-fold-circuits-only"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (gateName c.gate) "unique-lawful-one-depth-edge" &&
  SFT.Host.Text.equal (pathName c.path) "one-distinction-per-dependent-edge" &&
  SFT.Host.Text.equal (widthName c.width) "all-b-to-k-source-words" &&
  SFT.Host.Text.equal (sizeName c.size) "every-source-edge-required" &&
  SFT.Host.Text.equal (exhaustionName c.exhaustion) "complete-forced-edge-subset-census" &&
  SFT.Host.Text.equal (attainmentName c.attainment) "registered-circuit-attains-all-bounds" &&
  SFT.Host.Text.equal (successorName c.successor) "add-next-complete-source-layer" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "admitted-fold-circuits-only"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (gateName c.gate) "unique-lawful-one-depth-edge") then "A rewired or multi-depth edge is not a Fold transition." else
  if !(SFT.Host.Text.equal (pathName c.path) "one-distinction-per-dependent-edge") then "A reported implementation depth is not a lower bound." else
  if !(SFT.Host.Text.equal (widthName c.width) "all-b-to-k-source-words") then "Sampled sources omit generated inputs." else
  if !(SFT.Host.Text.equal (sizeName c.size) "every-source-edge-required") then "Counting one circuit does not prove necessity." else
  if !(SFT.Host.Text.equal (exhaustionName c.exhaustion) "complete-forced-edge-subset-census") then "Selected omissions cannot prove arbitrary-circuit necessity." else
  if !(SFT.Host.Text.equal (attainmentName c.attainment) "registered-circuit-attains-all-bounds") then "An unattained value need not be tight." else
  if !(SFT.Host.Text.equal (successorName c.successor) "add-next-complete-source-layer") then "A finite census does not generalize itself." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "admitted-fold-circuits-only") then "An external gate can have different fan-in and semantics." else
  "The unique kernel forces tight path k, width b^k and size sum(r=One..k)b^r lower bounds over every admitted Fold-edge circuit at every supplied positive finite depth."

def generationRule : String := "Generate the literal product of gate, path, width, size, subset exhaustion, attainment, successor and gate-basis-boundary coordinates."
def grammarBoundary : String := "Every circuit whose vertices are generated native Fold words and whose gates are lawful unique depth-r to depth-(r-1) Fold edges."

def candidates : List Candidate :=
  ([Gate.rejected,Gate.admitted]).flatMap fun gate =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Width.rejected,Width.admitted]).flatMap fun width =>
  ([Size.rejected,Size.admitted]).flatMap fun size =>
  ([Exhaustion.rejected,Exhaustion.admitted]).flatMap fun exhaustion =>
  ([Attainment.rejected,Attainment.admitted]).flatMap fun attainment =>
  ([Successor.rejected,Successor.admitted]).flatMap fun successor =>
  ([Boundary.rejected,Boundary.admitted]).map fun boundary =>
  ⟨gate,path,width,size,exhaustion,attainment,successor,boundary⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk gate path width size exhaustion attainment successor boundary =>
    have hgate : gate ∈ [Gate.rejected,Gate.admitted] := by
      cases gate <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hwidth : width ∈ [Width.rejected,Width.admitted] := by
      cases width <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsize : size ∈ [Size.rejected,Size.admitted] := by
      cases size <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hexhaustion : exhaustion ∈ [Exhaustion.rejected,Exhaustion.admitted] := by
      cases exhaustion <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hattainment : attainment ∈ [Attainment.rejected,Attainment.admitted] := by
      cases attainment <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsuccessor : successor ∈ [Successor.rejected,Successor.admitted] := by
      cases successor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ gate _ hgate
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ width _ hwidth
    apply CommonRefinement.memFlatMap _ _ size _ hsize
    apply CommonRefinement.memFlatMap _ _ exhaustion _ hexhaustion
    apply CommonRefinement.memFlatMap _ _ attainment _ hattainment
    apply CommonRefinement.memFlatMap _ _ successor _ hsuccessor
    exact Count.TraceDerivation.memMap _ boundary _ hboundary

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk gate path width size exhaustion attainment successor boundary =>
    cases gate <;> cases path <;> cases width <;> cases size <;> cases exhaustion <;> cases attainment <;> cases successor <;> cases boundary
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk gate path width size exhaustion attainment successor boundary =>
    cases gate <;> cases path <;> cases width <;> cases size <;> cases exhaustion <;> cases attainment <;> cases successor <;> cases boundary
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.gate = .admitted ∧ c.path = .admitted ∧ c.width = .admitted ∧ c.size = .admitted ∧ c.exhaustion = .admitted ∧ c.attainment = .admitted ∧ c.successor = .admitted ∧ c.boundary = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk gate path width size exhaustion attainment successor boundary =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem gate_rejected_rejected (c : Candidate) (h : c.gate = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gate eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
    rw [h] at field
    cases field

theorem width_rejected_rejected (c : Candidate) (h : c.width = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.width eq
    rw [h] at field
    cases field

theorem size_rejected_rejected (c : Candidate) (h : c.size = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.size eq
    rw [h] at field
    cases field

theorem exhaustion_rejected_rejected (c : Candidate) (h : c.exhaustion = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.exhaustion eq
    rw [h] at field
    cases field

theorem attainment_rejected_rejected (c : Candidate) (h : c.attainment = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.attainment eq
    rw [h] at field
    cases field

theorem successor_rejected_rejected (c : Candidate) (h : c.successor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.successor eq
    rw [h] at field
    cases field

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

end SFT.Computation.NativeCircuitGrammar
