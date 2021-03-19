import QtQuick 2.0
import QtQuick.LocalStorage 2.0 as Sql

Item {
    // Listening to the logic element

    property alias target: logicConnection.target

    // Theme Color used by elements

    property string themeColor: "#BDE1FE"

    // Number of Cabinets, can be changed depending on the physical locker system

    property int numberOfCabinets: 4

    // Exposing the database to other elements

    property alias dbalias :_.db

    // Company logo url

    property string imageUrl: "http://zemtech.co.za/images/logocropped.png"

    // Signals emitted by the model element to the pages

    // This is fired when there is no cabinet to rent

    signal noCabinet()

    // This is fired when all cabinets are vacant

    signal allEmpty()

    // This fires every second to update time

    signal timeUpdate(var a )

    // failed authentication

    signal failedAuth()

    // Timer for displaying time and triggers the timeUpdate signal

    Timer{
        id:timer
     interval: 1000
     running: true
     repeat: true
     onTriggered: timeUpdate(new Date().toTimeString())


    }

    // Set the password for the cabinet that is being rented and open it

    function setCabinetPasswd(cabinet, passwd){

        _.setCabinetPasswd(cabinet,passwd)

    }

    // Open a rented cabinet with a password

    function openCabinet(cabinet,passwd){

    _.openCabinetWithPaswd(cabinet,passwd)

    }

    // Private variable

    Item{

        id:_

        property var db

        //Initialising....

        Component.onCompleted: {

                                     db=Sql.LocalStorage.openDatabaseSync("Cabinet","1.0","This stores the cabinets states",1000000)

                                    db.transaction(
                                                    function(tx){

                                                                    // If the database doesnt exist, create one!
                                                                    tx.executeSql('CREATE TABLE IF NOT EXISTS Cabinet(cabinetNo INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL ,passwd VARCHAR,Occupied BOOLEAN,Charging BOOLEAN)')

                                                                    // Uncomment if you want to delete the table

                                                                    // tx.executeSql('Drop table Cabinet')

                                                                    // Find all records

                                                                    var cabinet = tx.executeSql("select * from Cabinet")

                                                                    // If the rows on the database are less than the numberOfCabinets variable then add more rows

                                                                        if(cabinet.rows.length < numberOfCabinets)
                                                                        {
                                                                                for(var i =1; i<=numberOfCabinets;i++)
                                                                                {

                                                                                 tx.executeSql("insert into Cabinet(passwd,Occupied,Charging) values(\"thami\",0,0)")

                                                                                }}})}



        // Open cabinet without password. Used for debugging

       function openCabinet(cabinet){

            controller.openChannel(cabinet)

        }

       // Open rented cabinet with Password

        function openCabinetWithPaswd(cabinet,passwd){

            db.transaction(

                        function(tx){

                                       var result = tx.executeSql('SELECT * FROM Cabinet WHERE cabinetNo =? AND passwd=?',[cabinet,passwd])

                            // If password doesnt match then fire the wrongPassword signal  else open the cabinet and update state

                            if(typeof result.rows.item(0) === 'undefined')
                                       {
                                            // fire signal if password does not match

                                            logic.wrongPassword()

                                       }

                                       else
                                      {
                                            // Open cabinet
                                           controller.openChannel(cabinet)
                                           controller.chargeCabinetOff(cabinet)
                                            // Navigate back to the home screen
                                           stackView.pop()

                                           stackView.pop()

                                            // Update the state to vacant

                                           tx.executeSql('update Cabinet set Occupied = 0 where cabinetNo=?',cabinet)}
                                     }
                                    )





        }

        // Rent a cabinet and set password

        function setCabinetPasswd(cabinet, passwd){

            //Open database and update password

            db.transaction(
                        function(tx){

                           var result= tx.executeSql('UPDATE Cabinet SET passwd = ? WHERE cabinetNo= ?;',[passwd,cabinet])

                            // Update  password

                            tx.executeSql('UPDATE Cabinet SET Occupied = ? WHERE cabinetNo= ?;',[1,cabinet])

                            // Open cabinet

                            controller.openChannel(cabinet)
                            controller.chargeCabinetOn(cabinet)
                            // Navigate back to the home screen

                            stackView.pop()
                        }

                        )

        }


        // Find an empty cabinet

        function findEmptyCabinet()
        {
                // Variable for storing the empty cabinet if found

                var number

                db.transaction(function(tx){

                    // Check all cabinets for a vacant cabinet

                   var res= tx.executeSql("Select * from Cabinet where Occupied=0 and cabinetNo between 1 and ? ",[numberOfCabinets])

                    // If there are no available cabinets then fire the noCabinetAvailable signal

                    if(res.rows.length === 0)

                        logic.noCabinetAvailable()

                    else
                    {
                        // If there is an empty cabinet, then open that cabinet and signal
                        var emptyCabinet =res.rows.item(0).cabinetNo

                       
                        logic.availableCabinet(emptyCabinet)

                       number = emptyCabinet


                    }})

            return number
        }

        // If all cabinets are empty then there is no need to click the Retrieve button

        function checkIfAllEmpty(){

                             var number

                          db.transaction(function(tx){

                             // check all cabinets
                             var res= tx.executeSql("Select * from Cabinet where Occupied=0 and cabinetNo between 1 and ? ",[numberOfCabinets])

                             // If there are no cabinets that are vacant then fire logic.noCabinetAvailable else fire allCabinetsEmpty

                                  var emptyCabinet =res.rows.length

                                  if(emptyCabinet === numberOfCabinets)

                                     logic.allCabinetsEmpty()
                                  else

                                  {stackView.push(components.retrievePageCmp,{dbResult:getDbResult(),gridModel:numberOfCabinets})}


                              })}}

    // Get the contents of the database and expose to other elements

    function getDbResult()

    {
        var result

        dbalias.transaction(
                    function(tx){

                        result= tx.executeSql('select * from  Cabinet')

                    }

                    )
        return result
    }

    // Listen to all signals that are fired by the logic Component

    Connections{

    id:logicConnection

    onDeposit:{

        // Response to the deposit signal from logic

        var cabinentNumber = _.findEmptyCabinet()

        if(typeof cabinentNumber === "undefined")

        { logic.noCabinetAvailable()}

       else

        stackView.push(components.passwordPageCmp,{emptyCabinet:cabinentNumber,deposit:true})}


    onRetrieve:{_.checkIfAllEmpty()}

    onNoCabinetAvailable:noCabinet()

    onAllCabinetsEmpty:allEmpty()

    onWrongPassword: failedAuth()
    }
}
