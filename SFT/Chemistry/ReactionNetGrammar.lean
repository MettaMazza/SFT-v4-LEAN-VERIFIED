import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ReactionNetGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Species where
  | rejected | admitted

def speciesName : Species → String
  | .rejected => "anonymous-state-count"
  | .admitted => "chemical-species-nodes"

inductive Reactions where
  | rejected | admitted

def reactionsName : Reactions → String
  | .rejected => "unlabelled-adjacency"
  | .admitted => "reaction-steps-connect-species"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "isolated-reaction-list"
  | .admitted => "shared-species-compose-paths"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "open-unrecorded-flux"
  | .admitted => "source-product-boundary-held"

inductive Branching where
  | rejected | admitted

def branchingName : Branching → String
  | .rejected => "single-path-only"
  | .admitted => "all-generated-paths-retained"

inductive Cycles where
  | rejected | admitted

def cyclesName : Cycles → String
  | .rejected => "cycle-collapsed"
  | .admitted => "reaction-cycles-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "network-picture-only"
  | .admitted => "complete-node-edge-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-network-topology"
  | .admitted => "no-extra-rule"

structure Candidate where
  species : Species
  reactions : Reactions
  composition : Composition
  boundary : Boundary
  branching : Branching
  cycles : Cycles
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [speciesName c.species, reactionsName c.reactions, compositionName c.composition, boundaryName c.boundary, branchingName c.branching, cyclesName c.cycles, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "species=" (speciesName c.species), SFT.Host.Text.append "reactions=" (reactionsName c.reactions), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "branching=" (branchingName c.branching), SFT.Host.Text.append "cycles=" (cyclesName c.cycles), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "chemical-species-nodes__reaction-steps-connect-species__shared-species-compose-paths__source-product-boundary-held__all-generated-paths-retained__reaction-cycles-retained__complete-node-edge-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (speciesName c.species) "chemical-species-nodes" &&
  SFT.Host.Text.equal (reactionsName c.reactions) "reaction-steps-connect-species" &&
  SFT.Host.Text.equal (compositionName c.composition) "shared-species-compose-paths" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "source-product-boundary-held" &&
  SFT.Host.Text.equal (branchingName c.branching) "all-generated-paths-retained" &&
  SFT.Host.Text.equal (cyclesName c.cycles) "reaction-cycles-retained" &&
  SFT.Host.Text.equal (recordName c.record) "complete-node-edge-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (speciesName c.species) "chemical-species-nodes") then "Chemical identities are lost." else
  if !(SFT.Host.Text.equal (reactionsName c.reactions) "reaction-steps-connect-species") then "Transitions are chemically ambiguous." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "shared-species-compose-paths") then "Shared carriers are not composed." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "source-product-boundary-held") then "The network cannot balance." else
  if !(SFT.Host.Text.equal (branchingName c.branching) "all-generated-paths-retained") then "Network alternatives are erased." else
  if !(SFT.Host.Text.equal (cyclesName c.cycles) "reaction-cycles-retained") then "Recurrence is lost." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-node-edge-trace") then "The network cannot be replayed." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "An imported graph selects the result." else
  "chemical-species-nodes__reaction-steps-connect-species__shared-species-compose-paths__source-product-boundary-held__all-generated-paths-retained"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by carrier preservation, complete support, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite set of retained chemical-species carriers and balanced reaction-step incidences with complete external source/product boundaries."

def candidates : List Candidate :=
  ([Species.rejected,Species.admitted]).flatMap fun species =>
  ([Reactions.rejected,Reactions.admitted]).flatMap fun reactions =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Branching.rejected,Branching.admitted]).flatMap fun branching =>
  ([Cycles.rejected,Cycles.admitted]).flatMap fun cycles =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨species,reactions,composition,boundary,branching,cycles,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk species reactions composition boundary branching cycles record extra =>
    have hspecies : species ∈ [Species.rejected,Species.admitted] := by
      cases species <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreactions : reactions ∈ [Reactions.rejected,Reactions.admitted] := by
      cases reactions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbranching : branching ∈ [Branching.rejected,Branching.admitted] := by
      cases branching <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcycles : cycles ∈ [Cycles.rejected,Cycles.admitted] := by
      cases cycles <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ species _ hspecies
    apply CommonRefinement.memFlatMap _ _ reactions _ hreactions
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ branching _ hbranching
    apply CommonRefinement.memFlatMap _ _ cycles _ hcycles
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extra _ hextra

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk species reactions composition boundary branching cycles record extra =>
    cases species <;> cases reactions <;> cases composition <;> cases boundary <;> cases branching <;> cases cycles <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk species reactions composition boundary branching cycles record extra =>
    cases species <;> cases reactions <;> cases composition <;> cases boundary <;> cases branching <;> cases cycles <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.species = .admitted ∧ c.reactions = .admitted ∧ c.composition = .admitted ∧ c.boundary = .admitted ∧ c.branching = .admitted ∧ c.cycles = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk species reactions composition boundary branching cycles record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem species_rejected_rejected (c : Candidate) (h : c.species = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.species eq
    rw [h] at field
    cases field

theorem reactions_rejected_rejected (c : Candidate) (h : c.reactions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reactions eq
    rw [h] at field
    cases field

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem branching_rejected_rejected (c : Candidate) (h : c.branching = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.branching eq
    rw [h] at field
    cases field

theorem cycles_rejected_rejected (c : Candidate) (h : c.cycles = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.cycles eq
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

end SFT.Chemistry.ReactionNetGrammar
