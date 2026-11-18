import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.MolecularGraphGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "detached-symbol-string"
  | .admitted => "held-finite-molecular-carrier"

inductive Atoms where
  | rejected | admitted

def atomsName : Atoms → String
  | .rejected => "unlabelled-vertex-count"
  | .admitted => "complete-held-atom-identities"

inductive Bonds where
  | rejected | admitted

def bondsName : Bonds → String
  | .rejected => "adjacency-without-bond-state"
  | .admitted => "complete-held-bond-identities"

inductive Orientation where
  | rejected | admitted

def orientationName : Orientation → String
  | .rejected => "discarded-isotope-charge-stereo"
  | .admitted => "retained-isotope-charge-stereo-fibres"

inductive Canonicality where
  | rejected | admitted

def canonicalityName : Canonicality → String
  | .rejected => "input-order-dependent-word"
  | .admitted => "exhaustive-equivalence-class-canonical-word"

inductive Decoding where
  | rejected | admitted

def decodingName : Decoding → String
  | .rejected => "one-way-text-token"
  | .admitted => "exact-word-to-graph-reconstruction"

inductive Custody where
  | rejected | admitted

def custodyName : Custody → String
  | .rejected => "source-free-identifier"
  | .admitted => "held-source-and-translation-custody"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "renumbered-prior-graph"
  | .admitted => "append-only-new-carrier-registration"

structure Candidate where
  carrier : Carrier
  atoms : Atoms
  bonds : Bonds
  orientation : Orientation
  canonicality : Canonicality
  decoding : Decoding
  custody : Custody
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, atomsName c.atoms, bondsName c.bonds, orientationName c.orientation, canonicalityName c.canonicality, decodingName c.decoding, custodyName c.custody, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "atoms=" (atomsName c.atoms), SFT.Host.Text.append "bonds=" (bondsName c.bonds), SFT.Host.Text.append "orientation=" (orientationName c.orientation), SFT.Host.Text.append "canonicality=" (canonicalityName c.canonicality), SFT.Host.Text.append "decoding=" (decodingName c.decoding), SFT.Host.Text.append "custody=" (custodyName c.custody), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-finite-molecular-carrier__complete-held-atom-identities__complete-held-bond-identities__retained-isotope-charge-stereo-fibres__exhaustive-equivalence-class-canonical-word__exact-word-to-graph-reconstruction__held-source-and-translation-custody__append-only-new-carrier-registration"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "held-finite-molecular-carrier" &&
  SFT.Host.Text.equal (atomsName c.atoms) "complete-held-atom-identities" &&
  SFT.Host.Text.equal (bondsName c.bonds) "complete-held-bond-identities" &&
  SFT.Host.Text.equal (orientationName c.orientation) "retained-isotope-charge-stereo-fibres" &&
  SFT.Host.Text.equal (canonicalityName c.canonicality) "exhaustive-equivalence-class-canonical-word" &&
  SFT.Host.Text.equal (decodingName c.decoding) "exact-word-to-graph-reconstruction" &&
  SFT.Host.Text.equal (custodyName c.custody) "held-source-and-translation-custody" &&
  SFT.Host.Text.equal (extensionName c.extension) "append-only-new-carrier-registration"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "held-finite-molecular-carrier") then "detached-symbol-string closes a distinction required by carrier." else
  if !(SFT.Host.Text.equal (atomsName c.atoms) "complete-held-atom-identities") then "unlabelled-vertex-count closes a distinction required by atoms." else
  if !(SFT.Host.Text.equal (bondsName c.bonds) "complete-held-bond-identities") then "adjacency-without-bond-state closes a distinction required by bonds." else
  if !(SFT.Host.Text.equal (orientationName c.orientation) "retained-isotope-charge-stereo-fibres") then "discarded-isotope-charge-stereo closes a distinction required by orientation." else
  if !(SFT.Host.Text.equal (canonicalityName c.canonicality) "exhaustive-equivalence-class-canonical-word") then "input-order-dependent-word closes a distinction required by canonicality." else
  if !(SFT.Host.Text.equal (decodingName c.decoding) "exact-word-to-graph-reconstruction") then "one-way-text-token closes a distinction required by decoding." else
  if !(SFT.Host.Text.equal (custodyName c.custody) "held-source-and-translation-custody") then "source-free-identifier closes a distinction required by custody." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "append-only-new-carrier-registration") then "renumbered-prior-graph closes a distinction required by extension." else
  "held-finite-molecular-carrier__complete-held-atom-identities__complete-held-bond-identities__retained-isotope-charge-stereo-fibres__exhaustive-equivalence-class-canonical-word__exact-word-to-graph-reconstruction__held-source-and-translation-custody__append-only-new-carrier-registration"

def generationRule : String := "Generate the literal product of the eight frozen COMP-001 chemical-information custody decisions."
def grammarBoundary : String := "Eight binary dimensions exhaust the registered COMP-001 identity, exact-support, equivalence, provenance, falsification and extension forms; 2^8 = 256 generated candidates."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Atoms.rejected,Atoms.admitted]).flatMap fun atoms =>
  ([Bonds.rejected,Bonds.admitted]).flatMap fun bonds =>
  ([Orientation.rejected,Orientation.admitted]).flatMap fun orientation =>
  ([Canonicality.rejected,Canonicality.admitted]).flatMap fun canonicality =>
  ([Decoding.rejected,Decoding.admitted]).flatMap fun decoding =>
  ([Custody.rejected,Custody.admitted]).flatMap fun custody =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,atoms,bonds,orientation,canonicality,decoding,custody,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier atoms bonds orientation canonicality decoding custody extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hatoms : atoms ∈ [Atoms.rejected,Atoms.admitted] := by
      cases atoms <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbonds : bonds ∈ [Bonds.rejected,Bonds.admitted] := by
      cases bonds <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horientation : orientation ∈ [Orientation.rejected,Orientation.admitted] := by
      cases orientation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcanonicality : canonicality ∈ [Canonicality.rejected,Canonicality.admitted] := by
      cases canonicality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdecoding : decoding ∈ [Decoding.rejected,Decoding.admitted] := by
      cases decoding <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcustody : custody ∈ [Custody.rejected,Custody.admitted] := by
      cases custody <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ atoms _ hatoms
    apply CommonRefinement.memFlatMap _ _ bonds _ hbonds
    apply CommonRefinement.memFlatMap _ _ orientation _ horientation
    apply CommonRefinement.memFlatMap _ _ canonicality _ hcanonicality
    apply CommonRefinement.memFlatMap _ _ decoding _ hdecoding
    apply CommonRefinement.memFlatMap _ _ custody _ hcustody
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (canonicality : Canonicality) (decoding : Decoding) (custody : Custody) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,canonicality,decoding,custody,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,canonicality,decoding,custody,extension⟩ := by
 cases canonicality <;> cases decoding <;> cases custody <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier atoms bonds orientation canonicality decoding custody extension =>
  cases carrier <;> cases atoms <;> cases bonds <;> cases orientation
  · exact sourceDecisionBlock0000 canonicality decoding custody extension
  · exact sourceDecisionBlock0001 canonicality decoding custody extension
  · exact sourceDecisionBlock0010 canonicality decoding custody extension
  · exact sourceDecisionBlock0011 canonicality decoding custody extension
  · exact sourceDecisionBlock0100 canonicality decoding custody extension
  · exact sourceDecisionBlock0101 canonicality decoding custody extension
  · exact sourceDecisionBlock0110 canonicality decoding custody extension
  · exact sourceDecisionBlock0111 canonicality decoding custody extension
  · exact sourceDecisionBlock1000 canonicality decoding custody extension
  · exact sourceDecisionBlock1001 canonicality decoding custody extension
  · exact sourceDecisionBlock1010 canonicality decoding custody extension
  · exact sourceDecisionBlock1011 canonicality decoding custody extension
  · exact sourceDecisionBlock1100 canonicality decoding custody extension
  · exact sourceDecisionBlock1101 canonicality decoding custody extension
  · exact sourceDecisionBlock1110 canonicality decoding custody extension
  · exact sourceDecisionBlock1111 canonicality decoding custody extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "held-finite-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem atomsCriterion (value : Atoms) : SFT.Host.Text.equal (atomsName value) "complete-held-atom-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem bondsCriterion (value : Bonds) : SFT.Host.Text.equal (bondsName value) "complete-held-bond-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem orientationCriterion (value : Orientation) : SFT.Host.Text.equal (orientationName value) "retained-isotope-charge-stereo-fibres" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem canonicalityCriterion (value : Canonicality) : SFT.Host.Text.equal (canonicalityName value) "exhaustive-equivalence-class-canonical-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem decodingCriterion (value : Decoding) : SFT.Host.Text.equal (decodingName value) "exact-word-to-graph-reconstruction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem custodyCriterion (value : Custody) : SFT.Host.Text.equal (custodyName value) "held-source-and-translation-custody" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "append-only-new-carrier-registration" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, atomsCriterion, bondsCriterion, orientationCriterion, canonicalityCriterion, decodingCriterion, custodyCriterion, extensionCriterion]
  cases c with
  | mk carrier atoms bonds orientation canonicality decoding custody extension =>
    cases carrier <;> cases atoms <;> cases bonds <;> cases orientation <;> cases canonicality <;> cases decoding <;> cases custody <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.atoms = .admitted ∧ c.bonds = .admitted ∧ c.orientation = .admitted ∧ c.canonicality = .admitted ∧ c.decoding = .admitted ∧ c.custody = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier atoms bonds orientation canonicality decoding custody extension =>
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

theorem atoms_rejected_rejected (c : Candidate) (h : c.atoms = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.atoms eq
    rw [h] at field
    cases field

theorem bonds_rejected_rejected (c : Candidate) (h : c.bonds = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.bonds eq
    rw [h] at field
    cases field

theorem orientation_rejected_rejected (c : Candidate) (h : c.orientation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.orientation eq
    rw [h] at field
    cases field

theorem canonicality_rejected_rejected (c : Candidate) (h : c.canonicality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.canonicality eq
    rw [h] at field
    cases field

theorem decoding_rejected_rejected (c : Candidate) (h : c.decoding = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.decoding eq
    rw [h] at field
    cases field

theorem custody_rejected_rejected (c : Candidate) (h : c.custody = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.custody eq
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

end SFT.Chemistry.MolecularGraphGrammar
