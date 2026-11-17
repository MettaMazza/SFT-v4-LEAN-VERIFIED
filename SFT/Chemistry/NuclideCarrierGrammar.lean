import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.NuclideCarrierGrammar
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Element where
  | rejected | admitted

def elementName : Element → String
  | .rejected => "anonymous-radiation"
  | .admitted => "held-element-identity"

inductive Nuclide where
  | rejected | admitted

def nuclideName : Nuclide → String
  | .rejected => "element-only-identity"
  | .admitted => "positive-nucleon-count"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "ground-state-assumption"
  | .admitted => "held-nuclear-state"

inductive Species where
  | rejected | admitted

def speciesName : Species → String
  | .rejected => "bare-nuclide-answer"
  | .admitted => "held-chemical-species"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "phase-free-species"
  | .admitted => "held-chemical-phase"

inductive Occurrence where
  | rejected | admitted

def occurrenceName : Occurrence → String
  | .rejected => "continuum-amount-premise"
  | .admitted => "positive-counted-occurrence"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-nuclide-row"
  | .admitted => "complete-nuclide-species-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "lookup-table-exception"
  | .admitted => "fresh-occurrence-preserves-identity"

structure Candidate where
  element : Element
  nuclide : Nuclide
  state : State
  species : Species
  phase : Phase
  occurrence : Occurrence
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [elementName c.element, nuclideName c.nuclide, stateName c.state, speciesName c.species, phaseName c.phase, occurrenceName c.occurrence, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "element=" (elementName c.element), SFT.Host.Text.append "nuclide=" (nuclideName c.nuclide), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "species=" (speciesName c.species), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "occurrence=" (occurrenceName c.occurrence), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "held-element-identity__positive-nucleon-count__held-nuclear-state__held-chemical-species__held-chemical-phase__positive-counted-occurrence__complete-nuclide-species-vector__fresh-occurrence-preserves-identity"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (elementName c.element) "held-element-identity" &&
  SFT.Host.Text.equal (nuclideName c.nuclide) "positive-nucleon-count" &&
  SFT.Host.Text.equal (stateName c.state) "held-nuclear-state" &&
  SFT.Host.Text.equal (speciesName c.species) "held-chemical-species" &&
  SFT.Host.Text.equal (phaseName c.phase) "held-chemical-phase" &&
  SFT.Host.Text.equal (occurrenceName c.occurrence) "positive-counted-occurrence" &&
  SFT.Host.Text.equal (recordName c.record) "complete-nuclide-species-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "fresh-occurrence-preserves-identity"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (elementName c.element) "held-element-identity") then "Radiation alone loses element." else
  if !(SFT.Host.Text.equal (nuclideName c.nuclide) "positive-nucleon-count") then "Element alone collapses isotopes." else
  if !(SFT.Host.Text.equal (stateName c.state) "held-nuclear-state") then "Nuclear state cannot be assumed." else
  if !(SFT.Host.Text.equal (speciesName c.species) "held-chemical-species") then "Chemistry requires species identity." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "held-chemical-phase") then "Phase affects the chemical record." else
  if !(SFT.Host.Text.equal (occurrenceName c.occurrence) "positive-counted-occurrence") then "Continuum amount hides occurrences." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-nuclide-species-vector") then "One row hides carrier diversity." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "fresh-occurrence-preserves-identity") then "A lookup cannot define identity." else
  "held-element-identity__positive-nucleon-count__held-nuclear-state__held-chemical-species__held-chemical-phase__positive-counted-occurrence__complete-nuclide-species-vector__fresh-occurrence-preserves-identity"

def generationRule : String := "Generate the literal product of eight registered carrier decisions."
def grammarBoundary : String := "Eight dimensions exhaust element, nuclide, state, species, phase, occurrence, record and extension."

def candidates : List Candidate :=
  ([Element.rejected,Element.admitted]).flatMap fun element =>
  ([Nuclide.rejected,Nuclide.admitted]).flatMap fun nuclide =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Species.rejected,Species.admitted]).flatMap fun species =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Occurrence.rejected,Occurrence.admitted]).flatMap fun occurrence =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨element,nuclide,state,species,phase,occurrence,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk element nuclide state species phase occurrence record extension =>
    have helement : element ∈ [Element.rejected,Element.admitted] := by
      cases element <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hnuclide : nuclide ∈ [Nuclide.rejected,Nuclide.admitted] := by
      cases nuclide <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hspecies : species ∈ [Species.rejected,Species.admitted] := by
      cases species <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoccurrence : occurrence ∈ [Occurrence.rejected,Occurrence.admitted] := by
      cases occurrence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ element _ helement
    apply CommonRefinement.memFlatMap _ _ nuclide _ hnuclide
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ species _ hspecies
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ occurrence _ hoccurrence
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (phase : Phase) (occurrence : Occurrence) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,phase,occurrence,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,phase,occurrence,record,extension⟩ := by
 cases phase <;> cases occurrence <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk element nuclide state species phase occurrence record extension =>
  cases element <;> cases nuclide <;> cases state <;> cases species
  · exact sourceDecisionBlock0000 phase occurrence record extension
  · exact sourceDecisionBlock0001 phase occurrence record extension
  · exact sourceDecisionBlock0010 phase occurrence record extension
  · exact sourceDecisionBlock0011 phase occurrence record extension
  · exact sourceDecisionBlock0100 phase occurrence record extension
  · exact sourceDecisionBlock0101 phase occurrence record extension
  · exact sourceDecisionBlock0110 phase occurrence record extension
  · exact sourceDecisionBlock0111 phase occurrence record extension
  · exact sourceDecisionBlock1000 phase occurrence record extension
  · exact sourceDecisionBlock1001 phase occurrence record extension
  · exact sourceDecisionBlock1010 phase occurrence record extension
  · exact sourceDecisionBlock1011 phase occurrence record extension
  · exact sourceDecisionBlock1100 phase occurrence record extension
  · exact sourceDecisionBlock1101 phase occurrence record extension
  · exact sourceDecisionBlock1110 phase occurrence record extension
  · exact sourceDecisionBlock1111 phase occurrence record extension

theorem elementCriterion (value : Element) : SFT.Host.Text.equal (elementName value) "held-element-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem nuclideCriterion (value : Nuclide) : SFT.Host.Text.equal (nuclideName value) "positive-nucleon-count" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "held-nuclear-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem speciesCriterion (value : Species) : SFT.Host.Text.equal (speciesName value) "held-chemical-species" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem phaseCriterion (value : Phase) : SFT.Host.Text.equal (phaseName value) "held-chemical-phase" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem occurrenceCriterion (value : Occurrence) : SFT.Host.Text.equal (occurrenceName value) "positive-counted-occurrence" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-nuclide-species-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "fresh-occurrence-preserves-identity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [elementCriterion, nuclideCriterion, stateCriterion, speciesCriterion, phaseCriterion, occurrenceCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk element nuclide state species phase occurrence record extension =>
    cases element <;> cases nuclide <;> cases state <;> cases species <;> cases phase <;> cases occurrence <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.element = .admitted ∧ c.nuclide = .admitted ∧ c.state = .admitted ∧ c.species = .admitted ∧ c.phase = .admitted ∧ c.occurrence = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk element nuclide state species phase occurrence record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem element_rejected_rejected (c : Candidate) (h : c.element = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.element eq
    rw [h] at field
    cases field

theorem nuclide_rejected_rejected (c : Candidate) (h : c.nuclide = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.nuclide eq
    rw [h] at field
    cases field

theorem state_rejected_rejected (c : Candidate) (h : c.state = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.state eq
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

theorem phase_rejected_rejected (c : Candidate) (h : c.phase = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.phase eq
    rw [h] at field
    cases field

theorem occurrence_rejected_rejected (c : Candidate) (h : c.occurrence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.occurrence eq
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

end SFT.Chemistry.NuclideCarrierGrammar
