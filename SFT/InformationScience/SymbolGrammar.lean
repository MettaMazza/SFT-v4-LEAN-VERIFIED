import SFT.InformationScience.SymbolWitnesses
import SFT.Foundation.CommonRefinement
namespace SFT.InformationScience.SymbolGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Alphabet where
  | rejected | admitted

def alphabetName : Alphabet → String
  | .rejected => "partial-or-duplicated-alphabet"
  | .admitted => "complete-canonical-alphabet"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "presentation-token"
  | .admitted => "canonical-form-identity"

inductive Label where
  | rejected | admitted

def labelName : Label → String
  | .rejected => "unlabelled-form"
  | .admitted => "retained-held-label"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "partial-observation"
  | .admitted => "total-source-bound-observation"

inductive Image where
  | rejected | admitted

def imageName : Image → String
  | .rejected => "multivalued-image"
  | .admitted => "single-retained-image"

inductive Distinction where
  | rejected | admitted

def distinctionName : Distinction → String
  | .rejected => "assumed-or-visual-difference"
  | .admitted => "different-observation-labels"

inductive Closure where
  | rejected | admitted

def closureName : Closure → String
  | .rejected => "source-identity-erased"
  | .admitted => "closed-class-with-microforms"

inductive Generality where
  | rejected | admitted

def generalityName : Generality → String
  | .rejected => "sampled-alphabets"
  | .admitted => "alphabet-successor"

inductive Addition where
  | rejected | admitted

def additionName : Addition → String
  | .rejected => "extra-symbol-semantics"
  | .admitted => "no-extra-symbol-semantics"

structure Candidate where
  alphabet : Alphabet
  identity : Identity
  label : Label
  observation : Observation
  image : Image
  distinction : Distinction
  closure : Closure
  generality : Generality
  addition : Addition

def sourceFields (c : Candidate) : List String := [alphabetName c.alphabet, identityName c.identity, labelName c.label, observationName c.observation, imageName c.image, distinctionName c.distinction, closureName c.closure, generalityName c.generality, additionName c.addition]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "alphabet=" (alphabetName c.alphabet), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "label=" (labelName c.label), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "image=" (imageName c.image), SFT.Host.Text.append "distinction=" (distinctionName c.distinction), SFT.Host.Text.append "closure=" (closureName c.closure), SFT.Host.Text.append "generality=" (generalityName c.generality), SFT.Host.Text.append "addition=" (additionName c.addition)]
def survivorId : String := "complete-canonical-alphabet__canonical-form-identity__retained-held-label__total-source-bound-observation__single-retained-image__different-observation-labels__closed-class-with-microforms__alphabet-successor__no-extra-symbol-semantics"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (alphabetName c.alphabet) "complete-canonical-alphabet" &&
  SFT.Host.Text.equal (identityName c.identity) "canonical-form-identity" &&
  SFT.Host.Text.equal (labelName c.label) "retained-held-label" &&
  SFT.Host.Text.equal (observationName c.observation) "total-source-bound-observation" &&
  SFT.Host.Text.equal (imageName c.image) "single-retained-image" &&
  SFT.Host.Text.equal (distinctionName c.distinction) "different-observation-labels" &&
  SFT.Host.Text.equal (closureName c.closure) "closed-class-with-microforms" &&
  SFT.Host.Text.equal (generalityName c.generality) "alphabet-successor" &&
  SFT.Host.Text.equal (additionName c.addition) "no-extra-symbol-semantics"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (alphabetName c.alphabet) "complete-canonical-alphabet") then "Omission or duplication changes the possible symbol family." else
  if !(SFT.Host.Text.equal (identityName c.identity) "canonical-form-identity") then "A presentation token may alias distinct generated forms." else
  if !(SFT.Host.Text.equal (labelName c.label) "retained-held-label") then "Without a retained label the selected fibre identity is unavailable." else
  if !(SFT.Host.Text.equal (observationName c.observation) "total-source-bound-observation") then "A missing symbol has no declared observation class." else
  if !(SFT.Host.Text.equal (imageName c.image) "single-retained-image") then "Multiple unheld images do not identify the observation made." else
  if !(SFT.Host.Text.equal (distinctionName c.distinction) "different-observation-labels") then "Presentation difference does not establish retained observational separation." else
  if !(SFT.Host.Text.equal (closureName c.closure) "closed-class-with-microforms") then "Erasing sources prevents an exact account of closed distinctions." else
  if !(SFT.Host.Text.equal (generalityName c.generality) "alphabet-successor") then "Examples do not establish extension to a fresh symbol." else
  if !(SFT.Host.Text.equal (additionName c.addition) "no-extra-symbol-semantics") then "Imported meaning or frequency is not supplied by form and observation." else
  "The symbol kernel is a complete canonical held-labelled alphabet, total single-valued observation, exact different-image distinguishability, retained closed classes, successor generality and no imported semantics."

def generationRule : String := "Generate the complete product of alphabet coverage, symbol identity, held label, observation coverage, observation single-valuedness, distinction rule, closed-class retention, finite generality and extra-symbol status."
def grammarBoundary : String := "All finite symbol systems generated from canonical Fold forms, held labels, complete alphabets, total observation relations and exact retained/closed pair ledgers."

def candidates : List Candidate :=
  ([Alphabet.rejected,Alphabet.admitted]).flatMap fun alphabet =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Label.rejected,Label.admitted]).flatMap fun label =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Image.rejected,Image.admitted]).flatMap fun image =>
  ([Distinction.rejected,Distinction.admitted]).flatMap fun distinction =>
  ([Closure.rejected,Closure.admitted]).flatMap fun closure =>
  ([Generality.rejected,Generality.admitted]).flatMap fun generality =>
  ([Addition.rejected,Addition.admitted]).map fun addition =>
  ⟨alphabet,identity,label,observation,image,distinction,closure,generality,addition⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 512 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk alphabet identity label observation image distinction closure generality addition =>
    have halphabet : alphabet ∈ [Alphabet.rejected,Alphabet.admitted] := by
      cases alphabet <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hlabel : label ∈ [Label.rejected,Label.admitted] := by
      cases label <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have himage : image ∈ [Image.rejected,Image.admitted] := by
      cases image <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdistinction : distinction ∈ [Distinction.rejected,Distinction.admitted] := by
      cases distinction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hclosure : closure ∈ [Closure.rejected,Closure.admitted] := by
      cases closure <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgenerality : generality ∈ [Generality.rejected,Generality.admitted] := by
      cases generality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have haddition : addition ∈ [Addition.rejected,Addition.admitted] := by
      cases addition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ alphabet _ halphabet
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ label _ hlabel
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    apply CommonRefinement.memFlatMap _ _ image _ himage
    apply CommonRefinement.memFlatMap _ _ distinction _ hdistinction
    apply CommonRefinement.memFlatMap _ _ closure _ hclosure
    apply CommonRefinement.memFlatMap _ _ generality _ hgenerality
    exact Count.TraceDerivation.memMap _ addition _ haddition

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk alphabet identity label observation image distinction closure generality addition =>
    cases alphabet <;> cases identity <;> cases label <;> cases observation <;> cases image <;> cases distinction <;> cases closure <;> cases generality <;> cases addition
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk alphabet identity label observation image distinction closure generality addition =>
    cases alphabet <;> cases identity <;> cases label <;> cases observation <;> cases image <;> cases distinction <;> cases closure <;> cases generality <;> cases addition
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.alphabet = .admitted ∧ c.identity = .admitted ∧ c.label = .admitted ∧ c.observation = .admitted ∧ c.image = .admitted ∧ c.distinction = .admitted ∧ c.closure = .admitted ∧ c.generality = .admitted ∧ c.addition = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk alphabet identity label observation image distinction closure generality addition =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7,h8⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7; cases h8
      rfl

theorem alphabet_rejected_rejected (c : Candidate) (h : c.alphabet = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.alphabet eq
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

theorem label_rejected_rejected (c : Candidate) (h : c.label = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.label eq
    rw [h] at field
    cases field

theorem observation_rejected_rejected (c : Candidate) (h : c.observation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.observation eq
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

theorem distinction_rejected_rejected (c : Candidate) (h : c.distinction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.distinction eq
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

end SFT.InformationScience.SymbolGrammar
