import SFT.InformationScience.CompressionWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.CompressionGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Message where
  | rejected | admitted

def messageName : Message → String
  | .rejected => "partial-message"
  | .admitted => "complete-canonical-message"

inductive Description where
  | rejected | admitted

def descriptionName : Description → String
  | .rejected => "opaque-short-string"
  | .admitted => "dictionary-and-token-trace"

inductive Reconstruction where
  | rejected | admitted

def reconstructionName : Reconstruction → String
  | .rejected => "similar-output"
  | .admitted => "exact-decoder-equality"

inductive Parsing where
  | rejected | admitted

def parsingName : Parsing → String
  | .rejected => "ambiguous-concatenation"
  | .admitted => "prefix-or-delimiter-witness"

inductive Redundancy where
  | rejected | admitted

def redundancyName : Redundancy → String
  | .rejected => "frequency-assumption"
  | .admitted => "reconstructible-occurrence-trace"

inductive Resources where
  | rejected | admitted

def resourcesName : Resources → String
  | .rejected => "payload-only"
  | .admitted => "complete-description-resource"

inductive Shortening where
  | rejected | admitted

def shorteningName : Shortening → String
  | .rejected => "universal-shortening-claim"
  | .admitted => "pigeonhole-boundary"

inductive Optimization where
  | rejected | admitted

def optimizationName : Optimization → String
  | .rejected => "tuned-score"
  | .admitted => "complete-undominated-descriptions"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-messages"
  | .admitted => "token-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-statistical-model"
  | .admitted => "no-extra-compression-model"

structure Candidate where
  message : Message
  description : Description
  reconstruction : Reconstruction
  parsing : Parsing
  redundancy : Redundancy
  resources : Resources
  shortening : Shortening
  optimization : Optimization
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [messageName c.message, descriptionName c.description, reconstructionName c.reconstruction, parsingName c.parsing, redundancyName c.redundancy, resourcesName c.resources, shorteningName c.shortening, optimizationName c.optimization, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "message=" (messageName c.message), SFT.Host.Text.append "description=" (descriptionName c.description), SFT.Host.Text.append "reconstruction=" (reconstructionName c.reconstruction), SFT.Host.Text.append "parsing=" (parsingName c.parsing), SFT.Host.Text.append "redundancy=" (redundancyName c.redundancy), SFT.Host.Text.append "resources=" (resourcesName c.resources), SFT.Host.Text.append "shortening=" (shorteningName c.shortening), SFT.Host.Text.append "optimization=" (optimizationName c.optimization), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-message__dictionary-and-token-trace__exact-decoder-equality__prefix-or-delimiter-witness__reconstructible-occurrence-trace__complete-description-resource__pigeonhole-boundary__complete-undominated-descriptions__token-successor__no-extra-compression-model"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (messageName c.message) "complete-canonical-message" &&
  SFT.Host.Text.equal (descriptionName c.description) "dictionary-and-token-trace" &&
  SFT.Host.Text.equal (reconstructionName c.reconstruction) "exact-decoder-equality" &&
  SFT.Host.Text.equal (parsingName c.parsing) "prefix-or-delimiter-witness" &&
  SFT.Host.Text.equal (redundancyName c.redundancy) "reconstructible-occurrence-trace" &&
  SFT.Host.Text.equal (resourcesName c.resources) "complete-description-resource" &&
  SFT.Host.Text.equal (shorteningName c.shortening) "pigeonhole-boundary" &&
  SFT.Host.Text.equal (optimizationName c.optimization) "complete-undominated-descriptions" &&
  SFT.Host.Text.equal (generalityName c.generality) "token-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-compression-model"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (messageName c.message) "complete-canonical-message") then "An omitted occurrence changes the reconstruction target." else
  if !(SFT.Host.Text.equal (descriptionName c.description) "dictionary-and-token-trace") then "A short string without dictionary provenance cannot reconstruct the source." else
  if !(SFT.Host.Text.equal (reconstructionName c.reconstruction) "exact-decoder-equality") then "Similarity does not establish exact source identity." else
  if !(SFT.Host.Text.equal (parsingName c.parsing) "prefix-or-delimiter-witness") then "One stream may admit several codeword parses." else
  if !(SFT.Host.Text.equal (redundancyName c.redundancy) "reconstructible-occurrence-trace") then "Frequency alone does not prove reconstruction." else
  if !(SFT.Host.Text.equal (resourcesName c.resources) "complete-description-resource") then "Ignoring a dictionary or decoder hides required information." else
  if !(SFT.Host.Text.equal (shorteningName c.shortening) "pigeonhole-boundary") then "Strictly shorter support has fewer generated nonempty codewords than complete fixed support." else
  if !(SFT.Host.Text.equal (optimizationName c.optimization) "complete-undominated-descriptions") then "A floating objective or tie rule is unforced." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "token-successor") then "Examples do not establish a fresh repeated token." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-compression-model") then "A learned or fitted model can select the representation." else
  "The compression kernel is exact message reconstruction from a uniquely parseable dictionary/token description, complete resource accounting, reconstructible redundancy, pigeonhole-limited shortening and no fitted model."

def generationRule : String := "Generate the complete product of message coverage, description provenance, exact reconstruction, parsing, redundancy witness, resource accounting, shortening status, optimization, generality and extra-compressor status."
def grammarBoundary : String := "All finite lossless descriptions generated from canonical messages, retained dictionaries, token traces, exact decoders, unique parsing witnesses and complete positive resource traces."

def candidates : List Candidate :=
  ([Message.rejected,Message.admitted]).flatMap fun message =>
  ([Description.rejected,Description.admitted]).flatMap fun description =>
  ([Reconstruction.rejected,Reconstruction.admitted]).flatMap fun reconstruction =>
  ([Parsing.rejected,Parsing.admitted]).flatMap fun parsing =>
  ([Redundancy.rejected,Redundancy.admitted]).flatMap fun redundancy =>
  ([Resources.rejected,Resources.admitted]).flatMap fun resources =>
  ([Shortening.rejected,Shortening.admitted]).flatMap fun shortening =>
  ([Optimization.rejected,Optimization.admitted]).flatMap fun optimization =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨message,description,reconstruction,parsing,redundancy,resources,shortening,optimization,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk message description reconstruction parsing redundancy resources shortening optimization generality addition =>
    have hmessage : message ∈ [Message.rejected,Message.admitted] := by
      cases message <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdescription : description ∈ [Description.rejected,Description.admitted] := by
      cases description <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreconstruction : reconstruction ∈ [Reconstruction.rejected,Reconstruction.admitted] := by
      cases reconstruction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hparsing : parsing ∈ [Parsing.rejected,Parsing.admitted] := by
      cases parsing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hredundancy : redundancy ∈ [Redundancy.rejected,Redundancy.admitted] := by
      cases redundancy <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hresources : resources ∈ [Resources.rejected,Resources.admitted] := by
      cases resources <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hshortening : shortening ∈ [Shortening.rejected,Shortening.admitted] := by
      cases shortening <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoptimization : optimization ∈ [Optimization.rejected,Optimization.admitted] := by
      cases optimization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ message _ hmessage
    apply CommonRefinement.memFlatMap _ _ description _ hdescription
    apply CommonRefinement.memFlatMap _ _ reconstruction _ hreconstruction
    apply CommonRefinement.memFlatMap _ _ parsing _ hparsing
    apply CommonRefinement.memFlatMap _ _ redundancy _ hredundancy
    apply CommonRefinement.memFlatMap _ _ resources _ hresources
    apply CommonRefinement.memFlatMap _ _ shortening _ hshortening
    apply CommonRefinement.memFlatMap _ _ optimization _ hoptimization
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk message description reconstruction parsing redundancy resources shortening optimization generality addition =>
    cases message <;> cases description <;> cases reconstruction <;> cases parsing <;> cases redundancy <;> cases resources <;> cases shortening <;> cases optimization <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk message description reconstruction parsing redundancy resources shortening optimization generality addition =>
    cases message <;> cases description <;> cases reconstruction <;> cases parsing <;> cases redundancy <;> cases resources <;> cases shortening <;> cases optimization <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.message = .admitted ∧ c.description = .admitted ∧ c.reconstruction = .admitted ∧ c.parsing = .admitted ∧ c.redundancy = .admitted ∧ c.resources = .admitted ∧ c.shortening = .admitted ∧ c.optimization = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk message description reconstruction parsing redundancy resources shortening optimization generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem message_rejected_rejected (c : Candidate) (h : c.message = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.message eq
    rw [h] at field
    cases field

theorem description_rejected_rejected (c : Candidate) (h : c.description = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.description eq
    rw [h] at field
    cases field

theorem reconstruction_rejected_rejected (c : Candidate) (h : c.reconstruction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reconstruction eq
    rw [h] at field
    cases field

theorem parsing_rejected_rejected (c : Candidate) (h : c.parsing = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.parsing eq
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

theorem resources_rejected_rejected (c : Candidate) (h : c.resources = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.resources eq
    rw [h] at field
    cases field

theorem shortening_rejected_rejected (c : Candidate) (h : c.shortening = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.shortening eq
    rw [h] at field
    cases field

theorem optimization_rejected_rejected (c : Candidate) (h : c.optimization = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.optimization eq
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

end SFT.InformationScience.CompressionGrammar
