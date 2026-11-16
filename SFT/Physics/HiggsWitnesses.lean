import SFT.Physics.HiggsCertificate
namespace SFT.Physics.HiggsWitnesses
open HiggsGround HiggsTerminal LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Witness where
 name : String
 statement : String
 passed : Bool
def witness0 : Bool := match ((do let rows ← vacuumGroundCensus; let ground ← displacedGround; pure (rows.length==3 && HiggsGround.samePart ground SFT.Foundation.HalfOneDerivation.halfOne)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness0Passed : witness0=true := rfl
#print axioms witness0Passed
def witness1 : Bool := match ((do let (a,b,c) ← leadingHiggsRungs; pure (a==normalize 1 2 (by decide) && b==normalize 1 4 (by decide) && c==normalize 1 8 (by decide))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness1Passed : witness1=true := rfl
#print axioms witness1Passed
def witness2 : Bool := match ((do let support ← scalarDirectionSupport; let active ← activeScalarDirections; let cover ← generationCoverDepth; pure (support==6 && active==cover && cover==5)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness2Passed : witness2=true := rfl
#print axioms witness2Passed
def witness3 : Bool := match ((do pure ((← terminalHiggsMassRatio)==normalize 2563352914777 5038463954690 (by decide))) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness3Passed : witness3=true := rfl
#print axioms witness3Passed
def witness4 : Bool := match ((do let coupling ← terminalHiggsSelfCoupling; let routes ← routeCrossLock; pure (coupling==normalize 6570778165695741824959729 50772238045420788745992200 (by decide) && routes.routesEqual)) : Except String Bool) with | .error _=>false | .ok b=>b
theorem witness4Passed : witness4=true := rfl
#print axioms witness4Passed
def witnesses : List Witness := [⟨"ground-census","Three minimal ground forms are generated and half-One is the unique displaced survivor.",witness0⟩,⟨"leading-rungs","The earlier half/quarter/eighth hierarchy is retained exactly.",witness1⟩,⟨"support-cross-lock","Complete scalar support is six and both independent predecessor and cover routes return five.",witness2⟩,⟨"terminal-ratio","The one terminal return forces the exact mass ratio without a target.",witness3⟩,⟨"terminal-coupling","The exact self-coupling and squared mass route cross-lock over the two fibres.",witness4⟩]
end SFT.Physics.HiggsWitnesses
