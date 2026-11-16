import SFT.Physics.HiggsCertificate
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.HiggsGrammar
open SFT.Foundation
set_option maxRecDepth 20000

inductive Ground where
  | rejected | admitted

def groundName : Ground → String
  | .rejected => "absence-as-numerical-ground"
  | .admitted => "positive-proper-ground-carrier"

inductive Displacement where
  | rejected | admitted

def displacementName : Displacement → String
  | .rejected => "unison-or-selected-part"
  | .admitted => "unique-self-antipodal-half-One"

inductive Rungs where
  | rejected | admitted

def rungsName : Rungs → String
  | .rejected => "discard-or-rewrite-leading-rungs"
  | .admitted => "retain-half-quarter-eighth-controls"

inductive Directions where
  | rejected | admitted

def directionsName : Directions → String
  | .rejected => "selected-direction-subset"
  | .admitted => "complete-two-by-three-product"

inductive Return where
  | rejected | admitted

def returnName : Return → String
  | .rejected => "retain-all-six-as-active"
  | .admitted => "hold-unique-return-leaving-five"

inductive Cover where
  | rejected | admitted

def coverName : Cover → String
  | .rejected => "free-denominator"
  | .admitted => "least-cover-of-generation-volume"

inductive Transport where
  | rejected | admitted

def transportName : Transport → String
  | .rejected => "fitted-offset-or-repeated-series"
  | .admitted => "one-six-over-five-alpha-return"

inductive Coupling where
  | rejected | admitted

def couplingName : Coupling → String
  | .rejected => "import-potential-or-free-lambda"
  | .admitted => "squared-excitation-shared-over-two-fibres"

inductive Route where
  | rejected | admitted

def routeName : Route → String
  | .rejected => "independent-mass-and-coupling-routes"
  | .admitted => "exact-two-route-cross-lock"

inductive Measurement where
  | rejected | admitted

def measurementName : Measurement → String
  | .rejected => "target-readable-before-seal"
  | .admitted => "all-targets-inaccessible-until-seal"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-mass-potential-or-correction"
  | .admitted => "no-extra-rule"

structure Candidate where
  ground : Ground
  displacement : Displacement
  rungs : Rungs
  directions : Directions
  «return» : Return
  cover : Cover
  transport : Transport
  coupling : Coupling
  route : Route
  measurement : Measurement
  extension : Extension

def sourceFields (c : Candidate) : List String := [groundName c.ground, displacementName c.displacement, rungsName c.rungs, directionsName c.directions, returnName c.«return», coverName c.cover, transportName c.transport, couplingName c.coupling, routeName c.route, measurementName c.measurement, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "ground=" (groundName c.ground), SFT.Host.Text.append "displacement=" (displacementName c.displacement), SFT.Host.Text.append "rungs=" (rungsName c.rungs), SFT.Host.Text.append "directions=" (directionsName c.directions), SFT.Host.Text.append "return=" (returnName c.«return»), SFT.Host.Text.append "cover=" (coverName c.cover), SFT.Host.Text.append "transport=" (transportName c.transport), SFT.Host.Text.append "coupling=" (couplingName c.coupling), SFT.Host.Text.append "route=" (routeName c.route), SFT.Host.Text.append "measurement=" (measurementName c.measurement), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "positive-proper-ground-carrier__unique-self-antipodal-half-One__retain-half-quarter-eighth-controls__complete-two-by-three-product__hold-unique-return-leaving-five__least-cover-of-generation-volume__one-six-over-five-alpha-return__squared-excitation-shared-over-two-fibres__exact-two-route-cross-lock__all-targets-inaccessible-until-seal__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (groundName c.ground) "positive-proper-ground-carrier" &&
  SFT.Host.Text.equal (displacementName c.displacement) "unique-self-antipodal-half-One" &&
  SFT.Host.Text.equal (rungsName c.rungs) "retain-half-quarter-eighth-controls" &&
  SFT.Host.Text.equal (directionsName c.directions) "complete-two-by-three-product" &&
  SFT.Host.Text.equal (returnName c.«return») "hold-unique-return-leaving-five" &&
  SFT.Host.Text.equal (coverName c.cover) "least-cover-of-generation-volume" &&
  SFT.Host.Text.equal (transportName c.transport) "one-six-over-five-alpha-return" &&
  SFT.Host.Text.equal (couplingName c.coupling) "squared-excitation-shared-over-two-fibres" &&
  SFT.Host.Text.equal (routeName c.route) "exact-two-route-cross-lock" &&
  SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if !(SFT.Host.Text.equal (groundName c.ground) "positive-proper-ground-carrier") then "Structural absence is not a field value." else
  if !(SFT.Host.Text.equal (displacementName c.displacement) "unique-self-antipodal-half-One") then "Unison is not displaced and a selected part is a parameter." else
  if !(SFT.Host.Text.equal (rungsName c.rungs) "retain-half-quarter-eighth-controls") then "A terminal successor cannot erase its lower-order receipt." else
  if !(SFT.Host.Text.equal (directionsName c.directions) "complete-two-by-three-product") then "A subset omits a generated hand or generator direction." else
  if !(SFT.Host.Text.equal (returnName c.«return») "hold-unique-return-leaving-five") then "The invariant return cannot also be an active displaced direction." else
  if !(SFT.Host.Text.equal (coverName c.cover) "least-cover-of-generation-volume") then "A denominator chosen for agreement is a parameter." else
  if !(SFT.Host.Text.equal (transportName c.transport) "one-six-over-five-alpha-return") then "An offset or truncation is a fit." else
  if !(SFT.Host.Text.equal (couplingName c.coupling) "squared-excitation-shared-over-two-fibres") then "An imported potential or free lambda would add an axiom." else
  if !(SFT.Host.Text.equal (routeName c.route) "exact-two-route-cross-lock") then "Independent routes introduce a dial." else
  if !(SFT.Host.Text.equal (measurementName c.measurement) "all-targets-inaccessible-until-seal") then "That would fit the coefficient to the measured mass." else
  if !(SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule") then "Any added term is a free parameter." else
  "The displaced ground is uniquely half-One; the retained leading Higgs rungs are 1/2, 1/4 and 1/8. Complete six-cell scalar support, its unique held return and the independently equal cover depth five force terminal m_H/v = 1/2 + (6/5) alpha = 2563352914777/5038463954690. The exact native self-coupling is lambda = (m_H/v)^2/2 = 6570778165695741824959729/50772238045420788745992200. Both routes cross-lock in the squared domain; no irrational root is formed."

def generationRule : String := "Generate the complete product of ground carrier, displacement, leading rungs, scalar directional support, held return, cover cross-lock, terminal transport, coupling composition, route equality, measurement custody and extension forms."
def grammarBoundary : String := "Structural empty-One, half-One and One ground forms; every binary successor of the displaced ground through the leading coupling rung; the complete binary-hand times generator-direction product; its unique held return; the least cover of generator volume; exactly one terminal alpha transport; exact positive rational operations; and no physical target before seal."

def candidates : List Candidate :=
  ([Ground.rejected,Ground.admitted]).flatMap fun ground =>
  ([Displacement.rejected,Displacement.admitted]).flatMap fun displacement =>
  ([Rungs.rejected,Rungs.admitted]).flatMap fun rungs =>
  ([Directions.rejected,Directions.admitted]).flatMap fun directions =>
  ([Return.rejected,Return.admitted]).flatMap fun «return» =>
  ([Cover.rejected,Cover.admitted]).flatMap fun cover =>
  ([Transport.rejected,Transport.admitted]).flatMap fun transport =>
  ([Coupling.rejected,Coupling.admitted]).flatMap fun coupling =>
  ([Route.rejected,Route.admitted]).flatMap fun route =>
  ([Measurement.rejected,Measurement.admitted]).flatMap fun measurement =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨ground,displacement,rungs,directions,«return»,cover,transport,coupling,route,measurement,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 2048 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk ground displacement rungs directions «return» cover transport coupling route measurement extension =>
    have hground : ground ∈ [Ground.rejected,Ground.admitted] := by
      cases ground <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdisplacement : displacement ∈ [Displacement.rejected,Displacement.admitted] := by
      cases displacement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrungs : rungs ∈ [Rungs.rejected,Rungs.admitted] := by
      cases rungs <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdirections : directions ∈ [Directions.rejected,Directions.admitted] := by
      cases directions <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hreturn : «return» ∈ [Return.rejected,Return.admitted] := by
      cases «return» <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcover : cover ∈ [Cover.rejected,Cover.admitted] := by
      cases cover <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have htransport : transport ∈ [Transport.rejected,Transport.admitted] := by
      cases transport <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcoupling : coupling ∈ [Coupling.rejected,Coupling.admitted] := by
      cases coupling <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hroute : route ∈ [Route.rejected,Route.admitted] := by
      cases route <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmeasurement : measurement ∈ [Measurement.rejected,Measurement.admitted] := by
      cases measurement <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ ground _ hground
    apply CommonRefinement.memFlatMap _ _ displacement _ hdisplacement
    apply CommonRefinement.memFlatMap _ _ rungs _ hrungs
    apply CommonRefinement.memFlatMap _ _ directions _ hdirections
    apply CommonRefinement.memFlatMap _ _ «return» _ hreturn
    apply CommonRefinement.memFlatMap _ _ cover _ hcover
    apply CommonRefinement.memFlatMap _ _ transport _ htransport
    apply CommonRefinement.memFlatMap _ _ coupling _ hcoupling
    apply CommonRefinement.memFlatMap _ _ route _ hroute
    apply CommonRefinement.memFlatMap _ _ measurement _ hmeasurement
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.HiggsGrammar
