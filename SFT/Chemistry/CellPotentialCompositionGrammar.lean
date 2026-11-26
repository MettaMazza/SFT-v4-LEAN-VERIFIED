import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.CellPotentialCompositionGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carriers where
  | rejected | admitted

def carriersName : Carriers → String
  | .rejected => "anonymous-voltage-pair"
  | .admitted => "two-distinct-held-half-cell-carriers"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "mixed-reference-subtraction"
  | .admitted => "one-common-held-reference"

inductive Condition where
  | rejected | admitted

def conditionName : Condition → String
  | .rejected => "mixed-condition-subtraction"
  | .admitted => "one-common-held-condition"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "unordered-potential-difference"
  | .admitted => "held-source-terminal-reaction-path"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "signed-arithmetic-premise"
  | .admitted => "exact-positive-sum-or-Take-composition"

inductive Coincidence where
  | rejected | admitted

def coincidenceName : Coincidence → String
  | .rejected => "numerical-zero-cell-potential"
  | .admitted => "structural-EmptyOne-cell-coincidence"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-cell-voltage"
  | .admitted => "complete-full-cell-potential-vector"

inductive Reverse where
  | rejected | admitted

def reverseName : Reverse → String
  | .rejected => "irreversible-sign-flip"
  | .admitted => "exact-cell-reversal-preserves-positive-separation"

structure Candidate where
  carriers : Carriers
  reference : Reference
  condition : Condition
  path : Path
  composition : Composition
  coincidence : Coincidence
  record : Record
  reverse : Reverse

def sourceFields (c : Candidate) : List String := [carriersName c.carriers, referenceName c.reference, conditionName c.condition, pathName c.path, compositionName c.composition, coincidenceName c.coincidence, recordName c.record, reverseName c.reverse]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carriers=" (carriersName c.carriers), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "condition=" (conditionName c.condition), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "coincidence=" (coincidenceName c.coincidence), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "reverse=" (reverseName c.reverse)]
def survivorId : String := "two-distinct-held-half-cell-carriers__one-common-held-reference__one-common-held-condition__held-source-terminal-reaction-path__exact-positive-sum-or-Take-composition__structural-EmptyOne-cell-coincidence__complete-full-cell-potential-vector__exact-cell-reversal-preserves-positive-separation"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carriersName c.carriers) "two-distinct-held-half-cell-carriers" &&
  SFT.Host.Text.equal (referenceName c.reference) "one-common-held-reference" &&
  SFT.Host.Text.equal (conditionName c.condition) "one-common-held-condition" &&
  SFT.Host.Text.equal (pathName c.path) "held-source-terminal-reaction-path" &&
  SFT.Host.Text.equal (compositionName c.composition) "exact-positive-sum-or-Take-composition" &&
  SFT.Host.Text.equal (coincidenceName c.coincidence) "structural-EmptyOne-cell-coincidence" &&
  SFT.Host.Text.equal (recordName c.record) "complete-full-cell-potential-vector" &&
  SFT.Host.Text.equal (reverseName c.reverse) "exact-cell-reversal-preserves-positive-separation"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carriersName c.carriers) "two-distinct-held-half-cell-carriers") then "Anonymous values lose the two chemical half-cells." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "one-common-held-reference") then "Different references cannot compose directly." else
  if !(SFT.Host.Text.equal (conditionName c.condition) "one-common-held-condition") then "Different conditions destroy a cell comparison." else
  if !(SFT.Host.Text.equal (pathName c.path) "held-source-terminal-reaction-path") then "An unordered difference loses reaction direction." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "exact-positive-sum-or-Take-composition") then "Signed arithmetic imports negative proof values." else
  if !(SFT.Host.Text.equal (coincidenceName c.coincidence) "structural-EmptyOne-cell-coincidence") then "Numerical zero is not a native proof magnitude." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-full-cell-potential-vector") then "A selected voltage can conceal half-cell and condition rows." else
  if !(SFT.Host.Text.equal (reverseName c.reverse) "exact-cell-reversal-preserves-positive-separation") then "A sign flip does not reconstruct the chemical path." else
  "two-distinct-held-half-cell-carriers__one-common-held-reference__one-common-held-condition__held-source-terminal-reaction-path__exact-positive-sum-or-Take-composition__structural-EmptyOne-cell-coincidence__complete-full-cell-potential-vector__exact-cell-reversal-preserves-positive-separation"

def generationRule : String := "Generate the literal product of eight registered full-cell composition decisions."
def grammarBoundary : String := "Eight dimensions exhaust carriers, reference, condition, path, composition, coincidence, record and reversal."

def candidates : List Candidate :=
  ([Carriers.rejected,Carriers.admitted]).flatMap fun carriers =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Condition.rejected,Condition.admitted]).flatMap fun condition =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Coincidence.rejected,Coincidence.admitted]).flatMap fun coincidence =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Reverse.rejected,Reverse.admitted]).map fun reverse =>
  ⟨carriers,reference,condition,path,composition,coincidence,record,reverse⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carriers reference condition path composition coincidence record reverse =>
    have hcarriers : carriers ∈ [Carriers.rejected,Carriers.admitted] := by
      cases carriers <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcondition : condition ∈ [Condition.rejected,Condition.admitted] := by
      cases condition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoincidence : coincidence ∈ [Coincidence.rejected,Coincidence.admitted] := by
      cases coincidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreverse : reverse ∈ [Reverse.rejected,Reverse.admitted] := by
      cases reverse <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carriers _ hcarriers
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ condition _ hcondition
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ coincidence _ hcoincidence
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ reverse _ hreverse

theorem sourceDecisionBlock0000 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0001 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0010 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0011 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0100 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0101 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0110 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock0111 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1000 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1001 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1010 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1011 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1100 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1101 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1110 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionBlock1111 (composition : Composition) (coincidence : Coincidence) (record : Record) (reverse : Reverse) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,composition,coincidence,record,reverse⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,composition,coincidence,record,reverse⟩ := by
 cases composition <;> cases coincidence <;> cases record <;> cases reverse <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carriers reference condition path composition coincidence record reverse =>
  cases carriers <;> cases reference <;> cases condition <;> cases path
  · exact sourceDecisionBlock0000 composition coincidence record reverse
  · exact sourceDecisionBlock0001 composition coincidence record reverse
  · exact sourceDecisionBlock0010 composition coincidence record reverse
  · exact sourceDecisionBlock0011 composition coincidence record reverse
  · exact sourceDecisionBlock0100 composition coincidence record reverse
  · exact sourceDecisionBlock0101 composition coincidence record reverse
  · exact sourceDecisionBlock0110 composition coincidence record reverse
  · exact sourceDecisionBlock0111 composition coincidence record reverse
  · exact sourceDecisionBlock1000 composition coincidence record reverse
  · exact sourceDecisionBlock1001 composition coincidence record reverse
  · exact sourceDecisionBlock1010 composition coincidence record reverse
  · exact sourceDecisionBlock1011 composition coincidence record reverse
  · exact sourceDecisionBlock1100 composition coincidence record reverse
  · exact sourceDecisionBlock1101 composition coincidence record reverse
  · exact sourceDecisionBlock1110 composition coincidence record reverse
  · exact sourceDecisionBlock1111 composition coincidence record reverse

theorem carriersCriterion (value : Carriers) : SFT.Host.Text.equal (carriersName value) "two-distinct-held-half-cell-carriers" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem referenceCriterion (value : Reference) : SFT.Host.Text.equal (referenceName value) "one-common-held-reference" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem conditionCriterion (value : Condition) : SFT.Host.Text.equal (conditionName value) "one-common-held-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "held-source-terminal-reaction-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem compositionCriterion (value : Composition) : SFT.Host.Text.equal (compositionName value) "exact-positive-sum-or-Take-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem coincidenceCriterion (value : Coincidence) : SFT.Host.Text.equal (coincidenceName value) "structural-EmptyOne-cell-coincidence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-full-cell-potential-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem reverseCriterion (value : Reverse) : SFT.Host.Text.equal (reverseName value) "exact-cell-reversal-preserves-positive-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carriersCriterion, referenceCriterion, conditionCriterion, pathCriterion, compositionCriterion, coincidenceCriterion, recordCriterion, reverseCriterion]
  cases c with
  | mk carriers reference condition path composition coincidence record reverse =>
    cases carriers <;> cases reference <;> cases condition <;> cases path <;> cases composition <;> cases coincidence <;> cases record <;> cases reverse
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carriers = .admitted ∧ c.reference = .admitted ∧ c.condition = .admitted ∧ c.path = .admitted ∧ c.composition = .admitted ∧ c.coincidence = .admitted ∧ c.record = .admitted ∧ c.reverse = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carriers reference condition path composition coincidence record reverse =>
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

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem condition_rejected_rejected (c : Candidate) (h : c.condition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.condition eq
    rw [h] at field
    cases field

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

theorem coincidence_rejected_rejected (c : Candidate) (h : c.coincidence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coincidence eq
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

theorem reverse_rejected_rejected (c : Candidate) (h : c.reverse = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reverse eq
    rw [h] at field
    cases field

end SFT.Chemistry.CellPotentialCompositionGrammar
