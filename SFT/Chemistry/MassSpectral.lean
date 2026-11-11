import SFT.Chemistry.IonTransfer
import SFT.Chemistry.IsotopeFamily
import SFT.Mathematics.FoldScalar
namespace SFT.Chemistry.MassSpectral
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.ExactOperations
open SFT.Mathematics.FoldScalar

def carrierAtoms : IonTransfer.Carrier → List ElementIdentity.Atom
 | .atomic atom => [atom]
 | .molecular first rest _ => first::rest

-- Mass remains a source-bound exact reading; it is not replaced by mass number.
structure Ion where
 state : IonTransfer.State
 orientation : IonTransfer.Held
 magnitude : SFT.Physics.CapabilityValues.PositiveCount
 chargeBound : IonTransfer.charge state=.charged orientation magnitude.value magnitude.positive
 isotopes : List IsotopeFamily.Nuclide
 completeIsotopes : isotopes.map IsotopeFamily.Nuclide.atom=carrierAtoms state.carrier
 mass : PositiveFraction
 massSource : SFT.Host.Canonical.Value

def chargeMagnitude (ion : Ion) : PositiveFraction :=
 normalizePositive ion.magnitude.value 1 ion.magnitude.positive (by decide)

def position (ion : Ion) : PositiveFraction := quotientMagnitude ion.mass (chargeMagnitude ion)

theorem generatedIon (ion : Ion) : IonTransfer.isIon ion.state := by
 unfold IonTransfer.isIon
 rw [ion.chargeBound]
 exact IonTransfer.positiveCharge _ _ _

theorem completeConstituentIsotopes (ion : Ion) (atom : ElementIdentity.Atom)
 (held : atom∈carrierAtoms ion.state.carrier) : ∃ isotope∈ion.isotopes, isotope.atom=atom := by
 rw [←ion.completeIsotopes] at held
 exact memMapPreimage _ _ _ held

theorem everyIsotopeBound (ion : Ion) (isotope : IsotopeFamily.Nuclide) (held : isotope∈ion.isotopes) :
 isotope.atom∈carrierAtoms ion.state.carrier := by
 rw [←ion.completeIsotopes]
 exact memMap _ _ _ held

theorem chargeMagnitudeExact (ion : Ion) :
 ion.magnitude.value*(chargeMagnitude ion).denominator=(chargeMagnitude ion).numerator*1 :=
 normalizedValuePreserved _ _ _ _

theorem massChargeExact (ion : Ion) :
 (ion.mass.numerator*(chargeMagnitude ion).denominator)*(position ion).denominator=
 (position ion).numerator*(ion.mass.denominator*(chargeMagnitude ion).numerator) := quotientExact _ _

theorem positivePosition (ion : Ion) : 0<(position ion).numerator := (position ion).positive

structure Row where
 ion : Ion
 abundance : SFT.Physics.CapabilityValues.PositiveCount
 responseSource : SFT.Host.Canonical.Value

def sameClass (a b : Row) : Bool :=
 decide ((position a.ion).numerator*(position b.ion).denominator=
  (position b.ion).numerator*(position a.ion).denominator)

theorem classExactly (a b : Row) : sameClass a b=true ↔
 (position a.ion).numerator*(position b.ion).denominator=
 (position b.ion).numerator*(position a.ion).denominator := by
 constructor
 · exact of_decide_eq_true
 · exact decide_eq_true

theorem ownClass (row : Row) : sameClass row row=true := decide_eq_true rfl

def responseTrace (rows : List Row) := rows.map (fun row => (position row.ion,row.abundance.value))

theorem everyResponseRetained (rows : List Row) (row : Row) (held : row∈rows) :
 (position row.ion,row.abundance.value)∈responseTrace rows := memMap _ _ _ held

theorem responseCoverage (rows : List Row) (pair : PositiveFraction×Nat) (held : pair∈responseTrace rows) :
 ∃ row∈rows, (position row.ion,row.abundance.value)=pair := memMapPreimage _ _ _ held

theorem responseTraceAppend (rows : List Row) (row : Row) :
 responseTrace (rows++[row])=responseTrace rows++[(position row.ion,row.abundance.value)] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _

def classCount (anchor : Row) : List Row → Nat
 | [] => 0
 | row::rest => (if sameClass anchor row then row.abundance.value else 0)+classCount anchor rest

theorem countAppend (anchor : Row) (rows : List Row) (row : Row) :
 classCount anchor (rows++[row])=classCount anchor rows+(if sameClass anchor row then row.abundance.value else 0) := by
 induction rows with
 | nil => exact (Nat.add_zero _).trans (Nat.zero_add _).symm
 | cons first rest ih =>
   change _+classCount anchor (rest++[row])=(_+classCount anchor rest)+_
   rw [ih,Nat.add_assoc]

theorem sameClassAddsAbundance (anchor : Row) (rows : List Row) (row : Row) (same : sameClass anchor row=true) :
 classCount anchor (rows++[row])=classCount anchor rows+row.abundance.value := by
 rw [countAppend,same]
 rfl

theorem otherClassUnchanged (anchor : Row) (rows : List Row) (row : Row) (different : sameClass anchor row=false) :
 classCount anchor (rows++[row])=classCount anchor rows := by
 rw [countAppend,different]
 change classCount anchor rows+0=classCount anchor rows
 exact Nat.add_zero _


theorem representedClassPositive (rows : List Row) (row : Row) (held : row∈rows) :
 0<classCount row rows := by
 induction held with
 | head =>
   change 0<(if sameClass row row then row.abundance.value else 0)+_
   rw [ownClass]
   change 0<row.abundance.value+_
   exact Nat.lt_of_lt_of_le row.abundance.positive (Nat.le_add_right _ _)
 | tail first held ih => exact Nat.lt_of_lt_of_le ih (Nat.le_add_left _ _)

def relativeAbundance (rows : List Row) (a b : Row) (ha : a∈rows) (hb : b∈rows) : PositiveFraction :=
 normalizePositive (classCount a rows) (classCount b rows)
  (representedClassPositive rows a ha) (representedClassPositive rows b hb)

theorem relativeAbundanceExact (rows : List Row) (a b : Row) (ha : a∈rows) (hb : b∈rows) :
 classCount a rows*(relativeAbundance rows a b ha hb).denominator=
 (relativeAbundance rows a b ha hb).numerator*classCount b rows := normalizedValuePreserved _ _ _ _

structure NamedRow where
 identity : SFT.Physics.CapabilityValues.HeldLabel
 row : Row

structure Origin where
 precursor : NamedRow
 fragment : NamedRow
 sourceRecord : SFT.Host.Canonical.Value

structure Spectrum where
 carriers : List NamedRow
 origins : List Origin
 completeOrigins : ∀ origin∈origins, origin.precursor∈carriers ∧ origin.fragment∈carriers
 ionizationMethod : SFT.Physics.CapabilityValues.HeldLabel
 conditions : SFT.Host.Canonical.Value
 instrument : SFT.Host.Canonical.Value

def rows (spectrum : Spectrum) := spectrum.carriers.map NamedRow.row
def trace (spectrum : Spectrum) := responseTrace (rows spectrum)

def base (carrier : NamedRow) (method : SFT.Physics.CapabilityValues.HeldLabel)
 (conditions instrument : SFT.Host.Canonical.Value) : Spectrum :=
 ⟨[carrier],[],(fun _ impossible => nomatch impossible),method,conditions,instrument⟩

def appendCarrier (spectrum : Spectrum) (carrier : NamedRow) : Spectrum where
 carriers := spectrum.carriers++[carrier]
 origins := spectrum.origins
 completeOrigins := fun origin held =>
  ⟨memAppendLeft _ _ _ (spectrum.completeOrigins origin held).1,
   memAppendLeft _ _ _ (spectrum.completeOrigins origin held).2⟩
 ionizationMethod := spectrum.ionizationMethod
 conditions := spectrum.conditions
 instrument := spectrum.instrument

def appendFragment (spectrum : Spectrum) (origin : Origin) (held : origin.precursor∈spectrum.carriers) : Spectrum where
 carriers := spectrum.carriers++[origin.fragment]
 origins := spectrum.origins++[origin]
 completeOrigins := by
  intro link member
  cases memAppendCases link spectrum.origins [origin] member with
  | inl old => exact ⟨memAppendLeft _ _ _ (spectrum.completeOrigins link old).1,
    memAppendLeft _ _ _ (spectrum.completeOrigins link old).2⟩
  | inr new => cases new with
    | head => exact ⟨memAppendLeft _ _ _ held,memAppendRight _ _ _ (.head [])⟩
    | tail _ impossible => cases impossible
 ionizationMethod := spectrum.ionizationMethod
 conditions := spectrum.conditions
 instrument := spectrum.instrument

-- Decomposition paths retain full source-bound endpoint records, not merely
-- equal display names; every step belongs to the declared origin ledger.
inductive DecompositionPath (origins : List Origin) : NamedRow → NamedRow → Type where
 | first (origin : Origin) (held : origin∈origins) : DecompositionPath origins origin.precursor origin.fragment
 | next {first middle : NamedRow} (history : DecompositionPath origins first middle)
   (origin : Origin) (held : origin∈origins) (bound : origin.precursor=middle) :
   DecompositionPath origins first origin.fragment

def pathRecords {origins : List Origin} {first last : NamedRow} :
 DecompositionPath origins first last → List Origin
 | .first origin _ => [origin]
 | .next history origin _ _ => pathRecords history++[origin]

def liftPath {origins : List Origin} {first last : NamedRow}
 (history : DecompositionPath origins first last) (added : List Origin) :
 DecompositionPath (origins++added) first last :=
 match history with
 | .first origin held => .first origin (memAppendLeft _ _ _ held)
 | .next prior origin held bound => .next (liftPath prior added) origin (memAppendLeft _ _ _ held) bound

theorem liftedPathExact {origins : List Origin} {first last : NamedRow}
 (history : DecompositionPath origins first last) (added : List Origin) :
 pathRecords (liftPath history added)=pathRecords history := by
 induction history with
 | first origin held => rfl
 | next prior origin held bound ih => exact congrArg (fun rows => rows++[origin]) ih

theorem everyPathStepHeld {origins : List Origin} {first last : NamedRow}
 (history : DecompositionPath origins first last) (origin : Origin) (member : origin∈pathRecords history) :
 origin∈origins := by
 induction history with
 | first link held =>
   cases member with
   | head => exact held
   | tail _ impossible => cases impossible
 | next prior link held bound ih =>
   cases memAppendCases origin _ [link] member with
   | inl old => exact ih old
   | inr new => cases new with
     | head => exact held
     | tail _ impossible => cases impossible

theorem baseTrace (carrier : NamedRow) (method : SFT.Physics.CapabilityValues.HeldLabel)
 (conditions instrument : SFT.Host.Canonical.Value) :
 trace (base carrier method conditions instrument)=[(position carrier.row.ion,carrier.row.abundance.value)] := rfl

theorem appendCarrierRows (spectrum : Spectrum) (carrier : NamedRow) :
 rows (appendCarrier spectrum carrier)=rows spectrum++[carrier.row] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend NamedRow.row spectrum.carriers [carrier]

theorem appendFragmentRows (spectrum : Spectrum) (origin : Origin) (held : origin.precursor∈spectrum.carriers) :
 rows (appendFragment spectrum origin held)=rows spectrum++[origin.fragment.row] :=
 SFT.Mathematics.ExactTraceArithmetic.mapAppend NamedRow.row spectrum.carriers [origin.fragment]

theorem appendCarrierTrace (spectrum : Spectrum) (carrier : NamedRow) :
 trace (appendCarrier spectrum carrier)=trace spectrum++[(position carrier.row.ion,carrier.row.abundance.value)] := by
 unfold trace
 rw [appendCarrierRows,responseTraceAppend]

theorem appendFragmentTrace (spectrum : Spectrum) (origin : Origin) (held : origin.precursor∈spectrum.carriers) :
 trace (appendFragment spectrum origin held)=trace spectrum++[(position origin.fragment.row.ion,origin.fragment.row.abundance.value)] := by
 unfold trace
 rw [appendFragmentRows,responseTraceAppend]

theorem priorOriginRetained (spectrum : Spectrum) (origin prior : Origin)
 (held : origin.precursor∈spectrum.carriers) (member : prior∈spectrum.origins) :
 prior∈(appendFragment spectrum origin held).origins := memAppendLeft _ _ _ member

theorem fragmentBoundaryRetained (spectrum : Spectrum) (origin : Origin) (held : origin.precursor∈spectrum.carriers) :
 (appendFragment spectrum origin held).ionizationMethod=spectrum.ionizationMethod ∧
 (appendFragment spectrum origin held).conditions=spectrum.conditions ∧
 (appendFragment spectrum origin held).instrument=spectrum.instrument := ⟨rfl,rfl,rfl⟩

end SFT.Chemistry.MassSpectral
