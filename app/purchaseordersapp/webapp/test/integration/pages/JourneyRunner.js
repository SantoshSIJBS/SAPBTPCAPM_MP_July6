sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"purchaseordersapp/test/integration/pages/PurchaseOrderSrvList",
	"purchaseordersapp/test/integration/pages/PurchaseOrderSrvObjectPage",
	"purchaseordersapp/test/integration/pages/PurhcaseItemSrvObjectPage"
], function (JourneyRunner, PurchaseOrderSrvList, PurchaseOrderSrvObjectPage, PurhcaseItemSrvObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('purchaseordersapp') + '/test/flp.html#app-preview',
        pages: {
			onThePurchaseOrderSrvList: PurchaseOrderSrvList,
			onThePurchaseOrderSrvObjectPage: PurchaseOrderSrvObjectPage,
			onThePurhcaseItemSrvObjectPage: PurhcaseItemSrvObjectPage
        },
        async: true
    });

    return runner;
});

