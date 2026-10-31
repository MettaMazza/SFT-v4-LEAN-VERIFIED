import SFT.Physics.LeptonRatios
import SFT.Physics.RunningConvergence
import SFT.Physics.ElectroweakTerminalDomain
import SFT.Physics.DimensionReferenceTransport
namespace SFT.Physics.CommonScaleAxis
open GeneratorOperations LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 8000000

def scaleSpacing (level : CountInput) : Except String Rat := do
 let support ← RunningConvergence.generatedScaleSupport level
 match support with
 | 0 => .error "generated support must remain positive"
 | n+1 => .ok (normalize 1 (n+1) (Nat.zero_lt_succ n))
def traversalCount := RunningConvergence.generatedScaleSupport

def commonRationalRescalingRatio (n d u : FoldFirstReturn.Input) : Except String Rat :=
 match n with
 | .nonFraction => .error "unit transport requires exact positive rational carriers"
 | .fraction n => match d with
   | .nonFraction => .error "unit transport requires exact positive rational carriers"
   | .fraction d => match u with
     | .nonFraction => .error "unit transport requires exact positive rational carriers"
     | .fraction u =>
       if zero.blt n && zero.blt d && zero.blt u then LeptonRatios.divide (multiply n u) (multiply d u)
       else .error "unit transport requires exact positive rational carriers"

def positiveCountValue : CountInput → Option Nat
 | .boolean _ => none
 | .integer z => match z with
   | .negSucc _ => none
   | .ofNat n => match n with
     | 0 => none
     | k+1 => some (k+1)
def isBinarySupport (input : CountInput) : Except String Bool :=
 match positiveCountValue input with
 | some n => .ok ((RunningConvergence.reachingPair n).2 == n)
 | none => .error "binary support requires a positive whole count"
def electroweakSource (level : CountInput) : Except String Nat := do
 let support ← RunningConvergence.generatedScaleSupport level
 .ok (2+support)
def internalSquareAnchorLevels (input : CountInput) : Except String (List Nat) :=
 match positiveCountValue input with
 | some n => do
  let rows ← (List.range n).mapM fun k => do
   let source ← electroweakSource (.integer (.ofNat (k+1)))
   let admitted ← isBinarySupport (.integer (.ofNat source))
   .ok (k+1,admitted)
  .ok ((rows.filter Prod.snd).map Prod.fst)
 | none => .error "anchor census requires positive finite depth"

def squaredSupport (support : Nat) : Except String Rat := do
 let charged := normalize (.ofNat (support+1)) (support+2) (Nat.zero_lt_succ _)
 let neutral := normalize 1 2 (by decide)
 LeptonRatios.divide (multiply neutral neutral) (add (multiply charged charged) (multiply neutral neutral))
def leadingElectroweakShareAtSupport (input : CountInput) : Except String Rat :=
 match positiveCountValue input with
 | some n => do
  let value ← squaredSupport n
  let existing ← ElectroweakTerminalRatio.runningShare (.integer (.ofNat n))
  if value != BoundaryGrowth.asFraction existing then .error "electroweak squared-support identities diverged"
  else .ok value
 | none => .error "electroweak support must be positive"
def leadingElectroweakShare (level : CountInput) : Except String Rat := do
 let support ← RunningConvergence.generatedScaleSupport level
 leadingElectroweakShareAtSupport (.integer (.ofNat support))

structure TerminalChain where
 promotionCount : Nat
 completeSupport : Nat
 heldGeneratorDirections : Nat
 activeLevel : Nat
 baseShare : Rat
 returnDivisor : Nat
 returnedShare : Rat
 terminalShare : Rat

def terminalElectroweakChain : Except String TerminalChain := do
 let support ← ElectroweakTerminalSupport.binarySupport
 let held ← FoldFirstReturn.generatorPeriod
 let active := support-held
 let existingLevel ← ElectroweakTerminalSupport.runningLevel
 if active != existingLevel then .error "terminal active level changed"
 else do
  let base ← leadingElectroweakShareAtSupport (.integer (.ofNat active))
  let terminal ← ElectroweakTerminalRatio.sinSquared
  let terminal := BoundaryGrowth.asFraction terminal
  let promotion ← ElectroweakTerminalSupport.promotionCount
  let divisor ← ElectroweakTerminalSupport.returnDivisor
  .ok ⟨promotion,support,held,active,base,divisor,subtract terminal base,terminal⟩

inductive LandmarkKind where
 | completeSupport | heldSupport
structure Landmark where
 name : String
 kind : LandmarkKind
 support : Nat

def scaleAxisLandmarks : Except String (List Landmark) := do
 let chain ← terminalElectroweakChain
 .ok [⟨"One-origin",.completeSupport,1⟩,
  ⟨"electroweak-internal-square",.completeSupport,2⟩,
  ⟨"three-space-step",.completeSupport,8⟩,
  ⟨"terminal-electroweak-support",.completeSupport,chain.completeSupport⟩,
  ⟨"terminal-electroweak-active-level",.heldSupport,chain.activeLevel⟩,
  ⟨"down-sector-cover",.completeSupport,32⟩,
  ⟨"up-sector-cover",.completeSupport,128⟩,
  ⟨"proton-Planck-massive-predecessor",.heldSupport,127⟩]

def adjacentDescent : List Rat → Bool
 | [] => true
 | [_] => true
 | a::b::rest => b.blt a && adjacentDescent (b::rest)
def leadingCurveStrictlyDescends (input : CountInput) : Except String Bool :=
 match positiveCountValue input with
 | none => .error "curve descent requires two positive levels"
 | some n => match n with
  | 0 => .error "curve descent requires two positive levels"
  | 1 => .error "curve descent requires two positive levels"
  | n+2 => do
   let values ← (List.range (n+2)).mapM fun k => leadingElectroweakShare (.integer (.ofNat (k+1)))
   .ok (adjacentDescent values)

structure Certificate where
 supports : List Nat
 spacings : List Rat
 traversals : List Nat
 sectorVectors : List (List (Nat × Rat))
 leadingWeakCurve : List Rat
 internalSquareAnchorLevels : List Nat
 terminalElectroweakChain : TerminalChain
 landmarks : List Landmark
 unitRatioWitness : Rat

def commonAxisCertificate : Except String Certificate := do
 let supports ← (List.range 8).mapM fun k => RunningConvergence.generatedScaleSupport (.integer (.ofNat (k+1)))
 let spacings ← (List.range 8).mapM fun k => scaleSpacing (.integer (.ofNat (k+1)))
 let chain ← terminalElectroweakChain
 let traversals ← (List.range 8).mapM fun k => traversalCount (.integer (.ofNat (k+1)))
 let sectors ← (List.range 5).mapM fun k => RunningConvergence.commonScaleVector (.integer (.ofNat (k+1)))
 let curve ← (List.range 5).mapM fun k => leadingElectroweakShare (.integer (.ofNat (k+1)))
 let anchors ← internalSquareAnchorLevels (.integer 12)
 let landmarks ← scaleAxisLandmarks
 let unit ← commonRationalRescalingRatio (.fraction (normalize 7 5 (by decide)))
  (.fraction (normalize 11 3 (by decide))) (.fraction (normalize 13 17 (by decide)))
 .ok ⟨supports,spacings,traversals,sectors,curve,anchors,chain,landmarks,unit⟩

theorem traversalsAreSupport (level : CountInput) : traversalCount level=RunningConvergence.generatedScaleSupport level := rfl

theorem originalSupports : (commonAxisCertificate.map Certificate.supports)=.ok [1,2,4,8,16,32,64,128] := rfl

theorem originalAnchorCensus : internalSquareAnchorLevels (.integer 16)=.ok [2] := rfl

theorem originalWeakCurve : ((List.range 4).mapM fun k => leadingElectroweakShare (.integer (.ofNat (k+1)))).map
 (fun ps => ps.map (fun p => (p.num,p.den))) = .ok [(9,25),(4,13),(9,34),(25,106)] := rfl

theorem originalDescent : leadingCurveStrictlyDescends (.integer 12)=.ok true := rfl

theorem originalChainFields : terminalElectroweakChain.map (fun c =>
 (c.promotionCount,c.completeSupport,c.heldGeneratorDirections,c.activeLevel,(c.baseShare.num,c.baseShare.den),
 c.returnDivisor,(c.returnedShare.num,c.returnedShare.den),(c.terminalShare.num,c.terminalShare.den)))=
 .ok (4,16,3,13,(225,1009),17,(3676744786,8565388722973),(1930922298157999,8642477221479757)) := rfl

theorem originalLandmarks : scaleAxisLandmarks.map (List.map Landmark.support)=.ok [1,2,8,16,13,32,128,127] := rfl

theorem originalUnitWitness : (commonAxisCertificate.map Certificate.unitRatioWitness).map (fun r => (r.num,r.den))=.ok (21,55) := rfl

end SFT.Physics.CommonScaleAxis
