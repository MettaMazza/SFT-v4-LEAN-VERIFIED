import SFT.Mathematics.CalculatorCompleteJSON
namespace SFT.Mathematics.CalculatorExpressionCensus
open SFT.Host SFT.Host.Canonical
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def calculatorClaimId : String := "SFT-MATH-SCIENTIFIC-CALCULATOR-006"
def currentClaimIds : List String := ["SFT-MATH-EXACT-ARITHMETIC-001","SFT-MATH-DISCRETE-001","SFT-MATH-COMBINATORICS-001","SFT-MATH-GRAPH-NETWORK-001","SFT-MATH-ALGEBRA-001","SFT-MATH-ORDER-LATTICE-001","SFT-MATH-GEOMETRY-TOPOLOGY-001","SFT-MATH-PROBABILITY-STATISTICS-001","SFT-MATH-OPTIMIZATION-001","SFT-MATH-DYNAMICAL-SYSTEMS-001","SFT-MATH-LOGIC-PROOF-001","SFT-MATH-CATEGORY-TYPE-COMPOSITION-001","SFT-MATH-EXACT-RELATIONS-002","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-LIMIT-CONTINUUM-002","SFT-MATH-ALGEBRAIC-BALANCE-002","SFT-MATH-BOUNDED-N-BODY-002","SFT-MATH-FLOORED-FLUID-REGULARITY-002","SFT-MATH-PRIME-PAIR-CENSUS-002","SFT-MATH-RIEMANN-MIRROR-002","SFT-MATH-COLLATZ-FINITE-CENSUS-002","SFT-MATH-SELF-SIMILAR-CONVERGENCE-002","SFT-MATH-SCIENTIFIC-CALCULATOR-004","SFT-MATH-SCIENTIFIC-CALCULATOR-005","SFT-MATH-SCIENTIFIC-CALCULATOR-006"]
def structuredOperations : List (String × List String) := [("SFT-MATH-EXACT-ARITHMETIC-001",["junction","product","quotient","comparison","oriented remainder"]),("SFT-MATH-DISCRETE-001",["collection","selection","relation","finite function","induction trace"]),("SFT-MATH-COMBINATORICS-001",["arrangements","selections","class ledger","recurrence extension"]),("SFT-MATH-GRAPH-NETWORK-001",["graph","path","reachability","cycle","cut","network balance"]),("SFT-MATH-ALGEBRA-001",["operation table","identity","associativity","return mate","homomorphism"]),("SFT-MATH-ORDER-LATTICE-001",["partial order","comparability","meet","join","monotone map"]),("SFT-MATH-GEOMETRY-TOPOLOGY-001",["incidence","dimension","adjacency","path distance","finite topology","continuity"]),("SFT-MATH-PROBABILITY-STATISTICS-001",["event","exact weight","conditional weight","independence","mode","observation class"]),("SFT-MATH-OPTIMIZATION-001",["feasible carrier","undominated carrier","exact optimum","Pareto frontier","approximation ratio"]),("SFT-MATH-DYNAMICAL-SYSTEMS-001",["transition law","trajectory","time","fixed form","return","reversibility","stability"]),("SFT-MATH-LOGIC-PROOF-001",["proposition","denial","junction","alternative","proof","consistency","grammar completeness"]),("SFT-MATH-CATEGORY-TYPE-COMPOSITION-001",["identity arrow","composition","canonical path","type","product","sum","functor","naturality"])]
def scalarAndCertificateClaims : List String := ["SFT-MATH-ALGEBRAIC-BALANCE-002","SFT-MATH-BOUNDED-N-BODY-002","SFT-MATH-COLLATZ-FINITE-CENSUS-002","SFT-MATH-EXACT-RELATIONS-002","SFT-MATH-FLOORED-FLUID-REGULARITY-002","SFT-MATH-LIMIT-CONTINUUM-002","SFT-MATH-ORBIT-NUMBER-THEORY-002","SFT-MATH-PRIME-PAIR-CENSUS-002","SFT-MATH-RIEMANN-MIRROR-002","SFT-MATH-SCIENTIFIC-CALCULATOR-004","SFT-MATH-SCIENTIFIC-CALCULATOR-005","SFT-MATH-SELF-SIMILAR-CONVERGENCE-002"]
structure Family where
 claimId : String
 interaction : String
 operations : List String
def distinct (xs : List String) : Bool := match xs with
 | [] => true
 | x::tail => !(tail.any (Text.equal x)) && distinct tail
def expressionFamiliesFor (ids : List String) : Except String (List Family) := do
 let predecessors := ids.filter (fun x => !Text.equal x calculatorClaimId)
 let families ← predecessors.mapM fun claimId => do
  match structuredOperations.find? (fun kv => Text.equal kv.1 claimId) with
  | some (_,ops) => pure (⟨claimId,"structured_exact_library_and_law_replay",ops⟩ : Family)
  | none =>
    if scalarAndCertificateClaims.any (Text.equal claimId) then pure ⟨claimId,"scalar_or_certificate_evaluator_and_law_replay",["exact value","certified enclosure","registered enumeration replay"]⟩
    else throw (Text.append "Mathematics expression family lacks a calculator translation: " claimId)
 if !distinct predecessors || families.length != predecessors.length || !(families.all (fun x => predecessors.any (Text.equal x.claimId)) && predecessors.all (fun x => families.any (fun f => Text.equal x f.claimId))) then throw "Mathematics expression census is not one-to-one"
 pure families
def expressionFamilies := expressionFamiliesFor currentClaimIds
def familyValue (f : Family) : Value := .object [("claim_id",.text f.claimId),("interaction",.text f.interaction),("operations",.array (f.operations.map Value.text))]
def expressionCensusValue : Except String Value := do
 let families ← expressionFamilies
 pure (.object [("calculator_claim_id",.text calculatorClaimId),("scope",.text "every registered predecessor in the current SFT Mathematics branch"),("family_count",.integer (.ofNat families.length)),("families",.array (families.map familyValue))])
def expressionCensusJSON : Except String String := expressionCensusValue.map CalculatorCompleteJSON.document
theorem originalFamilyCount : expressionFamilies.map List.length = .ok 24 := rfl
theorem originalFamilyCorrespondence : expressionFamilies.map (fun xs => xs.map Family.claimId)=.ok (currentClaimIds.filter (fun x => !Text.equal x calculatorClaimId)) := rfl
end SFT.Mathematics.CalculatorExpressionCensus
