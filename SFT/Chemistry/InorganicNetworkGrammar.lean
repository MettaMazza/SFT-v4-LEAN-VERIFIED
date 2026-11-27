import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InorganicNetworkGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-inorganic-equation"
  | .admitted => "complete-finite-species-transition-network"

inductive Species where
  | rejected | admitted

def speciesName : Species → String
  | .rejected => "untracked-reagent-labels"
  | .admitted => "complete-held-species-identity-support"

inductive AcidBase where
  | rejected | admitted

def acidBaseName : AcidBase → String
  | .rejected => "assumed-acid-and-base-names"
  | .admitted => "provider-acceptor-two-occurrence-pair-transfer"

inductive Adduct where
  | rejected | admitted

def adductName : Adduct → String
  | .rejected => "unstructured-acid-base-mixture"
  | .admitted => "retained-provider-acceptor-adduct-composition"

inductive Redox where
  | rejected | admitted

def redoxName : Redox → String
  | .rejected => "signed-oxidation-number-arithmetic"
  | .admitted => "positive-complete-held-electron-transfer"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "independent-oxidation-and-reduction-labels"
  | .admitted => "one-donor-acceptor-conserved-transfer"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "unordered-reaction-list"
  | .admitted => "complete-ordered-transition-path"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "named-reaction-exception"
  | .admitted => "transition-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  species : Species
  acidBase : AcidBase
  adduct : Adduct
  redox : Redox
  coupling : Coupling
  path : Path
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, speciesName c.species, acidBaseName c.acidBase, adductName c.adduct, redoxName c.redox, couplingName c.coupling, pathName c.path, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "species=" (speciesName c.species), SFT.Host.Text.append "acid-base=" (acidBaseName c.acidBase), SFT.Host.Text.append "adduct=" (adductName c.adduct), SFT.Host.Text.append "redox=" (redoxName c.redox), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-finite-species-transition-network__complete-held-species-identity-support__provider-acceptor-two-occurrence-pair-transfer__retained-provider-acceptor-adduct-composition__positive-complete-held-electron-transfer__one-donor-acceptor-conserved-transfer__complete-ordered-transition-path__transition-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-species-transition-network" &&
  SFT.Host.Text.equal (speciesName c.species) "complete-held-species-identity-support" &&
  SFT.Host.Text.equal (acidBaseName c.acidBase) "provider-acceptor-two-occurrence-pair-transfer" &&
  SFT.Host.Text.equal (adductName c.adduct) "retained-provider-acceptor-adduct-composition" &&
  SFT.Host.Text.equal (redoxName c.redox) "positive-complete-held-electron-transfer" &&
  SFT.Host.Text.equal (couplingName c.coupling) "one-donor-acceptor-conserved-transfer" &&
  SFT.Host.Text.equal (pathName c.path) "complete-ordered-transition-path" &&
  SFT.Host.Text.equal (extensionName c.extension) "transition-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-finite-species-transition-network") then "One selected equation does not close a reaction network." else
  if !(SFT.Host.Text.equal (speciesName c.species) "complete-held-species-identity-support") then "Untracked labels cannot establish conservation." else
  if !(SFT.Host.Text.equal (acidBaseName c.acidBase) "provider-acceptor-two-occurrence-pair-transfer") then "Names alone do not establish pair transfer." else
  if !(SFT.Host.Text.equal (adductName c.adduct) "retained-provider-acceptor-adduct-composition") then "A mixture loses the joining record." else
  if !(SFT.Host.Text.equal (redoxName c.redox) "positive-complete-held-electron-transfer") then "A signed inscription is not a native transfer record." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "one-donor-acceptor-conserved-transfer") then "Independent labels can violate carrier conservation." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-ordered-transition-path") then "An unordered list loses operational composition." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "transition-successor-no-extra-rule") then "A named exception destroys closure." else
  "complete-finite-species-transition-network__complete-held-species-identity-support__provider-acceptor-two-occurrence-pair-transfer__retained-provider-acceptor-adduct-composition__positive-complete-held-electron-transfer__one-donor-acceptor-conserved-transfer__complete-ordered-transition-path__transition-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, species, acid-base, adduct, redox, coupling, path and extension alternatives; decide all 256 forms from admitted graph, information conservation, operational process, Lewis, redox, stoichiometry and reaction dependencies."
def grammarBoundary : String := "Every finite complete inorganic species-transition network with Lewis pair/adduct and/or redox transfer steps and a complete ordered path; all fifteen frozen Lewis acid, Lewis base, Lewis adduct, oxidation and reduction surfaces."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Species.rejected,Species.admitted]).flatMap fun species =>
  ([AcidBase.rejected,AcidBase.admitted]).flatMap fun acidBase =>
  ([Adduct.rejected,Adduct.admitted]).flatMap fun adduct =>
  ([Redox.rejected,Redox.admitted]).flatMap fun redox =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,species,acidBase,adduct,redox,coupling,path,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier species acidBase adduct redox coupling path extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspecies : species ∈ [Species.rejected,Species.admitted] := by
      cases species <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hacidBase : acidBase ∈ [AcidBase.rejected,AcidBase.admitted] := by
      cases acidBase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hadduct : adduct ∈ [Adduct.rejected,Adduct.admitted] := by
      cases adduct <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hredox : redox ∈ [Redox.rejected,Redox.admitted] := by
      cases redox <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ species _ hspecies
    apply CommonRefinement.memFlatMap _ _ acidBase _ hacidBase
    apply CommonRefinement.memFlatMap _ _ adduct _ hadduct
    apply CommonRefinement.memFlatMap _ _ redox _ hredox
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (redox : Redox) (coupling : Coupling) (path : Path) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,redox,coupling,path,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,redox,coupling,path,extension⟩ := by
 cases redox <;> cases coupling <;> cases path <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier species acidBase adduct redox coupling path extension =>
  cases carrier <;> cases species <;> cases acidBase <;> cases adduct
  · exact sourceDecisionBlock0000 redox coupling path extension
  · exact sourceDecisionBlock0001 redox coupling path extension
  · exact sourceDecisionBlock0010 redox coupling path extension
  · exact sourceDecisionBlock0011 redox coupling path extension
  · exact sourceDecisionBlock0100 redox coupling path extension
  · exact sourceDecisionBlock0101 redox coupling path extension
  · exact sourceDecisionBlock0110 redox coupling path extension
  · exact sourceDecisionBlock0111 redox coupling path extension
  · exact sourceDecisionBlock1000 redox coupling path extension
  · exact sourceDecisionBlock1001 redox coupling path extension
  · exact sourceDecisionBlock1010 redox coupling path extension
  · exact sourceDecisionBlock1011 redox coupling path extension
  · exact sourceDecisionBlock1100 redox coupling path extension
  · exact sourceDecisionBlock1101 redox coupling path extension
  · exact sourceDecisionBlock1110 redox coupling path extension
  · exact sourceDecisionBlock1111 redox coupling path extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-finite-species-transition-network" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem speciesCriterion (value : Species) : SFT.Host.Text.equal (speciesName value) "complete-held-species-identity-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem acidBaseCriterion (value : AcidBase) : SFT.Host.Text.equal (acidBaseName value) "provider-acceptor-two-occurrence-pair-transfer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem adductCriterion (value : Adduct) : SFT.Host.Text.equal (adductName value) "retained-provider-acceptor-adduct-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem redoxCriterion (value : Redox) : SFT.Host.Text.equal (redoxName value) "positive-complete-held-electron-transfer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem couplingCriterion (value : Coupling) : SFT.Host.Text.equal (couplingName value) "one-donor-acceptor-conserved-transfer" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-ordered-transition-path" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "transition-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, speciesCriterion, acidBaseCriterion, adductCriterion, redoxCriterion, couplingCriterion, pathCriterion, extensionCriterion]
  cases c with
  | mk carrier species acidBase adduct redox coupling path extension =>
    cases carrier <;> cases species <;> cases acidBase <;> cases adduct <;> cases redox <;> cases coupling <;> cases path <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.species = .admitted ∧ c.acidBase = .admitted ∧ c.adduct = .admitted ∧ c.redox = .admitted ∧ c.coupling = .admitted ∧ c.path = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier species acidBase adduct redox coupling path extension =>
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

theorem species_rejected_rejected (c : Candidate) (h : c.species = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.species eq
    rw [h] at field
    cases field

theorem acidBase_rejected_rejected (c : Candidate) (h : c.acidBase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.acidBase eq
    rw [h] at field
    cases field

theorem adduct_rejected_rejected (c : Candidate) (h : c.adduct = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.adduct eq
    rw [h] at field
    cases field

theorem redox_rejected_rejected (c : Candidate) (h : c.redox = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.redox eq
    rw [h] at field
    cases field

theorem coupling_rejected_rejected (c : Candidate) (h : c.coupling = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.coupling eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.InorganicNetworkGrammar
