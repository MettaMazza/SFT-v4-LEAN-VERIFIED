import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.NucleophilicGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "selected-product-label-or-disconnected-fragments"
  | .admitted => "complete-source-ordered-reaction-carrier"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "reactant-or-bond-support-omitted"
  | .admitted => "complete-source-bonds-and-free-entering-pair"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "electrons-created-destroyed-or-collapsed-to-charge-number"
  | .admitted => "every-held-pair-occurrence-conserved"

inductive Change where
  | rejected | admitted

def changeName : Change → String
  | .rejected => "endpoint-only-product-or-extra-bond-change"
  | .admitted => "one-bond-cleaved-and-one-bond-formed"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "named-mechanism-rate-law-or-unordered-snapshots"
  | .admitted => "complete-one-transition-and-cleavage-first-path-family"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "intermediate-adverse-or-mechanism-row-omitted"
  | .admitted => "every-state-edge-status-and-source-record-retained"

inductive Observation where
  | rejected | admitted

def observationName : Observation → String
  | .rejected => "substrate-product-mechanism-readable-before-seal"
  | .admitted => "value-free-structure-and-mechanism-target-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "molecule-specific-exception-or-recomputed-prefix"
  | .admitted => "fresh-retained-substrate-successor-no-extra-rule"

structure Candidate where
  carrier : Carrier
  source : Source
  support : Support
  change : Change
  path : Path
  record : Record
  observation : Observation
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, sourceName c.source, supportName c.support, changeName c.change, pathName c.path, recordName c.record, observationName c.observation, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "change=" (changeName c.change), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "observation=" (observationName c.observation), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-source-ordered-reaction-carrier__complete-source-bonds-and-free-entering-pair__every-held-pair-occurrence-conserved__one-bond-cleaved-and-one-bond-formed__complete-one-transition-and-cleavage-first-path-family__every-state-edge-status-and-source-record-retained__value-free-structure-and-mechanism-target-seal__fresh-retained-substrate-successor-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-source-ordered-reaction-carrier" &&
  SFT.Host.Text.equal (sourceName c.source) "complete-source-bonds-and-free-entering-pair" &&
  SFT.Host.Text.equal (supportName c.support) "every-held-pair-occurrence-conserved" &&
  SFT.Host.Text.equal (changeName c.change) "one-bond-cleaved-and-one-bond-formed" &&
  SFT.Host.Text.equal (pathName c.path) "complete-one-transition-and-cleavage-first-path-family" &&
  SFT.Host.Text.equal (recordName c.record) "every-state-edge-status-and-source-record-retained" &&
  SFT.Host.Text.equal (observationName c.observation) "value-free-structure-and-mechanism-target-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "fresh-retained-substrate-successor-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-source-ordered-reaction-carrier") then "A named answer cannot reconstruct one complete reaction carrier." else
  if !(SFT.Host.Text.equal (sourceName c.source) "complete-source-bonds-and-free-entering-pair") then "Omission prevents exact reconstruction of what changes." else
  if !(SFT.Host.Text.equal (supportName c.support) "every-held-pair-occurrence-conserved") then "A scalar charge or incomplete pair loses the transferred occurrences." else
  if !(SFT.Host.Text.equal (changeName c.change) "one-bond-cleaved-and-one-bond-formed") then "An endpoint or extra edit does not prove the minimal substitution map." else
  if !(SFT.Host.Text.equal (pathName c.path) "complete-one-transition-and-cleavage-first-path-family") then "A conventional name or imported kinetic law can select a path." else
  if !(SFT.Host.Text.equal (recordName c.record) "every-state-edge-status-and-source-record-retained") then "Selected records falsely collapse the path family." else
  if !(SFT.Host.Text.equal (observationName c.observation) "value-free-structure-and-mechanism-target-seal") then "External structures or terminology could select the survivor." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "fresh-retained-substrate-successor-no-extra-rule") then "A special substrate rule is not depth-independent." else
  "complete-source-ordered-reaction-carrier__complete-source-bonds-and-free-entering-pair__every-held-pair-occurrence-conserved__one-bond-cleaved-and-one-bond-formed__complete-one-transition-and-cleavage-first-path-family__every-state-edge-status-and-source-record-retained__value-free-structure-and-mechanism-target-seal__fresh-retained-substrate-successor-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, source, support, change, path, record, observation and extension alternatives; decide all 256 forms only from admitted exact graph, conservation, bond and transition laws."
def grammarBoundary : String := "Every positive finite complete exchange carrier with distinct centre, retained, entering and leaving occurrences; all source bonds and free pairs; every atom and held electron occurrence; the single exchange slot; both generated path orders; every source record and the complete nine-target external surface."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Change.rejected,Change.admitted]).flatMap fun change =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Observation.rejected,Observation.admitted]).flatMap fun observation =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,source,support,change,path,record,observation,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier source support change path record observation extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchange : change ∈ [Change.rejected,Change.admitted] := by
      cases change <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hobservation : observation ∈ [Observation.rejected,Observation.admitted] := by
      cases observation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ change _ hchange
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    apply CommonRefinement.memFlatMap _ _ observation _ hobservation
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (path : Path) (record : Record) (observation : Observation) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,path,record,observation,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,path,record,observation,extension⟩ := by
 cases path <;> cases record <;> cases observation <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier source support change path record observation extension =>
  cases carrier <;> cases source <;> cases support <;> cases change
  · exact sourceDecisionBlock0000 path record observation extension
  · exact sourceDecisionBlock0001 path record observation extension
  · exact sourceDecisionBlock0010 path record observation extension
  · exact sourceDecisionBlock0011 path record observation extension
  · exact sourceDecisionBlock0100 path record observation extension
  · exact sourceDecisionBlock0101 path record observation extension
  · exact sourceDecisionBlock0110 path record observation extension
  · exact sourceDecisionBlock0111 path record observation extension
  · exact sourceDecisionBlock1000 path record observation extension
  · exact sourceDecisionBlock1001 path record observation extension
  · exact sourceDecisionBlock1010 path record observation extension
  · exact sourceDecisionBlock1011 path record observation extension
  · exact sourceDecisionBlock1100 path record observation extension
  · exact sourceDecisionBlock1101 path record observation extension
  · exact sourceDecisionBlock1110 path record observation extension
  · exact sourceDecisionBlock1111 path record observation extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-source-ordered-reaction-carrier" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem sourceCriterion (value : Source) : SFT.Host.Text.equal (sourceName value) "complete-source-bonds-and-free-entering-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem supportCriterion (value : Support) : SFT.Host.Text.equal (supportName value) "every-held-pair-occurrence-conserved" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem changeCriterion (value : Change) : SFT.Host.Text.equal (changeName value) "one-bond-cleaved-and-one-bond-formed" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-one-transition-and-cleavage-first-path-family" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "every-state-edge-status-and-source-record-retained" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem observationCriterion (value : Observation) : SFT.Host.Text.equal (observationName value) "value-free-structure-and-mechanism-target-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "fresh-retained-substrate-successor-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, sourceCriterion, supportCriterion, changeCriterion, pathCriterion, recordCriterion, observationCriterion, extensionCriterion]
  cases c with
  | mk carrier source support change path record observation extension =>
    cases carrier <;> cases source <;> cases support <;> cases change <;> cases path <;> cases record <;> cases observation <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.source = .admitted ∧ c.support = .admitted ∧ c.change = .admitted ∧ c.path = .admitted ∧ c.record = .admitted ∧ c.observation = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier source support change path record observation extension =>
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

theorem change_rejected_rejected (c : Candidate) (h : c.change = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.change eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.NucleophilicGrammar
