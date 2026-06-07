namespace poapp.cdsviews;

using { poapp.db.master, poapp.db.transaction } from '../db/datamodel';

context CDSViews {
    define view ![POWorklist] as 
        select from transaction.PurchaseOrders {
            key PO_ID as ![PurchaseOrderID],
            key Items.PO_ITEMS_POS as ![PurchaseOrderItemPosition],
            PARTNER_GUID.BP_ID as ![BusinessPartnerID],
            PARTNER_GUID.COMPANY_NAME as ![CompanyName],
            PARTNER_GUID.ADDRESS_GUID.CITY as ![City],
            PARTNER_GUID.ADDRESS_GUID.COUNTRY as ![Country],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            CURRENCY as ![CurrencyCode],
            OVERALL_STATUS as ![OverallStatus],
            Items.PRODUCT_GUID.PRODUCT_ID as ![ProductID],
            Items.PRODUCT_GUID.DESCRIPTION as ![ProductDescription]
        }

    define view ![ItemView] as 
        select from transaction.PurhcaseItems {
            PARENT_KEY.PARTNER_GUID.NODE_KEY as ![PartnerKey],
            PRODUCT_GUID.NODE_KEY as ![ProductKey],
            PARENT_KEY.OVERALL_STATUS as ![OverallStatus],
            CURRENCY as ![Currency],
            GROSS_AMOUNT as ![GrossAmount],
            NET_AMOUNT as ![NetAmount],
            TAX_AMOUNT as ![TaxAmount],
            PARENT_KEY.OVERALL_STATUS as ![Status],
        }

    define view ![ProductView] as 
        select from master.Products
        mixin {
            PO_ORDER : Association[*] to ItemView on PO_ORDER.ProductKey = $projection.ProductKey
        } into
        {
            NODE_KEY as ![ProductKey],
            DESCRIPTION as ![Description],
            CATEGORY as ![Category],
            PRICE as ![Price],
            SUPPLIER_GUID.BP_ID as ![SupplierID],
            SUPPLIER_GUID.COMPANY_NAME as ![CompanyName],
            SUPPLIER_GUID.ADDRESS_GUID.CITY as ![City],
            SUPPLIER_GUID.ADDRESS_GUID.COUNTRY as ![Country]

        }
}