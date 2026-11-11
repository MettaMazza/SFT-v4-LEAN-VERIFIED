import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SupramolecularGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Components where
  | rejected | admitted

def componentsName : Components → String
  | .rejected => "single-molecule-only"
  | .admitted => "multiple-molecular-components"

inductive Joining where
  | rejected | admitted

def joiningName : Joining → String
  | .rejected => "new-internal-covalent-graph"
  | .admitted => "noncovalent-interaction-support"

inductive Recognition where
  | rejected | admitted

def recognitionName : Recognition → String
  | .rejected => "arbitrary-collision"
  | .admitted => "complementary-recognition"

inductive Reversal where
  | rejected | admitted

def reversalName : Reversal → String
  | .rejected => "components-unrecoverable"
  | .admitted => "reversible-component-release"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "components-only"
  | .admitted => "assembled-whole-identity"

inductive Scope where
  | rejected | admitted

def scopeName : Scope → String
  | .rejected => "completed-infinite-assembly"
  | .admitted => "finite-declared-assembly"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "assembly-name-only"
  | .admitted => "component-recognition-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-host-guest-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  components : Components
  joining : Joining
  recognition : Recognition
  reversal : Reversal
  closure : Closure
  scope : Scope
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [componentsName c.components, joiningName c.joining, recognitionName c.recognition, reversalName c.reversal, closureName c.closure, scopeName c.scope, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "components=" (componentsName c.components), SFT.Host.Text.append "joining=" (joiningName c.joining), SFT.Host.Text.append "recognition=" (recognitionName c.recognition), SFT.Host.Text.append "reversal=" (reversalName c.reversal), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "scope=" (scopeName c.scope), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "multiple-molecular-components__noncovalent-interaction-support__complementary-recognition__reversible-component-release__assembled-whole-identity__finite-declared-assembly__component-recognition-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (componentsName c.components) "multiple-molecular-components" &&
  SFT.Host.Text.equal (joiningName c.joining) "noncovalent-interaction-support" &&
  SFT.Host.Text.equal (recognitionName c.recognition) "complementary-recognition" &&
  SFT.Host.Text.equal (reversalName c.reversal) "reversible-component-release" &&
  SFT.Host.Text.equal (closureName c.closure) "assembled-whole-identity" &&
  SFT.Host.Text.equal (scopeName c.scope) "finite-declared-assembly" &&
  SFT.Host.Text.equal (recordName c.record) "component-recognition-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (componentsName c.components) "multiple-molecular-components") then "A supramolecular assembly contains multiple molecular components." else
  if !(SFT.Host.Text.equal (joiningName c.joining) "noncovalent-interaction-support") then "Replacing components by one covalent graph erases the supramolecular boundary." else
  if !(SFT.Host.Text.equal (recognitionName c.recognition) "complementary-recognition") then "A collision has no complementary selection trace." else
  if !(SFT.Host.Text.equal (reversalName c.reversal) "reversible-component-release") then "If components cannot be recovered, their identities were not retained." else
  if !(SFT.Host.Text.equal (closureName c.closure) "assembled-whole-identity") then "Separate components do not form an assembled whole." else
  if !(SFT.Host.Text.equal (scopeName c.scope) "finite-declared-assembly") then "A completed infinity is not generated." else
  if !(SFT.Host.Text.equal (recordName c.record) "component-recognition-trace") then "A name cannot reconstruct recognition and release." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "An exception can force any desired assembly." else
  "multiple-molecular-components__noncovalent-interaction-support__complementary-recognition__reversible-component-release__assembled-whole-identity"

def generationRule : String := "Generate the literal product of the registered supramolecular components, joining, recognition, reversal, closure, scope, record and extension choices."
def grammarBoundary : String := "Every finite assembly of multiple complete molecular carriers joined through reversible recognition support, with all components recoverable and the collective whole separately distinguishable."

def candidates : List Candidate :=
  ([Components.rejected,Components.admitted]).flatMap fun components =>
  ([Joining.rejected,Joining.admitted]).flatMap fun joining =>
  ([Recognition.rejected,Recognition.admitted]).flatMap fun recognition =>
  ([Reversal.rejected,Reversal.admitted]).flatMap fun reversal =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Scope.rejected,Scope.admitted]).flatMap fun scope =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨components,joining,recognition,reversal,closure,scope,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk components joining recognition reversal closure scope record extension =>
    have hcomponents : components ∈ [Components.rejected,Components.admitted] := by
      cases components <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hjoining : joining ∈ [Joining.rejected,Joining.admitted] := by
      cases joining <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecognition : recognition ∈ [Recognition.rejected,Recognition.admitted] := by
      cases recognition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreversal : reversal ∈ [Reversal.rejected,Reversal.admitted] := by
      cases reversal <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscope : scope ∈ [Scope.rejected,Scope.admitted] := by
      cases scope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ components _ hcomponents
    apply CommonRefinement.memFlatMap _ _ joining _ hjoining
    apply CommonRefinement.memFlatMap _ _ recognition _ hrecognition
    apply CommonRefinement.memFlatMap _ _ reversal _ hreversal
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ scope _ hscope
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk components joining recognition reversal closure scope record extension =>
    cases components <;> cases joining <;> cases recognition <;> cases reversal <;> cases closure <;> cases scope <;> cases record <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk components joining recognition reversal closure scope record extension =>
    cases components <;> cases joining <;> cases recognition <;> cases reversal <;> cases closure <;> cases scope <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.components = .admitted ∧ c.joining = .admitted ∧ c.recognition = .admitted ∧ c.reversal = .admitted ∧ c.closure = .admitted ∧ c.scope = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk components joining recognition reversal closure scope record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem components_rejected_rejected (c : Candidate) (h : c.components = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.components eq
    rw [h] at field
    cases field

theorem joining_rejected_rejected (c : Candidate) (h : c.joining = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.joining eq
    rw [h] at field
    cases field

theorem recognition_rejected_rejected (c : Candidate) (h : c.recognition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.recognition eq
    rw [h] at field
    cases field

theorem reversal_rejected_rejected (c : Candidate) (h : c.reversal = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reversal eq
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

theorem scope_rejected_rejected (c : Candidate) (h : c.scope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scope eq
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

end SFT.Chemistry.SupramolecularGrammar
