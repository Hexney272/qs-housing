





local L0_1, L1_1, L2_1
L0_1 = {}
L0_1.INSERT_ORDER = [[
        INSERT INTO house_furniture_orders (house, buyer_identifier, model_name, price, payload_json, status, deliver_at, created_at, updated_at)
        VALUES (?, ?, ?, ?, ?, 'pending', ?, NOW(), NOW())
    ]]
L0_1.SELECT_READY_ORDERS = [[
        SELECT id, model_name, price, payload_json
        FROM house_furniture_orders
        WHERE house = ? AND status = 'ready'
        ORDER BY id ASC
    ]]
L0_1.SELECT_READY_COUNT = [[
        SELECT COUNT(*) AS count
        FROM house_furniture_orders
        WHERE house = ? AND status = 'ready'
    ]]
L0_1.SELECT_READY_COUNTS_FOR_HOUSES = [[
        SELECT house, COUNT(*) AS count
        FROM house_furniture_orders
        WHERE status = 'ready' AND house IN (%s)
        GROUP BY house
    ]]
L0_1.SELECT_HOUSES_WITH_DUE_ORDERS = [[
        SELECT DISTINCT house
        FROM house_furniture_orders
        WHERE status = 'pending' AND deliver_at <= NOW()
    ]]
L0_1.UPDATE_DUE_TO_READY = [[
        UPDATE house_furniture_orders
        SET status = 'ready', updated_at = NOW()
        WHERE status = 'pending' AND deliver_at <= NOW()
    ]]
L1_1 = db
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L1_2 = MySQL
  L1_2 = L1_2.insert
  L1_2 = L1_2.await
  L2_2 = L0_1.INSERT_ORDER
  L3_2 = {}
  L4_2 = A0_2.house
  L5_2 = A0_2.buyerIdentifier
  L6_2 = A0_2.modelName
  L7_2 = A0_2.price
  L8_2 = json
  L8_2 = L8_2.encode
  L9_2 = A0_2.payload
  if not L9_2 then
    L9_2 = {}
  end
  L8_2 = L8_2(L9_2)
  L9_2 = A0_2.deliverAt
  L3_2[1] = L4_2
  L3_2[2] = L5_2
  L3_2[3] = L6_2
  L3_2[4] = L7_2
  L3_2[5] = L8_2
  L3_2[6] = L9_2
  return L1_2(L2_2, L3_2)
end
L1_1.createFurnitureOrder = L2_1
L1_1 = db
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.single
  L1_2 = L1_2.await
  L2_2 = L0_1.SELECT_READY_COUNT
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  if L1_2 then
    L2_2 = L1_2.count
    if L2_2 then
      goto lbl_19
    end
    L2_2 = 0
    if L2_2 then
      goto lbl_19
    end
  end
  L2_2 = 0
  ::lbl_19::
  return L2_2
end
L1_1.getReadyFurnitureOrderCount = L2_1
L1_1 = db
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L1_2 = {}
  if A0_2 then
    L2_2 = #A0_2
    if 0 ~= L2_2 then
      goto lbl_9
    end
  end
  do return L1_2 end
  ::lbl_9::
  L2_2 = {}
  L3_2 = {}
  L4_2 = 1
  L5_2 = #A0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = #L2_2
    L8_2 = L8_2 + 1
    L2_2[L8_2] = "?"
    L8_2 = #L3_2
    L8_2 = L8_2 + 1
    L9_2 = A0_2[L7_2]
    L3_2[L8_2] = L9_2
    L8_2 = A0_2[L7_2]
    L1_2[L8_2] = 0
  end
  L4_2 = L0_1.SELECT_READY_COUNTS_FOR_HOUSES
  L5_2 = L4_2
  L4_2 = L4_2.format
  L6_2 = table
  L6_2 = L6_2.concat
  L7_2 = L2_2
  L8_2 = ","
  L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2, L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
  L5_2 = MySQL
  L5_2 = L5_2.query
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = L3_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L5_2 = {}
  end
  L6_2 = 1
  L7_2 = #L5_2
  L8_2 = 1
  for L9_2 = L6_2, L7_2, L8_2 do
    L10_2 = L5_2[L9_2]
    L11_2 = L10_2.house
    if L11_2 then
      L11_2 = L10_2.house
      L12_2 = tonumber
      L13_2 = L10_2.count
      L12_2 = L12_2(L13_2)
      if not L12_2 then
        L12_2 = 0
      end
      L1_2[L11_2] = L12_2
    end
  end
  return L1_2
end
L1_1.getReadyFurnitureOrderCounts = L2_1
L1_1 = db
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2
  L1_2 = MySQL
  L1_2 = L1_2.query
  L1_2 = L1_2.await
  L2_2 = L0_1.SELECT_READY_ORDERS
  L3_2 = {}
  L4_2 = A0_2
  L3_2[1] = L4_2
  L1_2 = L1_2(L2_2, L3_2)
  if not L1_2 then
    L1_2 = {}
  end
  return L1_2
end
L1_1.getReadyFurnitureOrders = L2_1
L1_1 = db
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = #A0_2
  if 0 == L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = {}
  L3_2 = {}
  L4_2 = A1_2
  L3_2[1] = L4_2
  L4_2 = 1
  L5_2 = #A0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = #L2_2
    L8_2 = L8_2 + 1
    L2_2[L8_2] = "?"
    L8_2 = #L3_2
    L8_2 = L8_2 + 1
    L9_2 = A0_2[L7_2]
    L3_2[L8_2] = L9_2
  end
  L4_2 = [[
 
        UPDATE house_furniture_orders
        SET status = 'delivered', delivered_at = NOW(), updated_at = NOW()
        WHERE house = ? AND status = 'ready' AND id IN (%s)
    ]]
  L5_2 = L4_2
  L4_2 = L4_2.format
  L6_2 = table
  L6_2 = L6_2.concat
  L7_2 = L2_2
  L8_2 = ","
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2, L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = L3_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L5_2 = 0
  end
  L6_2 = #A0_2
  L6_2 = L5_2 == L6_2
  return L6_2
end
L1_1.markFurnitureOrdersDelivered = L2_1
L1_1 = db
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L1_2 = db
  L1_2 = L1_2.getReadyFurnitureOrders
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  L2_2 = #L1_2
  if 0 == L2_2 then
    L2_2 = false
    L3_2 = {}
    L4_2 = {}
    return L2_2, L3_2, L4_2
  end
  L2_2 = {}
  L3_2 = 1
  L4_2 = #L1_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = #L2_2
    L7_2 = L7_2 + 1
    L8_2 = L1_2[L6_2]
    L8_2 = L8_2.id
    L2_2[L7_2] = L8_2
  end
  L3_2 = db
  L3_2 = L3_2.markFurnitureOrdersDelivered
  L4_2 = L2_2
  L5_2 = A0_2
  L3_2 = L3_2(L4_2, L5_2)
  if not L3_2 then
    L4_2 = false
    L5_2 = {}
    L6_2 = {}
    return L4_2, L5_2, L6_2
  end
  L4_2 = true
  L5_2 = L1_2
  L6_2 = L2_2
  return L4_2, L5_2, L6_2
end
L1_1.claimReadyFurnitureOrders = L2_1
L1_1 = db
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L2_2 = #A0_2
  if 0 == L2_2 then
    L2_2 = false
    return L2_2
  end
  L2_2 = {}
  L3_2 = {}
  L4_2 = A1_2
  L3_2[1] = L4_2
  L4_2 = 1
  L5_2 = #A0_2
  L6_2 = 1
  for L7_2 = L4_2, L5_2, L6_2 do
    L8_2 = #L2_2
    L8_2 = L8_2 + 1
    L2_2[L8_2] = "?"
    L8_2 = #L3_2
    L8_2 = L8_2 + 1
    L9_2 = A0_2[L7_2]
    L3_2[L8_2] = L9_2
  end
  L4_2 = [[
 
        UPDATE house_furniture_orders
        SET status = 'ready', updated_at = NOW()
        WHERE house = ? AND status = 'delivered' AND id IN (%s)
    ]]
  L5_2 = L4_2
  L4_2 = L4_2.format
  L6_2 = table
  L6_2 = L6_2.concat
  L7_2 = L2_2
  L8_2 = ","
  L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2, L8_2)
  L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2)
  L5_2 = MySQL
  L5_2 = L5_2.update
  L5_2 = L5_2.await
  L6_2 = L4_2
  L7_2 = L3_2
  L5_2 = L5_2(L6_2, L7_2)
  if not L5_2 then
    L5_2 = 0
  end
  L6_2 = #A0_2
  L6_2 = L5_2 == L6_2
  return L6_2
end
L1_1.revertFurnitureOrdersToReady = L2_1
L1_1 = db
function L2_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L0_2 = MySQL
  L0_2 = L0_2.query
  L0_2 = L0_2.await
  L1_2 = L0_1.SELECT_HOUSES_WITH_DUE_ORDERS
  L0_2 = L0_2(L1_2)
  if not L0_2 then
    L0_2 = {}
  end
  L1_2 = #L0_2
  if 0 == L1_2 then
    L1_2 = {}
    return L1_2
  end
  L1_2 = MySQL
  L1_2 = L1_2.update
  L1_2 = L1_2.await
  L2_2 = L0_1.UPDATE_DUE_TO_READY
  L1_2(L2_2)
  L1_2 = {}
  L2_2 = {}
  L3_2 = 1
  L4_2 = #L0_2
  L5_2 = 1
  for L6_2 = L3_2, L4_2, L5_2 do
    L7_2 = L0_2[L6_2]
    L7_2 = L7_2.house
    if L7_2 then
      L8_2 = L2_2[L7_2]
      if not L8_2 then
        L2_2[L7_2] = true
        L8_2 = #L1_2
        L8_2 = L8_2 + 1
        L1_2[L8_2] = L7_2
      end
    end
  end
  return L1_2
end
L1_1.updateFurnitureOrdersToReady = L2_1






