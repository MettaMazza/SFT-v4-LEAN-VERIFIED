import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HydrogenRydbergEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-or-erase-predecessor"
  | .admitted => "retain-and-compose-predecessors"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "imported-measured-mass-factor"
  | .admitted => "exact-reduced-mass-from-terminal-rho"

inductive Correction where
  | rejected | admitted

def correctionName : Correction → String
  | .rejected => "untyped-coefficient-list"
  | .admitted => "role-typed-alpha-return-chain"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "signed-floating-series"
  | .admitted => "ordered-positive-held-Take"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-or-open-order"
  | .admitted => "finite-carrier-exhaustion-order"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "answer-only-decimal"
  | .admitted => "alpha-square-times-terminal-scale"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "measurement-readable-execution"
  | .admitted => "target-inaccessible-until-seal"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "concealed-development-provenance"
  | .admitted => "disclosed-observational-prediction-protocol"

inductive Trace where
  | rejected | admitted

def traceName : Trace → String
  | .rejected => "result-without-root-trace"
  | .admitted => "complete-root-directed-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-term"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  mass : Mass
  correction : Correction
  operation : Operation
  order : Order
  composition : Composition
  target : Target
  provenance : Provenance
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, massName c.mass, correctionName c.correction, operationName c.operation, orderName c.order, compositionName c.composition, targetName c.target, provenanceName c.provenance, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "correction=" (correctionName c.correction), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-and-compose-predecessors__exact-reduced-mass-from-terminal-rho__role-typed-alpha-return-chain__ordered-positive-held-Take__finite-carrier-exhaustion-order__alpha-square-times-terminal-scale__target-inaccessible-until-seal__disclosed-observational-prediction-protocol__complete-root-directed-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "retain-and-compose-predecessors" &&
  SFT.Host.Text.equal (massName c.mass) "exact-reduced-mass-from-terminal-rho" &&
  SFT.Host.Text.equal (correctionName c.correction) "role-typed-alpha-return-chain" &&
  SFT.Host.Text.equal (operationName c.operation) "ordered-positive-held-Take" &&
  SFT.Host.Text.equal (orderName c.order) "finite-carrier-exhaustion-order" &&
  SFT.Host.Text.equal (compositionName c.composition) "alpha-square-times-terminal-scale" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "disclosed-observational-prediction-protocol" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-root-directed-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-or-erase-predecessor" then "A successor cannot rewrite either immutable derivation." else
  if SFT.Host.Text.equal (massName c.mass) "imported-measured-mass-factor" then "A measured multiplier would become a proof parameter." else
  if SFT.Host.Text.equal (correctionName c.correction) "untyped-coefficient-list" then "An untyped list cannot force placement or orientation." else
  if SFT.Host.Text.equal (operationName c.operation) "signed-floating-series" then "Signed or floating proof scalars violate the exact Fold domain." else
  if SFT.Host.Text.equal (orderName c.order) "selected-or-open-order" then "A chosen truncation or open series is a free choice." else
  if SFT.Host.Text.equal (compositionName c.composition) "answer-only-decimal" then "An answer-only decimal erases alpha, mass and gap provenance." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-execution" then "A target-readable execution cannot issue a sealed prediction." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "concealed-development-provenance" then "Hidden prior observation would misstate the protocol." else
  if SFT.Host.Text.equal (traceName c.trace) "result-without-root-trace" then "An untraced physical ratio is inadmissible." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-term" then "An ungenerated term is a parameter." else
  "For exact terminal rho, H/R_infinity=rho/(rho+1)+alpha^2/5+alpha^3/2 Take 6alpha^4+49alpha^5; H/(m_e c^2)=alpha^2/2 times that carrier; Lyman-alpha/R_infinity is three-quarters and Balmer-alpha/R_infinity is five-thirty-sixths of the same carrier."

def generationRule : String := "Generate the complete ten-axis terminal hydrogen Rydberg-scale product and exhaust the reduced-mass, down, binary, colour, direction, up-square and line-gap carriers."
def grammarBoundary : String := "All first terminal finite-proton-mass completions of the admitted alpha-squared-over-two hydrogen scale, using the terminal rho enclosure and each generated alpha-return carrier exactly once before the immutable line gaps act."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Correction.rejected,Correction.admitted]).flatMap fun correction =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,mass,correction,operation,order,composition,target,provenance,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor mass correction operation order composition target provenance trace extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrection : correction ∈ [Correction.rejected,Correction.admitted] := by
      cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htrace : trace ∈ [Trace.rejected,Trace.admitted] := by
      cases trace <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ correction _ hcorrection
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor mass correction operation order composition target provenance trace extension =>
    cases predecessor <;> cases mass <;> cases correction <;> cases operation <;> cases order <;> cases composition <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor mass correction operation order composition target provenance trace extension =>
    cases predecessor <;> cases mass <;> cases correction <;> cases operation <;> cases order <;> cases composition <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.mass = .admitted ∧ c.correction = .admitted ∧ c.operation = .admitted ∧ c.order = .admitted ∧ c.composition = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor mass correction operation order composition target provenance trace extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem predecessor_rejected_rejected (c : Candidate) (h : c.predecessor = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.predecessor eq
    rw [h] at field
    cases field

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
    rw [h] at field
    cases field

theorem correction_rejected_rejected (c : Candidate) (h : c.correction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correction eq
    rw [h] at field
    cases field

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
    rw [h] at field
    cases field

theorem order_rejected_rejected (c : Candidate) (h : c.order = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.order eq
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

theorem target_rejected_rejected (c : Candidate) (h : c.target = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.target eq
    rw [h] at field
    cases field

theorem provenance_rejected_rejected (c : Candidate) (h : c.provenance = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.provenance eq
    rw [h] at field
    cases field

theorem trace_rejected_rejected (c : Candidate) (h : c.trace = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.trace eq
    rw [h] at field
    cases field

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.HydrogenRydbergEntryGrammar
