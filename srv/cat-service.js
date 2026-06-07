const INSERT = require("@sap/cds/lib/ql/INSERT");

module.exports = cds.service.impl(async function () {

    /*
    * There are three generic handlers used in CAP service to implement the custom logic.
    * 1. this.before() - This handler is used to implement validations & pre-checks before the execution of the service operation.
    * 2. this.on() - This handler is used to implement the logic during the execution of the service operation.
    * 3. this.after() - This handler is used to implement to close the connection or to do some post processing after the execution of the service operation.
    */


    // Step-1 : Get the employee & product object from the service entities
    let { EmployeeSrv, ProductSrv, PurchaseOrderSrv } = this.entities;

    // Step-2 : Implment the logic to get the highest salary employee details
    this.on('gethighestSalary', async (request, response) => {
        try {
            // Step-3 : Create an object for the transaction
            const tx = cds.tx(request);

            // Step-4 : Get salary of an employee using Transaction object
            const response = await tx.read(EmployeeSrv).orderBy({
                salaryAmount: 'desc'
            }).limit(10);

            // Step-5 : Return the response
            return response;
        } catch (error) {
            return "Error : " + error;
        }
    })

    // Step - 1 : Implement pre-checks before updating the salary of an employee using this.before()
    this.before('UPDATE', EmployeeSrv, async (request, response) => {
        console.log("Salary : ", request.data);
        // Step - 2 : Check if the salary amount is greater than 100000, if yes then throw an error message
        if (parseFloat(request.data.salaryAmount) > 100000) {
            request.error(500, "You are not authorized to update the salary. Please get the approval from your line manager.");
        }
    })

    this.on('gethighestProducts', async (request, response) => {
        try {
            // Step-3 : Create an object for the transaction
            const tx = cds.tx(request);

            // Step-4 : Get salary of an employee using Transaction object
            const response = await tx.read(ProductSrv).orderBy({
                PRICE: 'desc'
            }).limit(10);

            // Step-5 : Return the response
            return response;
        } catch (error) {
            return "Error : " + error;
        }
    })

    this.on('insertEmployee', async (request, response) => {
        // Getting the input parameters from the request object
        const dataset = request.data;

        const salary = parseFloat(request.data.salaryAmount);

        // Step - 2 : Check if the salary amount is greater than 100000, if yes then throw an error message
        if (salary > 100000) {
            request.error(500, "You are not authorized to insert the employee details. Please get the approval from your line manager.");
        }
        try {
            // Step-3 : Create an object for the transaction
            const tx = cds.tx(request);

            // Step-4 : Insert the employee details into the database table using Transaction object
            const response = await cds.tx(request).run([
                INSERT.into(EmployeeSrv).entries(dataset)
            ]).then((resolve, reject) => {
                if (typeof (resolve) !== "undefined") {
                    return request.data;
                } else {
                    request.error(500, "Error while inserting the employee details. Please try again later.");
                }
            })
        } catch (error) {
            request.error(500, "Error : " + error);
        }
        return response;
    }),

    // Step - 1 : Implement the logic to provide discount of a product by 10% using this.on()
    this.on('discountPrice', async(request, response) =>{
        try {
            // Step - 2 : Get the input parameters from the request object
            const ID = request.params[0] ;
            // Step - 3 : Create an object for the transaction
            const tx = cds.tx(request);

            // Step-4 : Update the purchase order price by 10% using Transaction object
            await tx.update(PurchaseOrderSrv).with({
                GROSS_AMOUNT: { '-=': 1000 },
                NET_AMOUNT: { '-=' : 800 },
                TAX_AMOUNT : { '-=' : 200 } 
            }).where(ID);

        } catch (error) {
            return "Error : " + error ;
        }
    })

    // Step-1: Implement the logic to get the top 10 purchase orders with highest gross amount using instance bounded function
    this.on('largetOrderTop10', async(request, response) => {
        try {
            // Step-2: Create an object for the transaction
            const tx = cds.tx(request);

            // Step-3: Get the top 10 purchase orders with highest gross amount using Transaction object
            const reply = await tx.read(PurchaseOrderSrv).orderBy({
                GROSS_AMOUNT: 'desc'
            }).limit(10);

            // Step-4: Return the response
            return reply ;
        } catch (error) {
            return "Error : " + error ;
        }
    })
});