import SFT.Chemistry.ResonanceEquivalent
namespace SFT.Chemistry.ResonanceEquivalent
open SFT.Host SFT.Physics.CapabilityValues
theorem admittedEncodingUnchanged (value result : ExactMolecularEncoding)
 (accepted : validEncoding value = .ok result) : result = value := by
 unfold validEncoding at accepted
 cases h0 : (!Text.equal value.encoding.family "molecular-representation") with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
  cases h1 : (!Text.equal value.carrier.family "molecular-carrier") with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
   cases h2 : (value.atoms.length < 3 || !ElectronCountSpin.distinctLabels value.atoms) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
    cases h3 : (value.adjacency.length != value.fibres.length || value.adjacency.isEmpty) with
    | true => rw [h3] at accepted; cases accepted
    | false =>
     rw [h3] at accepted
     try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
     cases h4 : (value.adjacency.any (fun (left,right)=>!(value.atoms.any (ElectronCountSpin.sameLabel left)) || !(value.atoms.any (ElectronCountSpin.sameLabel right)) || ElectronCountSpin.sameLabel left right)) with
     | true => rw [h4] at accepted; cases accepted
     | false =>
      rw [h4] at accepted
      try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
      cases h5 : (!distinctEdges value.adjacency) with
      | true => rw [h5] at accepted; cases accepted
      | false =>
       rw [h5] at accepted
       try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
       cases h6 : (!(value.fibres.all (fun row=>Text.equal row.family "representation-support-fibre"))) with
       | true => rw [h6] at accepted; cases accepted
       | false =>
        rw [h6] at accepted
        try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
        exact (Except.ok.inj accepted).symm

theorem admittedPairUnchanged (pair result : ExactEquivalentRepresentationPair)
 (accepted : validPair pair = .ok result) : result = pair := by
 unfold validPair at accepted
 cases h0 : (!Text.equal pair.carrier.family "molecular-carrier") with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
  cases h1 : (!ElectronCountSpin.sameLabel pair.first.carrier pair.carrier || !ElectronCountSpin.sameLabel pair.second.carrier pair.carrier) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
   cases h2 : (ElectronCountSpin.sameLabel pair.first.encoding pair.second.encoding) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
    cases h3 : (!sameLabels pair.first.atoms pair.second.atoms) with
    | true => rw [h3] at accepted; cases accepted
    | false =>
     rw [h3] at accepted
     try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
     cases h4 : (!sameEdges pair.first.adjacency pair.second.adjacency) with
     | true => rw [h4] at accepted; cases accepted
     | false =>
      rw [h4] at accepted
      try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
      cases h5 : (sameLabels pair.first.fibres pair.second.fibres) with
      | true => rw [h5] at accepted; cases accepted
      | false =>
       rw [h5] at accepted
       try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
       cases hc : complementLabels pair.first.fibres with
       | error e => rw [hc] at accepted; cases accepted
       | ok complement =>
        rw [hc] at accepted
        try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
        cases hf : !sameLabels complement pair.second.fibres with
        | true => rw [hf] at accepted; cases accepted
        | false =>
         rw [hf] at accepted
         exact (Except.ok.inj accepted).symm

theorem admittedPairComplement (pair result : ExactEquivalentRepresentationPair)
 (accepted : validPair pair = .ok result) : ∃ complement, complementLabels pair.first.fibres = .ok complement ∧ sameLabels complement pair.second.fibres = true := by
 unfold validPair at accepted
 cases h0 : (!Text.equal pair.carrier.family "molecular-carrier") with
 | true => rw [h0] at accepted; cases accepted
 | false =>
  rw [h0] at accepted
  try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
  cases h1 : (!ElectronCountSpin.sameLabel pair.first.carrier pair.carrier || !ElectronCountSpin.sameLabel pair.second.carrier pair.carrier) with
  | true => rw [h1] at accepted; cases accepted
  | false =>
   rw [h1] at accepted
   try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
   cases h2 : (ElectronCountSpin.sameLabel pair.first.encoding pair.second.encoding) with
   | true => rw [h2] at accepted; cases accepted
   | false =>
    rw [h2] at accepted
    try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
    cases h3 : (!sameLabels pair.first.atoms pair.second.atoms) with
    | true => rw [h3] at accepted; cases accepted
    | false =>
     rw [h3] at accepted
     try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
     cases h4 : (!sameEdges pair.first.adjacency pair.second.adjacency) with
     | true => rw [h4] at accepted; cases accepted
     | false =>
      rw [h4] at accepted
      try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
      cases h5 : (sameLabels pair.first.fibres pair.second.fibres) with
      | true => rw [h5] at accepted; cases accepted
      | false =>
       rw [h5] at accepted
       try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
       cases hc : complementLabels pair.first.fibres with
       | error e => rw [hc] at accepted; cases accepted
       | ok complement =>
        rw [hc] at accepted
        try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
        cases hf : !sameLabels complement pair.second.fibres with
        | true => rw [hf] at accepted; cases accepted
        | false =>
         rw [hf] at accepted
         cases h : sameLabels complement pair.second.fibres with
         | false => rw [h] at hf; cases hf
         | true => exact ⟨complement,rfl,h⟩

theorem successfulSharedExtension (pair result : ExactEquivalentRepresentationPair) (label : String)
 (accepted : appendSharedSuccessor pair label = .ok result) :
 ∃ fresh firstLast secondLast firstNext secondNext : HeldLabel,
 atom label = .ok fresh ∧
 result.carrier = pair.carrier ∧
 result.first.encoding = pair.first.encoding ∧ result.second.encoding = pair.second.encoding ∧
 result.first.atoms = pair.first.atoms ++ [fresh] ∧
 result.second.atoms = pair.second.atoms ++ [fresh] ∧
 result.first.adjacency = pair.first.adjacency ++ [(firstLast,fresh)] ∧
 result.second.adjacency = pair.second.adjacency ++ [(secondLast,fresh)] ∧
 result.first.fibres = pair.first.fibres ++ [firstNext] ∧
 result.second.fibres = pair.second.fibres ++ [secondNext] ∧
 validPair result = .ok result := by
 unfold appendSharedSuccessor at accepted
 cases hfresh : atom label with
 | error e => rw [hfresh] at accepted; cases accepted
 | ok fresh =>
  rw [hfresh] at accepted
  try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
  cases duplicate : pair.first.atoms.any (ElectronCountSpin.sameLabel fresh) with
  | true => rw [duplicate] at accepted; cases accepted
  | false =>
   rw [duplicate] at accepted
   try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
   cases hfirstLast : ConjugatedSupport.lastFibre pair.first.atoms with
   | error e => rw [hfirstLast] at accepted; cases accepted
   | ok firstLast =>
    rw [hfirstLast] at accepted
    try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
    cases hsecondLast : ConjugatedSupport.lastFibre pair.second.atoms with
    | error e => rw [hsecondLast] at accepted; cases accepted
    | ok secondLast =>
     rw [hsecondLast] at accepted
     try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
     cases hfirstFibre : ConjugatedSupport.lastFibre pair.first.fibres with
     | error e => rw [hfirstFibre] at accepted; cases accepted
     | ok firstFibre =>
      rw [hfirstFibre] at accepted
      try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
      cases hfirstNext : fibre (if Text.equal firstFibre.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one") with
      | error e => rw [hfirstNext] at accepted; cases accepted
      | ok firstNext =>
       rw [hfirstNext] at accepted
       try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
       cases hsecondFibre : ConjugatedSupport.lastFibre pair.second.fibres with
       | error e => rw [hsecondFibre] at accepted; cases accepted
       | ok secondFibre =>
        rw [hsecondFibre] at accepted
        try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
        cases hsecondNext : fibre (if Text.equal secondFibre.label "fold-fibre-one" then "fold-fibre-two" else "fold-fibre-one") with
        | error e => rw [hsecondNext] at accepted; cases accepted
        | ok secondNext =>
         rw [hsecondNext] at accepted
         try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
         cases hfirst : validEncoding ⟨pair.first.encoding,pair.carrier,pair.first.atoms++[fresh],pair.first.adjacency++[(firstLast,fresh)],pair.first.fibres++[firstNext]⟩ with
         | error e => rw [hfirst] at accepted; cases accepted
         | ok first =>
          rw [hfirst] at accepted
          try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
          have eqfirst := admittedEncodingUnchanged _ _ hfirst
          cases eqfirst
          cases hsecond : validEncoding ⟨pair.second.encoding,pair.carrier,pair.second.atoms++[fresh],pair.second.adjacency++[(secondLast,fresh)],pair.second.fibres++[secondNext]⟩ with
          | error e => rw [hsecond] at accepted; cases accepted
          | ok second =>
           rw [hsecond] at accepted
           try dsimp only [Bind.bind, Pure.pure, Except.bind, Except.pure] at accepted
           have eqsecond := admittedEncodingUnchanged _ _ hsecond
           cases eqsecond
           have resultEq := admittedPairUnchanged _ _ accepted
           cases resultEq
           exact ⟨fresh,firstLast,secondLast,firstNext,secondNext,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,rfl,accepted⟩

#print axioms admittedPairComplement
#print axioms successfulSharedExtension
#print axioms admittedEncodingUnchanged
#print axioms admittedPairUnchanged
end SFT.Chemistry.ResonanceEquivalent
