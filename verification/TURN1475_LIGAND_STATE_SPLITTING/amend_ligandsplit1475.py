from pathlib import Path
p=Path('work/turn1064_recovery/SFT/Chemistry/LigandStateSplitting.lean');s=p.read_text();a=s.index('def sameSupport');b=s.index('def forced',a);eq=s[a:b];s=s[:a]+s[b:];a=s.index('def support');s=s[:a]+eq+'''def distinctSupports : List Support → Bool
 | [] => true
 | first::rest => !(rest.any (sameSupport first)) && distinctSupports rest
'''+s[a:]
s=s.replace(' return contrasts++pairs',''' let result := contrasts++pairs
 let identities := result.map Support.identity
 let unique := identities.foldl (fun seen h => if seen.any (fun k => Text.equal h.family k.family && Text.equal h.label k.label) then seen else seen++[h]) []
 if result.length != 5 || unique.length != 5 then
  throw "generator three and boundary rank two must produce five supports"
 return result''')
a=s.index('def addSupport');s=s[:a]+'''def level (rank : Rank) (members : List Support) : Except String Level := do
 if members.isEmpty || !distinctSupports members then
  throw "a split level requires positive distinct member support"
 return ⟨rank,members⟩
'''+s[a:]
a=s.index('def adjacent');s=s[:a]+'''def splitting (centre : HeldLabel) (unperturbed : PositiveCount) (levels : List Level)
 (separations : List Part) (lower upper : Distance) (preserved : Bool) : Except String Splitting := do
 if levels.isEmpty then throw "splitting requires at least one retained level"
 if (levels.map (fun l => l.members.length)).foldl Nat.add 0 != unperturbed.value then
  throw "splitting must preserve every unperturbed component"
 if separations.length+1 != levels.length then
  throw "every adjacent split pair requires one exact separation"
 let binary := levels.length==2
 if binary then
  match lower,upper with
  | .part low,.part high =>
   let lowWidth := (levels.headD ⟨.absent,[]⟩).members.length
   let highWidth := ((levels.drop 1).headD ⟨.absent,[]⟩).members.length
   if lowWidth*low.numerator.value*high.denominator.value != highWidth*high.numerator.value*low.denominator.value then
    throw "two-level splitting must preserve the unsplit balance exactly"
  | .absent,.absent | .absent,.part _ | .part _,.absent =>
   throw "a two-level split requires both positive balance distances"
 else
  match lower,upper with
  | .absent,.absent => pure ()
  | .part _,.absent | .absent,.part _ | .part _,.part _ =>
   throw "non-binary splitting retains no invented pair-balance distance"
 return ⟨centre,unperturbed,levels,separations,lower,upper,preserved⟩
'''+s[a:]
s=s.replace(' let levels := sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])',' let grouped := sortedLevels (supports.foldl (fun groups s => addSupport s (interactionRank s g) groups) [])\n let levels ← grouped.mapM (fun row => level row.rank row.members)')
s=s.replace(' return ⟨g.centre,← count supports.length,levels,separations,lower,upper,',' splitting g.centre (← count supports.length) levels separations lower upper (').replace('members.all (fun s => supports.any (sameSupport s))⟩','members.all (fun s => supports.any (sameSupport s)))')
s=s.replace(' return ⟨centre,⟨5,by decide⟩,[⟨.absent,supports⟩],[],.absent,.absent,true⟩',' splitting centre ⟨5,by decide⟩ [← level .absent supports] [] .absent .absent true')
p.write_text(s)
