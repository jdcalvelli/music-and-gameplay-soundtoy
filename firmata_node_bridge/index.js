// importing firmata for arduino connection
const Firmata = require("firmata");

// importing osc for passing info to sonic pi
const Osc = require("osc");

// initialize reference to arduino board
// referencing right side usbc port
const board = new Firmata("/dev/cu.usbmodem2101");

// initialization of osc protocol
const udpPort = new Osc.UDPPort({
  localAddress: "0.0.0.0",
  localPort: 57121,
  metadata: true,
});

// opening port post initialization
udpPort.open();

// after port has been opened
udpPort.on("ready", function () {
  // report that port has been opened
  console.log("port opened");

  // connect to board
  board.on("ready", () => {
    // Arduino is ready to communicate
    console.log("connected to board");

    // activate 2nd pin as digital input for touchpad 4
    board.pinMode(2, board.MODES.INPUT);
    // activate 3rd pin as digital input for touchpad 3
    board.pinMode(3, board.MODES.INPUT);
    // activate 4th pin as digital input for touchpad 2
    board.pinMode(4, board.MODES.INPUT);
    // activate 5th pin as digital input for touchpad 1
    board.pinMode(5, board.MODES.INPUT);
    // activate 13th pin as pullup input for seq button
    board.pinMode(13, board.MODES.PULLUP);
    // activate 1th pin as digital input for touch sensor
    board.pinMode(10, board.MODES.INPUT);

    // TOUCHPAD 1
    //receive input from 5th pin and pass on
    board.digitalRead(5, function (readResult) {
      // checking if input is true(1)
      if (readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/touchpad/1",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("sent /touchpad/1");
      }
    });

    // TOUCHPAD 2
    // receive input from 4th pin and pass on
    board.digitalRead(4, function (readResult) {
      // checking if input is true(1)
      if (readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/touchpad/2",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("sent /touchpad/2");
      }
    });

    // TOUCHPAD 3
    // receive input from 3rd pin and pass on
    board.digitalRead(3, function (readResult) {
      // checking if input is true(1)
      if (readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/touchpad/3",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("sent /touchpad/3");
      }
    });

    // TOUCHPAD 4
    // receive input from 2nd pin and pass on
    board.digitalRead(2, function (readResult) {
      // checking if input is true(1)
      if (readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/touchpad/4",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("sent /touchpad/4");
      }
    });

    // SEQ BUTTON
    board.digitalRead(13, function (readResult) {
      // if read result is 0 send osc
      if (!readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/button/1",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("sent button press");
      }
    });

    board.digitalRead(10, function (readResult) {
      if (readResult) {
        // send osc message
        udpPort.send(
          {
            address: "/touchcap/1",
            args: [],
          },
          "127.0.0.1",
          4560
        );

        console.log("touch cap sent");
      }
    });
  });
});
