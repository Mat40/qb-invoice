local Translations = {
    menu = {
        ["header"] = "Menu Factures",
        ["subheader"] = "Créer une facture",
        ["input_label"] = "Libellé",
        ["input_amount"] = "Montant ($)",
        ["confirm"] = "Confirmer",
        ["close"] = "Fermer",
    },
    invoice = {
        ["billed_by"] = "Facturé par : ",
        ["sent"] = "Facture émise",
        ["received"] = "Vous avez reçu une nouvelle facture."
    },
    notify = {
        ["nobody_near"] = "Personne aux alentours !",
    },
}
Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})