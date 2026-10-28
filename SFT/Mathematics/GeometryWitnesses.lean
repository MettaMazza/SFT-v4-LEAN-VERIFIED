import SFT.Mathematics.GeometryShortest
namespace SFT.Mathematics.GeometryWitnesses
open GeometryTopology DiscreteObjects

theorem absentOfFalse (visited : List String) (held : String) (no : has visited held = false) : ¬ held ∈ visited := by
  intro member
  have yes := (hasIff _ _).mpr member
  rw [no] at yes
  cases yes

theorem leafDerivation (boundary : Boundary) (visited : List String) (held : String)
    (empty : faces boundary held = []) (no : has visited held = false) : DepthDerivation boundary visited held 1 := by
  apply DepthDerivation.node visited held [] (absentOfFalse visited held no)
  rw [empty]
  exact FaceDerivations.nil _

theorem edgeDerivation (visited : List String) (held left right : String)
    (shape : faces witnessBoundary held = [left,right]) (no : has visited held = false)
    (leftLeaf : faces witnessBoundary left = []) (rightLeaf : faces witnessBoundary right = [])
    (leftFresh : has (visited ++ [held]) left = false) (rightFresh : has (visited ++ [held]) right = false) :
    DepthDerivation witnessBoundary visited held 2 := by
  change DepthDerivation witnessBoundary visited held (heightMaximum [1,1]+1)
  apply DepthDerivation.node visited held [1,1] (absentOfFalse visited held no)
  rw [shape]
  exact FaceDerivations.cons _ left 1 _ _ (leafDerivation _ _ _ leftLeaf leftFresh)
    (FaceDerivations.cons _ right 1 _ _ (leafDerivation _ _ _ rightLeaf rightFresh) (FaceDerivations.nil _))

theorem triangleDimension : cellDimension witnessCells witnessBoundary "triangle" = .ok 3 := by
  apply (dimensionIffDerivation witnessCells witnessBoundary "triangle" 3 rfl).mpr
  change DepthDerivation witnessBoundary [] "triangle" (heightMaximum [2,2]+1)
  apply DepthDerivation.node [] "triangle" [2,2] (absentOfFalse [] "triangle" rfl)
  change FaceDerivations witnessBoundary ["triangle"] ["pq","qr"] [2,2]
  exact FaceDerivations.cons _ "pq" 2 _ _ (edgeDerivation _ "pq" "p" "q" rfl rfl rfl rfl rfl rfl)
    (FaceDerivations.cons _ "qr" 2 _ _ (edgeDerivation _ "qr" "q" "r" rfl rfl rfl rfl rfl rfl) (FaceDerivations.nil _))

theorem edgeDimension : cellDimension witnessCells witnessBoundary "pq" = .ok 2 :=
  (dimensionIffDerivation witnessCells witnessBoundary "pq" 2 rfl).mpr
    (edgeDerivation [] "pq" "p" "q" rfl rfl rfl rfl rfl rfl)

theorem sourcePath : pathDistance ["a","b","c"] [("a","b"),("b","c")] "a" "c" = .ok (some ["a","b","c"]) := by
  let edges : Boundary := [("a","b"),("b","c")]
  let initial := initialPathState edges "a"
  let next := expandPathState edges initial ("a",["a"]) [] rfl
  change Except.ok (pathLoop edges "c" initial) = Except.ok (some ["a","b","c"])
  apply congrArg Except.ok
  rw [pathExpand edges "c" initial ("a",["a"]) [] rfl (by intro h; cases h) (by intro h; cases h)]
  exact pathHit edges "c" next ("b",["a","b"]) [] rfl (by intro h; cases h) rfl

structure Witness where
  name : String
  statement : String
  passed : Bool

def dimensionWitness : Bool :=
  (match cellDimension witnessCells witnessBoundary "triangle" with | .ok n => n == 3 | .error _ => false) &&
  (match cellDimension witnessCells witnessBoundary "pq" with | .ok n => n == 2 | .error _ => false)

theorem dimensionWitnessPassed : dimensionWitness = true := by
  unfold dimensionWitness
  rw [triangleDimension,edgeDimension]
  rfl

def pathWitness : Bool :=
  (match pathDistance ["a","b","c"] [("a","b"),("b","c")] "a" "c" with
    | .error _ => false
    | .ok result => match result with | none => false | some path => (path == ["a","b","c"])) &&
  (match pathDistance ["a","b"] [("a","b")] "a" "a" with
    | .error _ => false
    | .ok result => match result with | none => false | some path => (path == emptyOne))

theorem pathWitnessPassed : pathWitness = true := by
  unfold pathWitness
  rw [sourcePath,pathDistanceIdentity ["a","b"] [("a","b")] "a" rfl]
  rfl

def incidence : Witness := ⟨"incidence","Every witness face and cell belongs to the finite carrier.",incidenceWellFormed witnessCells witnessBoundary⟩

def dimensionDepth : Witness := ⟨"dimension-depth","The witness triangle has one more boundary layer than its edge.",dimensionWitness⟩

def adjacency : Witness := ⟨"adjacency","The two witness edges are adjacent exactly through their shared q face.",adjacent witnessBoundary "pq" "qr"⟩

def pathDistanceCheck : Witness := ⟨"path-distance","Shortest path retains a-to-b-to-c and identity returns empty One.",pathWitness⟩

def finiteTopologyCheck : Witness := ⟨"finite-topology","The complete two-point selection family is closed.",finiteTopology witnessPoints witnessOpens⟩

def continuity : Witness := ⟨"continuity","The identity map preserves every witness open by inverse image.",continuous witnessPoints witnessOpens witnessOpens [("a","a"),("b","b")]⟩

def witnesses : List Witness := [incidence,dimensionDepth,adjacency,pathDistanceCheck,finiteTopologyCheck,continuity]

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  change (true && (dimensionWitness && (true && (pathWitness && (true && (true && true)))))) = true
  rw [dimensionWitnessPassed,pathWitnessPassed]
  rfl

end SFT.Mathematics.GeometryWitnesses
