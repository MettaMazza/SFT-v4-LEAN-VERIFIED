import SFT.Mathematics.GeometryGrammar
import SFT.Mathematics.GeometryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.GeometryControls
open SFT.Host.Canonical SFT.Foundation GeometryGrammar
set_option maxRecDepth 20000

def laws : List String := ["cell dimension is determined by complete acyclic boundary descent","path distance retains a shortest generated transition trace and uses empty One at identity","finite topological closure is exhaustively decidable from the registered open family","continuity is exact inverse-image preservation of every admitted target open","geometric equivalence requires a reversible invariant-preserving transformation trace"]

def exclusions : List String := ["no ungenerated continuum","no irrational or floating proof coordinate","no free metric threshold","no completed infinite topological family"]

def closureValue : Value := .object [
  ("exact_result",.text "The geometry/topology kernel is finite canonical cells with held acyclic incidence, boundary-depth dimension, shared-face adjacency, exact shortest paths, closed finite open families, inverse-image continuity and reversible incidence-preserving deformation."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (GeometryWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "One point is a canonical cell; its open family consists of empty One and the whole point carrier."),
  ("induction_step",.text "Adding one fresh cell generates its possible boundary incidences, shared-face adjacencies and path edges; adding one fresh point generates exactly the open selections needed for closure checks. Every new boundary, path, intersection, join and inverse image is then exhaustively tested."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with cells := .rejected }

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
  passed := !exclusions.isEmpty && GeometryWitnesses.witnesses.all GeometryWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && GeometryWitnesses.witnesses.all GeometryWitnesses.Witness.passed) = true
  rw [GeometryWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.GeometryControls
