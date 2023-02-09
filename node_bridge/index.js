// importing firmata for arduino connection
const Firmata = require("firmata");

// importing osc for passing info to sonic pi
const Osc = require("osc");

// initialize reference to arduino board
const board = new Firmata("/dev/cu.usbmodem101");
 
 // initialization of osc protocol
 const udpPort = new Osc.UDPPort({
	 localAddress: "0.0.0.0",
	 localPort: 57121,
	 metadata: true
 });
 
 // opening port post initialization
 udpPort.open();
 
 // after port has been opened
 udpPort.on("ready", function () {
	 
	 // report that port has been opened
	 console.log("port opened")
	 
	 // connect to board
	 board.on("ready", () => {
		 
	     // Arduino is ready to communicate
	     console.log("connected to board");
	   
	     // activate 4th pin as digital input for touchpad
	     board.pinMode(4, board.MODES.INPUT);
	   
	     //receive input from fourth pin and store
	     board.digitalRead(4, function (readResult) {
		   
		   // checking if input is true(1)
		   if(readResult) {
			 // console log for testing
			 console.log(`${readResult}`);
			 // send osc message
			 udpPort.send({
				  address: "/test_message",
				  args: []
			  }, "127.0.0.1", 4560);
			  
			  console.log("sent message");
		   }
	   });
	});
  });