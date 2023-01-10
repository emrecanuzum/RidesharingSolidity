# Rideshare

This is a smart contract for a Rideshare app. It allows riders to request rides from drivers and drivers to accept rides. It also allows riders to cancel rides and mark rides as completed.

## Features

- Riders can request rides from drivers by calling the `requestRide` function and specifying the driver's address and the distance of the ride. They need to send at least `distance * .001 ether` as the price of the ride.
- Drivers can accept rides by calling the `acceptRide` function and specifying the ride ID. They will receive the cashback amount (`price - distance * .001 ether`) and the price of the ride minus the cashback will be transferred to the rider.
- Riders and drivers can cancel rides by calling the `cancelRide` function and specifying the ride ID. The price that the rider paid for the ride will be returned to the rider.
- Riders can mark rides as completed by calling the `rideCompleted` function and specifying the ride ID. The price of the ride will be transferred to the driver.

## Contract details

- The contract is written in Solidity and targets the `0.6.6` version of the Solidity compiler.
- The contract has a constructor that requires the caller to send at least `.0001 ether` when deploying the contract.
- The contract stores the details of rides in a `Ride` struct, which has the following fields:
  - `rider`: The address of the rider who requested the ride.
  - `driver`: The address of the driver who accepted the ride.
  - `price`: The price that the rider paid for the ride.
  - `distance`: The distance of the ride.
  - `cashBack`: The amount of money that the rider gets back as a cashback for taking the ride.
  - `isCompleted`: A boolean value indicating whether the ride has been completed or not.
- The contract uses a mapping from ride IDs to `Ride` structs to store the rides. The ride ID is a unique uint256 value that is incremented by 1 for each new ride.
- The contract has an `NewRide` event that is emitted whenever a new ride is requested.

## Requirements

- A Web3 provider, such as Metamask or to interact with the contract through a web browser.
- A way to deploy the contract, such a Remix online ide.

## Usage

1. Deploy the contract to the Ethereum network.
2. Request a ride by calling the `requestRide` function and specifying the driver's address and the distance of the ride. Make sure to send at least `distance * .001 ether` as the price of the ride.
3. The driver can accept the ride by calling the `acceptRide` function and specifying the ride ID.
4. The rider can cancel the ride by calling the `cancelRide` function and specifying the ride ID.
5. The rider can mark the ride as completed by calling the `rideCompleted` function and specifying the ride ID.


## Code Explanation
 
rider: The address of the rider who requested the ride.
driver: The address of the driver who accepted the ride.
price: The price that the rider paid for the ride.
distance: The distance of the ride.
cashBack: The amount of money that the rider gets back as a cashback for taking the ride.
isCompleted: A boolean value indicating whether the ride has been completed or not.
The rides mapping stores the rides that have been requested and accepted by drivers. The key is a unique ride ID, and the value is a Ride struct.

The rideId variable stores the current ride ID. When a new ride is requested, it is incremented by 1.

The NewRide event is emitted whenever a new ride is requested.

The requestRide function is called by a rider to request a ride from a specific driver. It takes the driver's address and the distance of the ride as arguments. It requires that the caller (the rider) has sent at least distance * .001 ether as the price of the ride. It creates a new Ride struct and stores it in the rides mapping.

The acceptRide function is called by a driver to accept a ride. It takes the ride ID as an argument and requires that the caller (the driver) is the one assigned to the ride. It transfers the cashback amount to the rider and updates the ride status to "accepted".

The cancelRide function is called by either the rider or the driver to cancel a ride. It takes the ride ID as an argument and requires that the caller is either the rider or the driver assigned to the ride. It transfers the price that the rider paid for the ride back to the rider and deletes the ride from the rides mapping.

The rideCompleted function is called by the rider to mark a ride as completed. It takes the ride ID as an argument and requires that the caller is the rider assigned to the ride. It sets the isCompleted field of the Ride struct to true and transfers the price of the ride to the driver.
