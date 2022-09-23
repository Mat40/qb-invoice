local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-invoice:server:CreatePEFCLInvoice", function(targetId, amount, reason, account)

  -- Source var
  local src = source
  local Player = QBCore.Functions.GetPlayer(src)
  local PlayerName = Player.PlayerData.name
  local PlayerId = Player.PlayerData.citizenid
  local PlayerFirstName = Player.PlayerData.charinfo.firstname
  local PlayerLastName = Player.PlayerData.charinfo.lastname

  -- Target var
  local Target = QBCore.Functions.GetPlayer(targetId)
  local TargetName = Target.PlayerData.name
  local TargetSource = Target.PlayerData.source
  local TargetId = Target.PlayerData.citizenid

  -- Reformat invoice message
  local reason = reason .. " " .. Lang:t("invoice.billed_by") .. PlayerFirstName .. " " .. PlayerLastName

  exports.pefcl:createInvoice(src, 
    { to = TargetName, 
    toIdentifier = TargetId, 
    from = PlayerName, 
    fromIdentifier = PlayerId,
    amount = amount, 
    message = reason, 
    receiverAccountIdentifier = account
    }
  )
  
  TriggerClientEvent('QBCore:Notify', src, Lang:t("invoice.sent"), 'success')
  TriggerClientEvent('QBCore:Notify', TargetSource, Lang:t("invoice.received"))
end)