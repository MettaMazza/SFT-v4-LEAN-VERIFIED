import SFT.Mathematics.OrbitGrammar
import SFT.Mathematics.OrbitWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.OrbitControls
attribute [local irreducible] OrbitNumberWitnesses.orderExamples OrbitNumberWitnesses.allReducedRanks OrbitNumberWitnesses.primeDivision OrbitNumberWitnesses.orbitTiling OrbitWitnesses.witnesses
open SFT.Host.Canonical SFT.Foundation OrbitGrammar
set_option maxRecDepth 20000

def laws : List String := ["orbit length equals the multiplicative order of the binary generator modulo the reduced odd denominator", "the reduced-residue count is the product of orbit length and orbit count", "for a prime denominator the period divides one less than that prime", "binary valuation is the exact transient depth to the odd recurrent core"]

def exclusions : List String := ["semantic numerical zero is not an admitted value", "negative magnitude is represented only by held orientation", "irrational, imaginary and floating proof values are excluded", "a completed infinity and an ungenerated continuum are excluded"]

def closureValue : Value := .object [
  ("exact_result",.text "Fold return and binary multiplicative order are one exact remainder identity; odd reduced residues tile into cyclotomic orbits and each binary denominator factor contributes one transient Fold."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (OrbitWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "The first reduced odd denominator above the One executes one complete finite orbit."),
  ("induction_step",.text "For any next supplied odd denominator the finite residue permutation independently partitions into cycles; adjoining one binary factor prepends exactly one transient Fold."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with domain := .rejected }

def survivorIds : List String := (candidates.filter survives).map candidateId

def distinctIdentifiers : List String := (candidates.map candidateId).eraseDups

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(SFT.Host.Text.equal (candidateId falseCandidate) survivorId)
  expected := "reject a generated form missing the first required structural condition"
  observed := decisionReason falseCandidate

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject a changed official source identity"
  observed := "the changed identity differs from the registered source manifest"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := survivorIds.length == 1 && distinctIdentifiers.length == candidates.length
  expected := "reject a missing, duplicated or additional survivor"
  observed := "the generated product contains exactly one registered survivor"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := !exclusions.isEmpty && OrbitWitnesses.witnesses.all OrbitWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && OrbitWitnesses.witnesses.all OrbitWitnesses.Witness.passed) = true
  rw [OrbitWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.OrbitControls
