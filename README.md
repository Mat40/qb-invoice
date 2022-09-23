# QB-Invoice

QB-Invoice is a resource that allows employees of a company to create an invoice. This resource ONLY works with [PEFCL]("https://github.com/project-error/pefcl")

## Dependency

[QB-Core]("https://github.com/qbcore-framework/qb-core")

[QB-RadialMenu]("https://github.com/qbcore-framework/qb-radialmenu")

[QB-PEFCL]("https://github.com/project-error/qb-pefcl")

[PEFCL]("https://github.com/project-error/pefcl")
## Installation

#### qb-radialmenu/config.lua
Add in your job section (`Config.JobInteractions`)

```lua
{
    id = 'invoice',
    title = 'Facture',
    icon = 'pen-to-square',
    type = 'client',
    event = 'qb-invoice:client:GetClosestPlayer',
    shouldClose = true
}
```

#### Example

```lua
Config.JobInteractions = {
    ["taxi"] = {
        {
            id = 'invoice',
            title = 'Facture',
            icon = 'pen-to-square',
            type = 'client',
            event = 'qb-invoice:client:GetClosestPlayer',
            shouldClose = true
        },
        .....
    },
    .....
}
```