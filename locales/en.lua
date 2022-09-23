local Translations = {
    menu = {
        ["header"] = "Invoices Menu",
        ["subheader"] = "Create an invoice",
        ["input_label"] = "Wording",
        ["input_amount"] = "Amount ($)",
        ["confirm"] = "Confirm",
        ["close"] = "Close",
    },
    invoice = {
        ["billed_by"] = "Billed by : ",
        ["sent"] = "Invoice sent",
        ["received"] = "You received a new invoice."
    },
    notify = {
        ["nobody_near"] = "Nobody around here !",
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})