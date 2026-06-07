using CatalogService as service from '../../srv/cat-service';
annotate service.PurchaseOrderSrv with @(
    UI.SelectionFields : [
        PO_ID,
        GROSS_AMOUNT,
        PARTNER_GUID.COMPANY_NAME,
        PARTNER_GUID.ADDRESS_GUID.COUNTRY
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.BP_ID
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        },
        {
            $Type : 'UI.DataFieldForAction',
            Action : 'CatalogService.discountPrice',
            Label : 'Discount(10%)',
            Inline : false,
        },
        {
            $Type : 'UI.DataField',
            Value : LST,
            Criticality : LSC
        },
        {
            $Type : 'UI.DataField',
            Value : OST,
            Criticality : OSC
        },
        {
            $Type : 'UI.DataField',
            Value : PARTNER_GUID.ADDRESS_GUID.COUNTRY
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order',
        TypeNamePlural : 'Purchase Orders',
        Title : {
            Label : 'Purchase Order ID',
            Value : PO_ID
        },
        Description : {
            Label : 'Company Name',
            Value : PARTNER_GUID.COMPANY_NAME
        },
        ImageUrl : 'https://cdn-icons-png.flaticon.com/512/5969/5969147.png'
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Purhcase Order Details',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'More details about the purchase order',
                    Target : '@UI.FieldGroup#MoreInfo'
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Amount Related Information',
                    Target : '@UI.FieldGroup#AmountInfo'
                }
            ]
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Line Item Details',
            Target : 'Items/@UI.LineItem'
        }
    ],
    UI.FieldGroup #MoreInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PO_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID.BP_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PARTNER_GUID_NODE_KEY
            },
            {
                $Type : 'UI.DataField',
                Value : LST,
                Criticality : LSC
            },
            {
                $Type : 'UI.DataField',
                Value : OST,
                Criticality : OSC
            }
        ]
    },

    UI.FieldGroup #AmountInfo : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataFieldForAction',
                Action : 'CatalogService.discountPrice',
                Label : 'Discount(10%)',
                Inline : true
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
        ]
    }
);

annotate service.PurhcaseItemSrv with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : PO_ITEMS_POS
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID.PRODUCT_ID
        },
        {
            $Type : 'UI.DataField',
            Value : PRODUCT_GUID_NODE_KEY
        },
        {
            $Type : 'UI.DataField',
            Value : GROSS_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : NET_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : TAX_AMOUNT
        },
        {
            $Type : 'UI.DataField',
            Value : CURRENCY_code
        }
    ],
    UI.HeaderInfo : {
        TypeName : 'Purchase Order Item',
        TypeNamePlural : 'Purchase Order Items',
        Title : {
            Label : 'Purchase Order Item ID',
            Value : PO_ITEMS_POS
        },
        Description : {
            Label : 'Product Description',
            Value : PRODUCT_GUID.DESCRIPTION
        },
        ImageUrl : 'https://cdn-icons-png.flaticon.com/512/5969/5969147.png'
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Product Details',
            Facets : [
{
        $Type : 'UI.ReferenceFacet',
         Label : 'Purchase Item Details',
         Target : '@UI.FieldGroup#PIPD'
        },
        {
        $Type : 'UI.ReferenceFacet',
        Label : 'Product Details',
        Target : '@UI.FieldGroup#PIPI'
        }
            ]
        }
    ],
    UI.FieldGroup #PIPD : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : GROSS_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : NET_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : TAX_AMOUNT
            },
            {
                $Type : 'UI.DataField',
                Value : CURRENCY_code
            }
        ]
    },
    UI.FieldGroup #PIPI : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRODUCT_ID
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DESCRIPTION
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.CATEGORY
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.PRICE
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DIM_UNIT
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.WEIGHT_UNIT
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.WEIGHT_MEASURE
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.HEIGHT
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.DEPTH
            },
            {
                $Type : 'UI.DataField',
                Value : PRODUCT_GUID.WIDTH
            }
        ]
    }
)