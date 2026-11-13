import SFT.Foundation.AdmissionGrammar
import SFT.Foundation.FoldControls
import SFT.Host.SHA256Chunks
namespace SFT.Foundation.AdmissionControls
open SFT.Host.Canonical AdmissionAcceptance
set_option maxRecDepth 20000
-- Reuse the established byte-for-byte equivalent traversal for large census hashes.
def executionIdentity (v : Value) : String :=
 SFT.Host.Text.append "sha256:" (SFT.Host.SHA256Chunks.digest (render v).toUTF8)

@[implemented_by executionIdentity]
def admissionIdentity (v : Value) : String := identity v

theorem executionIdentityCorrect (v : Value) : executionIdentity v = admissionIdentity v :=
 congrArg (SFT.Host.Text.append "sha256:") (SFT.Host.SHA256Chunks.digestPreserved (render v).toUTF8)

def closureValue : Value := .object [("necessity",.text "Each gate blocks a distinct unauthorized information or authority path: hidden premise, selected candidates, nonunique result, open form, unfalsified implementation, target leakage, lost failure or premature dependency."),("sufficiency",.text "A proposal satisfying all gates has one source-bound exact result at its declared boundary, independent recomputation, every required adverse control, appropriate empirical custody and an immutable disposition."),("formal_empirical_split",.text "Formal claims stop after independent recomputation. Empirical claims must additionally seal their prediction before identified external target content opens and preserve every comparison row."),("fail_closed",.text "Any failed or exceptional gate emits and preserves a rejected receipt; it does not enter model authority. Only finite-complete or depth-independent closure may become a dependency."),("minimality",.text "Removing any gate reopens its corresponding prohibited path; adding a bypass contradicts the same constraints."),("named_shape_uniqueness",.text "Only registration-root-bound__no-axiom-zero-parameter__census-complete__survivor-unique__form-closed__controls-complete__validation-independent__measurement-after-seal-when-required__every-receipt-preserved__dependency-after-model-admission__no-extra is an admissible authority path."),("generality",.text "The gate relation depends on claim capabilities and evidence class, not branch, operating system, target value or corpus size.")]
def falsePremise : FoldControls.ControlRecord where
 kind := .falsePremise
 passed := !(admissionAccepts [("parameter_free",false)])
 expected := "reject an axiom or free parameter"
 observed := "the route halts when parameter freedom is false"
theorem falsePremisePassed : falsePremise.passed = true := rfl
def tamperedSource (sourceHash : String) : FoldControls.ControlRecord where
 kind := .tamperedSource
 passed := !(SFT.Host.Text.equal (admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash) && !(admissionAccepts [("root_bound",false)])
 expected := "reject a changed source identity"
 observed := "the changed identity differs and root custody fails"
def tamperedArtifact : FoldControls.ControlRecord where
 kind := .tamperedArtifact
 passed := !(admissionAccepts [("unique",false)]) && !(admissionAccepts [("preserved",false)])
 expected := "reject a second survivor or discarded failure"
 observed := "both altered routes halt"
theorem tamperedArtifactPassed : tamperedArtifact.passed = true := rfl
def boundary : FoldControls.ControlRecord where
 kind := .boundary
 passed := !(admissionAccepts [("postseal",false)]) && !(admissionAccepts [("admitted_dependency",false)]) && admissionAccepts []
 expected := "reject pre-seal target access and unclosed dependencies"
 observed := "both capability violations halt while the complete path passes"
theorem boundaryPassed : boundary.passed = true := rfl
def controlRecords (sourceHash : String) := [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]
def runControls (sourceHash : String) : Value := .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (FoldControls.resultData c))
end SFT.Foundation.AdmissionControls
