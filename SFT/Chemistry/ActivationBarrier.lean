import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.ActivationBarrier
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
-- activation_barrier_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure BarrierPathState where
 stateIdentity : HeldLabel
 relativeSupport : Height
def makeState (identity : LabelInput) (support : Height) : Except String BarrierPathState := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "generated-path-state" then pure l else throw "barrier state requires one generated path-state identity"
  | .other=>throw "barrier state requires one generated path-state identity"
 if !validHeight support then throw "barrier state requires exact positive support or structural EmptyOne"
 pure ⟨identity,support⟩
inductive StateInput where
 | state (value : BarrierPathState)
 | other
inductive Provenance where
 | held (value : HeldLabel)
 | emptyOne (identity : String := "empty-One")
 | other
structure BarrierPathRecord where
 speciesIdentity : HeldLabel
 pathIdentity : HeldLabel
 orderedStates : List BarrierPathState
 sourceTargetRow : PositiveCount
 sourceReference : Provenance
 uncertaintySupport : Provenance
 methodSupport : Provenance
def makePath (species path : LabelInput) (states : List StateInput) (source : CountInput)
 (reference uncertainty method : Provenance) : Except String BarrierPathRecord := do
 let species ← match species with
  | .held l=>if Text.equal l.family "registered-species" then pure l else throw "barrier path requires a registered species identity"
  | .other=>throw "barrier path requires a registered species identity"
 let path ← match path with
  | .held l=>if Text.equal l.family "generated-reaction-path" then pure l else throw "barrier path requires a generated path identity"
  | .other=>throw "barrier path requires a generated path identity"
 if states.isEmpty then throw "barrier path requires a complete ordered state word"
 let states ← states.mapM fun row=>match row with
  | .state s=>pure s
  | .other=>throw "barrier path requires a complete ordered state word"
 let identities := states.map BarrierPathState.stateIdentity
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != states.length then
  throw "barrier path contains duplicate state identities"
 if !(states.any (fun row=>match row.relativeSupport with | .ratio _=>true | .emptyOne | .otherEmptyOne _ | .invalid=>false)) then
  throw "barrier path requires a positive crossing support"
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "barrier path requires a positive source-target identity"
 if (match reference with | .other=>true | .held _ | .emptyOne _=>false) then throw "barrier path requires retained source-reference provenance"
 if (match uncertainty with | .other=>true | .held _ | .emptyOne _=>false) || (match method with | .other=>true | .held _ | .emptyOne _=>false) then
  throw "barrier path requires retained uncertainty and method provenance"
 pure ⟨species,path,states,source,reference,uncertainty,method⟩
inductive PathInput where
 | path (value : BarrierPathRecord)
 | other
structure ExactActivationBarrier where
 pathIdentity : HeldLabel
 boundaryState : BarrierPathState
 barrierSupport : Ratio
 orientation : HeldLabel
-- Strict comparison preserves the first state at a tied maximum, as Python max does.
def selectBoundary (current next : BarrierPathState × Ratio) : BarrierPathState × Ratio :=
 if current.2.numerator.value * next.2.denominator.value < next.2.numerator.value * current.2.denominator.value then next else current
def forcedActivationBarrier (input : PathInput) : Except String ExactActivationBarrier := do
 let path ← match input with
  | .path p=>pure p
  | .other=>throw "activation barrier requires a complete generated path"
 let positive := path.orderedStates.filterMap fun s=>match s.relativeSupport with | .ratio r=>some (s,r) | .emptyOne | .otherEmptyOne _ | .invalid=>none
 match positive with
 | []=>throw "activation barrier requires positive crossing support"
 | first::rest=>
  let boundary := rest.foldl selectBoundary first
  pure ⟨path.pathIdentity,boundary.1,boundary.2,⟨"barrier-orientation","least-state-to-highest-path-boundary",rfl,rfl⟩⟩
abbrev OrderedRow := HeldLabel × HeldLabel × Ratio × HeldLabel × PositiveCount
structure ExactBarrierCollection where
 carrier : HeldLabel
 orderedRows : List OrderedRow
def insertSourcePath (path : BarrierPathRecord) : List BarrierPathRecord → List BarrierPathRecord
 | []=>[path]
 | x::xs=>if path.sourceTargetRow.value≤x.sourceTargetRow.value then path::x::xs else x::insertSourcePath path xs
def forcedBarrierCollection (input : List PathInput) : Except String ExactBarrierCollection := do
 if input.isEmpty then throw "barrier collection requires a complete path census"
 let paths ← input.mapM fun p=>match p with
  | .path p=>pure p
  | .other=>throw "barrier collection requires a complete path census"
 let ordinals := paths.map (fun p=>p.sourceTargetRow.value)
 if (ordinals.foldl (fun found n=>if found.contains n then found else found++[n]) []).length != paths.length then
  throw "barrier collection contains duplicate source targets"
 let ordered := paths.foldr insertSourcePath []
 let rows ← ordered.mapM fun path=>do
  let result ← forcedActivationBarrier (.path path)
  pure (path.speciesIdentity,path.pathIdentity,result.barrierSupport,result.boundaryState.stateIdentity,path.sourceTargetRow)
 pure ⟨⟨"activation-barrier-collection","complete-source-ordered-path-census",rfl,rfl⟩,rows⟩
def externalNonnegativeSupport (input : InscriptionInput) : Except String Height := do
 let inscription ← match input with
  | .text s=>pure s
  | .other=>throw "barrier inscription requires exact nonnegative external support"
 if Text.equal inscription "EmptyOne" then return .emptyOne
 let chars := SolvationDissolution.strip (Text.chars inscription)
 if chars.isEmpty || chars.head?==some '-' then throw "barrier inscription requires exact nonnegative external support"
 let parsed ← match SolvationDissolution.fractionInscription (String.ofList (chars.dropWhile (fun c=>c=='+'))) with
  | .ok r=>pure r
  | .error _=>throw "barrier inscription is not exact finite support"
 match parsed.num with
 | .negSucc _=>throw "negative barrier support is prohibited"
 | .ofNat 0=>pure .emptyOne
 | .ofNat (_+1)=>return .ratio (← SolvationDissolution.positiveRatio parsed)
def externalPositiveMagnitude (input : InscriptionInput) : Except String Ratio := do
 match ← externalNonnegativeSupport input with
 | .ratio r=>pure r
 | .emptyOne | .otherEmptyOne _ | .invalid=>throw "barrier magnitude must be exact and positive"
def completePathAppendPreservesCollection (paths : List PathInput) (successor : PathInput) : Except String Bool := do
 let prior ← forcedBarrierCollection paths
 let extended ← forcedBarrierCollection (paths++[successor])
 let priorRows := extended.orderedRows.take prior.orderedRows.length
 pure (equalLabel extended.carrier prior.carrier && priorRows.length==prior.orderedRows.length &&
  (priorRows.zip prior.orderedRows).all fun ((s,p,r,b,n),(ss,pp,rr,bb,nn))=>
   equalLabel s ss && equalLabel p pp && equalHeight (.ratio r) (.ratio rr) && equalLabel b bb && n.value==nn.value)
def witnessPath (target : Int) (species path : String) (supports : List (Option Int)) : Except String BarrierPathRecord := do
 let species ← heldLabel "registered-species" species
 let path ← heldLabel "generated-reaction-path" path
 let states ← supports.zipIdx.mapM fun (value,i)=>do
  let identity ← heldLabel "generated-path-state" (Text.append "state-" (toString (i+1)))
  let support ← match value with
   | none=>pure Height.emptyOne
   | some (.negSucc _)=>throw "an SFT count must be a positive counted value"
   | some (.ofNat n)=>do
    let n ← count n
    pure (.ratio ⟨n,⟨1,by decide⟩⟩)
  return StateInput.state (← makeState (.held identity) support)
 let target ← match target with | .ofNat n=>count n | .negSucc _=>throw "an SFT count must be a positive counted value"
 makePath (.held species) (.held path) states (.count target) .emptyOne .emptyOne .emptyOne
def boundaryWitness : Except String Bool := do
 let p ← witnessPath 1 "s" "p" [none,some 2,some 5,some 3]
 let result ← forcedActivationBarrier (.path p)
 pure (result.barrierSupport.numerator.value==5*result.barrierSupport.denominator.value)
def leastWitness : Except String Bool := do
 match ← externalNonnegativeSupport (.text "0.00") with | .emptyOne=>pure true | .otherEmptyOne _ | .ratio _ | .invalid=>pure false
def orderWitness : Except String Bool := do
 let a ← witnessPath 1 "a" "p1" [none,some 5]
 let b ← witnessPath 2 "b" "p2" [none,some 3]
 let result ← forcedBarrierCollection [.path a,.path b]
 pure (match result.orderedRows with | [(_,_,_,_,a),(_,_,_,_,b)]=>a.value==1 && b.value==2 | [] | [_] | _::_::_::_=>false)
def appendWitness : Except String Bool := do
 let a ← witnessPath 1 "a" "p1" [none,some 5]
 let b ← witnessPath 2 "b" "p2" [none,some 3]
 completePathAppendPreservesCollection [.path a] (.path b)
theorem highestBoundary : boundaryWitness=.ok true := rfl
theorem structuralLeast : leastWitness=.ok true := rfl
theorem sourceOrder : orderWitness=.ok true := rfl
theorem completeAppend : appendWitness=.ok true := rfl
end SFT.Chemistry.ActivationBarrier
