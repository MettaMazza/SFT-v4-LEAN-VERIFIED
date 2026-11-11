import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.IntermolecularGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carriers where
  | rejected | admitted

def carriersName : Carriers → String
  | .rejected => "one-molecule-internal-edge"
  | .admitted => "distinct-molecular-carriers"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "proximity-without-channel"
  | .admitted => "between-whole-interaction-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "constituents-merged-erased"
  | .admitted => "constituent-identities-retained"

inductive Recurrence where
  | rejected | admitted

def recurrenceName : Recurrence → String
  | .rejected => "transient-coincidence"
  | .admitted => "collective-recurrence"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "inter-intra-conflation"
  | .admitted => "explicit-molecular-boundary"

inductive Strength where
  | rejected | admitted

def strengthName : Strength → String
  | .rejected => "universal-weaker-law"
  | .admitted => "source-bounded-interaction-record"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "force-name-only"
  | .admitted => "carrier-channel-recurrence-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-force-family"
  | .admitted => "no-extra-rule"

structure Candidate where
  carriers : Carriers
  support : Support
  identity : Identity
  recurrence : Recurrence
  boundary : Boundary
  strength : Strength
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carriersName c.carriers, supportName c.support, identityName c.identity, recurrenceName c.recurrence, boundaryName c.boundary, strengthName c.strength, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carriers=" (carriersName c.carriers), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "recurrence=" (recurrenceName c.recurrence), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "strength=" (strengthName c.strength), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "distinct-molecular-carriers__between-whole-interaction-support__constituent-identities-retained__collective-recurrence__explicit-molecular-boundary__source-bounded-interaction-record__carrier-channel-recurrence-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carriersName c.carriers) "distinct-molecular-carriers" &&
  SFT.Host.Text.equal (supportName c.support) "between-whole-interaction-support" &&
  SFT.Host.Text.equal (identityName c.identity) "constituent-identities-retained" &&
  SFT.Host.Text.equal (recurrenceName c.recurrence) "collective-recurrence" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "explicit-molecular-boundary" &&
  SFT.Host.Text.equal (strengthName c.strength) "source-bounded-interaction-record" &&
  SFT.Host.Text.equal (recordName c.record) "carrier-channel-recurrence-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carriersName c.carriers) "distinct-molecular-carriers") then "An internal edge is intramolecular support." else
  if !(SFT.Host.Text.equal (supportName c.support) "between-whole-interaction-support") then "Proximity alone supplies no interaction trace." else
  if !(SFT.Host.Text.equal (identityName c.identity) "constituent-identities-retained") then "Erasing each molecule changes the class to a new bonded carrier." else
  if !(SFT.Host.Text.equal (recurrenceName c.recurrence) "collective-recurrence") then "A coincidence without response cannot organize an assembly." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "explicit-molecular-boundary") then "Conflation makes every covalent edge intermolecular." else
  if !(SFT.Host.Text.equal (strengthName c.strength) "source-bounded-interaction-record") then "Not every context forces one strength ordering." else
  if !(SFT.Host.Text.equal (recordName c.record) "carrier-channel-recurrence-trace") then "A force name cannot reconstruct endpoints and response." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An imported family can select desired interactions." else
  "distinct-molecular-carriers__between-whole-interaction-support__constituent-identities-retained__collective-recurrence__explicit-molecular-boundary"

def generationRule : String := "Generate the literal product of the registered intermolecular carrier, support, identity, recurrence, boundary, strength, record and extension choices."
def grammarBoundary : String := "Every finite interaction support joining two or more already complete molecular carriers while retaining each molecular identity and the boundary between inter- and intramolecular support."

def candidates : List Candidate :=
  ([Carriers.rejected,Carriers.admitted]).flatMap fun carriers =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Recurrence.rejected,Recurrence.admitted]).flatMap fun recurrence =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Strength.rejected,Strength.admitted]).flatMap fun strength =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carriers,support,identity,recurrence,boundary,strength,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carriers support identity recurrence boundary strength record extension =>
    have hcarriers : carriers ∈ [Carriers.rejected,Carriers.admitted] := by
      cases carriers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecurrence : recurrence ∈ [Recurrence.rejected,Recurrence.admitted] := by
      cases recurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstrength : strength ∈ [Strength.rejected,Strength.admitted] := by
      cases strength <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carriers _ hcarriers
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ recurrence _ hrecurrence
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ strength _ hstrength
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carriers support identity recurrence boundary strength record extension =>
    cases carriers <;> cases support <;> cases identity <;> cases recurrence <;> cases boundary <;> cases strength <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carriers support identity recurrence boundary strength record extension =>
    cases carriers <;> cases support <;> cases identity <;> cases recurrence <;> cases boundary <;> cases strength <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carriers = .admitted ∧ c.support = .admitted ∧ c.identity = .admitted ∧ c.recurrence = .admitted ∧ c.boundary = .admitted ∧ c.strength = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carriers support identity recurrence boundary strength record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem carriers_rejected_rejected (c : Candidate) (h : c.carriers = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carriers eq
    rw [h] at field
    cases field

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem recurrence_rejected_rejected (c : Candidate) (h : c.recurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recurrence eq
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

theorem strength_rejected_rejected (c : Candidate) (h : c.strength = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.strength eq
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

end SFT.Chemistry.IntermolecularGrammar
