pragma solidity ^0.6.6;

contract Rideshare {
  // Struct to represent a ride
  struct Ride {
    address payable rider;
    address payable driver;
    uint256 price;
    uint256 distance;
    uint256 cashBack;
    bool isCompleted;
  }
   // 0xc44dbA718034D32383BD3020a1709185Ca5Dde90 (emre)
  constructor() public payable{
    require(msg.value >= .0001 ether);
  }
  
  // Mapping from ride IDs to ride structs
  mapping(uint => Ride) public rides;

  uint public rideId;
  // Event for when a new ride is created
  event NewRide(uint256 rideId);

  // Function to request a ride
 // function requestRide(address driver, uint256 price, uint256 distance) public {
//    uint rideId = rides.length++;
 //   rides[rideId] = Ride(msg.sender, driver, price, distance);
 //   emit NewRide(rideId);
//  }

function requestRide(address payable driver, uint256 distance) public payable {
  // Generate a unique ride ID
  require(msg.value >= distance * .001 ether);
  rideId++;
 // uint256 rideId = uint256(keccak256(abi.encodePacked(msg.sender, driver, msg.value, distance, msg.value - (distance * .001 ether), now)));
  rides[rideId] = Ride(msg.sender, driver, msg.value, distance, msg.value - (distance * .001 ether), false);
  emit NewRide(rideId);
}

    //sürücünün  kısmı başladı
  // Function to accept a ride
  function acceptRide(uint rideId) public {
    // Ensure that the ride exists and the driver is the one accepting it
    require(rides[rideId].driver == msg.sender, "Only the driver can accept the ride.");
    //cashBack = msg.value - (distance * .001 ether);
    rides[rideId].rider.transfer(rides[rideId].cashBack);  // iş kabul edildiğinde ödenen miktarın para üstünü gönder -> kullanıcıya

    //msg.value(10 lira) - cashback'den geri kalan miktar(5 lira) kullanıcının içeride kalan parası (yolun parası), 
      //bunu zaten cashback(üstte ödenen 5 lira) kullanıcıya ödendiği için price olarak atamamız gerekiyor.(yani içeride sadece kullanıcının yol için harcayacağı para kalacak)
    rides[rideId].price = ( rides[rideId].price - rides[rideId].cashBack);


     // şoför kabul ettiği gibi para cebinde

    // Update the ride status to "accepted"
    rides[rideId].driver = address(0); //işlem yapıldıktan sonra bir daha üzerine işlem yapılmasın diye 0 a sabitleniyor.
  }

  // Function to cancel a ride
  function cancelRide(uint rideId) public payable {
    // Ensure that the ride exists


    require(rides[rideId].rider == msg.sender || (rides[rideId].driver == msg.sender) , "Only the rider or driver can cancel the ride.");




    //driverin içeride kalan parası verildi
    rides[rideId].rider.transfer(rides[rideId].price);
    // Delete the ride from the mapping
    delete rides[rideId];

    //parayı usera geri gönderecek
  }

  function rideCompleted(uint rideId) public payable {
    
    require(rides[rideId].rider == msg.sender);
    
    rides[rideId].isCompleted = true;

    rides[rideId].driver.transfer(rides[rideId].price);
  }

}