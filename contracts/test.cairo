
%builtins pedersen range_check
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word
# Function that receives an array as parameter, so it actually receives the array length and # the array itself

func array_play(array_param_len : felt, array_param : felt*) -> (res: felt):
    # read first element of the array
    let first = array_param[0]
    # read last element of the array
    let last = array_param[array_param_len - 1]
    let res = first + last
    return (res)
end

let (felt_array: felt*) = alloc()
assert [felt_array] = 3
assert [felt_array + 1] = 2

let array_len = 2

let example = array_play(array_len, felt_array)

