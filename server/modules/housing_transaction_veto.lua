local handlers = {}

HouseTransactionVeto = {}

function HouseTransactionVeto.Run(context)
  for handlerId, handler in pairs(handlers) do
    local ok, allowed, reason = pcall(handler, context)

    if not ok then
      Debug("HouseTransactionVeto", "Handler error", handlerId, allowed)
    elseif false == allowed then
      Debug("HouseTransactionVeto", "Transaction vetoed", handlerId, context.action, context.house, reason)

      local result = {}
      result.allowed = false

      if not reason then
        reason = "Transaction blocked by " .. handlerId
      end
      result.reason = reason

      return result
    end
  end

  return { allowed = true, reason = nil }
end

local function RegisterHouseTransactionVeto(handlerId, handler)
  if type(handlerId) ~= "string" or "" == handlerId then
    return Error("RegisterHouseTransactionVeto", "Invalid handler id", handlerId)
  end

  handlers[handlerId] = handler
  Debug("HouseTransactionVeto", "Registered handler", handlerId)
end

local function UnregisterHouseTransactionVeto(handlerId)
  if handlers[handlerId] then
    handlers[handlerId] = nil
    Debug("HouseTransactionVeto", "Unregistered handler", handlerId)
  end
end

exports("RegisterHouseTransactionVeto", RegisterHouseTransactionVeto)
exports("UnregisterHouseTransactionVeto", UnregisterHouseTransactionVeto)
