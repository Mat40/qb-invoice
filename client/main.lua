local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local PlayerJob = PlayerData.job

local function CloseMenuFull()
  exports['qb-menu']:closeMenu()
  exports['qb-core']:HideText()
  shownBossMenu = false
end

local function AddInvoiceMenuItem(data, id)
  local menuID = id or (#DynamicMenuItems + 1)
  DynamicMenuItems[menuID] = deepcopy(data)
  return menuID
end

exports("AddInvoiceMenuItem", AddInvoiceMenuItem)

local function RemoveInvoiceMenuItem(id)
  DynamicMenuItems[id] = nil
end

exports("RemoveInvoiceMenuItem", RemoveInvoiceMenuItem)

AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
      PlayerJob = QBCore.Functions.GetPlayerData().job
  end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  PlayerJob = QBCore.Functions.GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
  PlayerJob = JobInfo
end)

RegisterNetEvent('qb-invoice:client:OpenMenu', function()
  if not Config.AllowedJobs[PlayerJob.name] then return end

  local invoiceMenu = {
    {
      header = Lang:t("menu.header") .. string.upper(PlayerJob.label),
      icon = "fa-solid fa-memo-circle-check",
      isMenuHeader = true,
    },
    {
      header = Lang:t("menu.subheader"),
      txt = Lang:t("menu.subheader"),
      icon = "fa-solid fa-pen-to-square",
      params = {
        event = "qb-invoice:client:CreateInvoiceInput",
      }
    },
  }
  for _, v in pairs(DynamicMenuItems) do
    invoiceMenu[#invoiceMenu + 1] = v
  end

  invoiceMenu[#invoiceMenu + 1] = {
      header = Lang:t("menu.close"),
      icon = "fa-solid fa-angle-left",
      params = {
          event = "qb-menu:closeMenu",
      }
  }

  exports['qb-menu']:openMenu(invoiceMenu)
end)

RegisterNetEvent("qb-invoice:client:GetClosestPlayer", function()
  local target, distance = QBCore.Functions.GetClosestPlayer()
  if target ~= -1 and distance < 2.5 then
    local targetId = GetPlayerServerId(target)
    TriggerEvent("qb-invoice:client:CreateInvoiceInput", targetId)
  else
    QBCore.Functions.Notify(Lang:t("notify.nobody_near"), "error", 5000)
  end
end)

RegisterNetEvent("qb-invoice:client:CreateInvoiceInput", function(targetId)
  local invoice = exports['qb-input']:ShowInput({
    header = Lang:t("menu.subheader"),
    submitText = Lang:t("menu.confirm"),
    inputs = {
      {
          text = Lang:t("menu.input_label"),
          name = "reason",
          type = "text",
          isRequired = true, 
      },
      {
          text = Lang:t("menu.input_amount"),
          name = "amount",
          type = "number",
          isRequired = true,
      },
    },
  })
  if invoice then
    if not invoice.amount or not invoice.reason then return end
    local amount = tonumber(invoice.amount)
    local reason = invoice.reason
    local accountId = Config.AllowedJobs[PlayerJob.name].account
    TriggerServerEvent("qb-invoice:server:CreatePEFCLInvoice", targetId, amount, reason, accountId)
  end
end)