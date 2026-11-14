import SFT.Physics.AtomicShellPeriodicity
import SFT.Physics.AtomicShellRecords
namespace SFT.Physics.AtomicShellMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicShellRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def ionizationInterval (record : Value) (symbol : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field (← field record "sources") "ionization") "rows") symbol
 let centre ← decimalField row "value_eV"
 let spreadValue := (field row "uncertainty_eV").toOption.getD ((field row "display_half_width_eV").toOption.getD (.text "missing"))
 let spread ← LeptonDecimal.exactDecimal (← text spreadValue)
 let lower ← RunningConvergence.positiveTake centre spread
 pure (lower,add centre spread)
def configurations : List (String × String) := [("He","1s2"),("Li","1s2.2s"),("Ne","1s2.2s2.2p6"),("Na","[Ne].3s"),("Ar","[Ne].3s2.3p6"),("K","[Ar].4s"),("Kr","[Ar].3d10.4s2.4p6"),("Rb","[Kr].5s"),("Xe","[Cd].5p6"),("Cs","[Xe].6s"),("Rn","[Hg].6p6"),("Fr","[Rn].7s")]
def envelopes : List (String × String) := [("H","He"),("Li","Ne"),("Na","Ar"),("K","Kr"),("Rb","Xe"),("Cs","Rn")]
def resets : List (String × String) := [("He","Li"),("Ne","Na"),("Ar","K"),("Kr","Rb"),("Xe","Cs"),("Rn","Fr")]
def localDips : List (String × String) := [("Be","B"),("N","O"),("Mg","Al")]
def label : String := "exact-shell-sum-and-generated-period-widths-match-IUPAC__NIST-configurations-and-ionization-envelope-reset-vector-passed-with-local-dips-retained"
def allSeparated (record : Value) (rows : List (String × String)) : Except String Bool := do
 rows.foldlM (fun held pair => do
  if !held then return false
  let high ← ionizationInterval record pair.1
  let low ← ionizationInterval record pair.2
  pure (held && low.2.blt high.1)) true
def classificationFromRecord (record : Value) : Except String String := do
 let sources ← field record "sources"
 let periodic ← field (← field sources "periodic_table") "row"
 let closures ← AtomicShellPeriodicity.generatedPeriodClosures (.count (.integer 7))
 let widths ← AtomicShellPeriodicity.generatedPeriodWidths (.count (.integer 7))
 if !sameValue (← field periodic "closure_atomic_numbers") (.array (closures.map fun n => .integer (.ofNat n))) then
  throw "generated closures differ from the IUPAC table"
 if !sameValue (← field periodic "period_widths") (.array (widths.map fun n => .integer (.ofNat n))) then
  throw "generated widths differ from the IUPAC table"
 let rows ← field (← field sources "ionization") "rows"
 let configurationsMatch ← configurations.foldlM (fun held pair => do
  if !held then return false
  let shells ← field (← field rows pair.1) "ground_shells"
  pure (held && sameValue shells (.text pair.2))) true
 if !configurationsMatch then throw "registered NIST closure/successor configuration changed"
 if !(← allSeparated record (envelopes.map fun p => (p.2,p.1))) then
  throw "a registered period endpoint no longer exceeds its start"
 if !(← allSeparated record resets) then
  throw "a registered closure-to-successor ionization reset failed"
 if !(← allSeparated record localDips) then
  throw "a retained local ionization dip changed"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := match AtomicShellPeriodicity.generatedPeriodClosures (.count (.integer 7)) with
 | .error _ => false
 | .ok closures => match AtomicShellPeriodicity.generatedPeriodWidths (.count (.integer 7)) with
  | .error _ => false
  | .ok widths => closures==[2,10,18,36,54,86,118] && widths==[2,8,8,18,18,32,32]
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.AtomicShellMeasurement
