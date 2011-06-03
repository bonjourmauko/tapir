var premaster_body = ""
var premaster_chunks = []
var premaster_packets = []
var premaster_timestamp = "" // to check that all the packets are from this submit
var premaster_chunks_size = 50000 // characters

var premaster_packets_to_send = []
var premaster_packets_in_process = []
var premaster_packets_sent = []



function SetPremasterBody()
{
  premaster_body = $.trim($('#book_contents').html())
}

function PremasterChunkify(size)
{
  number_of_chunks = Math.ceil(premaster_body.length/size)
  start_position = 0
  premaster_chunks = []
  
  for(i=0;i<number_of_chunks;i++)
  {
    premaster_chunks.push(premaster_body.substr(start_position, size))
    start_position = start_position + size
  }
  return premaster_chunks.length;
}

function SetPacketTimeStamp()
{
  premaster_timestamp = Date().toString();
  return premaster_timestamp;
}

function PremasterPackets()
{
  number_of_chunks = premaster_chunks.length
  premaster_packets = []
  
  for(i=0;i<number_of_chunks;i++)
  {
    packet = 
    {
      'premaster_id': premaster_id,
      'position': i,
      'length': premaster_chunks[i].length,
      'timestamp': premaster_timestamp,
      'chunk': premaster_chunks[i],
      }
    premaster_packets.push(packet) 
  }
  return premaster_packets.length;
}

function PopulatePacketsToSend()
{
  for(i=0;i<premaster_packets.length;i++)
  {
    premaster_packets_to_send.push(i)
  }
}


function UploadPacket()
{
  url = "/premaster_packets"
  method = 'POST'
  data_type = 'text'
  
  var packet_index = premaster_packets_to_send.splice(0,1)[0]
  premaster_packets_in_process.push(packet_index)  
  var packet = premaster_packets[packet_index]
  
  console.log("starting the POST of packet " + packet.position)
  
  $.ajax({
    type: method,
    url: url,
    data: packet,
    success: function(){
      console.log("packet "+packet.position+" received OK")
      index = $.inArray(packet_index, premaster_packets_in_process)
      premaster_packets_sent.push(premaster_packets_in_process.splice(index,1)[0])
      return true;
    },
    error: function(){
      console.log("packet "+packet.position+" error")
      index = $.inArray(packet_index, premaster_packets_in_process)
      premaster_packets_to_send.push(premaster_packets_in_process.splice(index,1)[0])
      return false;
    },
    dataType: data_type
  });  
}

function UploadAllPackets()
{
  times = premaster_packets_to_send.length
  for(i=0; i < times; i++)
  {
    UploadPacket()
  }
}

function AllPacketsAreUploaded()
{
  url = "/premasters/build"
  method = 'POST'
  data_type = 'text'
  
  console.log("starting the POST of premaster")
  
  data = {'premaster_id':premaster_id, 'number_of_packets':premaster_packets.length, 'timestamp':premaster_timestamp}
  
  $.ajax({
    type: method,
    url: url,
    data: data,
    success: function(){
      console.log("All packets are received ok and the premaster has been posted")
      $('#bookhtml').remove()
      return true;
    },
    error: function(){
      console.log("There was an error in the transmission, will use form post instead")
      return false;
    },
    dataType: data_type
  });  
  
}



function DoSave()
{
  SetPremasterBody();
  PremasterChunkify(premaster_chunks_size);
  SetPacketTimeStamp();
  PremasterPackets();
  PopulatePacketsToSend()  
  
  function TimedIteration()
   {
      check_every = 2000; //miliseconds
      if (premaster_packets_to_send.length + premaster_packets_in_process.length > 0) {
          setTimeout(TimedIteration, check_every);
          UploadAllPackets();
          return;
      }
      AllPacketsAreUploaded()
  }
  
  UploadAllPackets()
  TimedIteration()
  
}