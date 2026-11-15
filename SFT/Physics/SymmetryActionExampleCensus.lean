import SFT.Physics.SymmetryActionIndexArrangements
namespace SFT.Physics.SymmetryActionExampleCensus
open SymmetryActionIndexArrangements
private theorem consFlat {α β : Type} (f : α → List β) (x : α) (xs : List α) : (x::xs).flatMap f=f x++xs.flatMap f := rfl
private theorem nilFlat {α β : Type} (f : α → List β) : [].flatMap f=[] := rfl
theorem indices0 : arrangementsCore [0] = [[0]] := by
 rw [arrangementsSingle]
theorem indices1 : arrangementsCore [1] = [[1]] := by
 rw [arrangementsSingle]
theorem indices2 : arrangementsCore [2] = [[2]] := by
 rw [arrangementsSingle]
theorem indices3 : arrangementsCore [3] = [[3]] := by
 rw [arrangementsSingle]
theorem indices01 : arrangementsCore [0,1] = [[0,1],[1,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,1] 0=[1] from rfl,show remainder [0,1] 1=[0] from rfl]
 rw [indices1,indices0]
 rfl
theorem indices02 : arrangementsCore [0,2] = [[0,2],[2,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,2] 0=[2] from rfl,show remainder [0,2] 2=[0] from rfl]
 rw [indices2,indices0]
 rfl
theorem indices03 : arrangementsCore [0,3] = [[0,3],[3,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,3] 0=[3] from rfl,show remainder [0,3] 3=[0] from rfl]
 rw [indices3,indices0]
 rfl
theorem indices12 : arrangementsCore [1,2] = [[1,2],[2,1]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [1,2] 1=[2] from rfl,show remainder [1,2] 2=[1] from rfl]
 rw [indices2,indices1]
 rfl
theorem indices13 : arrangementsCore [1,3] = [[1,3],[3,1]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [1,3] 1=[3] from rfl,show remainder [1,3] 3=[1] from rfl]
 rw [indices3,indices1]
 rfl
theorem indices23 : arrangementsCore [2,3] = [[2,3],[3,2]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [2,3] 2=[3] from rfl,show remainder [2,3] 3=[2] from rfl]
 rw [indices3,indices2]
 rfl
theorem indices012 : arrangementsCore [0,1,2] = [[0,1,2],[0,2,1],[1,0,2],[1,2,0],[2,0,1],[2,1,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,1,2] 0=[1,2] from rfl,show remainder [0,1,2] 1=[0,2] from rfl,show remainder [0,1,2] 2=[0,1] from rfl]
 rw [indices12,indices02,indices01]
 rfl
theorem indices013 : arrangementsCore [0,1,3] = [[0,1,3],[0,3,1],[1,0,3],[1,3,0],[3,0,1],[3,1,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,1,3] 0=[1,3] from rfl,show remainder [0,1,3] 1=[0,3] from rfl,show remainder [0,1,3] 3=[0,1] from rfl]
 rw [indices13,indices03,indices01]
 rfl
theorem indices023 : arrangementsCore [0,2,3] = [[0,2,3],[0,3,2],[2,0,3],[2,3,0],[3,0,2],[3,2,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,2,3] 0=[2,3] from rfl,show remainder [0,2,3] 2=[0,3] from rfl,show remainder [0,2,3] 3=[0,2] from rfl]
 rw [indices23,indices03,indices02]
 rfl
theorem indices123 : arrangementsCore [1,2,3] = [[1,2,3],[1,3,2],[2,1,3],[2,3,1],[3,1,2],[3,2,1]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [1,2,3] 1=[2,3] from rfl,show remainder [1,2,3] 2=[1,3] from rfl,show remainder [1,2,3] 3=[1,2] from rfl]
 rw [indices23,indices13,indices12]
 rfl
theorem indices0123 : arrangementsCore [0,1,2,3] = [[0,1,2,3],[0,1,3,2],[0,2,1,3],[0,2,3,1],[0,3,1,2],[0,3,2,1],[1,0,2,3],[1,0,3,2],[1,2,0,3],[1,2,3,0],[1,3,0,2],[1,3,2,0],[2,0,1,3],[2,0,3,1],[2,1,0,3],[2,1,3,0],[2,3,0,1],[2,3,1,0],[3,0,1,2],[3,0,2,1],[3,1,0,2],[3,1,2,0],[3,2,0,1],[3,2,1,0]] := by
 rw [arrangementsStepByValues]
 simp only [consFlat,nilFlat]
 rw [show remainder [0,1,2,3] 0=[1,2,3] from rfl,show remainder [0,1,2,3] 1=[0,2,3] from rfl,show remainder [0,1,2,3] 2=[0,1,3] from rfl,show remainder [0,1,2,3] 3=[0,1,2] from rfl]
 rw [indices123,indices023,indices013,indices012]
 rfl
end SFT.Physics.SymmetryActionExampleCensus
