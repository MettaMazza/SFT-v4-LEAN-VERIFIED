import SFT.Physics.InflationGrowthCertificate
namespace SFT.Physics.CollectiveRadiation
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def requirePositive (value : Rat) (name : String) : Except String Rat :=
 if zero.blt value then .ok value else .error (SFT.Host.Text.append name " must be an exact positive Fold carrier")
def positiveCount (value : CountInput) (error : String) : Except String Nat :=
 match value with
 | .boolean _ => .error error
 | .integer (.negSucc _) => .error error
 | .integer (.ofNat 0) => .error error
 | .integer (.ofNat (.succ n)) => .ok (n+1)
def checkedCosts (costs : List CountInput) : Except String (List Nat) := do
 if costs.isEmpty then throw "mode costs must be positive generated wholes"
 costs.mapM (fun c => positiveCount c "mode costs must be positive generated wholes")
def occupationProduct : List (List Nat) → List (List Nat)
 | [] => [[]]
 | axis::rest => axis.flatMap (fun count => (occupationProduct rest).map (List.cons count))
def wordEnergy (costs word : List Nat) : Nat :=
 (costs.zip word).foldl (fun total (cost,count) => total+cost*count) 0
def completeWords (costs : List Nat) (total : Nat) : List (List Nat) :=
 (occupationProduct (costs.map (fun c => List.range (total/c+1)))).filter (fun word => wordEnergy costs word == total)
def finiteBosonOccupations (modeCosts : List CountInput) (totalQuanta : CountInput) : Except String (List (List Nat)) := do
 let costs ← checkedCosts modeCosts
 let total ← positiveCount totalQuanta "total quanta must be a positive generated whole"
 pure (completeWords costs total)
def occupationAt : List Nat → Nat → Nat
 | [], _ => 0
 | n::_, 0 => n
 | _::rest, .succ i => occupationAt rest i
def exactModeOccupation (modeCosts : List CountInput) (totalQuanta : CountInput) : Except String (List Rat) := do
 let words ← finiteBosonOccupations modeCosts totalQuanta
 if words.isEmpty then throw "generated support has no complete occupation word"
 (List.range modeCosts.length).mapM (fun index =>
  LeptonRatios.divide (wholeRatio (words.foldl (fun total word => total+occupationAt word index) 0)) (wholeRatio words.length))
def ultravioletClosed (modeCosts : List CountInput) (totalQuanta : CountInput) : Except String Bool := do
 let occupations ← exactModeOccupation modeCosts totalQuanta
 let costs ← checkedCosts modeCosts
 let total ← positiveCount totalQuanta "total quanta must be a positive generated whole"
 pure ((costs.zip occupations).all (fun (cost,occupation) => if total<cost then VelocityComposition.ratEqual occupation zero else true))
def occupationScaleCovariant (modeCosts : List CountInput) (totalQuanta scale : CountInput) : Except String Bool := do
 let s ← positiveCount scale "scale must be a positive generated whole"
 let before ← finiteBosonOccupations modeCosts totalQuanta
 let costs ← checkedCosts modeCosts
 let total ← positiveCount totalQuanta "total quanta must be a positive generated whole"
 let after ← finiteBosonOccupations (costs.map (fun c => .integer (.ofNat (s*c)))) (.integer (.ofNat (s*total)))
 pure (before == after)
def radiationPowerRatio (temperatureRatio : Rat) : Except String Rat := do
 let r ← requirePositive temperatureRatio "temperature ratio"
 pure (multiply (multiply (multiply r r) r) r)
def acousticLadder (fundamental : Rat) (modeCount : CountInput) : Except String (List Rat) := do
 let base ← requirePositive fundamental "fundamental"
 let count ← positiveCount modeCount "mode count must be a positive generated whole"
 pure ((List.range count).map (fun n => multiply (wholeRatio (n+1)) base))
structure LaserLedger where
 inversion : Rat
 populationInverted : Bool
 atThreshold : Bool
 aboveThreshold : Bool
 linewidth : Rat
 linewidthTimeProduct : Rat
def laserLedger (excited lower : CountInput) (gain loss : Rat) (coherenceTicks : CountInput) : Except String LaserLedger := do
 let excited ← positiveCount excited "laser counts must be positive generated wholes"
 let lower ← positiveCount lower "laser counts must be positive generated wholes"
 let ticks ← positiveCount coherenceTicks "laser counts must be positive generated wholes"
 let gain ← requirePositive gain "gain"
 let loss ← requirePositive loss "loss"
 let inversion ← LeptonRatios.divide (wholeRatio excited) (wholeRatio (excited+lower))
 let width ← LeptonRatios.divide (wholeRatio 1) (wholeRatio ticks)
 let inverted := (natRatio 1 2 (by decide)).blt inversion
 pure ⟨inversion,inverted,VelocityComposition.ratEqual gain loss,loss.blt gain && inverted,width,multiply width (wholeRatio ticks)⟩
structure PlasmaCarriers where
 frequencySquared : Rat
 debyeLengthSquared : Rat
def plasmaSquaredCarriers (chargeCount charge mass permittivity temperature : Rat) : Except String PlasmaCarriers := do
 let n ← requirePositive chargeCount "charge count"
 let q ← requirePositive charge "charge"
 let m ← requirePositive mass "mass"
 let e ← requirePositive permittivity "permittivity"
 let t ← requirePositive temperature "temperature"
 let stiffness := multiply (multiply n q) q
 let frequency ← LeptonRatios.divide stiffness (multiply m e)
 let length ← LeptonRatios.divide (multiply e t) stiffness
 pure ⟨frequency,length⟩
def alfvenSquaredCarrier (field permeability density : Rat) : Except String Rat := do
 let b ← requirePositive field "field"
 let mu ← requirePositive permeability "permeability"
 let rho ← requirePositive density "density"
 LeptonRatios.divide (multiply b b) (multiply mu rho)
end SFT.Physics.CollectiveRadiation
