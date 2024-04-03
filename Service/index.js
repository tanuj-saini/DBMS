const express = require("express");
const mongoose = require("mongoose");
const authRouter = require("./routers/auth");
const chatRouter = require("./routers/chatRouter");
const mongooseUrl =
  "mongodb+srv://tanujsaini97999:tanuj778899@cluster0.q2ibkzf.mongodb.net/?retryWrites=true&w=majority";

const PORT = 3001;

const app = express();
app.use(express.json());

app.use(authRouter);
app.use(chatRouter);

mongoose
  .connect(mongooseUrl)
  .then(() => {
    console.log("Connection Successful in mongoose");
  })
  .catch((e) => {
    console.log(e);
  });

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Connect at ${PORT}`);
});
