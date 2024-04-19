
const {JSONLoader } = require("langchain/document_loaders/fs/json");
const {RecursiveCharacterTextSplitter} = require("langchain/text_splitter");

// const mongoose = require('mongoose');

// const JSONLoader = require("langchain/document_loaders/fs/json")
    


exports.getChunkedDocsFromPDF = async (filePath) => {
    try {
      const loader = new JSONLoader(
        filePath,
        ["/title", "/content"]
      );
      const docs = await loader.load();
      // console.log(docs+"\n\n\n");
      // From the docs https://www.pinecone.io/learn/chunking-strategies/
      const textSplitter = new RecursiveCharacterTextSplitter({
        chunkSize: 1000,
        chunkOverlap: 200,
      });

      
  
      const chunkedDocs = await textSplitter.splitDocuments(docs);
    
      return chunkedDocs;
    } catch (e) {
      console.error(e);
      throw new Error("Json docs chunking failed !");
    }
  }

