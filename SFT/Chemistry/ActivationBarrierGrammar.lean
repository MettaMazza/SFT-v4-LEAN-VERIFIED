import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ActivationBarrierGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Path where
  | rejected | admitted

def pathName : Path → String
  | .rejected => "endpoint-only-or-saddle-continuum-premise"
  | .admitted => "complete-generated-discrete-path-state-word"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "free-fitted-or-imported-barrier-number"
  | .admitted => "exact-source-bound-state-support"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "arbitrary-named-transition-state"
  | .admitted => "highest-positive-generated-path-boundary"

inductive Reference where
  | rejected | admitted

def referenceName : Reference → String
  | .rejected => "absolute-energy-origin-or-signed-difference"
  | .admitted => "least-state-EmptyOne-relative-support"

inductive Minimality where
  | rejected | admitted

def minimalityName : Minimality → String
  | .rejected => "nonminimal-added-support"
  | .admitted => "least-crossing-positive-support"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "species-path-or-state-collapsed"
  | .admitted => "held-species-torsion-and-state-identities"

inductive Record where
  | rejected | admitted

def recordName : Record → String
  | .rejected => "barrier-answer-only-or-selected-profile"
  | .admitted => "complete-source-ordered-profile-reference-and-adverse-record"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "barrier-value-readable-before-seal-or-refit-on-append"
  | .admitted => "complete-value-free-44-target-identity-seal-and-depth-independent-append"

structure Candidate where
  path : Path
  source : Source
  boundary : Boundary
  reference : Reference
  minimality : Minimality
  identity : Identity
  record : Record
  prediction : Prediction

def sourceFields (c : Candidate) : List String := [pathName c.path, sourceName c.source, boundaryName c.boundary, referenceName c.reference, minimalityName c.minimality, identityName c.identity, recordName c.record, predictionName c.prediction]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "path=" (pathName c.path), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "reference=" (referenceName c.reference), SFT.Host.Text.append "minimality=" (minimalityName c.minimality), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "record=" (recordName c.record), SFT.Host.Text.append "prediction=" (predictionName c.prediction)]
def survivorId : String := "complete-generated-discrete-path-state-word__exact-source-bound-state-support__highest-positive-generated-path-boundary__least-state-EmptyOne-relative-support__least-crossing-positive-support__held-species-torsion-and-state-identities__complete-source-ordered-profile-reference-and-adverse-record__complete-value-free-44-target-identity-seal-and-depth-independent-append"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (pathName c.path) "complete-generated-discrete-path-state-word" &&
  SFT.Host.Text.equal (sourceName c.source) "exact-source-bound-state-support" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "highest-positive-generated-path-boundary" &&
  SFT.Host.Text.equal (referenceName c.reference) "least-state-EmptyOne-relative-support" &&
  SFT.Host.Text.equal (minimalityName c.minimality) "least-crossing-positive-support" &&
  SFT.Host.Text.equal (identityName c.identity) "held-species-torsion-and-state-identities" &&
  SFT.Host.Text.equal (recordName c.record) "complete-source-ordered-profile-reference-and-adverse-record" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-44-target-identity-seal-and-depth-independent-append"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (pathName c.path) "complete-generated-discrete-path-state-word") then "Endpoints or a named saddle do not enumerate a crossing path." else
  if !(SFT.Host.Text.equal (sourceName c.source) "exact-source-bound-state-support") then "A detached number could select the result." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "highest-positive-generated-path-boundary") then "A named state need not be the path boundary." else
  if !(SFT.Host.Text.equal (referenceName c.reference) "least-state-EmptyOne-relative-support") then "An arbitrary origin or negative scalar imports an inadmissible choice." else
  if !(SFT.Host.Text.equal (minimalityName c.minimality) "least-crossing-positive-support") then "Extra support does not define the crossing." else
  if !(SFT.Host.Text.equal (identityName c.identity) "held-species-torsion-and-state-identities") then "Collapsing identity can manufacture a barrier across different paths." else
  if !(SFT.Host.Text.equal (recordName c.record) "complete-source-ordered-profile-reference-and-adverse-record") then "A selected value cannot reconstruct the empirical path." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-44-target-identity-seal-and-depth-independent-append") then "Target access or refitting can choose the answer." else
  "complete-generated-discrete-path-state-word__exact-source-bound-state-support__highest-positive-generated-path-boundary__least-state-EmptyOne-relative-support__least-crossing-positive-support__held-species-torsion-and-state-identities__complete-source-ordered-profile-reference-and-adverse-record__complete-value-free-44-target-identity-seal-and-depth-independent-append"

def generationRule : String := "Generate the literal product of path, source, boundary, reference, minimality, identity, record and prediction forms; decide all 256 candidates only from admitted exact arithmetic, discrete path, order, state-energy, free-order, reaction-mechanism, structural activation-boundary, EmptyOne, record-retention and finite-successor laws."
def grammarBoundary : String := "Every finite generated discrete path with held species/path/state identities, exact positive relative supports or structural EmptyOne, complete source provenance and one greatest positive boundary. External testing preserves the complete NIST SRD 101 experimental collection: 41 species, 44 torsion targets, 782 path states and one unresolved row."

def candidates : List Candidate :=
  ([Path.rejected,Path.admitted]).flatMap fun path =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Reference.rejected,Reference.admitted]).flatMap fun reference =>
  ([Minimality.rejected,Minimality.admitted]).flatMap fun minimality =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Record.rejected,Record.admitted]).flatMap fun record =>
  ([Prediction.rejected,Prediction.admitted]).map fun prediction =>
  ⟨path,source,boundary,reference,minimality,identity,record,prediction⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk path source boundary reference minimality identity record prediction =>
    have hpath : path ∈ [Path.rejected,Path.admitted] := by
      cases path <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreference : reference ∈ [Reference.rejected,Reference.admitted] := by
      cases reference <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hminimality : minimality ∈ [Minimality.rejected,Minimality.admitted] := by
      cases minimality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrecord : record ∈ [Record.rejected,Record.admitted] := by
      cases record <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ path _ hpath
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ reference _ hreference
    apply CommonRefinement.memFlatMap _ _ minimality _ hminimality
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ record _ hrecord
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0001 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0010 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0011 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0100 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0101 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0110 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock0111 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1000 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1001 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1010 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1011 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1100 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1101 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1110 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionBlock1111 (minimality : Minimality) (identity : Identity) (record : Record) (prediction : Prediction) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,minimality,identity,record,prediction⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,minimality,identity,record,prediction⟩ := by
 cases minimality <;> cases identity <;> cases record <;> cases prediction <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk path source boundary reference minimality identity record prediction =>
  cases path <;> cases source <;> cases boundary <;> cases reference
  · exact sourceDecisionBlock0000 minimality identity record prediction
  · exact sourceDecisionBlock0001 minimality identity record prediction
  · exact sourceDecisionBlock0010 minimality identity record prediction
  · exact sourceDecisionBlock0011 minimality identity record prediction
  · exact sourceDecisionBlock0100 minimality identity record prediction
  · exact sourceDecisionBlock0101 minimality identity record prediction
  · exact sourceDecisionBlock0110 minimality identity record prediction
  · exact sourceDecisionBlock0111 minimality identity record prediction
  · exact sourceDecisionBlock1000 minimality identity record prediction
  · exact sourceDecisionBlock1001 minimality identity record prediction
  · exact sourceDecisionBlock1010 minimality identity record prediction
  · exact sourceDecisionBlock1011 minimality identity record prediction
  · exact sourceDecisionBlock1100 minimality identity record prediction
  · exact sourceDecisionBlock1101 minimality identity record prediction
  · exact sourceDecisionBlock1110 minimality identity record prediction
  · exact sourceDecisionBlock1111 minimality identity record prediction

theorem pathCriterion (value : Path) : SFT.Host.Text.equal (pathName value) "complete-generated-discrete-path-state-word" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem sourceCriterion (value : Source) : SFT.Host.Text.equal (sourceName value) "exact-source-bound-state-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "highest-positive-generated-path-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem referenceCriterion (value : Reference) : SFT.Host.Text.equal (referenceName value) "least-state-EmptyOne-relative-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem minimalityCriterion (value : Minimality) : SFT.Host.Text.equal (minimalityName value) "least-crossing-positive-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "held-species-torsion-and-state-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem recordCriterion (value : Record) : SFT.Host.Text.equal (recordName value) "complete-source-ordered-profile-reference-and-adverse-record" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-44-target-identity-seal-and-depth-independent-append" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [pathCriterion, sourceCriterion, boundaryCriterion, referenceCriterion, minimalityCriterion, identityCriterion, recordCriterion, predictionCriterion]
  cases c with
  | mk path source boundary reference minimality identity record prediction =>
    cases path <;> cases source <;> cases boundary <;> cases reference <;> cases minimality <;> cases identity <;> cases record <;> cases prediction
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.path = .admitted ∧ c.source = .admitted ∧ c.boundary = .admitted ∧ c.reference = .admitted ∧ c.minimality = .admitted ∧ c.identity = .admitted ∧ c.record = .admitted ∧ c.prediction = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk path source boundary reference minimality identity record prediction =>
      obtain ⟨h0,h1,h2,h3,h4,h5,h6,h7⟩ := h
      cases h0; cases h1; cases h2; cases h3; cases h4; cases h5; cases h6; cases h7
      rfl

theorem path_rejected_rejected (c : Candidate) (h : c.path = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.path eq
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

theorem boundary_rejected_rejected (c : Candidate) (h : c.boundary = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.boundary eq
    rw [h] at field
    cases field

theorem reference_rejected_rejected (c : Candidate) (h : c.reference = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.reference eq
    rw [h] at field
    cases field

theorem minimality_rejected_rejected (c : Candidate) (h : c.minimality = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.minimality eq
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

theorem record_rejected_rejected (c : Candidate) (h : c.record = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.record eq
    rw [h] at field
    cases field

theorem prediction_rejected_rejected (c : Candidate) (h : c.prediction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.prediction eq
    rw [h] at field
    cases field

end SFT.Chemistry.ActivationBarrierGrammar
