import SFT.InformationScience.EncodingWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.EncodingGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "partial-source"
  | .admitted => "complete-canonical-source"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "free-code-token"
  | .admitted => "generated-code-support"

inductive Coverage where
  | rejected | admitted

def coverageName : Coverage → String
  | .rejected => "partial-map"
  | .admitted => "total-source-map"

inductive Image where
  | rejected | admitted

def imageName : Image → String
  | .rejected => "unheld-multiple-images"
  | .admitted => "single-retained-codeword"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "source-code-link-erased"
  | .admitted => "complete-source-code-relation"

inductive Decoder where
  | rejected | admitted

def decoderName : Decoder → String
  | .rejected => "guessed-preimage"
  | .admitted => "singleton-class-left-inverse"

inductive Loss where
  | rejected | admitted

def lossName : Loss → String
  | .rejected => "silent-loss"
  | .admitted => "declared-closed-source-classes"

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "presentation-concatenation"
  | .admitted => "complete-interface-map"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-codebooks"
  | .admitted => "source-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-code-convention"
  | .admitted => "no-extra-code-convention"

structure Candidate where
  source : Source
  support : Support
  coverage : Coverage
  image : Image
  provenance : Provenance
  decoder : Decoder
  loss : Loss
  composition : Composition
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [sourceName c.source, supportName c.support, coverageName c.coverage, imageName c.image, provenanceName c.provenance, decoderName c.decoder, lossName c.loss, compositionName c.composition, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "coverage=" (coverageName c.coverage), SFT.Host.Text.append "image=" (imageName c.image), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "decoder=" (decoderName c.decoder), SFT.Host.Text.append "loss=" (lossName c.loss), SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-source__generated-code-support__total-source-map__single-retained-codeword__complete-source-code-relation__singleton-class-left-inverse__declared-closed-source-classes__complete-interface-map__source-successor__no-extra-code-convention"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sourceName c.source) "complete-canonical-source" &&
  SFT.Host.Text.equal (supportName c.support) "generated-code-support" &&
  SFT.Host.Text.equal (coverageName c.coverage) "total-source-map" &&
  SFT.Host.Text.equal (imageName c.image) "single-retained-codeword" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "complete-source-code-relation" &&
  SFT.Host.Text.equal (decoderName c.decoder) "singleton-class-left-inverse" &&
  SFT.Host.Text.equal (lossName c.loss) "declared-closed-source-classes" &&
  SFT.Host.Text.equal (compositionName c.composition) "complete-interface-map" &&
  SFT.Host.Text.equal (generalityName c.generality) "source-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-code-convention"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (sourceName c.source) "complete-canonical-source") then "An omitted source symbol has no representation row." else
  if !(SFT.Host.Text.equal (supportName c.support) "generated-code-support") then "A free token has no generated Fold-word provenance." else
  if !(SFT.Host.Text.equal (coverageName c.coverage) "total-source-map") then "A partial map leaves at least one source without a codeword." else
  if !(SFT.Host.Text.equal (imageName c.image) "single-retained-codeword") then "Multiple images do not identify the codeword actually retained." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "complete-source-code-relation") then "Erasing links prevents reconstruction of source classes." else
  if !(SFT.Host.Text.equal (decoderName c.decoder) "singleton-class-left-inverse") then "A used codeword can have several source predecessors." else
  if !(SFT.Host.Text.equal (lossName c.loss) "declared-closed-source-classes") then "Silent merging falsely claims unavailable distinctions remain." else
  if !(SFT.Host.Text.equal (compositionName c.composition) "complete-interface-map") then "Concatenation can join unequal code interfaces." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "source-successor") then "Examples do not establish a fresh source row." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-code-convention") then "A borrowed numeral or lexical convention can select the code." else
  "The encoding kernel is complete source and generated code support with a total single-valued provenance relation, singleton-class left-inverse decoding, explicit loss classes, exact composition and no borrowed code."

def generationRule : String := "Generate the complete product of source coverage, code support, encoding totality, single-valuedness, provenance, decoder law, exact/lossy status, composition, finite generality and extra-code status."
def grammarBoundary : String := "All finite representations generated from complete canonical source alphabets, generated Fold codewords, total maps, inverse relations, retained source classes and exact interface composition."

def candidates : List Candidate :=
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Coverage.rejected,Coverage.admitted]).flatMap fun coverage =>
  ([Image.rejected,Image.admitted]).flatMap fun image =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Decoder.rejected,Decoder.admitted]).flatMap fun decoder =>
  ([Loss.rejected,Loss.admitted]).flatMap fun loss =>
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨source,support,coverage,image,provenance,decoder,loss,composition,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk source support coverage image provenance decoder loss composition generality addition =>
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoverage : coverage ∈ [Coverage.rejected,Coverage.admitted] := by
      cases coverage <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have himage : image ∈ [Image.rejected,Image.admitted] := by
      cases image <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecoder : decoder ∈ [Decoder.rejected,Decoder.admitted] := by
      cases decoder <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hloss : loss ∈ [Loss.rejected,Loss.admitted] := by
      cases loss <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ coverage _ hcoverage
    apply CommonRefinement.memFlatMap _ _ image _ himage
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    apply CommonRefinement.memFlatMap _ _ decoder _ hdecoder
    apply CommonRefinement.memFlatMap _ _ loss _ hloss
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk source support coverage image provenance decoder loss composition generality addition =>
    cases source <;> cases support <;> cases coverage <;> cases image <;> cases provenance <;> cases decoder <;> cases loss <;> cases composition <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk source support coverage image provenance decoder loss composition generality addition =>
    cases source <;> cases support <;> cases coverage <;> cases image <;> cases provenance <;> cases decoder <;> cases loss <;> cases composition <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.source = .admitted ∧ c.support = .admitted ∧ c.coverage = .admitted ∧ c.image = .admitted ∧ c.provenance = .admitted ∧ c.decoder = .admitted ∧ c.loss = .admitted ∧ c.composition = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk source support coverage image provenance decoder loss composition generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8,h9⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8; cases h9
      rfl

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
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

theorem coverage_rejected_rejected (c : Candidate) (h : c.coverage = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coverage eq
    rw [h] at field
    cases field

theorem image_rejected_rejected (c : Candidate) (h : c.image = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.image eq
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

theorem decoder_rejected_rejected (c : Candidate) (h : c.decoder = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decoder eq
    rw [h] at field
    cases field

theorem loss_rejected_rejected (c : Candidate) (h : c.loss = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.loss eq
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

end SFT.InformationScience.EncodingGrammar
