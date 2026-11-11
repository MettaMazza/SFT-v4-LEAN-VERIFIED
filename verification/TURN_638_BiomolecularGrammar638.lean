import «work».BiomolecularCarrier638
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.BiomolecularGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "biological-function-without-molecule"
  | .admitted => "chemical-molecular-identity-retained"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "composition-erased-at-handoff"
  | .admitted => "composition-preserved"

inductive Structure where
  | rejected | admitted

def structureName : Structure → String
  | .rejected => "structure-erased-at-handoff"
  | .admitted => "molecular-structure-preserved"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "timeless-molecule"
  | .admitted => "chemical-state-boundary-held"

inductive Function where
  | rejected | admitted

def functionName : Function → String
  | .rejected => "function-as-chemical-identity"
  | .admitted => "biological-function-separately-held"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "biology-imported-into-chemistry"
  | .admitted => "chemistry-to-biology-handoff"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "biomolecule-name-only"
  | .admitted => "composition-structure-state-function-trace"

inductive Extra where
  | rejected | admitted

def extraName : Extra → String
  | .rejected => "free-life-criterion"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  composition : Composition
  structure : Structure
  state : State
  function : Function
  boundary : Boundary
  record : Record
  extra : Extra

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, compositionName c.composition, structureName c.structure, stateName c.state, functionName c.function, boundaryName c.boundary, recordName c.record, extraName c.extra]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "structure=" (structureName c.structure), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "function=" (functionName c.function), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extra=" (extraName c.extra)]
def survivorId : String := "chemical-molecular-identity-retained__composition-preserved__molecular-structure-preserved__chemical-state-boundary-held__biological-function-separately-held__chemistry-to-biology-handoff__composition-structure-state-function-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "chemical-molecular-identity-retained" &&
  SFT.Host.Text.equal (compositionName c.composition) "composition-preserved" &&
  SFT.Host.Text.equal (structureName c.structure) "molecular-structure-preserved" &&
  SFT.Host.Text.equal (stateName c.state) "chemical-state-boundary-held" &&
  SFT.Host.Text.equal (functionName c.function) "biological-function-separately-held" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "chemistry-to-biology-handoff" &&
  SFT.Host.Text.equal (recordName c.record) "composition-structure-state-function-trace" &&
  SFT.Host.Text.equal (extraName c.extra) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "chemical-molecular-identity-retained") then "Chemistry requires a molecular carrier." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "composition-preserved") then "The object cannot be traced chemically." else
  if !(SFT.Host.Text.equal (structureName c.structure) "molecular-structure-preserved") then "Biological recognition loses its substrate." else
  if !(SFT.Host.Text.equal (stateName c.state) "chemical-state-boundary-held") then "Function acts on physical chemical states." else
  if !(SFT.Host.Text.equal (functionName c.function) "biological-function-separately-held") then "Different functions need not change chemical identity." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "chemistry-to-biology-handoff") then "A downstream law cannot select chemistry." else
  if !(SFT.Host.Text.equal (recordName c.record) "composition-structure-state-function-trace") then "The handoff cannot be audited." else
  if !(SFT.Host.Text.equal (extraName c.extra) "no-extra-rule") then "A life label can select any molecule." else
  "chemical-molecular-identity-retained__composition-preserved__molecular-structure-preserved__chemical-state-boundary-held__biological-function-separately-held"

def generationRule : String := "Generate the literal product of the eight registered binary coordinates; decide every form by complete carrier preservation, exact equivalence enumeration, minimality and absence of an extra rule."
def grammarBoundary : String := "Every finite chemical molecular carrier used by a downstream biological process, with complete composition, structure, state, conditions and separately registered function relation."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Structure.rejected,Structure.admitted]).flatMap fun structure =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Function.rejected,Function.admitted]).flatMap fun function =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extra.rejected,Extra.admitted]).map fun extra =>
  ⟨carrier,composition,structure,state,function,boundary,record,extra⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier composition structure state function boundary record extra =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstructure : structure ∈ [Structure.rejected,Structure.admitted] := by
      cases structure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfunction : function ∈ [Function.rejected,Function.admitted] := by
      cases function <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextra : extra ∈ [Extra.rejected,Extra.admitted] := by
      cases extra <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ structure _ hstructure
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ function _ hfunction
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier composition structure state function boundary record extra =>
    cases carrier <;> cases composition <;> cases structure <;> cases state <;> cases function <;> cases boundary <;> cases record <;> cases extra
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier composition structure state function boundary record extra =>
    cases carrier <;> cases composition <;> cases structure <;> cases state <;> cases function <;> cases boundary <;> cases record <;> cases extra
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.composition = .admitted ∧ c.structure = .admitted ∧ c.state = .admitted ∧ c.function = .admitted ∧ c.boundary = .admitted ∧ c.record = .admitted ∧ c.extra = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier composition structure state function boundary record extra =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
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

theorem structure_rejected_rejected (c : Candidate) (h : c.structure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.structure eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
    rw [h] at field
    cases field

theorem function_rejected_rejected (c : Candidate) (h : c.function = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.function eq
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

end SFT.Physics.BiomolecularGrammar
