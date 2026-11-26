import SFT.Chemistry.TransitionBoundary
namespace SFT.Chemistry.CompetingChannel
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev CountInput := SolvationDissolution.CountInput
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
structure ProductChannelSupport where
 channelIdentity : HeldLabel
 support : Height
 sourceRow : PositiveCount
def makeChannel (identity : LabelInput) (support : Height) (source : CountInput) : Except String ProductChannelSupport := do
 let identity ← match identity with
  | .held l=>if Text.equal l.family "registered-product-channel" then pure l else throw "branching relation requires registered product-channel identity"
  | .other=>throw "branching relation requires registered product-channel identity"
 if !validHeight support then throw "branching relation requires positive support or structural EmptyOne"
 let source ← match source with
  | .count n=>pure n
  | .other=>throw "branching relation requires positive source-row identity"
 pure ⟨identity,support,source⟩
inductive ChannelInput where
 | channel (value : ProductChannelSupport)
 | other
structure CompleteChannelRecord where
 reactionIdentity : HeldLabel
 conditionIdentity : HeldLabel
 orderedChannels : List ProductChannelSupport
def makeRecord (reaction condition : LabelInput) (channels : List ChannelInput) : Except String CompleteChannelRecord := do
 let reaction ← match reaction with
  | .held l=>if Text.equal l.family "registered-reaction" then pure l else throw "branching relation requires registered reaction identity"
  | .other=>throw "branching relation requires registered reaction identity"
 let condition ← match condition with
  | .held l=>if Text.equal l.family "held-condition" then pure l else throw "branching relation requires held condition identity"
  | .other=>throw "branching relation requires held condition identity"
 if channels.length<2 then throw "branching relation requires complete competing-channel word"
 let rows ← channels.mapM fun row=>match row with
  | .channel row=>pure row
  | .other=>throw "branching relation requires complete competing-channel word"
 let identities := rows.map ProductChannelSupport.channelIdentity
 if (identities.foldl (fun found x=>if found.any (equalLabel x) then found else found++[x]) []).length != rows.length then
  throw "branching relation duplicates product-channel identity"
 if !(rows.zipIdx.all fun (row,i)=>row.sourceRow.value==i+1) then
  throw "branching relation requires complete source order without a gap"
 if !(rows.any fun row=>match row.support with | .ratio _=>true | .emptyOne | .otherEmptyOne _ | .invalid=>false) then
  throw "branching relation requires positive complete support"
 pure ⟨reaction,condition,rows⟩
structure ExactBranchRow where
 channelIdentity : HeldLabel
 sourceRow : PositiveCount
 retainedSupport : Height
 shareOfCompleteSupport : Height
structure ExactBranchingRelation where
 reactionIdentity : HeldLabel
 conditionIdentity : HeldLabel
 completeSupport : Ratio
 orderedRows : List ExactBranchRow
 wholeIdentity : HeldLabel
inductive RecordInput where
 | record (value : CompleteChannelRecord)
 | other
def ratioValue (r : Ratio) : Rat :=
 LeptonIntervals.normalize (.ofNat r.numerator.value) r.denominator.value r.denominator.positive
def supportSum (supports : List Height) : Rat :=
 supports.foldl (fun total value=>match value with
  | .ratio r=>LeptonIntervals.add total (ratioValue r)
  | .emptyOne | .otherEmptyOne _ | .invalid=>total) (LeptonIntervals.normalize 0 1 (by decide))
def forcedCompetingChannelBranching (input : RecordInput) : Except String ExactBranchingRelation := do
 let record ← match input with
  | .record r=>pure r
  | .other=>throw "branching relation requires one complete channel record"
 let total := supportSum (record.orderedChannels.map ProductChannelSupport.support)
 if !(@decide (0<total.num) (Int.decLt _ _)) then throw "branching relation requires positive complete support"
 let complete ← SolvationDissolution.positiveRatio total
 let rows ← record.orderedChannels.mapM fun row=>do
  let share ← match row.support with
   | .ratio r=>do
    let n := r.numerator.value*complete.denominator.value
    let d := r.denominator.value*complete.numerator.value
    let d ← count d
    let normalized := LeptonIntervals.normalize (.ofNat n) d.value d.positive
    pure (Height.ratio (← SolvationDissolution.positiveRatio normalized))
   | .emptyOne | .otherEmptyOne _ | .invalid=>pure Height.emptyOne
  pure (ExactBranchRow.mk row.channelIdentity row.sourceRow row.support share)
 let sum := supportSum (rows.map ExactBranchRow.shareOfCompleteSupport)
 if !(@decide (sum.num=.ofNat sum.den) (Int.decEq _ _)) then
  throw "complete retained channel partition does not reconstruct One"
 pure ⟨record.reactionIdentity,record.conditionIdentity,complete,rows,
  ⟨"complete-channel-whole","all-registered-product-support-reconstructs-One",rfl,rfl⟩⟩
def completeChannelAppendPreservesPriorRows (record : CompleteChannelRecord) (successor : ProductChannelSupport) : Except String Bool := do
 if successor.sourceRow.value != record.orderedChannels.length+1 then
  throw "channel successor must be the next complete source row"
 let extended ← makeRecord (.held record.reactionIdentity) (.held record.conditionIdentity)
  ((record.orderedChannels++[successor]).map ChannelInput.channel)
 let prior ← forcedCompetingChannelBranching (.record record)
 let result ← forcedCompetingChannelBranching (.record extended)
 let retained := result.orderedRows.take prior.orderedRows.length
 pure (retained.length==prior.orderedRows.length && (retained.zip prior.orderedRows).all fun (a,b)=>
  equalLabel a.channelIdentity b.channelIdentity && equalHeight a.retainedSupport b.retainedSupport)
def witnessRecord (values : List (Option Nat)) : Except String CompleteChannelRecord := do
 let channels ← values.zipIdx.mapM fun (v,i)=>do
  let identity ← heldLabel "registered-product-channel" (Text.append "product-" (toString (i+1)))
  let source ← count (i+1)
  let support ← match v with
   | none=>pure Height.emptyOne
   | some n=>do
    let n ← count n
    pure (Height.ratio ⟨n,⟨1,by decide⟩⟩)
  pure (ChannelInput.channel (← makeChannel (.held identity) support (.count source)))
 makeRecord (.held ⟨"registered-reaction","competing-products",rfl,rfl⟩)
  (.held ⟨"held-condition","condition-a",rfl,rfl⟩) channels
def exactShareWitness : Except String Bool := do
 let result ← forcedCompetingChannelBranching (.record (← witnessRecord [some 2,some 3]))
 pure (match result.orderedRows.map ExactBranchRow.shareOfCompleteSupport with
  | [.ratio a,.ratio b]=>a.numerator.value==2 && a.denominator.value==5 && b.numerator.value==3 && b.denominator.value==5
  | [] | [_] | _::_::_::_=>false
  | [.emptyOne,_] | [.otherEmptyOne _,_] | [.invalid,_] | [.ratio _,.emptyOne] | [.ratio _,.otherEmptyOne _] | [.ratio _,.invalid]=>false)
def wholeWitness : Except String Bool := do
 let result ← forcedCompetingChannelBranching (.record (← witnessRecord [some 2,some 3]))
 let sum := supportSum (result.orderedRows.map ExactBranchRow.shareOfCompleteSupport)
 pure (@decide (sum.num=.ofNat sum.den) (Int.decEq _ _))
def unfavorableWitness : Except String Bool := do
 let result ← forcedCompetingChannelBranching (.record (← witnessRecord [some 2,none,some 3]))
 pure (match result.orderedRows.drop 1 with | row::_=>equalHeight row.shareOfCompleteSupport .emptyOne | []=>false)
def successorWitness : Except String Bool := do
 let record ← witnessRecord [some 2,some 3]
 let successor ← makeChannel (.held ⟨"registered-product-channel","product-3",rfl,rfl⟩)
  (.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩) (.count ⟨3,by decide⟩)
 completeChannelAppendPreservesPriorRows record successor
theorem exactShares : exactShareWitness=.ok true := rfl
theorem reconstructsOne : wholeWitness=.ok true := rfl
theorem retainedAbsentChannel : unfavorableWitness=.ok true := rfl
theorem retainedSuccessorSupport : successorWitness=.ok true := rfl
end SFT.Chemistry.CompetingChannel
