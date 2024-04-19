const { OpenAI } = require('openai');
require("dotenv").config();
const fs = require('fs').promises;
const { getOpenAIEmbedding } = require('./embeding_text_and_get_result')



async function textRender(question) {
  try {
    // var context = await getOpenAIEmbedding(question);
    var context = "";
    const client = new OpenAI({ apiKey: process.env.OPENAI_API_KEY });
    // console.log(context);
    const res = await client.chat.completions.create({

      model: 'gpt-3.5-turbo',
      messages: [
      //   {
      //   role: "system",
      //   content: `Bạn là một trợ lý tìm kiếm thông tin trong văn bản được cung cấp. 
      //         Tìm thông tin trong văn bản được cung cấp để trả lời câu hỏi. 
      //         Chỉ dùng thông tin được cung cấp trong Tài liệu.
      //         Đưa ra mô tả trong tài liệu một cách chính xác.
      //         `,
      // },
      {
       role: "system",
        content: `Dựa vào luật pháp Việt nam mà bạn có hãy trả lời các câu hỏi của người dùng. Nếu câu hỏi không liên quan dến pháp luật thì đừng trả lời!
                  Sau đó đưa ra chi tiết các điều khoản liên quan đến điều đấy!`,
      },
      {
        role: "user",
        content: `Câu hỏi: ${question}`,
      },
      // {
      //   role: "assistant",
      //   content: `Tài liệu:\n${context}`,
      // },
      ],
      temperature: 0.7
    });

    const relatedQuests = await client.chat.completions.create({
      model: 'gpt-3.5-turbo',
      messages: [{
        role: "system",
        content: `
              Bạn là một trợ lý có ích.
              Sinh các câu hỏi liên quan đến câu hỏi của người dùng.
              Trả về câu trả lời dưới dạng một danh sách ngăn cách bởi dấu '|'.
              Ví dụ:

              Q: Bạo lực gia đình là gì?
              A:
              Các hành vi bạo lực gia đình? | Đối tượng bị bạo lực gia đình?

              Q: Cộng tác viên dịch thuật là những ai?
              A:
              Phê duyệt danh sách cộng tác viên dịch thuật? | Cộng tác viên dịch thuật? | Tiêu chuẩn, điều kiện của người dịch?
              `},
      {
        role: "assistant",
        content: `Các câu hỏi liên quan đến câu hỏi sau là gì?: ${question}`
      },
      ],
      temperature: 0.7
    });

    // console.log(relatedQuests.choices[0].message.content);
    const suggestionQuestions = relatedQuests.choices[0].message.content
      .toString().replace(/^A:\s*/, '')
      .split("|")
      .map(e => e.trim());

    const answer = res.choices[0].message.content.toString();
    const response = {
      question: question,
      answer: answer,
      sources: context,
      suggestionQuestions: suggestionQuestions
    };
    return response;
  } catch (error) {
    console.error(error);
  }
}

module.exports = { textRender }