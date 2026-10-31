import SFT.Physics.CosmoSpatialFlatness
import Lean
open SFT.Physics.CosmoSpatialFlatness
def closedResult (r : Except String SFT.Mathematics.FoldScalar.Scalar) : Lean.Json :=
 match r with
 | .error e => .str ("error: "++e)
 | .ok v => match v with
   | .emptyOne => .str "empty-One"
   | .positive _ _ => .str "unexpected-present-remainder"
def refinedResult (r : Except String (List Rat)) : Lean.Json :=
 match r with
 | .error e => .str ("error: "++e)
 | .ok ps => .arr ((ps.map fun q => Lean.toJson [toString q.num,toString q.den]).toArray)
def main : IO Unit := do
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (2) 3 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (1) 6 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (0) 1 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (-1) 1 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (2) 1 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (2) 1 (by decide))])).compress)
 IO.println ((closedResult (closedPartitionInput [none])).compress)
 IO.println ((closedResult (closedPartitionInput [none])).compress)
 IO.println ((closedResult (closedPartitionInput [some (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)),some (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide))])).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)),(SFT.Physics.LeptonIntervals.normalize (2) 3 (by decide))] (.integer (1)) (SFT.Physics.LeptonIntervals.normalize (1) 6 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (-1) 1 (by decide)),(SFT.Physics.LeptonIntervals.normalize (2) 1 (by decide))] (.integer (1)) (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.boolean false) (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)) (SFT.Physics.LeptonIntervals.normalize (2) 3 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)),(SFT.Physics.LeptonIntervals.normalize (2) 3 (by decide))] (.boolean true) (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [] (.integer (0)) (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.integer (-1)) (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.integer (1)) (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 2 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.integer (0)) (SFT.Physics.LeptonIntervals.normalize (0) 1 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.integer (0)) (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)) (SFT.Physics.LeptonIntervals.normalize (1) 3 (by decide)))).compress)
 IO.println ((refinedResult (refinePartition [(SFT.Physics.LeptonIntervals.normalize (1) 1 (by decide))] (.integer (0)) (SFT.Physics.LeptonIntervals.normalize (-1) 1 (by decide)) (SFT.Physics.LeptonIntervals.normalize (2) 1 (by decide)))).compress)
