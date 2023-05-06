const functions = require("firebase-functions");
const axios = require("axios");

exports.chatGPT = functions.https.onCall(async (data, context) => {
  const prompt = data.prompt;
  const apiKey = "YOUR_CHATGPT_KEY";

  try {
    const response = await axios.post(
        "https://api.openai.com/v1/engines/davinci-codex/completions",
        {
          prompt: prompt,
          max_tokens: 100,
          n: 1,
          stop: null,
          temperature: 1,
        },
        {
          headers: {
            "Content-Type": "application/json",
            "Authorization": `Bearer ${apiKey}`,
          },
        },
    );
    return response.data.choices[0].text;
  } catch (error) {
    console.error("Error calling ChatGPT API:", error);
    throw new functions.https.HttpsError("internal", "ChatGPT API call failed");
  }
});

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
