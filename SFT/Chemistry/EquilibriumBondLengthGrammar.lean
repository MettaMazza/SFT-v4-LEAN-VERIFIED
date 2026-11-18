import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.EquilibriumBondLengthGrammar
set_option maxHeartbeats 100000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Identity where
  | rejected | admitted

def identityName : Identity → String
  | .rejected => "generic-diatomic-with-erased-state"
  | .admitted => "named-isotopologue-state-and-condition"

inductive Equilibrium where
  | rejected | admitted

def equilibriumName : Equilibrium → String
  | .rejected => "arbitrary-distance-sample"
  | .admitted => "configuration-minimum-distance"

inductive Scale where
  | rejected | admitted

def scaleName : Scale → String
  | .rejected => "free-angstrom-scale"
  | .admitted => "held-atomic-length-reference"

inductive Base where
  | rejected | admitted

def baseName : Base → String
  | .rejected => "free-leading-ratio"
  | .admitted => "up-support-over-down-support"

inductive Correction where
  | rejected | admitted

def correctionName : Correction → String
  | .rejected => "linear-or-open-correction-series"
  | .admitted => "binary-order-alpha-return"

inductive Isotope where
  | rejected | admitted

def isotopeName : Isotope → String
  | .rejected => "one-universal-isotope-correction"
  | .admitted => "distinct-light-and-heavy-typed-routes"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-readable-or-selected-value"
  | .admitted => "sealed-exact-interval-transport"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-species-term-or-fit"
  | .admitted => "finite-typed-vector-exhaustion"

structure Candidate where
  identity : Identity
  equilibrium : Equilibrium
  scale : Scale
  base : Base
  correction : Correction
  isotope : Isotope
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [identityName c.identity, equilibriumName c.equilibrium, scaleName c.scale, baseName c.base, correctionName c.correction, isotopeName c.isotope, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "identity=" (identityName c.identity), SFT.Host.Text.append "equilibrium=" (equilibriumName c.equilibrium), SFT.Host.Text.append "scale=" (scaleName c.scale), SFT.Host.Text.append "base=" (baseName c.base), SFT.Host.Text.append "correction=" (correctionName c.correction), SFT.Host.Text.append "isotope=" (isotopeName c.isotope), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "named-isotopologue-state-and-condition__configuration-minimum-distance__held-atomic-length-reference__up-support-over-down-support__binary-order-alpha-return__distinct-light-and-heavy-typed-routes__sealed-exact-interval-transport__finite-typed-vector-exhaustion"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (identityName c.identity) "named-isotopologue-state-and-condition" &&
  SFT.Host.Text.equal (equilibriumName c.equilibrium) "configuration-minimum-distance" &&
  SFT.Host.Text.equal (scaleName c.scale) "held-atomic-length-reference" &&
  SFT.Host.Text.equal (baseName c.base) "up-support-over-down-support" &&
  SFT.Host.Text.equal (correctionName c.correction) "binary-order-alpha-return" &&
  SFT.Host.Text.equal (isotopeName c.isotope) "distinct-light-and-heavy-typed-routes" &&
  SFT.Host.Text.equal (measurementName c.measurement) "sealed-exact-interval-transport" &&
  SFT.Host.Text.equal (extensionName c.extension) "finite-typed-vector-exhaustion"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (identityName c.identity) "named-isotopologue-state-and-condition") then "A generic diatomic label cannot own a quantitative molecular value." else
  if !(SFT.Host.Text.equal (equilibriumName c.equilibrium) "configuration-minimum-distance") then "A sampled distance is not the generated equilibrium fixed point." else
  if !(SFT.Host.Text.equal (scaleName c.scale) "held-atomic-length-reference") then "A freely chosen physical scale is a fitted parameter." else
  if !(SFT.Host.Text.equal (baseName c.base) "up-support-over-down-support") then "A chosen leading ratio can place the prediction near any target." else
  if !(SFT.Host.Text.equal (correctionName c.correction) "binary-order-alpha-return") then "A linear or open series has no typed closure and can be extended to fit." else
  if !(SFT.Host.Text.equal (isotopeName c.isotope) "distinct-light-and-heavy-typed-routes") then "One correction erases the admitted nuclear-support distinction." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "sealed-exact-interval-transport") then "Target-readable execution cannot provide an empirical prediction seal." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "finite-typed-vector-exhaustion") then "A species correction not generated by the typed boundary is a free parameter." else
  "named-isotopologue-state-and-condition__configuration-minimum-distance__held-atomic-length-reference__up-support-over-down-support__binary-order-alpha-return__distinct-light-and-heavy-typed-routes__sealed-exact-interval-transport__finite-typed-vector-exhaustion"

def generationRule : String := "Generate the literal product of molecular identity, equilibrium ownership, scale, common base, correction order, isotopologue route, measurement custody and extension forms; decide all 256 from the admitted Fold support and spectroscopy carriers."
def grammarBoundary : String := "The complete registered H2 and D2 homonuclear-hydrogen X 1Sigma_g+ gas-phase equilibrium-distance vector, using one held atomic-length reference, the exact alpha carrier and each generated up, down, generator and terminal support only in its typed slot."

def candidates : List Candidate :=
  ([Identity.rejected,Identity.admitted]).flatMap fun identity =>
  ([Equilibrium.rejected,Equilibrium.admitted]).flatMap fun equilibrium =>
  ([Scale.rejected,Scale.admitted]).flatMap fun scale =>
  ([Base.rejected,Base.admitted]).flatMap fun base =>
  ([Correction.rejected,Correction.admitted]).flatMap fun correction =>
  ([Isotope.rejected,Isotope.admitted]).flatMap fun isotope =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨identity,equilibrium,scale,base,correction,isotope,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk identity equilibrium scale base correction isotope measurement extension =>
    have hidentity : identity ∈ [Identity.rejected,Identity.admitted] := by
      cases identity <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hequilibrium : equilibrium ∈ [Equilibrium.rejected,Equilibrium.admitted] := by
      cases equilibrium <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hscale : scale ∈ [Scale.rejected,Scale.admitted] := by
      cases scale <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbase : base ∈ [Base.rejected,Base.admitted] := by
      cases base <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcorrection : correction ∈ [Correction.rejected,Correction.admitted] := by
      cases correction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hisotope : isotope ∈ [Isotope.rejected,Isotope.admitted] := by
      cases isotope <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ identity _ hidentity
    apply CommonRefinement.memFlatMap _ _ equilibrium _ hequilibrium
    apply CommonRefinement.memFlatMap _ _ scale _ hscale
    apply CommonRefinement.memFlatMap _ _ base _ hbase
    apply CommonRefinement.memFlatMap _ _ correction _ hcorrection
    apply CommonRefinement.memFlatMap _ _ isotope _ hisotope
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (correction : Correction) (isotope : Isotope) (measurement : Measurement) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,correction,isotope,measurement,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,correction,isotope,measurement,extension⟩ := by
 cases correction <;> cases isotope <;> cases measurement <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk identity equilibrium scale base correction isotope measurement extension =>
  cases identity <;> cases equilibrium <;> cases scale <;> cases base
  · exact sourceDecisionBlock0000 correction isotope measurement extension
  · exact sourceDecisionBlock0001 correction isotope measurement extension
  · exact sourceDecisionBlock0010 correction isotope measurement extension
  · exact sourceDecisionBlock0011 correction isotope measurement extension
  · exact sourceDecisionBlock0100 correction isotope measurement extension
  · exact sourceDecisionBlock0101 correction isotope measurement extension
  · exact sourceDecisionBlock0110 correction isotope measurement extension
  · exact sourceDecisionBlock0111 correction isotope measurement extension
  · exact sourceDecisionBlock1000 correction isotope measurement extension
  · exact sourceDecisionBlock1001 correction isotope measurement extension
  · exact sourceDecisionBlock1010 correction isotope measurement extension
  · exact sourceDecisionBlock1011 correction isotope measurement extension
  · exact sourceDecisionBlock1100 correction isotope measurement extension
  · exact sourceDecisionBlock1101 correction isotope measurement extension
  · exact sourceDecisionBlock1110 correction isotope measurement extension
  · exact sourceDecisionBlock1111 correction isotope measurement extension

theorem identityCriterion (value : Identity) : SFT.Host.Text.equal (identityName value) "named-isotopologue-state-and-condition" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem equilibriumCriterion (value : Equilibrium) : SFT.Host.Text.equal (equilibriumName value) "configuration-minimum-distance" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem scaleCriterion (value : Scale) : SFT.Host.Text.equal (scaleName value) "held-atomic-length-reference" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem baseCriterion (value : Base) : SFT.Host.Text.equal (baseName value) "up-support-over-down-support" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem correctionCriterion (value : Correction) : SFT.Host.Text.equal (correctionName value) "binary-order-alpha-return" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem isotopeCriterion (value : Isotope) : SFT.Host.Text.equal (isotopeName value) "distinct-light-and-heavy-typed-routes" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem measurementCriterion (value : Measurement) : SFT.Host.Text.equal (measurementName value) "sealed-exact-interval-transport" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "finite-typed-vector-exhaustion" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [identityCriterion, equilibriumCriterion, scaleCriterion, baseCriterion, correctionCriterion, isotopeCriterion, measurementCriterion, extensionCriterion]
  cases c with
  | mk identity equilibrium scale base correction isotope measurement extension =>
    cases identity <;> cases equilibrium <;> cases scale <;> cases base <;> cases correction <;> cases isotope <;> cases measurement <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.identity = .admitted ∧ c.equilibrium = .admitted ∧ c.scale = .admitted ∧ c.base = .admitted ∧ c.correction = .admitted ∧ c.isotope = .admitted ∧ c.measurement = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk identity equilibrium scale base correction isotope measurement extension =>
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

theorem equilibrium_rejected_rejected (c : Candidate) (h : c.equilibrium = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.equilibrium eq
    rw [h] at field
    cases field

theorem scale_rejected_rejected (c : Candidate) (h : c.scale = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.scale eq
    rw [h] at field
    cases field

theorem base_rejected_rejected (c : Candidate) (h : c.base = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.base eq
    rw [h] at field
    cases field

theorem correction_rejected_rejected (c : Candidate) (h : c.correction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.correction eq
    rw [h] at field
    cases field

theorem isotope_rejected_rejected (c : Candidate) (h : c.isotope = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.isotope eq
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

theorem extension_rejected_rejected (c : Candidate) (h : c.extension = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.extension eq
    rw [h] at field
    cases field

end SFT.Chemistry.EquilibriumBondLengthGrammar
