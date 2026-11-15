import SFT.Physics.LatticeOperator
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.LatticeOperatorGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "signed-field-number"
  | .admitted => "positive-held-site-presence"

inductive Neighbours where
  | rejected | admitted

def neighboursName : Neighbours → String
  | .rejected => "selected-or-remote-neighbours"
  | .admitted => "complete-two-per-generated-axis-ring"

inductive Stencil where
  | rejected | admitted

def stencilName : Stencil → String
  | .rejected => "free-dimension-specific-weights"
  | .admitted => "half-One-held-half-One-equally-distributed"

inductive Operator where
  | rejected | admitted

def operatorName : Operator → String
  | .rejected => "signed-Laplacian-value"
  | .admitted => "positive-peak-with-held-opposition"

inductive Source where
  | rejected | admitted

def sourceName : Source → String
  | .rejected => "chosen-peak-or-partial-ring"
  | .admitted => "two-dimension-peak-and-complete-ring"

inductive Causality where
  | rejected | admitted

def causalityName : Causality → String
  | .rejected => "continuum-or-selected-front"
  | .admitted => "complete-oriented-taxicab-ball"

inductive Modes where
  | rejected | admitted

def modesName : Modes → String
  | .rejected => "evaluated-cosine-or-mode-table"
  | .admitted => "complete-exact-phase-mode-carriers"

inductive Induction where
  | rejected | admitted

def inductionName : Induction → String
  | .rejected => "bounded-count-list"
  | .admitted => "axis-and-oriented-step-successor"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "measurement-selects-operator"
  | .admitted => "inherit-sealed-dispersion-and-cubic-records"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "free-coefficient-or-extra-neighbour"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  neighbours : Neighbours
  stencil : Stencil
  operator : Operator
  source : Source
  causality : Causality
  modes : Modes
  induction : Induction
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, neighboursName c.neighbours, stencilName c.stencil, operatorName c.operator, sourceName c.source, causalityName c.causality, modesName c.modes, inductionName c.induction, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "neighbours=" (neighboursName c.neighbours), SFT.Host.Text.append "stencil=" (stencilName c.stencil), SFT.Host.Text.append "operator=" (operatorName c.operator), SFT.Host.Text.append "source=" (sourceName c.source), SFT.Host.Text.append "causality=" (causalityName c.causality), SFT.Host.Text.append "modes=" (modesName c.modes), SFT.Host.Text.append "induction=" (inductionName c.induction), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "positive-held-site-presence__complete-two-per-generated-axis-ring__half-One-held-half-One-equally-distributed__positive-peak-with-held-opposition__two-dimension-peak-and-complete-ring__complete-oriented-taxicab-ball__complete-exact-phase-mode-carriers__axis-and-oriented-step-successor__inherit-sealed-dispersion-and-cubic-records__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "positive-held-site-presence" &&
  SFT.Host.Text.equal (neighboursName c.neighbours) "complete-two-per-generated-axis-ring" &&
  SFT.Host.Text.equal (stencilName c.stencil) "half-One-held-half-One-equally-distributed" &&
  SFT.Host.Text.equal (operatorName c.operator) "positive-peak-with-held-opposition" &&
  SFT.Host.Text.equal (sourceName c.source) "two-dimension-peak-and-complete-ring" &&
  SFT.Host.Text.equal (causalityName c.causality) "complete-oriented-taxicab-ball" &&
  SFT.Host.Text.equal (modesName c.modes) "complete-exact-phase-mode-carriers" &&
  SFT.Host.Text.equal (inductionName c.induction) "axis-and-oriented-step-successor" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "inherit-sealed-dispersion-and-cubic-records" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "signed-field-number" then "A signed scalar imports cancellation and an unheld absence value." else
  if SFT.Host.Text.equal (neighboursName c.neighbours) "selected-or-remote-neighbours" then "Selection or remote adjacency breaks locality and completeness." else
  if SFT.Host.Text.equal (stencilName c.stencil) "free-dimension-specific-weights" then "Independent weights introduce parameters." else
  if SFT.Host.Text.equal (operatorName c.operator) "signed-Laplacian-value" then "A signed result is not a positive Fold record." else
  if SFT.Host.Text.equal (sourceName c.source) "chosen-peak-or-partial-ring" then "A chosen peak or incomplete ring does not conserve the neighbour ledger." else
  if SFT.Host.Text.equal (causalityName c.causality) "continuum-or-selected-front" then "A continuum or selected sample omits generated cells." else
  if SFT.Host.Text.equal (modesName c.modes) "evaluated-cosine-or-mode-table" then "An imported cosine or table introduces nonnative and potentially irrational proof values." else
  if SFT.Host.Text.equal (inductionName c.induction) "bounded-count-list" then "A short list does not close the next generated axis or tick." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "measurement-selects-operator" then "External targets cannot choose the stencil or cone." else
  if SFT.Host.Text.equal (extensionName c.extension) "free-coefficient-or-extra-neighbour" then "That changes the generated conservative family." else
  "The exact Fold nearest-neighbour family retains half-One at the centre and shares half-One over 2d neighbours; point-source peak and opposition-ring magnitudes are 2d; causal balls at ticks 1,2,3 are (3,5,7), (5,13,25) and (7,25,63) for dimensions one, two and three; and every N-site cycle has N exact phase-mode carriers with one stationary identity mode."

def generationRule : String := "Generate the complete product of site carrier, neighbour family, conserved stencil, positive operator, point-source ring, causal support, cycle modes, dimension induction, comparison boundary and extension forms."
def grammarBoundary : String := "Every positive finite one-, two- and three-direction nearest-neighbour Fold lattice; every positive tick and oriented causal cell; every positive finite cyclic site count of at least three; and the already sealed dispersion, Maxwell and cubic-support comparison records."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Neighbours.rejected,Neighbours.admitted]).flatMap fun neighbours =>
  ([Stencil.rejected,Stencil.admitted]).flatMap fun stencil =>
  ([Operator.rejected,Operator.admitted]).flatMap fun operator =>
  ([Source.rejected,Source.admitted]).flatMap fun source =>
  ([Causality.rejected,Causality.admitted]).flatMap fun causality =>
  ([Modes.rejected,Modes.admitted]).flatMap fun modes =>
  ([Induction.rejected,Induction.admitted]).flatMap fun induction =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,neighbours,stencil,operator,source,causality,modes,induction,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier neighbours stencil operator source causality modes induction comparison extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hneighbours : neighbours ∈ [Neighbours.rejected,Neighbours.admitted] := by
      cases neighbours <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hstencil : stencil ∈ [Stencil.rejected,Stencil.admitted] := by
      cases stencil <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hoperator : operator ∈ [Operator.rejected,Operator.admitted] := by
      cases operator <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hsource : source ∈ [Source.rejected,Source.admitted] := by
      cases source <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcausality : causality ∈ [Causality.rejected,Causality.admitted] := by
      cases causality <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hmodes : modes ∈ [Modes.rejected,Modes.admitted] := by
      cases modes <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hinduction : induction ∈ [Induction.rejected,Induction.admitted] := by
      cases induction <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ neighbours _ hneighbours
    apply CommonRefinement.memFlatMap _ _ stencil _ hstencil
    apply CommonRefinement.memFlatMap _ _ operator _ hoperator
    apply CommonRefinement.memFlatMap _ _ source _ hsource
    apply CommonRefinement.memFlatMap _ _ causality _ hcausality
    apply CommonRefinement.memFlatMap _ _ modes _ hmodes
    apply CommonRefinement.memFlatMap _ _ induction _ hinduction
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.LatticeOperatorGrammar
