const fs = require('fs').promises;

exports.getChuDe = async (req, res, next) => {
    try {
        
        const chuDeData = await fs.readFile('./phapdien_data/danhMuc/chuDe.json', 'utf8');
        const chuDe = JSON.parse(chuDeData);
        res.status(200).json({
            status: true,
            data: chuDe,
            message: "Recive ChuDe successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}

exports.getDeMuc = async (req, res, next) => {
    try {
        const { chuDeValue } = req.body;
        const deMucData = await fs.readFile('./phapdien_data/danhMuc/deMuc.json', 'utf8');
        const parsedData = JSON.parse(deMucData);
        const deMuc = parsedData.filter(item => item.ChuDe === chuDeValue);
        res.status(200).json({
            status: true,
            data: deMuc,
            message: "Recive DeMuc successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}

exports.getChuong = async (req, res, next) => {
    try {
        const { deMucValue } = req.body;
        const allTreeData = await fs.readFile('./phapdien_data/danhMuc/allTree.json', 'utf8');
        const parsedData = JSON.parse(allTreeData);
        const cacChuong = parsedData.filter(item => item.DeMucID === deMucValue && item.MAPC.length==20);
        res.status(200).json({
            status: true,
            data: cacChuong,
            message: "Recive CacChuong successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}

exports.getDieu = async (req, res, next) => {
    try {
        const { chuongValue } = req.body;
        const allTreeData = await fs.readFile('./phapdien_data/danhMuc/allTree.json', 'utf8');
        const parsedData = JSON.parse(allTreeData);
        const cacChuong = parsedData.filter(item => item.MAPC.substring(0, 20) === chuongValue && item.MAPC.length > 20 && item.TEN.substring(0, 4) =="Điều");
        res.status(200).json({
            status: true,
            data: cacChuong,
            message: "Recive CacChuong successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}

exports.getAllDieu = async (req, res, next) => {
    try {
        const allTreeData = await fs.readFile('./phapdien_data/danhMuc/allTree.json', 'utf8');
        const parsedData = JSON.parse(allTreeData);
        const cacChuong = parsedData.filter(item => item.MAPC.length > 20 && item.TEN.substring(0, 4) =="Điều");
        res.status(200).json({
            status: true,
            data: cacChuong,
            message: "Recive CacChuong successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}

exports.getChiTiet = async (req, res, next) => {
    try {
        const { DeMucID, MAPC } = req.body;
        const chiTietData = await fs.readFile(`./phapdien_data/crawdata/${DeMucID}.json`, 'utf8');
        const parsedData = JSON.parse(chiTietData);
        const cacChuong = parsedData.filter(item => item.id === MAPC);
        res.status(200).json({
            status: true,
            data: cacChuong,
            message: "Recive CacChuong successfully"
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({
            status: false,
            message: "Internal Server Error"
        });
    }
}