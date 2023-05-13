const functions = require("firebase-functions");
const axios = require("axios");
/**
 * Function that communicates with the ChatGPT API to get a response.
 * @param {object} data - The data object containing the user's prompt.
 * @param {object} context - The context object of the cloud function call.
 * @returns {string} - The response from the ChatGPT API.
 */
exports.chatGPT = functions.https.onCall(async (data, context) => {
  const prompt = data.prompt;

  try {
    const message = await callChatGPT(prompt);
    console.log("001 ChatGPT API response message:", message);
    return message.trim();
  } catch (error) {
    console.error("Error calling ChatGPT API:",
        error.response ? error.response.data : error);
    throw new functions.https
        .HttpsError("internal", "ChatGPT API call failed");
  }
});

async function callChatGPT(prompt) {
  try {
    const headers = {
      "Content-Type": "application/json",
      "Authorization": `Bearer ${functions.config().openai.api_key}`,
    };

    // Define body here
    const body = {
      "model": "text-davinci-003",
      "prompt": prompt,
      "max_tokens": 50,
      "temperature": 0,
    };

    const response = await axios.post(
        "https://api.openai.com/v1/completions",
        body,
        {headers},
    );

    console.log("Request payload:", body);

    console.log("Request body:", JSON.stringify({
      prompt: prompt,
      max_tokens: 50,
      n: 1,
      stop: null,
      temperature: 0.7,
    }, null, 2));

    console.log("ChatGPT API response:",
        JSON.stringify(response.data, null, 2));

    const message = response.data.choices[0].text;
    console.log("002 ChatGPT API response message:", message);
    return message.trim();
  } catch (error) {
    console.error("Full error response:", JSON.stringify(
        error.response.data, null, 2));
    console.error("Error calling ChatGPT API:", error);
    throw new functions.https
        .HttpsError("internal", "ChatGPT API call failed");
  }
}

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });
