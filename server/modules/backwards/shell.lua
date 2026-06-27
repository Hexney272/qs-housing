





local L0_1, L1_1, L2_1, L3_1
L0_1 = RegisterCommand
L1_1 = "resetentrycoords"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2
  if 0 ~= A0_2 then
    L2_2 = Error
    L3_2 = "This command can only be executed from the server console."
    return L2_2(L3_2)
  end
  L2_2 = MySQL
  L2_2 = L2_2.Sync
  L2_2 = L2_2.execute
  L3_2 = [[
        UPDATE houselocations
        SET coords = JSON_REMOVE(coords, '$.exit')
        WHERE JSON_EXTRACT(coords, '$.exit') IS NOT NULL
    ]]
  L2_2 = L2_2(L3_2)
  if L2_2 and L2_2 > 0 then
    L3_2 = LoopError
    L4_2 = "^2[QS-HOUSING]^7 Successfully removed exit coords from "
    L5_2 = L2_2
    L6_2 = " houses. You need to restart the script!"
    L4_2 = L4_2 .. L5_2 .. L6_2
    L3_2(L4_2)
  else
    L3_2 = print
    L4_2 = "^3[QS-HOUSING]^7 No houses found with exit coords to remove"
    L3_2(L4_2)
  end
  L3_2 = print
  L4_2 = "^2[QS-HOUSING]^7 Process completed!"
  L3_2(L4_2)
end
L3_1 = false
L0_1(L1_1, L2_1, L3_1)






