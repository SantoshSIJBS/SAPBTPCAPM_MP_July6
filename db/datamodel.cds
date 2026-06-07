namespace poapp.db ;

using { Currency, cuid } from '@sap/cds/common';

using { poapp.reuse as reuse } from './reuse';

context master {
    entity BusinessPartners {
        key NODE_KEY : reuse.Guid @(title: '{i18n>NODE_KEY}');
        BP_ROLE : reuse.Role @(title: '{i18n>BP_ROLE}');
        EMAIL : reuse.Email @(title: '{i18n>EMAIL}');
        MOBILE : reuse.PhoneNumber @(title: '{i18n>MOBILE}');
        FAX : reuse.String32 @(title: '{i18n>FAX}');
        WEB : reuse.String255 @(title: '{i18n>WEB}');
        BP_ID : reuse.Guid @(title: '{i18n>BP_ID}');
        COMPANY_NAME : reuse.String255 @(title: '{i18n>COMPANY_NAME}');

        ADDRESS_GUID : Association to Addresses @(title: '{i18n>ADDRESS_GUID}');
    }

    entity Addresses : reuse.Address {
        key NODE_KEY : reuse.Guid @(title: '{i18n>NODE_KEY}');
        ADDRESS_TYPE : reuse.String32 @(title: '{i18n>ADDRESS_TYPE}');
        VAL_START : Date @(title: '{i18n>VAL_START}');
        VAL_END : Date @(title: '{i18n>VAL_END}');
        LATITUDE : Decimal @(title: '{i18n>LATITUDE}');
        LONGITUDE : Decimal @(title: '{i18n>LONGITUDE}');

        // Association - Unmanaged
        businesspartner : Association to one BusinessPartners on businesspartner.ADDRESS_GUID = $self ;
    }

    entity Products {
        key NODE_KEY : reuse.Guid @(title: '{i18n>NODE_KEY}');
        PRODUCT_ID : reuse.String32 @(title: '{i18n>PRODUCT_ID}');
        TYPE_CODE : String(2) @(title: '{i18n>TYPE_CODE}');
        CATEGORY : reuse.String32 @(title: '{i18n>CATEGORY}');
        DESCRIPTION : reuse.String255 @(title: '{i18n>DESCRIPTION}');
        TAX_TARIF_CODE : Integer @(title: '{i18n>TAX_TARIF_CODE}');
        MEASURE_UNIT : String(2) @(title: '{i18n>MEASURE_UNIT}');
        WEIGHT_MEASURE : Decimal(15,2) @(title: '{i18n>WEIGHT_MEASURE}');
        WEIGHT_UNIT : String(2) @(title: '{i18n>WEIGHT_UNIT}');
        PRICE : Decimal(15,2) @(title: '{i18n>PRICE}');
        CURRENCY_CODE : String(4) @(title: '{i18n>CURRENCY_CODE}');
        WIDTH : Decimal(5,2) @(title: '{i18n>WIDTH}');
        DEPTH : Decimal(5,2) @(title: '{i18n>DEPTH}');
        HEIGHT : Decimal(5,2) @(title: '{i18n>HEIGHT}');
        DIM_UNIT : String(2) @(title: '{i18n>DIM_UNIT}');

        // Managed Association
        SUPPLIER_GUID : Association to BusinessPartners @(title: '{i18n>SUPPLIER_GUID}') ;
    }

    entity Employees : cuid {
        nameFirst : String(40);
        nameLast : String(40);
        nameInitials : String(40);
        nameMiddle : String(40);
        gender : reuse.Gender ;
        language : String(2);
        loginName : String(16);
        phoneNumber : reuse.PhoneNumber ;
        email : reuse.Email ;
        Currency : Currency ;
        salaryAmount : reuse.AmountT;
        accountNumber : String(16);
        bankId : String(16);
        bankName : String(64);
    }
}

context transaction {
    entity PurchaseOrders : reuse.Amount {
        key NODE_KEY : reuse.Guid  @(title: '{i18n>NODE_KEY}');
        PO_ID : reuse.Guid  @(title: '{i18n>PO_ID}');
        // Association - Managed
        PARTNER_GUID : Association to master.BusinessPartners  @(title: '{i18n>PARTNER_GUID}');

        LIFECYCLE_STATUS : String(1)  @(title: '{i18n>LIFECYCLE_STATUS}');
        OVERALL_STATUS : String(1)  @(title: '{i18n>OVERALL_STATUS}');

        // Association - Unmanaged
        Items : Composition of many PurhcaseItems on Items.PARENT_KEY = $self ;
    }

    entity PurhcaseItems : reuse.Amount {
        key NODE_KEY : reuse.Guid  @(title: '{i18n>NODE_KEY}') ;
        PARENT_KEY : Association to PurchaseOrders  @(title: '{i18n>PARENT_KEY}');
        PO_ITEMS_POS : Integer  @(title: '{i18n>PO_ITEMS_POS}');

        // Association - Managed
        PRODUCT_GUID : Association to master.Products @(title: '{i18n>PRODUCT_GUID}') ;
    }


    entity Languages {
        key ID : String(1);
        value : String(10);
    }

    entity Countries {
        key ID : String(2);
        value : String(80);
    }

    entity Genders {
        key ID : String(1);
        value : String(10);
    }



    entity EmployeeFullDetails as 
        select from master.Employees as employee
        left join Languages as lang
            on employee.language = lang.ID
        left join Genders as gen
            on employee.gender = gen.ID
    {
        key employee.ID as EmployeeID,
        employee.nameFirst as FirstName,
        employee.nameLast as LastName,
        employee.phoneNumber as Mobile,
        lang.value as Language,
        gen.value as Gender
    }
}

