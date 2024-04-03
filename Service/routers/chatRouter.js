const express = require("express");
const { User } = require("../models/user");
const auth = require("../middleware/auth");
const { ChatDetail } = require("../models/chatDetails");
const chatRouter = express.Router();
chatRouter.get("/api/checkUser", auth, async (req, res) => {
  try {
    const user = await User.find({ phoneNumber: req.query.phoneNumber });
    if (user == null) {
      return res.status(400).json({ msg: "User is not login in This app" });
    }
    res.json(user);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

chatRouter.post("/api/message", auth, async (req, res) => {
  try {
    const { reciverId, message, time } = req.body;
    let chatModule = new ChatDetail({
      reciverId,
      message,
      time,
      itsMe: true,
    });
    let RchatModule = new ChatDetail({
      reciverId,
      message,
      time,
      itsMe: false,
    });

    chatModule = await chatModule.save();
    RchatModule = await RchatModule.save();

    let Cuser = await User.findById(req.user);
    let Ruser = await User.findById(reciverId);

    let Cchat = Cuser.chat.find((chat) => chat.reciverId === reciverId);

    if (Cchat) {
      Cchat.chatDetails.push(chatModule);
    } else {
      Cuser.chat.push({ reciverId, chatDetails: chatModule });
    }

    let Rchat = Ruser.chat.find((chat) => chat.reciverId === req.user);

    if (Rchat) {
      Rchat.chatDetails.push(RchatModule);
    } else {
      Ruser.chat.push({ reciverId: req.user, chatDetails: RchatModule });
    }

    Cuser = await Cuser.save();
    Ruser = await Ruser.save();

    res.json(Cuser);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});
chatRouter.get("/api/listChat", auth, async (req, res) => {
  try {
    const Ruser = await User.find({ phoneNumber: req.query.phoneNumber });
    if (!Ruser.length) {
      return res.status(400).json({ msg: "User not found" });
    }
    const Cuser = await User.findById(req.user);
    const Cchats = Cuser.chat.filter(
      (chat) => chat.reciverId === String(Ruser[0]._id)
    );

    res.json(Cchats);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});



module.exports = chatRouter;
