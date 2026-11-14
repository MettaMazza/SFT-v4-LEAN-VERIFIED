import SFT.Physics.NucleonBinding
namespace SFT.Physics.NucleonBindingRoots
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Interval := Rat × Rat
def precision : Rat := normalize 1 (10^12) (by decide)
def needsRefinement (brackets : List Interval) : Bool :=
 match brackets with
 | [] => false
 | row :: _ => precision.blt (subtract row.2 row.1)
def refine (pairSum product : Rat) (brackets : List Interval) :=
 brackets.map (fun row => QuarkIsolation.bisectBracket row pairSum product)

inductive SourceRun (pairSum product : Rat) : List Interval → List Interval → Prop where
 | stop (b : List Interval) (h : needsRefinement b = false) : SourceRun pairSum product b b
 | next (b result : List Interval) (h : needsRefinement b = true)
   (later : SourceRun pairSum product (refine pairSum product b) result) : SourceRun pairSum product b result

/-- Proof evaluation budget; successful results are certified against the original uncapped loop. -/
def refineWithin (pairSum product : Rat) : Nat → List Interval → Option (List Interval)
 | 0,_ => none
 | fuel+1,b => if needsRefinement b then refineWithin pairSum product fuel (refine pairSum product b) else some b

theorem refinementCorrespondence (pairSum product : Rat) (fuel : Nat) (b result : List Interval)
 (h : refineWithin pairSum product fuel b = some result) : SourceRun pairSum product b result := by
 induction fuel generalizing b with
 | zero => cases h
 | succ fuel ih =>
   unfold refineWithin at h
   cases hc : needsRefinement b with
   | false =>
     rw [hc] at h
     have he := Option.some.inj h
     cases he
     exact .stop result hc
   | true =>
     rw [hc] at h
     exact .next b result hc (ih _ h)


theorem exactDown : refineWithin QuarkComparison.downPair QuarkComparison.downProduct 35 QuarkComparison.initialDown = some QuarkComparison.refinedDown := rfl
theorem exactUp : refineWithin QuarkComparison.upPair QuarkComparison.upProduct 33 QuarkComparison.initialUp = some QuarkComparison.refinedUp := rfl
theorem sourceDown : SourceRun QuarkComparison.downPair QuarkComparison.downProduct QuarkComparison.initialDown QuarkComparison.refinedDown := refinementCorrespondence _ _ _ _ _ exactDown
theorem sourceUp : SourceRun QuarkComparison.upPair QuarkComparison.upProduct QuarkComparison.initialUp QuarkComparison.refinedUp := refinementCorrespondence _ _ _ _ _ exactUp
-- The original loop tests only the first bracket and updates every bracket.
def refinedLightQuarkRoots : Except String (Interval × Interval) := do
 let cubics ← QuarkInvariants.cubicInvariants
 let (down,up) ← QuarkIsolation.rootBrackets
 let ds ← match refineWithin (BoundaryGrowth.asFraction cubics.down.2.1) (BoundaryGrowth.asFraction cubics.down.2.2) 35 down with
  | none => .error "unreachable: certified nucleon down refinement"
  | some rows => .ok rows
 let us ← match refineWithin (BoundaryGrowth.asFraction cubics.up.2.1) (BoundaryGrowth.asFraction cubics.up.2.2) 33 up with
  | none => .error "unreachable: certified nucleon up refinement"
  | some rows => .ok rows
 let d ← LeptonRatios.atIndex ds 0
 let u ← LeptonRatios.atIndex us 0
 pure (d,u)
def lightDownUpSurplusInterval : Except String Interval := do
 let (down,up) ← refinedLightQuarkRoots
 let lower ← RunningConvergence.positiveTake down.1 up.2
 let upper ← RunningConvergence.positiveTake down.2 up.1
 if !lower.blt upper then throw "light down/up exact ordering failed"
 pure (lower,upper)
structure OrderCertificate where
 flavourSurplusLower : Rat
 flavourSurplusUpper : Rat
 protonElectromagneticDressing : Rat
 netNeutronSurplusLower : Rat
 netNeutronSurplusUpper : Rat
def neutronProtonOrderCertificate : Except String OrderCertificate := do
 let (lower,upper) ← lightDownUpSurplusInterval
 let electromagnetic ← TerminalProton.dressing
 let netLower ← RunningConvergence.positiveTake lower electromagnetic
 let netUpper ← RunningConvergence.positiveTake upper electromagnetic
 pure ⟨lower,upper,electromagnetic,netLower,netUpper⟩
def originalRoots : Interval × Interval := ((normalize (28872365447) 1099511627776 (by decide),normalize (3609045681) 137438953472 (by decide)),(normalize (4518254149) 1099511627776 (by decide),normalize (2259127075) 549755813888 (by decide)))
theorem completeRoots : refinedLightQuarkRoots=.ok originalRoots := rfl
def originalSurplus : Interval := (normalize (24354111297) 1099511627776 (by decide),normalize (24354111299) 1099511627776 (by decide))
theorem completeSurplus : lightDownUpSurplusInterval=.ok originalSurplus := rfl
def originalCertificate : OrderCertificate := ⟨normalize (24354111297) 1099511627776 (by decide),normalize (24354111299) 1099511627776 (by decide),normalize (24369786106211428981539709842165878) 259011767431927814399149292223642085725 (by decide),normalize (6281206548079656386042933296710013437878680707997) 284786450022217694483738649682455008306714483097600 (by decide),normalize (6281206548597679920906788925508312022325964879447) 284786450022217694483738649682455008306714483097600 (by decide)⟩
theorem completeCertificate : neutronProtonOrderCertificate=.ok originalCertificate := rfl
theorem positiveNetSurplus : (normalize 1 1000 (by decide)).blt originalCertificate.netNeutronSurplusLower=true := rfl
end SFT.Physics.NucleonBindingRoots
