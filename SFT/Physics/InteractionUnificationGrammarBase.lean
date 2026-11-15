import SFT.Physics.InteractionUnification
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.InteractionUnificationGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Sector where
  | rejected | admitted

def sectorName : Sector → String
  | .rejected => "selected-familiar-sectors"
  | .admitted => "complete-prime-ladder-through-seven"

inductive Standing where
  | rejected | admitted

def standingName : Standing → String
  | .rejected => "named-unification-point"
  | .admitted => "unique-self-antipodal-half-One-mode"

inductive Table where
  | rejected | admitted

def tableName : Table → String
  | .rejected => "independent-fitted-couplings"
  | .admitted => "single-m-indexed-exact-table"

inductive Mass where
  | rejected | admitted

def massName : Mass → String
  | .rejected => "inserted-mass-parameter"
  | .admitted => "positive-shortfall-from-unison"

inductive Support where
  | rejected | admitted

def supportName : Support → String
  | .rejected => "independent-scale-axes"
  | .admitted => "common-positive-binary-support"

inductive Order where
  | rejected | admitted

def orderName : Order → String
  | .rejected => "target-named-physical-order"
  | .admitted => "exact-positive-m-difference-gap"

inductive Coincidence where
  | rejected | admitted

def coincidenceName : Coincidence → String
  | .rejected => "asserted-unification-crossing"
  | .admitted => "finite-triple-coincidence-forbidden"

inductive Period where
  | rejected | admitted

def periodName : Period → String
  | .rejected => "selected-force-periods"
  | .admitted => "complete-one-two-three-period-dictionary"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "flat-EM-and-inconsistent-slope-bundle"
  | .admitted => "terminal-carrier-specific-running-and-anchors"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-group-or-crossing-scale"
  | .admitted => "no-extra-rule"

structure Candidate where
  sector : Sector
  standing : Standing
  table : Table
  mass : Mass
  support : Support
  order : Order
  coincidence : Coincidence
  period : Period
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [sectorName c.sector, standingName c.standing, tableName c.table, massName c.mass, supportName c.support, orderName c.order, coincidenceName c.coincidence, periodName c.period, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "sector=" (sectorName c.sector), SFT.Host.Text.append "standing=" (standingName c.standing), SFT.Host.Text.append "table=" (tableName c.table), SFT.Host.Text.append "mass=" (massName c.mass), SFT.Host.Text.append "support=" (supportName c.support), SFT.Host.Text.append "order=" (orderName c.order), SFT.Host.Text.append "coincidence=" (coincidenceName c.coincidence), SFT.Host.Text.append "period=" (periodName c.period), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "complete-prime-ladder-through-seven__unique-self-antipodal-half-One-mode__single-m-indexed-exact-table__positive-shortfall-from-unison__common-positive-binary-support__exact-positive-m-difference-gap__finite-triple-coincidence-forbidden__complete-one-two-three-period-dictionary__terminal-carrier-specific-running-and-anchors__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (sectorName c.sector) "complete-prime-ladder-through-seven" &&
  SFT.Host.Text.equal (standingName c.standing) "unique-self-antipodal-half-One-mode" &&
  SFT.Host.Text.equal (tableName c.table) "single-m-indexed-exact-table" &&
  SFT.Host.Text.equal (massName c.mass) "positive-shortfall-from-unison" &&
  SFT.Host.Text.equal (supportName c.support) "common-positive-binary-support" &&
  SFT.Host.Text.equal (orderName c.order) "exact-positive-m-difference-gap" &&
  SFT.Host.Text.equal (coincidenceName c.coincidence) "finite-triple-coincidence-forbidden" &&
  SFT.Host.Text.equal (periodName c.period) "complete-one-two-three-period-dictionary" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "terminal-carrier-specific-running-and-anchors" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (sectorName c.sector) "selected-familiar-sectors" then "Selection omits generated prime sectors or the exclusion boundary." else
  if SFT.Host.Text.equal (standingName c.standing) "named-unification-point" then "A name does not prove membership or uniqueness." else
  if SFT.Host.Text.equal (tableName c.table) "independent-fitted-couplings" then "Independent values violate the one-generator law." else
  if SFT.Host.Text.equal (massName c.mass) "inserted-mass-parameter" then "An inserted mass is not forced by the holding relation." else
  if SFT.Host.Text.equal (supportName c.support) "independent-scale-axes" then "Independent axes cannot define exact separation or convergence." else
  if SFT.Host.Text.equal (orderName c.order) "target-named-physical-order" then "A physical label cannot choose an inequality." else
  if SFT.Host.Text.equal (coincidenceName c.coincidence) "asserted-unification-crossing" then "A crossing contradicts the positive pair-gap identity." else
  if SFT.Host.Text.equal (periodName c.period) "selected-force-periods" then "Selected labels provide no Fold traces." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "flat-EM-and-inconsistent-slope-bundle" then "It conflicts internally and with admitted electromagnetic running." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-group-or-crossing-scale" then "An added group or fitted crossing scale is a free premise." else
  "The forced sectors (2,3,5,7) share one exact m-indexed interaction table; half-One uniquely unifies the odd-sector standing modes; all finite common-support sector gaps are positive and shrink without finite coincidence; the gravity/EM/strong Fold periods are 1/2/3 with joint recurrence 6; and the inconsistent flat-EM slope bundle is rejected in favour of the sealed terminal carrier-specific running laws."

def generationRule : String := "Generate the complete product of sector domain, standing-mode carrier, coupling table, mass relation, common support, sector order, coincidence boundary, period dictionary, empirical succession and extension forms."
def grammarBoundary : String := "Every forced prime sector through seven, every interior standing mode, every positive binary common-support successor, every ordered sector pair, the exact Fold periods of One, one-third and one-seventh, and the already sealed complete force/running comparison records."

def candidates : List Candidate :=
  ([Sector.rejected,Sector.admitted]).flatMap fun sector =>
  ([Standing.rejected,Standing.admitted]).flatMap fun standing =>
  ([Table.rejected,Table.admitted]).flatMap fun table =>
  ([Mass.rejected,Mass.admitted]).flatMap fun mass =>
  ([Support.rejected,Support.admitted]).flatMap fun support =>
  ([Order.rejected,Order.admitted]).flatMap fun order =>
  ([Coincidence.rejected,Coincidence.admitted]).flatMap fun coincidence =>
  ([Period.rejected,Period.admitted]).flatMap fun period =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨sector,standing,table,mass,support,order,coincidence,period,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk sector standing table mass support order coincidence period comparison extension =>
    have hsector : sector ∈ [Sector.rejected,Sector.admitted] := by
      cases sector <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstanding : standing ∈ [Standing.rejected,Standing.admitted] := by
      cases standing <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htable : table ∈ [Table.rejected,Table.admitted] := by
      cases table <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmass : mass ∈ [Mass.rejected,Mass.admitted] := by
      cases mass <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsupport : support ∈ [Support.rejected,Support.admitted] := by
      cases support <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have horder : order ∈ [Order.rejected,Order.admitted] := by
      cases order <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoincidence : coincidence ∈ [Coincidence.rejected,Coincidence.admitted] := by
      cases coincidence <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hperiod : period ∈ [Period.rejected,Period.admitted] := by
      cases period <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ sector _ hsector
    apply CommonRefinement.memFlatMap _ _ standing _ hstanding
    apply CommonRefinement.memFlatMap _ _ table _ htable
    apply CommonRefinement.memFlatMap _ _ mass _ hmass
    apply CommonRefinement.memFlatMap _ _ support _ hsupport
    apply CommonRefinement.memFlatMap _ _ order _ horder
    apply CommonRefinement.memFlatMap _ _ coincidence _ hcoincidence
    apply CommonRefinement.memFlatMap _ _ period _ hperiod
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.InteractionUnificationGrammar
