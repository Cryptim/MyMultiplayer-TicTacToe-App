//importing modules
const express=require("express");
const http=require('http');
const app=express();
// const port=3000;
const port=process.env.port||3000;
var server=http.createServer(app);
const Room=require('./model/room.js');
var io=require("socket.io");
//client->middleware->server
//middleware
app.use(express.json());
const DB="mongodb+srv://timothy:<timo08101264323>@cluster0.wbfbxbd.mongodb.net/?retryWrites=true&w=majority";
io.on('connection',(socket)=>{
    console.log("connected!");
    socket.on('createRoom',({nickname})=>{
console.log(nickname);
try{
    let room=new Room();
    let player={
       socketID:socket.id,
       nickname,
       playerType:'x',
    };
    room.players.push(player);
    room.turn=player;
   //player is stored in the room
   await room.save();//save in mongoDB
   //_id
   const roomId=room._id.toString();
   socket.join(roomId);
   //tell our client that room has been created
   //go to the next page
   //io->send data to everyone
   //socket->send data to yourself
   io.to(roomId).emit("createRoomSuccess",room);
      
}catch(e){
    console.log(e);
}
console.log(socket.id);
 //room is created
 
    });
    socket.on('tap',async({index,roomId})=>{
      try{
let room=await Room.findById(roomId);
let choice=room.turn.playertype;//x or 0
if(room.turnIndex==0){
room.turnIndex=1;
room.turn=room.players[1];
room.turnindex=1;
}else{
  room.turn=room.players[0];
  room.turnIndex=0;
}
room=await room.save();
io.to(roomId).emit('tapped',{
index,room,choice,

})
      }catch(e){
console.log(e);
      }
    });
    socket.on('winner',async({winnerScoketId,roomId})=>{
      try{
        let room=await Room.findById(roomId);
        room.players.find((player)=>player.socketID==winnerScoketId);
        player.points+=1;
        room=await room.save();
        if(player.points>=room.maxRounds){
          io.to(roomId).emit('endGame',player);
        }else{
          io.to(roomId).emit("pointIncrease",player);
        }
      }catch(e){
       console.log(e) 
      }
    })
});
mongoose.connect(DB).then(()=>{
    console.log("connection succesful");
}).catch((e)=>{
    console.log(e);
})
//promise in JS-Future in dart
server.listen(port,'0.0.0.0',()=>{
console.log(`Server started and running on port ${port}`);
socket.on('joinRoom',async({nickname,roomId}))
try{
  if(!roomId.match(/^[0-9a-fA-F]{24}$/)) {
socket.emit('errorOccurred','Please enter a valid room ID.');
return;
  } 
  let room=await Room.findById(roomId);
  if(room.isJoin){
let player={
    nickname,
    socketID:socket.id,
    playerType:'o'
}
socket.join(roomId);
room.players.push(player);
room.isJoin=false;
room=await room.save();
io.to(roomId).emit("joinRoomSuccess",room);
io.to(roomId).emit("updatePlayers",room.players);
io.to(roomId).emit("updateRoom",room);
}else{
    socket.emit(
        "errorOccurred",
        "The game is in progress,try again later."
    )
  }
}catch(e){
    console.log(e);
}
});