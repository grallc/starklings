%lang starknet

# Arrays can also contain structs

struct Point:
    member x : felt
    member y : felt
    member z : felt
end

func contains_origin{range_check_ptr : felt}(len_points : felt, points : Point*) -> (bool : felt):
    # FILL ME
    if len_points == 0:
        return (0)
    end

    if points[0].x != 0:
        return contains_origin(len_points - 1, points + Point.SIZE)
    end

    if points[0].y != 0:
        return contains_origin(len_points - 1, points + Point.SIZE)
    end

    if points[0].z != 0:
        return contains_origin(len_points - 1, points + Point.SIZE)
    end

    return (1)
end

# TESTS #

from starkware.cairo.common.alloc import alloc

@external
func test_contrains_origin{range_check_ptr : felt}():
    alloc_locals

    let (local false_array : Point*) = alloc()
    assert false_array[0] = Point(1, 2, 3)
    assert false_array[1] = Point(2, 2, 2)
    assert false_array[2] = Point(42, 27, 11)

    let (res) = contains_origin(3, false_array)
    assert res = 0

    let (local true_array : Point*) = alloc()
    assert true_array[0] = Point(1, 2, 3)
    assert true_array[1] = Point(0, 0, 0)
    assert true_array[2] = Point(42, 27, 11)

    let (res) = contains_origin(3, true_array)
    assert res = 1

    return ()
end
