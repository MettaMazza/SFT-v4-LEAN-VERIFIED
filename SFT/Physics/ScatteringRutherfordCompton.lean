import SFT.Physics.DeuteronDinucleon
namespace SFT.Physics.ScatteringRutherfordCompton
open LeptonIntervals VacuumLedgerProofs
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- Original scattering_rutherford_compton_terminal_law_v1.py, exact Fraction carriers.
def positiveTransferPart (n d : Int) : Except String Rat :=
 if h : 0 < d then
  if n < 1 || d < n then .error "direction transfer must be a positive part of the One"
  else .ok (normalize n d.toNat (by
    cases d with
    | ofNat k =>
      cases k with
      | zero => cases h
      | succ k => exact Nat.zero_lt_succ k
    | negSucc k => cases h))
 else .error "direction transfer must be a positive part of the One"
def forwardTransfer : List Rat := []
def overlapLeg (u : Rat) : Except String Rat :=
 if u.num < 1 || (wholeRatio 1).blt u then .error "overlap leg requires one exact positive nonforward part"
 else LeptonRatios.divide (wholeRatio 1) u
def directionComplement (u : Rat) : Except String (Option Rat) := do
 if u.num < 1 || (wholeRatio 1).blt u then throw "direction complement requires a positive part of the One"
 if u == wholeRatio 1 then pure none
 else pure (some (← RunningConvergence.positiveTake (wholeRatio 1) u))
def cumulativeImpactArea (u : Rat) : Except String (Option Rat) := do
 match ← directionComplement u with
 | none => pure none
 | some c => pure (some (← LeptonRatios.divide c u))
def annularTransferDensity (a b : Rat) : Except String Rat := do
 if a.num < 1 || !a.blt b || (wholeRatio 1).blt b then throw "annular transfer interval is not an ordered positive part"
 let lower ← cumulativeImpactArea a
 let upper ← cumulativeImpactArea b
 match lower with
 | none => throw "lower impact area cannot be structurally empty"
 | some l =>
  let removed ← match upper with | none => pure l | some h => RunningConvergence.positiveTake l h
  let interval ← RunningConvergence.positiveTake b a
  LeptonRatios.divide removed interval
def pairedOverlapDensity (u : Rat) : Except String Rat := do
 let leg ← overlapLeg u
 pure (multiply leg leg)
def coulombBackscatterScale (q e : Rat) : Except String Rat := do
 if q.num < 1 || e.num < 1 then throw "Coulomb scale carriers must remain exact and positive"
 let approach ← LeptonRatios.divide q (multiply (wholeRatio 4) e)
 pure (multiply approach approach)
def coulombDifferentialSupport (q e u : Rat) : Except String Rat := do
 pure (multiply (← coulombBackscatterScale q e) (← pairedOverlapDensity u))
def photonShiftInComptonCarriers (u : Rat) : Except String Rat :=
 if u.num < 1 || (wholeRatio 1).blt u then .error "photon shift requires a positive nonforward transfer part"
 else .ok (multiply (wholeRatio 2) u)
def scatteredPhotonEnergyRatio (x u : Rat) : Except String Rat :=
 if x.num < 1 || u.num < 1 || (wholeRatio 1).blt u then .error "Compton carriers must remain exact and positive"
 else LeptonRatios.divide (wholeRatio 1) (add (wholeRatio 1) (multiply (multiply (wholeRatio 2) x) u))
def comptonConservationTransfer (x r : Rat) : Except String Rat := do
 if x.num < 1 || r.num < 1 || !r.blt (wholeRatio 1) then throw "Compton conservation requires positive energy loss"
 let outgoing := multiply x r
 RunningConvergence.positiveTake (← LeptonRatios.divide (wholeRatio 1) outgoing) (← LeptonRatios.divide (wholeRatio 1) x)
def scatteredPhotonInRestUnits (x u : Rat) : Except String Rat := do
 pure (multiply x (← scatteredPhotonEnergyRatio x u))
def highEnergyCeilingInRestUnits (u : Rat) : Except String Rat :=
 if u.num < 1 || (wholeRatio 1).blt u then .error "ceiling requires a positive nonforward transfer part"
 else LeptonRatios.divide (wholeRatio 1) (multiply (wholeRatio 2) u)
def highEnergyGap (n : Int) (u : Rat) : Except String Rat := do
 if n < 1 then throw "generated incident-energy depth must be positive"
 pure (subtract (← highEnergyCeilingInRestUnits u) (← scatteredPhotonInRestUnits (normalize n 1 (by decide)) u))
def highEnergyStep (n : Int) (u : Rat) : Except String Rat := do
 if n < 1 then throw "generated incident-energy depth must be positive"
 let present ← scatteredPhotonInRestUnits (normalize n 1 (by decide)) u
 let successor ← scatteredPhotonInRestUnits (normalize (n+1) 1 (by decide)) u
 pure (subtract successor present)
def transferParts : List Rat := [normalize 1 4 (by decide),normalize 1 2 (by decide),normalize 3 4 (by decide),wholeRatio 1]
structure Certificate where
 forwardTransfer : List Rat
 transferParts : List Rat
 angularDensity : List (Rat × Rat)
 cumulativeArea : List (Rat × Option Rat)
 annularDensity : List (Rat × Rat × Rat)
 annularIdentity : List Bool
 chargeDoublingRatio : Rat
 energyDoublingRatio : Rat
 photonShifts : List (Rat × Rat)
 photonEnergy : List (Rat × Rat)
 conservationTransfer : List (Rat × Rat)
 rightAngleCeiling : Rat
 backscatterCeiling : Rat
 successorSteps : List Rat
 ceilingGaps : List Rat
def formalCertificate : Except String Certificate := do
 let angular ← transferParts.mapM (fun p => do pure (p,← pairedOverlapDensity p))
 let shifts ← transferParts.mapM (fun p => do pure (p,← photonShiftInComptonCarriers p))
 let energy ← transferParts.mapM (fun p => do pure (p,← scatteredPhotonEnergyRatio (wholeRatio 1) p))
 let intervals := transferParts.zip (transferParts.drop 1)
 pure ⟨forwardTransfer,transferParts,angular,
  ← transferParts.mapM (fun p => do pure (p,← cumulativeImpactArea p)),
  ← intervals.mapM (fun (a,b) => do pure (a,b,← annularTransferDensity a b)),
  ← intervals.mapM (fun (a,b) => do pure ((← annularTransferDensity a b)==(← LeptonRatios.divide (wholeRatio 1) (multiply a b)))),
  ← LeptonRatios.divide (← coulombBackscatterScale (wholeRatio 2) (wholeRatio 1)) (← coulombBackscatterScale (wholeRatio 1) (wholeRatio 1)),
  ← LeptonRatios.divide (← coulombBackscatterScale (wholeRatio 1) (wholeRatio 2)) (← coulombBackscatterScale (wholeRatio 1) (wholeRatio 1)),
  shifts,energy,
  ← transferParts.mapM (fun p => do pure (p,← comptonConservationTransfer (wholeRatio 1) (← scatteredPhotonEnergyRatio (wholeRatio 1) p))),
  ← highEnergyCeilingInRestUnits (normalize 1 2 (by decide)),
  ← highEnergyCeilingInRestUnits (wholeRatio 1),
  (← transferParts.mapM (fun p => [1,2,3,4].mapM (fun n => highEnergyStep n p))).flatten,
  (← transferParts.mapM (fun p => [1,2,3,4].mapM (fun n => highEnergyGap n p))).flatten⟩
def amplitudeCarrierIsForced (v : String) : Except String Bool := do
 let c ← formalCertificate
 let paired := (← c.angularDensity.mapM (fun (p,d) => do let leg ← overlapLeg p; pure (d==multiply leg leg))).all id && c.annularIdentity.all id
 let single := (← c.angularDensity.mapM (fun (p,d) => do pure (d==(← overlapLeg p)))).all id
 if SFT.Host.Text.equal v "paired-phase-compatible-overlap-legs" then pure paired
 else if SFT.Host.Text.equal v "single-unpaired-channel-count" then pure single
 else if SFT.Host.Text.equal v "imported-complex-amplitude" then pure false
 else throw "candidate names an ungenerated amplitude carrier"
def crossSectionMeasureIsForced (v : String) : Except String Bool := do
 let observed ← LeptonRatios.divide (wholeRatio 3) (multiply (wholeRatio 5) (wholeRatio 2))
 if SFT.Host.Text.equal v "paired-weight-per-incident-boundary-support" then pure (observed==normalize 3 10 (by decide))
 else if SFT.Host.Text.equal v "unnormalized-outgoing-count" then pure (observed==wholeRatio 3)
 else if SFT.Host.Text.equal v "target-fitted-area" then pure false
 else throw "candidate names an ungenerated cross-section measure"
def coulombAngularLawIsForced (v : String) : Except String Bool := do
 let observed := (← formalCertificate).angularDensity.map Prod.snd
 let expected ← if SFT.Host.Text.equal v "inverse-transfer-part-squared" then pure [wholeRatio 16,wholeRatio 4,normalize 16 9 (by decide),wholeRatio 1]
  else if SFT.Host.Text.equal v "inverse-transfer-part-first-power" then pure [wholeRatio 4,wholeRatio 2,normalize 4 3 (by decide),wholeRatio 1]
  else if SFT.Host.Text.equal v "angle-independent-response" then pure (List.replicate 4 (wholeRatio 1))
  else throw "candidate names an ungenerated Coulomb angular law"
 pure (observed==expected)
def coulombScaleLawIsForced (v : String) : Except String Bool := do
 let c ← formalCertificate
 if SFT.Host.Text.equal v "charge-product-squared-energy-inverse-squared" then pure (c.chargeDoublingRatio==wholeRatio 4 && c.energyDoublingRatio==normalize 1 4 (by decide))
 else if SFT.Host.Text.equal v "charge-product-linear-energy-inverse" then pure (c.chargeDoublingRatio==wholeRatio 2 && c.energyDoublingRatio==normalize 1 2 (by decide))
 else if SFT.Host.Text.equal v "free-dimensional-scale" then pure false
 else throw "candidate names an ungenerated Coulomb scale law"
def photonShiftLawIsForced (v : String) : Except String Bool := do
 let c ← formalCertificate
 let observed := c.photonShifts.map Prod.snd
 let conservation := c.conservationTransfer.map Prod.snd
 let expected ← if SFT.Host.Text.equal v "two-transfer-parts-times-action-over-inertia-speed" then pure [normalize 1 2 (by decide),wholeRatio 1,normalize 3 2 (by decide),wholeRatio 2]
  else if SFT.Host.Text.equal v "one-transfer-part-times-action-over-inertia-speed" then pure transferParts
  else if SFT.Host.Text.equal v "angle-independent-wavelength-change" then pure (List.replicate 4 (wholeRatio 1))
  else throw "candidate names an ungenerated photon shift law"
 pure (observed==expected && (!SFT.Host.Text.equal v "two-transfer-parts-times-action-over-inertia-speed" || conservation==observed))
def photonEnergyLawIsForced (v : String) : Except String Bool := do
 let c ← formalCertificate
 let observed := c.photonEnergy.map Prod.snd
 if SFT.Host.Text.equal v "rest-over-rest-plus-two-energy-transfer-parts" then pure (observed==[normalize 2 3 (by decide),normalize 1 2 (by decide),normalize 2 5 (by decide),normalize 1 3 (by decide)] && c.rightAngleCeiling==wholeRatio 1 && c.backscatterCeiling==normalize 1 2 (by decide) && c.successorSteps.all (fun s => decide (1 ≤ s.num)) && c.ceilingGaps.all (fun s => decide (1 ≤ s.num)))
 else if SFT.Host.Text.equal v "incident-energy-preserved" then pure (observed==List.replicate 4 (wholeRatio 1))
 else if SFT.Host.Text.equal v "outgoing-energy-greater-than-incident" then pure (observed.all (fun r => (wholeRatio 1).blt r))
 else throw "candidate names an ungenerated photon energy law"
def targetBoundaryIsForced (v : String) : Except String Bool :=
 if SFT.Host.Text.equal v "sealed-before-release" then .ok true else if SFT.Host.Text.equal v "readable-before-seal" then .ok false else .error "candidate names an ungenerated target boundary"
def extensionIsForced (v : String) : Except String Bool :=
 if SFT.Host.Text.equal v "empty-extension" then .ok true else if SFT.Host.Text.equal v "free-correction" then .ok false else .error "candidate names an ungenerated extension"
end SFT.Physics.ScatteringRutherfordCompton
