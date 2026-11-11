import SFT.Physics.AtomicBoundary
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.AtomicBoundaryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Charge where
  | rejected | admitted

def chargeName : Charge → String
  | .rejected => "unbound-number"
  | .admitted => "positive-held-charge-count"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "fitted-binding-equation"
  | .admitted => "charge-over-sealed-inverse-ratio"

inductive Ceiling where
  | rejected | admitted

def ceilingName : Ceiling → String
  | .rejected => "external-critical-charge"
  | .admitted => "complete-One-ceiling"

inductive Endpoint where
  | rejected | admitted

def endpointName : Endpoint → String
  | .rejected => "bounded-neighborhood-walk"
  | .admitted => "greatest-whole-division-certificate"

inductive Lower where
  | rejected | admitted

def lowerName : Lower → String
  | .rejected => "endpoint-label-only"
  | .admitted => "exact-lower-inequality"

inductive Upper where
  | rejected | admitted

def upperName : Upper → String
  | .rejected => "single-next-value-check-only"
  | .admitted => "successor-above-plus-order"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "finite-coordinate-census"
  | .admitted => "depth-independent-greatest-whole-law"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "observed-elements-visible"
  | .admitted => "observations-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-size-parameter"
  | .admitted => "no-extra-rule"

structure Candidate where
  charge : Charge
  coupling : Coupling
  ceiling : Ceiling
  endpoint : Endpoint
  lower : Lower
  upper : Upper
  generality : Generality
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [chargeName c.charge, couplingName c.coupling, ceilingName c.ceiling, endpointName c.endpoint, lowerName c.lower, upperName c.upper, generalityName c.generality, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "charge=" (chargeName c.charge), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "ceiling=" (ceilingName c.ceiling), SFT.Host.Text.append "endpoint=" (endpointName c.endpoint), SFT.Host.Text.append "lower=" (lowerName c.lower), SFT.Host.Text.append "upper=" (upperName c.upper), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "positive-held-charge-count__charge-over-sealed-inverse-ratio__complete-One-ceiling__greatest-whole-division-certificate__exact-lower-inequality__successor-above-plus-order__depth-independent-greatest-whole-law__observations-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (chargeName c.charge) "positive-held-charge-count" &&
  SFT.Host.Text.equal (couplingName c.coupling) "charge-over-sealed-inverse-ratio" &&
  SFT.Host.Text.equal (ceilingName c.ceiling) "complete-One-ceiling" &&
  SFT.Host.Text.equal (endpointName c.endpoint) "greatest-whole-division-certificate" &&
  SFT.Host.Text.equal (lowerName c.lower) "exact-lower-inequality" &&
  SFT.Host.Text.equal (upperName c.upper) "successor-above-plus-order" &&
  SFT.Host.Text.equal (generalityName c.generality) "depth-independent-greatest-whole-law" &&
  SFT.Host.Text.equal (targetName c.target) "observations-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (chargeName c.charge) "unbound-number" then "An unbound number has no element identity." else
  if SFT.Host.Text.equal (couplingName c.coupling) "fitted-binding-equation" then "A fitted equation imports the endpoint." else
  if SFT.Host.Text.equal (ceilingName c.ceiling) "external-critical-charge" then "An external critical charge is target input." else
  if SFT.Host.Text.equal (endpointName c.endpoint) "bounded-neighborhood-walk" then "A chosen search interval does not close all successors." else
  if SFT.Host.Text.equal (lowerName c.lower) "endpoint-label-only" then "A label has no inequality witness." else
  if SFT.Host.Text.equal (upperName c.upper) "single-next-value-check-only" then "One check without order closure does not exclude later values." else
  if SFT.Host.Text.equal (generalityName c.generality) "finite-coordinate-census" then "A finite census leaves later coordinates open." else
  if SFT.Host.Text.equal (targetName c.target) "observed-elements-visible" then "That would turn an observation boundary into a law." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-size-parameter" then "A size correction is a different, parameterized model." else
  "The unique greatest positive whole atomic coordinate under the exact Fold binding ceiling is 137; 137 <= 503846395469/3676744786 < 138."

def generationRule : String := "Generate the complete product of charge carrier, coupling, ceiling, endpoint construction, lower witness, upper witness, generality, target custody and extension forms."
def grammarBoundary : String := "All greatest-positive-whole atomic-coordinate conclusions under the One binding ceiling and the independently sealed exact inverse fine-structure ratio."

def candidates : List Candidate :=
  ([Charge.rejected,Charge.admitted]).flatMap fun charge =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Ceiling.rejected,Ceiling.admitted]).flatMap fun ceiling =>
  ([Endpoint.rejected,Endpoint.admitted]).flatMap fun endpoint =>
  ([Lower.rejected,Lower.admitted]).flatMap fun lower =>
  ([Upper.rejected,Upper.admitted]).flatMap fun upper =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨charge,coupling,ceiling,endpoint,lower,upper,generality,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk charge coupling ceiling endpoint lower upper generality target extension =>
    have hcharge : charge ∈ [Charge.rejected,Charge.admitted] := by
      cases charge <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hceiling : ceiling ∈ [Ceiling.rejected,Ceiling.admitted] := by
      cases ceiling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hendpoint : endpoint ∈ [Endpoint.rejected,Endpoint.admitted] := by
      cases endpoint <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlower : lower ∈ [Lower.rejected,Lower.admitted] := by
      cases lower <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hupper : upper ∈ [Upper.rejected,Upper.admitted] := by
      cases upper <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ charge _ hcharge
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ ceiling _ hceiling
    apply CommonRefinement.memFlatMap _ _ endpoint _ hendpoint
    apply CommonRefinement.memFlatMap _ _ lower _ hlower
    apply CommonRefinement.memFlatMap _ _ upper _ hupper
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk charge coupling ceiling endpoint lower upper generality target extension =>
    cases charge <;> cases coupling <;> cases ceiling <;> cases endpoint <;> cases lower <;> cases upper <;> cases generality <;> cases target <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk charge coupling ceiling endpoint lower upper generality target extension =>
    cases charge <;> cases coupling <;> cases ceiling <;> cases endpoint <;> cases lower <;> cases upper <;> cases generality <;> cases target <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.charge = .admitted ∧ c.coupling = .admitted ∧ c.ceiling = .admitted ∧ c.endpoint = .admitted ∧ c.lower = .admitted ∧ c.upper = .admitted ∧ c.generality = .admitted ∧ c.target = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk charge coupling ceiling endpoint lower upper generality target extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem charge_rejected_rejected (c : Candidate) (h : c.charge = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.charge eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
    rw [h] at field
    cases field

theorem ceiling_rejected_rejected (c : Candidate) (h : c.ceiling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ceiling eq
    rw [h] at field
    cases field

theorem endpoint_rejected_rejected (c : Candidate) (h : c.endpoint = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoint eq
    rw [h] at field
    cases field

theorem lower_rejected_rejected (c : Candidate) (h : c.lower = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.lower eq
    rw [h] at field
    cases field

theorem upper_rejected_rejected (c : Candidate) (h : c.upper = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.upper eq
    rw [h] at field
    cases field

theorem generality_rejected_rejected (c : Candidate) (h : c.generality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.generality eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.AtomicBoundaryGrammar
