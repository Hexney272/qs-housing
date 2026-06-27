





local L0_1, L1_1
L0_1 = Config
L0_1 = L0_1.EnableMetaKey
if not L0_1 then
  return
end
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L4_2 = A0_2
  L3_2 = A0_2.getCache
  L5_2 = "meta_key_valid"
  L6_2 = A1_2
  L7_2 = ":"
  L8_2 = A2_2
  L6_2 = L6_2 .. L7_2 .. L8_2
  L3_2 = L3_2(L4_2, L5_2, L6_2)
  if L3_2 then
    return L3_2
  end
  L4_2 = MySQL
  L4_2 = L4_2.single
  L4_2 = L4_2.await
  L5_2 = "SELECT key_id FROM house_meta_keys WHERE key_id = ? AND house = ?"
  L6_2 = {}
  L7_2 = A1_2
  L8_2 = A2_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L4_2 = L4_2(L5_2, L6_2)
  L5_2 = Debug
  L6_2 = "db:isMetaKeyValid"
  L7_2 = "Key ID:"
  L8_2 = A1_2
  L9_2 = "House:"
  L10_2 = A2_2
  L11_2 = "Result:"
  L12_2 = L4_2
  L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
  L5_2 = nil ~= L4_2
  L7_2 = A0_2
  L6_2 = A0_2.saveCache
  L8_2 = "meta_key_valid"
  L9_2 = L5_2
  L10_2 = A1_2
  L11_2 = ":"
  L12_2 = A2_2
  L10_2 = L10_2 .. L11_2 .. L12_2
  L6_2(L7_2, L8_2, L9_2, L10_2)
  return L5_2
end
L0_1.isMetaKeyValid = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
  L4_2 = MySQL
  L4_2 = L4_2.insert
  L4_2 = L4_2.await
  L5_2 = "INSERT INTO house_meta_keys (house, key_id, owner_identifier) VALUES (?, ?, ?)"
  L6_2 = {}
  L7_2 = A1_2
  L8_2 = A2_2
  L9_2 = A3_2
  L6_2[1] = L7_2
  L6_2[2] = L8_2
  L6_2[3] = L9_2
  L4_2 = L4_2(L5_2, L6_2)
  L6_2 = A0_2
  L5_2 = A0_2.clearCache
  L7_2 = "house_meta_keys"
  L8_2 = A1_2
  L5_2(L6_2, L7_2, L8_2)
  L6_2 = A0_2
  L5_2 = A0_2.clearCache
  L7_2 = "meta_key_valid"
  L8_2 = A2_2
  L9_2 = ":"
  L10_2 = A1_2
  L8_2 = L8_2 .. L9_2 .. L10_2
  L5_2(L6_2, L7_2, L8_2)
  return L4_2
end
L0_1.createMetaKey = L1_1
L0_1 = db
function L1_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
  L3_2 = MySQL
  L3_2 = L3_2.query
  L3_2 = L3_2.await
  L4_2 = "DELETE FROM house_meta_keys WHERE key_id = ? AND house = ?"
  L5_2 = {}
  L6_2 = A1_2
  L7_2 = A2_2
  L5_2[1] = L6_2
  L5_2[2] = L7_2
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = A0_2
  L4_2 = A0_2.clearCache
  L6_2 = "house_meta_keys"
  L7_2 = A2_2
  L4_2(L5_2, L6_2, L7_2)
  L5_2 = A0_2
  L4_2 = A0_2.clearCache
  L6_2 = "meta_key_valid"
  L7_2 = A1_2
  L8_2 = ":"
  L9_2 = A2_2
  L7_2 = L7_2 .. L8_2 .. L9_2
  L4_2(L5_2, L6_2, L7_2)
  return L3_2
end
L0_1.deleteMetaKey = L1_1
L0_1 = db
function L1_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L3_2 = A0_2
  L2_2 = A0_2.getCache
  L4_2 = "house_meta_keys"
  L5_2 = A1_2
  L2_2 = L2_2(L3_2, L4_2, L5_2)
  if L2_2 then
    return L2_2
  end
  L3_2 = MySQL
  L3_2 = L3_2.query
  L3_2 = L3_2.await
  L4_2 = "SELECT * FROM house_meta_keys WHERE house = ? ORDER BY created_at DESC"
  L5_2 = {}
  L6_2 = A1_2
  L5_2[1] = L6_2
  L3_2 = L3_2(L4_2, L5_2)
  L5_2 = A0_2
  L4_2 = A0_2.saveCache
  L6_2 = "house_meta_keys"
  L7_2 = L3_2
  L8_2 = A1_2
  L4_2(L5_2, L6_2, L7_2, L8_2)
  return L3_2
end
L0_1.getHouseMetaKeys = L1_1






