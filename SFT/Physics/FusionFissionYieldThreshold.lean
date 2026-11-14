import SFT.Physics.FusionFissionTerminalProofs
namespace SFT.Physics.FusionFissionYieldThreshold
open FusionFissionTerminal LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def perNucleonGainEnclosure (operation : String) : Except String (Rat × Rat) := do
 let (incident,product) ←
  if SFT.Host.Text.equal operation "fusion" then do
   pure (← NuclearBindingRadius.bindingScoreEnclosure (.integer 2) (.integer 1) (.integer 16),← NuclearBindingRadius.bindingScoreEnclosure (.integer 4) (.integer 2) (.integer 16))
  else if SFT.Host.Text.equal operation "fission" then do
   pure (← NuclearBindingRadius.bindingScoreEnclosure (.integer 238) (.integer 92) (.integer 16),← NuclearBindingRadius.bindingScoreEnclosure (.integer 119) (.integer 46) (.integer 16))
  else throw "yield comparison names an ungenerated reaction class"
 if !incident.2.blt product.1 then throw "registered reaction lacks a separated positive binding gain"
 pure (← RunningConvergence.positiveTake product.1 incident.2,← RunningConvergence.positiveTake product.2 incident.1)
def totalReleaseEnclosure (operation : String) : Except String (Rat × Rat) := do
 let gain ← perNucleonGainEnclosure operation
 let mass ← if SFT.Host.Text.equal operation "fusion" then do
   if !(← reactionConservesCounts (← fusionTrace "binary-junction")) then throw "fusion representative lost a conserved count"
   pure 4
  else if SFT.Host.Text.equal operation "fission" then do
   if !(← reactionConservesCounts (← fissionTrace "binary-decomposition")) then throw "fission representative lost a conserved count"
   pure 238
  else throw "release comparison names an ungenerated reaction class"
 pure (multiply (wholeRatio mass) gain.1,multiply (wholeRatio mass) gain.2)
structure ReleaseOrder where
 fusionPerNucleon : Rat × Rat
 fissionPerNucleon : Rat × Rat
 fusionTotal : Rat × Rat
 fissionTotal : Rat × Rat
 fusionGreaterPerNucleon : Bool
 fissionGreaterTotal : Bool
 ordersAreDistinct : Bool
def exactReleaseOrder : Except String ReleaseOrder := do
 let fp ← perNucleonGainEnclosure "fusion"
 let sp ← perNucleonGainEnclosure "fission"
 let ft ← totalReleaseEnclosure "fusion"
 let st ← totalReleaseEnclosure "fission"
 pure ⟨fp,sp,ft,st,sp.2.blt fp.1,ft.2.blt st.1,sp.2.blt fp.1 && ft.2.blt st.1⟩
def interBoundaryChargePaths (words : List Coordinate) : Except String (Option Nat) :=
 match words with
 | [_] => .ok none
 | [left,right] => if left.chargeCount*right.chargeCount<1 then .error "charged inter-boundary path count must remain positive" else .ok (some (left.chargeCount*right.chargeCount))
 | [] => .error "threshold grammar contains only one- or two-word incident support"
 | _::_::_::_ => .error "threshold grammar contains only one- or two-word incident support"
structure ThresholdTrace where
 incidentWords : List Coordinate
 interBoundaryChargePaths : Option Nat
 neutralTriggerCharge : Option Nat
 internalBoundaryCells : Nat
def fusionThresholdTrace : Except String ThresholdTrace := do
 let trace ← fusionTrace "binary-junction"
 let paths ← interBoundaryChargePaths trace.incident
 if paths.isNone then throw "fusion junction lost its charged incident boundary"
 pure ⟨trace.incident,paths,none,← NuclearResidualForce.finiteBoundaryCapacity⟩
def fissionThresholdTrace : Except String ThresholdTrace := do
 let trace ← fissionTrace "binary-decomposition"
 let paths ← interBoundaryChargePaths trace.incident
 if paths.isSome then throw "one-parent fission acquired an inter-composite charge path"
 pure ⟨trace.incident,paths,none,← NuclearResidualForce.finiteBoundaryCapacity⟩
structure Topology where
 fusionHasTwoChargedIncidentWords : Bool
 fusionInterBoundaryPaths : Option Nat
 fissionHasOneParentWord : Bool
 fissionInterBoundaryPaths : Option Nat
 neutralTriggerChargeIsEmptyForm : Bool
 internalSurfaceIsFinite : Bool
 residualInteractionIsShortRangeOrder : Bool
 carriersAreDistinct : Bool
def thresholdTopology : Except String Topology := do
 let f ← fusionThresholdTrace
 let s ← fissionThresholdTrace
 let capacity ← NuclearResidualForce.finiteBoundaryCapacity
 let residual ← NuclearResidualForce.residualBoundarySupport
 pure ⟨f.incidentWords.length==2 && f.incidentWords.all (fun w => w.chargeCount≥1),f.interBoundaryChargePaths,s.incidentWords.length==1,s.interBoundaryChargePaths,s.neutralTriggerCharge.isNone,s.internalBoundaryCells==capacity,residual==normalize 1 4 (by decide),f.interBoundaryChargePaths.isSome && s.interBoundaryChargePaths.isNone⟩
def perNucleonRelationIsForced (relation : String) : Except String Bool := do
 let o ← exactReleaseOrder
 if SFT.Host.Text.equal relation "fusion-greater-per-nucleon" then pure o.fusionGreaterPerNucleon
 else if SFT.Host.Text.equal relation "equal-per-nucleon" then pure (o.fusionPerNucleon==o.fissionPerNucleon)
 else if SFT.Host.Text.equal relation "fission-greater-per-nucleon" then pure (o.fusionPerNucleon.2.blt o.fissionPerNucleon.1)
 else throw "candidate names an ungenerated per-nucleon relation"
def totalReleaseRelationIsForced (relation : String) : Except String Bool := do
 let o ← exactReleaseOrder
 if SFT.Host.Text.equal relation "fusion-greater-total" then pure (o.fissionTotal.2.blt o.fusionTotal.1)
 else if SFT.Host.Text.equal relation "equal-total" then pure (o.fusionTotal==o.fissionTotal)
 else if SFT.Host.Text.equal relation "fission-greater-total" then pure o.fissionGreaterTotal
 else throw "candidate names an ungenerated total-release relation"
def fusionThresholdCarrierIsForced (carrier : String) : Except String Bool := do
 let t ← thresholdTopology
 if SFT.Host.Text.equal carrier "charged-boundary-approach" then pure (t.fusionHasTwoChargedIncidentWords && t.fusionInterBoundaryPaths.isSome)
 else if SFT.Host.Text.equal carrier "neutral-capture-approach" then pure t.fusionInterBoundaryPaths.isNone
 else if SFT.Host.Text.equal carrier "single-parent-internal-surface" then pure ((← fusionThresholdTrace).incidentWords.length==1)
 else throw "candidate names an ungenerated fusion-threshold carrier"
def fissionThresholdCarrierIsForced (carrier : String) : Except String Bool := do
 let t ← thresholdTopology
 if SFT.Host.Text.equal carrier "charged-boundary-approach" then pure t.fissionInterBoundaryPaths.isSome
 else if SFT.Host.Text.equal carrier "neutral-capture-or-internal-surface" then pure (t.fissionHasOneParentWord && t.fissionInterBoundaryPaths.isNone && t.neutralTriggerChargeIsEmptyForm && t.internalSurfaceIsFinite)
 else if SFT.Host.Text.equal carrier "carrier-free-decomposition" then pure (!t.internalSurfaceIsFinite)
 else throw "candidate names an ungenerated fission-threshold carrier"
def thresholdScopeIsForced (scope : String) : Except String Bool := do
 let distinct := (← thresholdTopology).carriersAreDistinct
 let normalized := (← NuclearResidualForce.residualBoundarySupport)==normalize 1 4 (by decide)
 if SFT.Host.Text.equal scope "one-universal-dimensional-threshold" then pure (!distinct)
 else if SFT.Host.Text.equal scope "normalized-structure-with-reaction-specific-dimensions" then pure (distinct && normalized)
 else if SFT.Host.Text.equal scope "no-threshold-distinction" then pure (!distinct && !normalized)
 else throw "candidate names an ungenerated threshold scope"
def accessCarrierIsForced (carrier : String) : Except String Bool := do
 let charged := (← fusionThresholdTrace).interBoundaryChargePaths.isSome
 let specific := (← thresholdTopology).carriersAreDistinct
 if SFT.Host.Text.equal carrier "thermal-or-directed-energy-support" then pure (charged && specific)
 else if SFT.Host.Text.equal carrier "one-universal-temperature-value" then pure (!specific)
 else if SFT.Host.Text.equal carrier "no-access-support" then pure (!charged)
 else throw "candidate names an ungenerated access carrier"
def metricRetentionIsForced (retention : String) : Except String Bool := do
 let distinct := (← exactReleaseOrder).ordersAreDistinct
 if SFT.Host.Text.equal retention "retain-per-nucleon-and-total-separately" then pure distinct
 else if SFT.Host.Text.equal retention "conflate-per-nucleon-with-total" then pure (!distinct)
 else throw "candidate names an ungenerated metric-retention state"
def targetBoundaryIsForced (boundary : String) : Except String Bool :=
 if SFT.Host.Text.equal boundary "sealed-before-release" then .ok true
 else if SFT.Host.Text.equal boundary "readable-before-seal" then .ok false
 else .error "candidate names an ungenerated target boundary"
def extensionIsForced (extension : String) : Except String Bool :=
 if SFT.Host.Text.equal extension "empty-extension" then .ok true
 else if SFT.Host.Text.equal extension "free-correction" then .ok false
 else .error "candidate names an ungenerated extension state"
end SFT.Physics.FusionFissionYieldThreshold
