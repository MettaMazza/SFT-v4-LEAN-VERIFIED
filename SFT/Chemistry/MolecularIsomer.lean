import SFT.Chemistry.MolecularGeometry
import SFT.Mathematics.ArrangementCompleteness
namespace SFT.Chemistry.MolecularIsomer
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GraphOperations
open SFT.Mathematics.CombinatorialArrangements
open SFT.Foundation.Count.TraceDerivation
abbrev Raw := MolecularCarrier.Raw

def lookup (key : String) : List (String × String) → String
 | [] => ""
 | first::rest => if key=first.1 then first.2 else lookup key rest

def edgeSet (raw : Raw) := MolecularGeometry.unique (raw.bonds.map MolecularCarrier.normalizedEdge)
def mapping (left : Raw) (order : List String) := left.occurrences.zip order

def respectsElements (left right : Raw) (order : List String) : Bool :=
 left.occurrences.all (fun node => decide
  (lookup node (left.occurrences.zip left.elements)=
   lookup (lookup node (mapping left order)) (right.occurrences.zip right.elements)))

def mappedEdges (left : Raw) (order : List String) := MolecularGeometry.unique
 ((edgeSet left).map (fun edge => MolecularCarrier.normalizedEdge
  (lookup edge.1 (mapping left order),lookup edge.2 (mapping left order))))

def candidateMatches (left right : Raw) (order : List String) : Bool :=
 respectsElements left right order && MolecularGeometry.sameSet (mappedEdges left order) (edgeSet right)

def structurallyEquivalent (left right : Raw) : Bool :=
 if MolecularCarrier.compositionSignature left = MolecularCarrier.compositionSignature right then
  (arrangementsCore right.occurrences).any (candidateMatches left right)
 else false

def molecularIsomers (left right : Raw) : Bool :=
 decide (MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right) &&
 !structurallyEquivalent left right

theorem candidateMeaning (left right : Raw) (order : List String) :
 candidateMatches left right order=true ↔ respectsElements left right order=true ∧
 (∀ edge ∈ mappedEdges left order, edge ∈ edgeSet right) ∧
 (∀ edge ∈ edgeSet right, edge ∈ mappedEdges left order) := by
 constructor
 · intro passed
   have both := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp passed
   exact ⟨both.1,(MolecularGeometry.sameSetMeaning _ _).mp both.2⟩
 · intro both
   exact (SFT.Mathematics.GeometryTopology.andTrue _ _).mpr ⟨both.1,(MolecularGeometry.sameSetMeaning _ _).mpr both.2⟩

theorem equivalenceExactlyGeneratedMatch (left right : Raw) : structurallyEquivalent left right=true ↔
 MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right ∧
 ∃ order ∈ arrangementsCore right.occurrences, candidateMatches left right order=true := by
 unfold structurallyEquivalent
 split
 · rename_i equal
   constructor
   · intro yes; exact ⟨equal,(anyTrueWitness _ _).mp yes⟩
   · intro yes; exact (anyTrueWitness _ _).mpr yes.2
 · rename_i unequal
   constructor
   · intro impossible; cases impossible
   · intro yes; exact False.elim (unequal yes.1)

theorem completeRelabellingSearch (left right : Raw)
 (nonempty : right.occurrences ≠ []) (distinctNames : distinct right.occurrences=true) :
 structurallyEquivalent left right=true ↔
 MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right ∧
 ∃ order, List.Perm order right.occurrences ∧ candidateMatches left right order=true := by
 constructor
 · intro yes
   have both := (equivalenceExactlyGeneratedMatch left right).mp yes
   obtain ⟨order,held,matchFound⟩ := both.2
   exact ⟨both.1,order,everyArrangementPermutesCarrier _ distinctNames _ held,matchFound⟩
 · intro yes
   obtain ⟨order,perm,matchFound⟩ := yes.2
   exact (equivalenceExactlyGeneratedMatch left right).mpr
    ⟨yes.1,order,everyPermutationGenerated _ nonempty distinctNames _ perm,matchFound⟩

theorem isomersHaveEqualComposition (left right : Raw) (yes : molecularIsomers left right=true) :
 MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right :=
 of_decide_eq_true ((SFT.Mathematics.GeometryTopology.andTrue _ _).mp yes).1

theorem unequalCompositionRejected (left right : Raw)
 (unequal : MolecularCarrier.compositionSignature left≠MolecularCarrier.compositionSignature right) :
 structurallyEquivalent left right=false := by unfold structurallyEquivalent; rw [ite_eq_right unequal]

theorem retainedMismatchRejects (left right : Raw)
 (mismatch : ∀ order ∈ arrangementsCore right.occurrences, candidateMatches left right order=false) :
 structurallyEquivalent left right=false := by
 cases result : structurallyEquivalent left right with
 | false => rfl
 | true =>
   obtain ⟨order,held,matched⟩ := ((equivalenceExactlyGeneratedMatch left right).mp result).2
   rw [mismatch order held] at matched
   cases matched

theorem matchedExtensionPreservesMultiplicity (left right : List String) (added : List String)
 (same : ∀ label, MolecularCarrier.labelCount label left=MolecularCarrier.labelCount label right) :
 ∀ label, MolecularCarrier.labelCount label (left++added)=MolecularCarrier.labelCount label (right++added) := by
 intro label
 rw [MolecularCarrier.labelCountAppend,MolecularCarrier.labelCountAppend,same label]


theorem branchOrdersw : arrangementsCore ["w"]=[["w"]] := by
 exact arrangementsSingle _

theorem branchOrdersx : arrangementsCore ["x"]=[["x"]] := by
 exact arrangementsSingle _

theorem branchOrdersy : arrangementsCore ["y"]=[["y"]] := by
 exact arrangementsSingle _

theorem branchOrdersz : arrangementsCore ["z"]=[["z"]] := by
 exact arrangementsSingle _

theorem branchOrderswx : arrangementsCore ["w","x"]=[["w","x"],["x","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["x"]).map (List.cons "w") ++ ((arrangementsCore ["w"]).map (List.cons "x") ++ ([])) = [["w","x"],["x","w"]]
 rw [branchOrdersx,branchOrdersw]
 rfl

theorem branchOrderswy : arrangementsCore ["w","y"]=[["w","y"],["y","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["y"]).map (List.cons "w") ++ ((arrangementsCore ["w"]).map (List.cons "y") ++ ([])) = [["w","y"],["y","w"]]
 rw [branchOrdersy,branchOrdersw]
 rfl

theorem branchOrderswz : arrangementsCore ["w","z"]=[["w","z"],["z","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["z"]).map (List.cons "w") ++ ((arrangementsCore ["w"]).map (List.cons "z") ++ ([])) = [["w","z"],["z","w"]]
 rw [branchOrdersz,branchOrdersw]
 rfl

theorem branchOrdersxy : arrangementsCore ["x","y"]=[["x","y"],["y","x"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["y"]).map (List.cons "x") ++ ((arrangementsCore ["x"]).map (List.cons "y") ++ ([])) = [["x","y"],["y","x"]]
 rw [branchOrdersy,branchOrdersx]
 rfl

theorem branchOrdersxz : arrangementsCore ["x","z"]=[["x","z"],["z","x"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["z"]).map (List.cons "x") ++ ((arrangementsCore ["x"]).map (List.cons "z") ++ ([])) = [["x","z"],["z","x"]]
 rw [branchOrdersz,branchOrdersx]
 rfl

theorem branchOrdersyz : arrangementsCore ["y","z"]=[["y","z"],["z","y"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["z"]).map (List.cons "y") ++ ((arrangementsCore ["y"]).map (List.cons "z") ++ ([])) = [["y","z"],["z","y"]]
 rw [branchOrdersz,branchOrdersy]
 rfl

theorem branchOrderswxy : arrangementsCore ["w","x","y"]=[["w","x","y"],["w","y","x"],["x","w","y"],["x","y","w"],["y","w","x"],["y","x","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["x","y"]).map (List.cons "w") ++ ((arrangementsCore ["w","y"]).map (List.cons "x") ++ ((arrangementsCore ["w","x"]).map (List.cons "y") ++ ([]))) = [["w","x","y"],["w","y","x"],["x","w","y"],["x","y","w"],["y","w","x"],["y","x","w"]]
 rw [branchOrdersxy,branchOrderswy,branchOrderswx]
 rfl

theorem branchOrderswxz : arrangementsCore ["w","x","z"]=[["w","x","z"],["w","z","x"],["x","w","z"],["x","z","w"],["z","w","x"],["z","x","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["x","z"]).map (List.cons "w") ++ ((arrangementsCore ["w","z"]).map (List.cons "x") ++ ((arrangementsCore ["w","x"]).map (List.cons "z") ++ ([]))) = [["w","x","z"],["w","z","x"],["x","w","z"],["x","z","w"],["z","w","x"],["z","x","w"]]
 rw [branchOrdersxz,branchOrderswz,branchOrderswx]
 rfl

theorem branchOrderswyz : arrangementsCore ["w","y","z"]=[["w","y","z"],["w","z","y"],["y","w","z"],["y","z","w"],["z","w","y"],["z","y","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["y","z"]).map (List.cons "w") ++ ((arrangementsCore ["w","z"]).map (List.cons "y") ++ ((arrangementsCore ["w","y"]).map (List.cons "z") ++ ([]))) = [["w","y","z"],["w","z","y"],["y","w","z"],["y","z","w"],["z","w","y"],["z","y","w"]]
 rw [branchOrdersyz,branchOrderswz,branchOrderswy]
 rfl

theorem branchOrdersxyz : arrangementsCore ["x","y","z"]=[["x","y","z"],["x","z","y"],["y","x","z"],["y","z","x"],["z","x","y"],["z","y","x"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["y","z"]).map (List.cons "x") ++ ((arrangementsCore ["x","z"]).map (List.cons "y") ++ ((arrangementsCore ["x","y"]).map (List.cons "z") ++ ([]))) = [["x","y","z"],["x","z","y"],["y","x","z"],["y","z","x"],["z","x","y"],["z","y","x"]]
 rw [branchOrdersyz,branchOrdersxz,branchOrdersxy]
 rfl

theorem branchOrderswxyz : arrangementsCore ["w","x","y","z"]=[["w","x","y","z"],["w","x","z","y"],["w","y","x","z"],["w","y","z","x"],["w","z","x","y"],["w","z","y","x"],["x","w","y","z"],["x","w","z","y"],["x","y","w","z"],["x","y","z","w"],["x","z","w","y"],["x","z","y","w"],["y","w","x","z"],["y","w","z","x"],["y","x","w","z"],["y","x","z","w"],["y","z","w","x"],["y","z","x","w"],["z","w","x","y"],["z","w","y","x"],["z","x","w","y"],["z","x","y","w"],["z","y","w","x"],["z","y","x","w"]] := by
 rw [arrangementsStepByValues]
 change (arrangementsCore ["x","y","z"]).map (List.cons "w") ++ ((arrangementsCore ["w","y","z"]).map (List.cons "x") ++ ((arrangementsCore ["w","x","z"]).map (List.cons "y") ++ ((arrangementsCore ["w","x","y"]).map (List.cons "z") ++ ([])))) = [["w","x","y","z"],["w","x","z","y"],["w","y","x","z"],["w","y","z","x"],["w","z","x","y"],["w","z","y","x"],["x","w","y","z"],["x","w","z","y"],["x","y","w","z"],["x","y","z","w"],["x","z","w","y"],["x","z","y","w"],["y","w","x","z"],["y","w","z","x"],["y","x","w","z"],["y","x","z","w"],["y","z","w","x"],["y","z","x","w"],["z","w","x","y"],["z","w","y","x"],["z","x","w","y"],["z","x","y","w"],["z","y","w","x"],["z","y","x","w"]]
 rw [branchOrdersxyz,branchOrderswyz,branchOrderswxz,branchOrderswxy]
 rfl

def originalChain : Raw := ⟨["a","b","c","d"],["E","E","E","E"],[("a","b"),("b","c"),("c","d")],[]⟩
def originalBranch : Raw := ⟨["w","x","y","z"],["E","E","E","E"],[("w","x"),("w","y"),("w","z")],[]⟩
theorem originalSameComposition : MolecularCarrier.compositionSignature originalChain=MolecularCarrier.compositionSignature originalBranch := rfl

theorem originalChainBranchDistinct : structurallyEquivalent originalChain originalBranch=false := by
 unfold structurallyEquivalent
 rw [ite_eq_left originalSameComposition]
 change (arrangementsCore ["w","x","y","z"]).any (candidateMatches originalChain originalBranch)=false
 rw [branchOrderswxyz]
 rfl

theorem originalIsomerPair : molecularIsomers originalChain originalBranch=true := by
 unfold molecularIsomers
 rw [originalChainBranchDistinct]
 rfl

theorem originalSelfEquivalent : structurallyEquivalent originalChain originalChain=true := by
 apply (completeRelabellingSearch _ _ (by intro h; cases h) (by decide)).mpr
 exact ⟨rfl,originalChain.occurrences,List.Perm.refl _,by decide⟩
def originalRelabelledChain : Raw := ⟨["q","r","s","t"],["E","E","E","E"],[("q","r"),("r","s"),("s","t")],[]⟩
theorem originalRelabelledEquivalent : structurallyEquivalent originalChain originalRelabelledChain=true := by
 apply (completeRelabellingSearch _ _ (by intro h; cases h) (by decide)).mpr
 exact ⟨rfl,originalRelabelledChain.occurrences,List.Perm.refl _,by decide⟩
theorem unmatchedBondRejects (left right : Raw) (order : List String)
 (mismatch : respectsElements left right order=false ∨
  (∃ edge ∈ mappedEdges left order, ¬edge∈edgeSet right) ∨
  (∃ edge ∈ edgeSet right, ¬edge∈mappedEdges left order)) :
 candidateMatches left right order=false := by
 cases result : candidateMatches left right order with
 | false => rfl
 | true =>
   have complete := (candidateMeaning left right order).mp result
   cases mismatch with
   | inl labels => rw [labels] at complete; cases complete.1
   | inr bonds =>
     cases bonds with
     | inl extra =>
       obtain ⟨edge,held,absent⟩ := extra
       exact False.elim (absent (complete.2.1 edge held))
     | inr missing =>
       obtain ⟨edge,held,absent⟩ := missing
       exact False.elim (absent (complete.2.2 edge held))

theorem retainedDistinctionUnderMatchedExtension (left right : Raw)
 (same : MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right)
 (unmatched : ∀ order ∈ arrangementsCore right.occurrences,
  respectsElements left right order=false ∨
  (∃ edge ∈ mappedEdges left order, ¬edge∈edgeSet right) ∨
  (∃ edge ∈ edgeSet right, ¬edge∈mappedEdges left order)) :
 molecularIsomers left right=true := by
 have rejected := retainedMismatchRejects left right
  (fun order held => unmatchedBondRejects left right order (unmatched order held))
 unfold molecularIsomers
 rw [rejected]
 have composition : decide (MolecularCarrier.compositionSignature left=MolecularCarrier.compositionSignature right)=true := decide_eq_true same
 rw [composition]
 rfl
-- MOLECULAR_STRUCTURE_BLUEPRINTS[2] also retains held-orientation signatures.
-- The signature is the existing GeometryRelation record, including its orientation.
theorem differentOrientationDistinguishesRecord (left right : MolecularGeometry.Relation)
 (different : left.orientation≠right.orientation) :
 MolecularGeometry.relativeRecord left≠MolecularGeometry.relativeRecord right := by
 intro equal
 exact different (congrArg (fun row => row.2.2) equal)

theorem retainedOrientationExcludesEveryRelabelling
 (carrier : List String) (nonempty : carrier≠[]) (unique : distinct carrier=true)
 (leftRecord rightRecord : List String → MolecularGeometry.Relation)
 (retained : ∀ order, List.Perm order carrier →
  (leftRecord order).orientation≠(rightRecord order).orientation) :
 ∀ order ∈ arrangementsCore carrier,
 MolecularGeometry.relativeRecord (leftRecord order)≠MolecularGeometry.relativeRecord (rightRecord order) := by
 intro order held
 exact differentOrientationDistinguishesRecord _ _
  (retained order (everyArrangementPermutesCarrier carrier unique order held))
end SFT.Chemistry.MolecularIsomer
