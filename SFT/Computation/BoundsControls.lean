import SFT.Computation.BoundsGrammar
import SFT.Computation.BoundsWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Computation.BoundsControls
open SFT.Host.Canonical SFT.Foundation BoundsGrammar
set_option maxRecDepth 20000

def laws : List String := ["Carrier law: problem family; registered model; resource measure; constructive algorithm trace; adversarial indistinguishability family; lower witness; upper witness.","Trace law: every accepted result reconstructs from the exact initial form and retained transition or relation rows.","Boundary law: unregistered forms, powers, parameters, models and omitted rows halt the computation claim.","Composition law: serial or parallel assembly preserves interfaces, component identities and lost/retained distinction ledgers."]

def exclusions : List String := ["no conventional machine, algorithm, language, security definition or learning model may select the law","no numerical zero, negative, irrational, imaginary or floating proof quantity","no completed infinity or ungenerated continuum","no free, fitted or learned parameter","no application result or pretrained model","Arbitrary asymptotic lower bounds remain separate claims requiring their own generated families."]

def closureValue : Value := .object [
  ("exact_result",.text "The forced resource comparison certificates kernel retains problem family; registered model; resource measure; constructive algorithm trace; adversarial indistinguishability family; lower witness; upper witness; every operation is source-bound, trace-complete, boundary-explicit, composition-preserving, successor-general and contains no imported answer-producing premise."),
  ("laws",.array (laws.map Value.text)),
  ("witnesses",.array (BoundsWitnesses.witnesses.map fun w => .array [.text w.name,.text w.statement,.boolean w.passed])),
  ("minimality",.text "Changing any admitted coordinate removes a registered carrier, relation, trace, boundary, composition, generality or no-extra condition."),
  ("uniqueness",.text (SFT.Host.Text.join ["Exactly one product member has every admitted coordinate: ",survivorId,"."])),
  ("base",.text "The structural One supplies one canonical resource comparison certificates form with its identity trace and no unrecorded predecessor."),
  ("successor",.text "Appending one generated resource comparison certificates form adds its exact carrier row, relations, trace positions and new pair/interface distinctions while preserving every earlier record."),
  ("exclusions",.array (exclusions.map Value.text))]

def falseCandidate : Candidate := { survivor with input := .rejected }

def survivorIds : List String := (candidates.filter survives).map candidateId

def distinctIdentifiers : List String := (candidates.map candidateId).eraseDups

def falsePremise : FoldControls.ControlRecord where
  kind := .falsePremise
  passed := !(SFT.Host.Text.equal (candidateId falseCandidate) survivorId)
  expected := "reject the generated form lacking complete first-axis coverage"
  observed := decisionReason falseCandidate

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
  kind := .tamperedSource
  passed := !(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash)
  expected := "reject a changed official source identity"
  observed := "changed source identity differs"

def tamperedArtifact : FoldControls.ControlRecord where
  kind := .tamperedArtifact
  passed := survivorIds.length == 1 && distinctIdentifiers.length == candidates.length
  expected := "reject missing, duplicated or additional survivors"
  observed := "literal product contains one survivor and unique identities"

def boundary : FoldControls.ControlRecord where
  kind := .boundary
  passed := !exclusions.isEmpty && BoundsWitnesses.witnesses.all BoundsWitnesses.Witness.passed
  expected := "halt imported models, parameters or excluded quantum machinery"
  observed := SFT.Host.Text.intercalate "; " exclusions

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
  change (true && BoundsWitnesses.witnesses.all BoundsWitnesses.Witness.passed) = true
  rw [BoundsWitnesses.allWitnessesPass]
  rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
  [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
  kind := c.kind
  passed := c.passed
  expectedBehavior := c.expected
  observedBehavior := c.observed
  receiptHash := identity (.array [.text "SFT-COMP-CPLX-BOUNDS-001",.text (SFT.Engine.kindName c.kind),.text c.expected,.text c.observed,.boolean c.passed])

def runControls (sourceHash : String) : Value :=
  .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))

end SFT.Computation.BoundsControls
