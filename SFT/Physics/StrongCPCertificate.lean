import SFT.Physics.StrongCPHands
import SFT.Physics.StrongCPActions
namespace SFT.Physics.StrongCPCertificate
open StrongCPHands StrongCPActions LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Proton where
 initialColourWord : List Int
 initialBaryonTally : Rat
 generatedOneStepImages : List (List Int)
 generatedImageCount : Nat
 allImagesRetainBaryonOne : Bool
 quarkToLeptonAction : List String
 leptonOnlyDecayImage : List String
 finiteCompositionLaw : String
 baryogenesisBoundary : String
def protonTransitionCertificate : Except String Proton := do
 let words ← completeColourWords
 let colour ← FoldFirstReturn.generatorPeriod
 let initial := (List.range colour).map (fun i=>Int.ofNat (i+1))
 let action ← sectorActionCertificate
 if !action.generatedCrossFibreActions.isEmpty then throw "a cross-fibre action entered the closed mediator grammar"
 let tallies ← words.mapM baryonTally
 .ok ⟨initial,← baryonTally initial,words,words.length,tallies.all (fun x=>x==wholeRatio 1),["empty-One"],["empty-One"],"composition-of-same-fibre-maps-remains-same-fibre","the admitted retained-residue law has a distinct cosmological tally-changing premise; the complete mediator grammar contains no such low-energy proton transition"⟩
structure Certificate where
 alignment : Alignment
 actions : StrongCPActions.Certificate
 proton : Proton
 uniqueStrongHandForm : Bool
 onlyTwoPhaseClasses : Bool
 noExtraCompensator : Bool
 baryonOneInvariant : Bool
def samePhase (a b : String × SFT.Foundation.ExactPartCarrier.Part) : Bool :=
 SFT.Host.Text.equal a.1 b.1 && StrongCPHands.samePart a.2 b.2
def theoremCertificate : Except String Certificate := do
 let alignment ← strongAlignmentCertificate
 let actions ← sectorActionCertificate
 let proton ← protonTransitionCertificate
 let rows ← strongHandCensus
 let phases := rows.foldl (fun acc row=>if acc.any (fun p=>samePhase p row.phase) then acc else acc++[row.phase]) []
 .ok ⟨alignment,actions,proton,(rows.filter Row.completeColourHandProduct).length==1,phases.length==2,sameHands alignment.extraCompensatorRequired ["empty-One"],proton.initialBaryonTally==wholeRatio 1 && proton.allImagesRetainBaryonOne⟩
theorem protonOne : (protonTransitionCertificate.map (fun p=>(p.initialBaryonTally,p.generatedImageCount,p.allImagesRetainBaryonOne)))=.ok (wholeRatio 1,27,true) := rfl
theorem originalCertificateFlags : (theoremCertificate.map (fun c=>(c.uniqueStrongHandForm,c.onlyTwoPhaseClasses,c.noExtraCompensator,c.baryonOneInvariant)))=.ok (true,true,true,true) := rfl
#print axioms protonTransitionCertificate
#print axioms theoremCertificate
#print axioms protonOne
#print axioms originalCertificateFlags
end SFT.Physics.StrongCPCertificate
