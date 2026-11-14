import SFT.Physics.DecayWidthBranchingLifetime
namespace SFT.Physics.DecayWidthBranchingLifetimeCertificate
open DecayWidthBranchingLifetime LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 closedChannel : List Rat
 sampleWidths : List Rat
 total : Rat
 parts : List Rat
 partition : Rat
 lifetime : Rat
 widthLifetimeVector : List (Rat × Rat)
 successorIncrements : List Rat
 successorPartitions : List Rat
 widerLifetimeTakes : List Rat
def formalCertificate : Except String Certificate := do
 let widths ← samplePartialWidths
 let parts ← branchingParts widths
 let successors := [normalize 1 8 (by decide),normalize 1 4 (by decide),normalize 1 2 (by decide),wholeRatio 1]
 pure ⟨closedChannel,widths,← totalTransitionWidth widths,parts,← completeBranchingPartition widths,
  ← lifetimeFromWidth (wholeRatio 1) (← totalTransitionWidth widths),
  ← [normalize 1 2 (by decide),wholeRatio 1,wholeRatio 2].mapM (fun width => do pure (width,← lifetimeFromWidth (wholeRatio 1) width)),
  ← successors.mapM (successorTotalIncrement widths),
  ← successors.mapM (fun successor => do completeBranchingPartition (← appendOpenChannel widths successor)),
  ← [(normalize 1 4 (by decide),normalize 1 2 (by decide)),(normalize 1 2 (by decide),wholeRatio 1),(wholeRatio 1,wholeRatio 2)].mapM (fun (a,b) => widerStateLifetimeTake (wholeRatio 1) a b)⟩
def partialWidthCarrierIsForced (v : String) : Except String Bool := do
 let observed ← partialTransitionWidth (normalize 1 2 (by decide)) (normalize 3 4 (by decide)) (wholeRatio 1)
 let expected ← if SFT.Host.Text.equal v "paired-transition-weight-times-output-support-per-action" then pure (normalize 3 16 (by decide))
  else if SFT.Host.Text.equal v "unpaired-transition-leg-times-output-support" then pure (normalize 3 8 (by decide))
  else if SFT.Host.Text.equal v "target-assigned-partial-width" then pure (wholeRatio 1)
  else throw "candidate names an ungenerated partial-width carrier"
 pure (observed==expected)
def channelDomainIsForced (v : String) : Except String Bool := do
 if SFT.Host.Text.equal v "positive-open-channels-closed-as-empty" then pure (closedChannel.isEmpty && (← samplePartialWidths).all (fun r => decide (1≤r.num)))
 else if SFT.Host.Text.equal v "numeric-null-closed-channels" || SFT.Host.Text.equal v "indistinguishable-overlapping-channel-list" then pure false
 else throw "candidate names an ungenerated channel domain"
def totalWidthLawIsForced (v : String) : Except String Bool := do
 let observed ← totalTransitionWidth (← samplePartialWidths)
 let expected ← if SFT.Host.Text.equal v "ordered-positive-sum-of-partial-widths" then pure (wholeRatio 2)
  else if SFT.Host.Text.equal v "largest-partial-width-only" then pure (normalize 5 4 (by decide))
  else if SFT.Host.Text.equal v "arithmetic-mean-of-partial-widths" then pure (normalize 2 3 (by decide))
  else throw "candidate names an ungenerated total-width law"
 pure (observed==expected)
def branchingLawIsForced (v : String) : Except String Bool := do
 let widths ← samplePartialWidths
 let observed ← branchingParts widths
 let expected ← if SFT.Host.Text.equal v "partial-width-over-total-width" then pure [normalize 1 8 (by decide),normalize 1 4 (by decide),normalize 5 8 (by decide)]
  else if SFT.Host.Text.equal v "total-width-over-partial-width" then pure [wholeRatio 8,wholeRatio 4,normalize 8 5 (by decide)]
  else if SFT.Host.Text.equal v "unnormalized-partial-width" then pure widths
  else throw "candidate names an ungenerated branching law"
 pure (observed==expected)
def partitionLawIsForced (v : String) : Except String Bool := do
 let parts ← branchingParts (← samplePartialWidths)
 let whole ← completeBranchingPartition (← samplePartialWidths)
 let incomplete ← totalTransitionWidth (parts.take (parts.length-1))
 let overlapping ← totalTransitionWidth (parts++[← LeptonRatios.atIndex parts 0])
 if SFT.Host.Text.equal v "complete-exclusive-partition-of-one" then pure (whole==wholeRatio 1)
 else if SFT.Host.Text.equal v "incomplete-open-channel-subset" then pure (incomplete==wholeRatio 1)
 else if SFT.Host.Text.equal v "overlapping-double-counted-channels" then pure (overlapping==wholeRatio 1)
 else throw "candidate names an ungenerated branching partition"
def lifetimeLawIsForced (v : String) : Except String Bool := do
 let observed ← lifetimeFromWidth (wholeRatio 1) (wholeRatio 2)
 let expected ← if SFT.Host.Text.equal v "action-over-total-width" then pure (normalize 1 2 (by decide))
  else if SFT.Host.Text.equal v "total-width-over-action" || SFT.Host.Text.equal v "action-times-total-width" then pure (wholeRatio 2)
  else throw "candidate names an ungenerated lifetime law"
 pure (observed==expected)
def orderingLawIsForced (v : String) : Except String Bool := do
 let vector := (← formalCertificate).widthLifetimeVector
 let adjacent := vector.zip (vector.drop 1)
 if SFT.Host.Text.equal v "greater-width-shorter-lifetime" then pure (adjacent.all (fun ((lw,lt),(rw,rt)) => lw.blt rw && rt.blt lt))
 else if SFT.Host.Text.equal v "greater-width-longer-lifetime" then pure (adjacent.all (fun ((_,lt),(_,rt)) => lt.blt rt))
 else if SFT.Host.Text.equal v "width-independent-lifetime" then pure ((vector.map Prod.snd).eraseDups.length==1)
 else throw "candidate names an ungenerated width-lifetime ordering"
def targetBoundaryIsForced (v : String) : Except String Bool :=
 if SFT.Host.Text.equal v "sealed-before-release" then .ok true else if SFT.Host.Text.equal v "readable-before-seal" then .ok false else .error "candidate names an ungenerated target boundary"
def extensionIsForced (v : String) : Except String Bool :=
 if SFT.Host.Text.equal v "empty-extension" then .ok true else if SFT.Host.Text.equal v "free-correction" then .ok false else .error "candidate names an ungenerated extension"
end SFT.Physics.DecayWidthBranchingLifetimeCertificate
