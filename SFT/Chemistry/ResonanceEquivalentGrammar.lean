import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ResonanceEquivalentGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "different-molecular-carriers"
  | .admitted => "one-retained-molecular-carrier"

inductive Atoms where
  | rejected | admitted

def atomsName : Atoms → String
  | .rejected => "atom-occurrence-change"
  | .admitted => "complete-equal-atom-occurrence-support"

inductive Adjacency where
  | rejected | admitted

def adjacencyName : Adjacency → String
  | .rejected => "connectivity-change"
  | .admitted => "complete-equal-adjacency-support"

inductive Encodings where
  | rejected | admitted

def encodingsName : Encodings → String
  | .rejected => "one-encoding-only"
  | .admitted => "multiple-distinct-encoding-identities"

inductive Fibres where
  | rejected | admitted

def fibresName : Fibres → String
  | .rejected => "partial-or-arbitrary-label-change"
  | .admitted => "complete-opposed-fibre-complement"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "representations-counted-as-species"
  | .admitted => "one-carrier-many-representations"

inductive Process where
  | rejected | admitted

def processName : Process → String
  | .rejected => "equilibrium-or-transition-imported"
  | .admitted => "representation-relation-only"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "named-resonance-exception"
  | .admitted => "shared-complement-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  atoms : Atoms
  adjacency : Adjacency
  encodings : Encodings
  fibres : Fibres
  identity : Identity
  process : Process
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, atomsName c.atoms, adjacencyName c.adjacency, encodingsName c.encodings, fibresName c.fibres, identityName c.identity, processName c.process, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "atoms=" (atomsName c.atoms), SFT.Host.Text.append "adjacency=" (adjacencyName c.adjacency), SFT.Host.Text.append "encodings=" (encodingsName c.encodings), SFT.Host.Text.append "fibres=" (fibresName c.fibres), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "process=" (processName c.process), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-molecular-carrier__complete-equal-atom-occurrence-support__complete-equal-adjacency-support__multiple-distinct-encoding-identities__complete-opposed-fibre-complement__one-carrier-many-representations__representation-relation-only__shared-complement-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-molecular-carrier" &&
  SFT.Host.Text.equal (atomsName c.atoms) "complete-equal-atom-occurrence-support" &&
  SFT.Host.Text.equal (adjacencyName c.adjacency) "complete-equal-adjacency-support" &&
  SFT.Host.Text.equal (encodingsName c.encodings) "multiple-distinct-encoding-identities" &&
  SFT.Host.Text.equal (fibresName c.fibres) "complete-opposed-fibre-complement" &&
  SFT.Host.Text.equal (identityName c.identity) "one-carrier-many-representations" &&
  SFT.Host.Text.equal (processName c.process) "representation-relation-only" &&
  SFT.Host.Text.equal (extensionName c.extension) "shared-complement-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-molecular-carrier") then "Different carriers are different molecular identities." else
  if !(SFT.Host.Text.equal (atomsName c.atoms) "complete-equal-atom-occurrence-support") then "Adding, deleting or replacing an occurrence changes the carrier description." else
  if !(SFT.Host.Text.equal (adjacencyName c.adjacency) "complete-equal-adjacency-support") then "Changed adjacency is a distinct constitution, not an encoding alternative." else
  if !(SFT.Host.Text.equal (encodingsName c.encodings) "multiple-distinct-encoding-identities") then "One inscription supplies no representation equivalence class." else
  if !(SFT.Host.Text.equal (fibresName c.fibres) "complete-opposed-fibre-complement") then "An arbitrary partial change does not preserve the generated Fold relation." else
  if !(SFT.Host.Text.equal (identityName c.identity) "one-carrier-many-representations") then "Formal encodings do not create new chemical carriers." else
  if !(SFT.Host.Text.equal (processName c.process) "representation-relation-only") then "A representation relation does not imply a physical interconversion process." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "shared-complement-successor-no-extra-rule") then "A named exception adds an unforced classification rule." else
  "one-retained-molecular-carrier__complete-equal-atom-occurrence-support__complete-equal-adjacency-support__multiple-distinct-encoding-identities__complete-opposed-fibre-complement__one-carrier-many-representations__representation-relation-only__shared-complement-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, atom-support, adjacency, encoding-number, fibre-relation, identity, process and extension alternatives; decide all 256 forms from admitted form enforcement, exact graph, distinction, conservation, molecular identity, bond-order, electronic-state and conjugated-support dependencies."
def grammarBoundary : String := "Every finite complete connected alternating molecular representation pair related by global Fold-fibre complement. Larger finite representation classes are generated by composition of exact local pair relations while retaining the same carrier, atoms and adjacency. The empirical boundary is the four complete preregistered IUPAC records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Atoms.rejected,Atoms.admitted]).flatMap fun atoms =>
  ([Adjacency.rejected,Adjacency.admitted]).flatMap fun adjacency =>
  ([Encodings.rejected,Encodings.admitted]).flatMap fun encodings =>
  ([Fibres.rejected,Fibres.admitted]).flatMap fun fibres =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Process.rejected,Process.admitted]).flatMap fun process =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,atoms,adjacency,encodings,fibres,identity,process,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier atoms adjacency encodings fibres identity process extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hatoms : atoms ∈ [Atoms.rejected,Atoms.admitted] := by
      cases atoms <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadjacency : adjacency ∈ [Adjacency.rejected,Adjacency.admitted] := by
      cases adjacency <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hencodings : encodings ∈ [Encodings.rejected,Encodings.admitted] := by
      cases encodings <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hfibres : fibres ∈ [Fibres.rejected,Fibres.admitted] := by
      cases fibres <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprocess : process ∈ [Process.rejected,Process.admitted] := by
      cases process <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ atoms _ hatoms
    apply CommonRefinement.memFlatMap _ _ adjacency _ hadjacency
    apply CommonRefinement.memFlatMap _ _ encodings _ hencodings
    apply CommonRefinement.memFlatMap _ _ fibres _ hfibres
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ process _ hprocess
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (fibres : Fibres) (identity : Identity) (process : Process) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,fibres,identity,process,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,fibres,identity,process,extension⟩ := by
 cases fibres <;> cases identity <;> cases process <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier atoms adjacency encodings fibres identity process extension =>
  cases carrier <;> cases atoms <;> cases adjacency <;> cases encodings
  · exact sourceDecisionBlock0000 fibres identity process extension
  · exact sourceDecisionBlock0001 fibres identity process extension
  · exact sourceDecisionBlock0010 fibres identity process extension
  · exact sourceDecisionBlock0011 fibres identity process extension
  · exact sourceDecisionBlock0100 fibres identity process extension
  · exact sourceDecisionBlock0101 fibres identity process extension
  · exact sourceDecisionBlock0110 fibres identity process extension
  · exact sourceDecisionBlock0111 fibres identity process extension
  · exact sourceDecisionBlock1000 fibres identity process extension
  · exact sourceDecisionBlock1001 fibres identity process extension
  · exact sourceDecisionBlock1010 fibres identity process extension
  · exact sourceDecisionBlock1011 fibres identity process extension
  · exact sourceDecisionBlock1100 fibres identity process extension
  · exact sourceDecisionBlock1101 fibres identity process extension
  · exact sourceDecisionBlock1110 fibres identity process extension
  · exact sourceDecisionBlock1111 fibres identity process extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-molecular-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem atomsCriterion (value : Atoms) : SFT.Host.Text.equal (atomsName value) "complete-equal-atom-occurrence-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adjacencyCriterion (value : Adjacency) : SFT.Host.Text.equal (adjacencyName value) "complete-equal-adjacency-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem encodingsCriterion (value : Encodings) : SFT.Host.Text.equal (encodingsName value) "multiple-distinct-encoding-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem fibresCriterion (value : Fibres) : SFT.Host.Text.equal (fibresName value) "complete-opposed-fibre-complement" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "one-carrier-many-representations" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem processCriterion (value : Process) : SFT.Host.Text.equal (processName value) "representation-relation-only" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "shared-complement-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, atomsCriterion, adjacencyCriterion, encodingsCriterion, fibresCriterion, identityCriterion, processCriterion, extensionCriterion]
  cases c with
  | mk carrier atoms adjacency encodings fibres identity process extension =>
    cases carrier <;> cases atoms <;> cases adjacency <;> cases encodings <;> cases fibres <;> cases identity <;> cases process <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.atoms = .admitted ∧ c.adjacency = .admitted ∧ c.encodings = .admitted ∧ c.fibres = .admitted ∧ c.identity = .admitted ∧ c.process = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier atoms adjacency encodings fibres identity process extension =>
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

theorem adjacency_rejected_rejected (c : Candidate) (h : c.adjacency = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adjacency eq
    rw [h] at field
    cases field

theorem encodings_rejected_rejected (c : Candidate) (h : c.encodings = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.encodings eq
    rw [h] at field
    cases field

theorem fibres_rejected_rejected (c : Candidate) (h : c.fibres = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.fibres eq
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

theorem process_rejected_rejected (c : Candidate) (h : c.process = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.process eq
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

end SFT.Chemistry.ResonanceEquivalentGrammar
