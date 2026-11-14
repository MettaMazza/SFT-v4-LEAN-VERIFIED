import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.MolecularSpectroscopyEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "replace-or-erase-predecessor"
  | .admitted => "retain-and-version-predecessor"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "one-universal-quarter-carrier"
  | .admitted => "distinct-generated-rotational-and-vibrational-carriers"

inductive Ladder where
  | rejected | admitted

def ladderName : Ladder → String
  | .rejected => "imported-continuum-spectrum"
  | .admitted => "counted-JJplusOne-and-odd-oscillator-ladders"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "signed-floating-series"
  | .admitted => "ordered-positive-held-Takes"

inductive Isotope where
  | rejected | admitted

def isotopeName : Isotope → String
  | .rejected => "free-isotope-factor"
  | .admitted => "count-refined-linear-and-squared-transport"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "selected-or-open-correction-order"
  | .admitted => "finite-typed-carrier-exhaustion"

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
  carrier : Carrier
  ladder : Ladder
  operation : Operation
  isotope : Isotope
  order : Order
  target : Target
  provenance : Provenance
  trace : Trace
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, carrierName c.carrier, ladderName c.ladder, operationName c.operation, isotopeName c.isotope, orderName c.order, targetName c.target, provenanceName c.provenance, traceName c.trace, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "ladder=" (ladderName c.ladder), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "isotope=" (isotopeName c.isotope), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "trace=" (traceName c.trace), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "retain-and-version-predecessor__distinct-generated-rotational-and-vibrational-carriers__counted-JJplusOne-and-odd-oscillator-ladders__ordered-positive-held-Takes__count-refined-linear-and-squared-transport__finite-typed-carrier-exhaustion__target-inaccessible-until-seal__disclosed-observational-prediction-protocol__complete-root-directed-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "retain-and-version-predecessor" &&
  SFT.Host.Text.equal (carrierName c.carrier) "distinct-generated-rotational-and-vibrational-carriers" &&
  SFT.Host.Text.equal (ladderName c.ladder) "counted-JJplusOne-and-odd-oscillator-ladders" &&
  SFT.Host.Text.equal (operationName c.operation) "ordered-positive-held-Takes" &&
  SFT.Host.Text.equal (isotopeName c.isotope) "count-refined-linear-and-squared-transport" &&
  SFT.Host.Text.equal (orderName c.order) "finite-typed-carrier-exhaustion" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "disclosed-observational-prediction-protocol" &&
  SFT.Host.Text.equal (traceName c.trace) "complete-root-directed-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "replace-or-erase-predecessor" then "A versioned successor cannot rewrite an admitted receipt or delete an adverse row." else
  if SFT.Host.Text.equal (carrierName c.carrier) "one-universal-quarter-carrier" then "One numerical carrier repeats the already rejected equality." else
  if SFT.Host.Text.equal (ladderName c.ladder) "imported-continuum-spectrum" then "A continuum spectrum is outside the exact finite Fold grammar." else
  if SFT.Host.Text.equal (operationName c.operation) "signed-floating-series" then "Signed or floating proof scalars violate the permitted domain." else
  if SFT.Host.Text.equal (isotopeName c.isotope) "free-isotope-factor" then "A chosen scale factor is a parameter." else
  if SFT.Host.Text.equal (orderName c.order) "selected-or-open-correction-order" then "A selected truncation or open correction list is not closed." else
  if SFT.Host.Text.equal (targetName c.target) "measurement-readable-execution" then "A target-readable execution cannot issue a sealed empirical prediction." else
  if SFT.Host.Text.equal (provenanceName c.provenance) "concealed-development-provenance" then "Concealing prior observation would misstate the empirical protocol." else
  if SFT.Host.Text.equal (traceName c.trace) "result-without-root-trace" then "An untraced numerical relation is inadmissible." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-term" then "An ungenerated extra term is a parameter." else
  "E_J/B=J(J+1), Delta_J/B=2J, and G_n=omega(2n-1)/2 Take omega_x(2n-1)^2/4. For exact alpha: B_H2/omega_H2=2alpha Take 14alpha^2 Take 58alpha^3 Take 82alpha^4; omega_x,H2/omega_H2=4alpha Take 30alpha^2 Take 59alpha^3 Take 63alpha^4; B_D2/B_H2=1/2+5alpha^2+38alpha^3; and (omega_D2/omega_H2)^2=1/2+20alpha^2+49alpha^3."

def generationRule : String := "Generate the complete ten-axis terminal molecular-spectroscopy product and exhaust the distinct ladder, alpha-return, isotope and provenance carriers."
def grammarBoundary : String := "All first terminal molecular successors preserving the admitted hierarchy and adverse receipt while using the complete J, odd-oscillator, down/up, generator, heavy, terminal and isotope carriers once in their typed roles."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Ladder.rejected,Ladder.admitted]).flatMap fun ladder =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Isotope.rejected,Isotope.admitted]).flatMap fun isotope =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Trace.rejected,Trace.admitted]).flatMap fun trace =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,carrier,ladder,operation,isotope,order,target,provenance,trace,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor carrier ladder operation isotope order target provenance trace extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hladder : ladder ∈ [Ladder.rejected,Ladder.admitted] := by
      cases ladder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotope : isotope ∈ [Isotope.rejected,Isotope.admitted] := by
      cases isotope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
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
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ ladder _ hladder
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ isotope _ hisotope
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ trace _ htrace
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 100000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk predecessor carrier ladder operation isotope order target provenance trace extension =>
    cases predecessor <;> cases carrier <;> cases ladder <;> cases operation <;> cases isotope <;> cases order <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals rfl

set_option maxHeartbeats 100000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk predecessor carrier ladder operation isotope order target provenance trace extension =>
    cases predecessor <;> cases carrier <;> cases ladder <;> cases operation <;> cases isotope <;> cases order <;> cases target <;> cases provenance <;> cases trace <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.predecessor = .admitted ∧ c.carrier = .admitted ∧ c.ladder = .admitted ∧ c.operation = .admitted ∧ c.isotope = .admitted ∧ c.order = .admitted ∧ c.target = .admitted ∧ c.provenance = .admitted ∧ c.trace = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk predecessor carrier ladder operation isotope order target provenance trace extension =>
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

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem ladder_rejected_rejected (c : Candidate) (h : c.ladder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.ladder eq
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

theorem isotope_rejected_rejected (c : Candidate) (h : c.isotope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotope eq
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

end SFT.Physics.MolecularSpectroscopyEntryGrammar
