import SFT.Physics.VacuumPolarization
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.VacuumPolarizationGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "borrowed-vacuum-number"
  | .admitted => "generated-exact-Fold-carrier"

inductive Dependency where
  | rejected | admitted

def dependencyName : Dependency → String
  | .rejected => "asserted-prior-answer"
  | .admitted => "admitted-V3-dependency-trace"

inductive Relation where
  | rejected | admitted

def relationName : Relation → String
  | .rejected => "fitted-running-curve-or-reversed-direction"
  | .admitted => "half-One-screened-to-One-exposed-running"

inductive Enumeration where
  | rejected | admitted

def enumerationName : Enumeration → String
  | .rejected => "selected-candidate-neighbourhood"
  | .admitted => "complete-registered-product"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "survivor-without-lower-controls"
  | .admitted => "all-omitted-carrier-forms-rejected"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-visible-before-seal"
  | .admitted => "exact-result-sealed-before-comparison"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "answer-only-record"
  | .admitted => "complete-source-transfer-control-record"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  dependency : Dependency
  relation : Relation
  enumeration : Enumeration
  minimality : Minimality
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, dependencyName c.dependency, relationName c.relation, enumerationName c.enumeration, minimalityName c.minimality, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "dependency=" (dependencyName c.dependency), SFT.Host.Text.append "relation=" (relationName c.relation), SFT.Host.Text.append "enumeration=" (enumerationName c.enumeration), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generated-exact-Fold-carrier__admitted-V3-dependency-trace__half-One-screened-to-One-exposed-running__complete-registered-product__all-omitted-carrier-forms-rejected__exact-result-sealed-before-comparison__complete-source-transfer-control-record__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "generated-exact-Fold-carrier" &&
  SFT.Host.Text.equal (dependencyName c.dependency) "admitted-V3-dependency-trace" &&
  SFT.Host.Text.equal (relationName c.relation) "half-One-screened-to-One-exposed-running" &&
  SFT.Host.Text.equal (enumerationName c.enumeration) "complete-registered-product" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "all-omitted-carrier-forms-rejected" &&
  SFT.Host.Text.equal (measurementName c.measurement) "exact-result-sealed-before-comparison" &&
  SFT.Host.Text.equal (recordName c.record) "complete-source-transfer-control-record" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "borrowed-vacuum-number" then "A borrowed vacuum number has no Fold trace." else
  if SFT.Host.Text.equal (dependencyName c.dependency) "asserted-prior-answer" then "An asserted prior answer is an unregistered premise." else
  if SFT.Host.Text.equal (relationName c.relation) "fitted-running-curve-or-reversed-direction" then "The alternative loses a required carrier or imports an extra law." else
  if SFT.Host.Text.equal (enumerationName c.enumeration) "selected-candidate-neighbourhood" then "A selected neighbourhood cannot establish uniqueness." else
  if SFT.Host.Text.equal (minimalityName c.minimality) "survivor-without-lower-controls" then "A bare survivor does not prove the required carriers are minimal." else
  if SFT.Host.Text.equal (measurementName c.measurement) "target-visible-before-seal" then "Target access before sealing reverses the scientific direction." else
  if SFT.Host.Text.equal (recordName c.record) "answer-only-record" then "An answer alone cannot reproduce the source and transfer ledger." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-extra-rule" then "An added selector is a free parameter." else
  "Vacuum polarization forces the structural running direction screened 1/2 -> exposed One; closer probing removes screening and increases effective electromagnetic support."

def generationRule : String := "Generate the complete eight-axis product of polarization carrier, dependencies, screened-to-exposed relation, enumeration, minimality, measurement direction, record and extension."
def grammarBoundary : String := "The complete exact Fold fibre from the half-One screened carrier to the exposed One, with every intermediate finite screening layer retained if subsequently generated."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Dependency.rejected,Dependency.admitted]).flatMap fun dependency =>
  ([Relation.rejected,Relation.admitted]).flatMap fun relation =>
  ([Enumeration.rejected,Enumeration.admitted]).flatMap fun enumeration =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,dependency,relation,enumeration,minimality,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier dependency relation enumeration minimality measurement record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdependency : dependency ∈ [Dependency.rejected,Dependency.admitted] := by
      cases dependency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrelation : relation ∈ [Relation.rejected,Relation.admitted] := by
      cases relation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have henumeration : enumeration ∈ [Enumeration.rejected,Enumeration.admitted] := by
      cases enumeration <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ dependency _ hdependency
    apply CommonRefinement.memFlatMap _ _ relation _ hrelation
    apply CommonRefinement.memFlatMap _ _ enumeration _ henumeration
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier dependency relation enumeration minimality measurement record extension =>
    cases carrier <;> cases dependency <;> cases relation <;> cases enumeration <;> cases minimality <;> cases measurement <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier dependency relation enumeration minimality measurement record extension =>
    cases carrier <;> cases dependency <;> cases relation <;> cases enumeration <;> cases minimality <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.dependency = .admitted ∧ c.relation = .admitted ∧ c.enumeration = .admitted ∧ c.minimality = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier dependency relation enumeration minimality measurement record extension =>
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

theorem dependency_rejected_rejected (c : Candidate) (h : c.dependency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.dependency eq
    rw [h] at field
    cases field

theorem relation_rejected_rejected (c : Candidate) (h : c.relation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.relation eq
    rw [h] at field
    cases field

theorem enumeration_rejected_rejected (c : Candidate) (h : c.enumeration = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.enumeration eq
    rw [h] at field
    cases field

theorem minimality_rejected_rejected (c : Candidate) (h : c.minimality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.minimality eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Physics.VacuumPolarizationGrammar
