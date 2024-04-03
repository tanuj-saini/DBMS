const mongoose = require("mongoose");
const { chatDetailsSchema } = require("./chatDetails");

const userSchema = mongoose.Schema({
  name: {
    required: true,
    type: String,
  },
  bio: {
    required: true,
    type: String,
  },
  photoUrl: {
    required: true,
    type: String,
  },
  phoneNumber: {
    required: true,
    type: String,
  },
  chat: [
    {
      reciverId: {
        required: true,
        type: String,
      },
      chatDetails: [chatDetailsSchema],
    },
  ],
});
const User = mongoose.model("User", userSchema);
module.exports = { User, userSchema };
