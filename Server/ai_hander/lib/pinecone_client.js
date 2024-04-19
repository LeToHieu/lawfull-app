require("dotenv").config();
const { Pinecone} = require("@pinecone-database/pinecone");

let pineconeClientInstance = null;

// Create pineconeIndex if it doesn't exist

function delay(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

async function createIndex(client, indexName) {
  try {
    await client.createIndex({
        name: indexName,
        dimension: 1536,
        metric: "cosine",
        spec: { 
          serverless: { 
            cloud: 'aws', 
            region:  process.env.PINECONE_ENVIRONMENT
          } 
      }
  });
    
    console.log(
      `Waiting for ${process.env.INDEX_INIT_TIMEOUT} seconds for index initialization to complete...`
    );
    await delay(process.env.INDEX_INIT_TIMEOUT);
    console.log("Index created !!");
  } catch (error) {
    console.error("error ", error);
    throw new Error("Index creation failed");
  }
}

// Initialize index and ready to be accessed.
async function initPineconeClient() {
  try {
    const pineconeClient = new Pinecone({ apiKey: process.env.PINECONE_API_KEY });
    
    const indexName = process.env.PINECONE_INDEX_NAME;

    const existingIndexes = await pineconeClient.listIndexes();
    const exist = existingIndexes.indexes.every(index => index.name === 'lawfull');
    if (!exist) {
      createIndex(pineconeClient, indexName);
    } else {
      
      console.log("Your index already exists. nice !!");
    }

    return pineconeClient;
  } catch (error) {
    console.error("error", error);
    throw new Error("Failed to initialize Pinecone Client");
  }
}

async function getPineconeClient() {
  if (!pineconeClientInstance) {
    pineconeClientInstance = await initPineconeClient();
  }

  return pineconeClientInstance;
}
module.exports = {getPineconeClient}