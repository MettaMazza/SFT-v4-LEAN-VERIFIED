import SFT.Chemistry.ActivationBarrier
namespace SFT.Chemistry.TransitionBoundary
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
abbrev TransitionPathState := ActivationBarrier.BarrierPathState
abbrev StateInput := ActivationBarrier.StateInput
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def makeState (identity : LabelInput) (support : Height) : Except String TransitionPathState := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "generated-path-state" then pure l else throw "transition boundary requires generated path-state identity"
  | .other=>throw "transition boundary requires generated path-state identity"
 if !validHeight support then throw "transition boundary requires positive support or structural EmptyOne"
 pure ⟨identity,support⟩
structure TransitionPath where
 reactionIdentity : HeldLabel
 pathIdentity : HeldLabel
 isotopologueIdentity : HeldLabel
 orderedStates : List TransitionPathState
 sourceRow : PositiveCount
def equalRatio (a b : Ratio) : Bool := a.numerator.value*b.denominator.value==b.numerator.value*a.denominator.value
def positiveStates (states : List TransitionPathState) : List (TransitionPathState×Ratio) :=
 states.filterMap fun s=>match s.relativeSupport with | .ratio r=>some (s,r) | .emptyOne | .otherEmptyOne _ | .invalid=>none
def makePath (reaction path isotope : LabelInput) (states : List StateInput) (source : CountInput) : Except String TransitionPath := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "registered-reaction" then pure l else throw "transition path requires registered reaction identity"
  | .other=>throw "transition path requires registered reaction identity"
 let path ← match path with
  | .held l=>if Text.equal l.family "generated-reaction-path" then pure l else throw "transition path requires generated path identity"
  | .other=>throw "transition path requires generated path identity"
 let isotope ← match isotope with
  | .held l=>if Text.equal l.family "held-isotopologue" then pure l else throw "transition path requires held isotopologue identity"
  | .other=>throw "transition path requires held isotopologue identity"
 if states.length<2 then throw "transition path requires a complete finite state word"
 let states ← states.mapM fun row=>match row with
  | .state s=>pure s
  | .other=>throw "transition path requires a complete finite state word"
 let identities := states.map ActivationBarrier.BarrierPathState.stateIdentity
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != states.length then
  throw "transition path contains duplicate state identity"
 let positive := positiveStates states
 let greatest ← match positive with
  | []=>throw "transition path requires positive boundary support"
  | first::rest=>pure ((rest.foldl ActivationBarrier.selectBoundary first).2)
 if (positive.filter (fun (_,r)=>equalRatio r greatest)).length != 1 then
  throw "transition path requires one unique greatest finite boundary"
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "transition path requires positive source-row identity"
 pure ⟨reaction,path,isotope,states,source⟩
inductive PathInput where
 | path (value : TransitionPath)
 | other
inductive StateWord where
 | word (states : List TransitionPathState)
 | emptyOne
structure TransitionBoundaryCarrier where
 reactionIdentity : HeldLabel
 pathIdentity : HeldLabel
 isotopologueIdentity : HeldLabel
 entryWord : StateWord
 boundaryState : TransitionPathState
 exitWord : StateWord
 orientation : HeldLabel
def forcedTransitionBoundary (input : PathInput) : Except String TransitionBoundaryCarrier := do
 let path ← match input with
  | .path p=>pure p
  | .other=>throw "transition boundary requires one complete generated path"
 let greatest ← match positiveStates path.orderedStates with
  | []=>throw "max() arg is an empty sequence"
  | first::rest=>pure ((rest.foldl ActivationBarrier.selectBoundary first).2)
 let indices := path.orderedStates.zipIdx.filter fun (s,_)=>match s.relativeSupport with
  | .ratio r=>equalRatio r greatest
  | .emptyOne | .otherEmptyOne _ | .invalid=>false
 match indices with
 | [(boundary,index)]=>
  let before := path.orderedStates.take index
  let after := path.orderedStates.drop (index+1)
  pure ⟨path.reactionIdentity,path.pathIdentity,path.isotopologueIdentity,
   if before.isEmpty then .emptyOne else .word before,boundary,
   if after.isEmpty then .emptyOne else .word after,
   ⟨"path-boundary-orientation","entry-through-unique-boundary-to-exit",rfl,rfl⟩⟩
 | [] | _::_::_=>throw "transition boundary is not unique"
abbrev OrderedRow := PositiveCount × HeldLabel × HeldLabel × HeldLabel
structure TransitionBoundaryCollection where
 carrier : HeldLabel
 orderedRows : List OrderedRow
def insertSourcePath (path : TransitionPath) : List TransitionPath → List TransitionPath
 | []=>[path]
 | x::xs=>if path.sourceRow.value≤x.sourceRow.value then path::x::xs else x::insertSourcePath path xs
def forcedBoundaryCollection (input : List PathInput) : Except String TransitionBoundaryCollection := do
 if input.isEmpty then throw "transition boundary collection requires complete path census"
 let paths ← input.mapM fun p=>match p with
  | .path p=>pure p
  | .other=>throw "transition boundary collection requires complete path census"
 let ordinals := paths.map (fun p=>p.sourceRow.value)
 if (ordinals.foldl (fun found n=>if found.contains n then found else found++[n]) []).length != paths.length then
  throw "transition boundary collection duplicates a source row"
 let ordered := paths.foldr insertSourcePath []
 let rows ← ordered.mapM fun path=>do
  let result ← forcedTransitionBoundary (.path path)
  pure (path.sourceRow,path.reactionIdentity,path.isotopologueIdentity,result.boundaryState.stateIdentity)
 pure ⟨⟨"transition-boundary-collection","complete-source-ordered-finite-path-boundary-census",rfl,rfl⟩,rows⟩
structure ExternalBarrierSignature where
 orientation : HeldLabel
 positiveMagnitude : Ratio
 uncertainty : Ratio
inductive FractionInput where
 | text (value : String)
 | integer (value : Int)
 | boolean (value : Bool)
 | other
def decodeFraction : FractionInput → Except String Rat
 | .text s=>SolvationDissolution.fractionInscription s
 | .integer n=>pure (LeptonIntervals.normalize n 1 (by decide))
 | .boolean b=>pure (LeptonIntervals.normalize (if b then 1 else 0) 1 (by decide))
 | .other=>throw "invalid fraction"
def externalBarrierSignature (signed orientation : InscriptionInput) (uncertainty : FractionInput) : Except String ExternalBarrierSignature := do
 let inscription ← match signed with
  | .text s=>pure (SolvationDissolution.strip (Text.chars s))
  | .other=>throw "external barrier signature requires source inscription"
 if inscription.isEmpty then throw "external barrier signature requires source inscription"
 let inscription := inscription.map (fun c=>if c=='−' then '-' else c)
 let reverse := inscription.head?==some '-'
 let magnitudeText := if reverse then inscription.drop 1 else inscription.dropWhile (fun c=>c=='+')
 let magnitude ← match decodeFraction (.text (String.ofList magnitudeText)) with
  | .ok r=>pure r
  | .error _=>throw "external barrier signature is not exact finite provenance"
 let uncertaintyValue ← match decodeFraction uncertainty with
  | .ok r=>pure r
  | .error _=>throw "external barrier signature is not exact finite provenance"
 if !(@decide (0<magnitude.num) (Int.decLt _ _)) || !(@decide (0<uncertaintyValue.num) (Int.decLt _ _)) then
  throw "external barrier signature requires positive magnitude and uncertainty"
 let expected := if reverse then "reverse-held-temperature-order" else "held-temperature-order"
 if !(match orientation with | .text s=>Text.equal s expected | .other=>false) then
  throw "external signed inscription and held orientation disagree"
 let magnitude ← SolvationDissolution.positiveRatio magnitude
 let uncertainty ← SolvationDissolution.positiveRatio uncertaintyValue
 let label ← heldLabel "external-barrier-orientation" expected
 pure ⟨label,magnitude,uncertainty⟩
def completePathAppendPreservesBoundaries (paths : List PathInput) (successor : PathInput) : Except String Bool := do
 let prior ← forcedBoundaryCollection paths
 let extended ← forcedBoundaryCollection (paths++[successor])
 let priorRows := extended.orderedRows.take prior.orderedRows.length
 pure (equalLabel extended.carrier prior.carrier && priorRows.length==prior.orderedRows.length &&
  (priorRows.zip prior.orderedRows).all fun ((n,r,i,b),(nn,rr,ii,bb))=>
   n.value==nn.value && equalLabel r rr && equalLabel i ii && equalLabel b bb)
def witnessPath (source : Int) (isotope : String) (supports : List (Option Int)) : Except String TransitionPath := do
 let ntext := match source with | .ofNat n=>toString n | .negSucc n=>Text.append "-" (toString (n+1))
 let path ← heldLabel "generated-reaction-path" (Text.append "path-" ntext)
 let isotope ← heldLabel "held-isotopologue" isotope
 let states ← supports.zipIdx.mapM fun (value,i)=>do
  let identity ← heldLabel "generated-path-state" (Text.append "state-" (toString (i+1)))
  let support ← match value with
   | none=>pure Height.emptyOne
   | some (.negSucc _)=>throw "an SFT count must be a positive counted value"
   | some (.ofNat n)=>do
    let n ← count n
    pure (.ratio ⟨n,⟨1,by decide⟩⟩)
  return ActivationBarrier.StateInput.state (← makeState (.held identity) support)
 let source ← match source with | .ofNat n=>count n | .negSucc _=>throw "an SFT count must be a positive counted value"
 makePath (.held ⟨"registered-reaction","dissociative-activation",rfl,rfl⟩) (.held path) (.held isotope) states (.count source)
def boundaryWitness : Except String Bool := do
 let p ← witnessPath 1 "H2" [none,some 2,some 5,some 3]
 let result ← forcedTransitionBoundary (.path p)
 pure (match result.boundaryState.relativeSupport with | .ratio r=>r.numerator.value==5*r.denominator.value | .emptyOne | .otherEmptyOne _ | .invalid=>false)
def partitionWitness : Except String Bool := do
 let p ← witnessPath 1 "H2" [none,some 2,some 5,some 3]
 let result ← forcedTransitionBoundary (.path p)
 pure (match result.entryWord,result.exitWord with | .word a,.word b=>a.length+1+b.length==4 | .emptyOne, _ | .word _, .emptyOne=>false)
def orientationWitness : Except String Bool := do
 let result ← externalBarrierSignature (.text "−0.023") (.text "reverse-held-temperature-order") (.text "0.005")
 pure (result.positiveMagnitude.numerator.value*1000==23*result.positiveMagnitude.denominator.value)
def appendWitness : Except String Bool := do
 let a ← witnessPath 1 "H2" [none,some 2,some 5,some 3]
 let b ← witnessPath 2 "D2" [none,some 3,some 7,some 4]
 completePathAppendPreservesBoundaries [.path a] (.path b)
theorem finiteBoundary : boundaryWitness=.ok true := rfl
theorem completePartition : partitionWitness=.ok true := rfl
theorem positiveOrientedMagnitude : orientationWitness=.ok true := rfl
theorem completeAppend : appendWitness=.ok true := rfl
end SFT.Chemistry.TransitionBoundary
