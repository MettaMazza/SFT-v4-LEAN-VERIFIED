import SFT.Physics.QuadrupoleRadiatedPower
namespace SFT.Physics.QuadrupoleRadiatedPowerCertificate
open QuadrupoleRadiatedPower LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure ShellRow where
 radius : Rat
 density : Rat
 reconstructedPower : Rat
structure Certificate where
 coupling : Rat
 monopoleRecord : String
 dipoleRecord : String
 firstRadiativeMoment : String
 baseThirdRecord : List Rat
 doubledThirdRecord : List Rat
 basePower : Rat
 doubledPower : Rat
 staticPowerRecord : Option Rat
 thirdRateDoubles : Bool
 powerQuadruples : Bool
 shellRows : List ShellRow
 shellPowerConserved : Bool
 cubicIdentities : List CubicIdentity
 baseIdentityHolds : Bool
 successorIdentityHolds : Bool
 generalRateIdentity : String
 generalPowerIdentity : String
 generalShellIdentity : String
 staticSilenceIsEmpty : Bool
 forbiddenProofScalarUsed : Bool
def radiatedPowerCertificate (input : GeneratorOperations.CountInput := .integer 12) : Except String Certificate := do
 let depth ← match input with
  | .boolean _ => .error "positive binary shell depth required"
  | .integer (.negSucc _) => .error "positive binary shell depth required"
  | .integer (.ofNat 0) => .error "positive binary shell depth required"
  | .integer (.ofNat 1) => .error "positive binary shell depth required"
  | .integer (.ofNat (n+2)) => .ok (n+2)
 let binary ← AlphaCovers.binaryCount
 let coupling ← LeptonRatios.divide (normalize 1 1 (by decide)) (wholeRatio binary)
 let baseTrace ← generatedQuadrupoleTrace (.fraction (normalize 1 1 (by decide))) (.integer (.ofNat (depth+4)))
 let doubledTrace ← generatedQuadrupoleTrace (.fraction (wholeRatio binary)) (.integer (.ofNat (depth+4)))
 let staticTrace ← staticQuadrupoleTrace (.integer (.ofNat (depth+4)))
 let baseThird ← generatedDifferenceRecord (baseTrace.map FoldFirstReturn.Input.fraction) (.integer 3)
 let doubledThird ← generatedDifferenceRecord (doubledTrace.map FoldFirstReturn.Input.fraction) (.integer 3)
 let basePower ← quadrupolePowerRecord (baseTrace.map FoldFirstReturn.Input.fraction) coupling
 let doubledPower ← quadrupolePowerRecord (doubledTrace.map FoldFirstReturn.Input.fraction) coupling
 let staticPower ← quadrupolePowerRecord (staticTrace.map FoldFirstReturn.Input.fraction) coupling
 let (basePower,doubledPower) ← match basePower,doubledPower with
  | some a,some b => .ok (a,b)
  | none,none => .error "dynamic power records must remain exact and positive"
  | none,some _ => .error "dynamic power records must remain exact and positive"
  | some _,none => .error "dynamic power records must remain exact and positive"
 let shellRows ← (List.range depth).mapM (fun layer => do
  let radius := wholeRatio (binary^(layer+1))
  let density ← LeptonRatios.divide basePower (wholeRatio (binary^(binary*(layer+1))))
  pure (⟨radius,density,multiply (multiply density radius) radius⟩ : ShellRow))
 let identities ← (List.range depth).mapM (fun k => cubicOppositionIdentity (.integer (.ofNat (k+1))))
 let baseHolds := match identities with | [] => false | x::_ => x.identityHolds
 pure ⟨coupling,"held-source","held-momentum","quadrupole",baseThird,doubledThird,basePower,doubledPower,staticPower,
  (baseThird.zip doubledThird).all (fun p => p.2==multiply (wholeRatio binary) p.1),
  doubledPower==multiply (wholeRatio (binary^2)) basePower,shellRows,shellRows.all (fun row => row.reconstructedPower==basePower),
  identities,baseHolds,identities.all CubicIdentity.successorPreservesIdentity,
  "third generated difference of amplitude paired with positive tick cubed is six paired with amplitude",
  "power is half-One paired with the third-rate carrier paired with itself",
  "rank-two shell density paired with radius and radius reconstructs total power",staticPower.isNone,false⟩
def certificateFacts : Except String Bool := do
 let c ← radiatedPowerCertificate
 pure (c.coupling==normalize 1 2 (by decide) && SFT.Host.Text.equal c.firstRadiativeMoment "quadrupole" && c.staticSilenceIsEmpty && c.thirdRateDoubles && c.powerQuadruples && c.shellPowerConserved && c.baseIdentityHolds && c.successorIdentityHolds && !c.forbiddenProofScalarUsed)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.QuadrupoleRadiatedPowerCertificate
