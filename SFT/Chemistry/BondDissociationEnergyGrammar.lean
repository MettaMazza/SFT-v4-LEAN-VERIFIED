import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.BondDissociationEnergyGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "generic-molecule-with-erased-isotope"
  | .admitted => "named-isotopologue-and-X-state"

inductive Channel where
  | rejected | admitted

def channelName : Channel → String
  | .rejected => "dissociation-products-erased"
  | .admitted => "both-product-channels-held"

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "answer-only-energy-lookup"
  | .admitted => "shared-prefix-path-composition"

inductive Operation where
  | rejected | admitted

def operationName : Operation → String
  | .rejected => "signed-or-floating-subtraction"
  | .admitted => "ordered-positive-held-Take"

inductive Input where
  | rejected | admitted

def inputName : Input → String
  | .rejected => "measured-value-used-as-prediction-input"
  | .admitted => "all-measurements-opened-post-seal"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "dissociation-target-readable-before-seal"
  | .admitted => "target-inaccessible-until-prediction-seal"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "selected-historical-or-current-row"
  | .admitted => "complete-historical-and-current-vector"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-coefficient-or-correction"
  | .admitted => "typed-two-row-exhaustion-no-extra-rule"

structure Candidate where
  identity : Identity
  channel : Channel
  path : Path
  operation : Operation
  input : Input
  measurement : Measurement
  record : Record
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, channelName c.channel, pathName c.path, operationName c.operation, inputName c.input, measurementName c.measurement, recordName c.record, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "channel=" (channelName c.channel), SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "operation=" (operationName c.operation), SFT.Host.Text.append "input=" (inputName c.input), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "named-isotopologue-and-X-state__both-product-channels-held__shared-prefix-path-composition__ordered-positive-held-Take__all-measurements-opened-post-seal__target-inaccessible-until-prediction-seal__complete-historical-and-current-vector__typed-two-row-exhaustion-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "named-isotopologue-and-X-state" &&
  SFT.Host.Text.equal (channelName c.channel) "both-product-channels-held" &&
  SFT.Host.Text.equal (pathName c.path) "shared-prefix-path-composition" &&
  SFT.Host.Text.equal (operationName c.operation) "ordered-positive-held-Take" &&
  SFT.Host.Text.equal (inputName c.input) "all-measurements-opened-post-seal" &&
  SFT.Host.Text.equal (measurementName c.measurement) "target-inaccessible-until-prediction-seal" &&
  SFT.Host.Text.equal (recordName c.record) "complete-historical-and-current-vector" &&
  SFT.Host.Text.equal (extensionName c.extension) "typed-two-row-exhaustion-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "named-isotopologue-and-X-state") then "A generic molecule cannot own an isotopologue-specific quantitative path." else
  if !(SFT.Host.Text.equal (channelName c.channel) "both-product-channels-held") then "Erasing the atomic product states destroys the path whose segment is Taken." else
  if !(SFT.Host.Text.equal (pathName c.path) "shared-prefix-path-composition") then "An answer-only energy does not derive the relation between the two state paths." else
  if !(SFT.Host.Text.equal (operationName c.operation) "ordered-positive-held-Take") then "A signed scalar or floating subtraction is outside the Fold exact domain." else
  if !(SFT.Host.Text.equal (inputName c.input) "all-measurements-opened-post-seal") then "A measured threshold or atomic interval inside prediction would make observation select the number." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "target-inaccessible-until-prediction-seal") then "A readable target can select or alter the predicted interval." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-historical-and-current-vector") then "Selecting one resolution or era can conceal an unfavorable comparison." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "typed-two-row-exhaustion-no-extra-rule") then "A species coefficient or residual correction would be a free parameter." else
  "named-isotopologue-and-X-state__both-product-channels-held__shared-prefix-path-composition__ordered-positive-held-Take__all-measurements-opened-post-seal__target-inaccessible-until-prediction-seal__complete-historical-and-current-vector__typed-two-row-exhaustion-no-extra-rule"

def generationRule : String := "Generate the literal product of identity, channel, path, operation, public-input, target-custody, record-completeness and extension forms; decide all 256 using only admitted transition/conservation laws and the registered source identities."
def grammarBoundary : String := "The complete eight-row H2/D2 path vector: two B-prime thresholds, two atomic 1S-2S segments, two APS-1994 ground-state rows, and the later high-resolution H2-2009 and D2-2022 rows, with species, state, product channel, condition and uncertainty held and every number withheld until after sealing."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Channel.rejected,Channel.admitted]).flatMap fun channel =>
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Operation.rejected,Operation.admitted]).flatMap fun operation =>
  ([Input.rejected,Input.admitted]).flatMap fun input =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,channel,path,operation,input,measurement,record,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity channel path operation input measurement record extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hchannel : channel ∈ [Channel.rejected,Channel.admitted] := by
      cases channel <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperation : operation ∈ [Operation.rejected,Operation.admitted] := by
      cases operation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinput : input ∈ [Input.rejected,Input.admitted] := by
      cases input <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ channel _ hchannel
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ operation _ hoperation
    apply CommonRefinement.memFlatMap _ _ input _ hinput
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (input : Input) (measurement : Measurement) (record : Record) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,input,measurement,record,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,input,measurement,record,extension⟩ := by
 cases input <;> cases measurement <;> cases record <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity channel path operation input measurement record extension =>
  cases identity <;> cases channel <;> cases path <;> cases operation
  · exact sourceDecisionBlock0000 input measurement record extension
  · exact sourceDecisionBlock0001 input measurement record extension
  · exact sourceDecisionBlock0010 input measurement record extension
  · exact sourceDecisionBlock0011 input measurement record extension
  · exact sourceDecisionBlock0100 input measurement record extension
  · exact sourceDecisionBlock0101 input measurement record extension
  · exact sourceDecisionBlock0110 input measurement record extension
  · exact sourceDecisionBlock0111 input measurement record extension
  · exact sourceDecisionBlock1000 input measurement record extension
  · exact sourceDecisionBlock1001 input measurement record extension
  · exact sourceDecisionBlock1010 input measurement record extension
  · exact sourceDecisionBlock1011 input measurement record extension
  · exact sourceDecisionBlock1100 input measurement record extension
  · exact sourceDecisionBlock1101 input measurement record extension
  · exact sourceDecisionBlock1110 input measurement record extension
  · exact sourceDecisionBlock1111 input measurement record extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "named-isotopologue-and-X-state" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem channelCriterion (value : Channel) : SFT.Host.Text.equal (channelName value) "both-product-channels-held" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "shared-prefix-path-composition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem operationCriterion (value : Operation) : SFT.Host.Text.equal (operationName value) "ordered-positive-held-Take" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem inputCriterion (value : Input) : SFT.Host.Text.equal (inputName value) "all-measurements-opened-post-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem measurementCriterion (value : Measurement) : SFT.Host.Text.equal (measurementName value) "target-inaccessible-until-prediction-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-historical-and-current-vector" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "typed-two-row-exhaustion-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, channelCriterion, pathCriterion, operationCriterion, inputCriterion, measurementCriterion, recordCriterion, extensionCriterion]
  cases c with
  | mk identity channel path operation input measurement record extension =>
    cases identity <;> cases channel <;> cases path <;> cases operation <;> cases input <;> cases measurement <;> cases record <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.channel = .admitted ∧ c.path = .admitted ∧ c.operation = .admitted ∧ c.input = .admitted ∧ c.measurement = .admitted ∧ c.record = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity channel path operation input measurement record extension =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
    rw [h] at field
    cases field

theorem channel_rejected_rejected (c : Candidate) (h : c.channel = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.channel eq
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

theorem operation_rejected_rejected (c : Candidate) (h : c.operation = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.operation eq
    rw [h] at field
    cases field

theorem input_rejected_rejected (c : Candidate) (h : c.input = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.input eq
    rw [h] at field
    cases field

theorem measurement_rejected_rejected (c : Candidate) (h : c.measurement = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.measurement eq
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

end SFT.Chemistry.BondDissociationEnergyGrammar
