import SFT.Chemistry.ConformerCensus
import SFT.Chemistry.DihedralTorsion
namespace SFT.Chemistry.ConformerPopulation
open SFT.Host SFT.Physics.CapabilityValues ConformerAssignments ConformerCensus
open DihedralTorsion (Ratio Height CountInput fraction rawRatio)

inductive Occurrence where
 | emptyOne
 | count (value : PositiveCount)
 | otherEmptyOne (identity : String)
 | invalid

structure Observation where
 condition : HeldLabel
 boundary : PositiveCount
 trace : List Assignment
structure Row where
 equivalenceClass : List Assignment
 occurrence : Occurrence
 population : Height
 relativeEnergy : Height
structure PopulationCensus where
 conformers : Census
 observation : Observation
 rows : List Row

def orderedTake (higher lower : Height) : Except String Ratio :=
 match higher with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "higher conformer energy must retain a positive exact magnitude"
 | .ratio high =>
  match lower with
  | .emptyOne => .ok high
  | .otherEmptyOne _ | .invalid => .error "energy Take requires a strictly lower retained conformer state"
  | .ratio low =>
   let h := fraction high
   let l := fraction low
   if ordered : l.numerator*h.denominator < h.numerator*l.denominator then
    .ok (rawRatio (SFT.Physics.LeptonTake.heldRemainder h l ordered))
   else .error "energy Take requires a strictly lower retained conformer state"

def observation (condition : HeldLabel) (boundary : CountInput) (trace : List Assignment) : Except String Observation := do
 if !Text.equal condition.family "observation-condition" then
  throw "conformer population requires one retained observation condition"
 match boundary with
 | .other => throw "observation boundary must equal the complete positive trace length"
 | .count n =>
  if trace.length != n.value then throw "observation boundary must equal the complete positive trace length"
  return ⟨condition,n,trace⟩

def singletonEmpty : Height → Bool
 | .emptyOne => true
 | .ratio _ | .otherEmptyOne _ | .invalid => false
def positiveRatio : Height → Bool
 | .ratio _ => true
 | .emptyOne | .otherEmptyOne _ | .invalid => false
def validEnergy : Height → Bool
 | .emptyOne | .otherEmptyOne _ | .ratio _ => true
 | .invalid => false

def row (group : List Assignment) (occurrence : Occurrence) (population energy : Height) : Except String Row := do
 if group.isEmpty then throw "population row requires one complete conformer equivalence class"
 match occurrence with
 | .emptyOne =>
  if !singletonEmpty population then throw "unobserved class population is structural EmptyOne"
 | .count _ =>
  if !positiveRatio population then throw "observed class population requires positive exact count and ratio"
 | .otherEmptyOne _ | .invalid => throw "observed class population requires positive exact count and ratio"
 if !validEnergy energy then throw "relative energy must be structural least-state EmptyOne or positive exact magnitude"
 return ⟨group,occurrence,population,energy⟩

def sameClass : List Assignment → List Assignment → Bool
 | [],[] => true
 | a::as,b::bs => MulticentreSupport.sameWord a b && sameClass as bs
 | [],_::_ | _::_,[] => false
def sameClasses : List (List Assignment) → List (List Assignment) → Bool
 | [],[] => true
 | a::as,b::bs => sameClass a b && sameClasses as bs
 | [],_::_ | _::_,[] => false

def occurrences (group : List Assignment) : List Assignment → Nat
 | [] => 0
 | state::rest => (if containsAssignment group state then 1 else 0) + occurrences group rest

def occurrenceNat : Occurrence → Nat
 | .count n => n.value
 | .emptyOne | .otherEmptyOne _ | .invalid => 0

def validateCount (observed : Nat) (boundary : PositiveCount) (r : Row) : Except String Unit :=
 if observed<1 then
  match r.occurrence with
  | .emptyOne => if singletonEmpty r.population then .ok () else .error "structurally absent observations must remain EmptyOne"
  | .count _ | .otherEmptyOne _ | .invalid => .error "structurally absent observations must remain EmptyOne"
 else
  match r.occurrence,r.population with
  | .count n,.ratio p =>
   if n.value==observed && p.numerator.value==observed && p.denominator.value==boundary.value then .ok ()
   else .error "population must equal exact class occurrences over the retained boundary"
  | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ => .error "population must equal exact class occurrences over the retained boundary"
  | .count _,.emptyOne | .count _,.otherEmptyOne _ | .count _,.invalid => .error "population must equal exact class occurrences over the retained boundary"

def construct (conformers : Census) (observed : Observation) (rows : List Row) : Except String PopulationCensus := do
 if rows.length != conformers.equivalenceClasses.length then throw "population census requires every conformer class exactly once"
 if !sameClasses (rows.map Row.equivalenceClass) conformers.equivalenceClasses then throw "population rows changed or reordered the conformer quotient"
 if !(observed.trace.all (containsAssignment conformers.generatedAssignments)) then throw "observation trace contains an ungenerated conformer assignment"
 let total := (rows.map (fun r => occurrenceNat r.occurrence)).foldl Nat.add 0
 if total != observed.boundary.value then throw "population counts do not exhaust the complete observation boundary"
 rows.forM fun r => validateCount (occurrences r.equivalenceClass observed.trace) observed.boundary r
 return ⟨conformers,observed,rows⟩

def generatedRow (group : List Assignment) (energy : Height) (trace : List Assignment) (boundary : PositiveCount) : Except String Row :=
 let n := occurrences group trace
 if positive : 0<n then row group (.count ⟨n,positive⟩) (.ratio ⟨⟨n,positive⟩,boundary⟩) energy
 else row group .emptyOne .emptyOne energy

def conditioned (conformers : Census) (condition : HeldLabel) (trace : List Assignment) (energies : List Height) : Except String PopulationCensus := do
 if trace.isEmpty || energies.length != conformers.equivalenceClasses.length then
  throw "complete trace and one energy record per conformer class are required"
 let boundary ← count trace.length
 let rows ← (conformers.equivalenceClasses.zip energies).mapM fun (group,energy) => generatedRow group energy trace boundary
 let observed ← observation condition (.count boundary) trace
 construct conformers observed rows

def appendObservation (census : PopulationCensus) (assignment : Assignment) : Except String PopulationCensus :=
 conditioned census.conformers census.observation.condition (census.observation.trace++[assignment]) (census.rows.map Row.relativeEnergy)

-- The source's Fraction(0,1) is only a sorting key for the singleton EmptyOne.
-- No numerical zero is inserted into a native population or energy record.
def orderKey : Height → Except String (Nat×Nat)
 | .emptyOne => .ok (0,1)
 | .ratio r => .ok (r.numerator.value,r.denominator.value)
 | .otherEmptyOne _ => .error "'EmptyOne' object has no attribute 'fraction'"
 | .invalid => .error "invalid conformer magnitude has no exact fraction"
def precedes (descending : Bool) (a b : Nat×Nat) : Bool :=
 if descending then a.1*b.2>=b.1*a.2 else a.1*b.2<=b.1*a.2
def insertKeyed (descending : Bool) (row : Row×(Nat×Nat)) : List (Row×(Nat×Nat)) → List (Row×(Nat×Nat))
 | [] => [row]
 | first::rest => if precedes descending row.2 first.2 then row::first::rest else first::insertKeyed descending row rest
def sortKeyed (descending : Bool) : List (Row×(Nat×Nat)) → List (Row×(Nat×Nat))
 | [] => []
 | first::rest => insertKeyed descending first (sortKeyed descending rest)
def orderedRows (rows : List Row) (key : Row→Height) (descending : Bool) : Except String (List (List Assignment)) := do
 let keyed ← rows.mapM fun r => do return (r,← orderKey (key r))
 return (sortKeyed descending keyed).map (fun r => r.1.equivalenceClass)
def populationOrder (census : PopulationCensus) := orderedRows census.rows Row.population true
def energyOrder (census : PopulationCensus) := orderedRows census.rows Row.relativeEnergy false
end SFT.Chemistry.ConformerPopulation
