{
    "$schema": "http://schema.management.azure.com/schemas/2015-01-01/deploymentTemplate.json#",
    "contentVersion": "1.0.0.0",
    "parameters": {
        "subscriptionId": {
            "type": "string"
        },
        "name": {
            "type": "string"
        },
        "location": {
            "type": "string"
        },
        "hostingEnvironment": {
            "type": "string"
        },
        "hostingPlanName": {
            "type": "string"
        },
        "serverFarmResourceGroup": {
            "type": "string"
        },
        "alwaysOn": {
            "type": "bool"
        },
        "sku": {
            "type": "string"
        },
        "skuCode": {
            "type": "string"
        },
        "workerSize": {
            "type": "string"
        },
        "workerSizeId": {
            "type": "string"
        },
        "numberOfWorkers": {
            "type": "string"
        },
        "currentStack": {
            "type": "string"
        },
        "netFrameworkVersion": {
            "type": "string"
        }
    },
    "resources": [
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('name')]",
            "type": "Microsoft.Web/sites",
            "location": "[parameters('location')]",
            "tags": {
                "Resource-Tag": "POC"
            },
            "dependsOn": [
                "[concat('Microsoft.Web/serverfarms/', parameters('hostingPlanName'))]"
            ],
            "properties": {
                "name": "[parameters('name')]",
                "siteConfig": {
                    "appSettings": [],
                    "metadata": [
                        {
                            "name": "CURRENT_STACK",
                            "value": "[parameters('currentStack')]"
                        }
                    ],
                    "netFrameworkVersion": "[parameters('netFrameworkVersion')]",
                    "alwaysOn": "[parameters('alwaysOn')]"
                },
                "serverFarmId": "[concat('/subscriptions/', parameters('subscriptionId'),'/resourcegroups/', parameters('serverFarmResourceGroup'), '/providers/Microsoft.Web/serverfarms/', parameters('hostingPlanName'))]",
                "hostingEnvironment": "[parameters('hostingEnvironment')]",
                "clientAffinityEnabled": true
            }
        },
        {
            "apiVersion": "2018-02-01",
            "name": "[parameters('hostingPlanName')]",
            "type": "Microsoft.Web/serverfarms",
            "location": "[parameters('location')]",
            "kind": "",
            "tags": {
                "Resource-Tag": "POC"
            },
            "properties": {
                "name": "[parameters('hostingPlanName')]",
                "workerSize": "[parameters('workerSize')]",
                "workerSizeId": "[parameters('workerSizeId')]",
                "numberOfWorkers": "[parameters('numberOfWorkers')]",
                "hostingEnvironment": "[parameters('hostingEnvironment')]"
            },
            "sku": {
                "Tier": "[parameters('sku')]",
                "Name": "[parameters('skuCode')]"
            }
        }
    ]
}
