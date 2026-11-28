import SFT.Applications.Discovery.USDEPhysics
import SFT.Applications.Discovery.FloatText
namespace SFT.Applications.Discovery.AcademicReport
open SFT.Applications.Discovery
open SFT.Applications.Discovery.USDECore
open SFT.Applications.Discovery.USDEPhysics
open SFT.Applications.Discovery.USDEEigenvalues
open SFT.Applications.Discovery.USDESweep
open SFT.Applications.Discovery.Reports
open SFT.Applications.Discovery.Display
open SFT.Host.Text
def invariantDescriptions : List (String × String × String) := [
 ("T1_confines","Confinement","Checks if every coordinate x pairs with an antipode (1 - x) to sum to the One. Physically, this indicates whether state-space endpoints are perfectly confined and symmetric, preventing fractional coordinates or charges from leaking out of the system."),
 ("T2_closed","Algebraic Closure","Checks if folding coordinates by the prime generators (2, 3, 5, 7) maps back into the same denominator family. Physically, this confirms algebraic closure, showing that no dynamic interactions can escape the localized sector."),
 ("T3_resolves","Dynamic Resolution","Checks if all coordinates eventually resolve to a stable fixed point or cycle under double-folding. Physically, this ensures the sector has stable attractor states, avoiding chaotic or unbounded divergence."),
 ("T4_single_sector","Boundary Quantization","Checks if all coordinates belong to the standing modes of the sector boundary m. Physically, this confirms that the sector's coordinates are quantized to fit the boundary constraints of the sector's size."),
 ("T5_pair_law","Symmetry Balance","Checks if the number of internal antipode pairs matches (m-1)/2. Physically, this represents the balance of internal degrees of freedom/chirality pairs expected for a boundary of size m."),
 ("T6_handedness","Chiral Preimage Splitting","Checks if preimages split symmetrically across the unit midpoint. Physically, this reflects chiral handedness separation, ensuring that left- and right-handed states are distinct."),
 ("T7_causality","Metric Causality","Checks if coordinate differences satisfy Minkowski-like intervals under ticks. Physically, this guarantees local causality, preventing superluminal or backward-in-time propagation within the lattice."),
 ("T8_dimension","Dimensional Constraint","Checks if the size of the coordinate group fits within the sector boundary. Physically, this enforces spatial dimensionality limits, selecting physical configurations compatible with 3 spatial dimensions."),
 ("T9_sync","Sync Threshold","Checks if the coupling tipping point is exactly (m-1)/m. Physically, this marks the threshold where coupled copies of the fold lock phase and act as a single coherent observer or particle."),
 ("T10_curvature","Curvature Stability","Checks if denominators of coordinates are bounded from below. Physically, this ensures that the discrete curvature of the coordinate lattice does not blow up, preventing singular instabilities."),
 ("T11_scale_indep","Scale Invariance","Checks if ratios of energy levels are independent of the grid size. Physically, this establishes scale invariance, which is required for consistent physical predictions at different energy scales."),
 ("T12_cp_closure","CP Symmetry Preservation","Checks if the sector boundary m is an odd prime. Physically, this preserves CP symmetry (Charge-Parity) through phase closure in odd-numbered cycles.")
]
def flags (p : AnalyticalProof) : List Bool := [p.confines,p.closed,p.resolves,p.singleSector,p.pairLaw,p.handedness,p.causality,p.dimension,p.sync,p.curvature,p.scaleIndep,p.cpClosure]

def groupLines (particles : ParticleQueries) (group : List Fraction) : Except String (List String) := do
 match group with
 | [] => .error "list index out of range"
 | first::_ =>
  let sector := first.denominator+1
  let proof := runAutoProof group sector
  let eigenvalues ← solveEigenvalues sector
  let physics := crossReferencePhysics particles sector eigenvalues
  let coords := intercalate ", " ((sortFractions group).map (fun x => join [fractionText x," (~",FloatText.fixed (Float.ofInt x.numerator/Float.ofInt x.denominator) 6,")"]))
  let heading := [append "## Sector m = " (number sector),append "- **Coordinate Count (Size)**: " (n group.length),join ["- **Coordinates**: `",coords,"`"],"","### Invariant Proof Matrix (T1–T12)","| Invariant | Name | Status | Description |","|---|---|---|---|"]
  let matrix := (invariantDescriptions.zip (flags proof)).map (fun ((key,name,description),passed) => join ["| ",String.ofList ((chars key).takeWhile (fun c => decide (c.toNat≠95)))," | ",name," | ",if passed then "✅ PASS" else "❌ FAIL"," | ",description," |"])
  let spectrum := if eigenvalues.isEmpty then [] else ["### Eigenvalue Spectrum","Solving the sector polynomial:","$$\\lambda^3 - \\lambda^2 + e_2 \\lambda - e_3 = 0$$",join ["where $e_2 = 1/(2m) = ",FloatText.fixed (1.0/Float.ofInt (2*sector)) 6,"$ and $e_3 = 1/(2m^5-1) = ",FloatText.fixed (1.0/Float.ofInt (2*wholePower sector 5-1)) 8,"$."],join ["- **Eigenvalues (\\lambda^2)**: `[",intercalate ", " (eigenvalues.map (fun x => FloatText.fixed x 8)),"]`"],""]
  let empirical := if physics.alignments.isEmpty then [] else
   "### Empirical Matches"::physics.alignments.flatMap (fun a => [append "#### 🎯 " a.name,append "- **Calculated Ratio**: " (FloatText.fixed a.calculated 6),append "- **Measured Ratio**: " (FloatText.fixed a.measured 6),join ["- **Deviation**: ",FloatText.fixed a.deviationPct 4,"%"],append "- **T1-T4 Proof Status**: " (if proof.proves then "Verified Sector" else "Unproved Sector (Empirical Only)"),""])
  .ok (heading++matrix++[""]++spectrum++empirical++["---",""])

def reportText (particles : ParticleQueries) (limit : Nat) (timestamp : String) : Except String (String × Nat) := do
 let scan := candidateGroups limit false
 let heading := ["# Smithian Fold Theory — Universal Discovery Atlas",append "Generated at: " timestamp,append "Sweep Limit Depth N: " (n limit),append "Coordinates Scanned: " (n scan.coordinatesScanned),append "Candidate Sectors Identified: " (n scan.groups.length),"","## Executive Summary","This document translates the raw mathematical coordinate orbits generated by the dyadic fold map into physical and algebraic descriptions. The system starts from a single axiom—the fold—and generates coordinate sets representing discrete sectors. For each sector, we solve the characteristic eigenvalues and match them against measured physical particles (Particle Data Group), testing them against the 12 theoretical invariants (T1–T12).","","---",""]
 let bodies ← scan.groups.mapM (groupLines particles)
 .ok (intercalate "\n" (heading++bodies.flatten),scan.groups.length)

def generateAcademicReport (particles : ParticleQueries) (limit : Nat) (outputPath : String := "usde_reports/discovery_atlas.md") : IO Nat := do
 let path := System.FilePath.mk outputPath
 match path.parent with
 | none => pure ()
 | some parent => if !(SFT.Host.Text.equal parent.toString "") then IO.FS.createDirAll parent
 let time ← IO.Process.output {cmd := "/bin/date",args := #["+%Y-%m-%d %H:%M:%S"]}
 let timestamp := String.ofList ((chars time.stdout).filter (fun c => decide (c.toNat≠10 ∧ c.toNat≠13)))
 match reportText particles limit timestamp with
 | .error e => throw (IO.userError e)
 | .ok (content,count) =>
  IO.FS.writeBinFile path content.toUTF8
  return count
end SFT.Applications.Discovery.AcademicReport
