import SFT.Physics.FiniteQuantumGravity
import SFT.Foundation.CommonRefinement
namespace SFT.Physics.FiniteQuantumGravityGrammar
open SFT.Foundation
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

inductive Carrier where
  | rejected | admitted

def carrierName : Carrier → String
  | .rejected => "separate-quantum-and-gravity-substrates"
  | .admitted => "single-finite-Fold-lattice"

inductive Dimension where
  | rejected | admitted

def dimensionName : Dimension → String
  | .rejected => "chosen-or-extra-dimensional-space"
  | .admitted => "three-space-plus-one-process-direction"

inductive Rank where
  | rejected | admitted

def rankName : Rank → String
  | .rejected => "scalar-or-selected-tensor"
  | .admitted => "complete-symmetric-rank-two-source"

inductive Polarization where
  | rejected | admitted

def polarizationName : Polarization → String
  | .rejected => "assigned-spin-or-mode-count"
  | .admitted => "ten-take-four-take-four-leaves-two"

inductive Propagation where
  | rejected | admitted

def propagationName : Propagation → String
  | .rejected => "fitted-mass-or-speed"
  | .admitted => "empty-mass-record-and-One-cell-per-tick"

inductive Quantum where
  | rejected | admitted

def quantumName : Quantum → String
  | .rejected => "continuum-amplitude-space"
  | .admitted => "complete-finite-binary-word-support"

inductive Loops where
  | rejected | admitted

def loopsName : Loops → String
  | .rejected => "completed-infinity-or-counterterm"
  | .admitted => "complete-finite-rational-loop-prefix"

inductive Horizon where
  | rejected | admitted

def horizonName : Horizon → String
  | .rejected => "unbounded-or-unrecorded-boundary"
  | .admitted => "positive-floor-and-quarter-area-record"

inductive Comparison where
  | rejected | admitted

def comparisonName : Comparison → String
  | .rejected => "target-selects-composition"
  | .admitted => "inherit-sealed-wave-loop-and-horizon-comparisons"

inductive Extension where
  | rejected | admitted

def extensionName : Extension → String
  | .rejected => "extra-dimension-or-free-regulator"
  | .admitted => "no-extra-rule"

structure Candidate where
  carrier : Carrier
  dimension : Dimension
  rank : Rank
  polarization : Polarization
  propagation : Propagation
  quantum : Quantum
  loops : Loops
  horizon : Horizon
  comparison : Comparison
  extension : Extension

def sourceFields (c : Candidate) : List String := [carrierName c.carrier, dimensionName c.dimension, rankName c.rank, polarizationName c.polarization, propagationName c.propagation, quantumName c.quantum, loopsName c.loops, horizonName c.horizon, comparisonName c.comparison, extensionName c.extension]

def candidateId (c : Candidate) : String := SFT.Host.Text.intercalate "__" (sourceFields c)
def exactForm (c : Candidate) : String := SFT.Host.Text.intercalate "; " [SFT.Host.Text.append "carrier=" (carrierName c.carrier), SFT.Host.Text.append "dimension=" (dimensionName c.dimension), SFT.Host.Text.append "rank=" (rankName c.rank), SFT.Host.Text.append "polarization=" (polarizationName c.polarization), SFT.Host.Text.append "propagation=" (propagationName c.propagation), SFT.Host.Text.append "quantum=" (quantumName c.quantum), SFT.Host.Text.append "loops=" (loopsName c.loops), SFT.Host.Text.append "horizon=" (horizonName c.horizon), SFT.Host.Text.append "comparison=" (comparisonName c.comparison), SFT.Host.Text.append "extension=" (extensionName c.extension)]
def survivorId : String := "single-finite-Fold-lattice__three-space-plus-one-process-direction__complete-symmetric-rank-two-source__ten-take-four-take-four-leaves-two__empty-mass-record-and-One-cell-per-tick__complete-finite-binary-word-support__complete-finite-rational-loop-prefix__positive-floor-and-quarter-area-record__inherit-sealed-wave-loop-and-horizon-comparisons__no-extra-rule"
def survives (c : Candidate) : Bool := SFT.Host.Text.equal (candidateId c) survivorId
def criteriaDecision (c : Candidate) : Bool :=
  SFT.Host.Text.equal (carrierName c.carrier) "single-finite-Fold-lattice" &&
  SFT.Host.Text.equal (dimensionName c.dimension) "three-space-plus-one-process-direction" &&
  SFT.Host.Text.equal (rankName c.rank) "complete-symmetric-rank-two-source" &&
  SFT.Host.Text.equal (polarizationName c.polarization) "ten-take-four-take-four-leaves-two" &&
  SFT.Host.Text.equal (propagationName c.propagation) "empty-mass-record-and-One-cell-per-tick" &&
  SFT.Host.Text.equal (quantumName c.quantum) "complete-finite-binary-word-support" &&
  SFT.Host.Text.equal (loopsName c.loops) "complete-finite-rational-loop-prefix" &&
  SFT.Host.Text.equal (horizonName c.horizon) "positive-floor-and-quarter-area-record" &&
  SFT.Host.Text.equal (comparisonName c.comparison) "inherit-sealed-wave-loop-and-horizon-comparisons" &&
  SFT.Host.Text.equal (extensionName c.extension) "no-extra-rule"

def decisionReason (c : Candidate) : String :=
  if SFT.Host.Text.equal (carrierName c.carrier) "separate-quantum-and-gravity-substrates" then "Separate substrates do not establish a composition law." else
  if SFT.Host.Text.equal (dimensionName c.dimension) "chosen-or-extra-dimensional-space" then "A chosen or added dimension is not generated by the stability theorem." else
  if SFT.Host.Text.equal (rankName c.rank) "scalar-or-selected-tensor" then "A scalar or selected tensor omits the admitted complete source slots." else
  if SFT.Host.Text.equal (polarizationName c.polarization) "assigned-spin-or-mode-count" then "An assigned label does not derive physical degrees." else
  if SFT.Host.Text.equal (propagationName c.propagation) "fitted-mass-or-speed" then "A fitted mass or speed imports the target." else
  if SFT.Host.Text.equal (quantumName c.quantum) "continuum-amplitude-space" then "A continuum adds ungenerated support." else
  if SFT.Host.Text.equal (loopsName c.loops) "completed-infinity-or-counterterm" then "A completed infinity and correction are outside the Fold grammar." else
  if SFT.Host.Text.equal (horizonName c.horizon) "unbounded-or-unrecorded-boundary" then "An unbounded or unrecorded boundary loses the finite ledger." else
  if SFT.Host.Text.equal (comparisonName c.comparison) "target-selects-composition" then "External programmes cannot choose the joint model." else
  if SFT.Host.Text.equal (extensionName c.extension) "extra-dimension-or-free-regulator" then "Either addition changes the generated model." else
  "At every positive finite Fold depth, one shared lattice jointly retains complete quantum support, three spatial directions, a symmetric rank-two gravity carrier with two physical polarizations, empty mass/rest record, One-cell causal advance, a positive distance floor, a finite rational loop sum and a quarter-area horizon ledger; no extra spatial direction or completed infinity is generated."

def generationRule : String := "Generate the complete product of shared carrier, dimensional support, rank-two source, polarization reduction, mass/causal carrier, quantum support, finite-loop closure, horizon ledger, comparison boundary and extension forms."
def grammarBoundary : String := "Every positive finite Fold depth on the admitted three-space lattice, its complete binary quantum support, four-coordinate symmetric rank-two source slots, finite exact loop prefix, positive distance floor and complete quarter-area horizon record.  Continuum completion is outside the boundary."

def candidates : List Candidate :=
  ([Carrier.rejected,Carrier.admitted]).flatMap fun carrier =>
  ([Dimension.rejected,Dimension.admitted]).flatMap fun dimension =>
  ([Rank.rejected,Rank.admitted]).flatMap fun rank =>
  ([Polarization.rejected,Polarization.admitted]).flatMap fun polarization =>
  ([Propagation.rejected,Propagation.admitted]).flatMap fun propagation =>
  ([Quantum.rejected,Quantum.admitted]).flatMap fun quantum =>
  ([Loops.rejected,Loops.admitted]).flatMap fun loops =>
  ([Horizon.rejected,Horizon.admitted]).flatMap fun horizon =>
  ([Comparison.rejected,Comparison.admitted]).flatMap fun comparison =>
  ([Extension.rejected,Extension.admitted]).map fun extension =>
  ⟨carrier,dimension,rank,polarization,propagation,quantum,loops,horizon,comparison,extension⟩

def survivor : Candidate := ⟨.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted,.admitted⟩

theorem generatedCardinality : candidates.length = 1024 := rfl

theorem candidatesComplete (c : Candidate) : c ∈ candidates := by
  cases c with
  | mk carrier dimension rank polarization propagation quantum loops horizon comparison extension =>
    have hcarrier : carrier ∈ [Carrier.rejected,Carrier.admitted] := by
      cases carrier <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hdimension : dimension ∈ [Dimension.rejected,Dimension.admitted] := by
      cases dimension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hrank : rank ∈ [Rank.rejected,Rank.admitted] := by
      cases rank <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpolarization : polarization ∈ [Polarization.rejected,Polarization.admitted] := by
      cases polarization <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hpropagation : propagation ∈ [Propagation.rejected,Propagation.admitted] := by
      cases propagation <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hquantum : quantum ∈ [Quantum.rejected,Quantum.admitted] := by
      cases quantum <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hloops : loops ∈ [Loops.rejected,Loops.admitted] := by
      cases loops <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hhorizon : horizon ∈ [Horizon.rejected,Horizon.admitted] := by
      cases horizon <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hcomparison : comparison ∈ [Comparison.rejected,Comparison.admitted] := by
      cases comparison <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    have hextension : extension ∈ [Extension.rejected,Extension.admitted] := by
      cases extension <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail
    unfold candidates
    apply CommonRefinement.memFlatMap _ _ carrier _ hcarrier
    apply CommonRefinement.memFlatMap _ _ dimension _ hdimension
    apply CommonRefinement.memFlatMap _ _ rank _ hrank
    apply CommonRefinement.memFlatMap _ _ polarization _ hpolarization
    apply CommonRefinement.memFlatMap _ _ propagation _ hpropagation
    apply CommonRefinement.memFlatMap _ _ quantum _ hquantum
    apply CommonRefinement.memFlatMap _ _ loops _ hloops
    apply CommonRefinement.memFlatMap _ _ horizon _ hhorizon
    apply CommonRefinement.memFlatMap _ _ comparison _ hcomparison
    exact Count.TraceDerivation.memMap _ extension _ hextension

end SFT.Physics.FiniteQuantumGravityGrammar
