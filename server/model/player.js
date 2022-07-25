const mongoose = require('mongoose')

const playerSchema = new mongoose.Schema({
    nickName: {
        type: String,
        required: [true, 'please provide nickname'],
        trim: true
    },
    socketID: {
        type: String,
    },
    points: {
        type: Number,
        default: 0
    },
    playerType: {
        required :[true, 'please provide type'],
        type: String,
        enum: ['x', 'o']
    }
});

module.exports = playerSchema