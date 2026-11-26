import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.TemperatureDependence
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- temperature_dependence_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure TemperatureRateRow where
 reactionIdentity : HeldLabel
 conditionIdentity : HeldLabel
 temperatureSupport : Ratio
 transitionRateSupport : Ratio
 sourceConditionRow : PositiveCount
 sourceTargetRow : PositiveCount
 uncertaintySupport : List Height
def makeRow (reactant condition : LabelInput) (temperature rate : Height) (conditionSource targetSource : CountInput)
 (uncertainties : List Height) : Except String TemperatureRateRow := do
 let reactant ← match reactant with
  | .held l=>if Text.equal l.family "registered-reaction" then pure l else throw "temperature relation requires a registered reaction identity"
  | .other=>throw "temperature relation requires a registered reaction identity"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "complete-condition" then pure l else throw "temperature relation requires a complete condition identity"
  | .other=>throw "temperature relation requires a complete condition identity"
 let ratios ← [temperature,rate].mapM fun row=>match row with
  | .ratio r=>pure r
  | .emptyOne | .otherEmptyOne _ | .invalid=>throw "temperature and rate require exact positive support"
 let sources ← [conditionSource,targetSource].mapM fun source=>match source with
  | .count n=>pure n
  | .other=>throw "temperature relation requires positive source-row identities"
 if uncertainties.isEmpty || uncertainties.any (fun c=>match c with | .invalid=>true | .emptyOne | .otherEmptyOne _ | .ratio _=>false) then
  throw "temperature relation requires complete uncertainty provenance"
 match ratios,sources with
 | [temperature,rate],[conditionSource,targetSource]=>pure ⟨reactant,condition,temperature,rate,conditionSource,targetSource,uncertainties⟩
 | [], _ | [_], _ | _::_::_::_, _ =>throw "temperature and rate require exact positive support"
 | [_,_], [] | [_,_], [_] | [_,_], _::_::_::_=>throw "temperature and rate require exact positive support"
inductive RowInput where
 | row (value : TemperatureRateRow)
 | other
abbrev OrderedRow := HeldLabel × Ratio × Ratio × HeldLabel × PositiveCount × PositiveCount
structure ExactTemperatureDependence where
 carrier : HeldLabel
 orderedRows : List OrderedRow
-- Insertion implements the source numeric-key sort; duplicate keys reject before sorting.
def insertSourceRow (row : TemperatureRateRow) : List TemperatureRateRow → List TemperatureRateRow
 | []=>[row]
 | x::xs=>if row.sourceTargetRow.value≤x.sourceTargetRow.value then row::x::xs else x::insertSourceRow row xs
def forcedTemperatureDependence (input : List RowInput) : Except String ExactTemperatureDependence := do
 if input.isEmpty then throw "temperature dependence requires a complete positive row census"
 let rows ← input.mapM fun row=>match row with
  | .row r=>pure r
  | .other=>throw "temperature dependence requires a complete positive row census"
 let sources := rows.map (fun r=>r.sourceTargetRow.value)
 if (sources.foldl (fun found n=>if found.contains n then found else found++[n]) []).length != rows.length then
  throw "temperature dependence contains duplicate source target rows"
 let ordered := rows.foldr insertSourceRow []
 pure ⟨⟨"temperature-dependence-carrier","complete-registered-reaction-census",rfl,rfl⟩,
  ordered.map fun row=>(row.reactionIdentity,row.temperatureSupport,row.transitionRateSupport,row.conditionIdentity,row.sourceConditionRow,row.sourceTargetRow)⟩
def externalPositiveMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "temperature/rate inscription requires exact positive support"
  else .error "temperature/rate inscription is not exact positive finite support"
def completeRowAppendPreservesRelation (rows : List RowInput) (successor : RowInput) : Except String Bool := do
 let prior ← forcedTemperatureDependence rows
 let extended ← forcedTemperatureDependence (rows++[successor])
 let priorRows := extended.orderedRows.take prior.orderedRows.length
 pure (equalLabel extended.carrier prior.carrier && priorRows.length==prior.orderedRows.length &&
  (priorRows.zip prior.orderedRows).all fun ((reaction,c,r,k,n,t),(preaction,pc,pr,pk,pn,pt))=>
   equalLabel reaction preaction && equalHeight (.ratio c) (.ratio pc) && equalHeight (.ratio r) (.ratio pr) && equalLabel k pk && n.value==pn.value && t.value==pt.value)
def witnessRow (target condition : Int) (reaction : String) (temperature rate : Int) : Except String TemperatureRateRow := do
 let reaction ← heldLabel "registered-reaction" reaction
 let numberText := match condition with | .ofNat n=>toString n | .negSucc n=>Text.append "-" (toString (n+1))
 let conditionLabel ← heldLabel "complete-condition" (Text.append "condition-" numberText)
 let positive := fun (n : Int)=>match n with
  | .ofNat n=>count n | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let c ← positive temperature
 let r ← positive rate
 let conditionSource ← positive condition
 let targetSource ← positive target
 makeRow (.held reaction) (.held conditionLabel) (.ratio ⟨c,⟨1,by decide⟩⟩) (.ratio ⟨r,⟨1,by decide⟩⟩)
  (.count conditionSource) (.count targetSource) [.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩,.emptyOne]
def orderWitness : Except String Bool := do
 let a ← witnessRow 1 1 "r-a" 3 5
 let b ← witnessRow 2 2 "r-a" 7 4
 let r ← forcedTemperatureDependence [.row a,.row b]
 pure (match r.orderedRows with | [(_,_,_,_,_,x),(_,_,_,_,_,y)]=>x.value==1 && y.value==2 | [] | [_] | _::_::_::_=>false)
def adverseWitness : Except String Bool := do
 let a ← witnessRow 1 1 "r-a" 3 5
 let b ← witnessRow 2 2 "r-a" 7 4
 let r ← forcedTemperatureDependence [.row a,.row b]
 pure (match (r.orderedRows.drop 1).head? with | some (_,_,rate,_,_,_)=>rate.numerator.value==4*rate.denominator.value | none=>false)
def separationWitness : Except String Bool := do
 let a ← witnessRow 1 1 "r-a" 3 5
 let b ← witnessRow 2 1 "r-b" 3 7
 let r ← forcedTemperatureDependence [.row a,.row b]
 let names := r.orderedRows.map fun (reaction,_,_,_,_,_)=>reaction.label
 pure ((names.foldl (fun found n=>if found.any (Text.equal n) then found else found++[n]) []).length==2)
def appendWitness : Except String Bool := do
 let a ← witnessRow 1 1 "r-a" 3 5
 let b ← witnessRow 2 2 "r-a" 7 4
 completeRowAppendPreservesRelation [.row a] (.row b)
theorem sourceOrder : orderWitness=.ok true := rfl
theorem adverseRetention : adverseWitness=.ok true := rfl
theorem reactionSeparation : separationWitness=.ok true := rfl
theorem completeAppend : appendWitness=.ok true := rfl
end SFT.Chemistry.TemperatureDependence
