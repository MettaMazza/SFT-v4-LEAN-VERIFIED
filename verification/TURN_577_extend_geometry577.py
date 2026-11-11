from pathlib import Path
p=Path('work/constants-recovery/SFT/Chemistry/MolecularGeometry.lean');s=p.read_text();a=s.index('def orientation :')
extra='''theorem uniqueMeaning (edges : List Edge) (edge : Edge) : edge ∈ unique edges ↔ edge ∈ edges := by
 induction edges with
 | nil => exact ⟨fun h => h,fun h => h⟩
 | cons first rest ih =>
   unfold unique
   split
   · rename_i exists
     have held := (hasIff _ _).mp exists
     constructor
     · intro h; exact .tail _ (ih.mp h)
     · intro h
       cases h with
       | head => exact held
       | tail _ tail => exact ih.mpr tail
   · constructor
     · intro h
       cases h with
       | head => exact .head _
       | tail _ tail => exact .tail _ (ih.mp tail)
     · intro h
       cases h with
       | head => exact .head _
       | tail _ tail => exact .tail _ (ih.mpr tail)

theorem requiredSuccessor (nodes : List String) (fresh : String) (edge : Edge) :
 edge ∈ required (nodes++[fresh]) ↔ edge ∈ required nodes ∨
 ∃ prior ∈ nodes, MolecularCarrier.normalizedEdge (prior,fresh)=edge := by
 constructor
 · intro member
   obtain ⟨pair,held,equal⟩ := memMapPreimage MolecularCarrier.normalizedEdge edge (pairs (nodes++[fresh])) ((uniqueMeaning _ _).mp member)
   cases (pairSuccessor nodes fresh pair).mp held with
   | inl old => exact .inl ((uniqueMeaning _ _).mpr (equal ▸ memMap _ _ _ old))
   | inr added =>
     obtain ⟨prior,held,same⟩ := memMapPreimage (fun prior => (prior,fresh)) pair nodes added
     cases same
     exact .inr ⟨prior,held,equal⟩
 · intro member
   apply (uniqueMeaning _ _).mpr
   cases member with
   | inl old =>
     obtain ⟨pair,held,equal⟩ := memMapPreimage MolecularCarrier.normalizedEdge edge (pairs nodes) ((uniqueMeaning _ _).mp old)
     exact equal ▸ memMap _ _ _ ((pairSuccessor nodes fresh pair).mpr (.inl held))
   | inr added =>
     obtain ⟨prior,held,equal⟩ := added
     exact equal ▸ memMap _ _ _ ((pairSuccessor nodes fresh (prior,fresh)).mpr (.inr (memMap _ _ _ held)))

'''
p.write_text(s[:a]+extra+s[a:])
