const { getPineconeClient } = require("./pinecone_client");
const axios = require('axios');
require("dotenv").config();
const fs = require('fs');
  
// Configure OpenAI
const openaiConfig = {
    apiKey: process.env.OPENAI_API_KEY,
    model: 'text-embedding-ada-002'
};


    // Function to get embeddings from OpenAI
async function getOpenAIEmbedding(queryText) {
    try {
    const pineconeClient = await getPineconeClient();
    const index = pineconeClient.index(process.env.PINECONE_INDEX_NAME);
        
    const response = await axios.post('https://api.openai.com/v1/embeddings', {
        model: openaiConfig.model,
        input: queryText
    }, {
        headers: {
        'Authorization': `Bearer ${openaiConfig.apiKey}`,
        'Content-Type': 'application/json'
        }
    });

    const embedding =  response.data.data[0].embedding;

    const results = await index.query({
        vector: embedding,
        topK: 1,
        includeMetadata: true,
    });
    const convertedData = results.matches.map(item => {
        return {
          source: item.metadata.source,
          text: item.metadata.text
        };
      });
      var context="";
        convertedData.map(item => {
            const contentArray = fs.readFileSync(item.source, 'utf8');
            const parsedData = JSON.parse(contentArray);
            const deMuc = parsedData.filter(i => i.content.includes(item.text) || i.title.includes(item.text));
            deMuc.map(item => {
                context += `${item.title}:\n${item.content}\n\n`;
            })
        });
      
      return context;
    }catch (error) {
        console.error('Error querying Pinecone:', error);
    }
}

module.exports = {getOpenAIEmbedding}