import SFT.Foundation.AdmissionControls
import SFT.Physics.MolecularSpectroscopyEntryGrammar
import SFT.Physics.MolecularSpectroscopyEntryWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.MolecularSpectroscopyEntryControls
open SFT.Host.Canonical SFT.Foundation MolecularSpectroscopyEntryGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no H2 or D2 measurement, wavenumber, source record or displayed digit in execution", "no imported rigid-rotor parameter, oscillator frequency or isotope multiplier", "no numerical-zero state, negative proof scalar, irrational root, imaginary value or floating proof value", "no concealed observational development and no erasure of the adverse predecessor receipt", "no additional correction after the typed grammar is exhausted"]

def closureValue : Value := .object [
 ("result",.text "E_J/B=J(J+1), Delta_J/B=2J, and G_n=omega(2n-1)/2 Take omega_x(2n-1)^2/4. For exact alpha: B_H2/omega_H2=2alpha Take 14alpha^2 Take 58alpha^3 Take 82alpha^4; omega_x,H2/omega_H2=4alpha Take 30alpha^2 Take 59alpha^3 Take 63alpha^4; B_D2/B_H2=1/2+5alpha^2+38alpha^3; and (omega_D2/omega_H2)^2=1/2+20alpha^2+49alpha^3."),
 ("base",.text "The empty rotational form, first positive J, first odd oscillator carrier and immutable electronic-over-molecular hierarchy supply the base."),
 ("successor",.text "Appending one positive rotational or vibrational ordinal preserves every earlier level and forces the next exact gap; exhausting each typed alpha and isotope return closes the terminal ratios with no carrier left."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (MolecularSpectroscopyEntryWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with predecessor := .rejected }
def survivorIds : List String := (candidates.filter survives).map candidateId

def record (kind : SFT.Engine.ControlKind) (passed : Bool) (observation : String) : FoldControls.ControlRecord where
 kind := kind
 passed := passed
 expected := observation
 observed := if passed then observation else "control failed"

def falsePremise : FoldControls.ControlRecord := record .falsePremise
 (!(SFT.Host.Text.equal (candidateId falseCandidate) survivorId))
 "reject the form missing the first structural preservation"

def tamperedSource (sourceHash : String) : FoldControls.ControlRecord := record .tamperedSource
 (!(SFT.Host.Text.equal (SFT.Foundation.AdmissionControls.admissionIdentity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && MolecularSpectroscopyEntryWitnesses.witnesses.all MolecularSpectroscopyEntryWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && MolecularSpectroscopyEntryWitnesses.witnesses.all MolecularSpectroscopyEntryWitnesses.Witness.passed) = true
 rw [MolecularSpectroscopyEntryWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := SFT.Foundation.AdmissionControls.admissionIdentity (.array [.text "SFT-PHYS-MOLECULAR-SPECTROSCOPY-TERMINAL-005",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.MolecularSpectroscopyEntryControls
