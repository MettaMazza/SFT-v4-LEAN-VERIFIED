import SFT.Physics.GravityFlux
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.NuclearBindingCurveEntryGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Predecessor where
  | rejected | admitted

def predecessorName : Predecessor → String
  | .rejected => "rewrite-predecessor-laws"
  | .admitted => "compose-immutable-predecessors"

inductive Bulk where
  | rejected | admitted

def bulkName : Bulk → String
  | .rejected => "unbounded-pairwise-bulk-growth"
  | .admitted => "one-saturating-bulk-support"

inductive Surface where
  | rejected | admitted

def surfaceName : Surface → String
  | .rejected => "fitted-surface-coefficient"
  | .admitted => "one-over-binary-plus-generator-interface"

inductive Coulomb where
  | rejected | admitted

def coulombName : Coulomb → String
  | .rejected => "import-semi-empirical-coulomb-term"
  | .admitted => "exact-alpha-times-ordered-charge-paths"

inductive Asymmetry where
  | rejected | admitted

def asymmetryName : Asymmetry → String
  | .rejected => "chosen-asymmetry-penalty"
  | .admitted => "quarter-order-unmatched-label-square"

inductive Pairing where
  | rejected | admitted

def pairingName : Pairing → String
  | .rejected => "fitted-pairing-term"
  | .admitted => "quarter-order-paired-gain-unpaired-loss"

inductive Radius where
  | rejected | admitted

def radiusName : Radius → String
  | .rejected => "evaluate-irrational-radius"
  | .admitted => "rational-enclosures-until-order-separates"

inductive Maximum where
  | rejected | admitted

def maximumName : Maximum → String
  | .rejected => "selected-isotope-window"
  | .admitted => "complete-concave-census-plus-forced-tail-induction"

inductive Target where
  | rejected | admitted

def targetName : Target → String
  | .rejected => "external-target-readable"
  | .admitted => "target-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-or-residual"
  | .admitted => "no-extra-rule"

structure Candidate where
  predecessor : Predecessor
  bulk : Bulk
  surface : Surface
  coulomb : Coulomb
  asymmetry : Asymmetry
  pairing : Pairing
  radius : Radius
  maximum : Maximum
  target : Target
  extension : Extension

def sourceFields (c : Candidate) : List String := [predecessorName c.predecessor, bulkName c.bulk, surfaceName c.surface, coulombName c.coulomb, asymmetryName c.asymmetry, pairingName c.pairing, radiusName c.radius, maximumName c.maximum, targetName c.target, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "predecessor=" (predecessorName c.predecessor), SFT.Host.Text.append "bulk=" (bulkName c.bulk), SFT.Host.Text.append "surface=" (surfaceName c.surface), SFT.Host.Text.append "coulomb=" (coulombName c.coulomb), SFT.Host.Text.append "asymmetry=" (asymmetryName c.asymmetry), SFT.Host.Text.append "pairing=" (pairingName c.pairing), SFT.Host.Text.append "radius=" (radiusName c.radius), SFT.Host.Text.append "maximum=" (maximumName c.maximum), SFT.Host.Text.append "target=" (targetName c.target), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "compose-immutable-predecessors__one-saturating-bulk-support__one-over-binary-plus-generator-interface__exact-alpha-times-ordered-charge-paths__quarter-order-unmatched-label-square__quarter-order-paired-gain-unpaired-loss__rational-enclosures-until-order-separates__complete-concave-census-plus-forced-tail-induction__target-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (predecessorName c.predecessor) "compose-immutable-predecessors" &&
  SFT.Host.Text.equal (bulkName c.bulk) "one-saturating-bulk-support" &&
  SFT.Host.Text.equal (surfaceName c.surface) "one-over-binary-plus-generator-interface" &&
  SFT.Host.Text.equal (coulombName c.coulomb) "exact-alpha-times-ordered-charge-paths" &&
  SFT.Host.Text.equal (asymmetryName c.asymmetry) "quarter-order-unmatched-label-square" &&
  SFT.Host.Text.equal (pairingName c.pairing) "quarter-order-paired-gain-unpaired-loss" &&
  SFT.Host.Text.equal (radiusName c.radius) "rational-enclosures-until-order-separates" &&
  SFT.Host.Text.equal (maximumName c.maximum) "complete-concave-census-plus-forced-tail-induction" &&
  SFT.Host.Text.equal (targetName c.target) "target-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (predecessorName c.predecessor) "rewrite-predecessor-laws" then "A successor cannot alter admitted receipts." else
  if SFT.Host.Text.equal (bulkName c.bulk) "unbounded-pairwise-bulk-growth" then "Short-range saturation forbids growth with every distant constituent." else
  if SFT.Host.Text.equal (surfaceName c.surface) "fitted-surface-coefficient" then "A fitted coefficient is a parameter." else
  if SFT.Host.Text.equal (coulombName c.coulomb) "import-semi-empirical-coulomb-term" then "An imported mass formula cannot select the law." else
  if SFT.Host.Text.equal (asymmetryName c.asymmetry) "chosen-asymmetry-penalty" then "A chosen coefficient is not forced." else
  if SFT.Host.Text.equal (pairingName c.pairing) "fitted-pairing-term" then "A fitted parity correction is a parameter." else
  if SFT.Host.Text.equal (radiusName c.radius) "evaluate-irrational-radius" then "Irrational values are outside the exact proof domain." else
  if SFT.Host.Text.equal (maximumName c.maximum) "selected-isotope-window" then "A chosen neighborhood cannot prove a global maximum." else
  if SFT.Host.Text.equal (targetName c.target) "external-target-readable" then "Target access would fit the isotope coordinate." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-coefficient-or-residual" then "An ungenerated correction destroys zero-parameter closure." else
  "The unique zero-parameter normalized binding maximum over every positive proton/neutron composition is A=62, Z=28, N=34. The exact ledger is bulk One; radial surface loss (1/5)/A^(1/3) represented only by rational enclosures; Coulomb loss alpha*Z*(Z-1)/A^(4/3); quarter-order asymmetry loss (1/4)*(N-Z)^2/A^2; and quarter-order parity gain/loss (1/4)/A^(4/3)."

def generationRule : String := "Generate the complete ten-axis predecessor, bulk, surface, Coulomb, asymmetry, pairing, radius, maximum, target-custody and extension product."
def grammarBoundary : String := "Every positive proton/neutron composite, exact saturated bulk, forced 1/5 interface share, exact alpha ordered charge path, quarter-order imbalance/pairing class, rational rank-two/rank-three enclosure and every mass beyond the forced 4096 tail boundary."

def candidates : List Candidate :=
  ([Predecessor.rejected,Predecessor.admitted]).flatMap fun predecessor =>
  ([Bulk.rejected,Bulk.admitted]).flatMap fun bulk =>
  ([Surface.rejected,Surface.admitted]).flatMap fun surface =>
  ([Coulomb.rejected,Coulomb.admitted]).flatMap fun coulomb =>
  ([Asymmetry.rejected,Asymmetry.admitted]).flatMap fun asymmetry =>
  ([Pairing.rejected,Pairing.admitted]).flatMap fun pairing =>
  ([Radius.rejected,Radius.admitted]).flatMap fun radius =>
  ([Maximum.rejected,Maximum.admitted]).flatMap fun maximum =>
  ([Target.rejected,Target.admitted]).flatMap fun target =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨predecessor,bulk,surface,coulomb,asymmetry,pairing,radius,maximum,target,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk predecessor bulk surface coulomb asymmetry pairing radius maximum target extension =>
    have hpredecessor : predecessor ∈ [Predecessor.rejected,Predecessor.admitted] := by
      cases predecessor <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hbulk : bulk ∈ [Bulk.rejected,Bulk.admitted] := by
      cases bulk <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsurface : surface ∈ [Surface.rejected,Surface.admitted] := by
      cases surface <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoulomb : coulomb ∈ [Coulomb.rejected,Coulomb.admitted] := by
      cases coulomb <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hasymmetry : asymmetry ∈ [Asymmetry.rejected,Asymmetry.admitted] := by
      cases asymmetry <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpairing : pairing ∈ [Pairing.rejected,Pairing.admitted] := by
      cases pairing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hradius : radius ∈ [Radius.rejected,Radius.admitted] := by
      cases radius <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmaximum : maximum ∈ [Maximum.rejected,Maximum.admitted] := by
      cases maximum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htarget : target ∈ [Target.rejected,Target.admitted] := by
      cases target <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ predecessor _ hpredecessor
    apply CommonRefinement.memFlatMap _ _ bulk _ hbulk
    apply CommonRefinement.memFlatMap _ _ surface _ hsurface
    apply CommonRefinement.memFlatMap _ _ coulomb _ hcoulomb
    apply CommonRefinement.memFlatMap _ _ asymmetry _ hasymmetry
    apply CommonRefinement.memFlatMap _ _ pairing _ hpairing
    apply CommonRefinement.memFlatMap _ _ radius _ hradius
    apply CommonRefinement.memFlatMap _ _ maximum _ hmaximum
    apply CommonRefinement.memFlatMap _ _ target _ htarget
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.NuclearBindingCurveEntryGrammar
