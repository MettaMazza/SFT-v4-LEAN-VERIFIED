import SFT.Chemistry.FiniteMicrostateSupport
namespace SFT.Chemistry.EntropyMultiplicityCorrespondence
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion SFT.Foundation.ExactOperations
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Pinned entropy_multiplicity_correspondence_law_v1.py, 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
inductive SupportInput where
 | tuple (values : List LabelInput)
 | other
inductive ObservationInput where
 | tuple (values : List (LabelInput × LabelInput))
 | other
inductive Distinctions where
 | pairs (values : List (HeldLabel×HeldLabel))
 | emptyOne
structure ChemicalEntropyClass where
 macroObservation : HeldLabel
 microstates : List HeldLabel
 multiplicity : PositiveCount
 exactSupportPart : Ratio
 unresolvedDistinctions : Distinctions
structure ChemicalEntropyLedger where
 completeSupport : List HeldLabel
 classes : List ChemicalEntropyClass
def equalInput (a b : LabelInput) : Bool := match a,b with
 | .held a,.held b => equalLabel a b
 | .other,.other => true
 | .other,.held _ | .held _,.other => false
def distinctInputs : List LabelInput → Bool
 | [] => true
 | first::rest => !(rest.any (equalInput first)) && distinctInputs rest
def validateSupportAndObservation (input : SupportInput) (observation : ObservationInput) : Except String (List HeldLabel × List (HeldLabel×HeldLabel)) := do
 let raw ← match input with
  | .tuple (first::rest) => pure (first::rest)
  | .tuple [] | .other => throw "chemical entropy requires finite nonempty microstate support"
 let support ← raw.mapM fun value => match value with
  | .held label => if Text.equal label.family "chemical-microstate" then pure label
    else throw "chemical entropy support lost microstate identity"
  | .other => throw "chemical entropy support lost microstate identity"
 if !distinctAtoms support then throw "chemical entropy support duplicated a microstate"
 let pairs ← match observation with
  | .tuple pairs =>
   if pairs.length==support.length then pure pairs
   else throw "chemical entropy requires a total observation"
  | .other => throw "chemical entropy requires a total observation"
 let keys := pairs.map Prod.fst
 if !distinctInputs keys || !(keys.all fun key => raw.any (equalInput key)) ||
  !(raw.all fun key => keys.any (equalInput key)) then throw "chemical observation is partial or duplicated"
 let images ← pairs.mapM fun (key,image) => do
  let image ← match image with
   | .held label =>
    if Text.equal label.family "chemical-macro-observation" then pure label
    else throw "chemical macro-observation lost held identity"
   | .other => throw "chemical macro-observation lost held identity"
  match key with
  | .held key => pure (key,image)
  | .other => throw "chemical observation is partial or duplicated"
 pure (support,images)
def unresolvedPairs (members : List HeldLabel) : Distinctions :=
 let pairs := members.zipIdx.flatMap fun (left,position) =>
  (members.drop (position+1)).map fun right => (left,right)
 if pairs.isEmpty then .emptyOne else .pairs pairs
def imageAt (images : List (HeldLabel×HeldLabel)) (state : HeldLabel) : Except String HeldLabel :=
 match images.find? (fun pair => equalLabel pair.1 state) with
 | some pair => pure pair.2
 | none => .error "chemical observation is partial or duplicated"
def chemicalEntropyLedger (support : SupportInput) (observation : ObservationInput) : Except String ChemicalEntropyLedger := do
 let (support,images) ← validateSupportAndObservation support observation
 let ordered ← support.mapM (imageAt images)
 let labels := ordered.foldl (fun labels image => if labels.any (equalLabel image) then labels else labels++[image]) []
 let classes ← labels.mapM fun label => do
  let members := (support.zip ordered).filterMap fun (state,image) => if equalLabel image label then some state else none
  if count : 0<members.length then
   if total : 0<support.length then
    pure (⟨label,members,⟨members.length,count⟩,⟨⟨members.length,count⟩,⟨support.length,total⟩⟩,unresolvedPairs members⟩ : ChemicalEntropyClass)
   else throw "an SFT count must be a positive counted value"
  else throw "an SFT count must be a positive counted value"
 pure ⟨support,classes⟩
inductive LedgerInput where
 | ledger (value : ChemicalEntropyLedger)
 | other
def closedDistinctionPairs (input : LedgerInput) : Except String Distinctions := do
 let ledger ← match input with
  | .ledger value => pure value
  | .other => throw "closed distinctions require a chemical entropy ledger"
 let pairs := ledger.classes.flatMap fun item => match item.unresolvedDistinctions with
  | .pairs values => values
  | .emptyOne => []
 pure (if pairs.isEmpty then .emptyOne else .pairs pairs)
def chemicalObservationRefines (support : SupportInput) (fine coarse : ObservationInput) : Except String Bool := do
 let (states,fineImages) ← validateSupportAndObservation support fine
 let (_,coarseImages) ← validateSupportAndObservation support coarse
 let comparisons ← states.mapM fun left => do
  let fineLeft ← imageAt fineImages left
  let coarseLeft ← imageAt coarseImages left
  let comparisons ← states.mapM fun right => do
   let fineRight ← imageAt fineImages right
   if equalLabel fineLeft fineRight then
    pure (equalLabel coarseLeft (← imageAt coarseImages right))
   else pure true
  pure (comparisons.all id)
 pure (comparisons.all id)
def equalLabels : List HeldLabel → List HeldLabel → Bool
 | [],[] => true
 | first::rest,next::tail => equalLabel first next && equalLabels rest tail
 | [],_::_ | _::_,[] => false
def appendMicrostatePreservesLedger (support : SupportInput) (observation : ObservationInput)
 (newState newImage : LabelInput) : Except String Bool := do
 let prior ← chemicalEntropyLedger support observation
 if prior.completeSupport.any (fun state => equalInput (.held state) newState) then
  throw "entropy successor requires one fresh microstate"
 let rawObservation ← match observation with
  | .tuple values => pure values
  | .other => throw "chemical entropy requires a total observation"
 let extended ← chemicalEntropyLedger (.tuple (prior.completeSupport.map MolecularFormationEnergy.LabelInput.held++[newState]))
  (.tuple (rawObservation++[(newState,newImage)]))
 let checks ← prior.classes.mapM fun priorClass => do
  let current ← match extended.classes.find? (fun item => equalLabel item.macroObservation priorClass.macroObservation) with
   | some value => pure value
   | none => throw "chemical observation is partial or duplicated"
  if equalInput (.held priorClass.macroObservation) newImage then
   pure (equalLabels (current.microstates.take (current.microstates.length-1)) priorClass.microstates &&
    (match current.microstates.getLast? with | some last => equalInput (.held last) newState | none => false))
  else pure (equalLabels current.microstates priorClass.microstates)
 pure (checks.all id && equalLabels (extended.completeSupport.take (extended.completeSupport.length-1)) prior.completeSupport)
def aa : HeldLabel := ⟨"chemical-microstate","aa",rfl,rfl⟩
def ab : HeldLabel := ⟨"chemical-microstate","ab",rfl,rfl⟩
def ba : HeldLabel := ⟨"chemical-microstate","ba",rfl,rfl⟩
def bb : HeldLabel := ⟨"chemical-microstate","bb",rfl,rfl⟩
def fresh : HeldLabel := ⟨"chemical-microstate","ac",rfl,rfl⟩
def labelA : HeldLabel := ⟨"chemical-macro-observation","a",rfl,rfl⟩
def labelB : HeldLabel := ⟨"chemical-macro-observation","b",rfl,rfl⟩
def support : SupportInput := .tuple [.held aa,.held ab,.held ba,.held bb]
def fine : ObservationInput := .tuple [(.held aa,.held ⟨"chemical-macro-observation","aa",rfl,rfl⟩),(.held ab,.held ⟨"chemical-macro-observation","ab",rfl,rfl⟩),(.held ba,.held ⟨"chemical-macro-observation","ba",rfl,rfl⟩),(.held bb,.held ⟨"chemical-macro-observation","bb",rfl,rfl⟩)]
def prefixObservation : ObservationInput := .tuple [(.held aa,.held labelA),(.held ab,.held labelA),(.held ba,.held labelB),(.held bb,.held labelB)]
def coarse : ObservationInput := .tuple ([aa,ab,ba,bb].map fun state => (.held state,.held ⟨"chemical-macro-observation","unresolved",rfl,rfl⟩))
def multiplicityWitness : Except String Bool := do
 let ledger ← chemicalEntropyLedger support prefixObservation
 pure (ledger.classes.all fun c => c.multiplicity.value==2 && 2*c.exactSupportPart.numerator.value==c.exactSupportPart.denominator.value)
def singletonWitness : Except String Bool := do
 let ledger ← chemicalEntropyLedger support fine
 pure (ledger.classes.all fun c => match c.unresolvedDistinctions with | .emptyOne => true | .pairs _ => false)
def pairsWitness : Except String Bool := do
 let ledger ← chemicalEntropyLedger support coarse
 let pairs ← closedDistinctionPairs (.ledger ledger)
 pure (match pairs with | .pairs values => values.length==6 | .emptyOne => false)
def refinementWitness : Except String Bool := do
 let first ← chemicalObservationRefines support fine prefixObservation
 let second ← chemicalObservationRefines support prefixObservation coarse
 pure (first && second)
def successorWitness : Except String Bool := appendMicrostatePreservesLedger support prefixObservation (.held fresh) (.held labelA)
theorem exactMultiplicity : multiplicityWitness=.ok true := rfl
theorem singletonEmptyOne : singletonWitness=.ok true := rfl
theorem completePairLedger : pairsWitness=.ok true := rfl
theorem refinement : refinementWitness=.ok true := rfl
theorem successor : successorWitness=.ok true := rfl
end SFT.Chemistry.EntropyMultiplicityCorrespondence
