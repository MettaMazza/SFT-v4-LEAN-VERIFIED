import SFT.Chemistry.PeriodicRecurrenceTrace
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.PeriodicRecurrenceGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "property-name-series"
  | .admitted => "boundary-closed-outer-support"

inductive Progression where
  | rejected | admitted

def progressionName : Progression → String
  | .rejected => "mass-selected-progression"
  | .admitted => "atomic-number-successor-progression"

inductive Equivalence where
  | rejected | admitted

def equivalenceName : Equivalence → String
  | .rejected => "visual-column-equivalence"
  | .admitted => "complete-chemical-trace-equivalence"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "unbounded-orbital-continuum"
  | .admitted => "finite-bound-state-recurrence"

inductive Occupation where
  | rejected | admitted

def occupationName : Occupation → String
  | .rejected => "duplicate-state-without-trace"
  | .admitted => "exclusion-preserving-occupation"

inductive Periodicity where
  | rejected | admitted

def periodicityName : Periodicity → String
  | .rejected => "assumed-fixed-period"
  | .admitted => "return-of-observation-class"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "recurrence-label-only"
  | .admitted => "support-transition-recurrence-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-shell-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  progression : Progression
  equivalence : Equivalence
  closure : Closure
  occupation : Occupation
  periodicity : Periodicity
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, progressionName c.progression, equivalenceName c.equivalence, closureName c.closure, occupationName c.occupation, periodicityName c.periodicity, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "progression=" (progressionName c.progression), SFT.Host.Text.append "equivalence=" (equivalenceName c.equivalence), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "occupation=" (occupationName c.occupation), SFT.Host.Text.append "periodicity=" (periodicityName c.periodicity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "boundary-closed-outer-support__atomic-number-successor-progression__complete-chemical-trace-equivalence__finite-bound-state-recurrence__exclusion-preserving-occupation__return-of-observation-class__support-transition-recurrence-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "boundary-closed-outer-support" &&
  SFT.Host.Text.equal (progressionName c.progression) "atomic-number-successor-progression" &&
  SFT.Host.Text.equal (equivalenceName c.equivalence) "complete-chemical-trace-equivalence" &&
  SFT.Host.Text.equal (closureName c.closure) "finite-bound-state-recurrence" &&
  SFT.Host.Text.equal (occupationName c.occupation) "exclusion-preserving-occupation" &&
  SFT.Host.Text.equal (periodicityName c.periodicity) "return-of-observation-class" &&
  SFT.Host.Text.equal (recordName c.record) "support-transition-recurrence-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "boundary-closed-outer-support") then "A list of property names contains no physical recurrence carrier." else
  if !(SFT.Host.Text.equal (progressionName c.progression) "atomic-number-successor-progression") then "Isotope mass does not determine element succession." else
  if !(SFT.Host.Text.equal (equivalenceName c.equivalence) "complete-chemical-trace-equivalence") then "A drawing cannot establish common chemical behavior." else
  if !(SFT.Host.Text.equal (closureName c.closure) "finite-bound-state-recurrence") then "An ungenerated continuum violates the finite exact domain." else
  if !(SFT.Host.Text.equal (occupationName c.occupation) "exclusion-preserving-occupation") then "Unrecorded duplicate occupation violates exclusion." else
  if !(SFT.Host.Text.equal (periodicityName c.periodicity) "return-of-observation-class") then "A fixed imported period can manufacture recurrence." else
  if !(SFT.Host.Text.equal (recordName c.record) "support-transition-recurrence-trace") then "A repeated label does not reproduce the equivalence test." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary shell equation would import the desired organization." else
  "boundary-closed-outer-support__atomic-number-successor-progression__complete-chemical-trace-equivalence__return-of-observation-class"

def generationRule : String := "Generate the literal product of the registered recurrence carrier, progression, equivalence, closure, occupation, periodicity, record and extension choices."
def grammarBoundary : String := "Every generated positive-finite atomic-number successor family whose boundary-closed outer observation support is quotiented only by complete chemical transition equivalence."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Progression.rejected,Progression.admitted]).flatMap fun progression =>
  ([Equivalence.rejected,Equivalence.admitted]).flatMap fun equivalence =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Occupation.rejected,Occupation.admitted]).flatMap fun occupation =>
  ([Periodicity.rejected,Periodicity.admitted]).flatMap fun periodicity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,progression,equivalence,closure,occupation,periodicity,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier progression equivalence closure occupation periodicity record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprogression : progression ∈ [Progression.rejected,Progression.admitted] := by
      cases progression <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequivalence : equivalence ∈ [Equivalence.rejected,Equivalence.admitted] := by
      cases equivalence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccupation : occupation ∈ [Occupation.rejected,Occupation.admitted] := by
      cases occupation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiodicity : periodicity ∈ [Periodicity.rejected,Periodicity.admitted] := by
      cases periodicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ progression _ hprogression
    apply CommonRefinement.memFlatMap _ _ equivalence _ hequivalence
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ occupation _ hoccupation
    apply CommonRefinement.memFlatMap _ _ periodicity _ hperiodicity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier progression equivalence closure occupation periodicity record extension =>
    cases carrier <;> cases progression <;> cases equivalence <;> cases closure <;> cases occupation <;> cases periodicity <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier progression equivalence closure occupation periodicity record extension =>
    cases carrier <;> cases progression <;> cases equivalence <;> cases closure <;> cases occupation <;> cases periodicity <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.progression = .admitted ∧ c.equivalence = .admitted ∧ c.closure = .admitted ∧ c.occupation = .admitted ∧ c.periodicity = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier progression equivalence closure occupation periodicity record extension =>
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

theorem progression_rejected_rejected (c : Candidate) (h : c.progression = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.progression eq
    rw [h] at field
    cases field

theorem equivalence_rejected_rejected (c : Candidate) (h : c.equivalence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equivalence eq
    rw [h] at field
    cases field

theorem closure_rejected_rejected (c : Candidate) (h : c.closure = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.closure eq
    rw [h] at field
    cases field

theorem occupation_rejected_rejected (c : Candidate) (h : c.occupation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occupation eq
    rw [h] at field
    cases field

theorem periodicity_rejected_rejected (c : Candidate) (h : c.periodicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.periodicity eq
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

end SFT.Chemistry.PeriodicRecurrenceGrammar
