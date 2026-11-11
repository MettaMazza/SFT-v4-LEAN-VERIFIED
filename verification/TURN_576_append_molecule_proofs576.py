from pathlib import Path
p=Path('work/constants-recovery/SFT/Chemistry/MolecularCarrier.lean')
s=p.read_text(); marker='end SFT.Chemistry.MolecularCarrier'
addition='''theorem adjacentOccurrencePreservesConnectivity (first : String) (rest : List String)
 (edges : List Edge) (anchor fresh : String)
 (covered : ∀ edge ∈ edges, edge.1 ∈ first::rest ∧ edge.2 ∈ first::rest)
 (prior : connected (first::rest) edges=true) (anchorHeld : anchor ∈ first::rest) :
 connected ((first::rest)++[fresh]) (edges++[(anchor,fresh)])=true := by
 let newNodes := (first::rest)++[fresh]
 let newEdges := edges++[(anchor,fresh)]
 have newCovered : ∀ edge ∈ newEdges, edge.1 ∈ newNodes ∧ edge.2 ∈ newNodes := by
  intro edge held
  cases memAppendCases edge edges [(anchor,fresh)] held with
  | inl old => exact ⟨memAppendLeft _ _ _ (covered edge old).1,memAppendLeft _ _ _ (covered edge old).2⟩
  | inr added =>
    cases added with
    | head => exact ⟨memAppendLeft _ _ _ anchorHeld,memAppendRight _ _ _ (.head [])⟩
    | tail _ impossible => cases impossible
 have keepNodes : ∀ node ∈ helperNodes (first::rest) edges, node ∈ helperNodes newNodes newEdges := by
  intro node held
  exact memAppendLeft _ _ _ (memAppendLeft _ _ _ (helperNodesKnown _ _ covered node held))
 have keepEdges := MetallicNetwork.symmetricEdgesMonotone edges newEdges (fun edge held => memAppendLeft _ _ _ held)
 have oldPaths := connectedPaths first rest edges prior
 have retained : ∀ target ∈ first::rest, PathWitness (helperGraph newNodes newEdges) first target :=
  fun target held => retainedPathWitness _ _ keepNodes keepEdges _ _ (oldPaths target held)
 apply connectedFromPaths first (rest++[fresh]) newEdges
 · intro target held
   cases memAppendCases target (first::rest) [fresh] held with
   | inl old => exact retained target old
   | inr added =>
     cases added with
     | head => exact extendPathWitness _ _ _ _ (retained anchor anchorHeld)
        (memAppendLeft _ _ _ (memAppendRight _ _ _ (.head [])))
        (memAppendLeft _ _ _ (memAppendRight _ _ _ (.head [])))
     | tail _ impossible => cases impossible
 · intro target path
   exact helperNodesKnown newNodes newEdges newCovered target (pathWitnessTarget _ _ _ path)

def originalDiatomic : Raw :=
 ⟨["atom-occurrence-one","atom-occurrence-two"],["E","E"],[("atom-occurrence-one","atom-occurrence-two")],[]⟩

theorem originalDiatomicConnected : connected originalDiatomic.occurrences originalDiatomic.bonds=true := by
 apply connectedFromPaths
 · intro target held
   cases held with
   | head => exact ⟨[],by decide,rfl⟩
   | tail _ remaining =>
     cases remaining with
     | head => exact ⟨["atom-occurrence-one"],by decide,rfl⟩
     | tail _ impossible => cases impossible
 · intro target path
   apply helperNodesKnown _ _ _ target (pathWitnessTarget _ _ _ path)
   intro edge held
   cases held with
   | head => exact ⟨.head _,.tail _ (.head [])⟩
   | tail _ impossible => cases impossible

theorem originalDiatomicAdmitted : admit originalDiatomic=.ok originalDiatomic := by
 unfold admit
 rw [show basicFailure originalDiatomic=false from rfl]
 change (if connected originalDiatomic.occurrences originalDiatomic.bonds=false then _ else _)=_
 rw [originalDiatomicConnected]
 rfl

theorem originalDiatomicComposition : compositionSignature originalDiatomic=[("E",2)] := rfl

'''
p.write_text(s.replace(marker,addition+marker))
