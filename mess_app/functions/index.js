/* eslint-disable max-len */
/* eslint-disable comma-dangle */
/* eslint-disable object-curly-spacing */
/* eslint-disable indent */
/* eslint-disable eol-last */
const functions = require("firebase-functions");
const admin = require("firebase-admin");
admin.initializeApp();

exports.myFunction = functions.firestore
    .document("chat/{message}")
    .onCreate((snapshot, context) => {
        return admin.messaging().sendToTopic("chat", { notification: { title: snapshot.data().username, body: snapshot.data().text, clickAction: "FLUTTER_NOTIFICATION_CLICK", } });
    });