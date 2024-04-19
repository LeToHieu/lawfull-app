// const { getChunkedDocsFromPDF } = require("../lib/json_loader");
// const { embedAndStoreDocs } = require("../lib/vector_store");
// const { getPineconeClient } = require("../lib/pinecone_client");
// const fs = require('fs').promises;

// // This operation might fail because indexes likely need
// // more time to init, so give some 5 mins after index
// // creation and try again.
// (async () => {
//   try {
//     const danhMucData = await fs.readFile('./phapdien_data/danhMuc/deMuc.json', 'utf8');
//     const danhMuc = JSON.parse(danhMucData);
//     const pineconeClient = await getPineconeClient();

//     danhMuc.forEach(async item => {
//       const myJsonFilePath = `./phapdien_data/crawdata/${item.Value}.json`;
//       console.log("Preparing chunks from Json file");
//       const docs = await getChunkedDocsFromPDF(myJsonFilePath);
//       console.log(`Loading ${docs.length} chunks into pinecone...`);
//       await embedAndStoreDocs(pineconeClient, docs);
//       console.log("Data embedded and stored in pine-cone index");
//     });

//   } catch (error) {
//     console.error("Init client script failed ", error);
//   }
// })();

const { getChunkedDocsFromPDF } = require("../lib/json_loader");
const { embedAndStoreDocs } = require("../lib/vector_store");
const { getPineconeClient } = require("../lib/pinecone_client");
const fs = require('fs').promises;

async function retryEmbedding(pineconeClient, docs) {
  try {
    await embedAndStoreDocs(pineconeClient, docs);
    console.log("Data embedded and stored in pine-cone index");
  } catch (error) {
    console.error("Embedding and storing data failed ", error);
    // Retry after 30 seconds
    await new Promise(resolve => setTimeout(resolve, 30000));
    await retryEmbedding(pineconeClient, docs);
  }
}

(async () => {
  try {
    const danhMucData = await fs.readFile('./phapdien_data/danhMuc/deMuc.json', 'utf8');
    const danhMuc = JSON.parse(danhMucData);
    const pineconeClient = await getPineconeClient();

    for (const item of danhMuc) {
      const myJsonFilePath = `./phapdien_data/crawdata/${item.Value}.json`;
      console.log("Preparing chunks from Json file");
      const docs = await getChunkedDocsFromPDF(myJsonFilePath);
      console.log(`Loading ${docs.length} chunks into pinecone...`);
      await retryEmbedding(pineconeClient, docs);
    }

  } catch (error) {
    console.error("Init client script failed ", error);
  }
})();
