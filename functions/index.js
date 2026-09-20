/**
 * MapMoment Cloud Functions — slice 1 (walking skeleton).
 *
 * sendTestPing: callable, sends one push to every registered device in the
 * group. This is the seed of the future daily moment ping — slice 2 replaces
 * the manual trigger with a scheduled evening-window ping (see the stub at
 * the bottom), same fan-out.
 */
const { onCall, HttpsError } = require("firebase-functions/v2/https");
const { setGlobalOptions } = require("firebase-functions/v2");
const admin = require("firebase-admin");

admin.initializeApp();
setGlobalOptions({ maxInstances: 2 });

exports.sendTestPing = onCall(async (request) => {
  if (!request.auth) {
    throw new HttpsError("unauthenticated", "Sign in first.");
  }

  const snapshot = await admin.firestore().collection("users").get();
  const tokens = [
    ...new Set(
      snapshot.docs.map((doc) => doc.get("fcmToken")).filter(Boolean)
    ),
  ];
  if (tokens.length === 0) {
    return { sent: 0, failed: 0, message: "No registered devices yet." };
  }

  const response = await admin.messaging().sendEachForMulticast({
    tokens,
    notification: {
      title: "MapMoment",
      body: "Ping! The map is live — come see where everyone is.",
    },
    apns: {
      payload: { aps: { sound: "default" } },
    },
  });

  // Prune tokens that APNs/FCM reports as dead so the group list stays clean.
  const deadTokens = [];
  response.responses.forEach((res, i) => {
    if (
      res.error &&
      [
        "messaging/registration-token-not-registered",
        "messaging/invalid-registration-token",
      ].includes(res.error.code)
    ) {
      deadTokens.push(tokens[i]);
    }
  });
  if (deadTokens.length > 0) {
    const batch = admin.firestore().batch();
    snapshot.docs
      .filter((doc) => deadTokens.includes(doc.get("fcmToken")))
      .forEach((doc) =>
        batch.update(doc.ref, {
          fcmToken: admin.firestore.FieldValue.delete(),
        })
      );
    await batch.commit();
  }

  return { sent: response.successCount, failed: response.failureCount };
});

/*
 * Slice 2 seed — the daily moment ping (DO NOT enable in slice 1):
 *
 * const { onSchedule } = require("firebase-functions/v2/scheduler");
 * exports.dailyMomentPing = onSchedule(
 *   { schedule: "every day 20:14", timeZone: "America/Los_Angeles" },
 *   async () => { ...same fan-out as sendTestPing, plus a moments/{date} doc... }
 * );
 */
