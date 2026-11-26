import SFT.Chemistry.SolvationDissolution
namespace SFT.Chemistry.ConcentrationDependence
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
abbrev InscriptionInput := SolvationDissolution.InscriptionInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- concentration_dependence_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure ConcentrationRateRow where
 reactantIdentity : HeldLabel
 conditionIdentity : HeldLabel
 concentrationSupport : Ratio
 transitionRateSupport : Ratio
 sourceRow : PositiveCount
 uncertaintySupport : List Height
def makeRow (reactant condition : LabelInput) (concentration rate : Height) (source : CountInput)
 (uncertainties : List Height) : Except String ConcentrationRateRow := do
 let reactant ← match reactant with
  | .held l=>if Text.equal l.family "registered-reactant" then pure l else throw "concentration relation requires one registered reactant"
  | .other=>throw "concentration relation requires one registered reactant"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "complete-condition" then pure l else throw "concentration relation requires a complete condition identity"
  | .other=>throw "concentration relation requires a complete condition identity"
 let ratios ← [concentration,rate].mapM fun row=>match row with
  | .ratio r=>pure r
  | .emptyOne | .otherEmptyOne _ | .invalid=>throw "concentration and rate require exact positive support"
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "concentration relation requires a positive source-row identity"
 if uncertainties.isEmpty || uncertainties.any (fun c=>match c with | .invalid=>true | .emptyOne | .otherEmptyOne _ | .ratio _=>false) then
  throw "concentration relation requires complete uncertainty provenance"
 match ratios with
 | [concentration,rate]=>pure ⟨reactant,condition,concentration,rate,source,uncertainties⟩
 | [] | [_] | _::_::_::_=>throw "concentration and rate require exact positive support"
inductive RowInput where
 | row (value : ConcentrationRateRow)
 | other
abbrev OrderedRow := Ratio × Ratio × HeldLabel × PositiveCount
structure ExactConcentrationDependence where
 carrier : HeldLabel
 orderedRows : List OrderedRow
-- Insertion implements the source numeric-key sort; duplicate keys reject before sorting.
def insertSourceRow (row : ConcentrationRateRow) : List ConcentrationRateRow → List ConcentrationRateRow
 | []=>[row]
 | x::xs=>if row.sourceRow.value≤x.sourceRow.value then row::x::xs else x::insertSourceRow row xs
def forcedConcentrationDependence (input : List RowInput) : Except String ExactConcentrationDependence := do
 if input.isEmpty then throw "concentration dependence requires a complete positive row census"
 let rows ← input.mapM fun row=>match row with
  | .row r=>pure r
  | .other=>throw "concentration dependence requires a complete positive row census"
 let sources := rows.map (fun r=>r.sourceRow.value)
 if (sources.foldl (fun found n=>if found.contains n then found else found++[n]) []).length != rows.length then
  throw "concentration dependence contains duplicate source rows"
 match rows with
 | []=>throw "concentration dependence requires a complete positive row census"
 | first::_=>
  if !(rows.all fun row=>equalLabel row.reactantIdentity first.reactantIdentity) then
   throw "one concentration relation cannot collapse distinct reactants"
  let ordered := rows.foldr insertSourceRow []
  let carrier ← heldLabel "concentration-dependence-carrier" first.reactantIdentity.label
  pure ⟨carrier,ordered.map fun row=>(row.concentrationSupport,row.transitionRateSupport,row.conditionIdentity,row.sourceRow)⟩
def externalPositiveMagnitude (input : InscriptionInput) : Except String Ratio :=
 match SolvationDissolution.exactSolubilityCapacity input with
 | .ok r=>.ok r
 | .error e=>if Text.equal e "solubility capacity requires an exact positive external inscription" then
   .error "concentration/rate inscription requires exact positive support"
  else .error "concentration/rate inscription is not exact positive finite support"
def completeRowAppendPreservesRelation (rows : List RowInput) (successor : RowInput) : Except String Bool := do
 let prior ← forcedConcentrationDependence rows
 let extended ← forcedConcentrationDependence (rows++[successor])
 let priorRows := extended.orderedRows.take prior.orderedRows.length
 pure (equalLabel extended.carrier prior.carrier && priorRows.length==prior.orderedRows.length &&
  (priorRows.zip prior.orderedRows).all fun ((c,r,k,n),(pc,pr,pk,pn))=>
   equalHeight (.ratio c) (.ratio pc) && equalHeight (.ratio r) (.ratio pr) && equalLabel k pk && n.value==pn.value)
def witnessRow (number concentration rate : Int) : Except String ConcentrationRateRow := do
 let numberText := match number with | .ofNat n=>toString n | .negSucc n=>Text.append "-" (toString (n+1))
 let condition ← heldLabel "complete-condition" (Text.append "condition-" numberText)
 let positive := fun (n : Int)=>match n with
  | .ofNat n=>count n | .negSucc _=>Except.error "an SFT count must be a positive counted value"
 let c ← positive concentration
 let r ← positive rate
 let n ← positive number
 makeRow (.held ⟨"registered-reactant","OH-plus-DME",rfl,rfl⟩) (.held condition)
  (.ratio ⟨c,⟨1,by decide⟩⟩) (.ratio ⟨r,⟨1,by decide⟩⟩) (.count n)
  [.ratio ⟨⟨1,by decide⟩,⟨2,by decide⟩⟩,.emptyOne]
def orderWitness : Except String Bool := do
 let a ← witnessRow 1 3 5
 let b ← witnessRow 2 7 4
 let r ← forcedConcentrationDependence [.row a,.row b]
 pure (match r.orderedRows with | [(_,_,_,x),(_,_,_,y)]=>x.value==1 && y.value==2 | [] | [_] | _::_::_::_=>false)
def adverseWitness : Except String Bool := do
 let a ← witnessRow 1 3 5
 let b ← witnessRow 2 7 4
 let r ← forcedConcentrationDependence [.row a,.row b]
 pure (match (r.orderedRows.drop 1).head? with | some (_,rate,_,_)=>rate.numerator.value==4*rate.denominator.value | none=>false)
def absenceWitness : Except String Bool := do
 let a ← witnessRow 1 3 5
 pure (match (a.uncertaintySupport.drop 1).head? with | some .emptyOne | some (.otherEmptyOne _)=>true | none | some .invalid | some (.ratio _)=>false)
def appendWitness : Except String Bool := do
 let a ← witnessRow 1 3 5
 let b ← witnessRow 2 7 4
 completeRowAppendPreservesRelation [.row a] (.row b)
theorem sourceOrder : orderWitness=.ok true := rfl
theorem adverseRetention : adverseWitness=.ok true := rfl
theorem structuralAbsence : absenceWitness=.ok true := rfl
theorem completeAppend : appendWitness=.ok true := rfl
end SFT.Chemistry.ConcentrationDependence
