





local L0_1, L1_1, L2_1
L0_1 = _G
L1_1 = {}
L2_1 = {}
L1_1.cache = L2_1
L0_1.db = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2, A3_2, A4_2)
  local L5_2, L6_2, L7_2, L8_2
  if not A2_2 then
    L5_2 = Debug
    L6_2 = "No data to save to cache"
    L7_2 = A1_2
    L8_2 = A3_2
    L5_2(L6_2, L7_2, L8_2)
    return
  end
  if A4_2 then
    L5_2 = os
    L5_2 = L5_2.time
    L5_2 = L5_2()
    A4_2 = L5_2 + A4_2
  else
    L5_2 = os
    L5_2 = L5_2.time
    L5_2 = L5_2()
    A4_2 = L5_2 + 3600000
  end
  L5_2 = A0_2.cache
  L6_2 = A0_2.cache
  L6_2 = #L6_2
  L6_2 = L6_2 + 1
  L7_2 = {}
  L7_2.name = A1_2
  L7_2.id = A3_2
  L8_2 = os
  L8_2 = L8_2.time
  L8_2 = L8_2()
  L7_2.time = L8_2
  L7_2.expire = A4_2
  L7_2.data = A2_2
  L5_2[L6_2] = L7_2
  L5_2 = Debug
  L6_2 = "db:saveCache"
  L7_2 = A1_2
  L8_2 = A3_2
  L5_2(L6_2, L7_2, L8_2)
end
L0_1.saveCache = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  function L3_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.name
    L2_3 = A1_2
    L1_3 = L1_3 ~= L2_3
    return L1_3
  end
  if not A2_2 then
    function L4_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.name
      L2_3 = A1_2
      L1_3 = L1_3 ~= L2_3
      return L1_3
    end
    L3_2 = L4_2
  end
  L4_2 = table
  L4_2 = L4_2.filter
  L5_2 = A0_2.cache
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  A0_2.cache = L4_2
  L4_2 = Debug
  L5_2 = "db:clearCache"
  L6_2 = A1_2
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
end
L0_1.clearCache = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  function L3_2(A0_3)
    local L1_3, L2_3
    L1_3 = A0_3.name
    L2_3 = A1_2
    L1_3 = L1_3 == L2_3
    return L1_3
  end
  if not A2_2 then
    function L4_2(A0_3)
      local L1_3, L2_3
      L1_3 = A0_3.name
      L2_3 = A1_2
      L1_3 = L1_3 == L2_3
      return L1_3
    end
    L3_2 = L4_2
  end
  L4_2 = table
  L4_2 = L4_2.find
  L5_2 = A0_2.cache
  L6_2 = L3_2
  L4_2 = L4_2(L5_2, L6_2)
  if L4_2 then
    L5_2 = Debug
    L6_2 = "db:getCache"
    L7_2 = A1_2
    L8_2 = A2_2
    L5_2(L6_2, L7_2, L8_2)
    L5_2 = L4_2.data
    return L5_2
  end
  L5_2 = nil
  return L5_2
end
L0_1.getCache = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L2_2 = type
  L3_2 = A1_2
  L2_2 = L2_2(L3_2)
  if "table" ~= L2_2 then
    return A1_2
  end
  L2_2 = A1_2.w
  if L2_2 then
    L2_2 = A1_2.x
    if L2_2 then
      L2_2 = A1_2.y
      if L2_2 then
        L2_2 = A1_2.z
        if L2_2 then
          L2_2 = vec4
          L3_2 = A1_2.x
          L4_2 = A1_2.y
          L5_2 = A1_2.z
          L6_2 = A1_2.w
          return L2_2(L3_2, L4_2, L5_2, L6_2)
        end
      end
    end
  end
  L2_2 = pairs
  L3_2 = A1_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    L8_2 = type
    L9_2 = L7_2
    L8_2 = L8_2(L9_2)
    if "table" == L8_2 then
      L9_2 = A0_2
      L8_2 = A0_2.convertVectors
      L10_2 = L7_2
      L8_2 = L8_2(L9_2, L10_2)
      A1_2[L6_2] = L8_2
    end
  end
  return A1_2
end
L0_1.convertVectors = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
  L3_2 = A0_2
  L2_2 = A0_2.getCache
  L4_2 = "bills"
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    return L2_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.query
  L3_2 = L3_2.await
  L4_2 = "SELECT * FROM house_bills WHERE house = ? ORDER BY payed ASC, date DESC LIMIT 100"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L4_2 = pairs
  L5_2 = L3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = json
    L10_2 = L10_2.decode
    L11_2 = L9_2.breakdown
    L10_2 = L10_2(L11_2)
    L9_2.breakdown = L10_2
  end
  L5_2 = A0_2
  L4_2 = A0_2.saveCache
  L6_2 = "bills"
  L7_2 = L3_2
  L8_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  return L3_2
end
L0_1.getBills = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2
  L4_2 = MySQL
  L4_2 = L4_2.update
  L4_2 = L4_2.await
  L5_2 = "UPDATE house_bills SET payed = 1, payed_by = ? WHERE id = ?"
  L6_2 = {}
  L7_2 = A3_2
  L8_2 = A1_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2(L5_2, L6_2)
  L5_2 = A0_2
  L4_2 = A0_2.clearCache
  L6_2 = "bills"
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
end
L0_1.payBill = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  L3_2 = MySQL
  L3_2 = L3_2.update
  L3_2 = L3_2.await
  L4_2 = "UPDATE house_bills SET payed = 1, payed_by = ? WHERE house = ? AND payed = 0"
  L5_2 = {}
  L6_2 = A2_2
  L7_2 = A1_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = A0_2
  L4_2 = A0_2.clearCache
  L6_2 = "bills"
  L7_2 = A1_2
  L4_2(L5_2, L6_2, L7_2)
  L4_2 = L3_2 or L4_2
  if not L3_2 then
    L4_2 = 0
  end
  return L4_2
end
L0_1.payAllBills = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.prepare
  L1_2 = L1_2.await
  L2_2 = "SELECT * FROM house_bills WHERE id = ?"
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L2_2 = json
    L2_2 = L2_2.decode
    L3_2 = L1_2.breakdown
    L2_2 = L2_2(L3_2)
    L1_2.breakdown = L2_2
    L2_2 = L1_2.payed
    L2_2 = 1 == L2_2
    L1_2.payed = L2_2
  end
  return L1_2
end
L0_1.getBill = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = Config
  L2_2 = L2_2.Cleanup
  if L2_2 then
    L2_2 = L2_2.Enabled
  end
  if not L2_2 then
    L2_2 = 0
    return L2_2
  end
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 * 24
  L3_2 = L3_2 * 60
  L3_2 = L3_2 * 60
  L2_2 = L2_2 - L3_2
  L3_2 = 0
  L4_2 = MySQL
  L4_2 = L4_2.query
  L4_2 = L4_2.await
  L5_2 = [[
            DELETE FROM house_bills
            WHERE payed = 1
            AND date < FROM_UNIXTIME(?)
        ]]
  L6_2 = {}
  L7_2 = L2_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2.affectedRows
  if not L5_2 then
    L5_2 = 0
  end
  L3_2 = L3_2 + L5_2
  if L3_2 > 0 then
    L6_2 = Debug
    L7_2 = "db:cleanupOldBills"
    L8_2 = "Deleted"
    L9_2 = L3_2
    L10_2 = "old paid bills (older than"
    L11_2 = A1_2
    L12_2 = "days)"
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  return L3_2
end
L0_1.cleanupOldBills = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L2_2 = Config
  L2_2 = L2_2.Cleanup
  if L2_2 then
    L2_2 = L2_2.Enabled
  end
  if not L2_2 then
    L2_2 = 0
    return L2_2
  end
  L2_2 = os
  L2_2 = L2_2.time
  L2_2 = L2_2()
  L3_2 = A1_2 * 24
  L3_2 = L3_2 * 60
  L3_2 = L3_2 * 60
  L2_2 = L2_2 - L3_2
  L3_2 = 0
  L4_2 = MySQL
  L4_2 = L4_2.query
  L4_2 = L4_2.await
  L5_2 = [[
            DELETE FROM house_rents
            WHERE payed = 1
            AND date < FROM_UNIXTIME(?)
        ]]
  L6_2 = {}
  L7_2 = L2_2
  L6_2[1] = L7_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = L4_2.affectedRows
  if not L5_2 then
    L5_2 = 0
  end
  L3_2 = L3_2 + L5_2
  if L3_2 > 0 then
    L6_2 = Debug
    L7_2 = "db:cleanupOldRent"
    L8_2 = "Deleted"
    L9_2 = L3_2
    L10_2 = "old paid rent records (older than"
    L11_2 = A1_2
    L12_2 = "days)   "
    L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  end
  return L3_2
end
L0_1.cleanupOldRent = L1_1
L0_1 = db
function L1_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L1_2 = Config
  L1_2 = L1_2.Cleanup
  if L1_2 then
    L1_2 = L1_2.Enabled
  end
  if not L1_2 then
    L1_2 = {}
    L1_2.bills = 0
    L1_2.rent = 0
    L1_2.total = 0
    return L1_2
  end
  L1_2 = {}
  L1_2.bills = 0
  L1_2.rent = 0
  L1_2.total = 0
  L2_2 = Config
  L2_2 = L2_2.Cleanup
  L2_2 = L2_2.Bills
  if L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.cleanupOldBills
    L4_2 = Config
    L4_2 = L4_2.Cleanup
    L4_2 = L4_2.Bills
    L4_2 = L4_2.KeepDays
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.bills = L2_2
  end
  L2_2 = Config
  L2_2 = L2_2.Cleanup
  L2_2 = L2_2.Rent
  if L2_2 then
    L3_2 = A0_2
    L2_2 = A0_2.cleanupOldRent
    L4_2 = Config
    L4_2 = L4_2.Cleanup
    L4_2 = L4_2.Rent
    L4_2 = L4_2.KeepDays
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.rent = L2_2
  end
  L2_2 = L1_2.bills
  L3_2 = L1_2.rent
  L2_2 = L2_2 + L3_2
  L1_2.total = L2_2
  L2_2 = L1_2.total
  if L2_2 > 0 then
    L2_2 = Debug
    L3_2 = "db:runCleanup"
    L4_2 = "Cleanup completed"
    L5_2 = "Bills:"
    L6_2 = L1_2.bills
    L7_2 = "Rent:"
    L8_2 = L1_2.rent
    L9_2 = "Total:"
    L10_2 = L1_2.total
    L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
  end
  return L1_2
end
L0_1.runCleanup = L1_1
L0_1 = CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
  L0_2 = Config
  L0_2 = L0_2.Cleanup
  if L0_2 then
    L0_2 = L0_2.Enabled
  end
  if not L0_2 then
    return
  end
  L0_2 = Config
  L0_2 = L0_2.Cleanup
  L0_2 = L0_2.IntervalHours
  L0_2 = L0_2 * 60
  L0_2 = L0_2 * 60
  L0_2 = L0_2 * 1000
  while true do
    L1_2 = db
    L2_2 = L1_2
    L1_2 = L1_2.runCleanup
    L1_2 = L1_2(L2_2)
    L2_2 = L1_2.total
    if L2_2 > 0 then
      L2_2 = Debug
      L3_2 = "Cleanup cycle completed"
      L4_2 = "Deleted records:"
      L5_2 = L1_2.total
      L2_2(L3_2, L4_2, L5_2)
    end
    L2_2 = Wait
    L3_2 = L0_2
    L2_2(L3_2)
  end
end
L0_1(L1_1)






