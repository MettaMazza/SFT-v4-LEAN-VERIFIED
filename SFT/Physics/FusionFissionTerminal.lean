import SFT.Foundation.HalfOneDerivation
import SFT.Physics.NuclearBindingRadius
import SFT.Physics.NuclearBindingPeakClosure
namespace SFT.Physics.FusionFissionTerminal
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
structure Coordinate where
 massCount : Nat
 chargeCount : Nat
 deriving DecidableEq, BEq
def coordinate : CountInput → CountInput → Except String Coordinate
 | .boolean _,_ => .error "nuclear coordinates require exact positive counts"
 | .integer _,.boolean _ => .error "nuclear coordinates require exact positive counts"
 | .integer a,.integer z =>
   if a < 2 || z < 1 || z ≥ a then .error "nuclear coordinates require positive proton and neutron support"
   else .ok ⟨a.toNat,z.toNat⟩
def neutronCount (c : Coordinate) := c.massCount-c.chargeCount
structure ReactionTrace where
 incident : List Coordinate
 products : List Coordinate
 operation : String
def reactionTrace (incident products : List Coordinate) (operation : String) : Except String ReactionTrace :=
 if incident.isEmpty || products.isEmpty then .error "a reaction requires positive incident and product support"
 else .ok ⟨incident,products,operation⟩
def positiveCountSum (values : List CountInput) : Except String Nat := do
 if values.isEmpty then throw "a nuclear total requires nonempty positive counts"
 let ns ← values.mapM (fun v => match v with
  | .boolean _ => .error "a nuclear total requires nonempty positive counts"
  | .integer n => if n<1 then .error "a nuclear total requires nonempty positive counts" else .ok n.toNat)
 match ns with
 | [] => throw "a nuclear total requires nonempty positive counts"
 | first::rest => pure (rest.foldl (·+·) first)
def coordinateJunction (left right : Coordinate) : Except String Coordinate :=
 coordinate (.integer (.ofNat (left.massCount+right.massCount))) (.integer (.ofNat (left.chargeCount+right.chargeCount)))
def coordinateBinarySplit (parent : Coordinate) : Except String (Coordinate × Coordinate) := do
 if parent.massCount%2 != 0 || parent.chargeCount%2 != 0 then
  throw "the registered binary representative must split into exact whole coordinates"
 let part ← coordinate (.integer (.ofNat (parent.massCount/2))) (.integer (.ofNat (parent.chargeCount/2)))
 pure (part,part)
def deuteron : Coordinate := ⟨2,1⟩
def heliumFour : Coordinate := ⟨4,2⟩
def heavyParent : Coordinate := ⟨238,92⟩
def symmetricHeavyProduct : Coordinate := ⟨119,46⟩
def fusionTrace (operation : String) : Except String ReactionTrace := do
 if SFT.Host.Text.equal operation "identity" then reactionTrace [deuteron] [deuteron] operation
 else if SFT.Host.Text.equal operation "binary-junction" then
  reactionTrace [deuteron,deuteron] [← coordinateJunction deuteron deuteron] operation
 else if SFT.Host.Text.equal operation "binary-decomposition" then reactionTrace [heliumFour] [deuteron,deuteron] operation
 else throw "fusion candidate names an ungenerated operation"
def fissionTrace (operation : String) : Except String ReactionTrace := do
 let parts ← coordinateBinarySplit heavyParent
 if SFT.Host.Text.equal operation "identity" then reactionTrace [heavyParent] [heavyParent] operation
 else if SFT.Host.Text.equal operation "binary-junction" then
  reactionTrace [parts.1,parts.2] [← coordinateJunction parts.1 parts.2] operation
 else if SFT.Host.Text.equal operation "binary-decomposition" then reactionTrace [heavyParent] [parts.1,parts.2] operation
 else throw "fission candidate names an ungenerated operation"
def reactionConservesCounts (trace : ReactionTrace) : Except String Bool := do
 let total := fun rows f => positiveCountSum (rows.map (fun x => CountInput.integer (.ofNat (f x))))
 let ai ← total trace.incident Coordinate.massCount
 let ao ← total trace.products Coordinate.massCount
 if ai != ao then pure false else do
  let zi ← total trace.incident Coordinate.chargeCount
  let zo ← total trace.products Coordinate.chargeCount
  if zi != zo then pure false else do
   let ni ← total trace.incident neutronCount
   let no ← total trace.products neutronCount
   pure (ni == no)
def totalBindingEnclosure (coordinates : List Coordinate) : Except String (Rat × Rat) := do
 let parts ← coordinates.mapM (fun c => do
  let (lo,hi) ← NuclearBindingRadius.bindingScoreEnclosure (.integer (.ofNat c.massCount)) (.integer (.ofNat c.chargeCount)) (.integer 16)
  pure (multiply (wholeRatio c.massCount) lo,multiply (wholeRatio c.massCount) hi))
 match parts with
 | [] => throw "IndexError"
 | first::rest => pure (rest.foldl (fun a b => (add a.1 b.1,add a.2 b.2)) first)
def bindingGainEnclosure (trace : ReactionTrace) : Except String (Option (Rat × Rat)) := do
 let incident ← totalBindingEnclosure trace.incident
 let products ← totalBindingEnclosure trace.products
 if !incident.2.blt products.1 then pure none else do
  let lo ← RunningConvergence.positiveTake products.1 incident.2
  let hi ← RunningConvergence.positiveTake products.2 incident.1
  pure (some (lo,hi))
def reactionIncreasesBinding (trace : ReactionTrace) : Except String Bool := do
 if !(← reactionConservesCounts trace) then pure false else pure (← bindingGainEnclosure trace).isSome
def fusionOperationIsForced (operation : String) : Except String Bool := do
 let t ← fusionTrace operation
 if t.incident.length != 2 || t.products.length != 1 || t.products.head? != some heliumFour then pure false
 else reactionIncreasesBinding t
def fissionOperationIsForced (operation : String) : Except String Bool := do
 let t ← fissionTrace operation
 if t.incident.length != 1 || t.products.length != 2 || t.products != [symmetricHeavyProduct,symmetricHeavyProduct] then pure false
 else reactionIncreasesBinding t
def bindingDirectionIsForced (direction : String) : Except String Bool := do
 let fusion ← fusionTrace "binary-junction"
 let fission ← fissionTrace "binary-decomposition"
 let a ← reactionIncreasesBinding fusion
 let b ← reactionIncreasesBinding fission
 if SFT.Host.Text.equal direction "toward-higher-binding" then pure (a&&b)
 else if SFT.Host.Text.equal direction "toward-lower-binding" then do
  let fi ← totalBindingEnclosure fusion.incident
  let fo ← totalBindingEnclosure fusion.products
  let si ← totalBindingEnclosure fission.incident
  let so ← totalBindingEnclosure fission.products
  pure (fo.2.blt fi.1 && so.2.blt si.1)
 else throw "binding candidate names an ungenerated direction"
def barrierPart (label : String) : Except String Rat :=
 if SFT.Host.Text.equal label "quarter-One" then .ok (normalize 1 4 (by decide))
 else if SFT.Host.Text.equal label "half-One" then .ok (normalize 1 2 (by decide))
 else if SFT.Host.Text.equal label "three-quarter-One" then .ok (normalize 3 4 (by decide))
 else if SFT.Host.Text.equal label "One" then .ok (wholeRatio 1)
 else .error "barrier candidate names an ungenerated Fold part"
def barrierIsForced (label : String) : Except String Bool := do
 let part ← barrierPart label
 let half := SFT.Foundation.HalfOneDerivation.halfOne
 let forced := normalize (.ofNat half.numerator) half.denominator (SFT.Foundation.ExactPartCarrier.denominatorPositive half)
 pure (part == forced && add part forced == wholeRatio 1)
def releaseAccountingIsForced (accounting : String) : Except String Bool := do
 let fusion ← fusionTrace "binary-junction"
 let fission ← fissionTrace "binary-decomposition"
 let fg ← bindingGainEnclosure fusion
 let sg ← bindingGainEnclosure fission
 let fc ← reactionConservesCounts fusion
 let sc ← reactionConservesCounts fission
 let complete := fg.isSome && sg.isSome && fc && sc
 if SFT.Host.Text.equal accounting "complete-held-release" then pure complete
 else if SFT.Host.Text.equal accounting "unrecorded-release" then pure (!complete)
 else throw "energy candidate names an ungenerated accounting state"
-- Reuse the already proved complete source peak; do not recompute its census.
def peakClosureIsForced (closure : String) : Except String Bool :=
 let cert := NuclearBindingPeakClosure.originalCertificate
 let unique := cert.massNumber==62 && cert.chargeCount==28 && cert.neutronCount==34 && cert.rivalUpper.blt cert.scoreLower && cert.tailClosed
 if SFT.Host.Text.equal closure "unique-unbounded-peak" then .ok unique
 else if SFT.Host.Text.equal closure "selected-finite-peak" then .ok (!cert.tailClosed)
 else .error "peak candidate names an ungenerated closure state"
def targetBoundaryIsForced (boundary : String) : Except String Bool :=
 if SFT.Host.Text.equal boundary "sealed-before-release" then .ok true
 else if SFT.Host.Text.equal boundary "readable-before-seal" then .ok false
 else .error "target candidate names an ungenerated custody state"
def extensionIsForced (extension : String) : Except String Bool :=
 if SFT.Host.Text.equal extension "empty-extension" then .ok true
 else if SFT.Host.Text.equal extension "free-correction" then .ok false
 else .error "extension candidate names an ungenerated state"
theorem inheritedPeak : NuclearBindingPeak.bindingPeakWithin 7 4 = .ok (some NuclearBindingPeakClosure.originalCertificate) := NuclearBindingPeakClosure.completePeak
theorem fusionCounts : reactionConservesCounts ⟨[deuteron,deuteron],[heliumFour],"binary-junction"⟩ = .ok true := rfl
theorem fissionCounts : reactionConservesCounts ⟨[heavyParent],[symmetricHeavyProduct,symmetricHeavyProduct],"binary-decomposition"⟩ = .ok true := rfl
theorem halfOneBarrier : barrierIsForced "half-One" = .ok true := rfl
end SFT.Physics.FusionFissionTerminal
