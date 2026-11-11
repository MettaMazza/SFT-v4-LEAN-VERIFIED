import SFT.Chemistry.IonTransfer
namespace SFT.Chemistry.PeriodicRelease
open PeriodicOrderTrace
structure Release where
 last : Row
 sequence : Sequence last
 releaseDate : String
 sourceId : String
 sourceHash : String
 extractionTrace : SFT.Host.Canonical.Value

def rows (release : Release) := records release.sequence
def extent (release : Release) := coordinate release.last

theorem terminalHeld {last : Row} (sequence : Sequence last) : last ∈ records sequence := by
 cases sequence with
 | first row valid one => exact .head _
 | next history row valid successor => exact SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _)

theorem allCoordinatesBounded {last : Row} (sequence : Sequence last) (row : Row) (held : row ∈ records sequence) :
 coordinate row ≤ coordinate last := by
 induction sequence with
 | first first valid one =>
   cases held with
   | head => exact Nat.le_refl _
   | tail _ impossible => cases impossible
 | next history next valid successor ih =>
   cases SFT.Foundation.Count.TraceDerivation.memAppendCases row (records history) [next] held with
   | inl old =>
     exact Nat.le_trans (ih old) (Nat.le_of_lt (successorStrict history next valid successor))
   | inr fresh =>
     cases fresh with
     | head => exact Nat.le_refl _
     | tail _ impossible => cases impossible

theorem extentAttained (release : Release) : release.last ∈ rows release := terminalHeld _
theorem extentBoundsEveryRow (release : Release) (row : Row) (held : row ∈ rows release) :
 coordinate row ≤ extent release := allCoordinatesBounded _ _ held

theorem completeCensusCount (release : Release) : (rows release).length = extent release :=
 (completeTraceLength _).trans (coordinateForced _).symm

theorem greatestUnique (release : Release) (row : Row) (held : row ∈ rows release)
 (upper : ∀ other ∈ rows release, coordinate other ≤ coordinate row) : coordinate row = extent release :=
 Nat.le_antisymm (extentBoundsEveryRow _ _ held) (upper _ (extentAttained _))

def extend (release : Release) (row : Row) (valid : PeriodicOrderTrace.valid row)
 (successor : coordinate row = extent release + 1) (date source hash : String)
 (trace : SFT.Host.Canonical.Value) : Release :=
 ⟨row,.next release.sequence row valid successor,date,source,hash,trace⟩

theorem extensionExtent (release : Release) (row : Row) (valid : PeriodicOrderTrace.valid row)
 (successor : coordinate row = extent release + 1) (date source hash : String) (trace : SFT.Host.Canonical.Value) :
 extent (extend release row valid successor date source hash trace) = extent release + 1 := successor

theorem extensionRetainsRows (release : Release) (row : Row) (valid : PeriodicOrderTrace.valid row)
 (successor : coordinate row = extent release + 1) (date source hash : String) (trace : SFT.Host.Canonical.Value)
 (old : Row) (held : old ∈ rows release) : old ∈ rows (extend release row valid successor date source hash trace) :=
 retainsEveryRow _ _ _ _ _ held

theorem beyondReleaseAbsent (release : Release) (row : Row) (later : extent release < coordinate row) :
 row ∉ rows release := fun held => Nat.not_le_of_gt later (extentBoundsEveryRow _ _ held)

theorem absentSuccessorAdmittedInExtension (release : Release) (row : Row) (valid : PeriodicOrderTrace.valid row)
 (successor : coordinate row = extent release + 1) (date source hash : String) (trace : SFT.Host.Canonical.Value) :
 row ∉ rows release ∧ row ∈ rows (extend release row valid successor date source hash trace) := by
 refine ⟨beyondReleaseAbsent release row ?_,extentAttained _⟩
 rw [successor]
 exact Nat.lt_succ_self _

theorem sourceDateRetained (release : Release) :
 (release.releaseDate,release.sourceId,release.sourceHash,release.extractionTrace).1 = release.releaseDate := rfl
end SFT.Chemistry.PeriodicRelease
