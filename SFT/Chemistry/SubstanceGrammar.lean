import SFT.Chemistry.SubstanceIdentity
import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.SubstanceGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Composition where
  | rejected | admitted

def compositionName : Composition → String
  | .rejected => "variable-unrecorded-composition"
  | .admitted => "constant-composition"

inductive Constituents where
  | rejected | admitted

def constituentsName : Constituents → String
  | .rejected => "anonymous-matter"
  | .admitted => "constituent-entity-support"

inductive Properties where
  | rejected | admitted

def propertiesName : Properties → String
  | .rejected => "composition-only-answer"
  | .admitted => "property-characterization"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "source-free-substance-label"
  | .admitted => "source-bounded-substance-identity"

inductive Phase where
  | rejected | admitted

def phaseName : Phase → String
  | .rejected => "phase-silently-collapsed"
  | .admitted => "phase-record-retained"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "property-selection-only"
  | .admitted => "complete-property-record"

inductive Provenance where
  | rejected | admitted

def provenanceName : Provenance → String
  | .rejected => "unbound-provenance"
  | .admitted => "source-bound-proof-trace"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-extra-substance-rule"
  | .admitted => "no-extra-rule"

structure Candidate where
  composition : Composition
  constituents : Constituents
  properties : Properties
  source : Source
  phase : Phase
  record : Record
  provenance : Provenance
  extension : Extension

def sourceFields (c : Candidate) : List String := [compositionName c.composition, constituentsName c.constituents, propertiesName c.properties, sourceName c.source, phaseName c.phase, recordName c.record, provenanceName c.provenance, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "composition=" (compositionName c.composition), SFT.Host.Text.append "constituents=" (constituentsName c.constituents), SFT.Host.Text.append "properties=" (propertiesName c.properties), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "phase=" (phaseName c.phase), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "provenance=" (provenanceName c.provenance), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "constant-composition__constituent-entity-support__property-characterization__source-bounded-substance-identity__phase-record-retained__complete-property-record__source-bound-proof-trace__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (compositionName c.composition) "constant-composition" &&
  SFT.Host.Text.equal (constituentsName c.constituents) "constituent-entity-support" &&
  SFT.Host.Text.equal (propertiesName c.properties) "property-characterization" &&
  SFT.Host.Text.equal (sourceName c.source) "source-bounded-substance-identity" &&
  SFT.Host.Text.equal (phaseName c.phase) "phase-record-retained" &&
  SFT.Host.Text.equal (recordName c.record) "complete-property-record" &&
  SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (compositionName c.composition) "constant-composition") then "Unrecorded variable composition cannot identify one substance." else
  if !(SFT.Host.Text.equal (constituentsName c.constituents) "constituent-entity-support") then "Matter without retained constituent entities loses chemical identity." else
  if !(SFT.Host.Text.equal (propertiesName c.properties) "property-characterization") then "Composition alone can leave observation-equivalent candidates unresolved." else
  if !(SFT.Host.Text.equal (sourceName c.source) "source-bounded-substance-identity") then "A source-free label cannot distinguish sample and convention boundaries." else
  if !(SFT.Host.Text.equal (phaseName c.phase) "phase-record-retained") then "Silently collapsing phase can erase an observed substance distinction." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-property-record") then "Selecting one favorable property is not a complete characterization record." else
  if !(SFT.Host.Text.equal (provenanceName c.provenance) "source-bound-proof-trace") then "Unbound composition and property claims cannot be audited." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "A discretionary rule can split or merge substances after observation." else
  "constant-composition__constituent-entity-support__property-characterization__source-bounded-substance-identity"

def generationRule : String := "Generate the literal product of the registered substance composition, constituents, properties, source, phase, record, provenance and extension choices."
def grammarBoundary : String := "Every finite chemical substance carrier formed from one generated constant-composition support of chemical entities plus any positive-finite extension of its source-bound property record."

def candidates : List Candidate :=
  ([Composition.rejected,Composition.admitted]).flatMap fun composition =>
  ([Constituents.rejected,Constituents.admitted]).flatMap fun constituents =>
  ([Properties.rejected,Properties.admitted]).flatMap fun properties =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Phase.rejected,Phase.admitted]).flatMap fun phase =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Provenance.rejected,Provenance.admitted]).flatMap fun provenance =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨composition,constituents,properties,source,phase,record,provenance,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk composition constituents properties source phase record provenance extension =>
    have hcomposition : composition ∈ [Composition.rejected,Composition.admitted] := by
      cases composition <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconstituents : constituents ∈ [Constituents.rejected,Constituents.admitted] := by
      cases constituents <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hproperties : properties ∈ [Properties.rejected,Properties.admitted] := by
      cases properties <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hphase : phase ∈ [Phase.rejected,Phase.admitted] := by
      cases phase <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprovenance : provenance ∈ [Provenance.rejected,Provenance.admitted] := by
      cases provenance <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ composition _ hcomposition
    apply CommonRefinement.memFlatMap _ _ constituents _ hconstituents
    apply CommonRefinement.memFlatMap _ _ properties _ hproperties
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ phase _ hphase
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ provenance _ hprovenance
    exact Count.TraceDerivation.memMap _ extension _ hextension

set_option maxHeartbeats 20000000 in
theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
  cases c with
  | mk composition constituents properties source phase record provenance extension =>
    cases composition <;> cases constituents <;> cases properties <;> cases source <;> cases phase <;> cases record <;> cases provenance <;> cases extension
    all_goals rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  cases c with
  | mk composition constituents properties source phase record provenance extension =>
    cases composition <;> cases constituents <;> cases properties <;> cases source <;> cases phase <;> cases record <;> cases provenance <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.composition = .admitted ∧ c.constituents = .admitted ∧ c.properties = .admitted ∧ c.source = .admitted ∧ c.phase = .admitted ∧ c.record = .admitted ∧ c.provenance = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk composition constituents properties source phase record provenance extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem composition_rejected_rejected (c : Candidate) (h : c.composition = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.composition eq
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

theorem properties_rejected_rejected (c : Candidate) (h : c.properties = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.properties eq
    rw [h] at field
    cases field

theorem source_rejected_rejected (c : Candidate) (h : c.source = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.source eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.SubstanceGrammar
