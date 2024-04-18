const cheerio = require('cheerio');
const fs = require('fs').promises;

const directoryPath = './phapdien_data/crawdata';

// Create the directory if it doesn't exist
fs.access(directoryPath).catch(() => {
    // If it doesn't exist, create it
    fs.mkdir(directoryPath, { recursive: true })
});


async function main() {
    try {

        // Read danhMuc file
        const danhMucData = await fs.readFile('./phapdien_data/danhMuc/deMuc.json', 'utf8');
        const danhMuc = JSON.parse(danhMucData);

        danhMuc.forEach(async item => {
            const cacChuongId = item.Value;
            // Đọc file HTML
            const htmlContent = await fs.readFile(`BoPhapDienDienTu/demuc/${cacChuongId}.html`, 'utf-8');

            // Parse HTML
            const $ = cheerio.load(htmlContent);

            const result = [];
            try  {
                $('.pDieu').each((index, el) =>  {
                    // Find the <a> element within the current <p> element and get its 'name' attribute
                    const deMucId = $(el).find('a').attr('name');
                    const deMucText = $(el).text().replace(/[\n\t]+/g, ' ').trim();

                    //ghi chu

                    const ghiChu = $(el).next('.pGhiChu').text().trim();
                    const ghiChuUrl = $(el).next('.pGhiChu').find('a').attr('href');

                    const noiDungArray = $(el).next('.pGhiChu').next('p').nextUntil('p.pDieu, p.pChuong').filter('p').map((i, el) => $(el).text().replace(/[\n\t]+/g, ' ').trim()).get();
                    const content = noiDungArray.join('\n');

                    result.push({ "id": deMucId, "title": deMucText, "ghi_chu": ghiChu, "ghi_chu_url": ghiChuUrl, "content": content, "chuong_id": deMucId.substring(0, 20) });
                });

            } catch {
                console.error('An error occurred:', cacChuongId);
            }

            // Write the final result to a file
            await fs.writeFile(`phapdien_data/crawdata/${cacChuongId}.json`, JSON.stringify(result));
            console.log('File saved successfully.');

            // Print the final result
            // console.log(danhMucData);

        });

    } catch (error) {
        console.error('An error occurred:', error);
    }
}

// Call the main function
main();