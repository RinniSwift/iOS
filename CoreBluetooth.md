# Core Bluetooth Framework


The Core Bluetooth framework allows communication between low energy devices.\
There are two main players in the *Bluetooth Low Energy* (*BLE*) communication: The **central** and the **peripheral**\
A quick explanation of what they are before diving deeper:

- **Central**: Uses information served by peripherals to accomplish a specific task.
- **Peripheral**: Contains the data needed by other devices. Usually would be the ones sending data.

## Peripherals

> Peripherals broadcasts data in a form of advertising packets -- small bundle of data containing useful information.

With BLE devices, advertising is the primary way that peripherals make their precense known. \
An example would be a digital thermostat -- where the advertise packet would be where it provides the current temperature of the room.

Peripherals can contain many *services* which the services can containing multiple *characteristics* or references to other services.

> **Services**: a collection of data or associated behaviours for accomplishing a function or feature of a device.\
> **Characteristics**: provide further detail about a peripherals service.


## Central

> The central listens in on advertising information that it's interested in and revcieves and possibly manipulates it.

The main way centrals interact with peripherals are through exploring what data it has to offer.


### Central, Peripherals, and Peripheral Data

Once a peripheral connects with a central, the peripheral will stop advertising itself

`CBCentralManager`\
`CBPeripheral`, `CBPeripheralManager`\
`CBService` and its subclass `CBMutableService` represents a peripherals service. Services can contain a number of characteristics and other references to other services. Each service distinguishes from another using unique number id called `UUID` which is either 16 bit or 128 bit.\
`CBCharacteristic` and its subclass `CBMutableCharacteristic` represents further detail of a peripherals service. The properties of a characteristic determine how the value of the characteristic can be used and how the descriptors can be accessed. Each characteristic distinguishing from another using unique number id called `UUID` which is either 16 bit or 128 bit.

### Setup / What to Consider

1. Conform view controller to `CBCentralManagerDelegate` and `CBPeripheralDelegate` protocols.
2. Instantiate the `CBCentralManager` and `CBPeripheral` class to persist within the app's life cycle.
3. Create the central to scan for, connect to, manage, and collect data from peripherals on the background thread.
4. Check user's Bluetooth state in `centralManagerDidUpdateState` method. `.poweredOn` means users bluetooth is on.
5. Scan for peripherals with `.scanForPeripherals(withServices:)` and declare the `CBUUIDs` of the service interested in connecting. The parameter can be declared `nil` which will listen into all services in range.
6. Check the `didDiscover` method for all services discovered. *Note: after discovering, should stop scanning for peripherals to save battery life.* And the `didConnect` method when a connection is successfully connected with a peripheral.
7. Further to discover characteristics of a service `(didDiscoverCharacteristicsFor service:)` in the peripheral delegate.

> **Resources**:
> - [Working with Core Bluetooth](https://www.appcoda.com/core-bluetooth/), App Coda
> - [An Overview of Core Bluetooth Framework](https://mindbowser.com/core-bluetooth-framework/), Mind Bowser
