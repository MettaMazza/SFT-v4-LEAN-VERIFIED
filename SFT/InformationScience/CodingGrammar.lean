import SFT.InformationScience.CodingWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.CodingGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "partial-word-support"
  | .admitted => "complete-generated-word-support"

inductive Codebook where
  | rejected | admitted

def codebookName : Codebook → String
  | .rejected => "free-valid-list"
  | .admitted => "held-support-selection"

inductive Encoding where
  | rejected | admitted

def encodingName : Encoding → String
  | .rejected => "implicit-assignment"
  | .admitted => "total-source-code-relation"

inductive Positions where
  | rejected | admitted

def positionsName : Positions → String
  | .rejected => "unequal-or-unlabelled-positions"
  | .admitted => "common-canonical-position-trace"

inductive Difference where
  | rejected | admitted

def differenceName : Difference → String
  | .rejected => "scalar-distance"
  | .admitted => "complete-difference-trace"

inductive Errors where
  | rejected | admitted

def errorsName : Errors → String
  | .rejected => "sampled-error-outputs"
  | .admitted => "complete-registered-error-images"

inductive Detection where
  | rejected | admitted

def detectionName : Detection → String
  | .rejected => "likely-corruption"
  | .admitted => "noncodeword-image"

inductive Correction where
  | rejected | admitted

def correctionName : Correction → String
  | .rejected => "nearest-codeword"
  | .admitted => "disjoint-error-image-support"

inductive Redundancy where
  | rejected | admitted

def redundancyName : Redundancy → String
  | .rejected => "unaccounted-padding"
  | .admitted => "separation-forcing-positions"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "fixed-mask-example"
  | .admitted => "error-action-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-distance-or-rate-rule"
  | .admitted => "no-extra-coding-rule"

structure Candidate where
  support : Support
  codebook : Codebook
  encoding : Encoding
  positions : Positions
  difference : Difference
  errors : Errors
  detection : Detection
  correction : Correction
  redundancy : Redundancy
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [supportName c.support, codebookName c.codebook, encodingName c.encoding, positionsName c.positions, differenceName c.difference, errorsName c.errors, detectionName c.detection, correctionName c.correction, redundancyName c.redundancy, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "codebook=" (codebookName c.codebook), SFT.Host.Text.append "encoding=" (encodingName c.encoding), SFT.Host.Text.append "positions=" (positionsName c.positions), SFT.Host.Text.append "difference=" (differenceName c.difference), SFT.Host.Text.append "errors=" (errorsName c.errors), SFT.Host.Text.append "detection=" (detectionName c.detection), SFT.Host.Text.append "correction=" (correctionName c.correction), SFT.Host.Text.append "redundancy=" (redundancyName c.redundancy), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-generated-word-support__held-support-selection__total-source-code-relation__common-canonical-position-trace__complete-difference-trace__complete-registered-error-images__noncodeword-image__disjoint-error-image-support__separation-forcing-positions__error-action-successor__no-extra-coding-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (supportName c.support) "complete-generated-word-support" &&
  SFT.Host.Text.equal (codebookName c.codebook) "held-support-selection" &&
  SFT.Host.Text.equal (encodingName c.encoding) "total-source-code-relation" &&
  SFT.Host.Text.equal (positionsName c.positions) "common-canonical-position-trace" &&
  SFT.Host.Text.equal (differenceName c.difference) "complete-difference-trace" &&
  SFT.Host.Text.equal (errorsName c.errors) "complete-registered-error-images" &&
  SFT.Host.Text.equal (detectionName c.detection) "noncodeword-image" &&
  SFT.Host.Text.equal (correctionName c.correction) "disjoint-error-image-support" &&
  SFT.Host.Text.equal (redundancyName c.redundancy) "separation-forcing-positions" &&
  SFT.Host.Text.equal (generalityName c.generality) "error-action-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-coding-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (supportName c.support) "complete-generated-word-support") then "Omission hides possible code or error images." else
  if !(SFT.Host.Text.equal (codebookName c.codebook) "held-support-selection") then "A free list lacks a complete source support boundary." else
  if !(SFT.Host.Text.equal (encodingName c.encoding) "total-source-code-relation") then "An implicit assignment erases source provenance." else
  if !(SFT.Host.Text.equal (positionsName c.positions) "common-canonical-position-trace") then "Position changes cannot be located on unequal or anonymous carriers." else
  if !(SFT.Host.Text.equal (differenceName c.difference) "complete-difference-trace") then "A scalar erases which positions and labels differ." else
  if !(SFT.Host.Text.equal (errorsName c.errors) "complete-registered-error-images") then "Sampling cannot prove image supports disjoint." else
  if !(SFT.Host.Text.equal (detectionName c.detection) "noncodeword-image") then "Likelihood imports a prior and threshold." else
  if !(SFT.Host.Text.equal (correctionName c.correction) "disjoint-error-image-support") then "A metric can tie and is not structurally supplied." else
  if !(SFT.Host.Text.equal (redundancyName c.redundancy) "separation-forcing-positions") then "Padding without a correction witness is an unforced addition." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "error-action-successor") then "One mask does not establish all registered actions." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-coding-rule") then "A borrowed metric or asymptotic rate can select the code." else
  "The coding kernel is complete word support, held codebook and source map, common positions, exact differences, complete registered error images, structural detection, disjoint-support correction and witnessed redundancy."

def generationRule : String := "Generate the complete product of word support, codebook selection, source encoding, position identity, difference trace, error-family coverage, detection, correction, redundancy witness, generality and extra-code status."
def grammarBoundary : String := "All finite codes generated from complete held-label word support, held codebooks, exact source maps, common position carriers, registered error actions and complete error-image families."

def candidates : List Candidate :=
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Codebook.rejected,Codebook.admitted]).flatMap fun codebook =>
  ([Encoding.rejected,Encoding.admitted]).flatMap fun encoding =>
  ([Positions.rejected,Positions.admitted]).flatMap fun positions =>
  ([Difference.rejected,Difference.admitted]).flatMap fun difference =>
  ([Errors.rejected,Errors.admitted]).flatMap fun errors =>
  ([Detection.rejected,Detection.admitted]).flatMap fun detection =>
  ([Correction.rejected,Correction.admitted]).flatMap fun correction =>
  ([Redundancy.rejected,Redundancy.admitted]).flatMap fun redundancy =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨support,codebook,encoding,positions,difference,errors,detection,correction,redundancy,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk support codebook encoding positions difference errors detection correction redundancy generality addition =>
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcodebook : codebook ∈ [Codebook.rejected,Codebook.admitted] := by
      cases codebook <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hencoding : encoding ∈ [Encoding.rejected,Encoding.admitted] := by
      cases encoding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpositions : positions ∈ [Positions.rejected,Positions.admitted] := by
      cases positions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdifference : difference ∈ [Difference.rejected,Difference.admitted] := by
      cases difference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have herrors : errors ∈ [Errors.rejected,Errors.admitted] := by
      cases errors <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdetection : detection ∈ [Detection.rejected,Detection.admitted] := by
      cases detection <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrection : correction ∈ [Correction.rejected,Correction.admitted] := by
      cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hredundancy : redundancy ∈ [Redundancy.rejected,Redundancy.admitted] := by
      cases redundancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ codebook _ hcodebook
    apply CommonRefinement.memFlatMap _ _ encoding _ hencoding
    apply CommonRefinement.memFlatMap _ _ positions _ hpositions
    apply CommonRefinement.memFlatMap _ _ difference _ hdifference
    apply CommonRefinement.memFlatMap _ _ errors _ herrors
    apply CommonRefinement.memFlatMap _ _ detection _ hdetection
    apply CommonRefinement.memFlatMap _ _ correction _ hcorrection
    apply CommonRefinement.memFlatMap _ _ redundancy _ hredundancy
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk support codebook encoding positions difference errors detection correction redundancy generality addition =>
    cases support <;> cases codebook <;> cases encoding <;> cases positions <;> cases difference <;> cases errors <;> cases detection <;> cases correction <;> cases redundancy <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk support codebook encoding positions difference errors detection correction redundancy generality addition =>
    cases support <;> cases codebook <;> cases encoding <;> cases positions <;> cases difference <;> cases errors <;> cases detection <;> cases correction <;> cases redundancy <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.support = .admitted ∧ c.codebook = .admitted ∧ c.encoding = .admitted ∧ c.positions = .admitted ∧ c.difference = .admitted ∧ c.errors = .admitted ∧ c.detection = .admitted ∧ c.correction = .admitted ∧ c.redundancy = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk support codebook encoding positions difference errors detection correction redundancy generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9,h10⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9; cases h10
      rfl

theorem support_rejected_rejected (c : Candidate) (h : c.support = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.support eq
    rw [h] at field
    cases field

theorem codebook_rejected_rejected (c : Candidate) (h : c.codebook = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.codebook eq
    rw [h] at field
    cases field

theorem encoding_rejected_rejected (c : Candidate) (h : c.encoding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.encoding eq
    rw [h] at field
    cases field

theorem positions_rejected_rejected (c : Candidate) (h : c.positions = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.positions eq
    rw [h] at field
    cases field

theorem difference_rejected_rejected (c : Candidate) (h : c.difference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.difference eq
    rw [h] at field
    cases field

theorem errors_rejected_rejected (c : Candidate) (h : c.errors = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.errors eq
    rw [h] at field
    cases field

theorem detection_rejected_rejected (c : Candidate) (h : c.detection = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.detection eq
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

theorem redundancy_rejected_rejected (c : Candidate) (h : c.redundancy = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.redundancy eq
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

theorem addition_rejected_rejected (c : Candidate) (h : c.addition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.addition eq
    rw [h] at field
    cases field

end SFT.InformationScience.CodingGrammar
