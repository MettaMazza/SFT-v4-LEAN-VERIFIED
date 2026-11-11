import SFT.Chemistry.FormulaComposition
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.FormulaGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Domain where
  | rejected | admitted

def domainName : Domain → String
  | .rejected => "unbounded-object-label"
  | .admitted => "discrete-molecule-domain"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "name-only-string"
  | .admitted => "formula-encoding"

inductive Constituents where
  | rejected | admitted

def constituentsName : Constituents → String
  | .rejected => "anonymous-symbols"
  | .admitted => "held-entity-symbols"

inductive Multiplicity where
  | rejected | admitted

def multiplicityName : Multiplicity → String
  | .rejected => "unrecorded-repetition"
  | .admitted => "exact-positive-multiplicity"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "mass-unrelated-to-composition"
  | .admitted => "composition-mass-correspondence"

inductive Structure where
  | rejected | admitted

def structureName : Structure → String
  | .rejected => "order-erased"
  | .admitted => "structure-correspondence"

inductive Decode where
  | rejected | admitted

def decodeName : Decode → String
  | .rejected => "nondecodable-inscription"
  | .admitted => "composition-decodable"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-formula-exception"
  | .admitted => "no-extra-rule"

structure Candidate where
  domain : Domain
  carrier : Carrier
  constituents : Constituents
  multiplicity : Multiplicity
  mass : Mass
  «structure» : Structure
  decode : Decode
  extension : Extension

def sourceFields (c : Candidate) : List String := [domainName c.domain, carrierName c.carrier, constituentsName c.constituents, multiplicityName c.multiplicity, massName c.mass, structureName c.«structure», decodeName c.decode, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "domain=" (domainName c.domain), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "constituents=" (constituentsName c.constituents), SFT.Host.Text.append "multiplicity=" (multiplicityName c.multiplicity), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "structure=" (structureName c.«structure»), SFT.Host.Text.append "decode=" (decodeName c.decode), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "discrete-molecule-domain__formula-encoding__held-entity-symbols__exact-positive-multiplicity__composition-mass-correspondence__structure-correspondence__composition-decodable__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (domainName c.domain) "discrete-molecule-domain" &&
  SFT.Host.Text.equal (carrierName c.carrier) "formula-encoding" &&
  SFT.Host.Text.equal (constituentsName c.constituents) "held-entity-symbols" &&
  SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-multiplicity" &&
  SFT.Host.Text.equal (massName c.mass) "composition-mass-correspondence" &&
  SFT.Host.Text.equal (structureName c.«structure») "structure-correspondence" &&
  SFT.Host.Text.equal (decodeName c.decode) "composition-decodable" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (domainName c.domain) "discrete-molecule-domain") then "A formula without a declared chemical carrier domain can encode unrelated objects." else
  if !(SFT.Host.Text.equal (carrierName c.carrier) "formula-encoding") then "A name alone does not retain exact constituent multiplicity." else
  if !(SFT.Host.Text.equal (constituentsName c.constituents) "held-entity-symbols") then "Anonymous symbols erase chemical-entity identity." else
  if !(SFT.Host.Text.equal (multiplicityName c.multiplicity) "exact-positive-multiplicity") then "Unrecorded repetition cannot reconstruct composition or relative mass." else
  if !(SFT.Host.Text.equal (massName c.mass) "composition-mass-correspondence") then "A mass label not reconstructed from the constituent record is not a formula consequence." else
  if !(SFT.Host.Text.equal (structureName c.«structure») "structure-correspondence") then "Equal counts can represent distinct molecular structures." else
  if !(SFT.Host.Text.equal (decodeName c.decode) "composition-decodable") then "An inscription that cannot return its constituent record is not an exact encoding." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary exception can manufacture a desired formula." else
  "discrete-molecule-domain__formula-encoding__composition-mass-correspondence__structure-correspondence"

def generationRule : String := "Generate the literal product of the registered formula domain, carrier, constituents, multiplicity, mass, structure, decoding and extension choices."
def grammarBoundary : String := "Every positive-finite discrete-molecule composition word generated from admitted entity labels, exact multiplicities and a held structural-order record."

def candidates : List Candidate :=
  ([Domain.rejected,Domain.admitted]).flatMap fun domain =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Constituents.rejected,Constituents.admitted]).flatMap fun constituents =>
  ([Multiplicity.rejected,Multiplicity.admitted]).flatMap fun multiplicity =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Structure.rejected,Structure.admitted]).flatMap fun «structure» =>
  ([Decode.rejected,Decode.admitted]).flatMap fun decode =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨domain,carrier,constituents,multiplicity,mass,«structure»,decode,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk domain carrier constituents multiplicity mass «structure» decode extension =>
    have hdomain : domain ∈ [Domain.rejected,Domain.admitted] := by
      cases domain <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstituents : constituents ∈ [Constituents.rejected,Constituents.admitted] := by
      cases constituents <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmultiplicity : multiplicity ∈ [Multiplicity.rejected,Multiplicity.admitted] := by
      cases multiplicity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstructure : «structure» ∈ [Structure.rejected,Structure.admitted] := by
      cases «structure» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecode : decode ∈ [Decode.rejected,Decode.admitted] := by
      cases decode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ domain _ hdomain
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ constituents _ hconstituents
    apply CommonRefinement.memFlatMap _ _ multiplicity _ hmultiplicity
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ «structure» _ hstructure
    apply CommonRefinement.memFlatMap _ _ decode _ hdecode
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk domain carrier constituents multiplicity mass «structure» decode extension =>
    cases domain <;> cases carrier <;> cases constituents <;> cases multiplicity <;> cases mass <;> cases «structure» <;> cases decode <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk domain carrier constituents multiplicity mass «structure» decode extension =>
    cases domain <;> cases carrier <;> cases constituents <;> cases multiplicity <;> cases mass <;> cases «structure» <;> cases decode <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.domain = .admitted ∧ c.carrier = .admitted ∧ c.constituents = .admitted ∧ c.multiplicity = .admitted ∧ c.mass = .admitted ∧ c.«structure» = .admitted ∧ c.decode = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk domain carrier constituents multiplicity mass «structure» decode extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem domain_rejected_rejected (c : Candidate) (h : c.domain = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.domain eq
    rw [h] at field
    cases field

theorem carrier_rejected_rejected (c : Candidate) (h : c.carrier = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.carrier eq
    rw [h] at field
    cases field

theorem constituents_rejected_rejected (c : Candidate) (h : c.constituents = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.constituents eq
    rw [h] at field
    cases field

theorem multiplicity_rejected_rejected (c : Candidate) (h : c.multiplicity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.multiplicity eq
    rw [h] at field
    cases field

theorem mass_rejected_rejected (c : Candidate) (h : c.mass = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.mass eq
    rw [h] at field
    cases field

theorem structure_rejected_rejected (c : Candidate) (h : c.«structure» = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.«structure» eq
    rw [h] at field
    cases field

theorem decode_rejected_rejected (c : Candidate) (h : c.decode = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decode eq
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

end SFT.Chemistry.FormulaGrammar
