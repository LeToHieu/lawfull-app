require("dotenv").config();
const { OpenAIEmbeddings } = require('@langchain/openai');
const { PineconeStore } = require('@langchain/pinecone');

async function embedAndStoreDocs(client,docs) {
  /*create and store the embeddings in the vectorStore*/
  try {
    const embeddings = new OpenAIEmbeddings();
    const index = client.Index(process.env.PINECONE_INDEX_NAME);

    //embed the PDF documents
    await PineconeStore.fromDocuments(docs, embeddings, {
      pineconeIndex: index,
      textKey: 'text',
    });
  } catch (error) {
    console.log('error ', error);
    throw new Error('Failed to load your docs !');
  }
}

// Returns vector-store handle to be used a retrievers on langchains
async function getVectorStore(client) {
  try {
    const embeddings = new OpenAIEmbeddings();
    const index = client.Index(process.env.PINECONE_INDEX_NAME);

    const vectorStore = await PineconeStore.fromExistingIndex(embeddings, {
      pineconeIndex: index,
      textKey: 'text',
    });

    return vectorStore;
  } catch (error) {
    console.log('error ', error);
    throw new Error('Something went wrong while getting vector store !');
  }
}

module.exports = {
    embedAndStoreDocs,
    getVectorStore
};