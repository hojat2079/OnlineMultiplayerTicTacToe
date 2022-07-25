//import module
require('dotenv').config();
// require('express-async-errors');
const express = require('express');
const http = require('http');

const app = express();
const port = process.env.PORT || 3000;
const server = http.createServer(app);
const io = require('socket.io')(server);

//conntect to db
const connectDb = require('./db/mongoose');

//middlewere
app.use(express.json());

//model
const Room = require('./model/room')


io.on("connection", (socket) => {
    console.log('connect socket');

    //create a room
    socket.on('createRoom', async ({ nickname }) => {
        console.log(nickname);
        try {
            let room = new Room();
            let player = {
                socketID: socket.id,
                nickName: nickname,
                playerType: 'x'
            };
            room.players.push(player);
            room.turn = player;
            room = await room.save();
            const roomId = room._id.toString();

            console.log(room);

            socket.join(roomId);

            io.to(roomId).emit('createRoomSuccess', room);

        } catch (ex) {
            Console.log(ex);
        }

    });

    //join room
    socket.on('joinRoom', async ({ nickname, roomId }) => {
        console.log(`nickname : ${nickname} , roomId : ${roomId}`);
        try {
            if (!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccurred', 'Please enter a valid room ID.')
                return;
            }
            let room = await Room.findById(roomId);
            if (room.isJoin) {
                let player = {
                    socketID: socket.id,
                    nickName: nickname,
                    playerType: 'o'
                };
                room.players.push(player);
                room.isJoin = false;
                room = await room.save();

                socket.join(roomId);

                console.log(room);

                io.to(roomId).emit('joinRoomSuccess', room);
                io.to(roomId).emit('updatePlayers', room.players);
                io.to(roomId).emit('updateRoom', room);

            } else {
                socket.emit('errorOccurred', 'The game is in progress, try again later.')
            }
        } catch (ex) {
            console.log(ex);
        }
    });

    //tap grid
    socket.on('tap', async ({ index, roomId }) => {
        try {
            let room = await Room.findById(roomId);
            let choice = room.turn.playerType;

            if (room.turnIndex == 0) {
                room.turnIndex = 1;
                room.turn = room.players[1];
            } else {
                room.turnIndex = 0;
                room.turn = room.players[0];
            }
            room = await room.save();

            io.to(roomId).emit('tapped', { index, room, choice })
        } catch (ex) {
            console.log(ex);
        }
    });

    //winner round
    socket.on('winner', async ({ roomId, socketID }) => {
        try {
            let room = await Room.findById(roomId);
            let player = room.players.find((p) => p.socketID == socketID);
            player.points += 1;
            room.round += 1;
            room = await room.save();

            if (room.maxRound <= player.points) {
                io.to(roomId).emit('endGame', player);
            } else {
                io.to(roomId).emit('increasePointPlayer', player);
            }
        } catch (ex) {
            console.log(ex);
        }
    });

});

const start = async () => {
    try {
        await connectDb(process.env.MONGO_URI);
        server.listen(port, () =>
            console.log(`Server is listening on port ${port}...`)
        );
    } catch (error) {
        console.log(error);
    }
};

start();
