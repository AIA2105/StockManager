const express = require('express');
const fs = require('fs');
const path = require('path')
const app = express();
app.set('view engine', 'ejs');

// var router = express.Router();
var Employees;
var Brands;
var Departments;
var Holders;
var report={};
var logged='false';
insertedIntoSummury = 'false';
insertedIntoSummury2 = 'false';

app.use(express.json());
app.use('/assets', express.static(path.join(__dirname, 'assets')))
    
app.listen(3000,()=>{
    console.log('Web Server is running on localhost, port 3000');
});

var mysql = require('mysql');
//var conn = mysql.createConnection({
var conn = mysql.createPool({ 
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'services_db'
});


// conn.connect((err)=>{
//     if(err){
//         throw err;
//     }
//     console.log('App is connected to Services_db Database throw localhost!');
// });

conn.on('connection', function (connection) {
     console.log('App is connected to Services_db Database throw localhost!');
  
    connection.on('error', function (err) {
      console.error(new Date(), 'MySQL error', err.code);
    });
    connection.on('close', function (err) {
      console.error(new Date(), 'MySQL close', err);
    });
  
  });

////////////////////////////
// var myQuery = "select Department_id , Department_name from departments";
var getEmployeesQuery = "select Employee_id, employee_name from employees";
var getBrandsQuery = "select Brand_id, Brand_name from Brands";
var getDepartmentsQuery = "select Department_id, Department_name from departments";
var getHoldersQuery = "select Holder_id, Holder_name from Holders";
var myQuery5 = "select Now_quantity from Brands where Brand_name = ?";

////////////////////////////



conn.query(getEmployeesQuery,(err, result)=>{
    if(err){
        throw err;
    }

    elements = [];
   result.forEach(element => {
        elements.push(element['employee_name']);
    });

    Employees=elements;
    console.log('getEmployeesQuery Done!');
});

conn.query(getBrandsQuery,(err, result)=>{
    if(err){
        throw err;
    }

    elements = [];
   result.forEach(element => {
        elements.push(element['Brand_name']);
    });

    Brands=elements;
    console.log('getBrandsQuery Done!');
    
}); 

conn.query(getDepartmentsQuery,(err, result)=>{
    if(err){
        throw err;
    }

    elements = [];
   result.forEach(element => {
        elements.push(element['Department_name']);
    });

    Departments = elements;
    console.log('getDepartmentsQuery Done!');
    
}); 

conn.query(getHoldersQuery,(err, result)=>{
    if(err){
        throw err;
    }

    elements = [];
   result.forEach(element => {
        elements.push(element['Holder_name']);
    });
    Holders = elements;
    console.log('getHoldersQuery Done!');    
/*     //to send data use: JSON.stringify(result)
    //to recive data use: JSON.parse(result) and forEach
 */
    
}); 


app.get('/login',(req,res)=>{
    app.set('views',__dirname + '/views');
    res.render('Login');
});

app.route('/home')
  .post((req, res) => postFunction(req, res))
  .get((req, res) => getFunction(req, res))

  postFunction = (req, res) => {
    if(req.body.bodydata=="true" && req.body.user=="admin" && req.body.pass== "123456"){
        logged=true;
        res.json("ok");
    }else{
        res.json("خطأ في البيانات");
    }
    }

  getFunction = (req, res) => {
    if(logged==true){
        app.set('views',__dirname + '/views');
        res.render('Home', { Employees_names: Employees, Brands_names : Brands, Departments_names: Departments, Holders_names: Holders }); 
        logged = false; 
    }else{
        app.set('views',__dirname + '/views');
        res.render('Login'); 
       
    }
    }



/*
app.get('/home',(req,res)=>{
    // pass array to ejs
    //console.log(Employees)
    app.set('views',__dirname + '/views');
    
    logged=true;
    if(logged==true){
        res.render('Home', { Employees_names: Employees, Brands_names : Brands, Departments_names: Departments, Holders_names: Holders });
    }else{
     res.render('Login');
    }
}); 
*/


app.post("/check",  (req, res) => {
    sequentialQueries();

    function getBrandId () {
        return new Promise((resolve, reject)=>{
            conn.query(myQuery5, req.body.Brand ,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['Now_quantity']);
            });
        });
    };

    async function sequentialQueries () {
        try{
        const Brand_quantity = await getBrandId();
        res.json(Brand_quantity);

        } catch(error){
        console.log(error)
        }
    }

    
 
});

app.post("/request", (req, res) => {
    sequentialQueries();
    function getLastSummaryId () {
        return new Promise((resolve, reject)=>{
            conn.query('SELECT Max(RequestSummary_id) FROM requests_summary',(err, result)=>{
                if(err){
                    return reject(err);
                }

                if(result[0]['Max(RequestSummary_id)']== null){
                    console.log("set to 0")
                    return resolve(0);
                }else{
                    console.log(result[0]['Max(RequestSummary_id)']);
                    return resolve(result[0]['Max(RequestSummary_id)']);
                }
            });
        });
    };

    function getEmployeeId () {
        return new Promise((resolve, reject)=>{
            conn.query('select employee_id from Employees where Employee_name= ?',req.body.employee,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['employee_id']);
            });
        });
    };

    function getDepartmentId  (){
        return new Promise((resolve, reject)=>{
            conn.query('select department_id from departments where department_name= ?',req.body.department,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['department_id']);
            });
        });
    };
    
    function getBrandId(){
        return new Promise((resolve, reject)=>{
            conn.query('select brand_id, Now_quantity from brands where brand_name= ?',req.body.brand,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve({brand_id: result[0]['brand_id'], Now_quantity: result[0]['Now_quantity']});
            });
        });
    };

    function insertData(lastSummaryId, empId, depId, braId){
        return new Promise((resolve, reject)=>{

            if(insertedIntoSummury == 'false'){
                lastSummaryId = lastSummaryId +1;
                conn.query('Insert into requests_summary(RequestSummary_id, Employee_id, department_id, RequestSummary_time) values (?, ?, ?, Now())',
                  [lastSummaryId, empId, depId],(err, result1)=>{
                  if(err){throw err;}          
                  insertedIntoSummury= 'true';
                  console.log("requests_summary has modified!");    
               });
              }

            conn.query('Insert into Requests(RequestSummary_id, Employee_id, department_id, brand_id, Request_quantity, Request_time) values (?, ?, ?, ?, ?, Now())',
            [lastSummaryId, empId, depId, braId, req.body.quanity],(err, result1)=>{
                if(err){throw err;}           
                console.log('Added to requests table');
                conn.query('Update Brands set Now_quantity = (Brands.Now_quantity - ?) where Brands.Brand_id = (select Brand_id from Requests where Requests.Request_id = ?);', [req.body.quanity, result1.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Current quantity has modified!");    
                });

                conn.query('Update Brands set requests = (brands.requests - ?) where brands.brand_id = (select brand_id from Requests where Requests.Request_id = ?);', [req.body.quanity, result1.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Total requests has modified!");   
                });
                
                conn.query('Update Brands set needs = (brands.dues - Brands.Now_quantity ) where Brands.brand_id = (select brand_id from Requests where Requests.Request_id = ?);', [result1.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Total Needs has modified!");    
                });

                return resolve({brandId: result1.insertId, requestId: lastSummaryId});
            });
        });
    };

    async function sequentialQueries () {
        try{
        const lastSummaryId = await getLastSummaryId();     
        const empId = await getEmployeeId();
        const depId = await getDepartmentId();
        const braId = await getBrandId();
        if(braId['Now_quantity'] >= req.body.quanity){
            const insertedId = await insertData(lastSummaryId, empId, depId, braId['brand_id']);
            res.json(insertedId);
        }else{
            res.json(null);
        }
        

        
        } catch(error){
        console.log(error)
        }
        }

report = {employee: req.body.employee, department: req.body.department, brand: req.body.brand, quantity: req.body.quanity}
//res.json("Successfully requested! ID: " + insertedId);
})


app.post("/add", (req, res) => {
    sequentialQueries();

    function getLastSummaryId () {
        return new Promise((resolve, reject)=>{
            conn.query('SELECT Max(AddSummary_id) FROM adds_summary',(err, result)=>{
                if(err){
                    return reject(err);
                }

                if(result[0]['Max(AddSummary_id)']== null){
                    console.log("set to 0");
                    return resolve(0);
                }else{
                    console.log(result[0]['Max(AddSummary_id)']);
                    return resolve(result[0]['Max(AddSummary_id)']);
                }
            });
        });
    };

    function getEmployeeId(){
        return new Promise((resolve, reject)=>{
            conn.query('select employee_id from employees where employee_name= ?',req.body.employee,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['employee_id']);
            });
        });
    };

    function getHolderId(){
        return new Promise((resolve, reject)=>{
            conn.query('select holder_id from holders where holder_name= ?',req.body.holder,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['holder_id']);
            });
        });
    };

    function getBrandId(){
        return new Promise((resolve, reject)=>{
            conn.query('select brand_id from brands where brand_name= ?',req.body.brand,(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result[0]['brand_id']);
            });
        });
    };

    function insertData(lastSummaryId, employeeId, holderId, brandId){
        return new Promise((resolve, reject)=>{

            if(insertedIntoSummury2 == 'false'){
                lastSummaryId = lastSummaryId +1;
                conn.query('Insert into adds_summary(AddSummary_id, Holder_id, employee_id, AddSummary_time) values (?, ?, ?, Now())',
                  [lastSummaryId, holderId, employeeId],(err, result1)=>{
                  if(err){throw err;}          
                  insertedIntoSummury2= 'true';
                  console.log("adds_summary has modified!");    
               });
              }

            conn.query('Insert into adds(AddSummary_id, Add_quantity, employee_id, holder_id, brand_id, Add_time) values (?, ?, ?, ?, ?, Now())',
            [lastSummaryId, req.body.quanity, employeeId, holderId, brandId],(err, result)=>{
                if(err){throw err;}           
                console.log('Added to Adds table!');   
                
                conn.query('Update Brands set Now_quantity = (Brands.Now_quantity + ?) where Brands.Brand_id in (select Brand_id from Adds where Adds.Add_id = ?);', [req.body.quanity, result.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Current quantity has modified!");    
                });

                conn.query('Update Brands set adds = (Brands.adds + ?) where Brands.brand_id = (select brand_id from Adds where Adds.Add_id = ?);', [req.body.quanity, result.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Total adds has modified!");    
                });
                
                conn.query('Update Brands set needs = (brands.dues - Brands.Now_quantity ) where Brands.brand_id = (select brand_id from Adds where Adds.Add_id = ?);', [result.insertId],(err, result)=>{
                    if(err){throw err;}           
                    console.log("Total Needs has modified!");    
                });
                
                return resolve({brandId: result.insertId, addId: lastSummaryId});
            });
        });
    }
    
    async function sequentialQueries () {
        try{
            const lastSummaryId = await getLastSummaryId();     
            const employeeId = await getEmployeeId();
            const HolderId = await getHolderId();
            const brandId = await getBrandId();

            const insertedId = await insertData(lastSummaryId, employeeId, HolderId, brandId);
            res.json(insertedId);

        } catch(error){
            console.log(error)
        }
        }

report = {employee: req.body.employee, holder: req.body.holder, brand: req.body.brand, quantity: req.body.quanity}
})




app.all('/request_report',(req,res)=>{
    fs.readFile(__dirname + '/views/report page/request_report.html', 'utf8', (err, text) => {
        app.set('views',__dirname + '/views/report page/');
        res.render('request_report', report);
        //res.json("report !");

    });

    });
app.all('/add_report',(req,res)=>{
    fs.readFile(__dirname + '/views/report page/add_report.html', 'utf8', (err, text) => {
        app.set('views',__dirname + '/views/report page/');
        res.render('add_report', report);
        //res.json("report !");

    });

    });


app.all('/request_report2/:id',(req,res)=>{
        sequentialQueries(req.params.id);
        function getRequestId(id){
            return new Promise((resolve, reject)=>{
                conn.query('select r.Request_id, e.Employee_name, d.Department_name, b.Brand_name, r.Request_quantity, r.RequestSummary_id, r.Request_time FROM requests r, employees e, brands b, departments d where r.RequestSummary_id=? and r.Employee_id = e.Employee_id and r.Department_id = d.Department_id and r.Brand_id = b.brand_id ORDER BY r.Request_id DESC',[id],(err, result1)=>{
                    if(err){return reject(err);}
                    return resolve(result1);
                });
            });
        };

        async function sequentialQueries (id) {
            try{
            var request = await getRequestId(id);
            insertedIntoSummury = 'false';
            fs.readFile(__dirname + '/views/report page/request_report.html', 'utf8', (err, text) => {
                app.set('views',__dirname + '/views/report page/');
                res.render('request_report', {requests: request}
                );
                
            });
            } catch(error){
            console.log(error)
            }
        }

        });

app.all('/add_report2/:id',(req,res)=>{
        sequentialQueries(req.params.id);
        function getAddId(id){
            return new Promise((resolve, reject)=>{
                conn.query('select a.Add_id, e.Employee_name, h.Holder_name, b.Brand_name, a.Add_quantity, a.AddSummary_id, a.Add_time FROM adds a, employees e, brands b, holders h where a.AddSummary_id=? and a.Employee_id = e.Employee_id and a.Holder_id = h.Holder_id and a.Brand_id = b.brand_id ORDER BY a.Add_id DESC',[id],(err, result1)=>{
                    if(err){return reject(err);}
                    return resolve(result1);
                });
            });
        };

        async function sequentialQueries (id) {
            try{
            var add = await getAddId(id);
            insertedIntoSummury2 = 'false';

            fs.readFile(__dirname + '/views/report page/add_report.html', 'utf8', (err, text) => {
                app.set('views',__dirname + '/views/report page/');
                res.render('add_report', {adds: add});   
            });
            }catch(error){
            console.log(error)
            }
        }
    
        });

app.all('/reportAll',(req,res)=>{

    sequentialQueries();

    function getAllBrands(){
        return new Promise((resolve, reject)=>{
            conn.query('select * from Brands',(err, result)=>{
                if(err){
                    return reject(err);
                }
                return resolve(result);
            });
        });
    };

    
    async function sequentialQueries () {
        try{
        var brands = await getAllBrands();

        fs.readFile(__dirname + '/views/report page/reportAll.html', 'utf8', (err, text) => {
            app.set('views',__dirname + '/views/report page/');
            res.render('reportAll',{brands: brands});
            //res.json(inks);
        });

        } catch(error){
        console.log(error)
        }
    }

    });

    app.all('/requestHistory',(req,res)=>{

        sequentialQueries();
    
        function getRequests(){
            return new Promise((resolve, reject)=>{
                conn.query('SELECT r.Request_id, r.RequestSummary_id, e.Employee_name, d.Department_name, b.Brand_name,r.Request_quantity, r.Request_time FROM `requests` r, employees e, brands b, departments d where r.Employee_id = e.Employee_id and r.Department_id = d.Department_id and r.Brand_id = b.brand_id ORDER BY r.Request_id DESC; ',(err, result)=>{
                    if(err){
                        return reject(err);
                    }
                    return resolve(result);
                });
            });
        };

    
        
        async function sequentialQueries () {
            try{
            var requests = await getRequests();
    
            fs.readFile(__dirname + '/views/report page/requestHistory.html', 'utf8', (err, text) => {
                app.set('views',__dirname + '/views/report page/');
                res.render('requestHistory',{requests: requests});
                //res.json(inks);
            });
    
            } catch(error){
            console.log(error)
            }
        }
    
        });

        app.all('/addHistory',(req,res)=>{

            sequentialQueries();
        
            function getAdds(){
                return new Promise((resolve, reject)=>{
                    conn.query('SELECT a.Add_id, a.AddSummary_id, b.Brand_name, h.Holder_name, e.Employee_name, a.add_quantity, a.add_time FROM `adds` a, brands b, holders h, employees e where a.Brand_id = b.Brand_id &&  a.Holder_id = h.Holder_id and a.Employee_id = e.Employee_id  ORDER BY a.Add_id DESC; ',(err, result)=>{
                        if(err){
                            return reject(err);
                        }
                        return resolve(result);
                    });
                });
            };
    
        
            
            async function sequentialQueries () {
                try{
                var adds = await getAdds();
        
                fs.readFile(__dirname + '/views/report page/addHistory.html', 'utf8', (err, text) => {
                    app.set('views',__dirname + '/views/report page/');
                    res.render('addHistory',{adds: adds});
                    //res.json(inks);
                });
        
                } catch(error){
                console.log(error)
                }
            }
        
            });