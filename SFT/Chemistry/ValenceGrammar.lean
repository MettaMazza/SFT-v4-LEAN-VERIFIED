import SFT.Chemistry.ValenceMaximum
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ValenceGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "element-name-only"
  | .admitted => "atom-or-fragment-carrier"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "assumed-valence-number"
  | .admitted => "complete-generated-combination-support"

inductive Unit where
  | rejected | admitted

def unitName : Unit → String
  | .rejected => "mixed-partner-count"
  | .admitted => "univalent-partner-count"

inductive Selection where
  | rejected | admitted

def selectionName : Selection → String
  | .rejected => "typical-count"
  | .admitted => "maximum-realized-count"

inductive Substitution where
  | rejected | admitted

def substitutionName : Substitution → String
  | .rejected => "combination-only"
  | .admitted => "combination-or-substitution"

inductive Context where
  | rejected | admitted

def contextName : Context → String
  | .rejected => "universal-context-free-number"
  | .admitted => "chemical-context-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "number-without-traces"
  | .admitted => "combination-maximum-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-valence-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  support : Support
  unit : Unit
  selection : Selection
  substitution : Substitution
  context : Context
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, supportName c.support, unitName c.unit, selectionName c.selection, substitutionName c.substitution, contextName c.context, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "unit=" (unitName c.unit), SFT.Host.Text.append "selection=" (selectionName c.selection), SFT.Host.Text.append "substitution=" (substitutionName c.substitution), SFT.Host.Text.append "context=" (contextName c.context), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "atom-or-fragment-carrier__complete-generated-combination-support__univalent-partner-count__maximum-realized-count__combination-or-substitution__chemical-context-retained__combination-maximum-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "atom-or-fragment-carrier" &&
  SFT.Host.Text.equal (supportName c.support) "complete-generated-combination-support" &&
  SFT.Host.Text.equal (unitName c.unit) "univalent-partner-count" &&
  SFT.Host.Text.equal (selectionName c.selection) "maximum-realized-count" &&
  SFT.Host.Text.equal (substitutionName c.substitution) "combination-or-substitution" &&
  SFT.Host.Text.equal (contextName c.context) "chemical-context-retained" &&
  SFT.Host.Text.equal (recordName c.record) "combination-maximum-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "atom-or-fragment-carrier") then "An element name contains no combination witness." else
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-combination-support") then "An assumed number imports the answer." else
  if !(SFT.Host.Text.equal (unitName c.unit) "univalent-partner-count") then "Partners of unrecorded multiplicity cannot define one comparison." else
  if !(SFT.Host.Text.equal (selectionName c.selection) "maximum-realized-count") then "A typical value can omit a lawful larger combination." else
  if !(SFT.Host.Text.equal (substitutionName c.substitution) "combination-or-substitution") then "Valence also constrains lawful substitution for the carrier." else
  if !(SFT.Host.Text.equal (contextName c.context) "chemical-context-retained") then "Chemical environment may alter available combinations." else
  if !(SFT.Host.Text.equal (recordName c.record) "combination-maximum-trace") then "A bare number cannot reproduce its maximum witness." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An adjustment can force a conventional value." else
  "atom-or-fragment-carrier__complete-generated-combination-support__univalent-partner-count__maximum-realized-count"

def generationRule : String := "Generate the literal product of the registered valence carrier, support, unit, selection, substitution, context, record and extension choices."
def grammarBoundary : String := "Every finite atom or chemical fragment with complete generated combination and substitution traces, where the largest realized univalent joining count is retained with its chemical context."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Unit.rejected,Unit.admitted]).flatMap fun unit =>
  ([Selection.rejected,Selection.admitted]).flatMap fun selection =>
  ([Substitution.rejected,Substitution.admitted]).flatMap fun substitution =>
  ([Context.rejected,Context.admitted]).flatMap fun context =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,support,unit,selection,substitution,context,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier support unit selection substitution context record extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hunit : unit ∈ [Unit.rejected,Unit.admitted] := by
      cases unit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hselection : selection ∈ [Selection.rejected,Selection.admitted] := by
      cases selection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsubstitution : substitution ∈ [Substitution.rejected,Substitution.admitted] := by
      cases substitution <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcontext : context ∈ [Context.rejected,Context.admitted] := by
      cases context <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ unit _ hunit
    apply CommonRefinement.memFlatMap _ _ selection _ hselection
    apply CommonRefinement.memFlatMap _ _ substitution _ hsubstitution
    apply CommonRefinement.memFlatMap _ _ context _ hcontext
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk carrier support unit selection substitution context record extension =>
    cases carrier <;> cases support <;> cases unit <;> cases selection <;> cases substitution <;> cases context <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk carrier support unit selection substitution context record extension =>
    cases carrier <;> cases support <;> cases unit <;> cases selection <;> cases substitution <;> cases context <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.support = .admitted ∧ c.unit = .admitted ∧ c.selection = .admitted ∧ c.substitution = .admitted ∧ c.context = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier support unit selection substitution context record extension =>
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

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem unit_rejected_rejected (c : Candidate) (h : c.unit = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.unit eq
    rw [h] at field
    cases field

theorem selection_rejected_rejected (c : Candidate) (h : c.selection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.selection eq
    rw [h] at field
    cases field

theorem substitution_rejected_rejected (c : Candidate) (h : c.substitution = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.substitution eq
    rw [h] at field
    cases field

theorem context_rejected_rejected (c : Candidate) (h : c.context = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.context eq
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

end SFT.Chemistry.ValenceGrammar
