const express = require("express");
const { User } = require("../models/user");
const jwt = require("jsonwebtoken");
const auth = require("../middleware/auth");

const authRouter = express.Router();
authRouter.post("/api/signIn", async (req, res) => {
  try {
    const { name, bio, photoUrl, phoneNumber } = req.body;

    let user = new User({
      name,
      bio,
      phoneNumber,
      photoUrl,
    });
    user = await user.save();
    const token = jwt.sign({ id: user._id }, "passwordKey");
    res.json({ token, ...user._doc });
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.post("/tokenIsValid", async (req, res) => {
  try {
    const token = req.header("x-auth-token-w");
    if (!token) {
      return res.json(false);
    }
    const verified = jwt.verify(token, "passwordKey");
    if (!verified) {
      return res.json(false);
    }
    const user = await User.findById(verified.id);
    if (!user) {
      return res.json(false);
    }
    res.json(true);
  } catch (e) {
    res.status(500).json({ error: e.message });
  }
});

authRouter.get("/", auth, async (req, res) => {
  const user = await User.findById(req.user); //by using auth middleware
  res.json({ ...user._doc, token: req.token });
});

module.exports = authRouter;
