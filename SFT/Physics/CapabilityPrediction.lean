import SFT.Mathematics.DiscreteObjects
namespace SFT.Physics.CapabilityPrediction
inductive Opcode where
 | input
 | emptyOne
 | label
 | count
 | ratio
 | word
 | pair
 | table
 | lookup
 | junction
 | product
 | quotient
 | same
 | assertSame
 | emit
 deriving DecidableEq

def opcodeName : Opcode → String
 | .input => "input"
 | .emptyOne => "empty_one"
 | .label => "label"
 | .count => "count"
 | .ratio => "ratio"
 | .word => "word"
 | .pair => "pair"
 | .table => "table"
 | .lookup => "lookup"
 | .junction => "junction"
 | .product => "product"
 | .quotient => "quotient"
 | .same => "same"
 | .assertSame => "assert_same"
 | .emit => "emit"

def allOpcodes : List Opcode := [.input,.emptyOne,.label,.count,.ratio,.word,.pair,.table,.lookup,.junction,.product,.quotient,.same,.assertSame,.emit]
theorem opcodeComplete (opcode : Opcode) : opcode ∈ allOpcodes := by
  cases opcode <;> repeat first | exact List.Mem.head _ | apply List.Mem.tail

def producesValue : Opcode → Bool
 | .assertSame => false
 | .emit => false
 | .input => true
 | .emptyOne => true
 | .label => true
 | .count => true
 | .ratio => true
 | .word => true
 | .pair => true
 | .table => true
 | .lookup => true
 | .junction => true
 | .product => true
 | .quotient => true
 | .same => true

theorem noAmbientOpcode (opcode : Opcode) :
    SFT.Mathematics.DiscreteObjects.has ["filesystem","network","subprocess","clock","environment","import","foreign_function"] (opcodeName opcode) = false := by
  cases opcode <;> decide
end SFT.Physics.CapabilityPrediction
