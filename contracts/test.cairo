%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

func product_sum(arr : felt*, size) -> (sum):
    if size == 0:
        return (sum=1)
    end

    if size  == 1:
        return ([arr])
    end

    # size is not zero.
    let (multiple_of_rest) = product_sum(arr=arr + 2, size=size - 2)
    return (sum=[arr] * multiple_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 6

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 1
    assert [ptr + 1] = 2
    assert [ptr + 2] = 3
    assert [ptr + 3] = 4
    assert [ptr + 4] = 5
    assert [ptr + 5] = 6
    assert [ptr + 6] = 7

    # Call array_sum to compute the sum of the elements.
    let (sum) = product_sum(arr=ptr, size=ARRAY_SIZE)

    # Write the sum to the program output.
    serialize_word(sum)

    return ()
end

