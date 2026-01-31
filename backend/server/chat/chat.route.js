const express = require("express");
const route = express.Router();
const checkAccessWithSecretKey = require("../../util/checkAccess");
const ChatController = require("./chat.controller");

route.post("/send", checkAccessWithSecretKey(), ChatController.sendMessage);
route.get("/conversations", checkAccessWithSecretKey(), ChatController.getConversations);
route.get("/messages", checkAccessWithSecretKey(), ChatController.getMessages);

module.exports = route;
