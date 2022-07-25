const mongoose = require('mongoose');
const playerSchema = require('./player')
const roomSchema = new mongoose.Schema({
    occupancy: {
        type: Number,
        default: 2
    },
    maxRound: {
        type: Number,
        default: 6
    },
    round: {
        type: Number,
        default: 1,
        required: [true, 'please provide round'],
    },
    players: [playerSchema],
    isJoin: {
        type: Boolean,
        default: 1
    },
    turn: playerSchema,
    turnIndex: {
        type: Number,
        default: 0
    }
});


module.exports = mongoose.model('Room',roomSchema);