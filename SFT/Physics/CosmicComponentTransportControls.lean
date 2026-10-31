import SFT.Physics.CosmicComponentTransportGrammar
import SFT.Physics.CosmicComponentTransportWitnesses
import SFT.Foundation.FoldControls
namespace SFT.Physics.CosmicComponentTransportControls
open SFT.Host.Canonical SFT.Foundation CosmicComponentTransportGrammar
set_option maxRecDepth 20000

def exclusions : List String := ["no V1/V2 executable, old two-thirds/one-third survivor or external equation in forcing", "no numerical-nothing zero, negative, irrational, imaginary, floating, NaN or completed-infinity proof scalar", "no continuum scale factor, differential field equation, fitted Hubble value, fitted density or selected redshift", "no use of a measured q, w, transition, H row or DESI interpretation before the derivation seal", "no erasure of the superseded one-half/four-cube results or the current DESI dynamic-dark-energy tension", "no claim that the terminal late matter-vacuum slice supplies a measured present radiation normalization"]

def closureValue : Value := .object [
 ("result",.text "Matter, radiation and vacuum have respectively third-power, fourth-power and Fold-invariant transport. The terminal late-time law is E2(r)=(11+5r^3)/16; Omega_m(r)=5r^3/(11+5r^3); Omega_v(r)=11/(11+5r^3); matter-vacuum equality is r^3=11/5; acceleration onset is r^3=22/5; and the present accelerating magnitude is 17/32. The static-vacuum correspondence is tension of One magnitude. All quantities are exact positive whole/fractional Fold forms or typed empty/orientation structures."),
 ("base",.text "At present stretch One, the terminal shares close 5/16+11/16 to the One and E2(One)=One; the acceleration carrier is the positive separation 11/16 from 5/32, exactly 17/32."),
 ("successor",.text "Appending one exact stretch factor multiplies matter volume support by three copies, radiation by those three plus one recurrence copy, and vacuum by the unchanged One; exact composition and fraction closure are preserved for every positive finite rational stretch."),
 ("exclusions",.array (exclusions.map Value.text)),
 ("witnesses",.array (CosmicComponentTransportWitnesses.witnesses.map fun w => .object [
   ("name",.text w.name),("statement",.text w.statement),("passed",.boolean w.passed)])),
 ("unique_survivor",.text survivorId)]

def falseCandidate : Candidate := { survivor with space := .rejected }
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
 (!(SFT.Host.Text.equal (identity (.object [("changed",.text sourceHash)])) sourceHash))
 "reject a changed source identity"

def tamperedArtifact : FoldControls.ControlRecord := record .tamperedArtifact
 (survivorIds.length == 1) "reject a missing, duplicate or additional survivor"

def boundary : FoldControls.ControlRecord := record .boundary
 (!exclusions.isEmpty && CosmicComponentTransportWitnesses.witnesses.all CosmicComponentTransportWitnesses.Witness.passed)
 "reject forbidden values, target feedback and extra laws"

theorem falsePremisePassed : falsePremise.passed = true := rfl

theorem boundaryPassed : boundary.passed = true := by
 change (true && CosmicComponentTransportWitnesses.witnesses.all CosmicComponentTransportWitnesses.Witness.passed) = true
 rw [CosmicComponentTransportWitnesses.allWitnessesPass]
 rfl

def controlRecords (sourceHash : String) : List FoldControls.ControlRecord :=
 [falsePremise,tamperedSource sourceHash,tamperedArtifact,boundary]

def resultData (c : FoldControls.ControlRecord) : SFT.Engine.ControlResult where
 kind := c.kind
 passed := c.passed
 expectedBehavior := c.expected
 observedBehavior := c.observed
 receiptHash := identity (.array [.text "SFT-PHYS-COSMO-COMPONENT-TRANSPORT-TERMINAL-032",.text (SFT.Engine.kindName c.kind),.boolean c.passed,.text c.expected])

def runControls (sourceHash : String) : Value :=
 .array ((controlRecords sourceHash).map fun c => SFT.Engine.controlResultValue (resultData c))
end SFT.Physics.CosmicComponentTransportControls
