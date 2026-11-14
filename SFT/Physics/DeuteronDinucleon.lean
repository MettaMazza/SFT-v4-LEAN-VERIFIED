import SFT.Physics.NucleonBinding
import SFT.Physics.NuclearResidualForce
import SFT.Physics.MatterExchangeSpin
import SFT.Foundation.HalfOneDerivation
namespace SFT.Physics.DeuteronDinucleon
open SFT.Host LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
local instance : BEq String := ⟨Text.equal⟩
def preserving := "exchange-preserving"
def alternating := "exchange-alternating"
def pairClasses : List String := ["proton-neutron","proton-proton","neutron-neutron"]
structure SpinClass where
 name : String
 exchangeHand : String
 heldWordSupport : List (String × String)
def spinClasses : Except String (List SpinClass) := do
 let first := "first-fibre"
 let second := "second-fibre"
 let classes : List SpinClass := [⟨"first-first",preserving,[(first,first)]⟩,⟨"preserving-mixed",preserving,[(first,second),(second,first)]⟩,⟨"second-second",preserving,[(second,second)]⟩,⟨"alternating-mixed",alternating,[(first,second),(second,first)]⟩]
 if classes.length != 4 || (classes.map SpinClass.name).eraseDups.length != 4 then throw "two-label spin exchange census is incomplete"
 pure classes
def exchangePartition : Except String (List String × List String) := do
 let classes ← spinClasses
 let p := (classes.filter (fun c => Text.equal c.exchangeHand preserving)).map SpinClass.name
 let a := (classes.filter (fun c => Text.equal c.exchangeHand alternating)).map SpinClass.name
 if p.length+a.length != classes.length then throw "exchange classes do not exhaust two-label support"
 pure (p,a)
def spinSupport (hand : String) : Except String Rat := do
 let partition ← exchangePartition
 let held ← if Text.equal hand preserving then pure partition.1 else if Text.equal hand alternating then pure partition.2 else throw "spin support names an ungenerated exchange hand"
 LeptonRatios.divide (wholeRatio held.length) (wholeRatio (← spinClasses).length)
def composeExchangeHands (hands : List String) : Except String String :=
 hands.foldlM (fun result hand => do
  if !(Text.equal hand preserving || Text.equal hand alternating) then throw "exchange composition names an ungenerated hand"
  pure (if Text.equal result hand then preserving else alternating)) preserving
def chargeExchangeHand (pair : String) : Except String String :=
 if Text.equal pair "proton-neutron" then .ok alternating
 else if Text.equal pair "proton-proton" || Text.equal pair "neutron-neutron" then .ok preserving
 else .error "charge exchange names an ungenerated pair"
def groundSpinHand (pair : String) : Except String String := do
 let charge ← chargeExchangeHand pair
 let tested ← [preserving,alternating].mapM (fun spin => do pure (spin,← composeExchangeHands [preserving,charge,spin]))
 let admissible := (tested.filter (fun p => Text.equal p.2 alternating)).map Prod.fst
 match admissible with
 | [spin] => .ok spin
 | [] | _::_::_ => .error "ground exchange ledger lacks a unique fermionic spin hand"
def retainedAfterResidual (hand : String) : Except String (Option Rat) := do
 let support ← spinSupport hand
 let boundary ← NuclearResidualForce.residualBoundarySupport
 if boundary.blt support then pure (some (← RunningConvergence.positiveTake support boundary))
 else if support==boundary then pure none
 else throw "generated spin support fell below the admitted residual boundary"
def pairChargePath (pair : String) : Except String (Option Rat) := do
 let charged ← NucleonBinding.baryonChargeClass (.count (.integer 2)) (.count (.integer 1))
 let neutral ← NucleonBinding.baryonChargeClass (.count (.integer 1)) (.count (.integer 2))
 if charged != some ("positive-charge-hand",wholeRatio 1) || neutral.isSome then throw "admitted nucleon charge words changed"
 if Text.equal pair "proton-proton" then pure (some (wholeRatio 1))
 else if Text.equal pair "proton-neutron" || Text.equal pair "neutron-neutron" then pure none
 else throw "charge path names an ungenerated pair"
structure PairChannel where
 pairClass : String
 spatialHand : String
 chargeHand : String
 spinHand : String
 totalExchangeHand : String
 spinSupport : Rat
 retainedBindingSupport : Option Rat
 chargePath : Option Rat
def PairChannel.binds (row : PairChannel) : Bool := row.retainedBindingSupport.isSome
def pairChannels : Except String (List PairChannel) := do
 let rows ← pairClasses.mapM (fun pair => do
  let charge ← chargeExchangeHand pair
  let spin ← groundSpinHand pair
  pure (⟨pair,preserving,charge,spin,← composeExchangeHands [preserving,charge,spin],← spinSupport spin,← retainedAfterResidual spin,← pairChargePath pair⟩ : PairChannel))
 if rows.any (fun row => !Text.equal row.totalExchangeHand alternating) then throw "two-nucleon ground ledger violates fermionic exchange"
 pure rows
def channelByPair (pair : String) : Except String PairChannel := do
 let found :=  (← pairChannels).filter (fun row => Text.equal row.pairClass pair)
 match found with
 | [row] => .ok row
 | [] | _::_::_ => .error "two-nucleon pair is absent or duplicated"
structure SpinCertificate where
 constituentSpin : Rat
 preservingCompositeSpin : Rat
 preservingReadingCount : Nat
 alternatingReadingCount : Nat
 preservingSupport : Rat
 alternatingSupport : Rat
 residualBoundary : Rat
 preservingRemainder : Option Rat
 alternatingRemainder : Option Rat
def compositeSpinCertificate : Except String SpinCertificate := do
 let h := SFT.Foundation.HalfOneDerivation.halfOne
 let half := normalize (.ofNat h.numerator) h.denominator (SFT.Foundation.ExactPartCarrier.denominatorPositive h)
 let partition ← exchangePartition
 pure ⟨half,add half half,partition.1.length,partition.2.length,← spinSupport preserving,← spinSupport alternating,← NuclearResidualForce.residualBoundarySupport,← retainedAfterResidual preserving,← retainedAfterResidual alternating⟩
def bindingOutcomes : Except String (List (String × Bool)) := do
 pure ((← pairChannels).map (fun row => (row.pairClass,row.binds)))
def exchangePartitionIsForced (value : String) : Except String Bool := do
 let p ← exchangePartition
 let expected ← if Text.equal value "three-preserving-one-alternating" then pure (3,1) else if Text.equal value "two-preserving-two-alternating" then pure (2,2) else if Text.equal value "one-preserving-three-alternating" then pure (1,3) else throw "candidate names an ungenerated exchange partition"
 pure ((p.1.length,p.2.length)==expected)
def groundExchangeLedgerIsForced (value : String) : Except String Bool := do
 let observed ← pairClasses.mapM groundSpinHand
 let expected ← if Text.equal value "pn-preserving-spin-ppnn-alternating-spin" then pure [preserving,alternating,alternating] else if Text.equal value "pn-alternating-spin-ppnn-preserving-spin" then pure [alternating,preserving,preserving] else if Text.equal value "all-pairs-preserving-spin" then pure [preserving,preserving,preserving] else throw "candidate names an ungenerated ground exchange ledger"
 pure (observed==expected)
def residualDiscriminatorIsForced (value : String) : Except String Bool := do
 let p ← retainedAfterResidual preserving
 let a ← retainedAfterResidual alternating
 if Text.equal value "preserving-leaves-half-alternating-empty" then pure (p==some (normalize 1 2 (by decide)) && a.isNone)
 else if Text.equal value "quarter-act-binds-both-spin-hands" then pure (p.isSome && a.isSome)
 else if Text.equal value "neither-spin-hand-retains-support" then pure (p.isNone && a.isNone)
 else throw "candidate names an ungenerated residual discriminator"
def bindingTableIsForced (value : String) : Except String Bool := do
 let observed := (← bindingOutcomes).map Prod.snd
 let expected ← if Text.equal value "pn-only-bound" then pure [true,false,false] else if Text.equal value "all-pairs-bound" then pure [true,true,true] else if Text.equal value "no-pair-bound" then pure [false,false,false] else if Text.equal value "identical-pairs-only-bound" then pure [false,true,true] else throw "candidate names an ungenerated binding table"
 pure (observed==expected)
def compositeSpinIsForced (value : String) : Except String Bool := do
 let certificate ← compositeSpinCertificate
 if Text.equal value "complete-One-with-three-readings" then pure (certificate.preservingCompositeSpin==wholeRatio 1 && certificate.preservingReadingCount==3 && Text.equal (← channelByPair "proton-neutron").spinHand preserving)
 else if Text.equal value "empty-spin-with-one-reading" then pure (Text.equal (← channelByPair "proton-neutron").spinHand alternating)
 else if Text.equal value "spin-unresolved" then pure false
 else throw "candidate names an ungenerated composite spin"
def chargedPairRoleIsForced (value : String) : Except String Bool := do
 let p ← channelByPair "proton-proton"
 let n ← channelByPair "neutron-neutron"
 if Text.equal value "pp-positive-opposition-secondary-to-singlet-exclusion" then pure (p.chargePath==some (wholeRatio 1) && n.chargePath.isNone && !p.binds && !n.binds && Text.equal p.spinHand n.spinHand && Text.equal n.spinHand alternating)
 else if Text.equal value "charged-path-selects-both-identical-outcomes" then pure (p.chargePath==n.chargePath)
 else throw "candidate names an ungenerated charged-pair role"
def targetBoundaryIsForced (value : String) : Except String Bool :=
 if Text.equal value "sealed-before-release" then .ok true else if Text.equal value "readable-before-seal" then .ok false else .error "candidate names an ungenerated target boundary"
def extensionIsForced (value : String) : Except String Bool :=
 if Text.equal value "empty-extension" then .ok true else if Text.equal value "free-correction" then .ok false else .error "candidate names an ungenerated extension"
end SFT.Physics.DeuteronDinucleon
