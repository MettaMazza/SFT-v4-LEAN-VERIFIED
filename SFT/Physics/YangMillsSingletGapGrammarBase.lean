import SFT.Physics.YangMillsSingletGap
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.YangMillsSingletGapGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Sector where
  | rejected | admitted

def sectorName : Sector → String
  | .rejected => "named-Yang-Mills-sector"
  | .admitted => "generated-colour-three-sector"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "isolated-colour-carrier"
  | .admitted => "complete-colour-singlet-support"

inductive Vacuum where
  | rejected | admitted

def vacuumName : Vacuum → String
  | .rejected => "numerical-zero-vacuum"
  | .admitted => "empty-excitation-record"

inductive Gap where
  | rejected | admitted

def gapName : Gap → String
  | .rejected => "massless-or-fitted-gap"
  | .admitted => "exact-positive-one-third-complement"

inductive Confinement where
  | rejected | admitted

def confinementName : Confinement → String
  | .rejected => "bounded-or-free-separation-work"
  | .admitted => "fixed-two-thirds-positive-work-successor"

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "conflate-local-carrier-with-physical-singlet"
  | .admitted => "retain-local-massless-physical-gapped-distinction"

inductive Orbit where
  | rejected | admitted

def orbitName : Orbit → String
  | .rejected => "selected-gap-coupling-pair"
  | .admitted => "complete-period-two-Fold-partition"

inductive Depth where
  | rejected | admitted

def depthName : Depth → String
  | .rejected => "bounded-depth-census-or-completed-infinity"
  | .admitted => "positive-finite-successor-induction"

inductive Prior where
  | rejected | admitted

def priorName : Prior → String
  | .rejected => "repeat-no-massless-strong-excitation"
  | .admitted => "correct-free-singlet-spectrum-boundary"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-scale-action-or-continuum-limit"
  | .admitted => "no-extra-rule"

structure Candidate where
  sector : Sector
  support : Support
  vacuum : Vacuum
  gap : Gap
  confinement : Confinement
  carrier : Carrier
  orbit : Orbit
  depth : Depth
  prior : Prior
  extension : Extension

def sourceFields (c : Candidate) : List String := [sectorName c.sector, supportName c.support, vacuumName c.vacuum, gapName c.gap, confinementName c.confinement, carrierName c.carrier, orbitName c.orbit, depthName c.depth, priorName c.prior, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sector=" (sectorName c.sector), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "vacuum=" (vacuumName c.vacuum), SFT.Host.Text.append "gap=" (gapName c.gap), SFT.Host.Text.append "confinement=" (confinementName c.confinement), SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "orbit=" (orbitName c.orbit), SFT.Host.Text.append "depth=" (depthName c.depth), SFT.Host.Text.append "prior=" (priorName c.prior), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "generated-colour-three-sector__complete-colour-singlet-support__empty-excitation-record__exact-positive-one-third-complement__fixed-two-thirds-positive-work-successor__retain-local-massless-physical-gapped-distinction__complete-period-two-Fold-partition__positive-finite-successor-induction__correct-free-singlet-spectrum-boundary__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sectorName c.sector) "generated-colour-three-sector" &&
  SFT.Host.Text.equal (supportName c.support) "complete-colour-singlet-support" &&
  SFT.Host.Text.equal (vacuumName c.vacuum) "empty-excitation-record" &&
  SFT.Host.Text.equal (gapName c.gap) "exact-positive-one-third-complement" &&
  SFT.Host.Text.equal (confinementName c.confinement) "fixed-two-thirds-positive-work-successor" &&
  SFT.Host.Text.equal (carrierName c.carrier) "retain-local-massless-physical-gapped-distinction" &&
  SFT.Host.Text.equal (orbitName c.orbit) "complete-period-two-Fold-partition" &&
  SFT.Host.Text.equal (depthName c.depth) "positive-finite-successor-induction" &&
  SFT.Host.Text.equal (priorName c.prior) "correct-free-singlet-spectrum-boundary" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (sectorName c.sector) "named-Yang-Mills-sector" then "A conventional name does not generate colour structure." else
  if SFT.Host.Text.equal (supportName c.support) "isolated-colour-carrier" then "The admitted confinement law leaves the isolated-colour observation record empty." else
  if SFT.Host.Text.equal (vacuumName c.vacuum) "numerical-zero-vacuum" then "Numerical zero is outside the Fold proof domain." else
  if SFT.Host.Text.equal (gapName c.gap) "massless-or-fitted-gap" then "A fitted value or an empty mass label conflates local carrier and physical singlet." else
  if SFT.Host.Text.equal (confinementName c.confinement) "bounded-or-free-separation-work" then "Bounded or free work permits an unrecorded free colour state." else
  if SFT.Host.Text.equal (carrierName c.carrier) "conflate-local-carrier-with-physical-singlet" then "The local carrier is not an observable isolated colour state." else
  if SFT.Host.Text.equal (orbitName c.orbit) "selected-gap-coupling-pair" then "A selected pair does not prove closure or recurrence." else
  if SFT.Host.Text.equal (depthName c.depth) "bounded-depth-census-or-completed-infinity" then "A bounded sample or completed infinity cannot certify every finite successor." else
  if SFT.Host.Text.equal (priorName c.prior) "repeat-no-massless-strong-excitation" then "That wording contradicts the admitted locally massless strong carrier." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-scale-action-or-continuum-limit" then "An added scale or action is a new premise." else
  "Within the complete finite Fold colour grammar, the least observable colour singlet has normalized gap one-third above the empty excitation record at every positive finite depth; confinement work advances by two-thirds; the two shares form a period-two partition of the One; and the locally massless confined carrier is retained without being mistaken for a free gapless physical singlet."

def generationRule : String := "Generate the complete product of colour sector, observable support, vacuum boundary, gap carrier, confinement work, local-carrier distinction, Fold orbit, depth closure, prior-claim correction and extension forms."
def grammarBoundary : String := "The generated colour-three Fold sector, its complete antipodal and three-member singlet supports, every positive finite separation/depth successor, the locally massless confined carrier and the normalized One partition. No continuum field action or completed infinite-volume limit is asserted."

def candidates : List Candidate :=
  ([Sector.rejected,Sector.admitted]).flatMap fun sector =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Vacuum.rejected,Vacuum.admitted]).flatMap fun vacuum =>
  ([Gap.rejected,Gap.admitted]).flatMap fun gap =>
  ([Confinement.rejected,Confinement.admitted]).flatMap fun confinement =>
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Orbit.rejected,Orbit.admitted]).flatMap fun orbit =>
  ([Depth.rejected,Depth.admitted]).flatMap fun depth =>
  ([Prior.rejected,Prior.admitted]).flatMap fun prior =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨sector,support,vacuum,gap,confinement,carrier,orbit,depth,prior,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk sector support vacuum gap confinement carrier orbit depth prior extension =>
    have hsector : sector ∈ [Sector.rejected,Sector.admitted] := by
      cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hvacuum : vacuum ∈ [Vacuum.rejected,Vacuum.admitted] := by
      cases vacuum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hgap : gap ∈ [Gap.rejected,Gap.admitted] := by
      cases gap <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hconfinement : confinement ∈ [Confinement.rejected,Confinement.admitted] := by
      cases confinement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horbit : orbit ∈ [Orbit.rejected,Orbit.admitted] := by
      cases orbit <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdepth : depth ∈ [Depth.rejected,Depth.admitted] := by
      cases depth <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hprior : prior ∈ [Prior.rejected,Prior.admitted] := by
      cases prior <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ sector _ hsector
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ vacuum _ hvacuum
    apply CommonRefinement.memFlatMap _ _ gap _ hgap
    apply CommonRefinement.memFlatMap _ _ confinement _ hconfinement
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ orbit _ horbit
    apply CommonRefinement.memFlatMap _ _ depth _ hdepth
    apply CommonRefinement.memFlatMap _ _ prior _ hprior
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.YangMillsSingletGapGrammar
