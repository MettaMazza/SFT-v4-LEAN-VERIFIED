import SFT.Foundation.CommonRefinement
import SFT.Foundation.CommonRefinement
namespace SFT.Chemistry.InorganicColourGrammar
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
set_option maxHeartbeats 20000000
open SFT.Foundation
set_option maxRecDepth 20000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "anonymous-complex-transition"
  | .admitted => "one-retained-coordination-entity"

inductive Endpoints where
  | rejected | admitted

def endpointsName : Endpoints → String
  | .rejected => "imported-orbital-symbol-pair"
  | .admitted => "complete-ligand-metal-carrier-pair"

inductive State where
  | rejected | admitted

def stateName : State → String
  | .rejected => "energy-only-endpoints"
  | .admitted => "two-retained-state-identities"

inductive Direction where
  | rejected | admitted

def directionName : Direction → String
  | .rejected => "signed-charge-displacement"
  | .admitted => "held-source-target-direction"

inductive Gap where
  | rejected | admitted

def gapName : Gap → String
  | .rejected => "floating-or-dimensional-energy-gap"
  | .admitted => "positive-state-order-separation"

inductive Absorption where
  | rejected | admitted

def absorptionName : Absorption → String
  | .rejected => "selected-colour-name"
  | .admitted => "proper-absorbed-distinction-class"

inductive Colour where
  | rejected | admitted

def colourName : Colour → String
  | .rejected => "conventional-colour-wheel"
  | .admitted => "retained-complement-observation-class"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "species-peak-or-threshold-exception"
  | .admitted => "complete-spectra-with-no-extra-rule"

structure Candidate where
  carrier : Carrier
  endpoints : Endpoints
  state : State
  direction : Direction
  gap : Gap
  absorption : Absorption
  colour : Colour
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, endpointsName c.endpoints, stateName c.state, directionName c.direction, gapName c.gap, absorptionName c.absorption, colourName c.colour, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "endpoints=" (endpointsName c.endpoints), SFT.Host.Text.append "state=" (stateName c.state), SFT.Host.Text.append "direction=" (directionName c.direction), SFT.Host.Text.append "gap=" (gapName c.gap), SFT.Host.Text.append "absorption=" (absorptionName c.absorption), SFT.Host.Text.append "colour=" (colourName c.colour), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "one-retained-coordination-entity__complete-ligand-metal-carrier-pair__two-retained-state-identities__held-source-target-direction__positive-state-order-separation__proper-absorbed-distinction-class__retained-complement-observation-class__complete-spectra-with-no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "one-retained-coordination-entity" &&
  SFT.Host.Text.equal (endpointsName c.endpoints) "complete-ligand-metal-carrier-pair" &&
  SFT.Host.Text.equal (stateName c.state) "two-retained-state-identities" &&
  SFT.Host.Text.equal (directionName c.direction) "held-source-target-direction" &&
  SFT.Host.Text.equal (gapName c.gap) "positive-state-order-separation" &&
  SFT.Host.Text.equal (absorptionName c.absorption) "proper-absorbed-distinction-class" &&
  SFT.Host.Text.equal (colourName c.colour) "retained-complement-observation-class" &&
  SFT.Host.Text.equal (extensionName c.extension) "complete-spectra-with-no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (carrierName c.carrier) "one-retained-coordination-entity") then "An anonymous transition erases which retained complex carries it." else
  if !(SFT.Host.Text.equal (endpointsName c.endpoints) "complete-ligand-metal-carrier-pair") then "Conventional orbital names would select the endpoint grammar." else
  if !(SFT.Host.Text.equal (stateName c.state) "two-retained-state-identities") then "Energy-only endpoints lose electronic-state identity." else
  if !(SFT.Host.Text.equal (directionName c.direction) "held-source-target-direction") then "A signed scalar imports negative quantity and erases endpoint direction." else
  if !(SFT.Host.Text.equal (gapName c.gap) "positive-state-order-separation") then "A dimensional or floating gap imports an unforced scale." else
  if !(SFT.Host.Text.equal (absorptionName c.absorption) "proper-absorbed-distinction-class") then "A named colour cannot establish what distinction was absorbed." else
  if !(SFT.Host.Text.equal (colourName c.colour) "retained-complement-observation-class") then "A colour wheel imports a continuum convention into forcing." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "complete-spectra-with-no-extra-rule") then "A selected peak or smoothing threshold can manufacture agreement." else
  "one-retained-coordination-entity__complete-ligand-metal-carrier-pair__two-retained-state-identities__held-source-target-direction__positive-state-order-separation__proper-absorbed-distinction-class__retained-complement-observation-class__complete-spectra-with-no-extra-rule"

def generationRule : String := "Generate the literal product of carrier, endpoints, state, direction, gap, absorption, colour and extension choices; decide all 256 candidates only from admitted distinction, order, transition, selection-rule and INORG-004/006/007 dependencies."
def grammarBoundary : String := "Every ordered ligand/metal carrier pair in one retained coordination entity; every positive exact state successor; every positive proper absorbed subset of a finite complete incident observation support; four frozen definitions and four immutable complete NIST spectra with original custody classes preserved."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Endpoints.rejected,Endpoints.admitted]).flatMap fun endpoints =>
  ([State.rejected,State.admitted]).flatMap fun state =>
  ([Direction.rejected,Direction.admitted]).flatMap fun direction =>
  ([Gap.rejected,Gap.admitted]).flatMap fun gap =>
  ([Absorption.rejected,Absorption.admitted]).flatMap fun absorption =>
  ([Colour.rejected,Colour.admitted]).flatMap fun colour =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,endpoints,state,direction,gap,absorption,colour,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 256 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier endpoints state direction gap absorption colour extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hendpoints : endpoints ∈ [Endpoints.rejected,Endpoints.admitted] := by
      cases endpoints <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstate : state ∈ [State.rejected,State.admitted] := by
      cases state <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirection : direction ∈ [Direction.rejected,Direction.admitted] := by
      cases direction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgap : gap ∈ [Gap.rejected,Gap.admitted] := by
      cases gap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have habsorption : absorption ∈ [Absorption.rejected,Absorption.admitted] := by
      cases absorption <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcolour : colour ∈ [Colour.rejected,Colour.admitted] := by
      cases colour <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ endpoints _ hendpoints
    apply CommonRefinement.memFlatMap _ _ state _ hstate
    apply CommonRefinement.memFlatMap _ _ direction _ hdirection
    apply CommonRefinement.memFlatMap _ _ gap _ hgap
    apply CommonRefinement.memFlatMap _ _ absorption _ habsorption
    apply CommonRefinement.memFlatMap _ _ colour _ hcolour
    exact Count.TraceDerivation.memMap _ extension _ hextension

theorem sourceDecisionBlock0000 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0001 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.rejected,.rejected,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.rejected,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0010 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0011 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.rejected,.admitted,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.rejected,.admitted,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0100 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0101 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.admitted,.rejected,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.rejected,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0110 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock0111 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.rejected,.admitted,.admitted,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.rejected,.admitted,.admitted,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1000 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1001 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.rejected,.rejected,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.rejected,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1010 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1011 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.rejected,.admitted,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.rejected,.admitted,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1100 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1101 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.admitted,.rejected,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.rejected,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1110 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.rejected,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.rejected,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionBlock1111 (gap : Gap) (absorption : Absorption) (colour : Colour) (extension : Extension) :
 survives ⟨.admitted,.admitted,.admitted,.admitted,gap,absorption,colour,extension⟩ = criteriaDecision ⟨.admitted,.admitted,.admitted,.admitted,gap,absorption,colour,extension⟩ := by
 cases gap <;> cases absorption <;> cases colour <;> cases extension <;> rfl

theorem sourceDecisionMatchesCriteria (c : Candidate) : survives c = criteriaDecision c := by
 cases c with
 | mk carrier endpoints state direction gap absorption colour extension =>
  cases carrier <;> cases endpoints <;> cases state <;> cases direction
  · exact sourceDecisionBlock0000 gap absorption colour extension
  · exact sourceDecisionBlock0001 gap absorption colour extension
  · exact sourceDecisionBlock0010 gap absorption colour extension
  · exact sourceDecisionBlock0011 gap absorption colour extension
  · exact sourceDecisionBlock0100 gap absorption colour extension
  · exact sourceDecisionBlock0101 gap absorption colour extension
  · exact sourceDecisionBlock0110 gap absorption colour extension
  · exact sourceDecisionBlock0111 gap absorption colour extension
  · exact sourceDecisionBlock1000 gap absorption colour extension
  · exact sourceDecisionBlock1001 gap absorption colour extension
  · exact sourceDecisionBlock1010 gap absorption colour extension
  · exact sourceDecisionBlock1011 gap absorption colour extension
  · exact sourceDecisionBlock1100 gap absorption colour extension
  · exact sourceDecisionBlock1101 gap absorption colour extension
  · exact sourceDecisionBlock1110 gap absorption colour extension
  · exact sourceDecisionBlock1111 gap absorption colour extension

theorem carrierCriterion (value : Carrier) : SFT.Host.Text.equal (carrierName value) "one-retained-coordination-entity" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem endpointsCriterion (value : Endpoints) : SFT.Host.Text.equal (endpointsName value) "complete-ligand-metal-carrier-pair" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem stateCriterion (value : State) : SFT.Host.Text.equal (stateName value) "two-retained-state-identities" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem directionCriterion (value : Direction) : SFT.Host.Text.equal (directionName value) "held-source-target-direction" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem gapCriterion (value : Gap) : SFT.Host.Text.equal (gapName value) "positive-state-order-separation" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem absorptionCriterion (value : Absorption) : SFT.Host.Text.equal (absorptionName value) "proper-absorbed-distinction-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem colourCriterion (value : Colour) : SFT.Host.Text.equal (colourName value) "retained-complement-observation-class" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

theorem extensionCriterion (value : Extension) : SFT.Host.Text.equal (extensionName value) "complete-spectra-with-no-extra-rule" = (match value with | .rejected => false | .admitted => true) := by
 cases value <;> rfl

set_option maxHeartbeats 10000000 in
theorem uniqueCriteriaSurvivor (c : Candidate) : criteriaDecision c = true ↔ c = survivor := by
  unfold criteriaDecision
  rw [carrierCriterion, endpointsCriterion, stateCriterion, directionCriterion, gapCriterion, absorptionCriterion, colourCriterion, extensionCriterion]
  cases c with
  | mk carrier endpoints state direction gap absorption colour extension =>
    cases carrier <;> cases endpoints <;> cases state <;> cases direction <;> cases gap <;> cases absorption <;> cases colour <;> cases extension
    all_goals constructor <;> intro h <;> first | rfl | cases h

theorem uniqueSurvivor (c : Candidate) : survives c = true ↔ c = survivor := by
  rw [sourceDecisionMatchesCriteria]
  exact uniqueCriteriaSurvivor c

theorem survivorAccepted : survives survivor = true := rfl

def ExactCriteria (c : Candidate) : Prop :=
  c.carrier = .admitted ∧ c.endpoints = .admitted ∧ c.state = .admitted ∧ c.direction = .admitted ∧ c.gap = .admitted ∧ c.absorption = .admitted ∧ c.colour = .admitted ∧ c.extension = .admitted

theorem acceptanceIffExactCriteria (c : Candidate) : survives c = true ↔ ExactCriteria c := by
  constructor
  · intro h
    have eq := (uniqueSurvivor c).mp h
    cases eq
    exact ⟨rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl⟩
  · intro h
    cases c with
    | mk carrier endpoints state direction gap absorption colour extension =>
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

theorem endpoints_rejected_rejected (c : Candidate) (h : c.endpoints = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.endpoints eq
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

theorem direction_rejected_rejected (c : Candidate) (h : c.direction = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.direction eq
    rw [h] at field
    cases field

theorem gap_rejected_rejected (c : Candidate) (h : c.gap = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.gap eq
    rw [h] at field
    cases field

theorem absorption_rejected_rejected (c : Candidate) (h : c.absorption = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.absorption eq
    rw [h] at field
    cases field

theorem colour_rejected_rejected (c : Candidate) (h : c.colour = .rejected) : survives c = false := by
  cases hs : survives c with
  | false => rfl
  | true =>
    have eq := (uniqueSurvivor c).mp hs
    have field := congrArg Candidate.colour eq
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

end SFT.Chemistry.InorganicColourGrammar
