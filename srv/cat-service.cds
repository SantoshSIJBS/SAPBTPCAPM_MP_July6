
using { poapp.db as database  } from '../db/datamodel';

using { poapp.cdsviews as views} from '../db/CDSViews';

using { poapp.reuse as reuse } from '../db/reuse';

using { Currency } from '@sap/cds/common';


service CatalogService @(path: 'cat-service', requires: 'authenticated-user') {


    entity ProductSrv as projection on database.master.Products;

    entity BusinessPartnerSrv as  projection on database.master.BusinessPartners;

    entity AddressesSrv as projection on database.master.Addresses;

    @restrict : [{
        grant : 'READ',
        to : [
            'Viewer'
        ]
    }]
    entity EmployeeSrv as projection on database.master.Employees;


    entity PurchaseOrderSrv as projection on database.transaction.PurchaseOrders{
        *,
        case OVERALL_STATUS
            when 'N' then 'New'
            when 'P' then 'Paid'
            when 'X' then 'Not Paid'
            else 'Completed'
        end as OST : String(20) @(title: '{i18n>OVERALL_STATUS}'),
        case OVERALL_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'X' then 2
            else 1
        end as OSC : String(20),
        case LIFECYCLE_STATUS
            when 'N' then 'Not Started'
            when 'P' then 'Pending'
            when 'D' then 'Delivered'
            when 'R' then 'Retruned'
            else 'Done'
        end as LST : String(20) @(title: '{i18n>LIFECYCLE_STATUS}'),
        case LIFECYCLE_STATUS
            when 'N' then 1
            when 'P' then 2
            when 'D' then 3
            when 'R' then 2
            else 1
        end as LSC : String(20),

    } actions {
        
        // Instance Bounded Action declaration - action <action_name> ( <parameters> ) returns <return_type>;

        @cds.odata.bindingparameter.name : 'DP'
        @Common.SideEffects : {
            TargetProperties : ['DP/GROSS_AMOUNT','DP/NET_AMOUNT','DP/TAX_AMOUNT'],
        }
        action discountPrice();

        // Instance Bounded Function declaration - function <function_name> ( <parameters> ) returns <return_type>;
        function largetOrderTop10() returns array of PurchaseOrderSrv ;
    };

    entity PurhcaseItemSrv as projection on database.transaction.PurhcaseItems;

    // Declaration of Function - function <function_name> ( <parameters> ) returns <return_type>;
    function gethighestSalary() returns array of EmployeeSrv;

    function gethighestProducts() returns array of ProductSrv;

    action insertEmployee(
        Currency_code: String,
        ID : UUID,
        nameFirst : String(40),
        nameLast : String(40),
        nameInitials : String(40),
        nameMiddle : String(40),
        gender : reuse.Gender ,
        language : String(2),
        loginName : String(16),
        phoneNumber : reuse.PhoneNumber,
        email : reuse.Email ,
        salaryAmount : reuse.AmountT,
        accountNumber : String(16),
        bankId : String(16),
        bankName : String(64)
    ) returns array of EmployeeSrv;
}