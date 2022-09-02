const mongoose =require('mongoose');
const playerSchema = require('./player');
const roomSchema=new mongoose.Schema({
    occupancy:{
        //is how long is the room
        type:Number,
        default:2,
        maxRounds:{
            type:Number,
            default:6,
        },
        currentRound:{
            required:true,
            type:Number,
            default:1,
        },
        players:[
//consist of players nickname and Id
playerSchema
        ],
        isJoin:{
            type:Boolean,
            default:true,
        },
        turn:{
            playerSchema,
            turnIndex:{//turn index keep track of user turn
                type:Number,
                default:0,
            }
        }
    }
});
//convert this to module
const gameModel=mongoose.model('Room',roomSchema);
module.exports=roomModel;