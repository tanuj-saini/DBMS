const mongoose = require("mongoose");

const chatDetailsSchema = mongoose.Schema({
  reciverId: {
    require: true,
    type: String,
  },
  message: {
    require: true,
    type: String,
  },
  time: {
    require: true,
    type: String,
  },
  itsMe: {
    default: false,
    type: Boolean,
  },
});
const ChatDetail = mongoose.model("chatDetails", chatDetailsSchema);
module.exports = { ChatDetail, chatDetailsSchema };
