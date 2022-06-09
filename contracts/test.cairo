from starkware.cairo.common.registers import get_fp_and_pc

struct Location:
    member row : felt
    member col : felt
end

func verify_valid_location(loc : Location*):
    # Проверим, что строка находится в диапазоне 0-3
    tempvar row = loc.row
    assert row * (row - 1) * (row - 2) * (row - 3) = 0

    # Проверим, что столбец находится в диапазоне 0-3
    tempvar col = loc.col
    assert col * (col - 1) * (col - 2) * (col - 3) = 0

    return ()
end

func verify_adjacent_location(
    loc0 : Location*, loc1 : Location*
):
    alloc_locals
    local row_diff = loc0.row - loc1.row
    local col_diff = loc0.col - loc1.col

    if row_diff == 0:
        # Координаты строки одинаковые
        # Необходимо проверить, что разница между координатами
        # столбца 1 или -1
        assert col_diff * col_diff = 1
        return ()
    else:
        assert row_diff * row_diff = 1
        assert col_diff = 0
        return()
    end
end

func verify_location_list(loc_list : Location*, n_steps):
    verify_valid_location(loc=loc_list)

    if n_steps == 0:
        return()
    end

    verify_adjacent_location(
        loc0 = loc_list, loc1 = loc_list + Location.SIZE
    )

    verify_location_list(
        loc_list = loc_list + Location.SIZE, n_steps = n_steps - 1
    )
    return()
end

func main():
    alloc_locals

    local loc_tuple : (
        Location, Location, Location, Location, Location
    ) = (
        Location(row=10, col=2),
        Location(row=1, col=2),
        Location(row=1, col=3),
        Location(row=2, col=3),
        Location(row=3, col=3),
        )

    let (__fp__, _) = get_fp_and_pc()

    verify_location_list(
        loc_list = cast(&loc_tuple, Location*), n_steps=4
    )
    return ()
end

