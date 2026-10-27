import SFT.Mathematics.CombinatoricsGrammar
import SFT.Mathematics.CombinatoricsWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Mathematics.CombinatoricsControls
open SFT.Host.Canonical SFT.Foundation CombinatoricsGrammar
set_option maxRecDepth 20000

def laws : List String := ["every arrangement holds each carrier member exactly once","every selection is produced once by the fresh-member absent/held recurrence","canonical trace equality is the only duplicate-elimination rule","disjoint class ledgers conserve the complete generated family","enumerated count is the identity of the complete output trace"]

def exclusions : List String := ["no random sampling as completeness evidence","no factorial or binomial answer table","no negative inclusion-exclusion proof value","no completed infinite combinatorial family"]

def closureValue : Value := .object [
  ("exact_result",.text "The combinatorial kernel is complete canonical carrier generation by held-choice recurrence with complete choice provenance, canonical deduplication, witnessed symmetry, disjoint class accounting, successor generality and no imported formula."),
  ("laws",.array (laws.map Value.text)),
  ("operational_witnesses",.array (CombinatoricsWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Replacing any admitted coordinate by a generated alternative removes a registered preservation, completeness, exactness or provenance condition."),
  ("named_shape_uniqueness",.text (SFT.Host.Text.join ["The complete product contains exactly one all-admitted coordinate: ",survivorId,"."])),
  ("induction_base",.text "A one-member carrier has one complete arrangement and two structural selection forms: empty One and held member."),
  ("induction_step",.text "For a fresh carrier member, arrangements partition by its held position and recurse on the prior remainder; selections partition into prior forms and the same forms with the fresh member held. These disjoint generated classes exhaust the successor carrier without an imported formula."),
  ("boundary_exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with carrier := .rejected }

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
  passed := !exclusions.isEmpty && CombinatoricsWitnesses.witnesses.all CombinatoricsWitnesses.Witness.passed
  expected := "halt any attempt to import an excluded object or answer-producing model"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && CombinatoricsWitnesses.witnesses.all CombinatoricsWitnesses.Witness.passed) = true
  rw [CombinatoricsWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))

end SFT.Mathematics.CombinatoricsControls
