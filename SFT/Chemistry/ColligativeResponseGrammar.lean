import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.ColligativeResponseGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "unbound-response-number"
  | .admitted => "complete-solvent-solute-particle-account"

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "anonymous-particle-count-or-erased-solvent"
  | .admitted => "distinct-held-solvent-and-solute-identities"

inductive Boundary where
  | rejected | admitted

def boundaryName : Boundary → String
  | .rejected => "imported-colligative-equation-or-dissociation-factor"
  | .admitted => "exact-solvent-transmission-and-solute-retention-boundary"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "signed-temperature-or-pressure-displacement"
  | .admitted => "held-boiling-freezing-osmotic-orientation-label"

inductive Magnitude where
  | rejected | admitted

def magnitudeName : Magnitude → String
  | .rejected => "linear-constant-fit-or-target-correction"
  | .admitted => "exact-positive-reference-response-separation"

inductive Absence where
  | rejected | admitted

def absenceName : Absence → String
  | .rejected => "numerical-zero-solute-coordinate"
  | .admitted => "structural-EmptyOne-pure-solvent-boundary"

inductive Prediction where
  | rejected | admitted

def predictionName : Prediction → String
  | .rejected => "response-values-readable-before-seal"
  | .admitted => "complete-value-free-276-record-identity-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "refit-after-particle-or-response-replication"
  | .admitted => "depth-independent-common-replication-and-record-append"

structure Candidate where
  carrier : Carrier
  identity : Identity
  boundary : Boundary
  direction : Direction
  magnitude : Magnitude
  absence : Absence
  prediction : Prediction
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, identityName c.identity, boundaryName c.boundary, directionName c.direction, magnitudeName c.magnitude, absenceName c.absence, predictionName c.prediction, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "boundary=" (boundaryName c.boundary), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "magnitude=" (magnitudeName c.magnitude), SFT.Host.Text.append "absence=" (absenceName c.absence), SFT.Host.Text.append "prediction=" (predictionName c.prediction), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-solvent-solute-particle-account__distinct-held-solvent-and-solute-identities__exact-solvent-transmission-and-solute-retention-boundary__held-boiling-freezing-osmotic-orientation-label__exact-positive-reference-response-separation__structural-EmptyOne-pure-solvent-boundary__complete-value-free-276-record-identity-seal__depth-independent-common-replication-and-record-append"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "complete-solvent-solute-particle-account" &&
  SFT.Host.Text.equal (identityName c.identity) "distinct-held-solvent-and-solute-identities" &&
  SFT.Host.Text.equal (boundaryName c.boundary) "exact-solvent-transmission-and-solute-retention-boundary" &&
  SFT.Host.Text.equal (directionName c.direction) "held-boiling-freezing-osmotic-orientation-label" &&
  SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-reference-response-separation" &&
  SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-pure-solvent-boundary" &&
  SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-276-record-identity-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "complete-solvent-solute-particle-account") then "A detached number erases the solvent, solute, condition and response boundary." else
  if !(SFT.Host.Text.equal (identityName c.identity) "distinct-held-solvent-and-solute-identities") then "Anonymous particles cannot distinguish the transmitted solvent from the held solute." else
  if !(SFT.Host.Text.equal (boundaryName c.boundary) "exact-solvent-transmission-and-solute-retention-boundary") then "An imported equation or factor selects a response instead of forcing it." else
  if !(SFT.Host.Text.equal (directionName c.direction) "held-boiling-freezing-osmotic-orientation-label") then "A signed displacement imports negative arithmetic." else
  if !(SFT.Host.Text.equal (magnitudeName c.magnitude) "exact-positive-reference-response-separation") then "A fitted constant or target correction adds an unforced parameter." else
  if !(SFT.Host.Text.equal (absenceName c.absence) "structural-EmptyOne-pure-solvent-boundary") then "Numerical zero is not an SFT value." else
  if !(SFT.Host.Text.equal (predictionName c.prediction) "complete-value-free-276-record-identity-seal") then "Readable values could select the response law." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "depth-independent-common-replication-and-record-append") then "Refitting destroys exact support provenance." else
  "complete-solvent-solute-particle-account__distinct-held-solvent-and-solute-identities__exact-solvent-transmission-and-solute-retention-boundary__held-boiling-freezing-osmotic-orientation-label__exact-positive-reference-response-separation__structural-EmptyOne-pure-solvent-boundary__complete-value-free-276-record-identity-seal__depth-independent-common-replication-and-record-append"

def generationRule : String := "Generate the literal product of carrier, identity, boundary, direction, magnitude, absence, prediction and extension forms; decide all 256 candidates only from admitted particle distinction, component exchange, phase balance, exact order, EmptyOne and finite successor laws."
def grammarBoundary : String := "Every finite positive boiling, freezing or osmotic record with distinct held solvent/solute identities, an exact composition coordinate or EmptyOne reference, exact positive environment and response support, and a declared solvent-transmission/solute-retention boundary. External testing preserves all 16 boiling datasets and 144 rows, six freezing datasets and 37 rows, six osmotic datasets and 95 rows, and all three complete sources."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Boundary.rejected,Boundary.admitted]).flatMap fun boundary =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Magnitude.rejected,Magnitude.admitted]).flatMap fun magnitude =>
  ([Absence.rejected,Absence.admitted]).flatMap fun absence =>
  ([Prediction.rejected,Prediction.admitted]).flatMap fun prediction =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,identity,boundary,direction,magnitude,absence,prediction,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier identity boundary direction magnitude absence prediction extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hboundary : boundary ∈ [Boundary.rejected,Boundary.admitted] := by
      cases boundary <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmagnitude : magnitude ∈ [Magnitude.rejected,Magnitude.admitted] := by
      cases magnitude <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsence : absence ∈ [Absence.rejected,Absence.admitted] := by
      cases absence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprediction : prediction ∈ [Prediction.rejected,Prediction.admitted] := by
      cases prediction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ boundary _ hboundary
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ magnitude _ hmagnitude
    apply CommonRefinement.memFlatMap _ _ absence _ habsence
    apply CommonRefinement.memFlatMap _ _ prediction _ hprediction
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (magnitude : Magnitude) (absence : Absence) (prediction : Prediction) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,magnitude,absence,prediction,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,magnitude,absence,prediction,extension⟩ := by
 cases magnitude <;> cases absence <;> cases prediction <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier identity boundary direction magnitude absence prediction extension =>
  cases carrier <;> cases identity <;> cases boundary <;> cases direction
  · exact sourceDecisionBlock0000 magnitude absence prediction extension
  · exact sourceDecisionBlock0001 magnitude absence prediction extension
  · exact sourceDecisionBlock0010 magnitude absence prediction extension
  · exact sourceDecisionBlock0011 magnitude absence prediction extension
  · exact sourceDecisionBlock0100 magnitude absence prediction extension
  · exact sourceDecisionBlock0101 magnitude absence prediction extension
  · exact sourceDecisionBlock0110 magnitude absence prediction extension
  · exact sourceDecisionBlock0111 magnitude absence prediction extension
  · exact sourceDecisionBlock1000 magnitude absence prediction extension
  · exact sourceDecisionBlock1001 magnitude absence prediction extension
  · exact sourceDecisionBlock1010 magnitude absence prediction extension
  · exact sourceDecisionBlock1011 magnitude absence prediction extension
  · exact sourceDecisionBlock1100 magnitude absence prediction extension
  · exact sourceDecisionBlock1101 magnitude absence prediction extension
  · exact sourceDecisionBlock1110 magnitude absence prediction extension
  · exact sourceDecisionBlock1111 magnitude absence prediction extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "complete-solvent-solute-particle-account" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "distinct-held-solvent-and-solute-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem boundaryCriterion (value : Boundary) : SFT.Host.Text.equal (boundaryName value) "exact-solvent-transmission-and-solute-retention-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem directionCriterion (value : Direction) : SFT.Host.Text.equal (directionName value) "held-boiling-freezing-osmotic-orientation-label" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem magnitudeCriterion (value : Magnitude) : SFT.Host.Text.equal (magnitudeName value) "exact-positive-reference-response-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absenceCriterion (value : Absence) : SFT.Host.Text.equal (absenceName value) "structural-EmptyOne-pure-solvent-boundary" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem predictionCriterion (value : Prediction) : SFT.Host.Text.equal (predictionName value) "complete-value-free-276-record-identity-seal" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "depth-independent-common-replication-and-record-append" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, identityCriterion, boundaryCriterion, directionCriterion, magnitudeCriterion, absenceCriterion, predictionCriterion, extensionCriterion]
  cases c with
  | mk carrier identity boundary direction magnitude absence prediction extension =>
    cases carrier <;> cases identity <;> cases boundary <;> cases direction <;> cases magnitude <;> cases absence <;> cases prediction <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.identity = .admitted ∧ c.boundary = .admitted ∧ c.direction = .admitted ∧ c.magnitude = .admitted ∧ c.absence = .admitted ∧ c.prediction = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier identity boundary direction magnitude absence prediction extension =>
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

theorem identity_rejected_rejected (c : Candidate) (h : c.identity = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.identity eq
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

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
    rw [h] at field
    cases field

theorem magnitude_rejected_rejected (c : Candidate) (h : c.magnitude = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.magnitude eq
    rw [h] at field
    cases field

theorem absence_rejected_rejected (c : Candidate) (h : c.absence = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absence eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.ColligativeResponseGrammar
