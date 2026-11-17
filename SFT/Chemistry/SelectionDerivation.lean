import SFT.Chemistry.SelectionRule
namespace SFT.Chemistry.SelectionDerivation
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.SelectionRule

-- SelectionRecord.__post_init__: every accepted DIRECT record obeys its
-- original observation predicate, for arbitrary retained signatures and record.
theorem acceptedDirectSound (initial terminal : StateSignature) (record : HeldLabel)
 (out : SelectionRecord Unit)
 (accepted : constructRecord (some initial) (some terminal) direct .emptyOne record = .ok out) :
 directObservationAllowed initial terminal = true := by
 change (if !Text.equal record.family "selection-record" then
  Except.error "selection result requires its exact observation record"
  else if !directObservationAllowed initial terminal then
   Except.error "closed distinction cannot pass as a direct observation"
  else Except.ok (SelectionRecord.mk (some initial) (some terminal) direct Mediator.emptyOne record)) = .ok out at accepted
 cases family : Text.equal record.family "selection-record" with
 | false => rw [family] at accepted; cases accepted
 | true =>
  rw [family] at accepted
  cases allowed : directObservationAllowed initial terminal with
  | false => rw [allowed] at accepted; cases accepted
  | true => rfl

theorem acceptedDirectMultiplicity (initial terminal : StateSignature) (record : HeldLabel)
 (out : SelectionRecord Unit)
 (accepted : constructRecord (some initial) (some terminal) direct .emptyOne record = .ok out) :
 initial.multiplicity.value = terminal.multiplicity.value :=
 directRetainsMultiplicity initial terminal (acceptedDirectSound initial terminal record out accepted)

theorem acceptedDirectAxis (initial terminal : StateSignature) (record : HeldLabel)
 (out : SelectionRecord Unit)
 (accepted : constructRecord (some initial) (some terminal) direct .emptyOne record = .ok out) :
 (axisNeighbours.any fun p => Text.equal p.1 initial.axis.label && Text.equal p.2 terminal.axis.label) = true :=
 directAxisNeighbour initial terminal (acceptedDirectSound initial terminal record out accepted)

theorem acceptedDirectInversion (initial terminal : StateSignature) (record : HeldLabel)
 (out : SelectionRecord Unit)
 (known : ((Text.equal initial.inversion.label "g" || Text.equal initial.inversion.label "u") &&
 (Text.equal terminal.inversion.label "g" || Text.equal terminal.inversion.label "u")) = true)
 (accepted : constructRecord (some initial) (some terminal) direct .emptyOne record = .ok out) :
 Text.equal initial.inversion.label terminal.inversion.label = false :=
 directChangesKnownInversion initial terminal known (acceptedDirectSound initial terminal record out accepted)

-- classify_observation: these branches preserve the original precedence;
-- supplying a mediator cannot change an otherwise direct result.
theorem directPriority (initial terminal : StateSignature) (record : String)
 (heldRecord : HeldLabel) (mediator : Option String)
 (bound : heldLabel "selection-record" record = .ok heldRecord)
 (allowed : directObservationAllowed initial terminal = true) :
 classifyObservation (some initial) (some terminal) record true false mediator =
 constructRecord (some initial) (some terminal) direct .emptyOne heldRecord := by
 unfold classifyObservation
 rw [bound]
 change (if directObservationAllowed initial terminal then
  constructRecord (some initial) (some terminal) direct .emptyOne heldRecord else _) = _
 rw [allowed]
 rfl

theorem missingMediatorRejected (initial terminal : StateSignature) (record : String)
 (heldRecord : HeldLabel)
 (bound : heldLabel "selection-record" record = .ok heldRecord)
 (notDirect : directObservationAllowed initial terminal = false) :
 classifyObservation (some initial) (some terminal) record true false none =
 .error "observed non-direct relation must not erase its mediator requirement" := by
 unfold classifyObservation
 rw [bound]
 change (if directObservationAllowed initial terminal then
  constructRecord (some initial) (some terminal) direct .emptyOne heldRecord else _) = _
 rw [notDirect]
 rfl
end SFT.Chemistry.SelectionDerivation
